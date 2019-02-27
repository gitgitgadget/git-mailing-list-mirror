Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3511C20248
	for <e@80x24.org>; Wed, 27 Feb 2019 12:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbfB0Mwg convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 27 Feb 2019 07:52:36 -0500
Received: from webmail.trimma.se.253.68.83.in-addr.arpa ([83.68.253.31]:5124
        "EHLO Triton.ad.trimma.se" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728004AbfB0Mwf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Feb 2019 07:52:35 -0500
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Feb 2019 07:52:34 EST
Received: from Triton.ad.trimma.se ([fe80::3059:77c9:78ab:1ec0]) by
 Triton.ad.trimma.se ([fe80::3059:77c9:78ab:1ec0%10]) with mapi id
 14.02.0328.009; Wed, 27 Feb 2019 13:47:08 +0100
From:   Linus Nilsson <Linus.Nilsson@trimma.se>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [BUG] All files in folder are moved when cherry-picking commit that
 moves fewer files
Thread-Topic: [BUG] All files in folder are moved when cherry-picking commit
 that moves fewer files
Thread-Index: AdTOmod0m3uZbLYAQNuBqsmdOY/9ng==
Date:   Wed, 27 Feb 2019 12:47:07 +0000
Message-ID: <67C5CE5D6EC13D4DB8FC51E2F9BD262F022B8B3151@Triton.ad.trimma.se>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.150.118]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I have found what I suspect to be a bug, or at least not desirable behavior in my case. In one branch, I have moved all files in a directory to another directory. The first directory is now empty in this branch (I haven't tested whether this is significant). I cherry-picked the commit to another branch that has additional files in the first directory. All the files in the first directory are now moved to the second directory, and not just the files that were moved in the original commit. It happens in Git for Windows, versions 2.20.1 and 2.21.0.

It can be reproduced using these steps:

$ git init
$ mkdir a
$ echo Hello > a/file1
$ git add a/file1
$ git commit -m 'Add file1'
$ git checkout -b fix
$ mkdir b
$ git mv a/file1 b
$ git commit -m 'Move file1 to b'
$ git checkout master
$ echo Bye > a/file2
$ git add a/file2
$ git commit -m 'Add file2'
$ git cherry-pick fix
[master 5b63afb] Move file1 to b
 Date: Wed Feb 27 13:27:45 2019 +0100
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename {a => b}/file1 (100%)
 rename {a => b}/file2 (100%)

Regards
Linus Nilsson
