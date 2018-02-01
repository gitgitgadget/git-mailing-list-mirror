Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3203A1F404
	for <e@80x24.org>; Thu,  1 Feb 2018 14:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeBAOFI (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 09:05:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:44178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751526AbeBAOFG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 09:05:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4F78FABB2;
        Thu,  1 Feb 2018 14:05:05 +0000 (UTC)
Subject: Re: [PATCH] tag: add --edit option
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <450140f4-d410-4f1a-e5c1-c56d345a7f7c@suse.com>
 <CAPig+cTFsp60KB+quuytW_nV2crLcjRV-PYN-3bO7tRY0_xu6w@mail.gmail.com>
 <fb3387f9-a341-c4dc-fa37-581229fb2c1d@suse.de>
 <bbc03595-cb31-63b8-3f4c-cfa04bb9ff27@suse.de>
 <CAPig+cTEoM3qYRN6j=zSVv1LPx_ggVuxqTMMK0SpjtYEqOiBMA@mail.gmail.com>
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Openpgp: preference=signencrypt
Message-ID: <4929bb41-54e7-4ba4-459f-e0d0649a14bf@suse.de>
Date:   Thu, 1 Feb 2018 15:05:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTEoM3qYRN6j=zSVv1LPx_ggVuxqTMMK0SpjtYEqOiBMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 01/02/2018 à 11:56, Eric Sunshine a écrit :
> On Thu, Feb 1, 2018 at 5:43 AM, Nicolas Morey-Chaisemartin
> <NMoreyChaisemartin@suse.de> wrote:
>> Le 01/02/2018 à 11:34, Nicolas Morey-Chaisemartin a écrit :
>>> Le 01/02/2018 à 11:16, Eric Sunshine a écrit :
>>>> A little below this change is where launch_editor() is actually
>>>> invoked. If it fails for some reason, it prints:
>>>>
>>>>     Please supply the message using either -m or -F option.
>>>>
>>>> which seems a bit counterintuitive if the user *did* specify one of
>>>> those options along with --edit. I wonder if that message needs to be
>>>> adjusted.
>>>>
>>> Yes I'll fix this.
>> I just checked what commit.c does and it seems to behave as my patch:
>>         if (launch_editor(git_path_commit_editmsg(), NULL, env.argv)) {
>>             fprintf(stderr,
>>             _("Please supply the message using either -m or -F option.\n"));
>>
>> To be honest the message is not that clear either.
>> If I'm reading launch_editor right most (or all) its falire are du to a failure to launch the editor or the editor crashed/exited with an error.
>> In this case, I wouldn't advise the user to use -m or -F but to fix its editor.
> Indeed, I also looked at the implementation of launch_editor(), and my
> "wondering" about whether the message needed adjustment was just that.
> The message seems somewhat counterintuitive in this case, but I didn't
> necessarily have a better suggestion. A valid response, therefore,
> might be to punt on it and leave that change for the future, or
> perhaps take it on as a second patch which adjusts the message in both
> commands. I don't have strong feelings about it at this time.

It seems all the error paths from launch_editor have an error message.
A simple "Editor failure, cancelling {commit, tag}" would probably be a better error message.
I'll post another series for that.
