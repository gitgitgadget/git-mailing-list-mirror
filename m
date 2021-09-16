Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE50C4332F
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 17:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4460B611C4
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 17:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344325AbhIPRFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 13:05:02 -0400
Received: from mail-mw2nam10on2108.outbound.protection.outlook.com ([40.107.94.108]:22656
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347781AbhIPRAo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 13:00:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVokB15hUe0XztDiUdeu++1kP6svOgnjvVAKbggKVRJHOu+LjzMsQnUTw9A0yLXkaxpCui2R+J8OSkdAmzncow8l82uExXFvWUKCdFXpY6OUi8p0cq48dedpQUQivb7xusrqzIe91zPFTM2QWW9TWWGXh/JGAeNcACjYoYNmHXZd3fk5txjU6AX5+EEKcjcAzMmgju/5C2ehR50pXcN9Pot9LQRsQR+0RLuT+mwp+ceaSLbWme8kf4X6YatvZ82m6Rr1GIuxCwt9NxNPHAlOaY7Hc+SHAAiOCckluq+XNu3ZLDvyHvKomaIH+eXgAfwalAL7+31NOOEnQvK47dbZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WBBtW3NjtHIkCl9+ddK+2FNcC4M/C9QoF2fe4wAeoxk=;
 b=ZaEz+bIWzF3Y9pgtVw1KZ0fnvIDgQNwBFMT0bOY5bL+FE39zpdKY2tB/KN9bsAMkjm5l0J/kjn5H29yzFaGQzuUEcWWaqb9/4/Th9gfnwMYRgTpXpfX8tCBfkorSNGHnLnY1MDdUMsbVg2C2qKkLY0FnAHCwvUG0xprObnranPRXQIZkqZ4fsE1YU9hHOTrqqydWEhGKhe84JBwRg3dTfI30LsaqAh9rwnd5MOpp4jwnZppYIEe9CFQ/N38LVk+fbio4yrHEBMFCQtQE8TBSqaKrT8l62eWjYPkLXP5tQeCi9xsbtF6ijTeb5CW5vw+MAKA/gzUZVoYd+t6kLUce1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=spideroak-inc.com; dmarc=pass action=none
 header.from=spideroak-inc.com; dkim=pass header.d=spideroak-inc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=spideroak.onmicrosoft.com; s=selector2-spideroak-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBBtW3NjtHIkCl9+ddK+2FNcC4M/C9QoF2fe4wAeoxk=;
 b=GN7GbEoTzToqCRMZYISoYkuBxy7s24ePVvgqrEJ6gzw5DocGU2tD0QdSG993356g/kA4OFra2cib0Iyq5L/T/gLQi7mLdBxJIXBoUJeO93pf70AdnP0yonHS3112k+XgM+c93eAb/0dQcaBEkq8balmpMChvatZxpR4XLe4PCrY=
Received: from SA1PR17MB4610.namprd17.prod.outlook.com (2603:10b6:806:195::13)
 by SA1PR17MB4738.namprd17.prod.outlook.com (2603:10b6:806:199::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 16:59:12 +0000
Received: from SA1PR17MB4610.namprd17.prod.outlook.com
 ([fe80::14bc:3528:b59e:1433]) by SA1PR17MB4610.namprd17.prod.outlook.com
 ([fe80::14bc:3528:b59e:1433%8]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 16:59:12 +0000
From:   Geoffrey Knopf <gknopf@spideroak-inc.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Feature Request: Submodule Warning When Cloning Repos
Thread-Topic: Feature Request: Submodule Warning When Cloning Repos
Thread-Index: AQHXqxsv1imrcd7+P0OTcC7c31iEGQ==
Date:   Thu, 16 Sep 2021 16:59:12 +0000
Message-ID: <SA1PR17MB46101CC190E4CDDD00F2AD2C9BDC9@SA1PR17MB4610.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: f6262b6f-157a-51bb-1c0e-5de3ec02f8c1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=spideroak-inc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9d83b07-2cbb-4c20-ea8d-08d979334f2b
x-ms-traffictypediagnostic: SA1PR17MB4738:
x-microsoft-antispam-prvs: <SA1PR17MB47389F352239A36067F0C8BF9BDC9@SA1PR17MB4738.namprd17.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FUN6VFrGbQwJ+36xrc4bRokhjPXMSM3Na/Q1TwnWN68/RWQnvrkTUCQq36FN3XgbTXq4k+i3CLNy1KjKa0wxNMrJgqjjjfx3VYVjIZyY6IUlXfS/qd3ufL1EaRQyNwMPR2ZCArL+hfxjarAQjhm5yspzcQmTRvHGeTnpAlY+dC3/OzxXuVrNA0Rd0UQDDKzm7h+s+/BF+OANFuoEWBVsDgBh6Z1aYqgXV6RVRV2jAuPQIJxNo6IrwmKp6a4Tbi/ayNMizIhF3iiuG9NVMvMmu9dAM/dyhasZgofQWfKTqVNjLq7RqKM7moGFU1MWUwMzTulNV7z8k6xZze1sMxOonfZe9xtoL/Z3+cjXkPj5DSXm6SolKiuwSWQrIfDCpzpNnP87wGJuFPUZx2hsjNKNkU7jG6xo1VtW2LqOoETtUBX8tAybvuGKRlxXkOShC14iXWpoG9sK+Du19ZxkExE07InEV57YztriHAaFX8wuVuupOvfMQP4NtA8kV0msj/omDFhgCt8WJFs/80GaDxyHcc9pqoEMGt48AM0RsPAwgJscHgJCABLM+8aTbBVR/uoXj6Ih1HPN3XWPWWYwBVNCAvjp/i8jjX+4mqdtvrLUdj0mdxm1T0mDByxg3YN7HdHcKaENd3kWmpJDlNR3YuDYExH038m3UAUuHGvI2rR3Agqt+klm6nPT4ulnr+sFK/cDaabuIL0lU8BlQyTRfHXKxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR17MB4610.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(39830400003)(366004)(376002)(38070700005)(66946007)(4744005)(64756008)(66556008)(66476007)(33656002)(66446008)(6916009)(9686003)(76116006)(83380400001)(26005)(38100700002)(122000001)(2906002)(186003)(6506007)(55016002)(7696005)(316002)(52536014)(478600001)(8936002)(86362001)(71200400001)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZOltirrBfI0FZi0gMGsgGXccm8bEAyXW3loysZnt1aEojKi2JXa3HbGicw?=
 =?iso-8859-1?Q?Xxv6vXhW52xEYYDSBzIvizTUOw2dIJTlNk0o2eZXFhYKSI3klsIrNwgFdT?=
 =?iso-8859-1?Q?K6mV/oHbEECGtibPuHzCzj+OHv+Qh9tAfeeGWPGVMZYa/0JM8YGs598UDg?=
 =?iso-8859-1?Q?WvxyrRhd0k7dIKmhXkpMCTFLPxOlIEMcnp23BI959lDPIQ9ZI3RTtkxLGg?=
 =?iso-8859-1?Q?HEYrPRf5sfbbKxJN3SXvxhkRCGLNEUmCzC3HR2vIIxHJyUypu4rKi5vDBJ?=
 =?iso-8859-1?Q?Qx6ktBMRtksrmTG/UfNPyDdOv/g6nzkM33WFe/DlYNHMtEGodVbkymSHa3?=
 =?iso-8859-1?Q?i6mgbQCP5SHlDh7MvKPYB4EcadR+fxBPshQJBCnDMIkhbgj0epQ+rSzyJy?=
 =?iso-8859-1?Q?Qp/mUBb+3yggYypO1HE66tJDnBzBs6nzszlKyNAAXL02q1+EAzaFKoc7og?=
 =?iso-8859-1?Q?oMKcoflqfjGNyDBmcZS5XjoHOYqiaMF2nY+i2x9mZbL+0oqdz2tSMiAnD6?=
 =?iso-8859-1?Q?5pTrdgxvURLDUeyRnZW/GtMWzXmYP5S1BJwAJRobeFlRx5X8jHDfzMazn7?=
 =?iso-8859-1?Q?0jXvTloi+L5ENQmYeB0pYadB1OD5b2E0MpgUcH9reKgVCuVpjglKNFkVS8?=
 =?iso-8859-1?Q?IsPEArSOXOdxP4mVgsb0Okl5jeKsfLnWR26d4v6ZElXHumO0yrO33gsO0z?=
 =?iso-8859-1?Q?8EKvVWmFsnQresgitOOasvdleOdzseJw2lvjWd8UPkgagiGU1yWmufvDg2?=
 =?iso-8859-1?Q?wnOgW2Xpoj5uEpA+Y9dri1Dw42cCeDMgiEOYrztciUR4z9EQZaIX5xNvdL?=
 =?iso-8859-1?Q?VlBGMQk4yl3gHhIcfkH6/XIyx/0ffMRCsyUZzRpHo1KGykUeq8sHykQG9Z?=
 =?iso-8859-1?Q?QALon87W5cD+wLW3yXQO/b8xBXs+83PHIqjJ40SFnLmNyZbDziw0bEjktG?=
 =?iso-8859-1?Q?w69r321jkgptGN9KAfiRnou2NtoOHkOWu1NUOJmOq0X1kuYXoGCqgGjLCP?=
 =?iso-8859-1?Q?UL/CCTQkOM8L8XMthor8E97Tqlws/c/ux0H28NiiRfXzC0PAOXpMOloDt9?=
 =?iso-8859-1?Q?DJ4f0sW0fpqKfBCCGW3+5yTCrpciYn2Cybt2UNjDXVbL0/9yt/41QXW+ZN?=
 =?iso-8859-1?Q?ive5oOKu9DDiLU/QB+E9YZPkTpJ2tG9zeuZzAnkEAOSKfzDH7jpExIb24m?=
 =?iso-8859-1?Q?M+TzhbPuwwkM8QDyYTMTmTJkOvOehuxFnLFCmbSaK770BGk9kdJ+gxwMzC?=
 =?iso-8859-1?Q?48RgrASy+O4P57E5lzibxM+FgnOnLCu0XPTlMZfAmCVT0M5TwlpVen1bIk?=
 =?iso-8859-1?Q?fth62TTlRuaSyNcK9TdcWp4IY81OoZdQn3d+y7a6xiolnvkkPew/Q5Ea12?=
 =?iso-8859-1?Q?HNcdLr3rf7?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: spideroak-inc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR17MB4610.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d83b07-2cbb-4c20-ea8d-08d979334f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:59:12.6006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f8920c0f-48a7-4213-900c-6b853968daef
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QcfRBpakUYgVuUowV/HVYAOfRYjiQAtNdsxVYg9jrvuTAciiW1ck4d6s9MBpF8m6q4zBw/3eHQdSTc3zvHTJKCeTAKhOQlGnNckrt24UWGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB4738
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Problem:=0A=
Easy to forget to clone submodules.=0A=
=0A=
Existing Solutions:=0A=
Always clone repos that have submodules with the "--recurse-submodules" opt=
ion.=0A=
Manually look inside the git ".submodules" file to see if there are any sub=
modules and initialize and update them.=0A=
=0A=
Request:=0A=
When performing a clone, warn the user if there are any submodules that hav=
e not been cloned.=0A=
Recommend that the user try the "--recurse-submodules" option next time or =
initialize and update the submodules.=
