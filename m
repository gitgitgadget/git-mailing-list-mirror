Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=BODY_SINGLE_WORD,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,TVD_SPACE_RATIO autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853C3C2D0CE
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 14:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E884207FD
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 14:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=21stCenturySoftware.onmicrosoft.com header.i=@21stCenturySoftware.onmicrosoft.com header.b="za3a+SU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfL2Ooj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 09:44:39 -0500
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com ([40.107.243.77]:58944
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbfL2Ooj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 09:44:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcY3BpyWNXK5GPF/K+Ht8koQ0Tm6LRjRT4WTf574pHafCXLdROudJGshvvhDiABNbgxw2J01mFXHayqI/6W7l9ZEpmsrYOPaTW4+z2e9CblGnlRVP51zydAtMImntBcsrs+QsKL5ocVP/yIS82jnEjlBPRTNuExPhUTseu+RCxtEEv7/CrXImmAAFU09ToAd7Io9Jslun0dpE+XJEHHeVAKBRj+NVQvDS0upKO4N/wPnXYy2i+P33jmyml99e5qvxICll/vtmdv4ENlU0grqPGXaZydcYUy4HHsXiXWi7lWZfpnzd6ws9pHonkR3VTYCY3WJaG6o3XM1x/18uqTG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzNhygGJDb7hZS0GWgeiw9tyJ0XJCVku5Jk9dlBLzvY=;
 b=HZ/5jQi8DaDRzy0U40Eifj9+4B7Bx05kBk7sIuY1yva+FUQNcX0nnesYKmSBDR3UOSb8E7yAvZhXLiMrsAH04e/Lh/fjUFsv8AHRFVr3tpBxQrKRnKUhxaLIxgT8Fgz4Xm6cgMIm00kQfn9PkXxodC5gm4U6KB2gPgLqpK3YWjiOA6elQA4mpu6KT4lV6pijhbW1qCbl03hFjOuJuf6X+XIL2p6ZGlVT1i8R7D8t1ExddscByin6JTB5FiEwVwZArGgwVER+xaAGc0Z3kboraQi+qrBMvxYq6wTOP+C0AjZtdyWs71AAsZ4fOzvBOobrAtb2xvu2oyFxcwmk0WcXUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=21csw.com; dmarc=pass action=none header.from=21csw.com;
 dkim=pass header.d=21csw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=21stCenturySoftware.onmicrosoft.com;
 s=selector2-21stCenturySoftware-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzNhygGJDb7hZS0GWgeiw9tyJ0XJCVku5Jk9dlBLzvY=;
 b=za3a+SU7bab/JJqygW7/ikqxzzzn4FU5ZARf69pkl5tWEVIzS9qv+OhLFQyGpnEdIe4oRUWWUV2RsYnwzrtVLWUBvc6oO3KAWm/jYGnY1WPlr75Zrn1TI0E3JWHCAuPYtuTej4DMEYAKVVhbUUhk3H4941nG8spJmK+Z8VSwv6U=
Received: from SN6PR03MB3695.namprd03.prod.outlook.com (52.135.85.26) by
 SN6PR03MB4093.namprd03.prod.outlook.com (52.135.109.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Sun, 29 Dec 2019 14:44:34 +0000
Received: from SN6PR03MB3695.namprd03.prod.outlook.com
 ([fe80::5433:b979:23a4:c5f3]) by SN6PR03MB3695.namprd03.prod.outlook.com
 ([fe80::5433:b979:23a4:c5f3%7]) with mapi id 15.20.2581.007; Sun, 29 Dec 2019
 14:44:34 +0000
From:   Lionel Dyck <lioneld@21csw.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: unsub
Thread-Topic: unsub
Thread-Index: AdW+Vnt2US7qvKKaT2SjlTAuiEe/nQ==
Date:   Sun, 29 Dec 2019 14:44:34 +0000
Message-ID: <SN6PR03MB3695BF61648C995A5124A0D2B8240@SN6PR03MB3695.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lioneld@21csw.com; 
x-originating-ip: [2600:1700:8e01:f18:ecc8:6ae1:db68:f282]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0672d0ce-a695-4eef-85be-08d78c6d9f46
x-ms-traffictypediagnostic: SN6PR03MB4093:
x-microsoft-antispam-prvs: <SN6PR03MB4093726EF7E29F793052EC54B8240@SN6PR03MB4093.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0266491E90
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(346002)(39830400003)(199004)(189003)(508600001)(5660300002)(7116003)(33656002)(3480700006)(55016002)(19618925003)(71200400001)(9686003)(8936002)(81166006)(81156014)(8676002)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(558084003)(6916009)(7696005)(316002)(52536014)(6506007)(186003)(2906002)(86362001)(220243001)(204593002)(239884005)(425394004)(19559445001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB4093;H:SN6PR03MB3695.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: 21csw.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IplRcB6Jj0P45KE9Wr90GPB2WrdA7Gwg0i/feVktzZFMzY+Nm+0j11Lfaowd1Z476XDkNZz0IJwqJWDg9246m0/HqsCnXzjy8lLW8XjLbww6lnSUY701c6l8ooHBfPnr/ZjaHB2umcLrMe435CJ1Y1sx1fU5gSkNcHH+/fCtORpbsmxNH4lhwgiEsN5mO/ftpkVOiLmNyjUzxXtGuW2C5d5s+8528iOmM/iRZE1UCIaZcljl3atBuVeiWvblI4U6GEms8M/nRpKIzo4P5eYMIzGDUCu8Zy+V1Z2ldQ8RWFDePhCrBdE/y+8DYrmS2YXey8ODW+iddNiSiAL1hQF8GYCrbZ03B1yXzUnOc2KAFEk4dWOWsGfkfMr0IXAL+5GDf7WDhKLL1i2daJ9CeVXAk6kY8uvVQef2cDy8qLGmSCLMzEXWwm4n7F4bu0c0gbV4qU3NMxs0y7/4bWhVOs/2tlGRJVJHNA6gMfF6P5c4pVf/KJs8QQ3v800KsTF5SGfXRN0Gtloaj3hZGphRkZpiyHILpBbl5Ji3TUSlM0mh07/Px8AirfgEFjsHW8Zp2fbKgWu0cOf2tx+5YEVX7vQzJQD/nLlSq4s9lPH9T6otw50=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: 21csw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0672d0ce-a695-4eef-85be-08d78c6d9f46
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2019 14:44:34.6018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46fa190c-b37a-4b1f-ac32-af89200f405c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SE8s210AcJ7sHCCvYBML3vsBVtM0f8ZWlpbxWqTxax7bbRkRsCWyjA0howFtd8KIx7oqTPOiqRV7LxJYtae+Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4093
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQp1bnN1YnNjcmliZQ0K
