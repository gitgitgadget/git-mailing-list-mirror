Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED45C77B61
	for <git@archiver.kernel.org>; Sat,  8 Apr 2023 21:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjDHVwS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Apr 2023 17:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDHVwR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2023 17:52:17 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::60c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55549EF1
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 14:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4hqKtLEBn9aoA0Z473soPw+CyMoJyRl3FrgnUo5ODRX+yuD8Znzrpchu2tLIKo1H8mduCgfmyFpgkdIq3QdEUBzsXHylRy3toQqdLKuHDrHECh2SDK6u7CceooLsYQDoeHgbA+duUSz/0b+pRr7RT4FBj24FXvMPnCRBsCGKLZpOHMaY4XRqarVmXlGD3sdcxmQQhDBod1gVmuEeEDseQd1Lo61QaoGR2/BEUZiBGvJDtHEupZebqyriZ+PnMkZqPLOFBVwbPZWP4XVfhJRHJgY1g4v5xObEI8DGav3luL/bmfn2x3hP2dBdRJRakv8gqqKMIm2Dx4XIi40/cMheA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcPTDZqK90zFtGUukualfh7OJunGh80+vWq59XTO+48=;
 b=kDZGTbmbnqWS5QDP5lDtRxMrAYDlDwjyVWRrcUqeie04vOlzLu1X5gbmUIqO2/LkiuOqeRpiUhglEnX2kOrTo3jKwpChMFZ5xjyx+tLMAAnrYBKkLe+Pd4ekbUp6Wxn+77BYFWJm9cpGtM2BjD0MXreKhbd9qqifX3GfJ5jc/PlWzLR+369BanLoCWa92327SJOM2gsgkfDTBdcOR03ImUUKhLaHtE4CgPNyNiw0+ZTsOrCVCqM4uqa0WKukpzhWiGWKlG05oDTPj7MYRlC0DvdVV+rkhLI7BUN6Qu1HEjlGTjG3Zpgo+h69mUQk8ZUSLwIY40iYLKcPKawUV0HBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcPTDZqK90zFtGUukualfh7OJunGh80+vWq59XTO+48=;
 b=jIwYTCAuzZLuXpbc3UVc8PzXYFA4NGvUCIfsChiwVwOtcdnidzyD5OxvfcjYPUNvOIUAY4aht4+WOEh7r/ZN0ZZ3ju9DYHZzkylG08XE3riWtyxiDNvEgrY6EHMHzhut6xwALJHCeBqtft05QOT8ITmKEY/OiWetUYwYO3WYtbwC6+h/enQ1aE2hub893a5bpgFYk28zyo8fC5/FGckUdofBmTIY5bJtxsZEiHt1D60mfPq+tFU9B+rQJB4coE8Z5K94+u1/anU9daWzunDOOZCE9TK2InbWuI0RUgktNR5CkS1kH6iXqYvX7askgOGbfbFvCPxyQy58Fj+IP1/0sg==
Received: from GVXPR10MB8199.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:116::5)
 by AM7PR10MB3810.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.25; Sat, 8 Apr
 2023 21:52:09 +0000
Received: from GVXPR10MB8199.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d989:6959:ae70:ff84]) by GVXPR10MB8199.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d989:6959:ae70:ff84%5]) with mapi id 15.20.6277.029; Sat, 8 Apr 2023
 21:52:09 +0000
From:   "Brown, Chris" <chris.c.brown@siemens.com>
To:     Rudy Rigot <rudy.rigot@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Negative patterns in cone mode
Thread-Topic: Negative patterns in cone mode
Thread-Index: Adlm7OeCRKFtiy/rRRGXi7zzMWcApgDQ/S6AAAyaAiA=
Date:   Sat, 8 Apr 2023 21:52:09 +0000
Message-ID: <GVXPR10MB8199695A0BD5D7A404CCCFD4B9979@GVXPR10MB8199.EURPRD10.PROD.OUTLOOK.COM>
References: <GVXPR10MB8199D186532A7A285CCF1538B9939@GVXPR10MB8199.EURPRD10.PROD.OUTLOOK.COM>
 <CANaDLWJ4XSFUULc4PGen_trsyJ1_K1qoufisoxgpjCfMhoDjKQ@mail.gmail.com>
