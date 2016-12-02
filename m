Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 425761FF6D
	for <e@80x24.org>; Fri,  2 Dec 2016 18:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753418AbcLBSUb convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 2 Dec 2016 13:20:31 -0500
Received: from smtp-out6.electric.net ([192.162.217.184]:57885 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbcLBSUa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 13:20:30 -0500
X-Greylist: delayed 1089 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Dec 2016 13:20:29 EST
Received: from 1cCsA5-0005fa-UQ by out6b.electric.net with emc1-ok (Exim 4.87)
        (envelope-from <thomas.attwood@stfc.ac.uk>)
        id 1cCsA5-0005iT-Ve
        for git@vger.kernel.org; Fri, 02 Dec 2016 10:02:17 -0800
Received: by emcmailer; Fri, 02 Dec 2016 10:02:17 -0800
Received: from [130.246.236.11] (helo=exchsmtp.stfc.ac.uk)
        by out6b.electric.net with esmtps (TLSv1:ECDHE-RSA-AES256-SHA:256)
        (Exim 4.87)
        (envelope-from <thomas.attwood@stfc.ac.uk>)
        id 1cCsA5-0005fa-UQ
        for git@vger.kernel.org; Fri, 02 Dec 2016 10:02:17 -0800
Received: from EXCHMBX01.fed.cclrc.ac.uk ([130.246.236.13]) by
 EXCHHUB03.fed.cclrc.ac.uk ([130.246.236.11]) with mapi id 14.03.0266.001;
 Fri, 2 Dec 2016 18:02:16 +0000
From:   <thomas.attwood@stfc.ac.uk>
To:     <git@vger.kernel.org>
Subject: git 2.11.0 error when pushing to remote located on a windows share
Thread-Topic: git 2.11.0 error when pushing to remote located on a windows
 share
Thread-Index: AdJMwlQUDsC60xIvQbi3TRYfROIxxw==
Date:   Fri, 2 Dec 2016 18:02:16 +0000
Message-ID: <AABB04BF1441D24CB4E9FCF46394F17D666F34E1@exchmbx01>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.246.243.169]
x-esetresult: clean, is OK
x-esetid: 37303A29411E5567637567
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 130.246.236.11
X-Env-From: thomas.attwood@stfc.ac.uk
X-Proto: esmtps
X-Revdns: exchhub03.rl.ac.uk
X-HELO: exchsmtp.stfc.ac.uk
X-TLS:  TLSv1:ECDHE-RSA-AES256-SHA:256
X-Authenticated_ID: 
X-PolicySMART: 3590380
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After updating git from 2.10.0 to 2.11.0 when trying to push any changes to a repo located in a windows share, the following error occurs:

$ git push origin test
Counting objects: 2, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), 284 bytes | 0 bytes/s, done.
Total 2 (delta 1), reused 1 (delta 0)
remote: error: object directory /path/to/dir/objects does not exist; check .git/objects/info/alternates.
remote: fatal: unresolved deltas left after unpacking
error: unpack failed: unpack-objects abnormal exit
To //path/to/dir
 ! [remote rejected] test -> test (unpacker error)
error: failed to push some refs to '//path/to/dir'


No error occurs if pushing to the same repo (a direct copy into a local directory) using 2.11.0.

$ git push local_test test
Counting objects: 2, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), 284 bytes | 0 bytes/s, done.
Total 2 (delta 1), reused 1 (delta 0)
To C:/path/to/dir
 * [new branch]      test -> test

---

git remotes:

$ git remote -v
local_test      C:/path/to/dir (fetch)
local_test      C:/path/to/dir (push)
origin  //path/to/dir (fetch)
origin  //path/to/dir (push)

---

Using `git fsck --full` in both 2.11.0 and 2.10.0, it doesn't reveal any additional problems.

$ git fsck --full
Checking object directories: 100% (256/256), done.
Checking objects: 100% (2710/2710), done.

---

I'm not sure if it's related but ` object directory /path/to/dir/objects does not exist` doesn't contain an expected second slash.

    Thomas 'Panda' Attwood.
