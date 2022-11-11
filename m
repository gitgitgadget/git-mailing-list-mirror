Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202C6C433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 19:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiKKTaz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 14:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiKKTaw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 14:30:52 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21EC701A4
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 11:30:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py6dLcBVXYYMa50A+dZJZDnXnxa+NWViyXG41ZgLlhdmO4tTt7gEzu4s2fF45ZooDqSbyzyuk4zWf2pXPl87BYgsOV4YNdUZLcJIBKzJu2+AIKEHYnNhYgKbdc5xkELP1wZNfMRcRVY4Wl5sVXsHADm7pEp2QDbFMUNhI3yHK3aSmwZibkOr6Q75eV4zaJW2ALDd7+PeZ3vd66+Bq+alIE0Kwyeu0F+B8Q8Tdsb0PzGH/gsEAWuA3QENjoRJYSC4XlyGQocnYFVXuT9YaQ0WXIJZoE12y7fkw+tG8HmQw9FfqUl9H0sAcJsoMfTBoriMKLXg/3gFgqv11XsGdAv3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzAz67E0NqvChIqqyD8M9Y/DPguRPtA+86vVyYKuIJE=;
 b=kZZto0bZ4grIhYgRzZCn4laVVsYYkYk4DWjLTizRiZeme9OTEioEvAHURAa37Xp2yqtWWURxovjfLPRQtvqMAPPQhNAdVJONw1iVJ7bo4naHEA8lTutykZKadzCbF7W79kKt8fU0EN7W3derpSqJvlGR4QyBnSanjVZgF51e8exhf0Tu0IIgyAFA9KV+fvP75SHy32lJqmBU7TbeQFDbOhY1zgrvmmBpsqJfcoUcvmpNNj9ZH46csTOoUKKkQpVbikEG6Tu+yQ4ymTUDBlO/r7MB+tciWYPjh9wa8blTw1MjMYPpGXvM5/KxUdIhXa0QMUJzLgS3uwhp+0MMRle2fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzAz67E0NqvChIqqyD8M9Y/DPguRPtA+86vVyYKuIJE=;
 b=NgTiJGBP0Mh0Nj4HB/fK4IvqwpxRHGdgto1Hm96gByVqR8+9SH1GGWm2MUyfd0xGM0Vw+Y8/BmAltUYQ91s4RXtyyAcCgEX7UnURO8swC8WmIhBRdnpB4zT4XKWSNGkR3+NFfC6mvMGzU3la0zWiJD4MeMpGNmUn1/FZN9V5PPY=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Fri, 11 Nov
 2022 19:30:48 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66%6]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 19:30:48 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 0/2] Update sendemail-validate hook docs to add header file
 parameter
Thread-Topic: [PATCH v2 0/2] Update sendemail-validate hook docs to add header
 file parameter
