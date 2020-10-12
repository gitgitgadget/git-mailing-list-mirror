Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2244AC433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 13:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B079021BE5
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 13:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ZnTBekOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbgJLNjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 09:39:00 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45912 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731287AbgJLNi4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Oct 2020 09:38:56 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CDcfXZ008095;
        Mon, 12 Oct 2020 15:38:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=P16aCLq7J6JsosSlVXVZ6lYUWouKmOnP7yck8OHyKSs=;
 b=ZnTBekOTFlZ8M2IBROaDMY3o3zur4KzQgyEnDl9GOZq+BFDkF7gJYPzj9+jtPRXME3tq
 pmwpd40psaB8B65g74xFQZh8xb7oAH9tR4ggxqyop0XU8uzPwH+UspdaoW7ySvFMNuRW
 /YoNYXcF8ghstpUF6hfHehXgtIaDfOPKTmAy4c0ZgB7DILY3yrj/hqPwPGkhwxMe39Vq
 IdKogLNwv09KrL6CNUcz5vowKpDJq/bp8ACydFxm6UCVECqLyogMK2CLMJqrKUwF3wgJ
 6SXAsXWAXGyGyU0k2Zd1/funv1+Ys0pYOD+yr6zeSYdUSnJDiXGASbqiB1evlmNGfncS YQ== 
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109])
        by mx07-00178001.pphosted.com with ESMTP id 34353qhe3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 15:38:44 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUCfbTn9f2kTxE7vpHnsoOMdU8Lgwq+mWJsvsBlQxyDwloGaLchy+z1fM9xOLgOALwYdxp2ZBrwOZ9Oys2P+K0DHjmVY5/Y0mmoyJJ7EXiv7BtFRmxBjNg1qQgsTxKKTDS9ww+roPjDtC7w/X5r1WJHdJolLvYUMXOwva1e+3nD1LuVXfYRlvepqlzJAfs7XZ2FDmOrFNFbqQiexwoPBPep7soTMOd1zpkoh0eXpr6rxeebwWykjtFmvaCCrQvcHtP9yLBiO+SkKC3X9eOgruaqqNtGUOSiRg83UyWBY/n7t74J8TUCE09ahxWPAfDnb8T0fqNlYiLwEQ+pn2qEoHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P16aCLq7J6JsosSlVXVZ6lYUWouKmOnP7yck8OHyKSs=;
 b=DMUCW+nPaOXWhDT83HYIsT3O8QjEWOhWKLXfnU8VnIdGE/QNY8imJk1vhr2PXKGYoQ6z31VrFLSQd0tg0iTdyCofiu+YY0XL9BtCAb2VCU1DMzwWG/I+rjf6963Gvquq4GxlQIoDZycqDJ8/+wonwkkbh/fxD3v9WCLghE9an+/IyCnIW72Kx18LMaglsn3hcYhe6bTpLOLQYvv6fg4fj36FLTWRPvoRIzTpqZou+OlEw79Jse4QSZxR/ZwTemJUph2oYLd1gna9eGgQPWjHOtPL5WJmqJhG4rjVfqZZ7SPw9khFo9gg/KfQDPNb5Tx5JvQGq3L1OMGxnd/3eF9NYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:10d::31)
 by VI1PR1001MB1312.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Mon, 12 Oct
 2020 13:38:43 +0000
Received: from VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51bd:39d7:e531:8178]) by VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51bd:39d7:e531:8178%7]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 13:38:42 +0000
From:   Ulrich HERRMANN <ulrich.herrmann@st.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: =?utf-8?B?UkU6IGdpdCBzdWJtb2R1bGUgc3RhdHVzIG5ldmVyIHNheXMg4oCcb2xkIGNv?=
 =?utf-8?B?bW1pdHPigJ0=?=
Thread-Topic: =?utf-8?B?Z2l0IHN1Ym1vZHVsZSBzdGF0dXMgbmV2ZXIgc2F5cyDigJxvbGQgY29tbWl0?=
 =?utf-8?B?c+KAnQ==?=
