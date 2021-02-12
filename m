Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ACFC433E6
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 15:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B898D64E39
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 15:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhBLPXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 10:23:06 -0500
Received: from ndjsvnpf103.ndc.nasa.gov ([198.117.1.153]:39610 "EHLO
        ndjsvnpf103.ndc.nasa.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhBLPU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 10:20:57 -0500
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=2a01:111:f400:7d05::208; helo=gcc02-bl0-obe.outbound.protection.outlook.com; envelope-from=thomas.c.doggett@nasa.gov; receiver=git@vger.kernel.org 
DKIM-Filter: OpenDKIM Filter v2.11.0 ndjsvnpf103.ndc.nasa.gov 1551E400AD3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nasa.gov;
        s=letsgomars; t=1613143209;
        bh=Yoauo6wgseQHqW32uzJFAdRfCpX54Olnn3BeWjRIW4Q=;
        h=From:To:CC:Subject:Date:From;
        b=RDYDFQRDKa+OMIx1cMliNwm+Dp2pXvqffeoVCk126BXLwwiXMHxJseX8LLV9Cl+OY
         vfncYhXHmGe0ft56jJ9vPxqNBuGC1VR2xcLKQFjiO+yB8EQIaQtyMGEljIJh59PSNJ
         ove8dYoXSDzBzKgLRqPSHqb1GMMQBXi4PVV38KQ/KovC6qw9JVrFmJ/qmsR3xxC2da
         F4mL1AwAVscZJxsjXuNp2KzGJMaT0zBTFR6DgF4naN478tMpO3FMdF8AK3Oyt/Rf0k
         prRUg0opmA/ls/D2Fr3ZujEYFvmeWF+qSAGdBH47khl5LO/Kzc2kAu5CC1QIYHOeSW
         ebxVc6cMthqvQ==
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (mail-bl0gcc02lp20208.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d05::208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ndjsvnpf103.ndc.nasa.gov (Postfix) with ESMTPS id 1551E400AD3B
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 09:20:09 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4SQMwJB67NXTtMwM7bDfqBUBWClxu5IQzSeJuy5X29Y91qoA0mWnNtxYmaJ8bbiqnqUIjzDM8Tc1mPM6wtyJTUeLSyBrCsNVf1L+/5EqifjLSc3TeawQdEKkcWUstkSGi64nj2Sz/KjkAvzZYnr1EZPCc6B4sRYoxy7a5rtuK+JKStVqRRD9dmOd11uZTeD+PKwTYGeugZ/wnEFuCg6WWrgf80IL9bSbDmY7Hw8fK/zkjdlXu0BU4pgTPLMqcPeDANdlSUIiojHdbCly1E01zI7JjInOehbU2ke6pNQPWNHjB/8hnDhzAofK7iofAoTAlV1BOR9+NPe1x/v2qw9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yoauo6wgseQHqW32uzJFAdRfCpX54Olnn3BeWjRIW4Q=;
 b=S6B/uZ8LkI34ycIpNdtYWomiCG0f/S+ufB5EkNn9dRcXUFBN5qoGfLY6EmcflCBKb7gcvzQU2w49zkO+Y32SeINe9ZpRb65qBFoHAec14zZgV6f0L29RLpzFdMFeRtrEpOC/x4BQCJ/yLj8EQUmRNbQiE6sG8z1KJsWA7FRyg+vBecevnky5WEBliXkui8GMjhxsx9X6r48Gg8KakYcrmYwvbARNK5dM9rsH7FyLCloKPFR3200XPdvlDfkTJkrU50VU4eFfmhdcpTQDawtaAKh5P/kyedUmVZ42FUP0C3p/ryMskRwJHywtahCBTVod0BWfBVrjqGNBP1QYCl7kpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nasa.gov; dmarc=pass action=none header.from=nasa.gov;
 dkim=pass header.d=nasa.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nasa.onmicrosoft.com;
 s=selector2-nasa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yoauo6wgseQHqW32uzJFAdRfCpX54Olnn3BeWjRIW4Q=;
 b=Sup1Gm0kzMeV6BljGNeTF7+tn8JXX8qc68+A3nTNn5rYvAsPFZAmKCgb3evbCUS8mEj58Q1nFgVg8qGneIyMJti86x01TkAQK2fNh3P1OeEme5QBux7U8W/zmcFr2WM+853Tjj1L1IuhcGmwy8roU3lynUoz4JGqQhEkEb72nOQ=
Received: from SA9PR09MB5807.namprd09.prod.outlook.com (2603:10b6:806:46::19)
 by SA1PR09MB7920.namprd09.prod.outlook.com (2603:10b6:806:183::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Fri, 12 Feb
 2021 15:20:07 +0000
Received: from SA9PR09MB5807.namprd09.prod.outlook.com
 ([fe80::8490:83f0:a8ca:1ab9]) by SA9PR09MB5807.namprd09.prod.outlook.com
 ([fe80::8490:83f0:a8ca:1ab9%5]) with mapi id 15.20.3805.039; Fri, 12 Feb 2021
 15:20:07 +0000
From:   "Doggett, Thomas C. (GSFC-705.0)[TELOPHASE CORP]" 
        <thomas.c.doggett@nasa.gov>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Zhang, Cynthia X. (GSFC-705.0)[TELOPHASE CORP]" 
        <cynthia.x.zhang@nasa.gov>
Subject: inquiry on Git GUI for Windows 2.30.0
Thread-Topic: inquiry on Git GUI for Windows 2.30.0
Thread-Index: AdcBUoCz/jMQRIOwScuB9edroXD0Tg==
Date:   Fri, 12 Feb 2021 15:20:07 +0000
Message-ID: <SA9PR09MB5807B61FB32C4865C1A2246DB68B9@SA9PR09MB5807.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nasa.gov;
x-originating-ip: [192.92.191.143]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f10955c8-15e1-498b-a23a-08d8cf69ae82
x-ms-traffictypediagnostic: SA1PR09MB7920:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR09MB7920B6DF7C8439DEEBD63CC0B68B9@SA1PR09MB7920.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EPbWPkdrerw5m3SZ0wWHteHYEa13+IlSHVKXcE6Mfc+s2cC+jIfNs9wDk2xXEiil0uha39Bwd/vBkDWy+SEKAt8U58dxtQSvRL09XMv6dGI9HKQSo1Km5/lh5O/EXzHWGB8NBfd7nFxT6kSu1+Og6sQNOy4P23Q0E+0j5k7Vj4t58tKnozdSl7kPGPw9q2ZNUCN39iKib11AWE3UJIAO+Dx8R14pgEI4YrNOUHrGGoymRWjOXdz1gJ96BwISQ0g/YaIEmtz+hVuP/wTIysyIX0mS6ITZJAvBRqLVhlSZ9KSjOaOqegiPjXCO7nCGSJWmJTu4g3xq3spF+77B6d0ZIsP8LP3qJYucrxhqBBN3LMWrR+s2/vRvkLAHWv4TuKPoYRpicHRf1AZo9WAG3ztkQAzXFXEJrMtUwv+UeevutDZGaInuBkkPWp2AV+p51hBhCeGqeX0ZFViycbohqVaZ1O0H5ddISfBRRu/vNn9BaWxKfbkhYvDCbz8wZ3xeiVC/s2Qay+z3sk9MZfWOt08aI2HtFTqN8/KX+UgFvLLARL0Cbvwk9b7SGrLlRrDE39FX8UiVKmgpZQHWFe46HE30Q3xPtVRJpldqldev+LvrZlqmmpdt17OF1/03mii4UB5aPi0mMPZ3DMn8swlFRO1myRFjqu3r2AFuGkN3AGg6AzU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA9PR09MB5807.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(9686003)(2906002)(66446008)(8936002)(4326008)(66946007)(66556008)(55016002)(107886003)(966005)(6916009)(33656002)(316002)(64756008)(66476007)(26005)(83080400002)(478600001)(186003)(5660300002)(83380400001)(76116006)(52536014)(8676002)(86362001)(71200400001)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?B+VaJUuvOiouh3jPt8dwKcI6PXKfxEuYpNNsXboJum9j7UFPs+f1PaZ3Oe?=
 =?iso-8859-1?Q?1dShiRnTRrDrnp+/gHkAzggs+HZBdiUNWv6O8z+WNMT/oSDn77Hs7VA0Vm?=
 =?iso-8859-1?Q?AyT0iyfuT6N2MYoqGNrrw+TrOSQNgP+gJXZ8o4kbyibXbGSNIHColJZi1w?=
 =?iso-8859-1?Q?jxLh9whL7Bec1uRN2BXi3utJNEp2MOK+rFgaeQ27huLgmKt3tnCsDhpgIo?=
 =?iso-8859-1?Q?yUjl7KIDt+vSslwQZ+t0zgq7VY5jAIjuibKn5X994+GscBcgytNY4KI6ya?=
 =?iso-8859-1?Q?U9SHu8M8W8PzDUz4aPvo2/Hmh2sXL0Cv0wbAedktjH/8OcO+iKzEBUS2WR?=
 =?iso-8859-1?Q?T7yKsUw/kUv/aDxRJeHlbh4kP6mtcJzON7rZgw455gH0YLnSONvlwXKxYw?=
 =?iso-8859-1?Q?l8pU7cyJ8vzQYCophhy5GZwGhsrtxkaCUz+nl5Ddp/yh4TCF82FvGq468Y?=
 =?iso-8859-1?Q?B86VHWTfvoXCKiz0AaoyNR1MaSnTh1x1OASBiZ6pqrd5cgFOCocq/oreup?=
 =?iso-8859-1?Q?1LmJ/oFifBfnmKE69gNx1s7JwVbwcf/wyTOqoRGACECQmp8FCG8l9NTSBC?=
 =?iso-8859-1?Q?6FmVUY4ccDVjn1QhcDMvO7VaZsqkM9Pqgd42QX1hVjWF88sKXbIJxh4IMT?=
 =?iso-8859-1?Q?77KzorayvCs+6wuhokD7BJzUh9JFyE4sMtqZe8TTVk6rBPJ2qsd1ZSbqIt?=
 =?iso-8859-1?Q?LJNfZsgue4QLlPS6Xb805eblRnbusTYK1oSDI21UyXJ+8k20b8L3G93NYq?=
 =?iso-8859-1?Q?Yh5ei7wG3rZXoJP4pwhHUpT6vcsgJVLwCn0x65B6YVVyx3KbBfZ1UkkbRk?=
 =?iso-8859-1?Q?YQ7Qr0YQv0UlZB567mxwDtgLQYJJfzS6gOwfmmEmS7FzkTpd8aDFGjSsZs?=
 =?iso-8859-1?Q?gMBHhhTvSibviWGURiTd9fJ6z0OnHnpTf9vf9uqEwEpxlUpSzAJ8Ov+7jc?=
 =?iso-8859-1?Q?T9uHg0g8MOmlBm7wcRu4IEHj9ppynE3LI2pYLUR+MYan+8Y1Ye29VGshiS?=
 =?iso-8859-1?Q?V1B6ID0XWZNWyl8wlbQxkNHPqANIkl6QW6cz/+/Utnv0lO3ob+CFSdpdAl?=
 =?iso-8859-1?Q?n2dJMXu2TTvOCvMnihcx0knCRozlF/1BZ0kmdeAeBOxKPs8Sf86q5mA+Ow?=
 =?iso-8859-1?Q?sCDlJNfg4dp62s9HbpaVq5Goxj5WfoEXxcOPdif7WlAkEp/G4TUyCs+tiK?=
 =?iso-8859-1?Q?PG7B4hQyJ2WcFFSzI1FfaPdEUMVmo6cZnVA9+61MM/rLft3mv7VOwvvcbu?=
 =?iso-8859-1?Q?9n982BZ30xwCkjYyAZxdsMdUoCLwtf0jiW2rng6dv1f6YGuHfqoRhBoInQ?=
 =?iso-8859-1?Q?zX88j3z+JaTMMuze9JtONooZzJIj/j2ODbw5m9QwLSOpxarfFn7ngq5XNV?=
 =?iso-8859-1?Q?Q5fQjhR9+4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nasa.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA9PR09MB5807.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10955c8-15e1-498b-a23a-08d8cf69ae82
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2021 15:20:07.8670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7005d458-45be-48ae-8140-d43da96dd17b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUMxP1QIFmCKW0lYD2GcR04FesdKt3KaqaYkJvXcQ5IaF8/H5iS2emhd8C5PufPFraC68VJveOVFuJtzs71XQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR09MB7920
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,=20

My name is Thomas Doggett and I am a Supply Chain Risk Management Coordinat=
or at NASA.  As such, I ensure that all NASA acquisitions of Covered Articl=
es comply with Section 208 of the Further Consolidated Appropriations Act, =
2020, Public Law 116-94, enacted December 20, 2019.  To do so, the Country =
of Origin (CoO) information must be obtained from the company that develops=
, produces, manufactures, or assembles the product(s).  Specifically, ident=
ify the country where each of the following products were developed, manufa=
ctured, and assembled:
=20
Git GUI for Windows 2.30.0 =20
=20
If the CoO is outside the United States, please provide any information you=
 may have stating that testing is performed in the United States prior to s=
upplying products to customers. Additionally, if available, please identify=
 all authorized resellers of the product(s) in question.
=20
Lastly, as required by Section 889 of the Fiscal Year 2019 National Defense=
 Authorization Act (NDAA) please=20

1.) advise if the product(s) in question is/are not manufactured by, contai=
n components manufactured by or substantial influence from prohibited entit=
ies - Huawei, ZTE, Hytera, Hikvision, and Dahua and their subsidiaries and =
affiliates, and,=20

2.) advise if your organization has the covered telecommunications and/or v=
ideo surveillance equipment or services as a substantial or essential compo=
nent of any system, or as critical technology as part of any system within =
the organization.

Product / Service Description: Git GUI for Windows 2.30.0
Model Number	(if applicable): 2.30.0
Country (or Countries) of Origin: [[please provide your answer here]]
NDAA Section 889, Part A Compliant (Y, N, N/A) : [[please provide your answ=
er here - (Y, N, N/A) ]]
NDAA Section 889, Part B Compliant (Y, N) : [[please provide your answer he=
re - (Y, N) ]]=09

Is final testing performed in the United States?: 	=09

Recognizing that these questions don't fit open source software very well, =
will add that I've tried some workarounds - like your affiliation with the =
Software Freedom Conservancy, but their entry on SAM.gov is expired (curren=
t entries would have NDAA attestations on them).

For these purposes, the country of origin of software is the country where =
the software was compiled and converted into object code.

Thanks,

=A0
Thomas Doggett=A0
SCRM Analyst | NASA=A0
=A0
Supply Chain Risk Management=A0(SCRM)=A0
Office of Cybersecurity Services (OCSS)=A0
Office of the Chief Information Officer (OCIO)=A0
"The cosmos is within us. We are made of star-stuff" - Carl Sagan=A0
=A0
(703).244.8719=A0
https://inside.nasa.gov/ocio/security/OCSS/SCRM=A0=A0


