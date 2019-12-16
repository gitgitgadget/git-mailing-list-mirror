Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEDCC43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 14:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356E92067C
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 14:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sixfeetup.onmicrosoft.com header.i=@sixfeetup.onmicrosoft.com header.b="yNcLdhgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfLPOcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:32:35 -0500
Received: from mail-eopbgr770100.outbound.protection.outlook.com ([40.107.77.100]:3460
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728014AbfLPOcf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 09:32:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lrh+nKDMiSvLJXUwFadN06UZo/elH/nCUsfyGrsmOOp9EFP/lGt5efY+qhV/PMLje341P4FDM3PjQ0MxsV31SleheAZf8B70Uts8yI0Ddj392g3SNXy2vU6MqyWGa5w3gnTIDLG/INQyW+A/thUETAWwUqn6u1G3Sdjsh7wKWtwW0qFDRKPfYnaAqddbSe8uoZsGNYYkgUrYgcSnxrMqPJjShPmuOFeniOgvELycMbFYxMHZzAxHJzSipiTNChHHamQBwaq63fJ2D2l0eGFJe3d54zgPw6wQcBqSPp0yRBnsj19ZIuMgqUMf43H4sdzStMpbsrackdGaLjdOlBaIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUoduHYMH/Fe3aiVbrzr1maeodfvi8cTO1X8q8plX8Y=;
 b=E6L1B7fAbQaTQtZTTDxFB9b3AmER4z5otTmo52QuCOu7KwiUuDhn1JC61b3ra/qn9TNb17ts3A9reQxQ3LBUCszj0jgKPnhyOrnSplwtZMk9+v09ZeU1DKIau6B55f4egcYEHzxvGEMdrOUeTXL6YoV+6sxmsAuqIwC8SAR10YP6GmzALeybZTnuQQsshcXDy7Yfd9HyV0XE1cWnIIKcL6LJoRzJ2s1LWUbH/juzB1OIOf20MQu/NnFWwq2WR4G6qG/DMmljH57mK+rZ09Bh9LMyq4qeQ7054yfSHYIwox7nH2hMULBsFbXY8mtVNXg9zs/4S1iKfmkLfSR4faw2YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sixfeetup.com; dmarc=pass action=none
 header.from=sixfeetup.com; dkim=pass header.d=sixfeetup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sixfeetup.onmicrosoft.com; s=selector2-sixfeetup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUoduHYMH/Fe3aiVbrzr1maeodfvi8cTO1X8q8plX8Y=;
 b=yNcLdhgTqreXthEDtv4a3ZzL6Am4P2iOcKE9bNk+lx9oY1pk9uNGH7VjJCCwu9Xjw6aNkOqmrmeMiFK7RwcQBZOURsQ9SIjB6AhSjfj5TLcFauJPoHbH5LJ5lMLYIZIMPs4xm+rEEAqEzGyJZQiL+pyOnjC/jIAUmobJx0jrcgo=
Received: from DM5PR15MB1644.namprd15.prod.outlook.com (10.175.106.151) by
 DM5PR15MB1547.namprd15.prod.outlook.com (10.173.221.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Mon, 16 Dec 2019 14:32:31 +0000
Received: from DM5PR15MB1644.namprd15.prod.outlook.com
 ([fe80::41c1:9304:15bc:24f5]) by DM5PR15MB1644.namprd15.prod.outlook.com
 ([fe80::41c1:9304:15bc:24f5%8]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 14:32:31 +0000
From:   Chrissy Wainwright <chrissy@sixfeetup.com>
To:     Kyle Meyer <kyle@kyleam.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Stash does not save rename information
Thread-Topic: Stash does not save rename information
Thread-Index: AQHVsrZ257cyQ21pSUmeF7+RdXi54qe6PywAgAABcACAAjCsAA==
Date:   Mon, 16 Dec 2019 14:32:31 +0000
Message-ID: <EF4FE28C-1111-46C7-9EDE-24940E8A5727@sixfeetup.com>
References: <296B296B-EBA0-4F1E-AFEA-ADC232E84656@sixfeetup.com>
 <87immizf55.fsf@kyleam.com> <87fthmzewl.fsf@kyleam.com>
In-Reply-To: <87fthmzewl.fsf@kyleam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chrissy@sixfeetup.com; 
x-originating-ip: [170.199.177.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aee33f65-207c-4389-40f6-08d78234c8b7
x-ms-traffictypediagnostic: DM5PR15MB1547:
x-microsoft-antispam-prvs: <DM5PR15MB1547AE797FFC90E48FBD5671A9510@DM5PR15MB1547.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39830400003)(366004)(346002)(396003)(199004)(189003)(186003)(6506007)(66556008)(110136005)(2906002)(64756008)(33656002)(66476007)(966005)(36756003)(91956017)(5660300002)(66446008)(8676002)(6486002)(71200400001)(86362001)(81156014)(81166006)(2616005)(508600001)(6512007)(316002)(8936002)(66946007)(76116006)(4744005)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1547;H:DM5PR15MB1644.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: sixfeetup.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Np9ggsSKc9RCsJihO4zf/Xel6Hu/sl6RJj3nRR1r2z+aR1e8witaVYGsBuBEiNUFv1rAJzJOLga2cRTAzcTk4pzqX68cp7Pcwm0PJ6PNnxGrHStSXB1WuXqYpbSKB7MXJnRB80mQSL/mjq9+Gq9hQZZKbAtsuwZZYPXpM6ySDTbk1qG+M1nClSmXhsELJ7FUxfgjBYwUnQ5bS8NHR68osztQyYpe5OZ4XtS0SGoawxpr3X4+AiQPWBezv2O2Q1JqQQdafid+zm3POYS5Px8wWKptfafkepX1cw98WyuOutBD/nlTeHUCR56I8APALOVuaOTtILzNSzzDtEy7BKmqDroSHvIRKmMsfmYx16SnUK6OJqPh2sc5eyamw2/jTnKWF5Plkg4IB9ejjfouPrJ7xfly0NYoI2Y+IgIuHyiucDhqE2laDJDq2shfpvSNvsPBV4rdt3BmbA7xk1VoNRB7ds4MlVb1RRGWd6jQDChlJNs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4FB539B570B12498279C199B5AE0A55@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sixfeetup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee33f65-207c-4389-40f6-08d78234c8b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 14:32:31.3077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5351e7d3-579d-4686-88d3-ac4abff7748b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3LjGKj3MNR0IAG20sqZ0rw4qTKFAZAbquhN/+d0yLbCMgP7y110Xi8VrTYqipEF97THBz522hfFGEAu5CKuVAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1547
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmsgeW91LCB1c2luZyAtLWluZGV4IGRvZXMgd29yayEgTm93IHRoZSB0cmljayBpcyB0byBh
Y3R1YWxseSByZW1lbWJlciB0byB1c2UgaXQgaW4gdGhpcyBjYXNlLCBzaW5jZSBpdCBkb2Vzbid0
IHNlZW0gdGhlIGNoYW5nZSBjYW4gYmUgcmVzdG9yZWQgaWYgeW91IGZvcmdldCB0byB1c2UgaXQg
dGhlIGZpcnN0IHRpbWUgeW91IHBvcC9hcHBseS4NCg0KVGhlbiB0aGUgZml4IGlzIHRvIGBnaXQg
bXZgIHRoZSBmaWxlcyBiYWNrIHRvIHRoZSBvcmlnaW5hbCBuYW1lLCBhbmQgdG8gdGhlIG5ldyBu
YW1lIGFnYWluLg0KDQpUaGFua3MNCkNocmlzc3kgV2FpbndyaWdodA0KIA0KLS0gDQpTaXggRmVl
dCBVcCwgSW5jLg0KUHl0aG9uICYgQ2xvdWQgRXhwZXJ0IENvbnN1bHRpbmcgDQpEaXJlY3QgTGlu
ZTogKzEgKDMxNykgODYxLTU5NDggeCg2MDQpDQpFbWFpbDogY2hyaXNzeUBzaXhmZWV0dXAuY29t
DQpodHRwczovL3NpeGZlZXR1cC5jb20NCiANCg0K77u/T24gMTIvMTQvMTksIDU6MDUgUE0sICJL
eWxlIE1leWVyIiA8a3lsZUBreWxlYW0uY29tPiB3cm90ZToNCg0KICAgIEt5bGUgTWV5ZXIgPGt5
bGVAa3lsZWFtLmNvbT4gd3JpdGVzOg0KICAgID4NCiAgICA+ICAgICAkIGdpdCBpbml0DQogICAg
PiAgICAgJCB0b3VjaCBmb28gJiYgZ2l0IGFkZCBmb28gJiYgZ2l0IGNvbW1pdCAtbWZvbw0KICAg
IA0KICAgIFNvcnJ5LCBJIGZvcmdvdCB0byBwYXN0ZSBpbiB0aGUgYGdpdCBybSBmb29gIHN0ZXAg
aGVyZS4NCiAgICANCiAgICA+ICAgICAkIGdpdCBzdGFzaA0KICAgID4gICAgICQgZ2l0IHN0YXNo
IGFwcGx5DQogICAgPiAgICAgUmVtb3ZpbmcgZm9vDQogICAgPiAgICAgT24gYnJhbmNoIG1hc3Rl
cg0KICAgID4gICAgIENoYW5nZXMgbm90IHN0YWdlZCBmb3IgY29tbWl0Og0KICAgID4gICAgIAkg
ICAgZGVsZXRlZDogICAgZm9vDQogICAgPg0KICAgID4gICAgIG5vIGNoYW5nZXMgYWRkZWQgdG8g
Y29tbWl0DQogICAgDQoNCg==
