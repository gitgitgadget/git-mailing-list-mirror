Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0063C61DB3
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 21:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbjAFVvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 16:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjAFVvE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 16:51:04 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843F144C5E
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 13:51:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Khv8J+0RYXXE3oS5B5XO+jcpVesqfUHDu0fUoADgoZDWnrGV8EEPUTXRoJQf2tN53YjhCnEOBf66kteAt6CgkgsK/72tB3I9mfAVcOylGNcW5etnWL5qTQMSf3VmskC7W6UiAxeLJEP8zlbBkHOuRsqa6a/1t9yg5fVeK3UuQCDtqZ49Q98qJXCZ+blayik/905MtSBFB4dVzdDU+o+Q8ZDERgOobpaHB+cOHjhFQ/XZIsmTfLt8PEGrNWehxhu5yfyOom4PKD2Vv1ky64EjOVqKMKEI+zbQMrOH6HyL6KC/oel01N4LTUgdwUdGa7JAb5QkP06DDMc+ycDT/tgaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UP/CdscilnNH5JGx9hZi1xvY5QjNtjzHCPHkwwcJrHo=;
 b=Oh5tpRU1//a20h/BYG+Ry+gGI9ZORJCM/WpujKTzWL+fffopJXL6ABQydgX/prsaaz62MKWVVXpc6G2JVinwvJu+DmX/o6yMy1LBDNlCCLkYSr5Afr2Fa8ORYupB5eu8SHH7+GJK+lOXm5Xz3YctJ0xmBF9XkpbXTubADsiFWaJHh3ZhCzMXOIjc53/AucYo0p85PC9IWZoLzYBtnfxrRu2qCvrAfCewP3xRkRF/RDK4UU/6teQ3CucIcrj1CHAwfcQoZATV7SkURf3a8/G25+/brnrZQ0cNGHDHWrfrETezQJaJnSyQBu4rPpcUhO3DUVigWdVov3JVmWADQr4y+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UP/CdscilnNH5JGx9hZi1xvY5QjNtjzHCPHkwwcJrHo=;
 b=a2zxZSaVGVgKAnVQ1yNhCCrNz29dYWXgBdlGUc9jfyJ1wYT5HOEb7iRXIhBQTgh89rxktbl7H5PpI5D0zktpFVRhfOy+Xm/ugdBnSOaSVHs2WMTJ/BcZ325YvNFv3R/0GDFRvIZE1m+hd8kGeJ+DkQ/XD1q4ZrXWvpRmUlag80c=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 21:50:56 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::b282:6c4:7660:583f]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::b282:6c4:7660:583f%7]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 21:50:56 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Subject: [PATCH v4 0/1] Expose header information to git-send-email's
 sendemail-validate hook
Thread-Topic: [PATCH v4 0/1] Expose header information to git-send-email's
 sendemail-validate hook
