Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4867AC433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 05:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiGGF7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 01:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiGGF7W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 01:59:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104D62F013
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 22:59:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvYfkw+l8BdkZHKcQijhq4OAbR+qpy5LHZ8ySH5pL8eTtOFErH7pw1VdSOjmsEH4ka4qABRSiZT4OFm1j+eDFa5rgMCKf8WUinm7spl+T1huewBtlyRMLnFcjkXo8H1JE4HKGZIbB44mT6a4FPyCGLsZOoEAOJmlTqmbP9/bcK3zzXxsqLMz8NzoKnyqLGQcksHCeQOMGSxqSkFIa9uMRfgatwn6A6q94E9mHq5ZoFuzmMvtuJAw5O2kwjWkk67zc4864TezIHljskM2Craa5042GL7PiGcDbBI10UIrKan0ESV8RES593SrNtIa+XscidXAZcjopIu8zWYr75MspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hNnEjh7oVYyTP3Aad2L8ucoF563L2RMZ/N/YkZ0XL8=;
 b=Qm3gwbUOpyM1MboJFwtn2R7TA2hPfXxQahBac/H6z5ms2qG/xFh6QlvaJ3kWAy6Ib+pWJB+k0mAYUv/9tLilSNVpCCtAsIXYIG9RQTd7h+lhtRiR4G+gEnpGvLovqU9hREZ0/tu4nKRaBwGaMPL8eWiOnfll6ntPtDCdGoxyeG6JlXdyG60mm4Vy27+a0JuYOSMgTidWOSWARd/8bsyszhfabHaEw3kSC9YjbnDf0pNH92S2tNWr+w0NM2REoOvM5k4yIFtZrvNYND25+a1bDwePBlIEswle/ozrAn15dAFXKO0JmqsQ4qsK5DYhgATVqVH33rZyou2pnXWNiM4GUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachivantara.com; dmarc=pass action=none
 header.from=hitachivantara.com; dkim=pass header.d=hitachivantara.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachivantara.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hNnEjh7oVYyTP3Aad2L8ucoF563L2RMZ/N/YkZ0XL8=;
 b=er/5PAgqGvN/KeRrdwD3U6wl19rzM+rqrl92jjElcD2a6nH79Z8yoMjKOdHD5LctlZQY/zzWBEpSDbU0Tejx+hevlgyTjjgMr82BKwXxdcS9gqszKlVakw/74H+NyZAV4ApCkc0aTHfrhcLQFr8ITDq6CHGT2Qrgl2r26Ym6ImGngUffVHdX+2EHpgW+VWX/g7JlLHuZGfceTSj0Ff7hmH3UFgwNvZ5bgZDyREhJrL5KiAsNFluDJZjS11FLD7aHRdQYup9qBX1K+w4zAGrgUNLOHfJIFQ7Aeon9H1DocYTcNsNp1nT56KTxKRJnb1AzsDyy1RuiPYzgG/CrhzB0iA==