In-Reply-To: <CANaDLWJ4XSFUULc4PGen_trsyJ1_K1qoufisoxgpjCfMhoDjKQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=b3eb2b3f-9b22-4367-b4ab-df1a783ae139;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-04-08T21:44:16Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVXPR10MB8199:EE_|AM7PR10MB3810:EE_
x-ms-office365-filtering-correlation-id: bf097f24-a5f7-46a5-56b6-08db387b8088
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HdnPSc+JwX33hfaJdWRjaorEDWoqFpMrprHB8nKSRxjKdx44kxz+w3h4/97K5/p1xTtyJkQEg0fEBCpQNkRDXgkBD2D/sDBSXt6diKhbTvYEEm6Ro2OohMe7YcZHm7W594tA8LjLk7e2x2sWogwC3CXlWqOwMumXs3cbTW73Y1uPWwsFAbC9z/J+Hgi2HrJAhnzHXgoF2YKf2iP2schwc/26OhQger4kzAHpw9bZoR5VYrRWDHUGrnxC3RP94KgWIENHXoSuL0KlW9ov5do41C6AZphlH9SbIETT82ATqTZVflpFTEUpuijcKRzocCshOmRHvTEarPYDuQFs8dpeOxBiy2kLo5rFyRwhZrTQcEGE3TWxZrFEvyK1UFgqvs/Pl7XsR/ideRC0OVs6PGvRBl4CHQtvInx56n3DjiQSN+sT2err1ohC18ul7M4E1SRLoPNOa1JYX8l1jfN7u2zB9xxU75YAbDJg1r3+MQL9ZaktGFIY5gj1PQ/iyHC5vL/gK1N2yTovJW8yo/ceRz8+H6crGLjAmjm2T4NWrKbnifRIIOgpTPKWXOGqP2etAMptL/XJBhOgHEmvvEb+k1eqRiryrMB1X8cYHjTqeWUv8hMFwzItlclzz42SfG36Ue3a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR10MB8199.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199021)(53546011)(76116006)(66946007)(86362001)(26005)(316002)(66446008)(6506007)(64756008)(66556008)(66476007)(9686003)(6916009)(4326008)(186003)(71200400001)(7696005)(55016003)(478600001)(33656002)(8676002)(8936002)(38100700002)(52536014)(5660300002)(41300700001)(122000001)(38070700005)(2906002)(83380400001)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUg5RDRpTEN0THZ1NnErbFU3RndxNFdPdlJCZHhleTRSckFjc0lGV1RVWGYw?=
 =?utf-8?B?SlU4ellZVWdhS1NHcFkzSHNBajVWb3ZnL1dTaXNJNFJBT1RqYTRvajd5K3Fy?=
 =?utf-8?B?NWJudDNkcmJVdUF6eXZaZ3pvamQxYTNGRXlZb3F4N0o2NHF5YjBHdSt4U1Q4?=
 =?utf-8?B?SGkyYlpTNTlMNmhLZmM0WmthZnFkL1V4V2c4NVF1b2Y4TGp6c2ljQTMxdm5X?=
 =?utf-8?B?bGIvVFZHZzh2VkxBL01KNmRrQnhidXJlRUxUSG5iMnQyd1lVb0I0RzRRVjJT?=
 =?utf-8?B?TDFoWWlBVWgyNXhZVU1LNHYwT0dhZEp6Qk9PSTdQVU0yZmZDQkRxNnNhT1l2?=
 =?utf-8?B?RXM1Sjh3b29ySWJZbkw1RW9KWXJDY2xUMkt3R1FTS1pxdWlBMnVmNDZFV2Zv?=
 =?utf-8?B?ZHgxbHBlelZKUXM2R2Job3FqcHdCTGM1cVliSEVSZGQ3QUlXZ2tUTHcySGxx?=
 =?utf-8?B?ZlRhM1FFRXB5OUN5WFFxQ0hxaWRtemtwNUtia2JOdkd1c3ZWU1J0M3lDWFRo?=
 =?utf-8?B?MVlTY0xBTVdoSmQwUlp0N3MvSTRVdFVKS3NhMWpEa2poZzhUbkFXVU9ORkhU?=
 =?utf-8?B?RGxKalQzQXNZSm45RGc0MWVURXpTem51Z2RPOUJyaHY3LzFLb0pIQ3hzdVI3?=
 =?utf-8?B?S0xNU0hPdjY0WWRFNGpVemRMTW1zM3BuWUVXdW5SdnVKcTFKd3E3REFRVG1B?=
 =?utf-8?B?MGZOOVFvdzdVTzBkVVp4dHEwK0JNV01lZXJyMUZGT2c2TC9MV2dUQ2Y1QXNz?=
 =?utf-8?B?UGpqZnlZUlRQelF3bC9kcG9xUmhjZndlem1WOGo3d3NzK0ptQ1ZyZ1lnN3dt?=
 =?utf-8?B?d3BrV0FWa3VOY1AwWUZQUWtWRXk2QU9zbVA1ckZUTUI4ZnZwQjUrVzd5QXo4?=
 =?utf-8?B?cEJwSlV2L2djTDNJSHlWQlhQRTZ0ZEh0UWpwQld2WEFVRFl3UlBXbGVwMnh0?=
 =?utf-8?B?RUd3VHZ4aUNtOU5rQzdTdmNHOXpXK0tPL1lwNE10V0orNFN2b0xoUERWWlhF?=
 =?utf-8?B?TkJMbjNBV0MzZ3A3MXd0T0QrT1p5T1JxS2F4SHR4aktiMytsTWE1ZDdUVkNl?=
 =?utf-8?B?WEsvMC9oZVZFSnRldkNvb1dOZ0JEOExyS0tGTnFCcWY5dGF5SXVZbVZCZmJO?=
 =?utf-8?B?UEtyTm1VQjU5U1dRVnN5akdtaWNaV0FsSHhHSjZRNmNnL0ZLYndJaWFBY25l?=
 =?utf-8?B?REx1VUU4b3lSR0QydDJBOTc2ZXFDY1ZuQWx1c2VXZWRkMXlsQkF2cjBvTHk3?=
 =?utf-8?B?ZDcrTEtiTktMWTlWVUZoUmJEa0oyZGM2OC9KVVJQM1JjeTQyRHZFeHJuVzFn?=
 =?utf-8?B?K3hvM2d0Q3QycytFNVhMVGRXYWsxUEtBblZROXFYT1pVZGFrZnE5YzZFOHVX?=
 =?utf-8?B?UEVkZG93Ym5sWU5oM0ZWTGFkUHBpaTVWUkl1bWNEd1BwNFZOQkpMRFc0amJD?=
 =?utf-8?B?elcyeFdjbXIwSXcvdVVGTnM3SHVMcS9SMEZhWFB6QS8vSkFUdFhyN3VRWWR6?=
 =?utf-8?B?RWVOdHpSZWc5YVcxSW1Pc0pmR05QSlZYRmN6ZTE3amJ1SUZBeFJwZytFY3ds?=
 =?utf-8?B?a3F1dG9pdjNjNFY2MnpieUFsM1RmRmdsUUhSY2RqbTUxTGNjeFJ3VzJLOG5o?=
 =?utf-8?B?MjdXek5QWVp6eWM2Q2VZMmV1VklEYm5Xai8yakwzSTNIT1FxQ3FpVUd5eUp2?=
 =?utf-8?B?TGVYVXliYXg3Mm9sMHRMaGM2NE5BOGU2dUxpZXFSMjZzdHhyYk9YbWhUV2tv?=
 =?utf-8?B?N243VERBN2FKUmRrS2lzZTRMMmdmYVJORmtqa091RkhNbTlsM2dQNlJpRFNZ?=
 =?utf-8?B?SXIyQjRBbUhyUzZGNXlMdVh4S2ZoTDBzd2RHWUc5WTZSRnpLWmpwMW5aZVZO?=
 =?utf-8?B?QUFiV0ZxeHBHdCtMc09Sc3Y0d1IrQzBLY0pRek41cjVGWUEzcnRhLzRQTXBz?=
 =?utf-8?B?bDNRdkFFaW1YQkpPWUZvcldtaVRpNVlxVVNGR1lJZml3b1NndHdGSFlLd2ZO?=
 =?utf-8?B?UW5JUTBqTXNxQUVoS0JtNk1DdTd3ZUJVWk9YdkkxM0V6d3c5MEUxckpLZW9S?=
 =?utf-8?B?UWRYN2NQQUo5VVlsVUY0MjFRMHZHSHNTaEpYQldKRDRWeHhENE96OEM4RkVV?=
 =?utf-8?Q?sZMg1kIsM4kj1kyjKLZbVIT62?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVXPR10MB8199.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bf097f24-a5f7-46a5-56b6-08db387b8088
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2023 21:52:09.1461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2MvhrNtDKxgc0/2S0OHh5mcM8s/T4iHzfcC7jdpQYpoIFMgLuPLl+9LOryhWRUUjTBzgIvcPykTUJM+N+ZwMnX/ac3JbPEQyTmg83hnqX34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3810
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIGZvciB0aGUgaW5wdXRzLiBJIGNhbWUgdG8gYSBzaW1pbGFyIGNvbmNsdXNpb24gYWZ0
ZXIgcG9yaW5nIG92ZXIgdGhlIGRvY3MuIFdlIGhhdmUgYSBzaW1pbGFyIHNpdHVhdGlvbiB0byB5
b3U7IGJ5IGV4Y2x1ZGluZyB+NTAgZGlyZWN0b3JpZXMgbm90IHJlcXVpcmVkIGF0IGJ1aWxkIHRp
bWUgd2UgY2FuIGF2b2lkIDE4R0Igb2YgZmlsZXMgb24gZGlzayBhbmQgcmVkdWNlIHRoZSBmaWxl
IGNvdW50IGJ5IDJ4LiBJIGVuZGVkIHVwIHdyaXRpbmcgYSBweXRob24gc2NyaXB0IHRoYXQgdXNl
cyBnaXQgbHMtdHJlZSBhbmQgdGhlbiBjb252ZXJ0cyBhIGZldyBuZWdhdGl2ZSBwYXR0ZXJucyBz
cGVjaWZpZWQgYnkgdGhlIGRldmVsb3BlciBpbnRvIGEgaHVnZSBzZXQgb2YgcG9zaXRpdmUgcGF0
dGVybnMgZm9yIGFsbCBkaXJlY3RvcmllcyBpbiB0aGUgdHJlZSAqZXhjZXB0KiB0aG9zZSB0aGF0
IHNob3VsZCBiZSBleGNsdWRlZC4gVGhlIHBlcmZvcm1hbmNlIGlzIGdvb2Q7IHRoZSBweXRob24g
c2NyaXB0IHRha2VzIGFyb3VuZCAxcywgYW5kIHRoZW4gYWxsb3dzIHRoZSBzcGFyc2UgY2hlY2tv
dXRzIHRvIG9wZXJhdGUgaW4gY29uZSBtb2RlIHdoaWNoIHdvcmtzIGluIHNlY29uZHMuIFRoaXMg
aXMgZ3JlYXQgY29tcGFyZWQgdG8gbm9uLWNvbmUtbW9kZSBwcm9jZXNzaW5nIHdoaWNoIHRha2Vz
IHNldmVyYWwgbWludXRlcyB0byBzcGFyc2UtY2hlY2tvdXQgdGhlIHNhbWUgZGlyZWN0b3JpZXMg
ZXhwcmVzc2VkIGRpcmVjdGx5IGFzIG5lZ2F0aXZlIHBhdHRlcm5zLg0KDQpUaGlzIHN1Z2dlc3Rz
IHRvIG1lIHRoYXQgY29uZSBtb2RlICpjb3VsZCogYmUgZW5oYW5jZWQgdG8gbmF0aXZlbHkgc3Vw
cG9ydCBhIHJlc3RyaWN0ZWQgdHlwZSBvZiBuZWdhdGl2ZSBwYXR0ZXJuIChleGNsdWRlIHRoaXMg
ZGlyZWN0b3J5IGFuZCBhbGwgc3ViZGlycykgd2l0aG91dCBwZXJmb3JtYW5jZSBvdmVyaGVhZC4N
Cg0KVGhlIHByb2JsZW0gd2l0aCBteSBzY3JpcHQgaXMgdGhhdCBpdCBpcyBxdWl0ZSBjb21wbGV4
LCBnZW5lcmF0ZXMgdGhvdXNhbmRzIG9mIHBvc2l0aXZlIHBhdHRlcm5zLCBhbmQgSSBhbSBub3Qg
eWV0IDEwMCUgY29udmluY2VkIHRoYXQgdGhlIGNvbXBsZXhpdHkgaXMgd29ydGggaXQgb3ZlciBz
aW1wbHkgcGF5aW5nIHRoZSBjb3N0IHRvIGRvd25sb2FkIHRoZSBtb25vcmVwby4NCg0KQ2hyaXMN
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFJ1ZHkgUmlnb3QgPHJ1ZHkucmln
b3RAZ21haWwuY29tPiANClNlbnQ6IDA4IEFwcmlsIDIwMjMgMTY6NDMNClRvOiBCcm93biwgQ2hy
aXMgKERJIFNXIExDUyBDRikgPGNocmlzLmMuYnJvd25Ac2llbWVucy5jb20+DQpDYzogZ2l0QHZn
ZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IE5lZ2F0aXZlIHBhdHRlcm5zIGluIGNvbmUgbW9k
ZQ0KDQpIaSwNCg0KPiBJJ20gZmFjaW5nIGFuIGlzc3VlIHdpdGggbmVnYXRpdmUgcGF0dGVybnMg
aW4gY29uZSBtb2RlLg0KPiBJIGNhbid0IHRlbGwgZnJvbSB0aGUgZG9jcyBvciBnaXQgY29kZSBp
ZiBJIG1pc3VuZGVyc3RhbmQgdGhlIHVzYWdlLCANCj4gYW0gdHJ5aW5nIHNvbWV0aGluZyBub3Qg
c3VwcG9ydGVkLCBvciBpZiB0aGVyZSBpcyBhIGJ1Zy4NCg0KTXkgdW5kZXJzdGFuZGluZyBzbyBm
YXIsIGFuZCBJIHdvdWxkIGFwcHJlY2lhdGUgaWYgc29tZW9uZSBjYW4gY29ycmVjdCBtZSBpZiBJ
J20gd3JvbmcsIGlzIHRoYXQgdGhlIHBvaW50IG9mIGNvbmUgbW9kZSBpcyB0aGF0IHRoZXJlIGNh
bid0IGJlIG5lZ2F0aXZlIHBhdHRlcm5zLCBhbmQgZXZlcnl0aGluZyBpcyBhIHBvc2l0aXZlIHJ1
bGUsIHNvIHRoZSBtYXRjaCBzZWFyY2ggY2FuIHN0b3AgYXMgc29vbiBhcyBhIHBvc2l0aXZlIHJ1
bGUgaXMgZm91bmQuDQoNCk15IHVuZGVyc3RhbmRpbmcgaGFzIGJlZW4gdGhhdCBpdCB3YXMgZGVz
aWduZWQgd2l0aCB0aGUgdXNlIGNhc2UgaW4gbWluZCBvZiBsYXJnZSBtb25vLXJlcG9zIG1hZGUg
b2Ygc2V2ZXJhbCBpbmRlcGVuZGVudCBhcHBsaWNhdGlvbnMsIG9mIHdoaWNoIGEgZ2l2ZW4gZGV2
ZWxvcGVyIG9ubHkgbmVlZHMgYSBmZXcuIEZvciBpbnN0YW5jZSwgaWYgSSBhbSBhbiBpT1MgZGV2
ZWxvcGVyLCBJIHdpbGwgY29uZmlndXJlIG15IHNwYXJzZSBjaGVja291dCB0byBoYXZlIHRoZSBi
YWNrLWVuZCBjb2RlIGFuZCB0aGUgaU9TIGNvZGUsIGJ1dCBub3QgdGhlIGZyb250LWVuZCBjb2Rl
IGFuZCB0aGUgQW5kcm9pZCBjb2RlLg0KDQpJIGRvbid0IGtub3cgaWYgdGhhdCdzIGFjY3VyYXRl
IGJlY2F1c2UgSSdtIG5vdCBhcyB3ZWxsLXZlcnNlZCBhYm91dCBpdCBhcyBJIHNob3VsZCBiZSwg
c28gSSB3b3VsZCBhcHByZWNpYXRlIGlmIHNvbWVvbmUgY291bGQgY29ycmVjdCBteSB1bmRlcnN0
YW5kaW5nLiBJdCBpcyB0aGUgY2hpZWYgcmVhc29uIHdlIGFyZSBzdGlja2luZyB3aXRoIG5vbi1j
b25lIG1vZGUgd2l0aCBvdXIgbWFzc2l2ZSBtb25vbGl0aCBhdA0KU2FsZXNmb3JjZTogaXQgaXMg
bm90IGEgbW9uby1yZXBvIG9mIGluZGVwZW5kZW50IGFwcGxpY2F0aW9ucywgYnV0IG9uZSBtYXNz
aXZlIG1vbm9saXRoIG9mIHdoaWNoIG9ubHkgYSBmZXcgKHZlcnkgbGFyZ2UpIGZpbGVzIGFyZSBu
b3QgbmVlZGVkIGZvciBhbGwgZGV2cy4NCg0KVGhhbmtzIGluIGFkdmFuY2UgZm9yIGFueW9uZSB3
aG8gbWF5IGhhdmUgaW5zaWdodHMuDQo=
