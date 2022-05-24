Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A45C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 19:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236789AbiEXTJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 15:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiEXTJl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 15:09:41 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2075.outbound.protection.outlook.com [40.92.98.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC23220CD
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzEGoHVJRsoCmcVNy4SDxtu36BR5Z/UiCHr+tSovb2dAsoJ1vP6cDynTsf+pypIZI9GIXr7U7GiZblwaUdbzfF1YSaqRXy8WErWLr4bX/tkAAMsCLNfGYmdarw4ekkz8Bv7L0a5At+V4uyBM/G2qDEE+EW+w6qdRUtLOF5ETd0H2ht6+mgEm7mQqeveOLpgyopmaSjdQpOTMTHi9+SdTPQtcCj6z8C3fJq6RABy2AcsA1amia0jj+qgMUq9XaDT/a8r0kwchv1pZz8wVeqUJ7kcTxZW8Y7dsAPukTABtlTXFLt0f+WYhBBmnMo197VPlDpvWv9XKMIMtSb6GCvHzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlHtI53yjsYz6j6xpACb4Zrc78JobKNeMA1boiTe8fM=;
 b=SWVpePBnFfZuxESSPTGpFz8HJK6ywIES/2TIQqBGJWz3tFrLTvSym7LkrsCk3DjQPQ3oNrOYYkydYk6zgQw2MaEtHNWxoQq5P8r7Xsf/y1JyYUlOAOsNxu6Kc2a/Z0k3CKcqvrZE1/jNwW2iaaYdi0VbP9vyZ6we7hxepgnx1cMt4NH3zkvDBXF8jSSpcZBBf795kvRzlrAmpPDm006KlxDoH+lLSoUwrxVVo36vCEYERXB2pBNU9hANiPOH702KIqfKtKweDuJseD/esoizzqGMTI8CdgnG1/F7SpyWrrBCuJqqB5y4xLzI1ucy75VZbsRs2Al4riQAewn7B4Haaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlHtI53yjsYz6j6xpACb4Zrc78JobKNeMA1boiTe8fM=;
 b=Ibv8MrLXv5XQkDykZ3zqmkGZrmVF9Jn4FSgkrpuUqm0jp4tYBa1pqjNPCdluLvSx+InTltUqcwMDWoU+vANXwpROpw/27ulRCYGjLzlHtHmGz0NAOBAJI5mHC9lRIJ/e28ANj3Bax5CX83q0x/y4EeoZLRxFg0ag2m8leu94MGWlEFDAzzlqDlcyCjkpmrfQm6t5q5kgWnf+N0TFZDcZUX0ttGG9+4UHaGg1w1rUkNJp7BhW462Go9Omnm9MDoi/NCBnI8H8p6IsmIzRS0vUyhaNnxCPmmnFOoaM5Y84uRh5hAoA5pwF/CocUr2MV8dFO8zOeL8oWknabZm/vDMkwg==
Received: from OSYP286MB0262.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:88::16)
 by OS3P286MB1160.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:123::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 19:09:38 +0000
Received: from OSYP286MB0262.JPNP286.PROD.OUTLOOK.COM
 ([fe80::849e:40ad:6c61:7ed4]) by OSYP286MB0262.JPNP286.PROD.OUTLOOK.COM
 ([fe80::849e:40ad:6c61:7ed4%5]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 19:09:37 +0000
From:   Yuyi Wang <Strawberry_Str@hotmail.com>
To:     johannes.schindelin@gmx.de
Cc:     Strawberry_Str@hotmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, sibisiddharthan.github@gmail.com
Subject: Re: [PATCH] Remove (_)UNICODE def on Windows in CMakeLists.txt
Date:   Wed, 25 May 2022 03:09:03 +0800
Message-ID: <OSYP286MB0262561439C0C7F0265A749FF8D79@OSYP286MB0262.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <nycvar.QRO.7.76.6.2205242046470.352@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2205242046470.352@tvgsbejvaqbjf.bet>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [1ICYjblBHA9Cp7hPS+TGa8tJDtXuN2kIZnlHtdvdBtdL4gpolQGNFMG9COe/NA6o]
X-ClientProxiedBy: HK2PR02CA0216.apcprd02.prod.outlook.com
 (2603:1096:201:20::28) To OSYP286MB0262.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:88::16)
