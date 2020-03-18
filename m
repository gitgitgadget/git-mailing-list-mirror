Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B16C10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 12:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DE32076D
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 12:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CorPowerOcean.onmicrosoft.com header.i=@CorPowerOcean.onmicrosoft.com header.b="EOY+SdJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCRMul (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:50:41 -0400
Received: from smtp-out11.electric.net ([185.38.181.33]:59259 "EHLO
        smtp-out11.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgCRMul (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 08:50:41 -0400
Received: from 1jEY9e-00033b-Tk by out11c.electric.net with emc1-ok (Exim 4.92.3)
        (envelope-from <timur.delahaye@corpowerocean.com>)
        id 1jEY9e-00035D-VF
        for git@vger.kernel.org; Wed, 18 Mar 2020 05:50:38 -0700
Received: by emcmailer; Wed, 18 Mar 2020 05:50:38 -0700
Received: from [104.47.14.58] (helo=EUR04-VI1-obe.outbound.protection.outlook.com)
        by out11c.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <timur.delahaye@corpowerocean.com>)
        id 1jEY9e-00033b-Tk
        for git@vger.kernel.org; Wed, 18 Mar 2020 05:50:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go9FXmJjzr0VP+GitEOEFYLOfKVYy8uo8YYLhvNAI2yjRrMGUKDAOBpoL2sNLylX/qqmmonoyDwMA8U36w6a4cq/v9hh9buPxg/vuyuv+CHMbgxRrzRPElw6oC4opys2MfaapRrLfDS5omi3m4XSPQSoqn2mwxJn0kD+DCuQhIMQr/K04Mtxbf5l0GGUBuX9rceTGnd/KM4dllcXRF2+2vYj0uUEp8zFjpUR96QVW0mlQ7wEkk3eu3cVmrp2fZn92ydCl0Zt8QPofc8BIxm1Xa3ZkgLQfxB6upBfJ98Bfo2xxDG0xJ8EKoG1GduwOd+TV/uOow/VYQIWNnIyBLEsjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbWE5cBAUvv5OAcX2TOQ8/4+DENrGQdMIcPJlw8xf78=;
 b=iLZLFAfo43f/NiNilBWs2ORhA6Z9q9NQQCeamLLTPHm/a02VAAwFS1HCaFPYSUvlzyXN8o2M1GTMKiEa7ay3Fej23bR6u27v5UjItRPuDyJL3b4O1qJxjUX/EZxmcQJqK4vzr+is5Pie219/4O7MvdpyqG75hSNKKw+Km/g77e3Z+Os8guc6d6VOVoM2EwK+t7sQaiJ4/rPQl2FkHAX3xl2MLzcYDnG3m67s+wQHc6MzP5Fm6nCcBPIiO8rXt1h/B2XTAep34JtN2V2iF2YrebrBkQ0LL8tKZAg8pI2FQwm7mUCI8+0VEfkq56ZXXSvKKDB23gplUyeES4VjjAN8ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corpowerocean.com; dmarc=pass action=none
 header.from=corpowerocean.com; dkim=pass header.d=corpowerocean.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CorPowerOcean.onmicrosoft.com; s=selector2-CorPowerOcean-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbWE5cBAUvv5OAcX2TOQ8/4+DENrGQdMIcPJlw8xf78=;
 b=EOY+SdJTP+k2Wtbsm3wKgRYfzDpM+qaY+8+LSBTPe1F0PG+3ORf4NZkw+BWu+jrf0GmStHVTgHf7Pmbd5RUVMnK4fGA/wkCANmGE8u36nqtZ5VyHC9+nx0LQuptIr+hq1pWkc3dD4U+yq62CR6rMxmSwwPCwxF1lBCT7nNsit4E=
Received: from HE1PR04MB2987.eurprd04.prod.outlook.com (10.170.254.25) by
 AM6SPR01MB0028.eurprd04.prod.outlook.com (20.177.116.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15; Wed, 18 Mar 2020 12:50:36 +0000
Received: from HE1PR04MB2987.eurprd04.prod.outlook.com
 ([fe80::6c7b:c0d7:47e6:da3c]) by HE1PR04MB2987.eurprd04.prod.outlook.com
 ([fe80::6c7b:c0d7:47e6:da3c%7]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 12:50:36 +0000
From:   Timur Delahaye <timur.delahaye@corpowerocean.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git submodule init initialises submodules for which active=false has
 been defined
Thread-Topic: git submodule init initialises submodules for which active=false
 has been defined
Thread-Index: AQHV/SO377CSf9EIlEOjjQViqN820g==
Date:   Wed, 18 Mar 2020 12:50:36 +0000
Message-ID: <HE1PR04MB2987A255BC327320D1DDFE6692F70@HE1PR04MB2987.eurprd04.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=timur.delahaye@corpowerocean.com; 
x-originating-ip: [82.209.176.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3b5dcb6-6e91-4ac9-3c3e-08d7cb3af484
x-ms-traffictypediagnostic: AM6SPR01MB0028:
x-microsoft-antispam-prvs: <AM6SPR01MB00281F9F5977D2DE383D0F6B92F70@AM6SPR01MB0028.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(396003)(346002)(366004)(39830400003)(136003)(376002)(199004)(8936002)(8676002)(44832011)(81156014)(81166006)(76116006)(66946007)(316002)(86362001)(7696005)(66446008)(64756008)(66476007)(66556008)(6506007)(6916009)(2906002)(55016002)(9686003)(33656002)(966005)(52536014)(508600001)(5660300002)(186003)(71200400001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6SPR01MB0028;H:HE1PR04MB2987.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: corpowerocean.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3D6TZ5HwEInRdlxzfNtAhyZ/7Rbhds2wklH4XQaSYLLYTrw4EjDlQp+c0+3aHd2XRX+WPsB52xlOHGGoVLrsysxsPtHfAcGUj4M1ImUbNa27rsMgFoAVX+7YIyJUsGnbvIs0bi9YCpwhzxy502qgVkZ8+bnWdDsUwYbiv6i27Z6AW7Q6rY+KF0pz0bHWfj9AwU+T9c73qpbWHwpafdj2O3ReB52TWmS26NB52uA/P0lsEoeOuL6LXoF6KHyWkJmm7oaIH0Ei9R6cuTMmS2jBaXqNgJkjO4b3ctOtP6v8xEjC3Ihj2m5v38FOvMYtjwSYUR4H5GCBsOhL8tfO/5WIpzW3lHTcHU6jUf6movzLoWGtRsxSEZMoZPXK68vkQ/biRf06R6b4/G2Bsj2WW1o8WJ7b89hMhTPkZoGyC8hpLKrTuM0/UFqDAOKsan7OXldp585BRJczpCanc3r/NgOuoayq+5hvDR0Aw81Ug7tUwMMTR89o6W1ECcti0IhwPV/mVrlQ0qmDryMed9ga3E8pN14loPM3k4wIvFEgOH1AqtlsalzgWuW/MZrDIuy+AbGSJJfnBH/2yZ0IDmvViEMdFg==
x-ms-exchange-antispam-messagedata: mZTZFxdZu2H+xWOKJ2p74hU/MoW1ws+hMxpy44bu1kR+I6yWlBbT4AdW8bGKftqlJqwsuUUBDZLBQc+p6pe1zS/+mwgosjshCbuoSUGnS6GOpIhEw4eRGNd3PfKFrWon2eAnRz/aO08fi5X0/f3N4g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: corpowerocean.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b5dcb6-6e91-4ac9-3c3e-08d7cb3af484
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 12:50:36.5034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7cfdffb1-8cc0-4305-aba0-fea67910d320
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7oiV99Bt5kaAKjFv9676om3Q386cM92ChH7Y4cS3bhOTKU7FEG/TekP3R5oJcywPvqaTmco8av4yrgzU+3PACWLh5pjRbTnsAlsuw0l9JkfSc/5kqLDmwf3revX2mS6K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6SPR01MB0028
X-Outbound-IP: 104.47.14.58
X-Env-From: timur.delahaye@corpowerocean.com
X-Proto: esmtps
X-Revdns: mail-vi1eur04lp2058.outbound.protection.outlook.com
X-HELO: EUR04-VI1-obe.outbound.protection.outlook.com
X-TLS:  TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256
X-Authenticated_ID: 
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (b)
X-PolicySMART: 21191767
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,=0A=
=0A=
I am trying to prevent=0A=
git clone --recurse-submodules=0A=
from installing some of the submodules of the repo that are not necessary t=
o most users.=0A=
=0A=
Here is what I did:=0A=
In my main-project=0A=
=0A=
git submodule add --name one url1=0A=
git submodule add --name two url2=0A=
=0A=
Then I edited .gitmodules as follows=0A=
=0A=
[submodule "one"]=0A=
 active =3D false=0A=
 url =3D url1=0A=
[submodule "two"]=0A=
 active =3D true=0A=
 url =3D url2=0A=
=0A=
commited and pushed.=0A=
=0A=
=0A=
From a fresh folder when I run=0A=
git clone --recurse-submodules main-repo-url=0A=
both "one" and "two" get installed=0A=
=0A=
Likewise if I do=0A=
git clone main-repo-url=0A=
git submodule init=0A=
both "one" and "two" are installed and appear in .git/config as well as .gi=
t/modules/=0A=
=0A=
From reading https://git-scm.com/docs/gitsubmodules/2.25.0 my understanding=
 was that both procedures should have installed only "two" and that I shoul=
d have needed to do=0A=
git submodule init one=0A=
in order to force the local installation of the inactive module "one".=0A=
=0A=
Either I misunderstood the manual or there is a bug with=0A=
git submodule init=0A=
=0A=
I am using git version 2.17.1 on Ubuntu 18.04=0A=
=0A=
=0A=
If this is not a bug but an error on my side, I would really appreciate som=
e explanation about the active=3Dfalse flag so I can achieve my purpose.=0A=
=0A=
Faithfully yours,=0A=
=0A=
=0A=
Timur=0A=
=0A=