Thread-Index: AQHZIhj0i5ZjbcTF4kaJc2fGWGCiJw==
Date:   Fri, 6 Jan 2023 21:50:55 +0000
Message-ID: <20230106215012.1079319-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|PH7PR12MB5976:EE_
x-ms-office365-filtering-correlation-id: e3b58360-b685-4468-a42b-08daf0301726
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K2vuRmLrW4KGrBlBhWSlNa4ukuwgpR+yjZGgGoRa10mFXCg8BstLd6HILmznK7m1YOcmp9nY902rSwSKts8cEAUiHtXKgcUK8QR+hyNYmKKdr06Lx1E6evfdK1W4OLqv6+LoiresoUZa6WZ16LxuvP+ypN0Hl58LDi3AeXfXptorrYMP0132zycQdG8LOGz/+HdcMk3Gh5LzRcG8lPzqocjU9fjF26bBPVQgn3x4Den1Fx8OGZtyecO2F27h3jCnnXn1jdb2K76+sc1gnNKmhTUadYuTOFR2l2f2l/bedm6HdKYGGSNG5H2vdxlJWj/HjwJeAwzcp9RM2yTnE7UwmnL1xil4ntkwVDtDCmgIvlYnZ8lWlyZS2Qii1GW0qsb/+0mdEWHpHVVXzllTyouZY1llGO7CDqyPnWidm/OAnt8B6XUQo332u1dGGWd34yHfB2TbcSdiDztVSPTSAhF0wdJMVAY2OXYaoK1ILB6iPyiE1Pz22xyxqN+hZJ8sx1X/LI2flzO3Chctd5Ejb+S+lKAQmwoD8qGGTUyMk2jMbaHNdarbGpsv0yx8HQKa+o6+ShSYWF7s9C2fUzjqMHwa15fJyPPyASqUQSYOuugJ6BQihsU/bWy+3kcJs8gYuMl8kS7m/bwzmgQ3fKDuUKqMfeo/XcUX05F1pBJsPGKdcOGcVb+qQNzxJpE6I1tIygFRoULgS8s6dfFL9agXsjuFq6Y0VbEzlALO7VOVDY+5G1M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(2616005)(316002)(186003)(6512007)(478600001)(2906002)(15650500001)(1076003)(38070700005)(6916009)(8936002)(6486002)(26005)(5660300002)(83380400001)(91956017)(66476007)(66556008)(38100700002)(122000001)(64756008)(66946007)(4326008)(8676002)(66446008)(71200400001)(966005)(76116006)(6506007)(4744005)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rB9l6siRNvVQ2WaYNuC2O9hlg9Mu4opZ3iEUj5IAXKv+PLw6EHraL3V2Av?=
 =?iso-8859-1?Q?BOeKdQmaBJvomCpUhrR4j0vKjVD3GdyV+rhfa1BAMXTPOQWA8OQV8YSPP2?=
 =?iso-8859-1?Q?YGHQ7XxHZC9e5GqtcKUnoPJzq1jYp//IZr9rDE1q99A8tlK9vs++kUySra?=
 =?iso-8859-1?Q?C4o0/wcIbXhzSSiKLX8JH3BaTYFY2Ius23jweMB7MBDWB3ZEABc/mbHBgy?=
 =?iso-8859-1?Q?kpJSorcaCXpQmk6r95OQzLLwFk3P62SHojnBzpq0GlPvzEoQfA+xS7B/Ej?=
 =?iso-8859-1?Q?ikEVTwTZQzaI9dOXcm2NHFBZbxO/izk+/Ig2IR6NuWxpGbwqlTc78wvNWR?=
 =?iso-8859-1?Q?SO2DL+qbupqd9LepFGhUHVpAUUojhI7f+48Q6D1MLpU0j5DZg4FDfVtCv8?=
 =?iso-8859-1?Q?FA7sYslG/eicVtq33mFaZW04detZR6KeDkkPnd3mOWIZ4YAuAtF/zf0bJ7?=
 =?iso-8859-1?Q?WHK5sqNgEsuIZYuoyYpsm27urjG6WMYL8XrNBV56vM6TC/sDG+4oEdDYN7?=
 =?iso-8859-1?Q?NRi1NzRqc1RcNQCEPbQlzyNhmtlxcBZ31Q8si2YJdU8vHIWyOPFfSrthng?=
 =?iso-8859-1?Q?v6JkfiLnpGB/KEZphwGeC/S0m/VARRcH7yPZkqgw+S7az5XdiUCcyU7jKu?=
 =?iso-8859-1?Q?uyRypEo0mP19YIiDsHLoJ5FkkjhNTvKX08rI7qvHAuiXpum1H8DSQW1+ra?=
 =?iso-8859-1?Q?dQhMUsKlr/5XMaT7t/+2DcZ3Fwy6G2n2UF63bN7c/XeTpsSewUSO9t7xrz?=
 =?iso-8859-1?Q?brUnwP36KCnXKdz2xjHIQlGytVt3MuOSbCTSemgn+sJfnxGAlva5zSTc48?=
 =?iso-8859-1?Q?zYU4HMkV+2zEaBqvwmez5bBLOCEQpWetkSOSAvLodxUZ7G/ZmHIFC7gg6U?=
 =?iso-8859-1?Q?zt/jGt0pTOlrqwnSgrK09+NSbsC6760BUpp/vXJPz77D9JZDxpxJYygC1/?=
 =?iso-8859-1?Q?UAVG1IZlYoqUz37O7su+8bLwnKaLRLsSVhLQHPPrbHkSw02/ZsnFW2ITP8?=
 =?iso-8859-1?Q?Ydi+XxUuD14NIZjMQUYe/eR68ombSJuNCxcmGd8UGxZRFAU1Ym6dXV2ilE?=
 =?iso-8859-1?Q?0zdM3kH93E3yiuwtQZeqOnRDZdwU1VznTBDaPRlARkhATRv07iEZVtwnZI?=
 =?iso-8859-1?Q?iHGvCuq8w0mrkErkRKIDLziCZ6CyGMoZO/FA3y3u3ChXCSedW3SKfd6G46?=
 =?iso-8859-1?Q?0LoT8YTdqKc+LyYuaNMHAJO/Q0s7tc+aBeiP6n8f1v+xLfNyqE9fjn9z7o?=
 =?iso-8859-1?Q?jrn85OIJoDx7/TYMZ6VcpGf0QPgxF8wOJ/Cvo4kEwpDOFTyRcw2YQq3Tri?=
 =?iso-8859-1?Q?Pu0k8k+uNP6vLYtc1v4FronR0egFvy4ORZRyYSTpeH0YBGDy9qLK84fel0?=
 =?iso-8859-1?Q?2gBMvCKm8AcP+I17q7SX1ruyQr17g5wgtC2Q8NnooOdnb+m6LA1nDFFoX0?=
 =?iso-8859-1?Q?1gdp4VfcJq/j6EXdjS7758Tqt2zqsS8mHtB9n+erroOqm23eM1Bg8HgEIT?=
 =?iso-8859-1?Q?eTtSin1xA65Nat6IQfabdSbggocmOznd6ENqhQwFVCW1LLklzK1oKGSmTw?=
 =?iso-8859-1?Q?rdnwEW8Yrb2GEITTjqUAeKleKy20m7rpX+p1fPrvW2Jn9eDnCqa4kE6msR?=
 =?iso-8859-1?Q?cOcbnI1Ok2Ujn1IXA9eX5rTSvJWzTdkYTL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b58360-b685-4468-a42b-08daf0301726
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 21:50:56.3382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EmvxJqcyUSZ6goAX765EgOkxLI+F2VIOv1AfoFbGhJ/9Wx7faIysmAavlJKwQhE+9uKwEUbMcFeeegDhbGadHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have fixed the t9001 errors this patch was getting earlier.

For reference of previous patch versions:
v1 - https://public-inbox.org/git/20221111021502.449662-1-michael.strawbrid=
ge@amd.com/T/#t
v2 - https://public-inbox.org/git/20221111193042.641898-1-michael.strawbrid=
ge@amd.com/T/#t
v3 - https://public-inbox.org/git/20221111194223.644845-1-michael.strawbrid=
ge@amd.com/T/#t

Michael Strawbridge (1):
  Expose header information to git-send-email's sendemail-validate hook

 Documentation/githooks.txt |  8 +++---
 git-send-email.perl        | 55 +++++++++++++++++++++++++-------------
 t/t9001-send-email.sh      | 25 +++++++++++++++++
 3 files changed, 65 insertions(+), 23 deletions(-)

--=20
2.34.1
