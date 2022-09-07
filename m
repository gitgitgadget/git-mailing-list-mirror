Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3B9C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 23:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIGXEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 19:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiIGXEl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 19:04:41 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.133.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964311F2FA
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 16:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1662591877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fcvrp7j77xkJQRRNTVt0zXG3nmvTIhXxplPhLCd61aE=;
        b=a1ZL8MBC/Wjz2JlbSCLPUipiQRLUwCswT4cx7rfn+9SDL8XR0ZgaTmj5yk3Vf0sBEo49hJ
        Xm5X9vS3+jvcpaEcZHoF6c/Gh2+IWB8Cp49jHvWrQH3hNm3+Cq+bYYeOni40qjB98mm1dA
        fhS13BTvuPTNHZ/LRJfkal0l4+dBRt8=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-centralusazlp17013032.outbound.protection.outlook.com [40.93.13.32])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-Y-QIBfyfOr2LEdgxEunQuw-1; Wed, 07 Sep 2022 19:04:36 -0400
X-MC-Unique: Y-QIBfyfOr2LEdgxEunQuw-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by CO1PR05MB7912.namprd05.prod.outlook.com (2603:10b6:303:f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5; Wed, 7 Sep
 2022 23:04:34 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7%6]) with mapi id 15.20.5612.007; Wed, 7 Sep 2022
 23:04:34 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH v4 4/4] fsmonitor: normalize FSEvents event paths to the
 real path
Thread-Topic: [PATCH v4 4/4] fsmonitor: normalize FSEvents event paths to the
 real path
Thread-Index: AQHYvVQH5djpr+NntUyFzNLwjYXiEq3LAbkAgAFSbnCABlkzAIAAGvZQgAALwjCAAY1+AIAAM2Zw
Date:   Wed, 7 Sep 2022 23:04:34 +0000
Message-ID: <BL0PR05MB5571C7A41CF397E7F7B05EC9D9419@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
 <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
 <56cabf3be3b9e228bc948da372db4c9d11fd3926.1661962145.git.gitgitgadget@gmail.com>
 <bdf26d53-7068-87a6-484b-aeef99be35bd@jeffhostetler.com>
 <BYAPR05MB5573B477ED53CBC4C996729DD97A9@BYAPR05MB5573.namprd05.prod.outlook.com>
 <a583a787-1f54-74ba-add1-61f9e30d5c2a@jeffhostetler.com>
 <BL0PR05MB5571765C903A82FDD990956AD97E9@BL0PR05MB5571.namprd05.prod.outlook.com>
 <BL0PR05MB55712AAD73E0B82B84AC9640D97E9@BL0PR05MB5571.namprd05.prod.outlook.com>
 <c9e9b38d-b2a8-7c01-9978-0cb2fc29880f@jeffhostetler.com>