Received: from PH0PR08MB7732.namprd08.prod.outlook.com (2603:10b6:510:f3::12)
 by DM5PR08MB3481.namprd08.prod.outlook.com (2603:10b6:4:66::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 05:59:16 +0000
Received: from PH0PR08MB7732.namprd08.prod.outlook.com
 ([fe80::34a4:b459:ebf:a42c]) by PH0PR08MB7732.namprd08.prod.outlook.com
 ([fe80::34a4:b459:ebf:a42c%9]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 05:59:15 +0000
From:   Florian Pfaff <florian.pfaff@hitachivantara.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git describe is not returning the expected tag 
Thread-Topic: git describe is not returning the expected tag 
Thread-Index: AdiRxKU0P33AGQCzRgyrEpzBj8narw==
Date:   Thu, 7 Jul 2022 05:59:15 +0000
Message-ID: <PH0PR08MB773203CE3206B8DEFB172B2F94839@PH0PR08MB7732.namprd08.prod.outlook.com>
Accept-Language: en-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachivantara.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9894e9b-da98-400c-a88d-08da5fddd2e4
x-ms-traffictypediagnostic: DM5PR08MB3481:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A3CliCjcQ6cDZ1KDuDQnu9ZvQeX1qZA7uehKqGhx3JW3+ycVEKZ9m6eubAu3ghIqMM0CXugwIlFZuIDkeW825G6yE+64TD571+I7quyV27gW7LXejM4JthUWussrhi/67yYZcsY2a7W6zu0+g848a5tWUC58w6eO5bGj1amdmZ45R2dGcPwP2xj8tsaqQnNSaWbu6qE+sJQL8OTh7KlBVKMdcnT0dy8T6xy4XqppnMuFJ5jVrX1KI6FV9THbLCBQONDOkf8MTJCz7dnGLy+7380cnDGqOhFWbX7YbeMHxaU61lQHEZAjEWlS/28fMmxU7eHQRAdBMXhq0iCkcSKDvJFFC1zT2hK8gpYdOTr8P8GOc3UNvZSaBL2ji8c9FoVNsRcucXPx6YpBamBOahYzvjYESHTm7WLtxJc7zZIBzlnZuHQWUiilV66e77qers4c7xW2nEPFA6MN0jDkeii5VBu7XXD99J7TFcq8eHIv6tys2by5IddP+2ffyJaNbgr7phPwtkDCp0OtlfbAQEWnhzGpt0LzsnqYuu5XdU3lQYUMB/cj5N4i2w5n44NDjEtadlJ8OzUH3LcaxpUEL9w7m8RuR3xrh9S14/5pgNjZORDl1bfzF4pBRvOQPzgkdSQPiUerGyVkAIfxIwFqMk4KOhx+NdD8bGJFwZpMpYgXTjoREa2xlXGs084UQZLoBh0WFlCc3jmrtZgftL9pnque1q/yAbo2IycwdLe9x8jqVcUE8EmeZhjlt3D/e7jm6mnSaK3kw2DnEQ/wXkq6AG76cb5HWZgHdH4qvNwy75X7tpn0SGT4HP1QRe07NDFWlQ/r7pVqJtDQ42k5SYWdQZgG/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR08MB7732.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(9686003)(122000001)(8936002)(38070700005)(52536014)(2906002)(86362001)(44832011)(26005)(71200400001)(4743002)(55016003)(316002)(6916009)(5660300002)(8676002)(38100700002)(186003)(76116006)(66446008)(66556008)(66476007)(33656002)(64756008)(6506007)(966005)(66946007)(7696005)(82960400001)(41300700001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZGQoPY4NZar6RFlLvi5djv2TMEHfGJ6iPcz4Kh5q86vVfDA6hfJR7SIeMQeY?=
 =?us-ascii?Q?E73Zhg5ArRHNgt7JAvaNMQPaOtcxwun0FAO+nGBqeOb5MkwLwJ5E+AWL8N7C?=
 =?us-ascii?Q?JCLjLL6Xxn6wMep77HoM3IM4v2/mFyavRmSfKjmqstFJUA/DeXd4IJGA/ZtF?=
 =?us-ascii?Q?pqP1ZrJMePZ1b/Gbbk5c1WsREJ7bjN9jjHPR3qPjzBiuw6GwvVn5iAaReMFQ?=
 =?us-ascii?Q?OK2tDg9V9RLv6NOtjsJ3RIH6qSwJlsjS4XPEwd8juJVxpQD2Ct1dy/yU5y7Y?=
 =?us-ascii?Q?tKuX5T9rHfqgf4CIovzypPjP9SDo6pgTx5tYDpV02z0Xf5113WS6evTFADk8?=
 =?us-ascii?Q?sp95FLnNvSqg8DlS/kpiYuog/CZyWWUm69K6TEubGYiHQpJjOX/g/cqj1Ov4?=
 =?us-ascii?Q?iQNbA4kzQEnqbO8VJG3mqohAhBB3Bsck3SkJUw9dKvw47FEZWzmDHQ1JPBkO?=
 =?us-ascii?Q?VVkNrq9ZHwmYluPiSXWUMNMPXe2U63aZUxoJXKcJaz+WLMY/iQ08UgloJvSN?=
 =?us-ascii?Q?iVgPCtk/ucDI19ZjCtUQbvIMkvyCepGgXryknz8lQla0Kn3SrsOa5t5voyd7?=
 =?us-ascii?Q?kVTK7VR1kKXQm/eVMVarKCxXuNJKpKXFSWTLyxu6yF+kKWrjVRJg0z/pzAfW?=
 =?us-ascii?Q?kPH/mPdyTCUBvO1DHfjw6JEqXurLtzJM8xz1KrAwIZ5TsjvH24rfHj9c61dd?=
 =?us-ascii?Q?7EozZueE/bOEbVHDqJ88xNLlInPcUj+Hqa/rCgvIt6AaDcEGYdhUr/n1fOIp?=
 =?us-ascii?Q?WoNv1gOm4XwQEG+Fyl0cyUVex/z/CzA4jJkocTpIZc7Z2tLcfjTHlrZ/n+Az?=
 =?us-ascii?Q?GzsCD7K+Xk4YP66R6THMRuOf9PgNbEZ7s/eafiP7piro65ZEmeKOsQVoP2xX?=
 =?us-ascii?Q?2oDmtc2Ntm/0FXMWqrf5yThOwFrX3iiiPOiETCwcWNZCf4uyD1TqKBHNYTmK?=
 =?us-ascii?Q?KnLLtiRf42QBfO+DriVkffoun5nCyoSpPk69Q+IdtwMEzRbgqVL9GImac3SL?=
 =?us-ascii?Q?DVwKyO0F7T+OuzS5N64ePFOcQyxAK4WfzH4v3GATt2l0FQ/2yj6mKcwd/J59?=
 =?us-ascii?Q?BBSVBGNkPmQPk2hqInDO764X+SUayvLD8LD3wie+MIu4EUGa67bnGtJdoQ4Q?=
 =?us-ascii?Q?vCOT7awxHuki5Ea8/7xTpt3sNCe+CMCAVrEQs7vDxgBZMcHHC1Wx97b6PhsC?=
 =?us-ascii?Q?C5n9stwd0S/VDNY68lE9pzr3yxHoJBtHYrl2wjrwvpS+/epRUVXEDljEKZQu?=
 =?us-ascii?Q?2VqjS+JldEahPiU3aiZ1tO5U9EI2BpdYxcnte6Y6xdqtofk3k5ORXeufOXbM?=
 =?us-ascii?Q?+Qp80tYeEVxfWLiGPjonsFmsWHpWpb8ZgKNg2PFe0cBlBU3wVeNgMAVPgxHz?=
 =?us-ascii?Q?kRaroun0tMULkVK6Ka55GvTaI2FxMCfh8IbmTauup5qEM8wkDFyv6AXF57kX?=
 =?us-ascii?Q?477phD13AJgTm4om8ohYxb9HebZtXTH9ZKFI3xg0/DryEj2Q16QaI0FMh2WG?=
 =?us-ascii?Q?aUCtpzDPG//tVVC0q/oCPck3O8a2AJi6C4/xtsNNVv/Ijajs0WfzBzPZbAwn?=
 =?us-ascii?Q?jqa2OsE6Ik2U0wgofYlLxAxqi5EHKNkeq7oLRmj/nFR7scVKfNTrRSZGF1G/?=
 =?us-ascii?Q?pysgZUV6Zgbi6VyLS3rd8X8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hitachivantara.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR08MB7732.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9894e9b-da98-400c-a88d-08da5fddd2e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 05:59:15.6333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18791e17-6159-4f52-a8d4-de814ca8284a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFHpVnMR0V5bODTQGvgwaD29QPuQPS7W/91Ydo1vTr4/PV79q2r6yROvXeRijaFi1kk+O7w18SsqWpaZG2gm5nSnaNF4v8wdUUmP/xMH0iqZoYhsPxVN299J+C40suyX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR08MB3481
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am experimenting with git describe as we want to use this in our CI syste=
m. However, I am not getting the expected results and neither the git descr=
ibe documentation nor googling nor stackoverflow have helped me understand =
why.

The repository
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

git log --oneline --graph

* 9a45651 (HEAD -> main) m c7
*   b7982a9 merged r3
|\ =20
| * 8c2adbe (tag: v3.0.0) r3 c1
|/ =20
* 273a50e m c6
*   6014487 merged r2
|\ =20
| * aa906b8 (tag: v2.0.0) r2 c2
| * 716c189 r2 c1
|/ =20
* f0e2c71 m c5
* d42bc37 m c4
*   9060516 merged r1
|\ =20
| * 619d331 (tag: v1.0.0) r1 c2
| * 75f90de r1 c1
* | 372f1fe m c3
|/ =20
* a27d5e4 m c2
* a66cb53 m c1


Expected result
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

When running git describe on main I'd expect   v3.0.0-x-d???????

Actual result
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

What I am getting instead is  v2.0.0-13-g9a45651


More information
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

git describe --debug
---------------------

        # git describe --debug
        describe HEAD
        No exact match on refs or tags, searching to describe
         annotated         13 v2.0.0
         annotated         13 v1.0.0
         annotated         14 v3.0.0
        traversed 15 commits
        v2.0.0-13-g9a45651


amount of commits between tag and HEAD
--------------------------------------

    $ git log --oneline v2.0.0..HEAD | wc -l
    5

    $ git log --oneline v3.0.0..HEAD | wc -l
    2

git version
-----------

    I have tested 2.36.1 and 2.37.0 both on Ubuntu 20.04.4 LTS both install=
ed from # deb-src http://ppa.launchpad.net/git-core/ppa/ubuntu focal main


Script to recreate the repository
---------------------------------

    https://gist.github.com/twigs/bb0cbe29af55b8141c19d25de47e0eed
