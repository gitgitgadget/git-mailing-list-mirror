Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBCAC433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 06:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiC1GDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 02:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238215AbiC1GCy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 02:02:54 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2047.outbound.protection.outlook.com [40.107.215.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF5551593
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 23:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q46IeqNn/euGWzATEugb8LmTf1dzjOQmXOnecY77DeaGyeZAiA/MBkoyFgDd8a2retCDFsUShJvrvl9unzjwOc+TTjIWo+XSz/RGSymnVjI4OeWSmTIHP8wkw6K4l9Xi93m/f543/1bDIfpXi1B66YkZjFMdUipOtI10EU+MFr5mphw3bprNlRHCUecJEZ+PxygpPWQKPpNuKomg8DESokWfbFUenxgxqvgRnEwRww/b5qTdw9+w0prbHoXcTqlk9RsC2kvGwouJTGVKYT9laO6z4R0avD/x91Sff117QrlA9c8DeeU7SN3LzMLtrOhvN1RVeLCTSxqvh2Q8BGoX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FK4sWye4SSzQpEgyHTQc9XorN/yrnt+ji+qET6EmJ6g=;
 b=XVNQ4Nb9FHApSY/yJ2jouIPPJIZsHEkaXFFWYU3tKm6NF/7GrWLhC5h/RufzD2OVdD5b0s12d1I3YlmVTSsW6eEAoHp7WpFGqAEqUXjPASmpsIiQerquCfGlUzPsg1VqoeJ7/etKFZfAv0a3vUt27h/vSpcOP095yNfsEqF4Bs7vFD4+jr/hLCbx3RgyulNGPtXLIjA93QvPc3nKfSFd1fhxAKM72txHsxdKQfY7QxjEdykoC/V5ex5yUOSzMgop9WLrzBgMoTGO1BReXgVKfsRM+QFex1q9veno51N2vo+monYZ1VxBDs2jfGVhALk0453dg+VlH7vqcvo2sL1jIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pmease.com; dmarc=pass action=none header.from=pmease.com;
 dkim=pass header.d=pmease.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gitplex.onmicrosoft.com; s=selector2-gitplex-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK4sWye4SSzQpEgyHTQc9XorN/yrnt+ji+qET6EmJ6g=;
 b=KSmLjIkxc9PW1QvefTDa5DpMdmnI424NHWhhNVvaMzuq9Tlm1R9+jt3ONKdwuM1hqEiGf7Z/1UqWihNWsNFIfQFNF/J+vbauh9f8rQmN12ZCKF/MBXrlN4B2UWAcVRqqtUar+HKhem+MhPwjLXC1lJ8M1xxbdgs27OtFBleF99I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pmease.com;
Received: from SG2PR06MB2966.apcprd06.prod.outlook.com (2603:1096:4:70::14) by
 PSAPR06MB4247.apcprd06.prod.outlook.com (2603:1096:301:80::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.17; Mon, 28 Mar 2022 06:01:08 +0000
Received: from SG2PR06MB2966.apcprd06.prod.outlook.com
 ([fe80::dce6:c14e:154e:242f]) by SG2PR06MB2966.apcprd06.prod.outlook.com
 ([fe80::dce6:c14e:154e:242f%5]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 06:01:08 +0000
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: How to get the original raw commit message without removing extra
 leading/trailing line breaks
From:   PMEase <robin@pmease.com>
In-Reply-To: <xmqq5yny62s1.fsf@gitster.g>
Date:   Mon, 28 Mar 2022 14:01:06 +0800
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DAF0ABA-7905-491B-A1DC-291A2D7C2BB4@pmease.com>
References: <1BEBB3E1-0089-44CD-8D3B-3AA424C90E48@pmease.com>
 <xmqq5yny62s1.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-ClientProxiedBy: HK2PR03CA0061.apcprd03.prod.outlook.com
 (2603:1096:202:17::31) To SG2PR06MB2966.apcprd06.prod.outlook.com
 (2603:1096:4:70::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26f0b7e8-657f-4fb3-78a3-08da10805a47
X-MS-TrafficTypeDiagnostic: PSAPR06MB4247:EE_
X-Microsoft-Antispam-PRVS: <PSAPR06MB4247A38A4907D258D3FDCBD2C21D9@PSAPR06MB4247.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgTftHgHTYdmKr7Mf4mEoTi6A4KHG3aYzIVItVCcokUuW2lqAw3LJkumoqyC+2gu2QPh3fv22XkqPHw1lFMh+Vwd2BwDvM3aY9WqWv8vKy3sPbCUltiXbkToKIVAFxrAHpgJaXkgpc8SKp6dbOIIdY0pXD0QXK+R0N5IBH41D7AI9wmr6LiX0+EO2qQQUqVoWsdUhS97G6KJuauLtjYKP5jVgqS3duFPV+/Iv77KrfVDkRATLgJTRTqzDkcXroQ/5RSp6mmqLzLoNWWkT5E6HSMXqS3fFzSfuqOpgqwc1bOK9fKsv3bnh5KOS76Z98MLW2ZUMUPx4EiJYq3MI4PjQN0bM2kLGWulTMX8Z9vCGSJ//BsiRlBb698LYlUpNZrYJyQpt9wSoq6Q9bl6dhGUBFhKJ5DliL/29LRdhYut7DmV1CSGhUfVxcvaU+TfViSvnCTSU9RzKUfErWkwnOYxUU374Bz/507xlA2xtEqmjL0GeoXSUnFMPD0gQ0SU6sLztZf3CTYYnDJy2GnC1KEvnEQdi+u1719Y39Ck0LELUcTLkBmcNHuCIbKyjIqupX6bDXMu2iQm4oTIdtoB22lddcbNpPaD7jPmQtCkeGZApTATrejFcaEoorxER72av/R64g+vSsfvNbo5fPeuziYQCcgZZo0oY9emdXc0DQWcag/1z7BqqPT+eFfcIxskOyQihkJT9jhk2ql6W/Z8H0PBfg6PTZleRvKeZn221LCJNh363JIMxirZqJ1y2OCu8RY/oMBIzq13qi2tr0Br/RoZdF625Vh6+W3fqQLlIJggx3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2966.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(366004)(346002)(136003)(376002)(396003)(38350700002)(38100700002)(6916009)(33656002)(4326008)(316002)(6486002)(66476007)(2906002)(508600001)(6506007)(186003)(66556008)(86362001)(8676002)(52116002)(53546011)(66946007)(83380400001)(4744005)(8936002)(36756003)(15650500001)(26005)(5660300002)(6512007)(2616005)(226483002)(15583001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f6O6Q3zfYpFIj3QnZrmfLnVoX8I0gM9O8IFrD5xgHcxgdySYoGWIwHEPsith?=
 =?us-ascii?Q?NKo/ugs0+HKafNYfaEkit+pvRQN8dNsa+FnqDuOn/o6dmUbij12Va+runhSR?=
 =?us-ascii?Q?g7sMyiUHfskdU3sW6a7kWTG29GoBfO9AaBbbxio7vNzalci+8aSYg7f6hlsL?=
 =?us-ascii?Q?zhjDdVvtH2UHJGUn0jnYFXulTQhVePEcN1JWeDFdHS/ZSTFnkRheyWeiVTFf?=
 =?us-ascii?Q?MrECJ4XE9TF8BridLMV2g6r2AuAkm80qTUkQTwKPN0OXJt0zaIpFNH5UENS/?=
 =?us-ascii?Q?RECYQ+cTUL8ia/6ukOuSxf1xPjjfC7MFXq1w8ERqWoTbQys8A7UV2I9vIGTn?=
 =?us-ascii?Q?GkQZ4uGU7FhgKgsr5iESQ02/2Y3TW5KfuzeBX7U0wCZFnaS60Z6oQXsJ4nJe?=
 =?us-ascii?Q?k9MhQEhHAsYX6efnk3sQKLFrItOJv5LpoOuYvxFIclumCii6fKKOkaslh748?=
 =?us-ascii?Q?pFQWiseNtxTXtdycTXA5RKUg1cmP+SnTKAxoCJG+hqDFevuF3g5b85FuTR+f?=
 =?us-ascii?Q?Qg1TFL6yKRypqZrKKo1avcoV+Bwdq+Gfuf6tdosS7iqM0ywSpjydNZxcHh5Q?=
 =?us-ascii?Q?VNzEI+lXG0b1r1zIr9wlEzYg4ZxMPgdGiVnneNKnEIrzI7ySJH5y4inmEJSE?=
 =?us-ascii?Q?D090SvE+rYxwWvoEdxhuPCkNaNUNBfOxgro+5hbBL6gdxKOi5pyXEKLDBxZq?=
 =?us-ascii?Q?dxUW66f6oA6z3SmHJyZJu7xu4p0vtrCdC9CQVr4gyfKr9OWyAxaTZKjAZ1I4?=
 =?us-ascii?Q?LEko5hGUZRrGhTBGCf6RM5HWlrFj02QD2p0uyqqoh3kKpWyrPP0hA874GTv2?=
 =?us-ascii?Q?EKUeB1FLuao5kCtaSv3j4WaKEoNdBiblqK2oNWj4/VsF+md+3hhpMPXReaxz?=
 =?us-ascii?Q?QrVIPsWKt7ljwT6PMrFwybw5xyPqCATj5vJyHFkTFGNf52J83Hfb3T9kXrn+?=
 =?us-ascii?Q?7pzXBJdY0mEmUauSIDNQ+wO+/bFquG+fLA48BjzYvf+QmzDAtkyPeRGry4R2?=
 =?us-ascii?Q?mdFreSMrI8Ye5F6C5b2u2GTIsEif4bz4MvC3GBA+LAwtD2BwxCyy4VkGlO1P?=
 =?us-ascii?Q?GrfCVFz92oovJ36WL2tPUpaBx0jM40k2E3YCKBeU3vBH0C14VFygIRj8X2Ki?=
 =?us-ascii?Q?5lLqkqVc5Wgcs155WKmW4P7RCH95nVibfwMd8Z8N/QHUEQMFGk+Dc331hDCr?=
 =?us-ascii?Q?u0eSyERxeFEXsTQ+1SaYZRfhZObmADtMeKZy0QOa6AA79ui3jMKHKK/D25Qw?=
 =?us-ascii?Q?F/t/BmWbmDzBBplc9wlvyWHSB9WP3f3/nuY9mNS5LDewnU/EvAG8Aq1t8b5W?=
 =?us-ascii?Q?XfHgRo+JplD1MUqcmshdIplvR0hsVNWycwuN8ApLWsZIs1czwRt5FNnxwe/3?=
 =?us-ascii?Q?LaWpRSyv/PNevSrhz9f2gFc7QcD2TLZZwqkCY5F+HEerYskkOgrXgtG/HCIL?=
 =?us-ascii?Q?QCp729wfgaLjpA5fQ5I64Fx/KIfB63/FzwAyX1wl2qNgwfOciHCSMsTzvVYq?=
 =?us-ascii?Q?h+aHq9ag4KDqU+KwSbiDsi0d4yRGSp87MQKH6MnijAz8fX7B1FeL2d2EtsEh?=
 =?us-ascii?Q?kxDNTPIiDVQ/kFnCTpRkU89Gm47yOO+o5uXwfdica6H/igtg67C01TlAlx5R?=
 =?us-ascii?Q?99W4gaZu7BJnGpJ7VCOSoqZEYNA6SnxpRaLYp5ZXwbPpBnnmUBzNDTSEUpCz?=
 =?us-ascii?Q?KfCK0XUyaM0k9qhBWkAlctOZci0mcCIcchi4e50L8VPMT3KcJSqKA1t1Swo3?=
 =?us-ascii?Q?HaxtjqErsw=3D=3D?=
X-OriginatorOrg: pmease.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f0b7e8-657f-4fb3-78a3-08da10805a47
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2966.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:01:08.4244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1cdecfba-7dde-4cf3-9831-7a4189f20315
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSthHBMf/0bD3qGLTmvBoJPxdxrb6n+pY2Gc86Iwfkv2ueBSQ5Das5lyHkg4v7CMxiwVOZIxSAPtPDY9cuM9jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4247
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,=20

Thanks for your response. "git cat-file" prints the commit message without =
leading space on each line, however extra leading/trailing line breaks of t=
he commit message is still removed.

> On Mar 28, 2022, at 1:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> PMEase <robin@pmease.com> writes:
>=20
> [jc: wrapped overly long lines]
>=20
>> I am using command "git show --format=3Draw <commit hash>" to get
>> raw commit object in order to verify the GPG signature in my
>> program to customize public key loading. However in the raw commit
>> object, extra line breaks before and after the commit message is
>> removed, which cause the signature verification failure as git
>> generates the signature without removing those line breaks.
>=20
> "git show --format=3Draw <commit object name>" will not give "raw
> commit object" to begin with.  It indents the message by four
> spaces.
>=20
> "git cat-file commit <commit object name>" is what you want, I
> think.