In-Reply-To: <c9e9b38d-b2a8-7c01-9978-0cb2fc29880f@jeffhostetler.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|CO1PR05MB7912:EE_
x-ms-office365-filtering-correlation-id: a6d79d67-8ba6-450e-3e31-08da9125548a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: jFEWsbrheVb1t6j+o05c9tNw7WocVyYJ2EXsFOE0UDq84KJbHuG7a+u1zaLZnaE4nRKMd2Op9e+FhmBdD7nru9dkSIVbaHdyynphfNw8YJtVhUHEuRuQvXw8KzgYrL4s8FWz0OCsLo/tIiDXmUErQ5XT0qg1tKv7vXCjvgYpGAR+REf+scBo4WxOEGrDokLf47Cauz3AwyX246jMNiCPBr315A8jom9S8a9dnPi1wETpA0WARRpyAhHnGHT/yEYJcxe92HqziSM0y7wCTNG1fssSfk0rl0PpehNJvZb0VtZK8m4OVSOHeyB6g+FGy2gvpTXphELb5aAqeSn9inmhuWgudq/IkB6W5E0SHsO2025FuulDCUZ6ZmtEXl97OmKSOt/O2s8MNXm4yDLVhXdYRbA5P1DRIRj+BcI7j1vtc0HbmX6MsLxmlKkuze+OyFefaOLn6xaq+k0p8dl5RNgR4b+IPtIVbQRYjRwddAlrCkserwGA4Cs2jEltVl71Op/UKHCXaaDrK+cWfyvw/Uzqm4/UPueBuV8WxsMENECjI7nt1BFkEMy1PsOD2DoGNfUpLs10g3uV5ILmRuou+WjO9oLrq260IaTu8jl1DlS9Sz6pg+DQmHVI2s7nISZ+m2BFHQUoQSenebxMR67inKNX0rheQ6s2lvQo7AOeJBOVK8+NeMdSHdZH5Y7NcFSypvMkTEvfkZYhAWrIPUsPF6LI4CrNmJ0syuevMJQpZP0QpR0mHmlpjtOoOD2ZUtEJcP6elBQgsdoCn6AJhnWxDInltr2vCJ3I9RT42m8IyyUlbUkVf7BKSZ3byA/YlBlPJdOmzW4VnQ/LPcgTAwyi/ruTsYUmvOi47AXeM0RSi1OFio8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(66476007)(8676002)(66446008)(64756008)(66556008)(66946007)(86362001)(76116006)(38070700005)(110136005)(5660300002)(316002)(7696005)(6506007)(83380400001)(53546011)(41300700001)(9686003)(26005)(71200400001)(966005)(186003)(122000001)(55016003)(38100700002)(478600001)(52536014)(84970400001)(33656002)(2906002)(8936002);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXJWRjVTZm52blJ3amtoMzVNV1NFeWgwajZYWjFzWW5jbzBXM204Tk9WMmNY?=
 =?utf-8?B?VFZ1cTB4YXVlWmF3YyszZU8rQUQ4bFJtMEJyMG9yejVDeGFnT2hvbE9Gams4?=
 =?utf-8?B?ME5CL3c4T29BOFFlN2xPN1FOU1M5NWpra0ZWMHo1MlVHVkZLNWpaVHk3U1Ji?=
 =?utf-8?B?WHhuTllGbVNVZko0aHJZb0VZcTRFdGVOTk93TTY4ZTRHOWpYTDYyb3owQVVh?=
 =?utf-8?B?UFZLK3J0bk5xTjIrbTRuRTdCY1llMTA3L3pBK1Y5RHBFNEIwNnZ6aDl3SXdz?=
 =?utf-8?B?L0c5S1kzNSthdnNWdzVFaGdiRmdaZHU4TDVaM3ZSN1hrZUdmVzZJU2hZQ3Mw?=
 =?utf-8?B?RE1JNUVyQVU0U1VRN0QwSGttb0FqVW9wdjFIbHVlQ3pLaytrb3VjUGlmenJY?=
 =?utf-8?B?R2RvU0NVVGdXQ1FYSDdFYXBlUDFCQW9LalJTOTVSL2pOcHRidXo1UmFSSnhN?=
 =?utf-8?B?VDRkTWVvT3RoMCtscVp4QUJYQkt6cnBQdzNIVjJ0VHlLN0REK3NHZ3J6VHNQ?=
 =?utf-8?B?aXhPOXM2RlhqTTBudk0waTgwM3o1Y296bExEMmZ2dEFRT0g1UWp1UHBXZGd3?=
 =?utf-8?B?a1hTaCtJUHBacktmd2t0VHd5VjQ2L1BmU01hTEdKSDVjajgyT3ZUaDZJaWU2?=
 =?utf-8?B?QldJaHNGQ2hyMGpZU25TNWM2MUNwZU0rMnVLSTEvWVNZQnN2TVlBQzV0VkRx?=
 =?utf-8?B?MElZTEFLcjJlVmpWN2NIUW1wNWlBaXpIS3V0MXVOQnhiVzhDcVJLb24vTjlM?=
 =?utf-8?B?WlpaanRkSkxwaExVRVFTbFFGdlQ2Z2pOOVBpbUx5VkQyZ3pSb0J5Y1M5UCs2?=
 =?utf-8?B?RG1pWmlMcVg4YjNuY3JvYm4reGVBTkljc1ZqZmM5WWJlQUNSTXZUdW9wM0My?=
 =?utf-8?B?aG1qcGNmY0dZeFFTcjVuQXlWLzRqOWNxR3FrMUZaZksvb2N5UXZGeGcyYjQ4?=
 =?utf-8?B?Ym1Vdk5MMm85akhwdmptVU9FMmI5Y3JKRmtUU3VyVzdrTHdURnJCWjFkR01E?=
 =?utf-8?B?S3pnZGxWK3RlVnhwb3ZrT1lyYmdBVU16NzNydUFJQTJYbnMzbEQxSys5Mzl4?=
 =?utf-8?B?cCtIWVdCcFVyeWN4V1pOSWlDaW5QaXlKdVNtVXcyV0V0OTh5eGZxdFpJQmNi?=
 =?utf-8?B?a3dKZGlQcVlMM2lqLzIwV0kwWVAvQW9xdkVoMXZLdmsvRy9XZGRKL1UvcGpJ?=
 =?utf-8?B?VERnWUt1T2dLVkVoOHZCeElMd2xZeEUxa3ZOajVNWHdrdVRYT2diT0hYVWRp?=
 =?utf-8?B?ZmlIQnN1KzZXNGtpMENFb3ZQYXhqcStFUGFLOTVvVUFlSStLdy9pa1h2bmZx?=
 =?utf-8?B?OU1tWkM3MG5RenRhUjQvZmI5ZjhTeDlEWGEwUHNMTlBvZEo4UmJWMGk3dGcx?=
 =?utf-8?B?SGRESTNoRG1QNEprZ0NlRHRhWnd3blhYRHZVSTV0UkVaRElORDVueDNTZjJD?=
 =?utf-8?B?WXhyY2JQbXloMGk2c0NiTkhKOHZCeFAzbzR4OFFvQW4rSEVsZzdQMkJEN0xh?=
 =?utf-8?B?SFV1VWhBSUFCVnd2T3pEVndaTFdQWTZHNXZaQU9JSUswRHdjamorTUs2TFlV?=
 =?utf-8?B?VDI4dDNybklaUG5Vam9wZWNKbEc3eTBnSFBHWmlyTXp6MGhzd1pjZjE4ays2?=
 =?utf-8?B?eTlFTmhHWWp4b1I2WFp2QVJXaVREbHdDUllBVWxNTmx1M3hOcnh5bFR5Snpy?=
 =?utf-8?B?T1pIZFMxQUtQbVU2QkgzZnNsd3FjMDR6ZGc3WC9XRElKNlJMdEQ4UXduSGRB?=
 =?utf-8?B?ZVFNN2E1cGZIbkt3TmN2ZFZsZmx0YVdtQVh5MUdwTGUvNGV0cmtPak9UZjl6?=
 =?utf-8?B?R2ZRZnpFeXNCdnV2ZFlvdDZVQzh0YXU3eHRLQTEveSszanFqRVZZbytuTGc1?=
 =?utf-8?B?NUgyYm9rSUtTd0dCZmxsbmNhRUNUc1dpeU96WmhtbGpYR1lFcmNVNzdwbUtK?=
 =?utf-8?B?RGVyQnR1VmVVcDdwZ3pWUWZsOE5lcS9YZzJLRG9MZTUvRWhWcGVjZndyK0FE?=
 =?utf-8?B?QXYvYjZqYUVOT20xYVlVS05paUR5aE9iT0QybzRBRFdoR1B3d1k1RW5pcVZU?=
 =?utf-8?B?SWdCaEZCVEhBc1IwN25iMGFyNXRCa3Y1N0ZLR0ZUSzVSM3Q2MXBMdi9GdGZL?=
 =?utf-8?Q?8cPSuDEjWdghMxNNvvA/L5fPh?=