X-Microsoft-Original-Message-ID: <20220524190904.740-1-Strawberry_Str@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63d8b4b7-3d81-4fde-b8cf-08da3db8f261
X-MS-Exchange-SLBlob-MailProps: uIjBWfsAVx/XZ2ZsthWYIUnBsFDVT9EKe0uC/ym2CAZ3NkeE9xv0laZHho89mXYKGYH4RcRlG2862/5stprYhuxheeD6/Fmb2A8ruNE4LIqXIge3PS0/L7NkNLOVc96YQfCYhpbQkJYXMo6O8TXpzbDChp05cPhVe0R6qvlG2bLEXJMZIJTmLsWUlsXVpF1zpCspbMBfFskNFFpnrxPaOHAsuOHY5LAr5booYtb2Zmg1JLFZOl+GFF4K9gTMqtw+c6rYCUzuS5IlCIkv45mbfZKdqbJB2Ml5AfJeWpBX25fKokaGmtRXPvdP7DMD/qvOFUnAxO/zfMPkDgqqCsKL+JEE1zLPuWp9t56h4eM+G+zdXuzyMwDFrnMV0MpVmSiASUSbM305H5Sm/EDuC8Ng53TygsRUWymZJl3z3w0/+6yrB+xky6g69z8AB2gPivCBRzenrgxOP+xEtykW/P82gOhvWOuGFMMUIWDhBVM1PfguyqxEMYjh/u3lb8lB/CKoWnp/d+5FNt1KzmV4gJH2DTwlqrFTrU5Fai7I5exWoNhVw395jiYgT/sl5/t8CEQuqvU7Xk2SU2eDS4FMdHMGEyv2YsjdBefpDn8vq2qyynjo5YX3eXpneshGD1fVBFU0PGZ6c0Zs9a+wkKwF4RPXfuACQSC0PBth8Y/MuUl3GP3oL5jaEyeKz4ZBN8bPuuPrvEBrdKcKZLc4257xGxLglw==
X-MS-TrafficTypeDiagnostic: OS3P286MB1160:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0v88cY26BpuYwjTQxh1bpDGIQH6cCW0/5t8ccgfnEuQPr+2hBlz+SBYoHw3ACyHMiMu9tFQA2QOA7Jj1XILJ7ODaMNC5IWdEYtulzLjs9Bui3qzNfrw0HwOQsyxItVsY0s3s8JL1C1VQgcQhcx+Gt8hVFdCiph97uPPxQZEIkOppiQAFL3P4V1paNa64kSB2m8U+cGhEAvsflOpueT2cNiHtv13n9wl/HNnHGIcQF5dE32TLpQVqtyL7VUDTMBcfIUO6r/XNqvzrC5e3d7sRjMSOMjZ2ZZSq0SSdePwnx08lARKauQIqipm21OLJPsdiyGFSqZQxBDgbT7VDB3r8gZo7vmG9y26Z/RLh/haLQW9pbO60iwrZ+mlwyh2MD2xUqlA1OaL1ntURFOjnWdE132T+N9dx0dtex6M7j7BNRXHy/MiYEYr5HZU2A/XLV1Aj+ODvOFO5zgQWYUyfUWLWiiWzhqPnoDF/eVsqugG46yM3EMOBlHjmNdCNcpNJYV2wgnGBZRzjZmhbmnz3jHxTLiJJuF2saF7Q4eqD79GS65X3qdmLVOLEB5Ov6N+v2vVgj3AmKXNGQRYDsiuE7M+OQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KoIZvuB5H+4X8jDCLWvXBhLXTcPMR9zm8r1WQSXCe4wqBhyeJhL48qnq1B4q?=
 =?us-ascii?Q?eiwcunzag4i27LexzfZeW1GAcE8v2bkq1g9kyfXz8sf7uwxpjynCY/6mfYE7?=
 =?us-ascii?Q?5xwiX392GKDxxjS5jkEES8TnKnTRHBW8yX9i4C0hvCDf1X59cPDtHanVzTe5?=
 =?us-ascii?Q?Dg+xK/+pP4N5wYO2Bw6USY7Ipva8IKJr3PZn8L2Z0QXBikrIFF6Rew0A9mG7?=
 =?us-ascii?Q?vSLH/4rAoZ+rmtB43nl1oydORRJF+HUI38GPAL31yxwjMrecsYtYWc1NClxB?=
 =?us-ascii?Q?3WbEH23INNnRzmlvvdswkip3zk+UM2P3pWDkIfRhkOEbgd6f6cyKyz62NwO4?=
 =?us-ascii?Q?XnhaqYIdYUNyrbSZUR16RhfU5SFRAZ2pP2jdbDS9fR+6azx1Ggzn2WPYxb9F?=
 =?us-ascii?Q?+JI0ALD+BR2+F3BRedCP7zdxlL75G+nzv2VAghmnCePKLoK8RE5BJBExeWJq?=
 =?us-ascii?Q?ArsWXo5NR0I+KnS48R2mX8XaXSrGMG1ET2jYd6GA7NxM3mKiC0BTVRnYMGtG?=
 =?us-ascii?Q?7Jl5h0E3h6o/97TNYLEPhiy/3SuqKUSb84K7yDxTHX3GupWz/kelfZJ7ZNEl?=
 =?us-ascii?Q?S1iJnYqE24rstx3bXyrUtoTquGW/phT6q+wPY6HNx5Ntq50XW4PzEgXqvhIb?=
 =?us-ascii?Q?POgwEzw9k5hPCMVkXRpW9RrSZ3JeTvFd8DUZBIiHGODvQCSpMwZ4GxPuRQFC?=
 =?us-ascii?Q?7jBlOYs8N4MpgQobyRj7w1/lebZ2WwXi/HLmwjgnHMW9/gt/T69RFfluHxWD?=
 =?us-ascii?Q?kEdtgDjVPgKlzOzCQdmn7jj20rRWZryqW0EjyW2DRp6BfnDI4fDwdKVz5fOy?=
 =?us-ascii?Q?Btd6kLh7zGG2cHECGDGLwdFYphqbQkCUGR9ZbRHZpx8zdntOp5kTG1wdGMe7?=
 =?us-ascii?Q?NYJxvUCHOYCEXSrwef+wVYoxNY/yWZrayRa3XU+675YrBDXbjKddlWExSm+v?=
 =?us-ascii?Q?PHMtM1D9IlKIZvP7+fKEEVr0BaL5VHiUDANDzc+qcymjHJxPKwC/wNAIK7VQ?=
 =?us-ascii?Q?fOeAl5fTwdEiscKQT47MId5Bxkw9SSf6UESxq0voA2vqkhPMsgE2I1Q2uhA2?=
 =?us-ascii?Q?CtDozmFgXFc3M6iuANx5jqNTCsPjAGNcoqVrBUfr09O7wzO/TrQqRK40HOwb?=
 =?us-ascii?Q?E4mMPI3tObOv5YGbWEPq/WU8cECjy7b8FiWko3cUBwyL36YhmR/cXI6P2zws?=
 =?us-ascii?Q?Mn0Rj0VC20hmabO30gkrnNnYQ0sX3fzsv6/8CI7iKgv1xzeE969FpJIEVuex?=
 =?us-ascii?Q?cCArC4Hx1T70PdXv/xB3sfGd8/2bO1+ohT+EQWF5+88Vh5VpsE+C64Ewo0aH?=
 =?us-ascii?Q?9O3j4CgAphrKjhjGsn0LTvnQP7sL1KlEbxsyf1z5H3Vjlip6ljc/GZ99HQEr?=
 =?us-ascii?Q?DqlcseLHwrLZ+smAL0nCSt+TZxbqsxX/abVKBCiIF61MLeqJwTSHkGRnj6y+?=
 =?us-ascii?Q?j3BV15huvRkl4PghfNZYLHj4kOHm/GvEGMz+laQw+FhLipcv6KNfgQFS35pR?=
 =?us-ascii?Q?0mvxt7OJn6VofPg=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d8b4b7-3d81-4fde-b8cf-08da3db8f261
X-MS-Exchange-CrossTenant-AuthSource: OSYP286MB0262.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 19:09:37.9406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1160
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> P.S.: Please note that the Git mailing list silently drops all mails from
> @hotmail.com addresses, as far as I remember. Therefore, if you reply, it
> may never reach the list.

Thanks for your remind! However, it seems that my reply reaches the list
successfully with hotmail address.