Thread-Index: AdZ3sabD0U6YTkSuQ/ag43rBt7mKxgAAt9ywABylaAAKHSn7sA==
Date:   Mon, 12 Oct 2020 13:38:42 +0000
Message-ID: <VE1PR10MB337438892373C3BA86D879D394070@VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM>
References: <VE1PR10MB33746C60D550BB11162F5E24945B0@VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM>
 <VE1PR10MB3374796F04367FA5DE25F921945B0@VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM>
 <20200822015402.GY8085@camp.crustytoothpaste.net>
In-Reply-To: <20200822015402.GY8085@camp.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: crustytoothpaste.net; dkim=none (message not signed)
 header.d=none;crustytoothpaste.net; dmarc=none action=none
 header.from=st.com;
x-originating-ip: [165.225.94.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c431399a-5c72-4709-0bc5-08d86eb422c0
x-ms-traffictypediagnostic: VI1PR1001MB1312:
x-microsoft-antispam-prvs: <VI1PR1001MB1312E4227DF0996C3465D69694070@VI1PR1001MB1312.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cWml79ob48rh6jNxyGG0xDqxSKjojfZdrqN6Eao89I5IwJfRCbbW2YXBrAVLgujjrRDutU3pZVEM+Oj/ezOV6TVjMtvGpg2NBlyD3l9Nu0BiKkmvVl/d9ORdBXhY0VEpg0rpHFaXKQzk9aZ4Gyr9YY6Yhyuv0QsyPNNLiASciyfttnz37AFNDfYMIFAyvNg0iEZhvNDFNHAD1YWF2xLW2p6J1JUZ15giOFmbeDc8FiNL+CshTMpbQRodCu1EUWV7Y8b803cE3LwSsY19SFzT5OnBw6OXy7RQ/kAtJZ3ClIL47sVKaV45UGcprg4iujE42DyI4gniQhoRJHRSWERV/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(9686003)(26005)(55236004)(6506007)(53546011)(8936002)(186003)(33656002)(6916009)(478600001)(2906002)(7696005)(55016002)(4326008)(5660300002)(52536014)(86362001)(66556008)(66446008)(316002)(76116006)(66476007)(64756008)(66946007)(71200400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vmI243OvAvtyVUseNbxjL08CQmeLGG5rtFEbplSVQwqo1HLQkvqNazYg5HH148wt5DfH5FH6gLbx6GHYY4ehWBTTTUZYJRfQ+W9H/R6dZRoi898dwmGICg5eOeA1G0QA4YGya8I0rUULqTZ0eNGhvbR3LZz+FCjPNJFjU8uGJsOVT1c4Ca2zw64GM0vBxH1d6GIk0AOJvV9eg+hV4Jsa7ZdL7zp1lwH4HxQi9E2q6iBubYKNUSEao+oTTqnpVkrR275rsnM9zUdYc+EVA9W1p4X4IXxU5KpS4HnxYvJdYxExYP8zRMTJl1GyKdCW5GInfHh6/r7e/V8UC8KWlKpE2S3WHhTbx5h6zeeKjckDQ6+BOWb99uEngy8nNM22v7zJKduQn9phFz1tjTC3gpkDIS991nNBLGDdU/z5d4j7eF1msriD9UO1KpjvsdpHDzuUQ9Byf9cuJa56SkXns3/SQRGTnOzNG7qVxLW4Fsdutzbape4lc7Wlfq302ELw/wu4ZN53tuBsCMFyWVOdLqSPGlD/jhoNCZqh3BfCKUz4B6QkV2qpXDhDJJlxP6hNZWE+F+iflykrsXKgJY148jQGugIRz3TC8L2RKxh1EnjBy2OJu3bL8FLN6wMo+utRxjMzi0SvfEV+Q97xkwzkVMhGMA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR10MB3374.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c431399a-5c72-4709-0bc5-08d86eb422c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 13:38:42.8225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adxDz6/IVWVQCveN8uUbbKU2xc5/9aBi2uiZ1Lo2PJgMI3tzcoNBIP8ttZtQGzBaR0VO0cDiMEYxFkC6VXOsnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1312
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_09:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010120110
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgQnJpYW4sDQoNCnRoYW5rIHlvdSBmb3IgdGhpcyBhbnN3ZXIuIEkgaGFkIG1pc3NlZCB0aGUg
c3VtbWFyeS8tLXN1Ym1vZHVsZSBvcHRpb24uIFRoZXkgc2VlbSB0byBiZSBwcmV0dHkgdXNhYmxl
Lg0KDQpCZXN0IFJlZ2FyZHMsIFVscmljaA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogYnJpYW4gbS4gY2FybHNvbiA8c2FuZGFsc0BjcnVzdHl0b290aHBhc3RlLm5ldD4gDQpT
ZW50OiBTYXR1cmRheSwgMjIgQXVndXN0IDIwMjAgMDM6NTQNClRvOiBVbHJpY2ggSEVSUk1BTk4g
PHVscmljaC5oZXJybWFubkBzdC5jb20+DQpDYzogZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVj
dDogUmU6IGdpdCBzdWJtb2R1bGUgc3RhdHVzIG5ldmVyIHNheXMg4oCcb2xkIGNvbW1pdHPigJ0N
Cg0KT24gMjAyMC0wOC0yMSBhdCAxMjoxNDo1OCwgVWxyaWNoIEhFUlJNQU5OIHdyb3RlOg0KPiBI
aSBhbGwsDQo+IA0KPiBJIGFtIG5vdyBhIHVzZXIgb2YgZ2l0LXN1Ym1vZHVsZXMgZm9yIHF1aXRl
IHNvbWUgdGltZS4gSG93ZXZlciBJIHN0aWxsIA0KPiBoYXZlbuKAmXQgZmlndXJlZCBvdXQgaG93
IHRvIGdldCBiZXR0ZXIgc3RhdHVzL2RpZmYgaW5mb3JtYXRpb24uIFdoZW4gDQo+IHRoZSBzdWJt
b2R1bGUgaXMgYXQgYSBkaWZmZXJlbnQgdmVyc2lvbiBpdCBhbHdheXMgZ2l2ZXMgbWUgIm5ldyAN
Cj4gY29tbWl0cyIgYnV0IG5ldmVyICJvbGQgY29tbWl0cyIgZXZlbiB0aG91Z2ggSSBoYXZlIGNo
ZWNrZWQgb3V0IGFuIA0KPiBvbGRlciB2ZXJzaW9uIGluc2lkZSB0aGUgc3VibW9kdWxlLiBnaXQg
ZGlmZiBnaXZlcyBtZSB0d28gZGlmZmVyZW50IA0KPiBoYXNoZXMgd2hpY2ggYWxzbyBkb24ndCBn
aXZlIGFueSBkaXJlY3RseSByZWFkYWJsZSBpbmZvcm1hdGlvbi4gwqBHaXQgDQo+IGNvdWxkIGNo
ZWNrIHRoZSBhbmNlc3RyeSBncmFwaCB0byBmaWd1cmUgdGhlIHJlbGF0aW9uIG9mIHRoZSB0d28N
Cj4gY29tbWl0czogY2hpbGQvcGFyZW50LCBwYXJlbnQvY2hpbGQsIGNvbW1vbiBhbmNlc3Rvciwg
ZXRjLg0KPiBPciBpcyB0aGVyZSBhIGZlYXR1cmUgLyBjb21tYW5kIGxpbmUgc3dpdGNoIG9mIGdp
dCB3aGljaCBJIGFtIG1pc3Npbmc/DQoNCllvdSBtYXkgYmUgaW50ZXJlc3RlZCBpbiB0aGUgc3Rh
dHVzLnN1Ym1vZHVsZVN1bW1hcnkgb3B0aW9uLCB3aGljaCBpZiBlbmFibGVkIHdpbGwgc2hvdyBh
IHN1bW1hcnkgb2Ygd2hhdCdzIGNoYW5nZWQgaW4gdGhlIHN1Ym1vZHVsZS4gIElmIHlvdSBkb24n
dCB3YW50IHRvIHNldCB0aGF0IHNldHRpbmcsIHRoZSBjb21tYW5kICJnaXQgc3VibW9kdWxlIHN1
bW1hcnkiIGNhbiBhbHNvIGJlIHVzZWQuDQoNCkZvciBnaXQgZGlmZiwgdGhlcmUncyB0aGUgLS1z
dWJtb2R1bGUgb3B0aW9uLCB3aGljaCBjYW4gYmUgdXNlZCB0byBjb250cm9sIHdoYXQgaW5mb3Jt
YXRpb24gaXMgc2hvd24gaW4gdGhlIGRpZmYsIGFuZCB0aGUgZGlmZi5zdWJtb2R1bGUgb3B0aW9u
IGNvbnRyb2xzIHRoZSBkZWZhdWx0Lg0KDQpBcyBmb3IganVzdCBrbm93aW5nIHdoZXRoZXIgdGhl
IHJldmlzaW9uIGNoZWNrZWQgb3V0IGlzIGFoZWFkIG9yIGJlaGluZCB0aGUgY29tbWl0dGVkIHJl
dmlzaW9uLCBJIGRvbid0IHRoaW5rIHRoZXJlJ3MgYW4gb3B0aW9uIGZvciB0aGF0LiAgTW9zdCBu
b3RhYmx5LCBpdCBuZWVkIG5vdCBiZSBlaXRoZXI6IHRoZSB0d28gY29tbWl0cyBjb3VsZCBiZSBv
biB0d28gZGlmZmVyZW50IGJyYW5jaGVzIHdpdGggc29tZSBzaGFyZWQgaGlzdG9yeSBvciBldmVu
IG9uIHR3byBjb21taXRzIHRoYXQgZG9uJ3Qgc2hhcmUgYW55IGhpc3RvcnkgYXQgYWxsLiAgU28g
dGhlcmUncyBub3QgbmVjZXNzYXJpbHkgYW55IGFuc3dlciB0aGF0J3MgY29ycmVjdCB0aGVyZSBh
dCBhbGwuDQoNCllvdSBjb3VsZCBzY3JpcHQgc29tZSBvZiB0aGlzIHdpdGggYW4gYWxpYXMgb3Ig
c2NyaXB0IGJ5IGRvaW5nIHNvbWV0aGluZyBsaWtlIHRoaXM6DQoNCiAgIyEvYmluL3NoIC1lDQoN
CiAgIyBvbGQgdmFsdWUNCiAgQT0kKGdpdCByZXYtcGFyc2UgLS12ZXJpZnkgJDEpDQogICMgbmV3
IHZhbHVlDQogIEI9JChnaXQgcmV2LXBhcnNlIC0tdmVyaWZ5ICQyKQ0KICBNQj0kKGdpdCBtZXJn
ZS1iYXNlICRBICRCIHx8IHRydWUpDQoNCiAgaWYgWyAteiAiJE1CIiBdDQogIHRoZW4NCiAgICBl
Y2hvICJObyBjb21tb24gYW5jZXN0b3JzIg0KICBlbGlmIFsgIiRBIiA9ICIkTUIiIF0NCiAgdGhl
bg0KICAgIGVjaG8gIk5ldyBjb21taXRzIg0KICBlbGlmIFsgIiRCIiA9ICIkTUIiIF0NCiAgdGhl
bg0KICAgIGVjaG8gIk9sZCBjb21taXRzIg0KICBlbHNlDQogICAgZWNobyAiQ29tbW9uIGFuY2Vz
dG9yIg0KICBmaQ0KLS0NCmJyaWFuIG0uIGNhcmxzb246IEhvdXN0b24sIFRleGFzLCBVUw0K