Thread-Index: AQHY9gQZeJ40EQ129EqWTmwB9mOGEg==
Date:   Fri, 11 Nov 2022 19:30:48 +0000
Message-ID: <20221111193042.641898-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|BY5PR12MB4291:EE_
x-ms-office365-filtering-correlation-id: e00b1727-17d5-450d-158f-08dac41b3c69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n3Vw+73/a7jp90mMn4bo0Vg5cF6Bmq//9IPg14TthuQKetzIZK9Md2VtQ64vP1mdhZLPkNhLkRdBBuAo0BZx+lzCR6VsRvN4M6MHl2decGailDXYANmUfFV7bSo2NL7OBX0ksFdr3X3hvtnipGnjTaql303XQjr0L+zjObBfudcUHOtC/ee5lBVkqSFV55GoAL0OYvUV5jiwf1Egs6UoQChusmOVMSHMoDBbLwQZGLIHwRpWMBaHp0LzM+2IljNBiX6cGmlDBf9clHGjsxcBhbdLZRQP1n2Bj6QlDyHAONJQApVISBjdT0ZjYNAQh5jxHP/QpufbvG/VZICZaD9UtDZqUSu6hO6eb1/WDssNcWU6XEAg92+5k49NUtg8691/VAkQFkEmLK4io45H3IMtdFgIUw/yFPEx7Xh/oJ0JZS7bW6iHUbtT2SK1gQhYR34JWGeVwYEZHf4RRYq3S0pJPOUhxuOKKcorDF940Uo9NylAFXD6VSj2/XLsQ9tZ7JPhG3oEZf/E/37sPk+kzEp0JCJjwePd6Qypfle5wRhBc29MZjVQP5T8Rqy8hWI5afBTCWGxv8lAHI9bPxldna9ul0w/pTLt7JWLT+KmnaMQcLqTOl0K9cwRj8xVWDFa8Sw2qxHjVpNcfvf95KXwurahzVtK8BqMjLAOEUm+9Eb/tYxyJfph/8o4loj/LCCz/D0zaeH8nXie9WCRAmW5ofnlP10/GCQwflUeaWQcE/ztVrlegOkY6aLD1w4yzgcBRCHUcTejFS3V3JB5sMkOFbwp1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199015)(36756003)(83380400001)(122000001)(6486002)(38070700005)(6512007)(478600001)(86362001)(1076003)(91956017)(15650500001)(6506007)(71200400001)(38100700002)(76116006)(41300700001)(66946007)(2906002)(26005)(6916009)(66446008)(66556008)(66476007)(8676002)(8936002)(4326008)(4744005)(2616005)(316002)(186003)(5660300002)(64756008)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?n1RQ/nYXARiw1PNXQJGycYZOnLfoo1f/jJvx1NzVaww2zTW2jiPoMhn2qF?=
 =?iso-8859-1?Q?d2pByFR1EaCsd1Eusc91+LBFyA8Gu7U5uq1P94d6cSLat4hGequLMhduqv?=
 =?iso-8859-1?Q?4SP2KalzJpcVEw9hs8z/TSMrxSMVVzZCvI6w+trZIpQDoAsceNt5GGZ7Z9?=
 =?iso-8859-1?Q?n1FbM1admOdVC4suVkYQwDiJjgTBGDfXE9LJekwc2YetT9/d1gUvHtgA/T?=
 =?iso-8859-1?Q?J8xzeCiIoyqiamdhArmw47bRECTE17ooZdykvrC7hMt2vWyembjc21lRYL?=
 =?iso-8859-1?Q?OsOrVHhnnvMe6v67hexieRuzsnSWI3W9sKyZQQCCRSH9/5u4tGkMeJCGLy?=
 =?iso-8859-1?Q?4hvxQzu1qildXDTDL17bwVyYqI0e1itK1x9wutXTqboKUBXazJ1bipMpdC?=
 =?iso-8859-1?Q?Dp2QPAZgm6vL3Bpu8YZ5Ht8izpDzG7IRfTpaKZ1orR2liZTZnOQ2ElVUP5?=
 =?iso-8859-1?Q?0m+mb+UQbEmllFo9cPgW+L8OcpKg6Ng8vjEr96rmVvypHc4CCpxoab2Uh3?=
 =?iso-8859-1?Q?OVG9IipK9UJJsi1REGSTtVerppw2iUG8VIcUQb0r6htR1iPGHQI2/a7GG5?=
 =?iso-8859-1?Q?gOMvwnMOPhjamGqvWgmg/f/uYLn7N2ZYjh9hJwIlDj9LKOpzEEqqlsKnuV?=
 =?iso-8859-1?Q?k2yJS5TC1Hx7pTM+S3Y3Oh4ohkBZs9KHvNwqyBm1IIR2X+Ch5rTMSIm8aV?=
 =?iso-8859-1?Q?5Crr0cZ1R8jVgD7icBVceaB6lhZ2sL8A4AvoZ642q6IcAG83K83MKrSCqq?=
 =?iso-8859-1?Q?oKOZreWnl8SdZZfJRMJpUkLhrwLMvGDSsIfY2DcrQVnGalzhQRXCwzTkkM?=
 =?iso-8859-1?Q?cpfzyr7+3G2X/whMqvO2XWSaQ8yaA0vRT+5SntWinXEjqgAIHy1e8Kh0X9?=
 =?iso-8859-1?Q?b75EqnGLPa+44XpMQn3WZ2WcHfeY8izOSEDjbpy28Qtt2+vG9V/eKNzY5w?=
 =?iso-8859-1?Q?+gK3Hf8EHQDj6pr7NZDHC9KV328gA5s1XFbz9mr3nv/5IpdEpO84i8Tfip?=
 =?iso-8859-1?Q?pZQYT7p0LY0bAkpxSEQLJvUrR+rGQnLGa7Wwc6wD/xKOoimpKDW5GMVMvC?=
 =?iso-8859-1?Q?nqHz8wYGlsWC0w/r61Gw9xeCrR/9E8ckgR4B3WMMwDmnZxYP4RzUUH9+tO?=
 =?iso-8859-1?Q?ngtO1pSQgbuXyTeyH1+xvFU4OFwZAxR5yr7hGZOQwj2Hz6nkLazMyuzxGY?=
 =?iso-8859-1?Q?/Iz4sBDDcrol6V7ja6M1FNnejzUPrIN4gK7UbRQIJ1aJKVHIep9CW2PXHJ?=
 =?iso-8859-1?Q?wxc1NEOI/+i+C0+WyTqcoVE11TT66F9D93RJYkrNMfKSKPXLwk0sMrIpNl?=
 =?iso-8859-1?Q?SnqOYoPtMmHMT04Zcs8kbO3jvoR7ZS3rFcNs8k2s3LVAxmkifTPbSkLd90?=
 =?iso-8859-1?Q?9bK7tdPgFpfVi4x7ch4GjG31I46GZyESMJctsxuLzTWs3RXudmrtTjgk+O?=
 =?iso-8859-1?Q?yI9tIoCGzFEWf4u0Wpsqy+/8TfVUVXi9c+4zYWWtiEgej56pgkK4mJVbtY?=
 =?iso-8859-1?Q?ThlRGV3Hba7E+weO6u3IYwKuDcO0w8YniY2WM6dyCkENC1RckEL6P8gBn3?=
 =?iso-8859-1?Q?+hhk5gHMB2d31H3UNJlP35JmFNhRKV5cwOvnyOKKuDlMZJmGceFk1HgFmc?=
 =?iso-8859-1?Q?6uI4qHLKMViLuDP2EjnQiYOfNMbWC9TIE5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00b1727-17d5-450d-158f-08dac41b3c69
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 19:30:48.2402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0NSCsgOabxcmApurRKLJ10+eN0LHLpXMRH68vbAwHa8mECVWdTZ4ZYvmk6sKock+Y3GombqzOuzCaJMDaxY2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changed smtp to SMTP.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: brian m. carlson <sandals@crustytoothpaste.net>

Michael Strawbridge (2):
  Expose header information to git-send-email's sendemail-validate hook
  Update sendemail-validate hook docs to add header file parameter

 Documentation/githooks.txt |  8 +++---
 git-send-email.perl        | 57 +++++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 24 deletions(-)

--=20
2.34.1
