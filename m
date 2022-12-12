Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F36C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 16:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiLLQOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 11:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiLLQOB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 11:14:01 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003766333
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 08:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barclays.com;
        s=barclayscom20180719; t=1670861638; i=@barclays.com;
        bh=mrjQ0QJUOQMPsHqiBqkf9HxzeaVBz/Ydvgy4nby8PiY=;
        h=From:To:Subject:Date:Message-ID:Content-Type:
         Content-Transfer-Encoding:MIME-Version;
        b=UNS7eqZpUCIuB8k7gdM+qyAZaW7fi034CaBQC37Kzj+CAZ79IHgH/XUdKHTUWRYa+
         CwUqu6VFcOBAMbITFsdTKPn3/4juESDKrCGq6vGSpxmMLx8ZWx8Ys6Is5bIuGCNXeG
         AmaXVaCLZhGktilmB7S46WuBamtiBD72q9Ffiq7TqHHAQ8ZUgqU0PuZs/15Eh0rnNO
         p5V3OKvRsoj0/jZbo8L0bYWRpQ3q0KWTRPUKSBjLffI/ZxY3K7PGlICqEV2zKYC3Dx
         vDvwoDXtIQlnxT8LBXET+OH2kWditD1CwKKz2GKr9V9lpax1RLNwa7yQW+JxxfM1CK
         9V5msag3kD95g==
X-Env-Sender: Mark.Yagnatinsky@barclays.com
X-Msg-Ref: server-6.tower-727.messagelabs.com!1670861635!4225!2
X-Originating-IP: [157.83.97.115]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4319 invoked from network); 12 Dec 2022 16:13:56 -0000
Received: from unknown (HELO IMSMGGCB602P.barclays.com) (157.83.97.115)
  by server-6.tower-727.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Dec 2022 16:13:56 -0000
Received: from IMSMGGCCP03P.barclays.com (Unknown_Domain [35.49.84.77])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by IMSMGGCB602P.barclays.com (Symantec Messaging Gateway) with SMTP id E0.F1.46293.34357936; Mon, 12 Dec 2022 16:13:55 +0000 (GMT)
X-AuditID: 0a118865-02393a800001b4d5-17-63975343eed8
Received: from MUKPBCC1MEG0006.collab.barclayscorp.com (Unknown_Domain [10.250.250.254])
        by IMSMGGCCP03P.barclays.com (Symantec Messaging Gateway) with SMTP id E4.73.22733.34357936; Mon, 12 Dec 2022 16:13:55 +0000 (GMT)
Received: from gbrpsm020010108.collab.barclayscorp.com (Not Verified[10.40.84.45]) by MUKPBCC1MEG0006.collab.barclayscorp.com with Barclays Capital Filter ESMTP (using TLS: TLSv1.2, ECDHE-RSA-AES256-GCM-SHA384)
        id <B639753430000>; Mon, 12 Dec 2022 16:13:55 +0000
