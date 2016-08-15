Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE,URIBL_RED shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01CEF1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 20:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbcHOUk6 (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 16:40:58 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:64485 "EHLO
	smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932201AbcHOUk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 16:40:57 -0400
Received: from PhilipOakley ([92.22.3.79])
	by smtp.talktalk.net with SMTP
	id ZOgobckTy0KuvZOgobJvcT; Mon, 15 Aug 2016 21:40:55 +0100
X-Originating-IP: [92.22.3.79]
X-Spam:	0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=LkKjIWfvQdKNf3TZC4q4CQ==:117
 a=LkKjIWfvQdKNf3TZC4q4CQ==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=5rxgeBVgAAAA:8 a=m5T4TEqDSwLQMX75NosA:9
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <C8DDA334A45E4B558FD1EFB191E047C9@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Junio C Hamano" <gitster@pobox.com>
Cc:	"Ralf Thielow" <ralf.thielow@gmail.com>, <git@vger.kernel.org>,
	<larsxschneider@gmail.com>, <me@jnm2.com>
References: <20160812201011.20233-1-ralf.thielow@gmail.com><20160815053628.3793-1-ralf.thielow@gmail.com><D954CB3E6C3445AF9358C6941362B69D@PhilipOakley> <xmqqr39phq3c.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v2] help: make option --help open man pages only for Git commands
Date:	Mon, 15 Aug 2016 21:40:54 +0100
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
X-CMAE-Envelope: MS4wfOu9+hWRasocXgRK7SWVUE7n5oxVIYYuR6QYl/6i9TahQGPXw6IpiSi+qVJjlSAl5nX/WD6xC1rqd+FlL8C7hA5bCIXE1o9KpeGyocRHiYhs3o3tjkZi
 il+/9xbuaoe1gwc+8R13fansW5JK81ScH4l4BB2pJA1zFLrwjK6F0vvuiRaw+e09uo2Wf+i8dACHkVBQcda1aO4D0FRSI+28f9ZxtbbN/u6nZiX9aXXbq2tR
 mLYBkWNdIaESWlVa0AFql/WVf+sj6wg3to1LwevasNRTG/ycUiO6ntjSlehCWfof
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> I'm still not sure this is enough. One of the problems back when I
>> introduced the --guides option (65f9835 (builtin/help.c: add --guide
>> option, 2013-04-02)) was that we had no easy way of determining what
>> guides were available, especially given the *nix/Windows split where
>> the help defaults are different (--man/--html).
>>
>> At the time[1] we (I) punted on trying to determine which guides were
>> actually installed, and just created a short list of the important
>> guides, which I believe you now check. However the less common guides
>> are still there (gitcvs-migration?), and others may be added locally.
>
> I think we should do both; "git help cvs-migration" should keep the
> same codeflow and behaviour as we have today (so that it would still
> work), while "git cvs-migration --help" should say "'cvs-migration'
> is not a git command".  That would be a good clean-up anyway.
>
> It obviously cannot be done if git.c::handle_builtin() does the same
> "swap <word> --help to help <word>" hack, but we could improve that
> part (e.g. rewrite it to "help --swapped <word>" to allow cmd_help()
> to notice).  When the user said "<word> --help", we don't do guides,
> when we swapped the word order, we check with guides, too.
>
The other option is to simply build a guide-list in exactly the same format 
as the command list (which if it works can be merged later). Re-use the 
existing code, etc.

I did propose that in my very first patch series, but it was probably a step 
too far at the time, as it stepped on the toes of your (junio's) script for 
the command list.

The link in my previous patch got mangled a possible start point for Ralf 
for looking at building a guide list would be 
http://public-inbox.org/git/1361660761-1932-7-git-send-email-philipoakley@iee.org/ 
(which worked back then ;-)

Philip


