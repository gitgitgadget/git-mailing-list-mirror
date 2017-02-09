Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C38F1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 23:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbdBIXeA (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 18:34:00 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:39824 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbdBIXd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 18:33:58 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id byBwceaf0cpskbyBwcIqH2; Thu, 09 Feb 2017 23:31:57 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=oa-xg8NNAAAA:8
 a=NEAV23lmAAAA:8 a=29pjsaa-ENbRs2naNrIA:9 a=wPNLvfGTeEIA:10
 a=MQ1BrC-N35uif390zSTS:22 a=Bn2pgwyD2vrAyMmN8A2t:22
Message-ID: <454E7D934160418EB4C4871ED209CBCA@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     "Ashutosh Bapat" <ashutosh.bapat@enterprisedb.com>,
        <git@vger.kernel.org>, "Michael Haggerty" <mhagger@alum.mit.edu>,
        "Michael J Gruber" <git@drmicha.warpmail.net>,
        "Matthieu Moy" <Matthieu.Moy@imag.fr>
References: <CAFjFpRe8zqxs4OLbCrjnuEzF=75sbBJ+HuZqek49B=O=TFHq8A@mail.gmail.com> <xmqqbmucuwb0.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702092142020.3496@virtualbox>
Subject: Re: Bug with fixup and autosquash
Date:   Thu, 9 Feb 2017 23:31:56 -0000
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
X-CMAE-Envelope: MS4wfOj+RZyq2kdocYqwaY2PX6CqIv6LF0MWOJ2getVYxaWAU4mjH3xGrdUebJ7wVYLXkILDY2of2wE8F+e0PMSd7vF85MP3QdKWL05jMcA/kXqTfcgMt5qh
 qo6vywDo/YWHVpsnLNS9yDRLj4lEjG8RkGmSN2JBXyIMNs9NIJZp5DahwDmW5JwQzg185xRPLpbO7ewRzqZCYIWwtdmmNhxkTCPcmHd8AqX02V4IddJJ+FzS
 IOCDRt2orKur0PcTLC2adkMFfFH5FDhjqi5Kv0bEsMAe5D+vk9IjxAmYsLSz5KpZtw/KWAEVjQF3vg+G4lguczHXPWS7gCX7V9G9Fm6atfGFN/vbQlh2jShn
 n/6Ma13tOnMnI8wOYX423bsiNMmRJg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sent: Thursday, February 09, 2017 8:55 PM
> Hi Ashutosh and Junio,
>
> On Wed, 8 Feb 2017, Junio C Hamano wrote:
>
>> Ashutosh Bapat <ashutosh.bapat@enterprisedb.com> writes:
>>
>> > I have been using git rebase heavily these days and seem to have found
>> > a bug.
>> >
>> > If there are two commit messages which have same prefix e.g.
>> > yyyyyy This is prefix
>> > xxxxxx This is prefix and message
>> >
>> > xxxxxx comitted before yyyyyy
>> >
>> > Now I commit a fixup to yyyyyy using git commit --fixup yyyyyy
>> > zzzzzz fixup! This is prefix
>> >
>> > When I run git rebase -i --autosquash, the script it shows me looks 
>> > like
>> > pick xxxxxx This is prefix and message
>> > fixup zzzzzz fixup! This is prefix
>> > pick yyyyyy This is prefix
>> >
>> > I think the correct order is
>> > pick xxxxxx This is prefix and message
>> > pick yyyyyy This is prefix
>> > fixup zzzzzz fixup! This is prefix
>> >
>> > Is that right?
>>
>> [...]
>>
>> Unfortunately, "rebase -i --autosquash" reorders the entries by
>> identifying the commit by its title, and it goes with prefix match so
>> that fix-up commits created without using --fixup option but manually
>> records the title's prefix substring can also work.
>
> This prefix match also happens to introduce a serious performance problem,
> which is why I "fixed" this issue in the rebase--helper already (which is
> the case if you are using Git for Windows, whose master branch builds on
> Linux and MacOSX as well). I quoted "fix" because my motivation was to fix
> the performance problem, not the "incorrect match" problem.
>
> The rebase--helper code (specifically, the patch moving autosquash logic
> into it: https://github.com/dscho/git/commit/7d0831637f) tries to match
> exact onelines first,

While I think this is an improvement, and will strongly support the `git 
commit --fixup=<commit>` option which will, if the sha1/oid is given, create 
the exact commit subject line.

However it would also be useful if the actual commit subject line could have 
a similar format option, so that those who use say the git gui (rather than 
the cli) for the commit message, could easily create the `!fixup <commit>` 
message which would allow a broader range of ways of spelling the commit 
(e.g. giving a sha1(min length) that is within the rebase todo list).

> and falls back to prefix matching only after that.
>
> Now that the sequencer-i patch series is in `master`, the next step is to
> send the patch series introducing the rebase--helper. The patch series
> including the fix discussed above relies on that one. Meaning that it will
> take a while to get through the mill.
>
> So please do not hold your breath until this feature/fix hits an official
> Git version. If you need it[*1*] faster, feel free to build Git for
> Windows' master and run with that for a while.
>
> Ciao,
> Johannes
>
> Footnote: By "it" I mean "the feature/fix", not "an official Git version"
> nor "your breath".
>
--
Philip 

