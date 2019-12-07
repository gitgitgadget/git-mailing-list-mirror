Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F59EC43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093E02245C
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ksysllc.onmicrosoft.com header.i=@ksysllc.onmicrosoft.com header.b="eBq1MZ0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfLGA3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:29:15 -0500
Received: from mail-eopbgr1310059.outbound.protection.outlook.com ([40.107.131.59]:12352
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726469AbfLGA3O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 19:29:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hf9o2/sWwsyC5PqxxvAjJWQeVh4UWa0ET982FON18OVO70HT46d27Yq0EyRCvZXz4EfUU9M6CwvzMKiCxljfnvdAO+q83L/X6gOKhoYiaumsH+J2HPfCSq23+b1jWNCibUmKGZUTEXt4q9sVjbl3ZF/gxZwfhNPgTB+jB57oMR2rmnX466QZx43QJfrkKYkjYOtfqahW3YxxBU4+Hht2VAkh/mHWzGdSsWLpt3OYLQt4RS0lL3wZ+m/QXUANJ/7bLLRiAldiD57JN/ldRwZhYAA8gJSluB7+ksTXs+64lQluVOZI8Lalpm7zR/nk515w7gD+px5iGCjGyslcKqzfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMV8uW+g4TPegDFoOZrSZ+C6LntdPbyASG6MyKrTRsQ=;
 b=PuMrkXx0gO+elPEKaN31m41IaTdIZ2oufsWO8zw+zLODQrO1uhPk3EF5bQZDEGBK1gcOxGoKz7b6QXRr2y85Yd84b5QGmtXnY7ejqTQ+JMLdbVd42khYf6fI8MCSzOfq9+FvafCR+oipS7TbZIWLBOiLLX3ci7eTuS6VBKL6Vzd3UZGEBLASaobDWCAi2r9xCthszRnkRZUJ0CrSIfImr6p9IIBCS9TJKysgo+XoYP61bFbBmEx41m9swszwSeiE8nDmmDguM7JdtOkicJE+D1mahIv0klV8kpPRfl2Tx/IDAu8mNzRmU5y30HIw7DdD4uBDazO7LWesGKtnWtZ9fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ksysllc.co.jp; dmarc=pass action=none
 header.from=ksysllc.co.jp; dkim=pass header.d=ksysllc.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ksysllc.onmicrosoft.com; s=selector2-ksysllc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMV8uW+g4TPegDFoOZrSZ+C6LntdPbyASG6MyKrTRsQ=;
 b=eBq1MZ0a1KzrvbUb+aiyeuxRdkESojOWF43IFq9S6vqtFZ4hYutSAXQV3vVDRC1fEHujhC0r6YVw0/eqwt3xqwcRducSaOfVfjsr4sz6gkjySwkNLUDfENKKATFbwL+shYta8Nb0yrcERQ6RlyZb16R5bzeTctY+UE+3Ict+wWA=
Received: from TY2PR01MB2427.jpnprd01.prod.outlook.com (20.177.100.73) by
 TY2PR01MB3532.jpnprd01.prod.outlook.com (20.178.141.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Sat, 7 Dec 2019 00:29:09 +0000
Received: from TY2PR01MB2427.jpnprd01.prod.outlook.com
 ([fe80::b074:84bd:8776:a29f]) by TY2PR01MB2427.jpnprd01.prod.outlook.com
 ([fe80::b074:84bd:8776:a29f%7]) with mapi id 15.20.2516.015; Sat, 7 Dec 2019
 00:29:09 +0000
From:   =?utf-8?B?5Yqg6Jek5LiA5Y2a?= <kato-k@ksysllc.co.jp>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     =?utf-8?B?5Yqg6Jek5LiA5Y2a?= <kato-k@ksysllc.co.jp>
Subject: [PATCH] git gui: fix branch name encoding error on git gui
Thread-Topic: [PATCH] git gui: fix branch name encoding error on git gui
Thread-Index: AQHVrJVXQ11/xAaD40W94w+igsJl6A==
Date:   Sat, 7 Dec 2019 00:29:09 +0000
Message-ID: <20191207002842.32208-1-kato-k@ksysllc.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYAPR01CA0059.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::23) To TY2PR01MB2427.jpnprd01.prod.outlook.com
 (2603:1096:404:7b::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kato-k@ksysllc.co.jp; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1.windows.1
x-originating-ip: [123.223.66.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ead66689-63fe-455a-0bb9-08d77aac79e8
x-ms-traffictypediagnostic: TY2PR01MB3532:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB3532C433A2DEF5B580D9F90CCA5E0@TY2PR01MB3532.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0244637DEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(8676002)(6916009)(305945005)(6486002)(316002)(5640700003)(6512007)(99286004)(52116002)(36756003)(1076003)(66556008)(64756008)(66476007)(66446008)(66946007)(5660300002)(2616005)(26005)(508600001)(86362001)(102836004)(6506007)(107886003)(186003)(85182001)(4326008)(2906002)(71200400001)(1730700003)(81166006)(81156014)(71190400001)(8936002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:TY2PR01MB3532;H:TY2PR01MB2427.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ksysllc.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: stNyDwZ3a78ME5QJHmJq9HHYf3/nQsQkLi17B1eJpnGt9+Qtj/lxUVQ+3IyLng3nRCj/QbIwXaNAyK+xWtqSi1yilFxQY1Qvog+r4D1XhePm/sV1gRPTXUqUJZdq1IpAvWQQdX0C/8l5pTFTDMsKeVxtm+Er3xMBegNmyp1CcAtFAiu6QanMKoYNnbdVISIonKiT1hhUNDbCyB3K5VS+DcdsyWm/1O+RoGxysvdoR/NasURZXqUV+lW9957R+MAylMnVqK5NzHAzfXc6VXteocA6qtZ3vFV1EQSH3wTP6U+Bko2PZ5MGYK4droPytQdG1U+S8vxlOpAlHKSzcbox8KnYRg+qBFdSqHilx1kvQ0A5oEIRRz2nyoTDpncbDiKJrA42iGCgFg2FetuaXNEgEwLmubcaf9Dr/OJG7CdIHQZvuJ607Tok0xAu2ClKyohs
Content-Type: text/plain; charset="utf-8"
Content-ID: <138ADBC2E5F55D489BBED32D6BD41166@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ksysllc.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ead66689-63fe-455a-0bb9-08d77aac79e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2019 00:29:09.5617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e2e801e1-1bfd-4c29-8e88-a6b5a79038d8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOrNAlFzRYuREVc6PFDwgyyoqBs+PsI/Lui/HrZlaiGEO66fT1NTpzZ5Da7cQuSiJ1pPNyS9rBBkimkVOI2x0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3532
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QWZ0ZXIgImdpdCBjaGVja291dCAtYiAn5ryi5a2XJyIgdG8gY3JlYXRlIGEgYnJhbmNoIHdpdGgg
VVRGLTgNCmNoYXJhY3RlciBpbiBpdCwgImdpdCBndWkiIHNob3dzIHRoZSBicmFuY2ggbmFtZSBp
bmNvcnJlY3RseSwNCmFzIGl0IGZvcmdldHMgdG8gdHVybiB0aGUgYnl0ZXMNCnJlYWQgZnJvbSB0
aGUgImdpdCBmb3ItZWFjaC1yZWYiIGFuZA0KcmVhZCBmcm9tICJIRUFEIiBmaWxlDQppbnRvIFVu
aWNvZGUgY2hhcmFjdGVycy4NCg0KU2lnbmVkLW9mZi1ieTogS2F6dWhpcm8gS2F0byA8a2F0by1r
QGtzeXNsbGMuY28uanA+DQotLS0NCiBnaXQtZ3VpLnNoICAgICB8IDEgKw0KIGxpYi9icmFuY2gu
dGNsIHwgMiArKw0KIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9naXQtZ3VpLnNoIGIvZ2l0LWd1aS5zaA0KaW5kZXggMGQyMWY1Ni4uOGY0YTlhZSAxMDA3
NTUNCi0tLSBhL2dpdC1ndWkuc2gNCisrKyBiL2dpdC1ndWkuc2gNCkBAIC02ODQsNiArNjg0LDcg
QEAgcHJvYyBsb2FkX2N1cnJlbnRfYnJhbmNoIHt9IHsNCiAJZ2xvYmFsIGN1cnJlbnRfYnJhbmNo
IGlzX2RldGFjaGVkDQogDQogCXNldCBmZCBbb3BlbiBbZ2l0ZGlyIEhFQURdIHJdDQorCWZjb25m
aWd1cmUgJGZkIC10cmFuc2xhdGlvbiBiaW5hcnkgLWVuY29kaW5nIHV0Zi04DQogCWlmIHtbZ2V0
cyAkZmQgcmVmXSA8IDF9IHsNCiAJCXNldCByZWYge30NCiAJfQ0KZGlmZiAtLWdpdCBhL2xpYi9i
cmFuY2gudGNsIGIvbGliL2JyYW5jaC50Y2wNCmluZGV4IDc3N2VlYjcuLjhiMGM0ODUgMTAwNjQ0
DQotLS0gYS9saWIvYnJhbmNoLnRjbA0KKysrIGIvbGliL2JyYW5jaC50Y2wNCkBAIC04LDYgKzgs
NyBAQCBwcm9jIGxvYWRfYWxsX2hlYWRzIHt9IHsNCiAJc2V0IHJoX2xlbiBbZXhwciB7W3N0cmlu
ZyBsZW5ndGggJHJoXSArIDF9XQ0KIAlzZXQgYWxsX2hlYWRzIFtsaXN0XQ0KIAlzZXQgZmQgW2dp
dF9yZWFkIGZvci1lYWNoLXJlZiAtLWZvcm1hdD0lKHJlZm5hbWUpICRyaF0NCisJZmNvbmZpZ3Vy
ZSAkZmQgLXRyYW5zbGF0aW9uIGJpbmFyeSAtZW5jb2RpbmcgdXRmLTgNCiAJd2hpbGUge1tnZXRz
ICRmZCBsaW5lXSA+IDB9IHsNCiAJCWlmIHshJHNvbWVfaGVhZHNfdHJhY2tpbmcgfHwgIVtpc190
cmFja2luZ19icmFuY2ggJGxpbmVdfSB7DQogCQkJbGFwcGVuZCBhbGxfaGVhZHMgW3N0cmluZyBy
YW5nZSAkbGluZSAkcmhfbGVuIGVuZF0NCkBAIC0yNCw2ICsyNSw3IEBAIHByb2MgbG9hZF9hbGxf
dGFncyB7fSB7DQogCQktLXNvcnQ9LXRhZ2dlcmRhdGUgXA0KIAkJLS1mb3JtYXQ9JShyZWZuYW1l
KSBcDQogCQlyZWZzL3RhZ3NdDQorCWZjb25maWd1cmUgJGZkIC10cmFuc2xhdGlvbiBiaW5hcnkg
LWVuY29kaW5nIHV0Zi04DQogCXdoaWxlIHtbZ2V0cyAkZmQgbGluZV0gPiAwfSB7DQogCQlpZiB7
IVtyZWdzdWIgXnJlZnMvdGFncy8gJGxpbmUge30gbmFtZV19IGNvbnRpbnVlDQogCQlsYXBwZW5k
IGFsbF90YWdzICRuYW1lDQotLSANCjIuMjAuMS53aW5kb3dzLjENCg0K