MIME-Version: 1.0
X-OriginatorOrg: mathworks.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR05MB7912
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBIb3N0ZXRsZXIg
PGdpdEBqZWZmaG9zdGV0bGVyLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgNywg
MjAyMiAzOjE1IFBNDQo+IFRvOiBFcmljIERlQ29zdGEgPGVkZWNvc3RhQG1hdGh3b3Jrcy5jb20+
OyBFcmljIERlQ29zdGEgdmlhIEdpdEdpdEdhZGdldA0KPiA8Z2l0Z2l0Z2FkZ2V0QGdtYWlsLmNv
bT47IGdpdEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCA0LzRdIGZz
bW9uaXRvcjogbm9ybWFsaXplIEZTRXZlbnRzIGV2ZW50IHBhdGhzIHRvIHRoZQ0KPiByZWFsIHBh
dGgNCj4gDQo+IA0KPiANCj4gT24gOS82LzIyIDM6MzMgUE0sIEVyaWMgRGVDb3N0YSB3cm90ZToN
Cj4gPg0KPiA+DQo+IFsuLi5dDQo+ID4NCj4gPiBUaGlzIGlzIGluZm9ybWF0aXZlOg0KPiA+DQo+
ID4gaHR0cHM6Ly9kZXZlbG9wZXIuYXBwbGUuY29tL2ZvcnVtcy90aHJlYWQvMTIwNjY1DQo+ID4g
PGh0dHBzOi8vcHJvdGVjdC0NCj4gdXMubWltZWNhc3QuY29tL3MvVmoxbUNMOUdsTFVqbXlKamZx
TEJxRz9kb21haW49ZGV2ZWwNCj4gPiBvcGVyLmFwcGxlLmNvbT4NCj4gPg0KPiA+IC1FcmljDQo+
ID4NCj4gPg0KPiANCj4gSG93IHN0cmFuZ2UuLi4uLi4uLg0KPiANCj4gSGF2ZSB5b3UgdHJpZWQg
dGhlOg0KPiBmY250bChGX0dFVFBBVEgpDQo+IHZzIGZjbnRsKEZfR0VUUEFUSF9OT0ZJUk1MSU5L
KQ0KPiB2cyByZWFscGF0aCgpDQo+IA0KPiBjb21wYXJpc29uIHN1Z2dlc3RlZCBpbiB0aGUgY29t
bWVudHMgYW5kIGRvZXMgaXQgcmV0dXJuIGFueXRoaW5nIHNlbnNpY2FsPw0KPiBTdWNoIHRoYXQg
d2UgY291bGQgcmVjb3JkIGJvdGggc3BlbGxpbmdzIHdoZW4gdGhlIGRhZW1vbiBzdGFydHMgdXAu
IEkgdGhpbmsNCj4gd2UnZCBoYXZlIHRvIGRvIGl0IG9uIGFuIG9wZW4gZmQgb24gdGhlIHdvcmt0
cmVlIHJvb3QgZGlyZWN0b3J5Lg0KPiANCj4gSmVmZg0KPiANCj4gDQo+IGh0dHBzOi8vZGV2ZWxv
cGVyLmFwcGxlLmNvbS9mb3J1bXMvdGhyZWFkLzEyMDY2NSA8aHR0cHM6Ly9wcm90ZWN0LQ0KPiB1
cy5taW1lY2FzdC5jb20vcy9WajFtQ0w5R2xMVWpteUpqZnFMQnFHP2RvbWFpbj1kZXZlbG9wZXIu
YXBwbGUuY29tDQo+ID4NCg0KSSdtIG5vdCBnZXR0aW5nIHRoZSBzYW1lIHJlc3VsdDoNCg0KV29y
a3RyZWUgaXM6ICcvU3lzdGVtL1ZvbHVtZXMvRGF0YS9tYXRod29ya3MvZGV2ZWwvc2FuZGJveC9l
ZGVjb3N0YS9naXQnDQpGX0dFVFBBVEggb2Ygd29ya3RyZWUgaXMgJy9TeXN0ZW0vVm9sdW1lcy9E
YXRhL21hdGh3b3Jrcy9kZXZlbC9zYW5kYm94L2VkZWNvc3RhL2dpdCcNCkZfR0VUUEFUSF9OT0ZJ
Uk1MSU5LIG9mIHdvcmt0cmVlIGlzICcvU3lzdGVtL1ZvbHVtZXMvRGF0YS9tYXRod29ya3MvZGV2
ZWwvc2FuZGJveC9lZGVjb3N0YS9naXQnDQpyZWFscGF0aCgpIG9mIHdvcmt0cmVlIGlzICcvU3lz
dGVtL1ZvbHVtZXMvRGF0YS9tYXRod29ya3MvZGV2ZWwvc2FuZGJveC9lZGVjb3N0YS9naXQnDQoN
ClRyeWluZyAvbWF0aHdvcmtzL2RldmVsL3NhbmRib3gvZWRlY29zdGEvZ2l0DQpGX0dFVFBBVEgg
b2YgL21hdGh3b3Jrcy9kZXZlbC9zYW5kYm94L2VkZWNvc3RhL2dpdCBpcyAnL1N5c3RlbS9Wb2x1
bWVzL0RhdGEvbWF0aHdvcmtzL2RldmVsL3NhbmRib3gvZWRlY29zdGEvZ2l0Jw0KRl9HRVRQQVRI
X05PRklSTUxJTksgb2YgL21hdGh3b3Jrcy9kZXZlbC9zYW5kYm94L2VkZWNvc3RhL2dpdCBpcyAn
L1N5c3RlbS9Wb2x1bWVzL0RhdGEvbWF0aHdvcmtzL2RldmVsL3NhbmRib3gvZWRlY29zdGEvZ2l0
Jw0KcmVhbHBhdGgoKSBvZiAvbWF0aHdvcmtzL2RldmVsL3NhbmRib3gvZWRlY29zdGEvZ2l0IGlz
ICcvU3lzdGVtL1ZvbHVtZXMvRGF0YS9tYXRod29ya3MvZGV2ZWwvc2FuZGJveC9lZGVjb3N0YS9n
aXQnDQoNCkVpdGhlciBzb21ldGhpbmcgaGFzIGNoYW5nZWQgb3IgdGhlIGZhY3QgdGhhdCAiL21h
dGh3b3JrcyIgaXMgYSAic3ludGhldGljIGZpcm1saW5rIiBoYXMgc29tZXRoaW5nIHRvIGRvIHdp
dGggaXQuDQoNCk1heWJlIGxvb2sgZm9yIHN5bnRoZXRpYyBmaXJtbGlua3MgaW4gdGhlIHJvb3Qg
ZGlyZWN0b3J5IGFuZCB1c2UgdGhhdCBpbmZvcm1hdGlvbiB0byBmaWd1cmUgb3V0IHdoYXQgYWxp
YXNlcyB0aGVyZSBtaWdodCBiZSB0byB0aGUgd29ya3RyZWUuDQoNCmxyd3hyLXhyLXggICAxIHJv
b3QgIHdoZWVsICAgIDMwIFNlcCAgMiAxMTo1MiBtYXRod29ya3MgLT4gL1N5c3RlbS9Wb2x1bWVz
L0RhdGEvbWF0aHdvcmtzDQoNCklmIHdoYXQgdGhlIGxpbmsgcmVzb2x2ZXMgdG8gaXMgYSBwcmVm
aXggb2YgdGhlIHdvcmt0cmVlLCB0aGVuIGl0IGlzIGEgZmlybWxpbmsgdG8gdGhlIHdvcmt0cmVl
Lg0KDQpTb21ldGhpbmcgbGlrZSB0aGF0Lg0KDQotRXJpYw0K

