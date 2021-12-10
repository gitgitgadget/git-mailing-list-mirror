Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3E7C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 10:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbhLJKp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:45:26 -0500
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:32768
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236065AbhLJKpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 05:45:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JU0O5ZrzL/9u765zNZQtWuuqnRmXmSMGrazOaHPW8qmL8t2z0xbl406iv8098OCNlOmnx+pc0HUZoxz130qhBAyyrSHrhjwPTFKPDVbrRzrrDpCoBRIBaA63yXt7XnLS9aTGo0L9SmyqkePdbyMbtb/91Yu12fXOgBRdjENL7+TOADDXRKLQpE7yBIVDUueCaUnLvlBv7UkFC6cfjJ2VNFBhBkz9NhMdB4cZ54afb97BCZAeXzOH2LTdr6mMbs9pJmPh2zby1omwaR0uoG6YeO25DRJb0IviWp4WgYuNInaXOCV0n/ev4DH2Y0ZzK6Bq+004vwIG6I2P5j5lN0GJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hl1ozJ1kXhLEXZLu4w5rM8Q7GslNHZURS2XIHxFHfDc=;
 b=PqPWQxZXrYvT6ANOAx+hKcen05PUZ9JS9idXQkyjDKlUq1/ApdMSkRj9KuZ3Z86yOP3I5BUST0q1uB2guonIT1mn7tSqCvrbOupOcVp3YVRdXVgqhTNuhphQQ3Gvilxt9/xX1q8AryackQ9LKwSxg0hMiVT7Xj191SbPgyWGHyn/C8Po/rzRINwb7muVXSU9BpM7719RA+zZX78QmhUn5xwM16/Xaz+k95iRjxAcc8QVeqsDIAF3lNzw4QmBnZYUDcfU30HgY8ewIzmQiL2wc53UjqN87T2SckLG4VD+R4N6foqH4zprlWOyHR7jK4iyY8svrfLy/HixMcOsisATKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl1ozJ1kXhLEXZLu4w5rM8Q7GslNHZURS2XIHxFHfDc=;
 b=qh+/RRbrt6eFPiKWoDc/DAKD+Qo25whRxBrNOGpoRHXrLRuMsUjg66cURoAJKUC0QW+AEoG5GVhJzleRayeXeDv2cnvxvNs+R1UU5+wIHv9/q3Vo1rjOMcqHJU/F8eJh3inEPD69W44K6uVTE4geJsmw38e/bjPEoth2qTTvM0vE68sa8Ahic9PNV9Op8/SNNL73W2vZSwVKivgCrpuTpcg7bBvLVe2DQ0OL3478z2Th17lYyZDc8kEVh9lW+wzg7j0NgHEIycjpaLGN9zBXTVJdmuDUedkkFjXcVnTZdhUnU3uZw0v1UIqRsGSokL7aQLF2ofdkQF7Pc/XKuPSnEQ==
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1699.namprd12.prod.outlook.com (2603:10b6:404:ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Fri, 10 Dec
 2021 10:41:49 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4755.025; Fri, 10 Dec 2021
 10:41:49 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH 4/6] git-p4: Decode byte strings before printing
Thread-Topic: [PATCH 4/6] git-p4: Decode byte strings before printing
Thread-Index: AQHX7TjegWc0xX/84E+r8GjK3oN8BKwqwwUggADGyuA=
Date:   Fri, 10 Dec 2021 10:41:49 +0000
Message-ID: <BN8PR12MB3361A80F11E68CB4808D7423C8719@BN8PR12MB3361.namprd12.prod.outlook.com>
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
        <20211209201029.136886-5-jholdsworth@nvidia.com> <xmqqczm5o0pa.fsf@gitster.g>
