Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0CFC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 06:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiBVGUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 01:20:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiBVGUr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 01:20:47 -0500
X-Greylist: delayed 518 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 22:20:22 PST
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8263FD64D0
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 22:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1645510303;
        bh=Mzekzhh7svNZhCGHypCGVQ+3t3H6IXhGQLgITA0n+cE=;
        h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:To;
        b=coFDGDvbhFBJ+a2Y0/X5JUt2ug8q+WbWlNL4wBpsfZLppxol5TkklfhksIJoznBqe
         dLlCbIozbocrBCRzWv0718HcFRgaziXnXUx4oUY1m4H9zd3hSngezfc0eYPD/naocW
         AE4CgL4xAdYwIj9NrHkTjRG2Bc9E4Z1PmJEM6NacdI6Sr6EF2UHAr7TH96ty+XW4Qo
         +1cSRy+pWwmwWsuNdqofhHLQItgjap4wTn0xTHh5waH63SV7zwmfJhQKjWMmdrOvxs
         qLCAB5Q39fqT7oSl5ky7kIhe6xrx7m0T/eCpr9m8B4m6KhHSaKFhD5StGyh741EKZ8
         dg2TQqjh58evg==
Received: from smtpclient.apple (ip-149-172-096-004.um42.pools.vodafone-ip.de [149.172.96.4])
        by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPS id D977A180174
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 06:11:42 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Maximilian Reichel <reichemn@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: pull fails after commit dry-run
Message-Id: <B0458F2D-C6B9-41AE-8F2F-39C1D2AEE6BD@icloud.com>
Date:   Tue, 22 Feb 2022 07:11:40 +0100
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (19D50)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.816
 definitions=2022-02-22_02:2022-02-21,2022-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2202220036
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=EF=BB=BFThank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Running the following two scripts.


Script one:
'#!/bin/bash

mkdir parent
git -C parent init
git -C parent -c user.name=3D"P" -c user.email=3D"m@example.com" commit -m o=
ne --allow-empty=20

mkdir cloneDir
cd cloneDir
git init

git pull -v --rebase "../parent"
echo git pull exit code: $?'




script two:
'#!/bin/bash

mkdir parent
git -C parent init
git -C parent -c user.name=3D"P" -c user.email=3D"m@example.com" commit -m o=
ne --allow-empty=20

mkdir cloneDir
cd cloneDir
git init
git commit -m "foo" --dry-run
git pull -v --rebase "../parent"
echo git pull exit code: $?'



What did you expect to happen? (Expected behavior)
Since they only differ in the 'git commit -m "foo" --dry-run' invocation, I w=
ould expect the same outcome for both scripts.
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
I tested this on git 2.35.1, 2.34.1 and 2.21.0 and they are all affected.=20=



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
not run from a git repository - no hooks to show
