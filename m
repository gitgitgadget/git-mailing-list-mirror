Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F4F81F453
	for <e@80x24.org>; Tue, 23 Oct 2018 11:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeJWTb7 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 23 Oct 2018 15:31:59 -0400
Received: from cme-mx01.cmegroup.com ([204.10.8.90]:41211 "EHLO
        cme-mx01.cmegroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeJWTb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 15:31:59 -0400
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Oct 2018 15:31:59 EDT
X-IronPort-AV: E=Sophos;i="5.54,415,1534809600"; 
   d="scan'208";a="54189401"
Received: from smx1oaindlp0005.prod.ad.merc.chicago.cme.com (HELO SMD1OACSEXC0002.prod.ad.merc.chicago.cme.com) ([10.250.195.168])
  by AAX1OAEMESA0001.MERC.CHICAGO.CME.COM with ESMTP; 23 Oct 2018 11:02:46 +0000
Received: from SMD1OACSEXC0003.prod.ad.merc.chicago.cme.com (10.213.105.32) by
 SMD1OACSEXC0002.prod.ad.merc.chicago.cme.com (10.213.105.31) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Tue, 23 Oct 2018 06:02:41 -0500
Received: from SMD1OACSEXC0003.prod.ad.merc.chicago.cme.com
 ([fe80::f977:1ad9:fb37:ddae]) by SMD1OACSEXC0003.prod.ad.merc.chicago.cme.com
 ([fe80::f977:1ad9:fb37:ddae%18]) with mapi id 15.00.1395.000; Tue, 23 Oct
 2018 06:02:41 -0500
From:   "Quinn, David" <David.Quinn@cmegroup.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Failed stash caused untracked changes to be lost
Thread-Topic: Failed stash caused untracked changes to be lost
Thread-Index: AQHUar6pSVAG+ED9H06IEwz5NHwoTg==
Date:   Tue, 23 Oct 2018 11:02:41 +0000
Message-ID: <1540292560837.94684@cmegroup.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.213.126.15]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Issue: While running a git stash command including the '-u' flag to include untracked files, the command failed due to arguments in the incorrect order. After this untracked files the were present had been removed and permanently lost.

Environment: Windows 10, Powershell w/ PoshGit


State before running command: 9 Modified files, 2 (new) untracked files

Note: I only wanted to commit some of the modified files (essentially all the files/changes I wanted to commit were in one directory)

Actual command run:  git stash push -u -- Directory/To/Files/* -m "My Message"

Returned:

    Saved working directory and index state WIP on [BranchName]: [Commit hash] [Commit Message]
    fatal: pathspec '-m' did not match any files
    error: unrecognized input

State after Command ran: 9 Modifed files, 0 untracked files


The command I should have ran should have been

    git stash push -u -m "My Message"? -- Directory/To/Files/*


I have found the stash that was created by running this command:

    gitk --all $(git fsck --no-reflog | Select-String "(dangling commit )(.*)" | %{ $_.Line.Split(' ')[2] })
?
and searching for the commit number that was returned from the original (paritally failed??) stash command. However there is nothing in that stash. It is empty.



I think that the fact my untracked files were lost is not correct behaviour and hence why I'm filing this bug report




________________________________
NOTICE: This message, and any attachments, are for the intended recipient(s) only, may contain information that is privileged, confidential and/or proprietary and subject to important terms and conditions available at E-Communication Disclaimer<http://www.cmegroup.com/tools-information/communications/e-communication-disclaimer.html>. If you are not the intended recipient, please delete this message. CME Group and its subsidiaries reserve the right to monitor all email communications that occur on CME Group information systems.