In-Reply-To: <xmqqczm5o0pa.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0bfcc7f-e141-4e2d-4b84-08d9bbc9abfa
x-ms-traffictypediagnostic: BN6PR12MB1699:EE_
x-microsoft-antispam-prvs: <BN6PR12MB169933D604231D601B6325C0C8719@BN6PR12MB1699.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vdam0lvIjLrjfSjUtIGsD+e+4TsxMoBTsMUk+4dtIN5yoL2KHsLH/myKTCJAv1DfVhEBMRqrg8cX2v0kbG1i4THKeK2sQM01opHtoBbGweb0w84LmwJn/+RfytqGHl2b/uEz+SlFHj40sHECh0Hbgoy2Qw3SAnr5XFEIsXba0OMFDSJousGoyw3LpP9dUNg5BwvocphP9FTRNgc1XwK249NfmeS5qr0X2LZOxJr0K9V4T6dZDIzHk5mEXrbW3xwFIdGVCBj66OVIL3zr+0phrlKCxt+TkHaYMo4UJfHRUnrLNEvx8O8kGlW59FwhGIUE5q0Osq8fYg4/a7OctnW6R8kP7XPH503a49EOjYJsyQdOdzgA3p76B01uahAr08IaCXPwuYI0WS+MfuBFlhzahImyV8+aMFvYoQJUN7FMX7OPt8R/3dH8hsv1Rf7F5Hv6oHdaDOPfp4wwEvJKyvBtilqlAv8Pja/dKknqjf9ap8zfnKHWIVXRiXKLXgpIAMO41/AXNq8PnGX/gZg7ejsXG1TFErgAsB8bzSQBy/y12uQUUPOoMPU7qJORl8A9f4r5YjXYZwHrjFrxSPUHciRAJcbW/oiwYcNY9cGRq4aJdMP3T2aPgjRH2U6hOm/Y1TBIXxgYtuYCxch5Mm/qke/xdVDO97N9935nhRuT7QWlnveMfirni2yCnTBOtp5tutr98f71rEKNIxkLfQtQIVfj8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(83380400001)(38100700002)(122000001)(316002)(71200400001)(4326008)(186003)(8676002)(8936002)(26005)(4744005)(6916009)(7696005)(9686003)(86362001)(2906002)(66446008)(64756008)(55016003)(66476007)(66556008)(55236004)(508600001)(5660300002)(66946007)(52536014)(76116006)(6506007)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zcr/vxecgbTMW5qKaLePlzXWSHFBiokap2nHleS+yGL5n4SCLGCM27zyWyau?=
 =?us-ascii?Q?FElCbz/ZGnblbiAqDEds9Q6ZQ/nRN4WaINrRI+LFxOj5DtJMP57niFZO93yc?=
 =?us-ascii?Q?Yu1I9MUpjSAWpDV+wMt2EUhY7BakcC6jikGoFGb1rPwgDfZKXLe5PTi/pjJm?=
 =?us-ascii?Q?nwRwqVwOqL1xN7s/6J52sOsC3fSBVvrxehUKMDhEMgi4Q6PqbJkqqEdP+aC4?=
 =?us-ascii?Q?xJpMYFncECrwmPnBifjhYdmA0YvRaPmAcc8qTJFHFYf3dIrtZCJ92nKWCU9q?=
 =?us-ascii?Q?8E9xaLFkjh4XAlmcosVbTRq1M/pk/WhiKVB9Sn0ScVyunez6ef62VAuE0r3C?=
 =?us-ascii?Q?E81DW+HDHoDlmsd7eDS0hfp0hOLmY+ijIulF2w90G7tIH2wycL54FIdmjZFK?=
 =?us-ascii?Q?5ZwKqnhlAPYYOErnw0HL0zoFMQ1mR5uQRZweApnffCl16R8mGssoGCO4f5KK?=
 =?us-ascii?Q?5AHZxpc4XlNlj7NcR38uHiNMAHP9QmIMvkxWD8bHdpDI9tuw+a31up0So+v5?=
 =?us-ascii?Q?Ve4P7/1CIN2pJdob+DRSNcAvXxwVTQTuEvCnPg5gRp40PRdxK6Yb5h0SwdMt?=
 =?us-ascii?Q?aB5OZzGWAyImsxkorHXYyLfPISRtFji4Gmm/9u1zhWG9tzzP2laU9FKorGGv?=
 =?us-ascii?Q?Qjbu+0fU2ARwrtwTFYF/77txNBNLkm6WVVbYwOvE56OVm6aZdfBUo/vBhjuT?=
 =?us-ascii?Q?AftcSHknvBtd5ZNKgZJlt9iHTkezE1gPJVlHRguhRBoX/a/mr0DaHWggpKOk?=
 =?us-ascii?Q?lYHuUecH/+ZmBdIfQ9+XVlPehlrKiR3CFIlIb/ey32y818920B5k3FEnO8BP?=
 =?us-ascii?Q?z9TATFYWRMSxr1OO1W8eYo3xTwQ9i18Wmmp6DA+Iuwn/KWAhMbmqGZ1QkfhR?=
 =?us-ascii?Q?8zBI/V8CCGBCWesvv3RRJKI1l3AME7Z/Fl9cZDh02KWhAjxhRs65CPUbdzKq?=
 =?us-ascii?Q?tPf7flEaavUqr/Kz/927SidS8i0DOnsOfBBMwaHcnURVtGr1vBRWCIpAwS/i?=
 =?us-ascii?Q?QgXaLKZGr/27T9uwtZ36f9w41bPIQDXbooBLK170VYtaulaeBltjE/3L9Dja?=
 =?us-ascii?Q?/vOxZIlDP39/yocHZj4VZMAtVVmQBa9gJJX7AbU0ZeoK+yI+n6Cy4lB1lx7D?=
 =?us-ascii?Q?bdpZotUhHyM2hOpqDmK1Px2DemUmbchFlLd4tZEeH8G2/pKqO3oZwVujshY0?=
 =?us-ascii?Q?i9AAjG3d51gdADArp8vClYxIR1j6ARmQQZ5gf77m3nbg1gzoomhOgC1jau3F?=
 =?us-ascii?Q?n980QUtgyAUyIbgxqkaipif398ISwEp2GqlUcaTDkjxEC1yIvLxRm2/S18wE?=
 =?us-ascii?Q?CrFQCxmMtTLL9fWW+2zB5sBoBjs15a9cUnf0if2KS1o9R5oEVDtFHUP7MOt2?=
 =?us-ascii?Q?X7s1Sb+Q1HfnBiO8/pEcVXLXyTeipSa6YgvFF4JHagL3GrJ/tzRWEplKncb2?=
 =?us-ascii?Q?G7K74BxL17FenslkhKnoVwCw6bhFvGp0VrXOJY+GV67zAyeDzD5CsQk6Hk3n?=
 =?us-ascii?Q?rtR0Zq/9PLFf8NvvjItAB9XqwJH8Onfma9+ftBDTbcfUCfsZZV7ZeBU42hhh?=
 =?us-ascii?Q?yJNBg8Sg8Qd1T11O2ZB6JLOo28PtIPR77Aow8eujVyBstiZjPkvRpnJuXtK/?=
 =?us-ascii?Q?nO6ksn8mD40R/+nBl677A7Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bfcc7f-e141-4e2d-4b84-08d9bbc9abfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 10:41:49.7184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JmD+7YlZTdhATBf0kHco31w75yRrEdpQRA3VqYxF73DxHUDhwTXrNXZgc3rBGQ6bzUgHDXqh2LB5O+1bW8nZ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1699
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Is the use of strings with {} placeholders and their .format() method int=
egral
> part of "decoding byte strings before printing", or it is just a
> new/better/improved/subjectively-preferred/whatever style?
>=20
> If the latter, such a change should be separated into its own step, or at=
 least
> needs to be mentioned and justified in the proposed log message.

As I mentioned in my other message, I would like to invest some time into t=
idying and modernising the script - as well as fixing bugs and improving be=
haviour. If I submit patches that only make subjective style improvements, =
are these likely to be accepted?

> Lack of explanation on "why" is shared among all these patches, it seems,=
 so I
> won't repeat, but the patches need to explain why to their readers.

Fair enough. I will resubmit.

