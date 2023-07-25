Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845C1EB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 00:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjGYADf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 20:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGYADe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 20:03:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2038.outbound.protection.outlook.com [40.92.42.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5100F172B
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 17:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWwpzC9RK6+Ci7ibGDH/Itt9wAQ67mgGNgUxE2gPFcntiL543dDpYT/086sAG+sgaumgqjs16iKj/i0G4mYii+XoZBKXX9lI9676Di2r/g4gZy7iusDCahbrf2hxOR39WFuID3KRFoTgVxgN6AaWWYsA3HKaHzRBZGQ7whhxFX1Ozm/FWF8FghMtDsdU+yxqBTupWTIbi+SycG5BUWBq2BN0Ra4p0wP0bryMwdFAuP/+zCH6Qm22iCEh6mEzlrqnSiBWpsK7FSkidsWUxPS2jb/5JCduqU+KsAAt3oqpNX6RrF3Ye7eBIfRUYxERzbE7bxEok2TDE4dW7x3OcXO83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBVc32Uj+GLlVMIOm7mdh7Ly3sna4Abkf9oFSxiVtl4=;
 b=lY+pC410Glf8KO/ne8/1WDbJJ503Qvv818q9mLTXG4+pTeLCgFaYanPkgEeSnMDM2iw9gfcI6WNW66Vv7f4rQbJn9bCmhPwIvxu/lSVxe0NMm2OZES8M7TjQxa9vRKLYaJi/WkjC7eAgD25XzDeGIipMwQ/B6GumBbpudhkBV59meQPSNVqVXuyWIg4Xuugvnp7ISZTPdsz+4dKxrxOWk7dxaLF3he71kqh/mmH6poYWGl4edCQbnyVUG3GvVFex+7xI9TGLPCycZcGHMplNT/i7qIsEjol96xUuvEMq//zwRsZ7uRH1NRLwY6dbNZOHAcDr3ASE1bHz8sbbCT5F+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBVc32Uj+GLlVMIOm7mdh7Ly3sna4Abkf9oFSxiVtl4=;
 b=TAdBfnUQUZFFsJ20dYvC3xGyqCuiWmQwS/AP6Rx7zcRSEcz9YD+tFsDl93CbOSbkhf3h+mkH9boCCDqbuSQX53/HaCRz0SFDY23Y5bOMsdp88nsoUdbPJEY4fjQ9suX5VVcysZJyPHUa5OuWt1cLJzbKyQVjaYiSIp6sNHZU9DEBETZK0nUHk57LSKaxjFoPQ032uYq8Ue6R1TfNPoewkyvynDszYjoOWyBishvfP7TiAlcC+/2Je4egxLvYaH6Bpxo8wJHVjLX8qjvZxbl+Bdl09f2j+H5zFUweKnurJaO0OXOncolYAfE9MHypbZ+S46m3DKGOPrYpRnBDEhhmBQ==
Received: from PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:1ca::15)
 by CY5P223MB0489.NAMP223.PROD.OUTLOOK.COM (2603:10b6:930:27::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 00:03:31 +0000
Received: from PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM
 ([fe80::e81a:76db:bb79:afdb]) by PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM
 ([fe80::e81a:76db:bb79:afdb%6]) with mapi id 15.20.6609.031; Tue, 25 Jul 2023
 00:03:31 +0000
From:   Benjamin Stein <benji_stein@hotmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug: fetch with deepen shortens history
Thread-Topic: Bug: fetch with deepen shortens history
Thread-Index: AQHZqHR9sgS2ms3/kku5Uykr0OUHyK/JxWJg
Date:   Tue, 25 Jul 2023 00:03:31 +0000
Message-ID: <PH8P223MB0699B4956F3FE9DC736419FA9F03A@PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM>
References: <PH8P223MB06996E110EF25C386AA314E19F26A@PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM>
In-Reply-To: <PH8P223MB06996E110EF25C386AA314E19F26A@PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [Ghy4izefj4fqMU2nHdwlR7DSMvXheAGi]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8P223MB0699:EE_|CY5P223MB0489:EE_
x-ms-office365-filtering-correlation-id: 563869a5-4638-4bad-37fe-08db8ca29512
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: brn1Hce1anocsmbXntIcOJkpAOA/dPCW+N5ok8cPO/C6JifawRZpVHgTZS+/cPGF5PKlcBoFSyRgKHOvxHp3mwmDxFDBdYIiAalFqYAceJF6ktuN3ZdSFRddt9Gd6vPVh9RdCg0vUR1IKyfuqnZDT/O7iX+a9ZYJhXyay7N8ylSkJWG/t3Fh5YJupP1hZlENSRvSwKEUfeV1k68VGWUwxjjfG7xtWH2E2rdBGp/BLZSFW0sRAj2fQciVZSr8kIXDdNxxpXexOkalgqbWJwmX1YVmZJXFC80pvtbIW2KTyVBZ45Cr4wzpQrdjhJWkzSfvEXQuTX8hcqQMHm/3v84CE3BTEhdTFeY9KqIQNjmk3sG6nBmRluIlLcjxQ1JSvTL6N6mYdFxzju11LyTyY+wB9eNTvRPLOxb0CkAC3M4iuMjnqeaepjHFmxMpcW3enIe+uQc4qwsTwF0YF7gqmc7hD37CwELsG4VlD485Vsi/HMpAk6tA+Ihsj9yDfiZnCTqyPT7D7qUH3sZ6lALxaU0zEddQefnk/wruoT+84JvJO1aIBmJElQc1HRBXYGfbwVPc
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Sf8udrHNxQ6oFzKKSLoGvsBq+H1TWgkFtLxR1QJeYSqEZixaKBGPYks++Z?=
 =?iso-8859-1?Q?/qUoKPNzjOrijUoXyIfYoDjA5KCJ/E/IXuXjIor8SqAnkn/1Ode3FnalpL?=
 =?iso-8859-1?Q?0xunnDLkA6qI67C9A9bPctniSB6hfkdkx7xak1UPLxroOFFJCm6j1lHZq0?=
 =?iso-8859-1?Q?jYJBuWTKudmKkaXQ/D0h+aRQSPf8GUELO6Gw8tBiUklLO5fXZtjMXCslcF?=
 =?iso-8859-1?Q?OpRsl6bSPbaEQNJ92iKNcy0ZEqGjcKEiwpDzQq+D8Hl4EPphTktJ838rZf?=
 =?iso-8859-1?Q?zDESLMQEIl7IRLzCwvSDiF1ktS+cHxadgMlcdUOtgea6gbXJogb8RNiahF?=
 =?iso-8859-1?Q?NNu1z2KC59wxyTC4qsx+p4jpwu7TQfOWBqPxD8PW248h6+uoizgCeoCPu3?=
 =?iso-8859-1?Q?uZyCvUZe/VN1NxGAqgctna4b3GdEp8dh6Zo9bYifkqhAPqdbH8ODWSmrci?=
 =?iso-8859-1?Q?w2JY+QOq9MAfgkrIXITs+xpZMZZbXjNfo8d0Cxgy5ExDio/aVpot4pZtdU?=
 =?iso-8859-1?Q?TCDQI8MVKf4pHigqjjc/pt1UFQvXmRKijVUzGfe4p9BGkSDAqxQ3QxA/8a?=
 =?iso-8859-1?Q?ezKXvKyF1aWZS1iNzeRvMrY95N9jnKZxqfhgjUJF4Kfbk5B83h2ch0o9FY?=
 =?iso-8859-1?Q?UgCXNscFMS94QnZ2NOooWdP7ydNozYVJjIi6yWkxLDs5CNugGyQpPmMp6o?=
 =?iso-8859-1?Q?bZqlDTswWxCC0gVDXusn82qv0FUEkeocFiLY0UqHlSGgeVGpa3tTSyYVuD?=
 =?iso-8859-1?Q?dwfx9fiq9n4RFhpLPxA1edjjplUA/0gwOOZm5paQFqfs8Ex6u6ZkRtAPIK?=
 =?iso-8859-1?Q?6s6E5m7rj+vFm0aaTXiQadqgV15M/SxwGaM9n09/W6zzNAjcG1jpGN2wFQ?=
 =?iso-8859-1?Q?zq2yCNExP2m65DhTN01Wvlt+udwcYetHgJdjZ3GCApzHQ9E+24axkQZzBK?=
 =?iso-8859-1?Q?+VHjVTSHX6i3766rIJSdpsBOCY9qsqNjzh/y0EunIwCA/Rwjm4kwX60Hv+?=
 =?iso-8859-1?Q?LPxN+OvoUo9QpkvfJ/SqvDWD2G9B/sU/H1yTvi5lXIYFrQSj5A9f+hUN+w?=
 =?iso-8859-1?Q?L5ExdqoNuoWi0qeqM3379zOZGrOmgEfuXx9HM2pnYspd7KQpWiXwGFVAou?=
 =?iso-8859-1?Q?yElIpiJOKNTngJmTsh8bxuX1WGHMsCI6Cdlbt7CObaQhnqLNyxS+l+9CQb?=
 =?iso-8859-1?Q?APupSbjzIOs/TPe7RMqWwN1HsY+D6LSGC38ejlL73D+T00Z58eFam91JQP?=
 =?iso-8859-1?Q?tnKGyLlEYKXOa/nyPRlw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-1ff67.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8P223MB0699.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 563869a5-4638-4bad-37fe-08db8ca29512
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 00:03:31.6265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5P223MB0489
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hello git gurus,=0A=
=0A=
> Here's an atypical bug report for you. I'm sorry for not starting with th=
e template, but the context/setup are longer =0A=
> than felt useful in that format.=0A=
> =0A=
> I have what I believe to be a (relatively) simple, reproducible test case=
 (repo setup/steps below) around shallow =0A=
> checkouts at merge commits and deepening where the behavior is quite surp=
rising - I end up with a smaller history =0A=
> after a fetch operation than when I started!=0A=
>=0A=
> =A0[...snip...]=0A=
=0A=
Hello again. It's been a month, and I didn't even get a "yes, we tested thi=
s and confirm the problem", so I thought I'd check in on this.=0A=
=0A=
I also found a commit setup where even my "working" solution steps (only us=
ing deepen) still ends up with the unexpected behavior, so I thought I'd ad=
d that in here as a simpler scenario to experiment=A0with. It happens when =
both sides of the merge are the same number of commits to the merge base.=
=0A=
=0A=
Let me know if there's any additional information I can provide or somethin=
g I can do to help resolve.=0A=
=0A=
Thanks,=0A=
Benji=0A=
=0A=
---------simple-bug-setup.sh---------=0A=
set -x=0A=
# Setup working folder for easy cleanup=0A=
mkdir git-test && cd git-test=0A=
=0A=
# Setup repo=0A=
mkdir source-repo &&=A0 cd source-repo=0A=
git init=0A=
git branch -m trunk=0A=
for i in {01..05}; do echo "start${i}" >> start; git add start; git commit =
-m "start${i}"; done=0A=
git branch old-checkpoint=0A=
for i in {01..10}; do echo "new${i}" >> new; git add new; git commit -m "ne=
w${i}"; done=0A=
git checkout -b feature HEAD~4=0A=
for i in {01..03}; do echo "feature${i}" >> feature; git add feature; git c=
ommit -m "feature${i}"; done=0A=
git checkout trunk=0A=
git merge --no-edit feature=0A=
cd ..=0A=
sleep 1=0A=
=0A=
# simple checkout=0A=
git clone --no-local source-repo --depth=3D1 --branch trunk shallow-clone-o=
nly-deepen=0A=
cd shallow-clone-only-deepen=0A=
git remote set-branches --add origin '*'=0A=
git fetch --deepen=3D4 origin HEAD feature # this also works if we use feat=
ure=0A=
git fetch origin --shallow-exclude=3Dold-checkpoint feature=0A=
git log --oneline origin/feature | wc -l # 9, expected=0A=
git fetch --deepen=3D1 origin feature=0A=
git log --oneline origin/feature | wc -l # 4, unexpected=0A=
cd ..=0A=
sleep 1=0A=
=0A=
