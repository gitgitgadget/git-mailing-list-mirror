Return-Path: <SRS0=+pXB=2E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AADC43603
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 19:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1942073D
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 19:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sixfeetup.onmicrosoft.com header.i=@sixfeetup.onmicrosoft.com header.b="rEzMNxV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfLNTlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Dec 2019 14:41:24 -0500
Received: from mail-eopbgr760128.outbound.protection.outlook.com ([40.107.76.128]:38063
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbfLNTlY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Dec 2019 14:41:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIxD8aywON4hRUfOli64C6lMvPqjzeS2C6C1A4EgeyNAknwHFZppeguh9WsFkcedwzLGywX/UHzg9MOQ3Yt4LOdU2GLCPkQpie8PnkMjThXLYGQ21Q5w4X7jX6O+t1Jkh0uL8miWS46dUrN4IpQz5d2fKqFDLUALJjK1bAXDU+bQw/J+c7ttqvhIo8bASF+gu+9lCKZeQSd05496I/j8UqLZFGS+/C2W5EdCASJCwyjVGLVAm8uR3K8fqMgXiRdPbokxTBqe+aFKdEynFF+g2cTD1q6pvNoLeqPBjPx3FTEaqcCp2y9o16Vp/mt8GJfxd/8VFoFptY36axgQFcqSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N58FqQzVM+s+bth60MscYtmeUAHlsRiHlDp7iTRaL5s=;
 b=n7uLCMVWOfqRKGf/bdaxzkyGvMcDxaCs/qgZFN7gjI5ZYZX6U4xa4ar1+8ivN375t9sWEQJSutEtIh2Yq7OP/77MbWA8/+gI2G+ERtUiOXFTLQeehw23dLcZC0j1lw9PE30x/StQCIr4LCaJtsURsi6t9viEy57uaBo/Xa+aPhOED5c3tT6Hi0JzvU29OLRmktTzeHVtrbX06sZNpj22hUMfvxBgDTrUIHAXCroOAK8hzhKxvjCq1c81VmNT29pEvbWyiD9JWuPdKL3fF1ug9vNZ4POxiWLfwmjgW28k4JwpxBAj53Gc8I3kgQ39I1MBs4bhnyjqBzRmkaM+mgrr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sixfeetup.com; dmarc=pass action=none
 header.from=sixfeetup.com; dkim=pass header.d=sixfeetup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sixfeetup.onmicrosoft.com; s=selector2-sixfeetup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N58FqQzVM+s+bth60MscYtmeUAHlsRiHlDp7iTRaL5s=;
 b=rEzMNxV9goVGV8EMUYzsTD5xcFLamQGUlDqZUmmNDxaO0b16eSUrDzjygA5ClEYv+d7+ykwS/KwXOFdEbeRT6CX5w2l20Q0ATsf+17Fo/YYLeWu4/NvTAMOLsM3ms2h+W19ToBsvlbfL0NPEcBx4hu5JZAHS4reTIzHjb5rIk+s=
Received: from BN6PR15MB1633.namprd15.prod.outlook.com (10.175.129.23) by
 BN6PR15MB1508.namprd15.prod.outlook.com (10.172.152.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Sat, 14 Dec 2019 19:41:22 +0000
Received: from BN6PR15MB1633.namprd15.prod.outlook.com
 ([fe80::123:896b:55e0:add6]) by BN6PR15MB1633.namprd15.prod.outlook.com
 ([fe80::123:896b:55e0:add6%12]) with mapi id 15.20.2538.019; Sat, 14 Dec 2019
 19:41:22 +0000
From:   Chrissy Wainwright <chrissy@sixfeetup.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Stash does not save rename information
Thread-Topic: Stash does not save rename information
Thread-Index: AQHVsrZ257cyQ21pSUmeF7+RdXi54g==
Date:   Sat, 14 Dec 2019 19:41:22 +0000
Message-ID: <296B296B-EBA0-4F1E-AFEA-ADC232E84656@sixfeetup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chrissy@sixfeetup.com; 
x-originating-ip: [170.199.177.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2fa875b-6321-4f98-b5ae-08d780cd9944
x-ms-traffictypediagnostic: BN6PR15MB1508:
x-microsoft-antispam-prvs: <BN6PR15MB150887F9B13521454A35498DA9570@BN6PR15MB1508.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 025100C802
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39830400003)(346002)(376002)(189003)(199004)(64756008)(66446008)(66946007)(66556008)(6916009)(66476007)(36756003)(76116006)(316002)(71200400001)(6486002)(81166006)(8676002)(81156014)(6506007)(2616005)(86362001)(4744005)(5660300002)(186003)(6512007)(2906002)(8936002)(91956017)(26005)(508600001)(966005)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1508;H:BN6PR15MB1633.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: sixfeetup.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: giM8XRKS9KYwAD7ssAroq7cMKabCMcEXLDn53kjC9zKe6qbkrA8oSewpwVYRWy18gHBgU7woIVMXAKfuQQ6lzqDVRqrREW5ZwSdpZWsEqEe2esROPPhgUZahssNKyv6B95wyGIYj3uA4vh1xzq/s3d3QCGZbA1+SGWwvXtreDF2jhTOrqebdA2eqP4FgET1/xX5Osn+4LIYkzfwO/ancZ8TizTiPb4lVc3/qbeVDvjMwzHDnZ4WTdhTYQUD8Sz0FhtsbKrwAZ0pIoM0WhhrqTZw5OV4EhmxXlUDGzI5bjXVFtnT2t6FijhB4Crc0/GRCqLE8ahdYB6aDwADkJA6Ho39QEzA/f/Kee774GV/OICcL8QErP8TYdfIEq7519J/Klu1UkyEcU77URXz0e2rIVzGOy50HLeFbenhqY0gX/7Lv0suOhuT4pLaNXrUB3a9G+IdVXJYLPR9Rtn1lyCtjPMYJ1bqAhfLZtBEZbW3K3VM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9429EA3F1EE764F892C4686ADAFDE7B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sixfeetup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fa875b-6321-4f98-b5ae-08d780cd9944
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2019 19:41:22.3742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5351e7d3-579d-4686-88d3-ac4abff7748b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BATPZoQB+SBJJOuxpGszCKIXaeqAStqVnk35P/TASRihEoIfTMAtVG8fLqPdFnN5THcWLX3bM4VIEuHE97aJ8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1508
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhpcyBzZWVtcyB0byBiZSBhIGJ1ZzoNCsKgDQoJMQlVc2UgYGdpdCBtdmAgdG8gcmVuYW1lIGEg
ZmlsZQ0KCTIJYGdpdCBzdGF0dXNgIHNob3dzIHRoZSBmaWxlIHdhcyByZW5hbWVkDQoJMwlTdGFz
aCB0aGUgY2hhbmdlcw0KCTQJUG9wIHRoZSBzdGFzaA0KCTUJYGdpdCBzdGF0dXNgIHNob3dzIHRo
ZSBmaWxlIGNoYW5nZSBhcyBkZWxldGVkL25ldyBmaWxlIGluc3RlYWQgb2YgYSByZW5hbWUNCg0K
DQpUaGFua3MNCkNocmlzc3kgV2FpbndyaWdodA0KIA0KLS0gDQpTaXggRmVldCBVcCwgSW5jLg0K
UHl0aG9uICYgQ2xvdWQgRXhwZXJ0IENvbnN1bHRpbmcgDQpEaXJlY3QgTGluZTogKzEgKDMxNykg
ODYxLTU5NDggeCg2MDQpDQpFbWFpbDogY2hyaXNzeUBzaXhmZWV0dXAuY29tDQpodHRwczovL3Np
eGZlZXR1cC5jb20NCiANCg0K
