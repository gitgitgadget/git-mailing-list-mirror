Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFC1B2070F
	for <e@80x24.org>; Sun, 18 Sep 2016 19:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756246AbcIRThd (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Sep 2016 15:37:33 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:65047 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756101AbcIRThc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2016 15:37:32 -0400
Received: from PhilipOakley ([92.22.21.30])
        by smtp.talktalk.net with SMTP
        id lhu5bydUw0Kuvlhu5bhLJf; Sun, 18 Sep 2016 20:37:30 +0100
X-Originating-IP: [92.22.21.30]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=iMv/OWFaO6rICWONOtAd4w==:117
 a=iMv/OWFaO6rICWONOtAd4w==:17 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8
 a=G2-PVLz0Au7u-NYypO4A:9 a=QEXdDO2ut3YA:10 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <4BB675F0AED14A309DC90DDDB08F441B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Philip Oakley" <philipoakley@iee.org>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     "Git List" <git@vger.kernel.org>
References: <3C23ED270E0C486EB2063BC5AEC25678@PhilipOakley> <CAPc5daUN7s+asu=drJRp=d1a5VRvG_EFNTsTqaQB+NZGDrzRmw@mail.gmail.com> <CAPc5daUsRtR0=C8D=gqTtk=2erqX1DHsYNbQzmyAyw+prCBrfQ@mail.gmail.com> <CAPc5daUdM4wwY7C_YKx0DkW3kty+VewksMMXG39bBr1K-JxBag@mail.gmail.com> <FD07B781038A4C878F6D0152A4ECE580@PhilipOakley>
Subject: Re: Finding a commit based on the diff index line?
Date:   Sun, 18 Sep 2016 20:37:31 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfNtMUxLbsi/S5gJVZ8MzUwRvNRJfluA5YkJbPfJGwcneDMmspnU+8S6lEOMsSBk96Glcc7IithU5FORn5ClIZG6jcc6HNIDJmsUXdtjGWGBebb64Nt4O
 WGTHrzzb+xcc/K020HNLTILr/r1jJ4UVsEizx+Py0tGuspn7XQ16ColzA09fQMQUej5PbxBjetE5+syUMcJGdqG+fbY+ns9eZtABj/WbB5IlrQM5zJyEdpoo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Philip Oakley" <philipoakley@iee.org>
>> From: Junio C Hamano
>> Sent: Saturday, September 17, 2016 5:30 PM
>>
>> Does it count as simple to use pager's search feature in
>> "log --raw" output piped to it?
>>
>> Pardon typos & html; typed on a phone
>>
>
> The `log --raw` looks useful, though I think (IIUC) I also have a problem 
> that (obviously?) these commits are not linked behind any existing ref 
> (except maybe the reflogs which I'm not up to speed on).
>
For others that may be reading... The command I eventually ended up using to 
find old series was:

git reflog HEAD --grep-reflog='rebase -i (finish)' | cut -c1-7 | xargs -n1 
git quote

where the alias.quote = log -1 --pretty='tformat:%h (%s, %ad)' --date=short

I can then compare the dates of my corrective rebases to the patch 
submission dates to find the (local sha1 of) missing series.

> I had somehow hoped for some neat magic command or rev specifier that took 
> the revs as alternates to the `-- <paths>` in rev-parse or some such....

Though locating a commit based on a diff's index line does still feel to be 
something that should be possible.
>
> It's tricky curating old mistakes ;-)
>
> Thanks for the pointer.
>
>> On Sep 17, 2016 07:33, "Philip Oakley" <philipoakley@iee.org> wrote:
>>
>> > Hi,
>> >
>> > I'm curating some of my old patch series (i.e. doing some tidying up) 
>> > and
>> > I'm trying to determine the commits that generated some of my patches 
>> > so
>> > that I can see if I still have them after they were rebased (a 'name 
>> > that
>> > dangling branch' problem).
>> >
>> > Is there an easy way of finding the commit sha1 that contains the given 
>> > diff
>> > index line.
>> >
>> > For example.
>> > index fa05269..57033dd 100755
>> > or
>> > index 8ebcded..d9ab360 100644
>> >
>> > which both should get back to Jeff King's 36d6792 (t0006: test various 
>> > date
>> > formats, 2016-06-20).
>> >
>> > It feels like it is something that should already possible without a
>> > mini-script. We have the rev range which should limit the range to a 
>> > single
>> > commit, though if random blob revs were given the commit range would be
>> > 'scattered'.
>> >
>> >
>> > Is there a simple quick way of achieving this?
>> >
>> > --
>> > Philip
>
> 

