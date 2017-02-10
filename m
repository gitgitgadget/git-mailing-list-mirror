Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C896E1FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 19:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753550AbdBJTCK (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 14:02:10 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:34301 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753118AbdBJTCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 14:02:09 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id cGSNcdcPD46SJcGSNcwENV; Fri, 10 Feb 2017 19:02:08 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=CItoZljD c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=NEAV23lmAAAA:8
 a=KjtaWa6mrfalS3hOZiAA:9 a=wPNLvfGTeEIA:10 a=Bn2pgwyD2vrAyMmN8A2t:22
Message-ID: <93E7A279BF61414D9EE8BB12B88E16E8@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     "Ashutosh Bapat" <ashutosh.bapat@enterprisedb.com>,
        <git@vger.kernel.org>, "Michael Haggerty" <mhagger@alum.mit.edu>,
        "Michael J Gruber" <git@drmicha.warpmail.net>,
        "Matthieu Moy" <Matthieu.Moy@imag.fr>
References: <CAFjFpRe8zqxs4OLbCrjnuEzF=75sbBJ+HuZqek49B=O=TFHq8A@mail.gmail.com> <xmqqbmucuwb0.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702092142020.3496@virtualbox> <xmqqwpcznjqi.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702092301070.3496@virtualbox> <xmqqd1ernh7g.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702101654500.3496@virtualbox>
Subject: Re: Bug with fixup and autosquash
Date:   Fri, 10 Feb 2017 19:02:06 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfEyEBzh3oyghLRHH8NE7ZiNv49SkdUmrmFMlLlqKUOeJxJL9WAJEBc6gEc/5AcmgdYmzIDO7QrnG0S8Bsu12TFL8FOYZXHzeFYwmdvgN+K0Z/putrAIr
 T54K9cJMeZbogPDMHhbiMCvHZ770W3kzTsf4v199K3Lfu1T3h2eQyVHjJExZ7x5iJlV0DPehxvu8oZTtrltd9lBiAYh+40oFtgsH8SYZrYFZ2NlCIAJSjBcc
 Qn6uWa6280U1ZJYyJp73m04lBF6dFKl9WrV2weOanpiKx3HCn6hErsifyz2jg3QxLAMKlFq+T4AxWv1FmcFZYt8uJEGMaimxuTlixf+rkcaFnn/CpCs8Pl42
 qO4I/8+1mFKzcE7BJZABe/aLTS5tTA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> Hi Junio,
>
> On Thu, 9 Feb 2017, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > Almost. While I fixed the performance issues as well as the design
>> > allowed, I happened to "fix" the problem where an incomplete prefix
>> > match could be favored over an exact match.
>>
>> Hmph.  Would it require too much further work to do what you said the
>> code does:
>
> I was just being overly precise. I *did* fix the problem. But since it was
> not my intention, I quoted the verb "fix".
>
>> > The rebase--helper code (specifically, the patch moving autosquash
>> > logic into it: https://github.com/dscho/git/commit/7d0831637f) tries
>> > to match exact onelines first, and falls back to prefix matching only
>> > after that.
>>
>> If the code matches exact onlines and then falls back to prefix, I do
>> not think incomplete prefix would be mistakenly chosen over an exact
>> one, so perhaps your code already does the right thing?
>
> The code does exactly that. It does even more: as `fixup! <SHA-1>` is
> allowed (for SHA-1s that have been mentioned in previous `pick` lines), it
> tries to match that before falling back to the incomplete prefix match.
>
> Ciao,
> Johannes

Now just the doc update to do.... ;-)

I definitely think the 'fix' that allows the `fixup! <SHA-1>` as the subject 
line is a good way to go for those who mix in the use of the gui and gitk 
into their workflow (*)

--
Philip
(*) I just don't see the point of having multiple cli tty windows, and then 
not using the gui/k windows that are part of the tool set.

