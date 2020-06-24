Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5140C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 16:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA08F206F7
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 16:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=aero.org header.i=@aero.org header.b="F3U+PvUU";
	dkim=pass (1024-bit key) header.d=aerospacecloud.onmicrosoft.com header.i=@aerospacecloud.onmicrosoft.com header.b="cVm6ZOck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404608AbgFXQFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:05:54 -0400
Received: from email6-west.aero.org ([130.221.16.31]:36977 "EHLO
        email6-west.aero.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404525AbgFXQFy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 12:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aero.org; i=@aero.org; q=dns/txt; s=mailhub;
  t=1593014752; x=1624550752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2mWCt+jG9e4Ua92xql0ybbIT1nthmw5Lq7TeC2O142I=;
  b=F3U+PvUUpiAxn1xE1mVzH6alfxLmPTThrA1CkXpJprhiXvHaygYUWv9Z
   cB4EJPe/GLQbDdh2+GkUccPJpU2Fb7ukf2Dc7fc6T8PCjxLzBVOOjCCyr
   Wo3ywUa+TOJVflT+DTuERudzlRRYGt231MBz+uGsXKlAsh4YcxOcYqYo6
   Y=;
x-SBRS: 3.5
x-SenderGroup: Inbound_Office365
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="7496415"
X-IronPort-AV: E=Sophos;i="5.75,275,1589266800"; 
   d="scan'208";a="7496415"
IronPort-PHdr: =?us-ascii?q?9a23=3AAtYX1BHvZXtsDp78jMtFDp1GYnJ96bzpIg4Y7I?=
 =?us-ascii?q?YmgLtSc6Oluo7vJ1Hb+e401QabRYna7fkClvGF+6zjWGlV55GHvThCdZFXTB?=
 =?us-ascii?q?YKhI0QmBBoG8+KD0D3bZuIJyw3FchPThlpqne8N0UGAMr/YVaUv2bhpTIXEw?=
 =?us-ascii?q?/0YAxyIOm9E4XOjsOxgua1/ZCbYwhBiDenJ71oKxDjpAjLsY8Rm4QxJw=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2FFAQCJefNeh2tBL2hmHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UqBUlGCKQqEGoNGA4U4iA2bKQNVCwEBAQEBAQEBAQYCLQIEAQECgVGCdAIXg?=
 =?us-ascii?q?gAlOBMCAw0BAQEFAQEBAQEGAwECAhABAQEIDQkIKYViDINVfgEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCgQw9AQEBAQMSEREMAQE3A?=
 =?us-ascii?q?QsEAgEIDgMDAQEBAwImAgICMBUICAEBBA4FCBqDBIJMAy4BrCECgTmIYAEBd?=
 =?us-ascii?q?YEygwEBAQWFLBhXgTcJgQ4qgmeCTBA2hnqBTD+BVIIYNT6EPxWCfTOCLY8MN?=
 =?us-ascii?q?Q2CIUKHC5sHKAeCXYEHBAuFZ5JSnwOraIQcAgQCBAUCDgEBBYFqgXkzGjCDL?=
 =?us-ascii?q?FAXAg1WjUgag1eKVkMxNAMCBggBAQMJfI8+AYEQAQE?=
Received: from mail-dm3gcc02lp2107.outbound.protection.outlook.com (HELO GCC02-DM3-obe.outbound.protection.outlook.com) ([104.47.65.107])
  by email6-west.aero.org with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 09:05:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRF6ZxCjkKrGYRwrQk6/lUkskQqT2IzIKpJ2X7kTeLUG9Pl3EOCiJt9WbUlRgEXkxzHwyscSUwUg26GcpV66O3d/lxuW0pA8XvbxT8bVH1oZRqsQfI/i9FyPNfVubFZZ9mbvpH0D+CfNPFyk+occuVMba3eyzga7UsSNXWsUwQugXiubgiZS+R3Nw8tsdXIJU7CN9GTiCh665w0+N7QlRfFSF11zF7hwLBRfhVfIGs0SI5nLFBsnhvOIhlGknRuZUOedqANTg3fchT+AJ2Pz88PtvWQEzAEHPtDzH/cXIcIxiWAUZfXl9aoEie/ozocSpclqjnuD+RvwjcDtcw8qWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mWCt+jG9e4Ua92xql0ybbIT1nthmw5Lq7TeC2O142I=;
 b=R5h/nGjnoewwIl9Yl8k2f9NPID2gl6rEN7PRnm2r45DCSTFcfSOEJuaxrJn/mkaW0UsIE/DochzB3MpUJF8t5i5VnSGDvWBZxQgMyBzdXoRmua/7WzcvQl2LutfYKh/C5lX2mRNrkKuRCiSkfkop5iA6mrUpaIoY/BIoOHyGzCUq/cxQ2mZlIKNuiDhFqmFEIkrOh7zvb+WFF+kDsNucizzO0R8pErEl6N+WW6UZuYInj6irYPRzjzLlLsgx6cG1MDYJYTIodTAbYP6DFONvUWujZhRcNWAWmY5O6N2XYAlMNq2g5e31mDX7qHCK0AlS83EiEZqPANzn6IVhF7WzlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aero.org; dmarc=pass action=none header.from=aero.org;
 dkim=pass header.d=aero.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aerospacecloud.onmicrosoft.com; s=selector2-aerospacecloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mWCt+jG9e4Ua92xql0ybbIT1nthmw5Lq7TeC2O142I=;
 b=cVm6ZOckcWCsp0o677ZPEBvkHBTEYFtCIn/tQl1owbGMc+L2V1Ov7IeLIYCqnjOqeNKVU8F69bKkKxGd2BNcTHZTIpodzB5sNBoQ3n2TfarV5UTupgPiBfugpmFh9REmrN89KyKhZjSVvxQj6LM89y82bPkuRShFCLRVvw9Pbzs=
Received: from BY5PR09MB4504.namprd09.prod.outlook.com (2603:10b6:a03:1c5::8)
 by BYAPR09MB3462.namprd09.prod.outlook.com (2603:10b6:a03:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 24 Jun
 2020 16:05:49 +0000
Received: from BY5PR09MB4504.namprd09.prod.outlook.com
 ([fe80::4c31:8bb7:a776:c4d3]) by BY5PR09MB4504.namprd09.prod.outlook.com
 ([fe80::4c31:8bb7:a776:c4d3%7]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 16:05:49 +0000
From:   Jesse Earles <jesse.earles@aero.org>
To:     Jason Pyeron <jpyeron@pdinc.us>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Are there MPU/SKU's for these products?
Thread-Topic: Are there MPU/SKU's for these products?
Thread-Index: AdZKPhATvPNGMKdcQL2gbx9ha4MxrAAAlIgAAAAwY2A=
Date:   Wed, 24 Jun 2020 16:05:49 +0000
Message-ID: <BY5PR09MB4504AD01DDA757120DCC79ABFF950@BY5PR09MB4504.namprd09.prod.outlook.com>
References: <BY5PR09MB4504218AEF2DFD593843A41EFF950@BY5PR09MB4504.namprd09.prod.outlook.com>
 <25d501d64a40$62991410$27cb3c30$@pdinc.us>
In-Reply-To: <25d501d64a40$62991410$27cb3c30$@pdinc.us>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL1RoZUFlcm9zcGFjZUNvcnAiLCJpZCI6IjVmYmI4OWY3LWY3NmMtNDBiZi1hYTdiLWU2OGM3ZDkyNzRkMCIsInByb3BzIjpbeyJuIjoiU2Vuc2l0aXZpdHkiLCJ2YWxzIjpbeyJ2YWx1ZSI6Ik5vbmUifV19LHsibiI6IlJlbGVhc2UiLCJ2YWxzIjpbXX0seyJuIjoiT3B0aW9uYWwiLCJ2YWxzIjpbXX1dfSwiU3ViamVjdExhYmVscyI6W10sIlRNQ1ZlcnNpb24iOiIxNy41LjEyLjEzIiwiVHJ1c3RlZExhYmVsSGFzaCI6IkNEQWMycFVcL3hDVGdWXC9nTno3ZWNTM1lZQURrYVdyRnkwYkVPT1lFSW44eVByQmhqM3daSEpGTkZlWXE3aGdCRiJ9
authentication-results: pdinc.us; dkim=none (message not signed)
 header.d=none;pdinc.us; dmarc=none action=none header.from=aero.org;
x-originating-ip: [130.221.145.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c794e37-0bea-4821-0c85-08d818587638
x-ms-traffictypediagnostic: BYAPR09MB3462:
x-microsoft-antispam-prvs: <BYAPR09MB3462874F459BD5DE7440EDB8FF950@BYAPR09MB3462.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gzwUfdyKO9vE1VW3D/hvKXxF0yu5rqMeLWyhUJJLSv2KroxNDYHCxmV6kOJ903xZyxZmlW/3XkfFY6oZyRQaSceE2tsEY1mj4pm0+aJytTsnM9YyRbCy1w4LAIUakcM3BFjWSvGwix0gLcr/zxyzK6W2AALsGYh+4Ppp9UTd8xspI0RNrbSHYTVoiIIT5T5ZEE9ygmjl54pSMXGaTChk7z6//W8KtjYb/T9MOsRuwT43EAEmXd2fmH1T6Bh2nLqPXZvtWDGJzDBGxf1esks32sLyrkdLHkbsPuPxSdTqB7ADsGo+TcguKavY12f3jqjarTBsdltJYgI8138zB86laQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR09MB4504.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(186003)(86362001)(26005)(5660300002)(8936002)(44832011)(33656002)(6916009)(4326008)(66476007)(66556008)(64756008)(66446008)(7696005)(66946007)(83380400001)(71200400001)(76116006)(9686003)(498600001)(2906002)(8676002)(55016002)(52536014)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Emkuby8cg9tv3mQxFQRaKClURhuhG8Uw8AtGZMPfe00csQR4SpRggKbFjtvDxn+/Ju7uWNj1v1jso/PitkvRkzbD85wtafFVMxd4d4kdAlSxGLZDoHKCTFUY7+L/l6CfHNfpQlaEabVIFawMu80e7Ip9yMqI8cYHqFDlRtB5yEx24Mh7RM5PjHOWTXitYWWMToe0NKF2SS5+n8VaEXynnSVXdkVBNOYvH7abOIEuRb0Bga2WKTFnyKNVHLCLCSAmk8FFK6dSJ8BKKhvCmEA8dNfNxqAws6ErduhNEW9C89KQqxLsiJAWzSRvgna3hY8DwcKXK0GytojtowYa1nvhOEv5hzQ6xlAGpAG8ZQlDejh+YG8mZOPaJTj5sScafa1MKrSHHCpMw+UkTnYgiV6aA0+HOA7R2S7Cx0F8UhuN8RUNyfSnu9hMXLWXNNfOBfql014hHFAF9lKIas7MzaXn5C9R4mz1nOLM2ABZpvWNCgdRvsVqQSj9gwlFrwBR7NUr
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aero.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR09MB4504.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c794e37-0bea-4821-0c85-08d818587638
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 16:05:49.0716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c8294700-c5a4-4ca1-a876-1457d39899fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XHUVrVcyZdzvSNs9Q+FhK42sogmds+LHDopgYEKdSInthJtQ4xiF3ilPy8Exd9yb9DOe/py/KyE9pSPSfylwvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR09MB3462
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzLCBidXQgSSB3YXMgcmVmZXJyaW5nIHRvIGlmIHRoZXJlIHdhcyBhIE1hbnVmYWN0dXJp
bmcgUGFydCBOdW1iZXIgb3IgYSBTdG9jayBLZWVwaW5nIFVuaXQgbnVtYmVyIGZvciB0aGlzIHBy
b2R1Y3QuIEkgYmVsaWV2ZSB3ZSBhbHJlYWR5IGhhdmUgdGhlIHVuaXF1ZSBJRCBlbnRlcmVkIGlu
IGFub3RoZXIgZmllbGQsIHNvIHRoYXQgcGFydCBzaG91bGQgYmUgZ29vZC4gDQoNCg0KDQoNCkpl
c3NlIEVhcmxlcw0KRGVza3RvcCBTdXBwb3J0IFNwZWNpYWxpc3QNCkVJUy9JVCBPcGVyYXRpb25z
IA0KRGlnaXRhbCBJbnRlbGxpZ2VuY2UgU3lzdGVtcywgTExDIChESVNZUykNClRoZSBBZXJvc3Bh
Y2UgQ29ycG9yYXRpb24NCjE0NzQ1IExlZSBSZC4gQ2hhbnRpbGx5LCBWQSAyMDE1MQ0KDQoNCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEphc29uIFB5ZXJvbiA8anB5ZXJvbkBw
ZGluYy51cz4gDQpTZW50OiBXZWRuZXNkYXksIEp1bmUgMjQsIDIwMjAgMTE6NTkgQU0NClRvOiBK
ZXNzZSBFYXJsZXMgPGplc3NlLmVhcmxlc0BhZXJvLm9yZz4NCkNjOiBnaXRAdmdlci5rZXJuZWwu
b3JnDQpTdWJqZWN0OiBSRTogQXJlIHRoZXJlIE1QVS9TS1UncyBmb3IgdGhlc2UgcHJvZHVjdHM/
DQoNClRoZSB1bmlxdWUgaWRlbnRpZmllciBmb3IgdGhhdCB2ZXJzaW9uIGlzOiBlN2UwN2Q1YTRm
Y2MyYTIwM2Q5ODczOTY4YWQzZTZiZDRkNzQxOWQ3DQoNCmNvbW1pdCBlN2UwN2Q1YTRmY2MyYTIw
M2Q5ODczOTY4YWQzZTZiZDRkNzQxOWQ3ICh0YWc6IHYyLjEyLjApDQpBdXRob3I6IEp1bmlvIEMg
SGFtYW5vIDxnaXRzdGVyQHBvYm94LmNvbT4NCkRhdGU6ICAgRnJpIEZlYiAyNCAxMDo0OTo1OCAy
MDE3IC0wODAwDQoNCiAgICBHaXQgMi4xMg0KDQogICAgU2lnbmVkLW9mZi1ieTogSnVuaW8gQyBI
YW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogZ2l0LW93bmVyQHZnZXIua2VybmVsLm9yZyA8Z2l0LW93bmVyQHZnZXIua2Vy
bmVsLm9yZz4gT24gQmVoYWxmIA0KPiBPZiBKZXNzZSBFYXJsZXMNCj4gU2VudDogV2VkbmVzZGF5
LCBKdW5lIDI0LCAyMDIwIDExOjQzIEFNDQo+IFRvOiBnaXRAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IEFyZSB0aGVyZSBNUFUvU0tVJ3MgZm9yIHRoZXNlIHByb2R1Y3RzPw0KPiANCj4gSGVs
bG8sDQo+IA0KPiBJIGFtIHdvcmtpbmcgd2l0aCBteSBzb2Z0d2FyZSB0ZWFtIG9uIHVwZGF0aW5n
IHRoZWlyIGludGVybmFsIGNhdGFsb2cgDQo+IHdpdGggY3VycmVudCBhbmQgYWNjdXJhdGUgaW5m
byBhbmQgYW0gbmVlZGluZyB0byBmaW5kIHRoZSBNUE4vU0tVIGZvciANCj4gIlNvZnR3YXJlIEZy
ZWVkb20gQ29uc2VydmFuY3kgfCBHaXQgfCB2Mi4xMi4wIi4gSSdtIG5vdCBjZXJ0YWluIGlmIA0K
PiB0aGVyZSBldmVuIGlzIG9uZSBhcyBJIGFzc3VtZSB0aGlzIGlzIG9wZW4tc291cmNlZCwgYnV0
IEkgZmlndXJlZCBJJ2QgcmVhY2ggb3V0IHRvIGdldCBjb25maXJtYXRpb24gYmVmb3JlIEkgbWFr
ZSBhbiBpbnRlcm5hbCBTS1UgZm9yIG91ciByZWNvcmRzLiBUaGFua3MuDQo+IA0KPiANCj4gSmVz
c2UgRWFybGVzDQo+IERlc2t0b3AgU3VwcG9ydCBTcGVjaWFsaXN0DQo+IEVJUy9JVCBPcGVyYXRp
b25zDQo+IERpZ2l0YWwgSW50ZWxsaWdlbmNlIFN5c3RlbXMsIExMQyAoRElTWVMpIFRoZSBBZXJv
c3BhY2UgQ29ycG9yYXRpb24NCj4gMTQ3NDUgTGVlIFJkLiBDaGFudGlsbHksIFZBIDIwMTUxDQo+
IA0KPiANCj4gDQoNCg0K