Received: from gbrpsm020010133.collab.barclayscorp.com (10.109.149.14) by
 gbrpsm020010108.collab.barclayscorp.com (10.49.132.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 12 Dec 2022 16:13:55 +0000
Received: from xukpbcc4app0193.collab.barclayscorp.com (10.234.4.44) by
 gbrpsm020010133.collab.barclayscorp.com (10.109.149.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Mon, 12 Dec 2022 16:13:54 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edge.barclays.com (10.234.4.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Mon, 12 Dec
 2022 16:13:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLPFHs3wmmT4K0TUA1xsEYOYdE5ttMctTTunI0xL4lmqyWNPCJxsFiECVZbBXSW687wpTapAoiqSwUFX7sTwfe2xsdXdvjyxFbGlRin4Q1ZHMaG56VjCAH48B7LaiLDUZM+VKq4CBMlxS3IHbmRRLV3ydEuq1TEkap7cQu5nsVoCI1T2jy61+7/nk1FeN8zmJIyk+CHtZYxBClueZl+J5fXErd5Jrz3fZcpnlHb6xSWO1iRZ3B5FcLCrfdbQKnFjTgoHVTMCmPaqItkNQ29FLnjHpFERtr06kyQQ7P40LwA5uww8QRrOz4T+gqLVtoz33fSq4tdVNq0ZaUG0QaskcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrVHfueA3+0/De96XGSeYrXhH1WFSkQ1x+rqc5ut2RM=;
 b=if6d7RCrCS5SkbiM7UD18QR90WPfvLhgYn1XnSZCVJldN5q6hxGemFjBHCXEu4NhL7P7f0K4EHiTeZLG4hlGKGQD3uKyE3G856MEDSIZa+PIzs++nOS0E/LTb+Nt6sK+1T+JLTh8EW+dluVc303QtyIMo4PXghKgkzQxCDVPti9wFMkJwX3bGvwWY3lgbKyyetiH6za+qXV1MbWWgBklfiV78hl4XIyOM2EVgY7zS6Wntk8X3TZdN9hep6w5o2JjxtPhtjYdtcVil6YlG6M3EJrcWMPURR5Y7vsKQiSbdCHzk9UStaM6aiWWT/2yAzAnVnfQHxhfoZztHQcqnxZ/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=barclays.com; dmarc=pass action=none header.from=barclays.com;
 dkim=pass header.d=barclays.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=barclays.onmicrosoft.com; s=selector1-barclays-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrVHfueA3+0/De96XGSeYrXhH1WFSkQ1x+rqc5ut2RM=;
 b=yeod0ZaIykcKAYRa0JLYeWE8JH5klXAs7TnwzvdXMiQSKcNnIAIEVk1La5mj5ErotRMCesv1KRqMh3eSVY6Jd6OCeg+W0e7hSsQeSvqJKOSbeQzgZUiSddx2K1+YtHVFQOn9LmEM4i20gMKs4m9qqsA19krITvZmwblA/8F/0SM=
Received: from MN2PR12MB3616.namprd12.prod.outlook.com (2603:10b6:208:cc::25)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 16:13:51 +0000
Received: from MN2PR12MB3616.namprd12.prod.outlook.com
 ([fe80::fd08:824b:d68d:2ad0]) by MN2PR12MB3616.namprd12.prod.outlook.com
 ([fe80::fd08:824b:d68d:2ad0%3]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 16:13:50 +0000
From:   <mark.yagnatinsky@barclays.com>
To:     <git@vger.kernel.org>
Subject: feature request: git clone --branch should accept commit hash
Thread-Topic: feature request: git clone --branch should accept commit hash
Thread-Index: AdkORLZJEPPgK2FDTjiHwr4G4/kKZQ==
Date:   Mon, 12 Dec 2022 16:13:50 +0000
Message-ID: <MN2PR12MB3616CCD1EDC3EB976CE32546F9E29@MN2PR12MB3616.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_Enabled=true;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_SetDate=2022-12-12T16:13:49Z;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_Method=Privileged;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_Name=Unrestricted;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_SiteId=c4b62f1d-01e0-4107-a0cc-5ac886858b23;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_ActionId=e35967c0-9782-4c13-81e1-34b5a5ea9ab5;
 MSIP_Label_c754cbb2-29ed-4ffe-af90-a08465e0dd2c_ContentBits=0
barclaysdc: Unrestricted
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB3616:EE_|DM6PR12MB4353:EE_
x-ms-office365-filtering-correlation-id: 07c7b654-2122-438e-5429-08dadc5bdb64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RhGiTKlDqxjJNsTsCEbUs02vIo+mRtzs+W6UTkgD72SA6+qp6B3gV2KgcJgC+GXohc3WSBUwYrZTxUlZXXROPLtdhQMiCtRM0F686ZhspNSbCWMxx3vLQgnOw2rV+YbnYKMb9xPCZgTfzazADAPk9HJayxn6AZnkJAA98YsRwH0pirLpLDdlWyv9MpE+PMT3jeZwxGf4bc6PuzktMpGDOCGPDDUNI2bBB8JgAydws1JugP7fQYNwfo5+gqnm1et/nOG70zjm5N6gyOUYXAjDXpdiky9TRudwvtgYc01mDF4dwkx1TybzirhBjDoiCKRo9R1HbVSKdbcpLEyWkVQeXV705wKE5rQG7DwhHqe1hDjWs/WT7EumOEn3agleuvS40OvoxpGrglDx6ZGMjTprNDg/Iqe8OqfR+WNh8OER56Ja9Zf9acC1MvhQmqOAnklQhgQCELVOGCXOoholg0uWfGAAp+qRcdQvzoy/TRhVqb3R7E0A8tqdGBesNg3qErJCRkxc855tEVaF+/Flo1n+lwTdq8TPvxSUNrmEQo03h/T9Tx1hC54y7t5FQscs8StKT0Bf43ZnINA1OsgCBmgdeJpse0PN4O/ORTCxr4lqDmhUNHlSG0AyM+2aV8zJP4o6GzYaGUSvLa1dXeVKslmuetShTO6ns4JRnuXFuPSZApY1vHJxn6o8UJRV3fCQT6xBMIXzf0dlZ6ovPCKJ1+Apiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3616.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(558084003)(10290500003)(316002)(52536014)(8936002)(38100700002)(6916009)(6506007)(478600001)(7696005)(122000001)(9686003)(38070700005)(82960400001)(26005)(71200400001)(2906002)(86362001)(33656002)(186003)(55016003)(64756008)(41300700001)(8676002)(76116006)(66446008)(66476007)(66556008)(66946007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uVnu7OHEXidrf27+A/GeHpbS0X9elgKJLRgDO6fuBI/YHPCa+agvyo4YXZ7s?=
 =?us-ascii?Q?xw6pv+eOaslqLecYxyPCX3ld5diXT5a2LJGAUVRJ4FBBLXDGWRgdLxHpHAxt?=
 =?us-ascii?Q?K6NQE60RGvshWFc5hInSqtICE0sbtWXGLyT7qK+UHph7mbkXrrRymA3XS7Y0?=
 =?us-ascii?Q?euJwDAHM8sz8fmntOZKps3gReaanrrPN4lLsY5kY16L+qjnjE/fJMNS4YBZQ?=
 =?us-ascii?Q?4YJ1tdGYXe3maZ30UvZmIlML9uZ1LhvKexSzIGxjteeaTvdgJZQCwILoh6RS?=
 =?us-ascii?Q?c+wZ+hPyNn9zIlXD+uwhL9C0UWAPrcpEPue3BLP1BPi1poFZuHH18CJyj4qb?=
 =?us-ascii?Q?ygDaodKx3PGmLYMFuhKC6StWSZp3V7V7SzLBkiKmCDLCX/IZ/N8+BO+CDlHL?=
 =?us-ascii?Q?LRd/MGzBbLbYnW5UZL5lgM9/1cAMY5M5Jb10IFDPmmRgHk5KwLqoSNMjG9zl?=
 =?us-ascii?Q?xERP+7IhTKPJLU5AEqUPG6dALsMvyT6IMy90I3618bgA/p2J6uHdnxt2WAIl?=
 =?us-ascii?Q?nCulHqtkX7Zsj9zVMYPKz+WKbmyalwlnY7WQsmo+a5KQUcxfsmSicD06rsCx?=
 =?us-ascii?Q?CHwhCyu459Sm1JBOnBoQxobDrdxKgwKicYhKVNeKxstaRz8bmaRj8ZJUVstn?=
 =?us-ascii?Q?Mr5zGVC5CO+7x8gkqb/T10a7ZRNocfR+K1foG1TP0RLP77P/f0YNJn17bkje?=
 =?us-ascii?Q?op2zX9xqOhU06QkBUZd6OyK8pgZBdrRRrVc4XAENFToLvtUK8jQ9TYxeswYI?=
 =?us-ascii?Q?8V70+edhgO8DBVfquPl3vHkh9V4K/ZMHH3cc9OR0Eu6z3C2489MigMUrp+n1?=
 =?us-ascii?Q?DBN3cLK7EPC/hx/GjhAYMMlb5ljgUVzPBlu+caL8s9enVDW44eJGIici19ZY?=
 =?us-ascii?Q?INMdun6DSi63jb9PUw23orTUATS7cL8RpDLk85ZgHidvNXsukcAQgshtibQn?=
 =?us-ascii?Q?l3yvtZkH2l0CA0vocAhG80Uz3HFFo5psqTpfhECc1vADXctQZQc5YZH4o891?=
 =?us-ascii?Q?zRFdA3hMKtkqiRVPpxsnsh2C2oQRyOksjP1gBR4sjIgHJ9MPR+2eW+Y50wWZ?=
 =?us-ascii?Q?iOTmABiYzqioG4fytN9kVm/O89tFQdvyzqlr15VVmPML5lSorcXOgPOmfIGQ?=
 =?us-ascii?Q?+hG65Wz4/DNNHoNY/Yjv6uA8PvYRdxZ2c6wleyE6AkAEYKgS5oR8opD3NUbB?=
 =?us-ascii?Q?/dhH0nYmvfP8URSt4EZumcdvenU4okEKHOwlnC2DG28vkiaL27YAt9j7HpYW?=
 =?us-ascii?Q?r4I0a9u6+vd2ShFwW4AgYsWaIPOI6xnp/CkuIKYwV7sxYMtWtHipr+BHoT5p?=
 =?us-ascii?Q?dZ8kpGbmcWQr+zg3LG3XsQt2YLBwQW4gKvdPkzRZS6hAUkpWMSU7k5JC1bSB?=
 =?us-ascii?Q?BsqqB0RUZjHUKn1Zn4/0zolgA8MHYcyNU4FiwKsjsWH2xDik2QTHlUxD7cMw?=
 =?us-ascii?Q?LSZLaTfMYOAgjPT5DeR3FuQ+wCB8TCVnXsZACOGJV3GcJ3OdAakLRmwPpKUp?=
 =?us-ascii?Q?YOrSJXAtNpEUSOLoLPcFPusTOT6GlaBI4+xRBBilpiuFn96xr79m2SQP9rEx?=
 =?us-ascii?Q?+aNcQaQtrW1j5bQF+d9l8jfT6vpgzrZ85ZiTp87R0NXMYTgR6KFA7jB+Y54G?=
 =?us-ascii?Q?fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3616.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c7b654-2122-438e-5429-08dadc5bdb64
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 16:13:50.6954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4b62f1d-01e0-4107-a0cc-5ac886858b23
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3eDwK+FGUdTQVc+djMoEGUf9CtK/MBOCdPjQDGNwC+pi8Yi+IcKvTd4GK5eEr0L7A5Um0L/l35J4tVYJp85MjBSLS9BwzptRnbcdLWYohUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
X-OriginatorOrg: barclays.com
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42JRNgzx1XUOnp5sMOOEhUXXlW4mB0aPz5vk
        AhijRG1KcooVilNLSjLz0m2VfEODQ5T07RJEMyYc28ZW0MJf8X9hJ2MDYwtvFyMnh4SAicSS
        DwvYuxi5OIQEdjFJLDyyjqmLkQMs8eaOLET8LqPEr/OLmSCcDiaJO+3LmSGcSUwSLSfOM0I4
        y5kkHv5ZyAYyV0jgP6PE329FIAlGgWXMEg//72aDclglOnbfZwWpYhTYwSgx7WU6SIJFYCuz
        xPmrq9ggZi1ikng+8SoLhPOIUWL3ux1gLWwCqhKzdq5nArFFBCQltj1+xQhiCwu4SSze9Ysd
        Iu4tMf1IO1SNnsSPtkNgNgtQ7+YjE8FqeAViJB7POMgGcYaYxPdTa8BqmAXEJW49mc8ECRwB
        iSV7zjND2KISLx//YwU5iFdgCYvEvTcLwA5iEpCQ6F/+nRliULnEh9097BANshKX5nczQtj2
        Ei93HIIa6iuxpekuVFxOYlXvQ5YJjGazkOyGsHUkFuz+xAZha0ssW/iaeRbY3YISJ2c+YVnA
        yLKKkcfTN9jX3d3ZyczAKGATIzBdcAl2pO5g3HDyhd4hRiYOxkOMEhzMSiK8qhrTkoV4UxIr
        q1KL8uOLSnNSiw8xmgIDZCKzlGhyPjBh5ZXEG5qaGhiYGZiYWliYGCiJ805uX5IgJJCeWJKa
        nZpakFoE08fEwSnVwKR2QL1BcX7HKysPATEeOduuPtbMSz0LpHlcXm9fJ6O0g7M1pLmgvjuj
        mM1o17RH142KvpxfEcN391DA5bqda54Us+x4YqBZZq35SKh/9tSb1m8WuD5oXx3M+Od2heve
        lZNV9sd2/TN346lYUHFz+/LQjJPcvA+jv9qLPnnpqPhIPmzKXOtTvrHvs7zZDWu6Hixa0JF6
        Ri6Fd1aUS1dF93Z99dMfV62aGyLjHXxiT2HAzcN/zkqpflM+1XBzY88dI7tvJudmSxUfvK75
        1CdV9cOu6dG/FlflaNXJN8z1s7n15KrD+0ubPrlue/r22dkZt8WCWotXLo7/9v3k5cf3fNY1
        enVz3q5wm2R2wqzvyXclluKMREMt5qLiRAADN8XXoAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsXC9evXP13n4OnJBp1vTCy6rnQzOTB6fN4k
        F8AYxWWTkpqTWZZapG+XwJUx4dg2toIW/or/CzsZGxhbeLsYOTgkBEwk3tyR7WLk4hASuMso
        8ev8YiYIp4NJ4k77cmYIZxKTRMuJ84wQznImiYd/FrJ1MXICOf8ZJf5+KwJJMAosY5Z4+H83
        G5TDKtGx+z4rSBWjwA5GiWkv00ESLAJbmSXOX13FBjFrEZPE84lXWSCcR4wSu9/tAGthE1CV
        mLVzPROILSIgKbHt8StGEFtYwE1i8a5f7BBxb4npR9qhavQkfrQdArNZgHo3H5kIVsMrECPx
        eMZBNogzxCS+n1oDVsMsIC5x68l8MFtCQEBiyZ7zzBC2qMTLx/9YQQ7iFVjCInHvzQKwg5gE
        JCT6l39nhhhULvFhdw87RIOsxKX53YwQtr3Eyx2HoIb6SmxpugsVl5NY1fuQBcKWl5i26D1U
        r4zEgxvb2SYwGs9CchOErSOxYPcnNghbW2LZwtfMs8D+EZQ4OfMJywJGllWMPJ6+wb7u7s7O
        AQbGAZsYgWlB2TDEdwfj20mZhxiZOBgPMUpwMCuJ8KpqTEsW4k1JrKxKLcqPLyrNSS0+xCjN
        waIkzivdZpAsJJCeWJKanZpakFoEk2Xi4JRqYPQsNc3gYKlmTY19GsXql/nJt9Cexdu4QJKV
        ycb4lcKlXkWZFyYRAZ+lfB6+2xegdfr2dw6e5uVNov3XfXjfdFs6eagbzf5/JPHqmu7Uiefj
        y60dNK5rPw9uMaqXTKtpCfwzWU6LucB01yXRfQ07n53xiViSlvOt8ZH0DP0+Xye284FZ4VZK
        LMUZiYZazEXFiQCpyf1S+QIAAA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git clone has a nice branch flag which can take a branch OR a tag; this i=
s very handy for shallow clones.
But it seems that it does NOT take a commit hash.  This would be very use=
ful for cases when the version you need is not tagged.
Any chance this can be supported?
This message is for information purposes only. It is not a recommendation=
, advice, offer or solicitation to buy or sell a product or service, nor =
an official confirmation of any transaction. It is directed at persons wh=
o are professionals and is intended for the recipient(s) only. It is not =
directed at retail customers. This message is subject to the terms at: ht=
tps://www.cib.barclays/disclosures/web-and-email-disclaimer.html.=20

For important disclosures, please see: https://www.cib.barclays/disclosur=
es/sales-and-trading-disclaimer.html regarding marketing commentary from =
Barclays Sales and/or Trading desks, who are active market participants; =
https://www.cib.barclays/disclosures/barclays-global-markets-disclosures.=
html regarding our standard terms for Barclays Corporate and Investment B=
ank where we trade with you in principal-to-principal wholesale markets t=
ransactions; and in respect to Barclays Research, including disclosures r=
elating to specific issuers, see: http://publicresearch.barclays.com.
_________________________________________________________________________=
_________=20
If you are incorporated or operating in Australia, read these important d=
isclosures: https://www.cib.barclays/disclosures/important-disclosures-as=
ia-pacific.html.
_________________________________________________________________________=
_________
For more details about how we use personal information, see our privacy n=
otice: https://www.cib.barclays/disclosures/personal-information-use.html=
.=20
_________________________________________________________________________=
_________
