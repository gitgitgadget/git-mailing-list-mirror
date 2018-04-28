Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D20E1F404
	for <e@80x24.org>; Sat, 28 Apr 2018 10:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759820AbeD1Ka0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 06:30:26 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:48249 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759756AbeD1KaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 06:30:25 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id CN7UfcvpI2vvYCN7Xfb5Xa; Sat, 28 Apr 2018 11:30:24 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=LLdIvqe9 c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=JBLUpSMPAAAA:8 a=rqu3hC5EQOz17NpVQyEA:9 a=QEXdDO2ut3YA:10
 a=o8iT8L5u9Sa769JGGcpz:22
Message-ID: <249C4D418B2B49B4AD5545B912FDA53D@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jacob Keller" <jacob.keller@gmail.com>,
        "Tang \(US\), Pik S" <Pik.S.Tang@boeing.com>
Cc:     "Git List" <git@vger.kernel.org>
References: <d4d8d8208b6a41c380ecf20807763bcf@XCH15-05-02.nw.nos.boeing.com> <CA+P7+xryOt_-vg7cpvqRapM7nWuhWXjhpUR1xi-5MY_RH5UwAQ@mail.gmail.com>
Subject: Re: Branch deletion question / possible bug?
Date:   Sat, 28 Apr 2018 11:30:21 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180428-4, 28/04/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfHk+b+EqUX9X88aqnuQftqI/L6GwzQ3xOtnyahCPmnIEDfUP1Zmseo0fanzJ75BfWl0GfYrPk4Y85QHgSyyQlyxO045z51eUoeLfzmAxwxuSwrXctWwl
 yaAAotV4pNuZYUW88+97NbE9oWRTRmtYGZ8hH4sNmbQJ2oTHcs6/QZRpnOG+gFKgAUsm00lMiAy7YOJTE8Vz0HZXp/OyMcexq0blBNq/eELvro0fE/XW3Ayq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jacob Keller" <jacob.keller@gmail.com>
> On Fri, Apr 27, 2018 at 5:29 PM, Tang (US), Pik S <Pik.S.Tang@boeing.com>
> wrote:
>> Hi,
>>
>> I discovered that I was able to delete the feature branch I was in, due
>> to some fat fingering on my part and case insensitivity.  I never
>> realized this could be done before.  A quick google search did not give
>> me a whole lot to work with...
>>
>> Steps to reproduce:
>> 1. Create a feature branch, "editCss"
>> 2. git checkout master
>> 3. git checkout editCSS
>> 4. git checkout editCss
>> 5. git branch -d editCSS
>>
>
> Are you running on a case-insensitive file system? What version of
> git? I thought I recalled seeing commits to help avoid creating
> branches of the same name with separate case when we know we're on a
> file system which is case-insensitive..
>
>> Normally, it should have been impossible for a user to delete the branch
>> they're on.  And the deletion left me in a weird state that took a while
>> to dig out of.
>>
>> I know this was a user error, but I was also wondering if this was a bug.
>
> If we have not yet done this, I think we should. Long term this would
> be fixed by using a separate format to store refs than the filesystem,
> which has a few projects being worked on but none have been put into a
> release.

Yes, this is an on-going problem on Windows and other case insentive
systems. At the moment the branch name becomes embedded as a file name, so
when Git requests details of a branch from the filesystem, it can get a case
insensitive equivalent. Meanwhile, internally Git is checking for equality
in a case sensitive [Linux] way with obvious consequences such as this - The
most obvious being when there is no "*" current branch marker in the branch
status list.

It's a bit tricky to fix (internally the name and the path are passed down
different call chains), and depends on how one expects the case
insensitivity to work - the kicker is when someone does an edit of the name
via the file system and expects Git to cope (i.e. devs knowing, or think
they know, too much detail ;-).

The refs can also get packed, so the "bad spelling" gets baked in.
Ultimately it probably means that GfW and other systems will need  a case
sensitivity check when opening paths...

Philip
>
> Thanks,
> Jake
>
>>
>>
>> Thanks,
>>
>> Pik Tang
>>
>

