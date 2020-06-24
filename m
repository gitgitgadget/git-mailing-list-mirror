Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B06C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 16:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0797F20738
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 16:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=aero.org header.i=@aero.org header.b="GA5FXgSe";
	dkim=pass (1024-bit key) header.d=aerospacecloud.onmicrosoft.com header.i=@aerospacecloud.onmicrosoft.com header.b="qdSncdV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404681AbgFXQNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:13:10 -0400
Received: from email3-east.aero.org ([130.221.184.167]:37166 "EHLO
        email3-east.aero.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404235AbgFXQNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 12:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aero.org; i=@aero.org; q=dns/txt; s=mailhub;
  t=1593015187; x=1624551187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gXRD39vpKP9394CbxaQVlOo3ScpB7XPWb/QeYYxgC/Y=;
  b=GA5FXgSesWhvfuW1ANCtIt8Rp3H0yy3EWIx3E3AQDkWFBPhabyyMFrrA
   8ox5qo+rSDzhJpXkHfmquWiq/jK+niggbaZ/HunVRcIZS+u+T/aT0om8q
   IDEMKnghEbwTJDZBppIClKteF1ZvOld2WCAng2/sIGbsdJibDEy+ja0rD
   U=;
x-SBRS: 3.5
x-SenderGroup: Inbound_Office365
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="3101083"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="3101083"
IronPort-PHdr: =?us-ascii?q?9a23=3AvKe49BQI60CAoE8Ogy6ez28Av9psv++ubAcI9p?=
 =?us-ascii?q?oqja5Pea2//pPkeVbS/uhpkESQBNyJ8/5FjeGQrruzEWAD4JPUtncEfdQMUh?=
 =?us-ascii?q?IekswZkkQmB9LNEkz0KvPmLklYVMRPXVNo5Te3ZE5SHsutf1HTpHb08CVBUh?=
 =?us-ascii?q?n6PBB+c+LyHIOahs+r1ue0rpvUZQgAhDe0bb5oahusqgCEv8QMhs1lMKlixw?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2FFAQD/evNeh2lBL2hmHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UqBUlGCKQqEGoNGA4U4iAybKQNVCwEBAQEBAQEBAQYCLQIEAQECgVGCdAIXg?=
 =?us-ascii?q?gAlOBMCAw0BAQEFAQEBAQEGAwECAhABAQEIDQkIKYViDINVfgEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCgQw9AQEBAQMSEREMAQE3A?=
 =?us-ascii?q?QsEAgEIDgMDAQEBAwImAgICMBUICAEBBA4FCBqDBIJMAy4BrBkCgTmIYAEBd?=
 =?us-ascii?q?YEygwEBAQWFLBhXgTcJgQ4qgmeCTBA2hnqBTD+BVIIYNT6EPxWCfTOCLY8MN?=
 =?us-ascii?q?Q2CIUKHC5sHKAeCXYEHBAuFZ5JSnwOraIQcAgQCBAUCDgEBBYFqgXkzGjCDL?=
 =?us-ascii?q?FAXAg1WjUgag1eKVkMxNAMCBggBAQMJfI8+AYEQAQE?=
Received: from mail-dm3gcc02lp2105.outbound.protection.outlook.com (HELO GCC02-DM3-obe.outbound.protection.outlook.com) ([104.47.65.105])
  by email3-east.aero.org with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 09:13:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0bjtNDuroAB/9tslT7c5frgysgVLBSgGdxvjBXepJ+IltYJKC3BtiiU1cWa8SVDmu7uFDsCQ5/tPdf3Iivg7KDGNtIcM3i0ZQVIQgVgG5mTw+38rEVP7msBNXuSmfJw0ghZKwDWdW/HSdbz71DNm4zGa+K41LIDtCOlVmFPSTgKQtqIvJutQPv+LL5caIkeLn1HHpyqDEzX0tuOwqxHYacypRkeX6qqeAcC0cBhYKMivZOtvNmNhTdNbuRPRQsELlrtw0pGw1Byg5Xr/VjmH/og0uUcQyqFYjIOBBOAyk5h9sw/No7yxsFkWYGkRe6twMGgDyrYlj1/yU3Ds4ih1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXRD39vpKP9394CbxaQVlOo3ScpB7XPWb/QeYYxgC/Y=;
 b=ntykx/yxoPluS+WmoObIb2LmaywbjUgf7hD5CDuFBVjOfNRVlwL0DiKPhuet/wJbYh051rIMcJQ96ErU9E8YJVNJ6w5fHt2VBAuEZdJC5+2a9zZzT1r5ardAtwg50260cw0lV18u81FxmiedIxGNHLEP3lrf49MgIE6zR9s6VmqEGiqOWc6xJ8uAE+THAScXufuI+2X/vIDV6m2Xhpx/vCG4y2d/saX5F6UFXgGZQEPFe2MG0VR8/Ev8GCwJSiMJjTcwO9/lNZ0eBwRKEBvkuVSZbhS62DOK46N0UWcTMvl/e6VggwsVEPq63IX46E4n9NTcu4IcLbsn3y6qz92CnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aero.org; dmarc=pass action=none header.from=aero.org;
 dkim=pass header.d=aero.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aerospacecloud.onmicrosoft.com; s=selector2-aerospacecloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXRD39vpKP9394CbxaQVlOo3ScpB7XPWb/QeYYxgC/Y=;
 b=qdSncdV6pYFnWkM55AaCd/K65BouOJPlqsnylRPcqEf5nz9yW2O8v85bhsmzkjlpZw5L1FRmSafeTGyxD2ZrBzAm33MAdFHJ3NcHygBPxWNagy9WWGiVUxh53ufT2dEvxYTGgL4aVbM3+NzxL7RPOdAeNpS6R/5jnIIoa10lYe4=
Received: from BY5PR09MB4504.namprd09.prod.outlook.com (2603:10b6:a03:1c5::8)
 by BYAPR09MB3415.namprd09.prod.outlook.com (2603:10b6:a03:107::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 24 Jun
 2020 16:13:05 +0000
Received: from BY5PR09MB4504.namprd09.prod.outlook.com
 ([fe80::4c31:8bb7:a776:c4d3]) by BY5PR09MB4504.namprd09.prod.outlook.com
 ([fe80::4c31:8bb7:a776:c4d3%7]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 16:13:05 +0000
From:   Jesse Earles <jesse.earles@aero.org>
To:     Jason Pyeron <jpyeron@pdinc.us>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Are there MPU/SKU's for these products?
Thread-Topic: Are there MPU/SKU's for these products?
Thread-Index: AdZKPhATvPNGMKdcQL2gbx9ha4MxrAAAlIgAAAAwY2AAAB5xgAAALTIA
Date:   Wed, 24 Jun 2020 16:13:05 +0000
Message-ID: <BY5PR09MB4504DF93C414A4E56668BAA6FF950@BY5PR09MB4504.namprd09.prod.outlook.com>
References: <BY5PR09MB4504218AEF2DFD593843A41EFF950@BY5PR09MB4504.namprd09.prod.outlook.com>
 <25d501d64a40$62991410$27cb3c30$@pdinc.us>
 <BY5PR09MB4504AD01DDA757120DCC79ABFF950@BY5PR09MB4504.namprd09.prod.outlook.com>
 <262201d64a41$9e1cb720$da562560$@pdinc.us>
In-Reply-To: <262201d64a41$9e1cb720$da562560$@pdinc.us>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL1RoZUFlcm9zcGFjZUNvcnAiLCJpZCI6ImQ2ZjJmMzgzLTE3MGMtNDM0My1hY2U1LTU3NDhkZWVhMDU1NyIsInByb3BzIjpbeyJuIjoiU2Vuc2l0aXZpdHkiLCJ2YWxzIjpbeyJ2YWx1ZSI6Ik5vbmUifV19LHsibiI6IlJlbGVhc2UiLCJ2YWxzIjpbXX0seyJuIjoiT3B0aW9uYWwiLCJ2YWxzIjpbXX1dfSwiU3ViamVjdExhYmVscyI6W10sIlRNQ1ZlcnNpb24iOiIxNy41LjEyLjEzIiwiVHJ1c3RlZExhYmVsSGFzaCI6InJSNUYxaEFmRm1jbWthQVZxb0tqSzFac1RNQTF0U01hU1RJd3RWVEpMM3BEU25zTmI0dmtcLzJwaHhEVzlMYk9yIn0=
authentication-results: pdinc.us; dkim=none (message not signed)
 header.d=none;pdinc.us; dmarc=none action=none header.from=aero.org;
x-originating-ip: [130.221.145.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1638a89b-90e1-4b1e-4b6c-08d818597a37
x-ms-traffictypediagnostic: BYAPR09MB3415:
x-microsoft-antispam-prvs: <BYAPR09MB3415656C851939E991D7737FFF950@BYAPR09MB3415.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6GzUUgiVEmQhZO7qReZEMImHz9lJxscWZgjoXSNhuKpzOFHiYm7JFyHrRj+wYjQnIaId78Y+BoHJ0TLB5LY5qDZiCJCrZGE7ywhkEHOUNuiXAsyN/uxpfck8Kv/VVmSF5gu6k9HPkdC6CSyfBhdhAZkzqnLmemm3ln319h+HqFeLBkfWtv3011EWHN615rniYjmtzJRh9mGHMdpGIWYP23FI1Taoa0jkOSXHoAMysL+1Itfso6vFKrQ/Hcxvt0InI5aPTI2eWlSuxnCflJDmcWt83uoIV6zI3HE1Y5zStvlMceMBGNk/Pzjf/9KyrDqvPFV2Bx+bSFkWWWzgEOmlvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR09MB4504.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39850400004)(376002)(346002)(366004)(396003)(6916009)(55016002)(8936002)(186003)(8676002)(44832011)(83380400001)(33656002)(9686003)(478600001)(71200400001)(2906002)(5660300002)(86362001)(66446008)(66946007)(64756008)(66476007)(66556008)(316002)(4326008)(76116006)(26005)(52536014)(53546011)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Fi3A6sQgZtqy4PZnx+dP1otG+5MQzXDTV6v5SpzNJuGQ0m5UaCHRUHVY8JcvTyW86DNZYNSWI/bgxSrqnJvhpPEMgWob8UHq//EQYUFS71vEQKIkb723dduzITdDkBT7JBkid5L6838fIEZPsFXtZCuxHl4nIwSG6pBSKts/W1iJGj8jwkI1LFG9xKKXvTcMN1+khVpl3fKW2zh69xmkYB18ik038gxsqmVRes3CnQkTEHh/opw5lzT2I7XQKnPIHViV1qk2m2WWlcSJtp1Xa79lgLd1n9/DEamfWuuFGYPweOPexlrm7ZUafQLVfN3Xll/90rPydDli4BHwWGwduIyrzMZljumRP0D6D2ywB9RzEloS+GvovctBgXr8pfH0KLh2YAWiE29eov9TBeZaoFY68cWSOFoi8t/onvpcYKeybsZnQAb/PqzQEeTYXfyYj8kE+3Y/t0KdmLZjmbvXeKO+jKrpYZ+/rixxwapq812bw/+GYaOzL850ZjYF6Izx
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aero.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 1638a89b-90e1-4b1e-4b6c-08d818597a37
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 16:13:05.2563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c8294700-c5a4-4ca1-a876-1457d39899fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9eX+Mvf1tFpZjqUDMR3qYNOowqJTEAyfppCWhiHER/iloT8xn5KcwiAQtGweEfg8iVaoj+BCyv08fw1h7jiOQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR09MB3415
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VW5kZXJzdG9vZC4gVGhhbmsgeW91LiANCg0KDQoNCg0KSmVzc2UgRWFybGVzDQpEZXNrdG9wIFN1
cHBvcnQgU3BlY2lhbGlzdA0KRUlTL0lUIE9wZXJhdGlvbnMgDQpEaWdpdGFsIEludGVsbGlnZW5j
ZSBTeXN0ZW1zLCBMTEMgKERJU1lTKQ0KVGhlIEFlcm9zcGFjZSBDb3Jwb3JhdGlvbg0KMTQ3NDUg
TGVlIFJkLiBDaGFudGlsbHksIFZBIDIwMTUxDQoNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogSmFzb24gUHllcm9uIDxqcHllcm9uQHBkaW5jLnVzPiANClNlbnQ6IFdlZG5l
c2RheSwgSnVuZSAyNCwgMjAyMCAxMjowOCBQTQ0KVG86IEplc3NlIEVhcmxlcyA8amVzc2UuZWFy
bGVzQGFlcm8ub3JnPg0KQ2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJFOiBBcmUg
dGhlcmUgTVBVL1NLVSdzIGZvciB0aGVzZSBwcm9kdWN0cz8NCg0KVGhhdCBpcyBvdXIgc291cmNl
IGNvZGUgc3RvY2sgdGFnLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEplc3NlIEVhcmxlcyA8amVzc2UuZWFybGVzQGFlcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IEp1bmUgMjQsIDIwMjAgMTI6MDYgUE0NCj4gVG86IEphc29uIFB5ZXJvbiA8anB5ZXJvbkBwZGlu
Yy51cz4NCj4gQ2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUkU6IEFyZSB0aGVy
ZSBNUFUvU0tVJ3MgZm9yIHRoZXNlIHByb2R1Y3RzPw0KPiANCj4gVGhhbmtzLCBidXQgSSB3YXMg
cmVmZXJyaW5nIHRvIGlmIHRoZXJlIHdhcyBhIE1hbnVmYWN0dXJpbmcgUGFydCANCj4gTnVtYmVy
IG9yIGEgU3RvY2sgS2VlcGluZyBVbml0IG51bWJlciBmb3IgdGhpcyBwcm9kdWN0LiBJIGJlbGll
dmUgd2UgDQo+IGFscmVhZHkgaGF2ZSB0aGUgdW5pcXVlIElEIGVudGVyZWQgaW4gYW5vdGhlciBm
aWVsZCwgc28gdGhhdCBwYXJ0IHNob3VsZCBiZSBnb29kLg0KPiANCj4gDQo+IA0KPiANCj4gSmVz
c2UgRWFybGVzDQo+IERlc2t0b3AgU3VwcG9ydCBTcGVjaWFsaXN0DQo+IEVJUy9JVCBPcGVyYXRp
b25zDQo+IERpZ2l0YWwgSW50ZWxsaWdlbmNlIFN5c3RlbXMsIExMQyAoRElTWVMpIFRoZSBBZXJv
c3BhY2UgQ29ycG9yYXRpb24NCj4gMTQ3NDUgTGVlIFJkLiBDaGFudGlsbHksIFZBIDIwMTUxDQo+
IA0KPiANCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphc29uIFB5
ZXJvbiA8anB5ZXJvbkBwZGluYy51cz4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDI0LCAyMDIw
IDExOjU5IEFNDQo+IFRvOiBKZXNzZSBFYXJsZXMgPGplc3NlLmVhcmxlc0BhZXJvLm9yZz4NCj4g
Q2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUkU6IEFyZSB0aGVyZSBNUFUvU0tV
J3MgZm9yIHRoZXNlIHByb2R1Y3RzPw0KPiANCj4gVGhlIHVuaXF1ZSBpZGVudGlmaWVyIGZvciB0
aGF0IHZlcnNpb24gaXM6IA0KPiBlN2UwN2Q1YTRmY2MyYTIwM2Q5ODczOTY4YWQzZTZiZDRkNzQx
OWQ3DQo+IA0KPiBjb21taXQgZTdlMDdkNWE0ZmNjMmEyMDNkOTg3Mzk2OGFkM2U2YmQ0ZDc0MTlk
NyAodGFnOiB2Mi4xMi4wKQ0KPiBBdXRob3I6IEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVyQHBvYm94
LmNvbT4NCj4gRGF0ZTogICBGcmkgRmViIDI0IDEwOjQ5OjU4IDIwMTcgLTA4MDANCj4gDQo+ICAg
ICBHaXQgMi4xMg0KPiANCj4gICAgIFNpZ25lZC1vZmYtYnk6IEp1bmlvIEMgSGFtYW5vIDxnaXRz
dGVyQHBvYm94LmNvbT4NCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gRnJvbTogZ2l0LW93bmVyQHZnZXIua2VybmVsLm9yZyA8Z2l0LW93bmVyQHZnZXIua2VybmVs
Lm9yZz4gT24gDQo+ID4gQmVoYWxmIE9mIEplc3NlIEVhcmxlcw0KPiA+IFNlbnQ6IFdlZG5lc2Rh
eSwgSnVuZSAyNCwgMjAyMCAxMTo0MyBBTQ0KPiA+IFRvOiBnaXRAdmdlci5rZXJuZWwub3JnDQo+
ID4gU3ViamVjdDogQXJlIHRoZXJlIE1QVS9TS1UncyBmb3IgdGhlc2UgcHJvZHVjdHM/DQo+ID4N
Cj4gPiBIZWxsbywNCj4gPg0KPiA+IEkgYW0gd29ya2luZyB3aXRoIG15IHNvZnR3YXJlIHRlYW0g
b24gdXBkYXRpbmcgdGhlaXIgaW50ZXJuYWwgDQo+ID4gY2F0YWxvZyB3aXRoIGN1cnJlbnQgYW5k
IGFjY3VyYXRlIGluZm8gYW5kIGFtIG5lZWRpbmcgdG8gZmluZCB0aGUgDQo+ID4gTVBOL1NLVSBm
b3IgIlNvZnR3YXJlIEZyZWVkb20gQ29uc2VydmFuY3kgfCBHaXQgfCB2Mi4xMi4wIi4gSSdtIG5v
dCANCj4gPiBjZXJ0YWluIGlmIHRoZXJlIGV2ZW4gaXMgb25lIGFzIEkgYXNzdW1lIHRoaXMgaXMg
b3Blbi1zb3VyY2VkLCBidXQgSSANCj4gPiBmaWd1cmVkIEknZCByZWFjaCBvdXQgdG8gZ2V0IGNv
bmZpcm1hdGlvbg0KPiBiZWZvcmUgSSBtYWtlIGFuIGludGVybmFsIFNLVSBmb3Igb3VyIHJlY29y
ZHMuIFRoYW5rcy4NCj4gPg0KPiA+DQo+ID4gSmVzc2UgRWFybGVzDQo+ID4gRGVza3RvcCBTdXBw
b3J0IFNwZWNpYWxpc3QNCj4gPiBFSVMvSVQgT3BlcmF0aW9ucw0KPiA+IERpZ2l0YWwgSW50ZWxs
aWdlbmNlIFN5c3RlbXMsIExMQyAoRElTWVMpIFRoZSBBZXJvc3BhY2UgQ29ycG9yYXRpb24NCj4g
PiAxNDc0NSBMZWUgUmQuIENoYW50aWxseSwgVkEgMjAxNTENCj4gPg0KPiA+DQo+ID4NCj4gDQo+
IA0KDQoNCg==
