Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LONGWORDS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA682C43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A39E205ED
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ksysllc.onmicrosoft.com header.i=@ksysllc.onmicrosoft.com header.b="Smn9UM7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLGAc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:32:29 -0500
Received: from mail-eopbgr1310079.outbound.protection.outlook.com ([40.107.131.79]:4634
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726374AbfLGAc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 19:32:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyZ/NELKZHXN6DK8gC2GzNSGYSNOOrFqIKbZWpWPGQ5cxAIY2srtLIqp76SBVoK5pc63ZU2F5g1S7Lz0JNGRF1d/nZX/AcF49NQ04cUIItLB+Xcw1aqBziGue8L6ol4T6th71H4jtYH8iq0+dIhcLf35Dmkn0vyWTkpbBG1tGfdxoCgEsSPEZX3a0ghYunIy4tCwhKQndIMU9rMK/fY0WyjAFX10rl6H5TLMpagBt7r0iJvlyCmWSGuD0lqteoTmKidyCKPh/76fw0T+ui7fABMUyVpdZ7u3ihn9tNvFPZtPcXOzFSXJrRJMTtKmVIoQ/EzdUG68Qq4CleGucrFIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hG4WCqXF1Dst0Yy6Hfl8vO1FzrK9N9NQcPNg44r+XT4=;
 b=n8VxshwvcyJLfeHQL1ZLC38PQJExNghgUM53D0+rZkCUh3gUtkyXVEV3Jx0gRaV7jW+FMvPcA3iCFnyc/+2XoKsuvdOiC0V31S/xuC0wA8HB0Ul8SxdzDvZdFvwPoO253gvMLg3KgW9DDna1DWPkdSlQ1SqQGtwO7uG6jEt2+5WkeFxZ+6Bqq3mdtLPySP6fG6eYO1etqqmaHCkj8dGuPQnVvMhrLBcMEj0r/tBiHgYopwZeAJU6K/2oRc97Lsf9Mtuu5V1EQ7SUAmJUNpMJLs0OzvmXkqlaUBThXfbGLNR1HYxMo1CZI6De7NtK1xVQNNbMo55FbW9chPU8QVHO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ksysllc.co.jp; dmarc=pass action=none
 header.from=ksysllc.co.jp; dkim=pass header.d=ksysllc.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ksysllc.onmicrosoft.com; s=selector2-ksysllc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hG4WCqXF1Dst0Yy6Hfl8vO1FzrK9N9NQcPNg44r+XT4=;
 b=Smn9UM7vLSac14bKMaqgWdnMjx1kVna1IQEwMNDHPKjQrcePmrlrK+rDVxtfwEqyTFs8C06C4LJ5LxJKEbpvrytaAWOG7SrR80OSzObR9P0zgLICK59JZKj0RCKFJPHngGuOjG9+zQJBabD4wJ+UNDClU5XmvhQ71H/hUR9drhg=
Received: from TY2PR01MB2427.jpnprd01.prod.outlook.com (20.177.100.73) by
 TY2PR01MB3532.jpnprd01.prod.outlook.com (20.178.141.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Sat, 7 Dec 2019 00:32:25 +0000
Received: from TY2PR01MB2427.jpnprd01.prod.outlook.com
 ([fe80::b074:84bd:8776:a29f]) by TY2PR01MB2427.jpnprd01.prod.outlook.com
 ([fe80::b074:84bd:8776:a29f%7]) with mapi id 15.20.2516.015; Sat, 7 Dec 2019
 00:32:25 +0000
From:   =?utf-8?B?5Yqg6Jek5LiA5Y2a?= <kato-k@ksysllc.co.jp>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     kazuhiro kato <kazuhiro.kato@hotmail.co.jp>,
        =?utf-8?B?5Yqg6Jek5LiA5Y2a?= <kato-k@ksysllc.co.jp>
Subject: [PATCH] gitk: fix branch name encoding error on gitk
Thread-Topic: [PATCH] gitk: fix branch name encoding error on gitk
Thread-Index: AQHVrJXMazqV0th7Ckux+28wTk3POg==
Date:   Sat, 7 Dec 2019 00:32:25 +0000
Message-ID: <20191207003203.9612-1-kato-k@ksysllc.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYCPR01CA0012.jpnprd01.prod.outlook.com (2603:1096:405::24)
 To TY2PR01MB2427.jpnprd01.prod.outlook.com (2603:1096:404:7b::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kato-k@ksysllc.co.jp; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1.windows.1
x-originating-ip: [123.223.66.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a7f75e7-1ca9-4297-c6be-08d77aacee87
x-ms-traffictypediagnostic: TY2PR01MB3532:|TY2PR01MB3532:
x-ld-processed: e2e801e1-1bfd-4c29-8e88-a6b5a79038d8,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB3532FADE7C0F92FB3B534079CA5E0@TY2PR01MB3532.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0244637DEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(8676002)(6916009)(305945005)(6486002)(54906003)(316002)(5640700003)(6512007)(99286004)(52116002)(36756003)(1076003)(66556008)(64756008)(66476007)(66446008)(4744005)(66946007)(5660300002)(2616005)(26005)(508600001)(86362001)(102836004)(6506007)(107886003)(186003)(85182001)(4326008)(2906002)(71200400001)(1730700003)(81166006)(81156014)(71190400001)(8936002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:TY2PR01MB3532;H:TY2PR01MB2427.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ksysllc.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cjwobV6A7msvC2PgXGTdL/4r5IqaD/lSiVFDUek+3JOH890RGxVDvdk3FE4hRmxrHOwcNjgfKHFmvBAKxspCPVceYCvpfORde3RlberAx1svxrvi/T/QRqYPjxol5RhANh1nnDdxacWTZWteFsg9PWZxuONhkYNS0R9LYe9xGSgfSwzs4wDP+NinIACBnulY0icJAfh7lgmVbY8UJfQvIBm8nps1quPmnq8kFzNO+10PYfXfNH2sT8Tp+9U/vCSDIQJ9ZSRRNtZNLs2Ze6IogDtJm+9iUm3vO0X53GsXV5IKMbg5DccVMGt5/wcMI96vu5AqlhJNNhv9PA/rN8prxlteRlxmPZyO8fCuJmuFXcI4Vx4FZ4s1W7fVZCxkXvEx8SY+L+cz62vz/6F+IIQcd3rHS3+fAd9IPqTXKyZD1kAyQ31OJE4We3e1NtVdeMSO
Content-Type: text/plain; charset="utf-8"
Content-ID: <1106DCBB6E6DD94CB9E254A168A4B580@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ksysllc.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7f75e7-1ca9-4297-c6be-08d77aacee87
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2019 00:32:25.2392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e2e801e1-1bfd-4c29-8e88-a6b5a79038d8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hO18vvnCYsP6m1ZxLqFwhP+T36S4ZoHEXF4lWVyMAd1hg6HgT9prdr/Ob1BecX2eXNbmBHa9jROYXPJiVE1Pzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3532
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RnJvbTogS2F6dWhpcm8gS2F0byA8a2F6dWhpcm8ua2F0b0Bob3RtYWlsLmNvLmpwPg0KDQpBZnRl
ciAiZ2l0IGNoZWNrb3V0IC1iICfmvKLlrZcnIiB0byBjcmVhdGUgYSBicmFuY2ggd2l0aCBVVEYt
OA0KY2hhcmFjdGVyIGluIGl0LCAiZ2l0ayIgc2hvd3MgdGhlIGJyYW5jaCBuYW1lIGluY29ycmVj
dGx5LCBhcyBpdA0KZm9yZ2V0cyB0byB0dXJuIHRoZSBieXRlcyByZWFkIGZyb20gdGhlICJnaXQg
c2hvdy1yZWYiIGNvbW1hbmQNCmludG8gVW5pY29kZSBjaGFyYWN0ZXJzLg0KDQpTaWduZWQtb2Zm
LWJ5OiBLYXp1aGlybyBLYXRvIDxrYXRvLWtAa3N5c2xsYy5jby5qcD4NCi0tLQ0KIGdpdGsgfCA0
ICsrKysNCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9n
aXRrIGIvZ2l0aw0KaW5kZXggYWJlNDgwNS4uM2Y2MWE1YiAxMDA3NTUNCi0tLSBhL2dpdGsNCisr
KyBiL2dpdGsNCkBAIC0xNzgwLDExICsxNzgwLDE1IEBAIHByb2MgcmVhZHJlZnMge30gew0KICAg
ICBnbG9iYWwgb3RoZXJyZWZpZHMgaWRvdGhlcnJlZnMgbWFpbmhlYWQgbWFpbmhlYWRpZA0KICAg
ICBnbG9iYWwgc2VsZWN0aGVhZCBzZWxlY3RoZWFkaWQNCiAgICAgZ2xvYmFsIGhpZGVyZW1vdGVz
DQorICAgIGdsb2JhbCB0Y2xlbmNvZGluZw0KIA0KICAgICBmb3JlYWNoIHYge3RhZ2lkcyBpZHRh
Z3MgaGVhZGlkcyBpZGhlYWRzIG90aGVycmVmaWRzIGlkb3RoZXJyZWZzfSB7DQogCXVuc2V0IC1u
b2NvbXBsYWluICR2DQogICAgIH0NCiAgICAgc2V0IHJlZmQgW29wZW4gW2xpc3QgfCBnaXQgc2hv
dy1yZWYgLWRdIHJdDQorICAgIGlmIHskdGNsZW5jb2RpbmcgIT0ge319IHsNCisJZmNvbmZpZ3Vy
ZSAkcmVmZCAtZW5jb2RpbmcgJHRjbGVuY29kaW5nDQorICAgIH0NCiAgICAgd2hpbGUge1tnZXRz
ICRyZWZkIGxpbmVdID49IDB9IHsNCiAJaWYge1tzdHJpbmcgaW5kZXggJGxpbmUgNDBdIG5lICIg
In0gY29udGludWUNCiAJc2V0IGlkIFtzdHJpbmcgcmFuZ2UgJGxpbmUgMCAzOV0NCi0tIA0KMi4y
MC4xLndpbmRvd3MuMQ0KDQo=
