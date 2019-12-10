Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267B2C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 16:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1A92077B
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 16:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="giVAVnYR";
	dkim=pass (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="iyMvjytq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfLJQQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:16:45 -0500
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:5914 "EHLO
        rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfLJQQp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 11:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=630; q=dns/txt; s=iport;
  t=1575994604; x=1577204204;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XddhdDOQ1M08kyutke8sp0ALdhvJ5WI5qbFR44Ig1bg=;
  b=giVAVnYR1c2m/SogpPVJhfbO5PwA+qbmC/BReFj9Kez6g26fffWTcXPR
   F3kwY3iB9rl7OW1W2HrYtE6dTnb9eqpkmGxlO03F23FVne1uEDd818ylu
   cIkgQsF2wkubnQWpw8ATDI8lzU11PUEsmOokFgqmvuLRAiYPHvn/x+5sR
   w=;
IronPort-PHdr: =?us-ascii?q?9a23=3AFlTiuxy42cmFhEPXCy+N+z0EezQntrPoPwUc9p?=
 =?us-ascii?q?sgjfdUf7+++4j5YhWN/u1j2VnOW4iTq+lJjebbqejBYSQB+t7A1RJKa5lQT1?=
 =?us-ascii?q?kAgMQSkRYnBZudAEjyNvrrYgQxHd9JUxlu+HToeUU=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CnCADJw+9d/4YNJK1lHgELHIFzC4F?=
 =?us-ascii?q?LUAWBRCAECyoKhz8DiwWCX5QLg3uCUgNUCQEBAQwBAS0CAQGEQAKCAyQ3Bg4?=
 =?us-ascii?q?CAw0BAQQBAQECAQUEbYU3DIVeAQEBAQIBEi4BATcBBAsCAQgOBzEyJQIEDgU?=
 =?us-ascii?q?IGoVHAw4gAaMIAoE4iGGCJ4J+AQEFhRUYghcJgTaMGBqBQT+BWIJMPoRJAoN?=
 =?us-ascii?q?AgiyWf5dpCoIvlguCMpgGLYQipCwCBAIEBQIOAQEFgWgjgVhwFYMnUBEUjGa?=
 =?us-ascii?q?Dc4pTdIEojHMBgQ8BAQ?=
X-IronPort-AV: E=Sophos;i="5.69,300,1571702400"; 
   d="scan'208";a="684454975"
Received: from alln-core-12.cisco.com ([173.36.13.134])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 10 Dec 2019 16:16:43 +0000
Received: from XCH-RCD-006.cisco.com (xch-rcd-006.cisco.com [173.37.102.16])
        by alln-core-12.cisco.com (8.15.2/8.15.2) with ESMTPS id xBAGGhUU030873
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 10 Dec 2019 16:16:43 GMT
Received: from xhs-rtp-003.cisco.com (64.101.210.230) by XCH-RCD-006.cisco.com
 (173.37.102.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Dec
 2019 10:16:42 -0600
Received: from xhs-aln-002.cisco.com (173.37.135.119) by xhs-rtp-003.cisco.com
 (64.101.210.230) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 10 Dec
 2019 11:16:41 -0500
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (173.37.151.57)
 by xhs-aln-002.cisco.com (173.37.135.119) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 10 Dec 2019 10:16:41 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2nfv+83lbilOBtUf+JYX8blQLaEFWaQ7T06RJ8gEgJZXuBLJFwCxSArpJUodDaMrD4C3AdLdjXKZChms73lKrFmS0j4deV9DA5P5EYl4JuXJt46Ug/2DzGHgb0/7hr59bvDz7pG2xsI1JXia/H1+Ec56oFOTIyj/6v90U51WA5+q6Q9uafcoIeN78TTO67OC0+iTWPTxjXmIWWD1P0V9TQ+WI617U7Zzg7B6asnrxfSeLQR9ifiPkO3882xq9l0pgzbn1GafPWtv4qkET8c2GZNV9zE/Pt1wJA+lElVRji/vCxS6kd0JXGD0DApt4p+ZSzrZZjhF7A9W67BFazlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XddhdDOQ1M08kyutke8sp0ALdhvJ5WI5qbFR44Ig1bg=;
 b=Clj2FI1CWU8dwGFCHjhDUNGuAJf00SiraIc4qznqN8xhNE26gCfq1Q74OXp3+v723dP51vw+T62DwODyc/+s/R7v+z81flmVKUJJKAhCfJvWmeW8hTUCUfgDZtclQ+IqlUWdBHxZdhbzfIM6JkGgc4rmqQnTrpQfPzGcFUdT9r6xsKI96DGz3w5Y+j+M896HuQQaLU0+Q5Yt4YxdeXdeospVIIOrphqY91K/7OdrrVRTTy/SuUCiZN/tKgkKA28QVcnvmuyF6xwMsUdlBXgCQRT60iQXLhZoFDXeS+8WfKfggbTrn9W3ZZzHyaI7PdR6Aug+JZxwMlfCYR/Y81B+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XddhdDOQ1M08kyutke8sp0ALdhvJ5WI5qbFR44Ig1bg=;
 b=iyMvjytq1xqy5g7BfxR/lm5iRPq4tBXz6cwJneu5vuHyqrlLyQsF2Ic1J7NXqluRWl2TZG0N9WJVMHeqBvUFVG9UofZRX+l2VfR66GSB+aSgd+2uYIHWc4Mzy3bX4PSK/ofQxn8UbWJ/gTf82porJxiIQSv0QV77HH2A4J9dSpw=
Received: from CH2PR11MB4294.namprd11.prod.outlook.com (10.141.118.210) by
 CH2PR11MB4392.namprd11.prod.outlook.com (10.141.118.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Tue, 10 Dec 2019 16:16:40 +0000
Received: from CH2PR11MB4294.namprd11.prod.outlook.com
 ([fe80::adc1:78a6:7f26:e484]) by CH2PR11MB4294.namprd11.prod.outlook.com
 ([fe80::adc1:78a6:7f26:e484%5]) with mapi id 15.20.2538.012; Tue, 10 Dec 2019
 16:16:40 +0000
From:   "Patrick Marlier (pamarlie)" <pamarlie@cisco.com>
To:     Jeff King <peff@peff.net>
CC:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] send-pack: use OBJECT_INFO_QUICK to check negative
 objects
Thread-Topic: [PATCH] send-pack: use OBJECT_INFO_QUICK to check negative
 objects
Thread-Index: AQHVpR63qXkRF4jHPE62LYMCWIhkwKepYxAAgAAC5QCACjeaRA==
Date:   Tue, 10 Dec 2019 16:16:40 +0000
Message-ID: <CH2PR11MB4294C33B1CC956D5BF6AAB81CF5B0@CH2PR11MB4294.namprd11.prod.outlook.com>
References: <CH2PR11MB429411CA1288526D21C7AF26CF4C0@CH2PR11MB4294.namprd11.prod.outlook.com>
 <20191127123211.GG22221@sigill.intra.peff.net>
 <20191204035522.GC214771@google.com>,<20191204040544.GA11502@sigill.intra.peff.net>
In-Reply-To: <20191204040544.GA11502@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pamarlie@cisco.com; 
x-originating-ip: [173.38.220.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5c8f8a8-2319-44c4-e5ec-08d77d8c56db
x-ms-traffictypediagnostic: CH2PR11MB4392:
x-microsoft-antispam-prvs: <CH2PR11MB439228E273634A16B2A4A1C9CF5B0@CH2PR11MB4392.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39860400002)(376002)(136003)(189003)(199004)(4744005)(66556008)(6506007)(5660300002)(91956017)(2906002)(76116006)(478600001)(7696005)(66476007)(4326008)(52536014)(6916009)(66446008)(66946007)(64756008)(81156014)(33656002)(316002)(8936002)(81166006)(8676002)(54906003)(86362001)(26005)(71200400001)(9686003)(186003)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR11MB4392;H:CH2PR11MB4294.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ljJU47tc4rT9K8aPg5rxiI8Qs5mDCqcGG9vfECgVqf2WNGZuGfoSn5PUhTCdoJVti/l/6m/YrILVtMD2Jcnqx342A+940edHbP+7G9g8nSNNTtus9QV3zbrRB8RJvOfcUOGrMhm5yutVL8i2i8SYr5UJGlDLuLZ3FmuBPS4Kq0NlxsHjMLRJ2xfh1jEhyPwqaW3+eg/fAHv/4fvgMp4C5ioMX7UxeJQeKapWn4LAAezpGbBbYGQdESSL6pQM+2cTIgVSd2hRJom9NL4s6bxYq4KltcSrqFI1yylo2XucrOqSueKf5uXGY/4SM+H5cVsN2QbzMfxS27TEoKzotJvGI4DRDFUvUsLs1IAR6P6eproG+YaOwMFdeRzyGuXrbJrWavC5gF79vg9wXXf7zowaiRHThqT1a5FPdAL6dPt/lyjZFefissxenq4bHkRrj4pu
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c8f8a8-2319-44c4-e5ec-08d77d8c56db
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 16:16:40.0990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZwJRqORBs1cn2jagQnKKiAdMn4PmS/Q/6LsIOy+IavduXGUhcfr1uqH1Cxofz5TmdRIDFcukQV1sdhuaqiE7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4392
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.16, xch-rcd-006.cisco.com
X-Outbound-Node: alln-core-12.cisco.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Jeff King <peff@peff.net>=0A=
> I'll be curious to see real-world numbers from Patrick's case).=0A=
=0A=
Here the real-world case (40 pushes)=0A=
=0A=
released=0A=
average 00:08:35.54=0A=
median 00:07:37.88=0A=
max 00:15:30.26=0A=
=0A=
patched=0A=
average 00:06:45.67=0A=
median 00:05:39.57=0A=
max 00:16:15.46=0A=
=0A=
Note our production is using 2.19 so I back-ported the patch (need to inclu=
de 2 other patches).=0A=
It helped to improve the push duration. I know one big part is git lfs but =
I need to check what are the other bottlenecks.=0A=
=0A=
Thanks a lot for the help.=0A=
--=0A=
Pat=
