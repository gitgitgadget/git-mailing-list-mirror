Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBFFC2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 08:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 887FE20768
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 08:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atos.net header.i=@atos.net header.b="n7WpOyug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404850AbgDOIdG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:33:06 -0400
Received: from smtppost.atos.net ([193.56.114.176]:16303 "EHLO
        smarthost1.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404826AbgDOIdD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 04:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1586939582; x=1618475582;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=IkrSZH7eNvj4OhaBkmbKweIznq2ZkugGfVrNirF8ras=;
  b=n7WpOyugL83fVfxUlS/avkKQy3vZN6ayA/xZw6D8d5ol68ZMNPyXE4K9
   7HgvBzLi5vRch3ECbSpSnqxT9p+mhqK2qxjcHuOmrtRrL7wlKf70BkJgh
   kVrFL3Kxm/a+gGELglgLuXRF3KffASIKgmrGgvDZFNZYqzw9sO52Xvqcd
   o=;
IronPort-SDR: u5cD5bm7g8R/YyPp+cpXIGkKkw83mTP3kDCEpXKm25I96VTLGIKFwuXCaWSEovVjjT14nsnQBX
 WEUo70/IiCaCUFcfWah3V5ykizOVF12//HnJHUIeqBeM0r7KPbMGC1bIrp/PFJfd60YNPaJdaU
 DFai45qUOac6PlAB70Bj4Hg1eR3HDht2x7ZsTm4mmSN/u3vrB/XeJQLKayaLVbSabvETBtgC8B
 n2OXqaQANnGGI3JqF61iOCKqQvHtO+FiVa/tGk2R5bubjZeV4wnDKIP3fzlDsv57L4N3BUcsEM
 4Ehowz628ejqotEnlvDIJEuo
X-IronPort-AV: E=Sophos;i="5.72,386,1580770800"; 
   d="scan'208";a="30116769"
X-MGA-submission: =?us-ascii?q?MDEPJ1pGgyprOeHE7Yc+WPTAHohP2ojceAGF2G?=
 =?us-ascii?q?XRvvvu52eNMaf2ZvCH/9lChzei6yEkuxKytL7Lv8boFHYk7+BHqsJb7Q?=
 =?us-ascii?q?EEOVxClhK2p80aAVc4A0n5lHT+ulV+EGC+H1j41/q8U8PZXk/sFtnwzp?=
 =?us-ascii?q?oc?=
Received: from unknown (HELO DEFTHW99ETYMSX.ww931.my-it-solutions.net) ([10.86.142.53])
  by smarthost1.atos.net with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 15 Apr 2020 10:33:00 +0200
Received: from DEERLM99ETWMSX.ww931.my-it-solutions.net (10.86.142.45) by
 DEFTHW99ETYMSX.ww931.my-it-solutions.net (10.86.142.53) with Microsoft SMTP
 Server (TLS) id 14.3.487.0; Wed, 15 Apr 2020 10:31:45 +0200
Received: from DEERLM99ETQMSX.ww931.my-it-solutions.net (10.86.142.102) by
 DEERLM99ETWMSX.ww931.my-it-solutions.net (10.86.142.45) with Microsoft SMTP
 Server (TLS) id 14.3.487.0; Wed, 15 Apr 2020 10:31:39 +0200
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.102) with Microsoft SMTP
 Server (TLS) id 14.3.487.0; Wed, 15 Apr 2020 10:31:36 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBnTv17h9aWbuB/pEJR7Rq4wc16bOzHdVZMeNc7Dbdj9ajY3efK/E8InvGGjGno7Pdw1feaoFk/bToMQUzJSddHiXI/E1JHTAEMXlJbtLb0d9M5Vvl7b1KYwtxlPIOXz8X3hRoMMyD1h+3HDMmFz/ZPsF4nmyC3Py4iMC7/IhKOMMOBd2GeTgUOocRYrPfFDjldeni5RSbb6wXik8q4OiW/XiqX5QnFsuVMc6M1cenhPwyNWbXahVAqx8Y/Sd/6k0MFQ7bp6w/3p3xje4Jd5svr2poPg1gPJnB9t+2qgPBaHYA6Nhd2JeHHevD1BGXHhixWy6ScbFIDdVVLiHZ+83g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkrSZH7eNvj4OhaBkmbKweIznq2ZkugGfVrNirF8ras=;
 b=nxSy1TDpwdw/OoDc0Ve790TfFEaS3HJRaGiPnYxk4eKgnA5S5XDTZkVvuVIJ9Fd14+4/8Ef7WElMVH2yt46VMo/bTXs9/Qfc0713V/PrUeLClRxzzfrUzIExglKKM87/y1eui3ZBLT6faguN3TRV/icqTtpQlOATFcyPKPte8MH0E2F3KJShkfWCmioV/lgYpZLoXB7OL6bupbAS3t+fdWIeKDohBH5jCEDw0RPgRK5Tj7kT7l+pafByxRIrd7RiDHvYCZ4AFs9mnF4/PH7DbcMJP84E3Q+cSexOCIxZSkLh9NLE1dWWPp8B+PfW59vWNAI6SpLdI5H8TEw4DfZkmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM0PR02MB3715.eurprd02.prod.outlook.com (2603:10a6:208:42::13)
 by AM0PR02MB5444.eurprd02.prod.outlook.com (2603:10a6:208:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 15 Apr
 2020 08:31:35 +0000
Received: from AM0PR02MB3715.eurprd02.prod.outlook.com
 ([fe80::b4c8:6064:534d:3eb8]) by AM0PR02MB3715.eurprd02.prod.outlook.com
 ([fe80::b4c8:6064:534d:3eb8%4]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 08:31:35 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Move some files, with all history, from one project into a new one
Thread-Topic: Move some files, with all history, from one project into a new
 one
Thread-Index: AdYS/5siN6K1VEonQ5i65mManIbGnQ==
Date:   Wed, 15 Apr 2020 08:31:35 +0000
Message-ID: <AM0PR02MB3715F9566BD9FEFAF832F0749CDB0@AM0PR02MB3715.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Enabled=True;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Owner=richard.kerry@atos.net;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_SetDate=2020-04-15T08:31:35.2582334Z;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Name=Atos For Internal Use;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_ActionId=35cae97e-01f5-4b66-a8f7-5ef71561b427;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Extended_MSFT_Method=Automatic;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=True;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Owner=richard.kerry@atos.net;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2020-04-15T08:31:35.2582334Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=Atos For Internal Use -
 All Employees;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=35cae97e-01f5-4b66-a8f7-5ef71561b427;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Parent=112e00b9-34e2-4b26-a577-af1fd0f9f7ee;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=richard.kerry@atos.net; 
x-originating-ip: [212.56.108.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e2b8243-a3a2-454a-a712-08d7e117690c
x-ms-traffictypediagnostic: AM0PR02MB5444:
x-microsoft-antispam-prvs: <AM0PR02MB544416804A78389FBC5558A39CDB0@AM0PR02MB5444.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB3715.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(66476007)(66556008)(55016002)(64756008)(9686003)(8676002)(26005)(81156014)(478600001)(6916009)(66946007)(8936002)(86362001)(66446008)(52536014)(186003)(71200400001)(7696005)(6506007)(33656002)(5660300002)(2906002)(316002)(76116006);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3j4Y945/TtPj4C8lOIpHZM2OhfVxJW8X5FYeCbIsjfRXfH9DdMIpa75o+Oe3TR9twHzN3dMuLm5cnlWBTgWF5JXozlDnAc+nM5OlCxh16itYJVhsByfglgBTEzFpnFrLtZqE6gEsHpaZof4mhlIS0vQ/j1kVH003wP273a636o1DkBmZGXcfldB6UgXTwVE6viJvKfbJ9AWzlBk0N/m1IfpVEKO80wHrjvsx3rNCvgfCPWEhB3Ffn0zyy3f0VCZ3Ih9p5Z5Z+QF11YxpJQttK04xJBMzfs5rc+IJiJQKHnCtXHeufrhMsdcfAWnM8WEMipx+rm8gPR6Fx5M4NW/5MAwUcN4UxO7u3PK0+yeBTIxPWABDXFSyfiW6+5+UnfXbnTHncUIf3gPh4lcB5JvEsuh3rB53w9bcXqf8AOSu8omOHfdvRcFwCWhnYJ/m7Pkn
x-ms-exchange-antispam-messagedata: wqFQPAcFd6OR4sDB4SnccU60PcDuujg5Bn3yFyffxz03g8Y23ylwKbPqFBLnLMG66bbB3a8BovqjZRNSv3xmraTIHWWvN/xuRzU8rCiMyy0OCXocTE4WknZPgEqgfuo2xUnQAY5Jvw4TA4pXSZwgAg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2b8243-a3a2-454a-a712-08d7e117690c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 08:31:35.8898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Sk3R3DfApRQ1P0tjjjhOmNUFu7wm6kzQDfaGxSczXuJnDWzS37u1bQESd5Zga8ItINfNZgxYNuE3tzaVrn9XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5444
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I would like to move some files, from the project in which they have always=
 resided into  a new project.  I would like to keep all their history.
I don't want to waste space by also moving the rest of the old project's hi=
story, or historical file contents.

We have a long-standing project, main-system.  A group of files within it a=
re designated as demo-system (sometimes whole folders, sometimes files with=
in folders with other files).
All development is done on the master branch.
It has now transpired that the demo-system files are necessary, but no long=
er want to be within main-system but in a new project of their own.  So I w=
ould like to move them from the main-system repo into a new repo of their o=
wn.  I do want all their history but I don't want to take any contents from=
 other files from main-system, which is quite big.
Please can someone advise if there is a particular method I should best use=
 for this.
Do I create a new branch, then delete the rest of main-system leaving only =
what I want?  Surely if I do that then I would end up with all the main-sys=
tem file data within the new repo, which would expand its size.
Is there a recommended way to extract certain files with their histories?

Regards,
Richard.

