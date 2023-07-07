Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09853EB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 17:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjGGROC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 13:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjGGROA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 13:14:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2079.outbound.protection.outlook.com [40.92.90.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B621FEC
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 10:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEKL/p2yQtM/odqUUIBvZ1aUtX/Ke6625fieqf7rjd121XcVuI8/3ORZXN0bgaUKWYh0z4QUYq5uZNsiojEqWxsXkk0w7wpXVbYqndMsWt9LJY3xhbkrqqEo8yTkHHDx+4rxVpRyckuY3uMdHsKabsitCyiO2A6loyEqBPb2n880ms/ZakdJytvJox/XiqWhOoLvgC2ZoPzBO9RjgNVf3BcGwcE2cjxLjS3EX+6w6UbokfINjtQg4Yvr1qMbdLu3BMtnJ/KUMFWmY2plqMIcO2kRWWspYfjkwnnY9XuJpvw4q4Gi3n23dfB9He5g+AaIjF/9+tjgPeuHJYM4bnZdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GC/VTTSLyiP1TqJ3kCwj6C84407apeoVX4lrRpIS4WA=;
 b=gYkkUwKIOW3CRmVESvlG8w0WH1bEOSipJyGQNlaJ2GZMfmHQxdc+miwUoQy+TrImTQAyiKSEAl398k7Jb4vy/aoeWsor8LQbJtiL9PrytW5y1dlFiljMoZWCXalB2kBpatBocZlaoD6VLatyV1tpzMjH8R1KHOAI1zlvhFX+Gpe9U+Lkk/vqu9Q2tVrQawApZQjcyH4EmvsViD6VEmtQvEs2gpMr3rp0gX2QQ91+oJXkxYKTEeXhNBozvYHlhwKCO7ohNMdrvs/Yaru9YhATWDnKmOEgeuIhAkPQltU0EPu+X17kWyUNqYYEokh2NkXtCjQ7dVOJb5Ag9hj9L9Ujfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GC/VTTSLyiP1TqJ3kCwj6C84407apeoVX4lrRpIS4WA=;
 b=bPLRy3/eCBZICvkdFIGRRW2tpVTsw3SxSgYFbKrnNEr0+pmMKPp2PYvfrthMA/u2s8qRHYF26MRW38B4lOhBDiHPtTRlUYngys2n4IVFytOO7YK9Tb7mok6UPXk3Ptf0jmFsWeWl+cZY/oqSg8a6QZJLflxQ6x8VZWSOd3yQpVsYhdAjaeCl4O9/8lC2anCTFJO2T7Daf/pn3B01RaNXgsgKtAOVYrAwucfAwshZxkgGeyTS4bNHTt8Zbx10sWy2Up/bHdredukeyQw+r6tuveHr8XrYcNoiWwVRMpX+E7PHS5w3tkZbTuS9bbfFXe+P8iXJTGUxnoyu4o1XZR0hdA==
Received: from DB9PR08MB7211.eurprd08.prod.outlook.com (2603:10a6:10:2ce::23)
 by AS4PR08MB7630.eurprd08.prod.outlook.com (2603:10a6:20b:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 17:13:57 +0000
Received: from DB9PR08MB7211.eurprd08.prod.outlook.com
 ([fe80::a06a:3cbc:9d5:db93]) by DB9PR08MB7211.eurprd08.prod.outlook.com
 ([fe80::a06a:3cbc:9d5:db93%3]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 17:13:57 +0000
From:   Mico Hasselstr?m <micohasselstroem@hotmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: https://github.com/gitgitgadget/git
Thread-Topic: https://github.com/gitgitgadget/git
Thread-Index: AQHZsPZqqELWlwpe70qjDtR9hCayGg==
Date:   Fri, 7 Jul 2023 17:13:57 +0000
Message-ID: <DB9PR08MB7211C55747D509AEF40652A1D52DA@DB9PR08MB7211.eurprd08.prod.outlook.com>
Accept-Language: da-DK, en-US
Content-Language: da-DK
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [UtgBfMZrtVzzxOsCK8OiFRjQknwGT8pL7Ix1LKai6kpUJrZxf+egLx1vI4aDsEk7]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR08MB7211:EE_|AS4PR08MB7630:EE_
x-ms-office365-filtering-correlation-id: 101f9d54-5caf-42c9-5c29-08db7f0d8c9c
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3D0VVeV1HnJoQcN4HQeKbQIA345t2/qiDuqQnjHw2gnMF9DxSRxr6w9KmlGyWQfsPY/hDb0NGHnFVPyzfTn+UzECWNTJR2F0AAaDloYEo+TGFuNFz0ns1XRbilLW8XGIP4ev72QZo0eKTEVepzukyU0ZATFFMQWFAVyIRGuHYGWV/ySetR/DpqvJs0MJB0gAgjlSV/13qEVpnCmcBUmN8Ow4RLRAHJusvZYS6zAiaYi2D1Oku574zgn4uDsjOVKJVR3ythCHkLrdLnbXUso3ltBrqWoyfVcTXgBiaf966x6XGbKrQ85gHk6A7aowTGSiM5rRxlBYzUu9HUDtBMFTZHW7tdLHFyDQJQqGavm4io3sYjJMeQ3ee2WgQqOW8q25MkJXgFbyE/VNkPxb3MYdLY46sYqI+pwCuG9X4l7VMurE7grbWXGd2+3mQF9vDdiL4WajBzZZytujnZGAItba0GgEVDF8wNqFnP9G9z0aUCS+r4AbCQtvnICtfOKEmeoMbYw9xcnz/kIJWCLvqdXjzberOhrwQBuqA0JkmYjWzxGj352ntJrCJI0Pi9vCQTFn
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+3iFIkDIE6EcZ0j5180Xwvj92PPr93zGaz8R6HQTrgfAO+yMJfjraIxe3RKO?=
 =?us-ascii?Q?I3A0ZPG2JATxBbddHusLz+SPkJYZoto+39Nm63M81JVRqrl/P4bPn5Y22Pxd?=
 =?us-ascii?Q?64CgCxad40YD7OSb3Yp+E8cnuObUMuj3Dd6sNHILkFUeA02UfN3DVGknDigC?=
 =?us-ascii?Q?SEEvcLAL2yIRvo3i3Im/PZSUj5gocNxNu4dh6v+9bdurzKJdAPgGVwbjq36O?=
 =?us-ascii?Q?Uxj8c1AuhKxTQAZV0wf9azq7u6LUUteoMYhWayXK0g4pvh/VmlJgQQvG0eYA?=
 =?us-ascii?Q?l+I4+Ht6OdsSR7OoQXaRgcwe1fj4sLppa8kr5/+gG7h5aD3thEgRF8K5gI7z?=
 =?us-ascii?Q?UVseHv9XhbmLEohy9ItTyilk2xwTEIewscfjH26UJisistjGvE21Rp4MvJAL?=
 =?us-ascii?Q?J1gaUjSy9oxPOwPLhXqlpT5PO1j7gY7Zx5s+acGp47UEiJO/3hKVtNqOPSMF?=
 =?us-ascii?Q?tY0L8mcbtzdZ6LxCznnPSzvbpD7JmwU9C0xWUQsQF15n3ZsaTNvdyGUvEe80?=
 =?us-ascii?Q?ZeTHx9jT78TZq108y4jW/SMf/8WMLv1e/gE3egzA8tHY1TAuaybo9/t6M/za?=
 =?us-ascii?Q?7L5RQYLa8eSWX7FVWkgIrMwKEfsRAtVt/EkOmTSnwWjoc1Lb3sNVOMKLR9dO?=
 =?us-ascii?Q?eTlA8BZyB5O9im8j3o+LUSZcV6JvHSqv0F/A/9oSWyBoB0Ptqcx/RdmjZ1oq?=
 =?us-ascii?Q?Cg/sfX88icORBs0yFxCbZAZ3XYY+yN9CYZrdORxjnDhlWMVuej8VqE5odnj1?=
 =?us-ascii?Q?tkEjMLDdKMNqxtHYG03VHDgeUatOSqDkPj1Ugy9u89XvIAlQX5GR2fRbbB/a?=
 =?us-ascii?Q?Q27PC1/kviRQ0clY9c/CdTwtKgXT5VXfQ/utEetfIrYbzTVYuZ7OmrkpzEjx?=
 =?us-ascii?Q?mH0gba9smbvDUvHafUwUtKI5zkzuq8IdaUL4ef4KyG0iWHPEBgKm1dUhnINJ?=
 =?us-ascii?Q?uybzdoosEI695KvAvWOcnOwxNrGBpAC3JZXqu6LaqDTt6MSlvMOejzcket3P?=
 =?us-ascii?Q?LByK7zkUuq/7Wpst6cD6ejp8lMtbC36CzEZxN1jGgY0cueznfv/mlUH+n0lg?=
 =?us-ascii?Q?uPLn6/f8AkUwLeZ6g1H8gUSOutf+9KUzA1lGUIOjUSZhgfeYBpqdPlH1hul7?=
 =?us-ascii?Q?24vNwIv5wwVvFtmnxwRoa2o5l1g0GeYfsTRH3TZYBYQMeWDaySnajydGz26D?=
 =?us-ascii?Q?vkSKKRUIhZAeeN16qvJ9n/TgkHK0jNEd4L6OtLIWwHTjRvC8uj14sYFvRBT9?=
 =?us-ascii?Q?AKfWpZ33Q9lprUCEko/84Te+JadFIgjxOStvNrDMepYy2UP7BlQfdP2dqfF2?=
 =?us-ascii?Q?3Vo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C28D609B31CBDD47A8FA5E9A9B9C02FB@sct-15-20-4755-11-msonline-outlook-83b42.templateTenant>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-37dd7.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB7211.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 101f9d54-5caf-42c9-5c29-08db7f0d8c9c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 17:13:57.3015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7630
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sendt fra min iPhone
