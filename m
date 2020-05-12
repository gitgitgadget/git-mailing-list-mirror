Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACAAC54E4A
	for <git@archiver.kernel.org>; Tue, 12 May 2020 14:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC97220736
	for <git@archiver.kernel.org>; Tue, 12 May 2020 14:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atos.net header.i=@atos.net header.b="FRnfvu2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbgELO2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 10:28:55 -0400
Received: from smtppost.atos.net ([193.56.114.176]:23210 "EHLO
        smarthost3.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725929AbgELO2y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 10:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1589293733; x=1620829733;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=veePRBCGxA6mJw+/dygd/+wFd80Wz2PgD2CjTeqVCiM=;
  b=FRnfvu2MopH3k7Ui8ifZFct9jbLX8nYZpJFUf4H7AaFtVUbwGyjCiBrq
   T/JJCCaRguZ1nJd5GlC+7y8CbRDssswh5QDP+6ttPBk+IauCkJ9WIOju6
   5vQIml562v8xFWTgwM/1t+Pzk2+3ltLWduq5yywhIVoMI4IDsFnCeVd09
   w=;
IronPort-SDR: taH5mEdDK6nAgFiQ9GsdlerMVNSWu4Ty0caJSVs0RiWhP4xvc2wrzbMsD+t316AmYQNM+L1rUm
 nujhdgtFVR8YWTTIoO5InGfVrYOUVe2FicC7qsMXWtNeTI+2fRHdpWl8CHQYlLntbZPdgkROi1
 AMhWLLP+DBSIGvRrOZCExvmUQ1/16F8f+bhY0qCl/6KDa+06C1IVR+S9nvGpBqHZWAgLdgVjXy
 GJme6YqR4rkpiOmLG+hp4pgLm8MKZfb/QWN/ci6qhZu00nymojLug0bU7e6UA+QOUybJhTwdT8
 xK3+1JQnYFALcCwGovbIo01p
X-IronPort-AV: E=Sophos;i="5.73,384,1583190000"; 
   d="scan'208";a="53535284"
X-MGA-submission: =?us-ascii?q?MDESRnKPP52CzoSrTWEkzQd9zBN2mHF3bxNoKo?=
 =?us-ascii?q?vpcQz3Wv9plT0bZ0L0N5QB3riN6wSUMxpglK9L+2XNcW3S3JqRfASHFU?=
 =?us-ascii?q?ksD9+C1GTbygIwuZRU8UAAMh9xMTl/LfMxDh8PuxtZDeouoYfBrUROu0?=
 =?us-ascii?q?TC?=
Received: from unknown (HELO DEERLM99ETXMSX.ww931.my-it-solutions.net) ([10.86.142.46])
  by smarthost3.atos.net with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 12 May 2020 16:27:55 +0200
Received: from DEFTHW99ETTMSX.ww931.my-it-solutions.net (10.86.142.101) by
 DEERLM99ETXMSX.ww931.my-it-solutions.net (10.86.142.46) with Microsoft SMTP
 Server (TLS) id 14.3.487.0; Tue, 12 May 2020 16:27:25 +0200
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.101) with Microsoft SMTP
 Server (TLS) id 14.3.487.0; Tue, 12 May 2020 16:27:24 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=davOA8b8j9XDdaf+7835EhP1UoZsCb2Uft8YFW2A76bPJTjvKzodplPHMnP8zRLR5gt/v1xO2gdxhsczjXzXCuZdom41/jJ/SeVsnKC8kyQJlDKqWqwxht+E+8p/V5ZBCVdrijy+8VZMon9m5e5nrqhqJh63vDcOFkdy0a9Cb0w31g4vHV7Ww+EWQo8JwU+FxjAzvkr9dNIHu/t+jM4BWNBo3dJxDki3tOvIecDaq9cHMYZdwT+Ax9KyS1I3sK5VYD8eygbCUS9LeqygHAcBuyIO+a1ej+xQ+yL5dhaqbx7rfD1v5HcoV0/cbnjVi0+7XqQghfXEofLODsnR4OsKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veePRBCGxA6mJw+/dygd/+wFd80Wz2PgD2CjTeqVCiM=;
 b=acgYxzt5LgbrJJfdzUR/aodMc3Ci+Omla/1lwwX4aC3HN5Y5c6VXj6aIwf3Q7n0LX7pV+xKCj2Yyuhzoj9g5FdZrDlXce2dVRZ7o8xmNSLPkPS4P1cjmbyAGG7PDpLBAKZ6ikS60fB4Tyg5tuHiQr7uAiO4TYKyaxc2qIH+wTikFOvO+qNb34B3MyTYcwzkqyndWAWHFF0lF75rCv0CuUITURGrjzIyO39z2iiQ8ei59gt+iDAGGSrvHKqFeSE/qaorWnfi+c8GgBTdrMKh3z1SBK6hB6fiCFXA5+Q5vhB227cQvLLTYPkZak7QSNH09bzYHOux094DwgS8p25Lxhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM0PR02MB3715.eurprd02.prod.outlook.com (2603:10a6:208:42::13)
 by AM0PR02MB4179.eurprd02.prod.outlook.com (2603:10a6:208:d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Tue, 12 May
 2020 14:27:23 +0000
Received: from AM0PR02MB3715.eurprd02.prod.outlook.com
 ([fe80::b4c8:6064:534d:3eb8]) by AM0PR02MB3715.eurprd02.prod.outlook.com
 ([fe80::b4c8:6064:534d:3eb8%4]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 14:27:22 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Pratyush Yadav <me@yadavpratyush.com>,
        "J. Paul Reed" <preed@sigkill.com>
Subject: RE: git-gui patch staging errors
Thread-Topic: git-gui patch staging errors
Thread-Index: AQHWJ/nddaIKi/rFAUemQgp9BDo8n6ikXgOAgAAd/WA=
Date:   Tue, 12 May 2020 14:27:22 +0000
Message-ID: <AM0PR02MB371505CA3EE36FBDB44B3A409CBE0@AM0PR02MB3715.eurprd02.prod.outlook.com>
References: <20200512010750.GA7127@sigkill.com>
 <20200512121511.dyyd6n5gdfbesy2j@yadavpratyush.com>
In-Reply-To: <20200512121511.dyyd6n5gdfbesy2j@yadavpratyush.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Enabled=True;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Owner=richard.kerry@atos.net;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_SetDate=2020-05-12T14:27:21.4571720Z;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Name=Atos For Internal Use;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_ActionId=ef9aadd1-916f-4f3f-a076-e48a5c4da205;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Extended_MSFT_Method=Automatic;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=True;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Owner=richard.kerry@atos.net;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2020-05-12T14:27:21.4571720Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=Atos For Internal Use -
 All Employees;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=ef9aadd1-916f-4f3f-a076-e48a5c4da205;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Parent=112e00b9-34e2-4b26-a577-af1fd0f9f7ee;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Extended_MSFT_Method=Automatic
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=atos.net;
x-originating-ip: [212.56.108.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 354e510c-4c12-4282-66a3-08d7f680960b
x-ms-traffictypediagnostic: AM0PR02MB4179:
x-microsoft-antispam-prvs: <AM0PR02MB4179DCF822A3C04E04099F3E9CBE0@AM0PR02MB4179.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g3fOruExbQnivGYHKOCGTmoNAbJKCxBwYC3v6kndfPJ79k5cmSfUfBs9+9gnEcrmN8ONEVvpTp7ifn7m7l0j9TVWFajC34o35B1qfBkhj8qbVUcf6RODMkEcmiawybnLH3+UlKOJJkqXGgPe2mm0oC6yBmuGT2cvhyKPQ5SqRNeIuMYaGWTp5+9lc8zrapzleIFdJL6AyGLYBhlQ1bYW2dc3eDfJ8dYFYe5J9pFr/MNSl2iwva0gVMr0SEOBA/k28KggDRH9mPhKTQ4sB9Q+lwn0Mcd97tFaqBjMfz3PZw/xAgxUHKxBrfAd+RDKlS1tArOoZtwqREJkzo/VAIMpJAttNIWtpRQ+fuOErhLXeQlOlSF/ASK6Zna0inr5N+nN2Rs/RLHCnYuUqoge0iY8HJbXlUtvHAZcdVZTGjMTRzWL1+zVgrhdhHcZF/bsHFfFIl63vkBi6dH/qAri1xtqOba5NXwzoK698YbHgmgYVtCYC19pdnwWHQHAwm/Xco1QQjVPtvn3feG88lTJ1MySEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB3715.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(33430700001)(86362001)(8676002)(64756008)(66556008)(6916009)(66446008)(3480700007)(26005)(71200400001)(76116006)(8936002)(5660300002)(186003)(6506007)(7696005)(53546011)(2906002)(33656002)(66476007)(54906003)(55016002)(316002)(45080400002)(52536014)(33440700001)(9686003)(4326008)(478600001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: YWYD9NMRtBOD0LyGDE/8PvwwLfrfMXOu0ZFxyV+azgJ+ipoDQh7ozlVTC8bvjE4ljc+z9ZIlwrkQ9nhVl+7xRj9Pn4qtGtwZn3moCSSUSdxawajSKUi8BLuQeC68JxvIsKyoIOh9vBsOaA+32vFuSK8WehGgBqkVtbzD9sjBwvPRciDOulRE3E2h7UWsHQikfzpGasmGRo/m0zz//IDl24/7sgfwnqKU9FbTELGpAgzwumHZje+edMCxRT9OmoEULrhHyKpxsbfIi9B52GpC2mJ9/0skQFwEf8iKGl2gwUHQzYxSYAp+8TuDfzLVGmjQr36h7UwneCLh6qdrNq3dUIw6YXj0RbPhn3snk88PhJh/biJYVxb8FsZ7eRib5VqJ6oT8m3jF0ftNuL5OyMtvmWsFKoBt8TBT5YaYftlEGtN6P/hXhhbtZmGr3bhTVi1V45RsrGNV6qkl8GnlQMqKy9aqFl01koad0zmbQsqYoKKdnlMgr7B5qR9W4TClib7P
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 354e510c-4c12-4282-66a3-08d7f680960b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 14:27:22.8261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eTb85sgI85bxA1vzoL7bcj2cCo2qb7Q4HPh5U4+1IC0ytPKsPcfQ8W0jBLCVLzClpq1/f/dJQktuM8/3h5IX5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4179
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogZ2l0LW93bmVyQHZnZXIua2VybmVs
Lm9yZyA8Z2l0LW93bmVyQHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIFByYXR5dXNoIFlh
ZGF2DQpTZW50OiAxMiBNYXkgMjAyMCAxMzoxNQ0KVG86IEouIFBhdWwgUmVlZCA8cHJlZWRAc2ln
a2lsbC5jb20+DQpDYzogZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IGdpdC1ndWkg
cGF0Y2ggc3RhZ2luZyBlcnJvcnMNCg0KSGksDQoNCk9uIDExLzA1LzIwIDA2OjA3UE0sIEouIFBh
dWwgUmVlZCB3cm90ZToNCj4gDQo+IEhleSBhbGwsDQo+IA0KPiBJIHJhbiBpbnRvIGFuIGludGVy
ZXN0aW5nIHByb2JsZW0gdGhpcyB3ZWVrIHdoZXJlIGdpdCBndWkgd2FzIGVycm9yaW5nIA0KPiBv
dXQgb24gc3RhZ2luZyBwYXJ0aWFsIHBhdGNoZXMgaW4gYSBwYXJ0aWN1bGFyIGZpbGUgSSB3YXMg
d29ya2luZyBvbi4NCj4gDQo+IEkgd29ya2VkIGFyb3VuZCBpdCB3aXRoICJnaXQgYWRkIC1pLCIg
d2hpY2ggd29ya2VkIGxpa2UgYSBjaGFtcC4NCj4gDQo+IEkgbGF0ZXIgcmVhbGl6ZWQgdGhlIHNv
dXJjZSBmaWxlIGhhcyBzb21lIHNwZWNpYWwgY2hhcmFjdGVycyAoVW5pY29kZSwNCj4gcHJvYmFi
bHkpIGluIGl0IHRvIHByaW50IGVtb2ppcyAob3IgY29sb3JzIG9yIHdoYXRldmVyIGZ1biBhbmlt
YXRpb25zIA0KPiB0aGUga2lkcyB3YW50IG9uIHRoZWlyIHRlcm1pbmFscyB0aGVzZSBkYXlzKS4N
Cj4gDQo+IEludGVyZXN0aW5nbHksIGxpbmVzL2h1bmtzIGJlZm9yZSB0aGUgZmlyc3QgVW5pY29k
ZSBjaGFyYWN0ZXIgd2lsbCANCj4gcGFydGlhbC1zdGFnZSBhcHByb3ByaWF0ZWx5LCBidXQgYXR0
ZW1wdGluZyB0byBzdGFnZSBhbnkgaHVua3MvbGluZXMgDQo+IGFmdGVyIHRoZSBjaGFyYWN0ZXJz
IHByb2R1Y2VzIGEgIkZhaWxlZCB0byBzdGFnZSBzZWxlY3RlZCBsaW5lLiBlcnJvcjogDQo+IHBh
dGNoIGZhaWxlZCAuLi4gZXJyb3I6IC4uLiBwYXRjaCBkb2VzIG5vdCBhcHBseSIgZXJyb3IgZGlh
bG9nLg0KPiANCj4gVGhpcyBjYW4gYmUgcmVwcm9kdWNlZCBieSBjbG9uaW5nDQpJIGNhbid0IHJl
cHJvZHVjZSBpdC4gSSBjbG9uZWQgdGhlIHJlcG8gYW5kIHRoZW4gZWRpdGVkIHRoZSBmaWxlIGF0
IGxpbmUNCjYwIHdpdGggYSBkaWZmIHRoYXQgbG9va3Mgc29tZXRoaW5nIGxpa2U6DQoNCiAgZGlm
ZiAtLWdpdCBhL2dsYWNpZXJ1cGxvYWQuc2ggYi9nbGFjaWVydXBsb2FkLnNoDQogIGluZGV4IDNi
OTU2YzcuLjI2NTM0OWIgMTAwNzU1DQogIC0tLSBhL2dsYWNpZXJ1cGxvYWQuc2gNCiAgKysrIGIv
Z2xhY2llcnVwbG9hZC5zaA0KICBAQCAtNTcsNyArNTcsOSBAQCBmaQ0KICAgDQogICAjIGNvdW50
IHRoZSBudW1iZXIgb2YgZmlsZXMgdGhhdCBiZWdpbiB3aXRoICIkcHJlZml4Ig0KICAgZmlsZUNv
dW50PSQobHMgLTEgfCBncmVwICJeJHByZWZpeCIgfCB3YyAtbCkNCiAgLWVjaG8gIvCfk6YgR2xh
Y2llciBVcGxvYWQgd2l0aCAkQVdTX1BST0ZJTEUiDQogICtiYXINCiAgK2VjaG8gIvCfk6YgR2xh
Y2llciBzIFVwbG9hZCB3aXRoICRBV1NfUFJPRklMRSINCiAgK2Zvbw0KICAgZWNobyAiVG90YWwg
cGFydHMgdG8gdXBsb2FkOiAiICRmaWxlQ291bnQNCiAgIA0KICAgIyBnZXQgdGhlIGxpc3Qgb2Yg
cGFydCBmaWxlcyB0byB1cGxvYWQuICBFZGl0IHRoaXMgaWYgeW91IGNob3NlIGEgZGlmZmVyZW50
IHByZWZpeCBpbiB0aGUgc3BsaXQgY29tbWFuZA0KDQpJIHRyaWVkIGEgYnVuY2ggb2YgY29tYmlu
YXRpb25zIGlmIHBhcnRpYWxseSBzdGFnaW5nIHBhcnRzIG9mIHRoaXMgZGlmZiwgYnV0IGV2ZXJ5
dGhpbmcgd29ya2VkIGZpbmUgd2l0aG91dCBhbnkgZXJyb3IgbWVzc2FnZS4gVGhlIGVtb2ppIGRp
ZG4ndCByZW5kZXIgcHJvcGVybHkgKHRob3VnaCB0aGF0IG1pZ2h0IGJlIG15IGZvbnQncyBwcm9i
bGVtKSwgYnV0IHRoZXJlIHdlcmUgbm8gcHJvYmxlbXMgaW4gcGFydGlhbCBzdGFnaW5nIG9yIHVu
c3RhZ2luZy4NCg0KRG9lcyB0aGlzIGV4YW1wbGUgd29yayBmaW5lIG9uIHlvdXIgc3lzdGVtIG9y
IGRvZXMgaXQgZXJyb3Igb3V0PyBDb3VsZCB5b3UgZ2l2ZSBhbiBleGFtcGxlIGRpZmYgd2hlcmUg
Z2l0LWd1aSBoYXMgcHJvYmxlbXMgd2hpbGUgc3RhZ2luZz8gTWF5YmUgc29tZXRoaW5nIGluIHlv
dXIgY29uZmlnIGlzIGRpZmZlcmVudD8NCiANCj4gUmVtb3ZpbmcgdGhlc2UgY29udHJvbCBjaGFy
YWN0ZXJzIHNlZW1zIHRvIGNhbG0gZ2l0IGd1aSdzIGluZGlnZXN0aW9uIA0KPiBvbiB0aGlzIGZp
bGUuDQo+IA0KPiBbcHJlZWRAdW5kZXJ3b3JsZCB+XSQgZ2l0IC0tdmVyc2lvbg0KPiBnaXQgdmVy
c2lvbiAyLjI2LjINCj4gW3ByZWVkQHVuZGVyd29ybGQgfl0kIGdpdCBndWkgLS12ZXJzaW9uIGdp
dC1ndWkgdmVyc2lvbiANCj4gMC4yMS4wLjY2LmdhNTcyOA0KPiANCj4gYmVzdCwNCj4gcHJlZWQN
Cg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KSSd2ZSByZWNlbnRseSBmb3VuZCAgc29tZXRo
aW5nIHZlcnkgc2ltaWxhciB0byB0aGlzIHVzaW5nIHRoZSBGb3JrIEd1aS4gIEkgYW0gdGVtcHRl
ZCB0byByZXBvcnQgaXQgdG8gdGhhdCBwcm9qZWN0LCBidXQgb24gc2VlaW5nIHNvbWV0aGluZyBz
aW1pbGFyIGhlcmUgcGVyaGFwcyBib3RoIEZvcmsgYW5kIEd1dC1HdWkgaGF2ZSBhIHNpbWlsYXIg
aXNzdWUgcmVsYXRpbmcgdG8gR3VpIGFwcGxpY2F0aW9ucyBmb3IgR2l0Pw0KSWYgdGhlIGNodW5r
IEkgd2FudCB0byBzdGFnZSBpbmNsdWRlcyBjaGFyYWN0ZXJzICBpbiBzb21lIGNhdGVnb3J5IFsx
XSwgdGhlbiBhbiBhdHRlbXB0IHRvIFN0YWdlIHRoYXQgY2h1bmsgd2lsbCBmYWlsIHdpdGggYSBz
aW1pbGFyIGZhdWx0IHRvIHdoYXQgaXMgZGVzY3JpYmVkIGhlcmUuICAoSSBkb24ndCBoYXZlIG9u
ZSBhdmFpbGFibGUgdG8gbWUgYXQgdGhlIG1vbWVudCB0byBjaGVjayB3aGV0aGVyIGl0IGlzIGV4
YWN0bHkgdGhpcyBmYWlsdXJlKQ0KSSBoYXZlIHJlY2VudGx5IGZvdW5kIG15c2VsZiBjdXR0aW5n
IGFuZCBwYXN0aW5nIHNvbWUgY2h1bmtzIG9mIHRleHQgZnJvbSBhIFBERiBpbnRvIG15IEMrKyBz
b3VyY2UsIGFuZCBpbiBwYXJ0aWN1bGFyIHRoYXQgaW5jbHVkZXMgImhhbmRlZCIgcXVvdGVzLCBy
YXRoZXIgdGhhbiB0aGUgdXN1YWwgdXNlIG9mIHRoZSB1c3VhbCBzaW5nbGUgcXVvdGUgY2hhcmFj
dGVyIChpZSB0aGUgYXBvc3Ryb3BoZSkuICBJZiBJIHRoZW4gdXNlIEZvcmsncyBhYmlsaXR5IHRv
IFN0YWdlIGNodW5rcyBvZiB0ZXh0IGNvbnRhaW5pbmcgdGhlc2UgKG9yIHBvc3NpYmx5IG5vdCBj
b250YWluaW5nLCBidXQgY2xvc2UgYWZ0ZXIpIEkgZ2V0IHRoaXMgZmFpbHVyZSByZXBvcnRlZC4N
ClRoZSB3b3JrLWFyb3VuZCBpcyB0byBkbyBpdCBmcm9tIHRoZSBjb21tYW5kIGxpbmUgdXNpbmcg
ImdpdCBhZGQgLS1wYXRjaCIsIHdoaWNoIHdvcmtzIGZpbmUuDQoNClJlZ2FyZHMsDQpSaWNoYXJk
Lg0KDQpbMV0gDQpJIGNhbid0IGJlIGVudGlyZWx5IHN1cmUgb2YgdGhlIGNhdGVnb3J5IGFzIEkg
aGF2ZW4ndCBsb29rZWQgZm9yIHRoZSBjb2RlcyB5ZXQsIGJ1dCBpdCBpcyBwcmVzdW1hYmx5IHNv
bWUgZ3JvdXAgb2YgY2hhcmFjdGVycyBvdXRzaWRlIHRoZSBiYXNpYyBBU0NJSSBwYWdlLg0KDQpQ
UyBTb3JyeSBhYm91dCBwb3N0aW5nIHN0eWxlLCBJJ20gdXNpbmcgT3V0bG9vayBhbmQgSSd2ZSB5
ZXQgdG8gZmluZCBhIHdheSBvZiBnZXR0aW5nIGl0IHRvIGhlbHAgb3V0IGJ5IGluZGVudGluZyBl
dmVyeXRoaW5nIHVzaW5nICI+Ii4NCg0KDQo=
