Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E729C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 04:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjEKEPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 00:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjEKEPf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 00:15:35 -0400
X-Greylist: delayed 493 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 21:15:34 PDT
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570854690
        for <git@vger.kernel.org>; Wed, 10 May 2023 21:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1683778041;
        bh=XOmTC6W3B2w9PCql3bnj6wMNZzPHVrQUjPJzjsZTt9o=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=nITVTAvQCJLwjQtQB8pu8QArNmdByJrr0jEOurb30UzRCyL/aRWeKdJW+P93ESabV
         EnwJLZ0Qmpeyr/ucuQ+4zAOFE5cEpXqFgbi84vHX0Y5F2W9oNoSB1NBge4EKHksAEZ
         N5bbuSX+dAEL4r+JoXwF89T2THpydExefhCpwtUYE68VGrM4yAUrcfoXpyRFjDx548
         Tzr3PBQFfYtb6kfK9dzsE6QMAH7I9NnPFesruaiN3qCg8eDMKtlD41gInDhgLinrg4
         /8+WVHCnWUCkaFnR2TLnmAOmCqYfnX/5eXNalukZPMr4eZVj5IGM+cOac3WowiJNV2
         NX4AtISZYuAFQ==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 279473A0E4D;
        Thu, 11 May 2023 04:07:20 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: git rebase --root bug
From:   Christopher Fretz <cfretz@icloud.com>
In-Reply-To: <1efe92ee-6ae0-4588-ba67-b7632c7ea97e@app.fastmail.com>
Date:   Wed, 10 May 2023 22:07:08 -0600
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C3061274-3B8C-4593-B2B3-7C6BCB3AA19E@icloud.com>
References: <5E3AD305-8461-496F-B165-7734D400C4A6@icloud.com>
 <1efe92ee-6ae0-4588-ba67-b7632c7ea97e@app.fastmail.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
X-Mailer: Apple Mail (2.3731.500.231)
X-Proofpoint-GUID: 4lPIgqK_CE18-KH8LxO889cxfNcWkdxI
X-Proofpoint-ORIG-GUID: 4lPIgqK_CE18-KH8LxO889cxfNcWkdxI
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2305110034
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Interestingly, I just tried the same on a personal laptop with a fully =
up-to-date version of git, and I get a more descriptive error:

$ git rebase --continue
error: invalid onto: =E2=80=98bdb3861a5176d64862366d702dd5abd396b18ab4'

Not sure what the cause is for the difference in error messages, we =
appear to be using the same version, but the issue appears to still be =
present in the most recent release of git regardless.

[System Info]
git version:
git version 2.40.1
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.4.0 Darwin Kernel Version 22.4.0: Mon Mar  6 20:59:28 =
PST 2023; root:xnu-8796.101.5~3/RELEASE_ARM64_T6000 arm64
compiler info: clang: 14.0.3 (clang-1403.0.22.14.1)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]

> On May 10, 2023, at 2:35 PM, Kristoffer Haugsbakk =
<code@khaugsbakk.name> wrote:
>=20
> On Wed, May 10, 2023, at 22:08, Christopher Fretz wrote:
>> Thank you for filling out a Git bug report!
>=20
> I get a more generic error:
>=20
>    $ git rebase --continue
>    fatal: No rebase in progress?
>=20
> [System Info]
> git version:
> git version 2.40.1
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.4.0-148-generic #165~18.04.1-Ubuntu SMP Thu Apr 20 =
01:14:06 UTC 2023 x86_64
> compiler info: gnuc: 7.5
> libc info: glibc: 2.27
> $SHELL (typically, interactive shell): /bin/bash
>=20
>=20
> [Enabled Hooks]
>=20
> --=20
> Kristoffer Haugsbakk

