Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF459C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbiBCVWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:22:25 -0500
Received: from mail-dm6nam10on2069.outbound.protection.outlook.com ([40.107.93.69]:45654
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232544AbiBCVWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:22:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8TswcgSWkE6C435zEN2nk+e+i/FeZ27cbNTj3FMuuZQeTg660CDX3jvdD1apJqEYdlHw9XeBFYs2wQQ09xGbpQ0lG37BMeQE/dihqd6+oqfeCA7IiSK3qIbls3EYr13UigQkzRGZLlroydiq5budtxoCuDGjtur0EepcKlhemw5LQNLqVgW9rLg4FV/rz6Gm6+WhrOYSnpxXiSOI1Am+DD106Mx1DO2T9M5wyGkqXQkw1RX0d+9Q0peSTcMw0fP7kjlFi07bWCpti7Ycwv1P9Z8MdSNPK9ZVP2IPTcOhP9XoDRj4ePJZwQj3loTiP1+pc2pqKKA2RIt9tiaRaBKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2nzn3TJogpjCILlOpah4zJuq8xe3nTycYWhFUcCeK8=;
 b=nvXgtzehW1HxJWRinBYciA/moeWic5bT7eDLGKKTHByTgLPPo0+nqZ1o35RPVDqHHHNo7GvgOtJZAvuS7cT+X79VCkKjT8MiVHqRU+90XRfnEPqizj+x0HeKWxqabL/lg9tccGIwsKEJrj2YE/UvwZQzEmA/Sl1UiRxdBcmhjG1MKIEbjrJtdJOgWflRkdEKLpSq2tViry/RHslCqhl3wMcYm5LLVa4o9rHcgGack7RleYmR+EiG+UpnxlIxyEq5FAqkCi358XwDk6WBXDkYar9ymMQJ6iTVazNHDBmJKoq6qRR6KgZCVhNFljlv259AYktrfItfhF3GRI815719+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2nzn3TJogpjCILlOpah4zJuq8xe3nTycYWhFUcCeK8=;
 b=cbbFynuUPOyVsAoeKFYv2BubmyH0BDCTdIzzZkS/CZGJlf5ow0mIgkbmWpg+ZMzwXWdPgKk0PQCXLNtqbVLGYPFiG3TnhZ5t/kVRmd7BJzgBjQbi/7bUMhe+GBguL/hDV86qq51464P6v+InWC0ZyaXJsTTtoTMsAx3Rr9yKUiwB0qpcoXSJ00mqZwMXjObDv7tJXQKMlgrraJX09/CxfnBEkKr17ZUB0VyrGg+zA4W9kNM6bII3UNv9zrKkFDGF7LCwCkZNiwoaquxqDexSgT1SFKrKxvJIG1U8a5c0l9pYmayLKz4ujseY28LUyOXS8fgfO8uTKIm6ZDd+cyLppw==
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MW2PR12MB2444.namprd12.prod.outlook.com (2603:10b6:907:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Thu, 3 Feb
 2022 21:22:23 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 21:22:22 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: RE: [PATCH v3 00/21] git-p4: Various code tidy-ups
Thread-Topic: [PATCH v3 00/21] git-p4: Various code tidy-ups
Thread-Index: AQHYCvMfiIWdPzVYr0K1RMgJMRPAl6xmbsy/gBwAJqA=
Date:   Thu, 3 Feb 2022 21:22:22 +0000
Message-ID: <BL0PR12MB4849847CD8385F0FABD9AE95C8289@BL0PR12MB4849.namprd12.prod.outlook.com>
References: <20220116160550.514637-1-jholdsworth@nvidia.com>
 <xmqqr197xi0b.fsf@gitster.g>
In-Reply-To: <xmqqr197xi0b.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2db5cb68-75d6-4d00-44a4-08d9e75b446a
x-ms-traffictypediagnostic: MW2PR12MB2444:EE_
x-microsoft-antispam-prvs: <MW2PR12MB244438E74CF41EF6FDF4197FC8289@MW2PR12MB2444.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I/qG8AOH03lwb8O9UXdh2BmDdtkXg7RhJSEZt+faMPBaM3TcEiDWCUesI071SlG1+IzI3BTcQ8wuWwwyJ6dcOmcxO7I7sCs5We2Hal86Zq2sopt4TPdNBx2Lq1VEpAQXFOH6G4PX8zVNzh8bMskG2073iu75tVPv6RriLsE7BU1g/23YqN8uIGzQNv5XH08xYkKjpZDbBuGFUOjjKoRaqIXf0yIueXLxwesCiqYYV2I/kwgf4TXVbgKYVeCkzbi+DEj7VdryeDLOYgqpi23uZKvWnZLxUvqwApHTwrNANU3/jR0kFcJf8WFtccgI/C3x/STTDPFQqhLgPTKD6qbD/zR+JH2QRZeoDUPVyiYgwaLGO7FVBUvDw2oOHnDqnFoGEuptCd6u6BN/952Qp9xnxKwfMXXz5ypd/JjBnAVJrAzMpRo0huQdzT1IGDGhdowAqur9Q7MV9AcxRnTgqhBGfNelf4LImANDqwPeztXonsIdhqxzBnxBN/r+D7rHQ07+ClVj2GtayrNHstddHqk4s2OBSFARqHwYmKbocGPIAlYzsd7Ra7qpk96tOve9GsJ9o6feQci4DELivvXjbh1PSud1f7jBMxkCWrA+iEahuHPGFBJDdEJQcKBwAQgmaWfFatmlwz8uYOJP5BHkSPB0sI5o0wU/1BQ5RA3dde5C/G2nhwC+iPkwcNorf57+3ZDEEX0Ulo7CWngITafB390lSU5zWwO5pR92dPlbgdOQxTpj9HcBUJIc/puw3FVYu1YKxfys8sA1yTY10Z88XMXmka/rx1U+Aw73j7JWuprwJlU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(186003)(55016003)(2906002)(122000001)(38070700005)(26005)(83380400001)(7696005)(54906003)(71200400001)(8676002)(5660300002)(76116006)(316002)(966005)(66946007)(6916009)(508600001)(66446008)(66556008)(64756008)(66476007)(7416002)(9686003)(4326008)(8936002)(86362001)(52536014)(38100700002)(6506007)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pM7GHvXimrpekmPf18JfHG+l4LmibJh+F2YLo0otjB1BfH++QV1WbqtNJAe7?=
 =?us-ascii?Q?NIwWPZv2rBFVnf/WWhgOnKLuZxx4P6iCfi7N44KjPWJuKM/5QH8kdi8AMlIJ?=
 =?us-ascii?Q?TpWPV7PzJfWOifi3eYCVpxD1zvi8QveFTZo155TqfwOn8/ECZMA7+b4YJ+NK?=
 =?us-ascii?Q?3cnlJWZxmjh6fL/JcVnkIRjCEWGcK0Fyy/JyIwEUzoi7YS5yCWbVajm4/YKT?=
 =?us-ascii?Q?8r+3kCoL1B671tlQBEPsfO3b939mhWm88MhuXlOwSDWutLvI2VoPRSRxUxHj?=
 =?us-ascii?Q?aJc0J3ow4ss+nsWekRFR+zqSwn/yu2okg8zmlqeaCDhaSv9HUtIcOHBtoHGw?=
 =?us-ascii?Q?ZEI5Zwatzpyul4kPVw8a50K4MbPqpe8OWwHdGTYbVeSogcn55AWgXa1wbA2C?=
 =?us-ascii?Q?qMbExbuV6MMbvfbKrzFMbJXE5KdDbCzV/hgkC0Bne8Ajbrcy/kgsifkta6w2?=
 =?us-ascii?Q?CilbrX7Eb7XaZGknFvi7GlounLYiYhBZtDN8PycIQ2IC8f0sJLjZ4Qb70Hz9?=
 =?us-ascii?Q?8iZFHQrSIVZrOA8eVux2iVGQJospLwjDeX2MNqYBQggDn66ZvjjMRhgJE9Sm?=
 =?us-ascii?Q?DskNMeAhJv1rIvBXbikRuYQo91EjUHDnbcOiJSmvsUAjn6JTUm2VXycCE2gt?=
 =?us-ascii?Q?RBCfnXDMtGefOoPDp2NLVsli3u8FcPwwe+Bv1iGdMouMK0n7zgCCLDaQ9ICb?=
 =?us-ascii?Q?LP/J0rJdKt+G9VkPM0gufB84kjccDDZB9829e5JjXjCJyeTg/3VSZjEEOw3D?=
 =?us-ascii?Q?8es9BucJeoZ+N7VlTmAmuuzMH0mSUcLLWcaD8cll/aVB9dJNFhyGGiD8FHPT?=
 =?us-ascii?Q?LNUQOgqwpxUHz7rvAmOvFVoxMH69Vvx6u2VYCAr1GQEMC6ClKYJTHld8FkiJ?=
 =?us-ascii?Q?gUo4w6FRDrxKkJUPK1ST59lNmNPpcZyxl07/lPBuV5cb+/E6JBId++hGSFqv?=
 =?us-ascii?Q?2Bm9C8vHtCTYHWWQ6yiB267bb8i2NZQK0bjIAlooIo8urIJgmb1AYP56mhUw?=
 =?us-ascii?Q?ikwyMWDQl32C3C3DscuZOEDdOivJx5D4Ls1BVMuUoU4khZ0PxgHAeXakozCi?=
 =?us-ascii?Q?gZn5TBp8bFse2reBR8YguvGjEGHNnJwqL5Hq9e0KanEDKwAKPHuvc8pyJUHD?=
 =?us-ascii?Q?gwJ6UJGJQHxESlxnlx/4A5i3tGojAp2crwx5ZOvX6O1ki7Qge/x+z7wZ+cP8?=
 =?us-ascii?Q?koQ/h1JlTOXiqn3A+eVC2QL2s6dOWpQeQbetebklDvIJ/1R6uGCeRmZQ5LmW?=
 =?us-ascii?Q?O/7wrk/XBiB6F1QcM2dyiMG8nZbIpR3q0PnGCffef4/u+Mjb9IW3Qs5QzDE6?=
 =?us-ascii?Q?hnU/LlVNy9vq54rOTsXLcrYgHVzkOllnCYrBFQh7kVxcI5qbveBt7b+qrcDp?=
 =?us-ascii?Q?eFIENe32jTz6N9Nhugh27wRmc+06uu5nB4j8YNEdfFg/AOTmCRbnqdRluw7+?=
 =?us-ascii?Q?PJyOUMdXz8BCraCysrsU4NYDQdonTtUk1DB2OynA9k44aJzouminmz9jO8EV?=
 =?us-ascii?Q?ZAUPR+1lIjp9+8m+5iKZMhYsykpTLEszv549J4HCCcdaQmkhGEcgMRaRfUBO?=
 =?us-ascii?Q?ysT3a0MQeHAeG+qc7FS1XkQdkv3AVkan4ODiyJuX86q9anXBu44Xbr7VzVsR?=
 =?us-ascii?Q?OiIrZiDtPBIcuvHY7doQvcw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db5cb68-75d6-4d00-44a4-08d9e75b446a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 21:22:22.4553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6oPUntS9y0zAdjv4V0WudJsz/Tzzfg8y7ZkCaFXsKrFMk0zS1cFJdsWADl66zXNURn1bkTMvHLSBhLMGOlUUgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2444
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> After other p4 topics in 'next' graduate to 'master', you'd need to rebas=
e the
> series again to the updated 'master', but in the meantime, people can
> comment on the current patches.

Hi Junio,

Thanks for reviewing my patch-set. I'm trying to figure out how to proceed.

At what point will the next branch be merged into master? At the point of t=
he next release, or before? I couldn't find any information about it.

The SubmittingPatches guide talks about branching off master, and merging t=
he prerequisite topic branches. For this patch-set I will need:

  * jh/p4-spawning-external-commands-cleanup
  * jh/p4-fix-use-of-process-error-exception
  * ab/config-based-hooks-2

If I then do "git send-email [...] origin/master" you will get all these pa=
tches included in my emails. Is this expected? It seems undesirable.

For reference, I have made a branch with these merges and rebased the tidy-=
ups patch-set here: https://github.com/jhol/git/commits/tidy-ups-submit-4

It's no problem to structure the patch-set in any way that is most desirabl=
e, so if you could let me know what is expected I am happy to make it happe=
n.

Best Regards
Joel Holdsworth
