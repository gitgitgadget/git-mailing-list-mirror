Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA2AC76196
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 12:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjCYMbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 08:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjCYMbV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 08:31:21 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2085.outbound.protection.outlook.com [40.92.22.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F13311153
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 05:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oST+SO5XnrcK1DdCDKtywf0+VmIjK5kxOU8dOnOUorfXqdurUV8uVjMGmlztH69cCp7PQ6Nx6ZLyO6NAPs+MFbZ7a0jM7WJuLlmfOn625j/LIs9MHt6Ddg07mJeIuJbsB2EoC1KRa9J/4u8zxL7Be4xVH/tIZcj8JDfJYjAKo25wYskLfOLM961MKfMSRQYOWVX+lV5Q3Ta42jO6tq995pO3HdriY2y1FTXkzcXLxc8aXZDhC9+QXuvWQw/YisBFycveoGx+wZWGgkXubtGSeZjoIAkwYG6ZgWigi/SXbszsROTqKQwimSV/MLMawpZyaxS5Fyv+IZk+swSmhy0/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2em/7kap0NIuDnnLMtcEiaVUbr9gvhxRuPI0Glm7E64=;
 b=kLcLe+cFaDn7a5p75PUviNSExurerhIg0QSHX3yt+fdFRpuCv+55ZKVFKaR5Y4iNfq4yWWo2YEpgSnID7SA9J38+qp5rviZ9x+RUr8BUkuhYCkpvnv/fPWHKZGZv5gBDqzr0pW8EXJXK93FMH5S9Qm9iSyB03fIg2fNkH5OfwItGvKeW1n/aHAGVTe/JFTYJh/EeI7WGshBKjNIspzWWqgV1TlCbPoJ4HSAL3SRnFiYVZyn6L5RmdwDUg/28GsYp6axp5oIgmHeWzOiIlbbAoPD/iMt6TVa8EYsdv6Q5olWDCUS7h1UOn+5JvmPHwE+YJGsvVSz4hceJAWEOsFOwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2em/7kap0NIuDnnLMtcEiaVUbr9gvhxRuPI0Glm7E64=;
 b=PIgwADWflnsndgvr+oZGHwTi6+c1GbpE6j+TdwMPlxOk8AaFYQkI0Wh9iu4J83wF7nchycG1DcaAwd8XmLCDhcT0M0n3SRD4Qel6x+ERcrlu5U68b4mLxt6aALPzUxUA43NFTVI4noIZCNwqUTedWlT4GADXUHMBMuMTOJm+/w/mwjucrloDCLOYHxmLI2YdFZLv5rC9tkEGxKDL1jqRupaulW8QQSmyAScLLPnbhcERPTvtT5R3F9wKnDBNUO9nAVHyDD3EJHshksnv+fkkLZul1AQrwKr7jMaBtupm5uBBaLPqf7HpOqYux2NOBlqHNVh9J/FkQeLgxcOUWAe0rQ==
Received: from MW4PR20MB5517.namprd20.prod.outlook.com (2603:10b6:303:22e::15)
 by MW3PR20MB3483.namprd20.prod.outlook.com (2603:10b6:303:5b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sat, 25 Mar
 2023 12:31:18 +0000
Received: from MW4PR20MB5517.namprd20.prod.outlook.com
 ([fe80::ae9:1282:c6ba:d6d7]) by MW4PR20MB5517.namprd20.prod.outlook.com
 ([fe80::ae9:1282:c6ba:d6d7%8]) with mapi id 15.20.6222.010; Sat, 25 Mar 2023
 12:31:18 +0000
From:   Mario Grgic <mario_grgic@hotmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: git bug: Perl compatible regular expressions do not work as expected
Message-ID: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
Date:   Sat, 25 Mar 2023 08:31:15 -0400
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-TMN:  [wH0wauXpuEfjdr8X3S6aAbrvuh7WdxD6]
X-ClientProxiedBy: YQBPR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::12) To MW4PR20MB5517.namprd20.prod.outlook.com
 (2603:10b6:303:22e::15)
X-Microsoft-Original-Message-ID: <C3415C6B-D1F0-48A1-BBD4-CACA445B7C18@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR20MB5517:EE_|MW3PR20MB3483:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d05a6d-c70d-40cd-38dd-08db2d2cd544
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7CYkRCwuhEi+0EwNXgdaChZKmWBI3lxwTOggWIpXhR7tEFz+bOggZxT5RwP62fPXq2pJ+VSWmgyr7npGBMsqWf4FiewJ01XqiBlkf+GghdVq6HDIbjAH9WpwtbmVFD0/umzj5p4Xa4/qQetSRcVmnbPI72SU06AFC/tPrGygSF4Igr4iMyt7Mb5/gmXx1JVSvv8rQ9LmS+CWzDD4QlA7m1k0S5V22JUO78smeKQvAyt+szITzEdX48IXoZvWHdAaHRVjBsFVp7tCwpr2rqpCIW/w4vzxgnHyaULx8p9yClv1Y9SQgUymd6DRGMs/I40mWkzhmAIShx0bPM+1gUoJqidl8VDN6y+0O+0QKtR9vorTn7zIIRtq0UXVMJlLbUazB8Ih9r9EwAz8nB8vFj4hvYvmuG0fv576rW5ymscxVRDmVaFSCTSJeiFe+HZj1VzXdT1CfGq2XnOOZpTNXadQ0fe7fCaxuBhtAyRysvtfez4UnD6DkgB0crqNRe5zvAIQ0jGA42pp4wjKBLgAmRdRh6AYTUZ4pNO9H+Xy3VeHr9mW4KbVHa5U2/h7zdThaZDD
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AgEhqIoacx1XVFCOkagCzd5kfoBnZrGO/gznPT53Dn4ZcUexCVRavzvBn8VA?=
 =?us-ascii?Q?5dNSvg178nNlKjHeB82+baP/FDt7IrqOAUzZP1OV8EzhfAZhJAc/UqN7hVCu?=
 =?us-ascii?Q?JspplqVcCuofQAeGWE2Dx9nZKMvfJ3YHwxXiDugTAvVlzyUbK09A7I0VhtXj?=
 =?us-ascii?Q?NNNzztLe3nyv/IdRGTy3+bgFs8Nq+D8g2fl/TQxorZF5eBaxgId2peouxYFn?=
 =?us-ascii?Q?AEaI3mMeex08n6VWJut3/Q/F7P4YGW4N4r014MZ3fnWYSgxdvsZannd+VPvq?=
 =?us-ascii?Q?MZORyTBbWSSD24z3dAr7+EytZznpL1ayH14rG9BJKdfHU7C6hQbs21S/y69c?=
 =?us-ascii?Q?V1uZK5kO87QjrASp0Hge6mZuib50xrammwOUNugKaGtA+kZZv+/RnDOUqxdX?=
 =?us-ascii?Q?DslsmJteWtEGvxFYn8YZu2Jqt7Mckf5ECsYuSPg7jnPWIH1ib3TkYWmLrXD1?=
 =?us-ascii?Q?CyHpchMFtsrnkoTKV0H6TBwk5teHd/wgXraqgFaNsg5R2qiZJiekFASuU0kI?=
 =?us-ascii?Q?NOWd6wbywNz65cTARH1mUofelcIwFsySOmNwNmEb0Pw7mp6Pr6xaD1ZgGtuH?=
 =?us-ascii?Q?5TBseEakhptIqoEMfrv+ElcXRf+Ov3Ayth6TOw5HuD6Yibi9jobzYBcgAwDV?=
 =?us-ascii?Q?5dD3LAuyxm0BILvnN3URdVryTGQEmVc0kTaiPrGTKv7br9RZ8bwb+RkoxNMX?=
 =?us-ascii?Q?WGQu4Z5EtzR7J8N8wqeGNJVOmT33nB+zvr52tTKzY6LAwAVDKTlyAGbzm9lu?=
 =?us-ascii?Q?3GQr9A2bex7CSPUCZ3Wu92He4kDMWm0Rz9gG+ghXHuXzIjGTXHLpcJCMqy4B?=
 =?us-ascii?Q?aOULc/pS9buVjaBlfQFCQap+3KZ2S0PBKLbzJnN/nshqqEEJiEU+gf7qCL9g?=
 =?us-ascii?Q?MIZ5Itx1evLvuFGMCkuwz9BgWZ0+3ObFM7OPU4Hd+gvT1ZO+etSSUf7M+/oF?=
 =?us-ascii?Q?sgjlQt1tyZs+dgouNU2i8+rR56ZksGCKq+hrvXbzKSiG2Ib+gPtWnrxUEonn?=
 =?us-ascii?Q?6zMPfXrwhbvW3OFBT2/Yt8UhKxcNIKtZcTfqYiqYuLY0NjeyBuDmsPKiRoDj?=
 =?us-ascii?Q?0d4BcnW8xy44u8Sv/XKlKTWsMfRyUnyTA0Yol45tqM+aCxIVLg5VKBrEXFGi?=
 =?us-ascii?Q?DgDeUeHY9sv+Gce6jXLpJk04q0SqX3P2DyB4c65aOTA4UmIQak/z05nzg/XH?=
 =?us-ascii?Q?xbmf69ekH9ukCzzMZDwllVkfBvjJ4qZkgBtSoM2MgY8WkorchYo67l62FF8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-9803a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d05a6d-c70d-40cd-38dd-08db2d2cd544
X-MS-Exchange-CrossTenant-AuthSource: MW4PR20MB5517.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2023 12:31:18.6562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR20MB3483
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Initilize a new git repo, create a simple C file that you commit into the n=
ew
repo. Then search the git history using Perl compatible regular expression.=
=20

Basically,

mkdir test
cd test
git init

Create a file=20

cat <<END > test.c
int main(int argc, const char *argv[])
{
    return 0;
}
END=20

git commit -m 'added test file'

Then run:

git log --all -p -G '\bmain\b'

git is compiled with pcre2 library support but does not find main word in t=
he
file we just added.


What did you expect to happen? (Expected behavior)
git compiled with pcre2 library should support Perl compatible regular
expressions

What happened instead? (Actual behavior)
Nothing is found, when in fact the search for term is present in the git
history

What's different between what you expected and what actually happened?
git should print out the commit containing the search term.

Anything else you want to add:

git was compiled with pcre2 library. Here is output of otool -L

$ otool -L git
git:
	/System/Library/Frameworks/CoreServices.framework/Versions/A/CoreServices =
(compatibility version 1.0.0, current version 1069.24.0)
	/usr/local/lib/libpcre2-8.0.dylib (compatibility version 12.0.0, current v=
ersion 12.2.0)
	/usr/local/lib/libz.1.dylib (compatibility version 1.0.0, current version =
1.2.13)
	/usr/lib/libiconv.2.dylib (compatibility version 7.0.0, current version 7.=
0.0)
	/usr/local/lib/libintl.8.dylib (compatibility version 11.0.0, current vers=
ion 11.0.0)
	/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1=
281.100.1)
	/System/Library/Frameworks/CoreFoundation.framework/Versions/A/CoreFoundat=
ion (compatibility version 150.0.0, current version 1677.104.0)
	/usr/lib/libcharset.1.dylib (compatibility version 2.0.0, current version =
2.0.0)


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.40.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 19.6.0 Darwin Kernel Version 19.6.0: Tue Jun 21 21:18:39 PDT =
2022; root:xnu-6153.141.66~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.0 (clang-1200.0.32.21)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show

