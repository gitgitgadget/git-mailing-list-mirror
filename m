Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46B581F453
	for <e@80x24.org>; Mon,  5 Nov 2018 09:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeKESsG convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 5 Nov 2018 13:48:06 -0500
Received: from cme-mx02.cmegroup.com ([204.10.8.92]:62901 "EHLO
        cme-mx02.cmegroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeKESsG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 13:48:06 -0500
X-IronPort-AV: E=Sophos;i="5.54,467,1534809600"; 
   d="scan'208";a="56093465"
Received: from smx1oaindlp0002.prod.ad.merc.chicago.cme.com (HELO SMD1OACSEXC0003.prod.ad.merc.chicago.cme.com) ([10.250.195.152])
  by AAX1OAEMESA0002.MERC.CHICAGO.CME.COM with ESMTP; 05 Nov 2018 09:29:16 +0000
Received: from SMD1OACSEXC0006.prod.ad.merc.chicago.cme.com (10.213.105.35) by
 SMD1OACSEXC0003.prod.ad.merc.chicago.cme.com (10.213.105.132) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Mon, 5 Nov 2018 03:29:16 -0600
Received: from SMD1OACSEXC0003.prod.ad.merc.chicago.cme.com (10.213.105.32) by
 SMD1OACSEXC0006.prod.ad.merc.chicago.cme.com (10.213.105.135) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Mon, 5 Nov 2018 03:29:13 -0600
Received: from SMD1OACSEXC0003.prod.ad.merc.chicago.cme.com
 ([fe80::f977:1ad9:fb37:ddae]) by SMD1OACSEXC0003.prod.ad.merc.chicago.cme.com
 ([fe80::f977:1ad9:fb37:ddae%18]) with mapi id 15.00.1395.000; Mon, 5 Nov 2018
 03:29:13 -0600
From:   "Quinn, David" <David.Quinn@cmegroup.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Failed stash caused untracked changes to be lost
Thread-Topic: Failed stash caused untracked changes to be lost
Thread-Index: AQHUar6pSVAG+ED9H06IEwz5NHwoTqU+k+IAgAJomdA=
Date:   Mon, 5 Nov 2018 09:29:12 +0000
Message-ID: <f1dd8c7097e94602a4508be4ceffbda0@SMD1OACSEXC0003.prod.ad.merc.chicago.cme.com>
References: <1540292560837.94684@cmegroup.com>
 <20181103153458.GG4883@hank.intra.tgummerer.com>
In-Reply-To: <20181103153458.GG4883@hank.intra.tgummerer.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.213.126.15]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for the reply. Sorry I forgot the version number, completely slipped my mind. At the time of writing the report it was Git ~ 2.17 I believe. All of our software is updated centrally at my work, we have received an update since writing this to 2.19.1. Unfortunately because of it being centrally controlled, I couldn't update and try the latest version at the time (and now I can't go back and check exactly what version I had).

I've never even looked at the git source or contributing before so I wouldn't be sure where to start. If you (or someone) is happy to point me in the right direction I'd be happy to take a look, I can't promise I'll be able to get anything done in a timely manner (or at all)

Thanks

-----Original Message-----
From: Thomas Gummerer <t.gummerer@gmail.com> 
Sent: 03 November 2018 15:35
To: Quinn, David <David.Quinn@cmegroup.com>
Cc: git@vger.kernel.org
Subject: Re: Failed stash caused untracked changes to be lost

Exercise Caution: This email is from an external source.


On 10/23, Quinn, David wrote:
>
> Issue: While running a git stash command including the '-u' flag to include untracked files, the command failed due to arguments in the incorrect order. After this untracked files the were present had been removed and permanently lost.

Thanks for your report (and sorry for the late reply)!

I believe this (somewhat) fixed in 833622a945 ("stash push: avoid printing errors", 2018-03-19), which was first included in Git 2.18.
Your message doesn't state which version of Git you encountered the bug, but I'm going to assume with something below 2.18 (For future reference, please include the version of Git in bug reports, or even better test with the latest version of Git, as the bug may have been fixed in the meantime).

Now I'm saying somewhat fixed above, because we still create an stash if a pathspec that doesn't match any files is passed to the command, but then don't remove anything from the working tree, which is a bit confusing.

I think the right solution here would be to error out early if we were given a pathspec that doesn't match anything.  I'll look into that, unless you're interested in giving it a try? :)

> Environment: Windows 10, Powershell w/ PoshGit
>
>
> State before running command: 9 Modified files, 2 (new) untracked 
> files
>
> Note: I only wanted to commit some of the modified files (essentially 
> all the files/changes I wanted to commit were in one directory)
>
> Actual command run:  git stash push -u -- Directory/To/Files/* -m "My Message"
>
> Returned:
>
>     Saved working directory and index state WIP on [BranchName]: [Commit hash] [Commit Message]
>     fatal: pathspec '-m' did not match any files
>     error: unrecognized input
>
> State after Command ran: 9 Modifed files, 0 untracked files
>
>
> The command I should have ran should have been
>
>     git stash push -u -m "My Message"? -- Directory/To/Files/*
>
>
> I have found the stash that was created by running this command:
>
>     gitk --all $(git fsck --no-reflog | Select-String "(dangling 
> commit )(.*)" | %{ $_.Line.Split(' ')[2] }) ?
> and searching for the commit number that was returned from the original (paritally failed??) stash command. However there is nothing in that stash. It is empty.
>
>
>
> I think that the fact my untracked files were lost is not correct 
> behaviour and hence why I'm filing this bug report
>
>
>
>
> ________________________________
> NOTICE: This message, and any attachments, are for the intended recipient(s) only, may contain information that is privileged, confidential and/or proprietary and subject to important terms and conditions available at E-Communication Disclaimer<http://www.cmegroup.com/tools-information/communications/e-communication-disclaimer.html>. If you are not the intended recipient, please delete this message. CME Group and its subsidiaries reserve the right to monitor all email communications that occur on CME Group information systems.
