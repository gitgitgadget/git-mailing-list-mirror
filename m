Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B6DC433FE
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 08:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343800AbiBUIgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 03:36:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiBUIgK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 03:36:10 -0500
X-Greylist: delayed 531 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 00:35:47 PST
Received: from st43p00im-zteg10063501.me.com (st43p00im-zteg10063501.me.com [17.58.63.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EE6DE83
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 00:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1645432015;
        bh=Efe3ez21iCCFUOMFQX3H/P+vkxnHFNyGhvhYv7Qrhrs=;
        h=From:Content-Type:Mime-Version:Date:Subject:Message-Id:To;
        b=kQYBHNpWbIGhnLTfL+sxXPzMGi/J2N3Kcw1kWqbue3d70tjzlCPuu92TJaydNdIyq
         9A3LNs8CM5za7idCI96Tjsxo06Ank28k0wIifKiuVMiIg2dc5ofRNJNcKudSRfB/2b
         tnxir0+OzZeDhiBZS8IXZLi2Q7QQko0t/60XnOtGHqjj9M3azNhTtlbzqVOIdOE25y
         RWRWTHL1yogspIexsdneVcsro4NPNlZNrg6Bna65jebLp84YwTaTCf+g39ZDgWkXUv
         SvUQifrbPhKR2O/rrSP5QDo+/rJaaD04Gx+9pYagabJTiVizxAigyNL+Vt2EsmiMdc
         T03Tjg0hMExVw==
Received: from infedyn180.informatik.uni-stuttgart.de (infedyn180.informatik.uni-stuttgart.de [129.69.220.180])
        by st43p00im-zteg10063501.me.com (Postfix) with ESMTPS id 29D634C1662;
        Mon, 21 Feb 2022 08:26:55 +0000 (UTC)
From:   Maximilian Reichel <reichemn@icloud.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Date:   Mon, 21 Feb 2022 09:26:52 +0100
Subject: pull fails after commit dry-run
Message-Id: <9FF5E3B7-E3EC-4E71-A701-D43B8B092F7C@icloud.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.21)
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2202210051
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Running the following two scripts.
Script one:
'#!/bin/bash

mkdir parent
git -C parent init
git -C parent -c user.name=3D"P" -c user.email=3D"m@example.com" commit =
-m one --allow-empty=20

mkdir cloneDir
cd cloneDir
git init

git pull -v --rebase "../parent"
echo git pull exit code: $?'

script two:
'#!/bin/bash

mkdir parent
git -C parent init
git -C parent -c user.name=3D"P" -c user.email=3D"m@example.com" commit =
-m one --allow-empty=20

mkdir cloneDir
cd cloneDir
git init
git commit -m "foo" --dry-run
git pull -v --rebase "../parent"
echo git pull exit code: $?'

What did you expect to happen? (Expected behavior)
Since they only differ in the 'git commit -m "foo" --dry-run' =
invocation, I would expect the same outcome for both scripts.
Expected output of the last two lines:
'=46rom ../parent
 * branch            HEAD       -> FETCH_HEAD
git pull exit code: 0'

What happened instead? (Actual behavior)
The second script is not able to pull from ../parent.
Output of the last lines of the second script:
'fatal: Updating an unborn branch with changes added to the index.
git pull exit code: 128=E2=80=99


Anything else you want to add:
I tested this on git 2.35.1, 2.34.1 and 2.21.0 and they are all =
affected.=20


[System Info]
git version:
git version 2.35.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.25-linuxkit #1 SMP Tue Mar 23 09:27:39 UTC 2021 x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.31
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
not run from a git repository - no hooks to show=
