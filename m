Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BC3C001B5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 16:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbiIBQf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 12:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbiIBQfz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 12:35:55 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.133.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78357859B
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 09:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1662136552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GReZ10IrslMtxIcUJ/XL23rJgx8Snavwyv8PR/WvVes=;
        b=aBpgp3nCZoCMpTbXWtoC2ymOyMMDIMsBGDY0mvC5oeOYtaBJQE5i+8HTVvxRkJSgWDMBVA
        bTOKohkKxFPlhtuxpTf2DC3uQJlIXgiCMG8D+5SyFWnLiQt16NcnzSfzeIvymy98ze/qze
        HIsH0C8pCzBQiW5P1mPE7dSCjm0jDR8=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-centralusazlp17013030.outbound.protection.outlook.com [40.93.13.30])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-hhlAgAltNxC0mZtDLHLX9A-1; Fri, 02 Sep 2022 12:35:51 -0400
X-MC-Unique: hhlAgAltNxC0mZtDLHLX9A-1
Received: from BYAPR05MB5573.namprd05.prod.outlook.com (2603:10b6:a03:1c::10)
 by SN6PR05MB4046.namprd05.prod.outlook.com (2603:10b6:805:20::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 16:35:42 +0000
Received: from BYAPR05MB5573.namprd05.prod.outlook.com
 ([fe80::490f:1009:ce25:470f]) by BYAPR05MB5573.namprd05.prod.outlook.com
 ([fe80::490f:1009:ce25:470f%7]) with mapi id 15.20.5588.010; Fri, 2 Sep 2022
 16:35:42 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH v4 4/4] fsmonitor: normalize FSEvents event paths to the
 real path
Thread-Topic: [PATCH v4 4/4] fsmonitor: normalize FSEvents event paths to the
 real path
Thread-Index: AQHYvVQH5djpr+NntUyFzNLwjYXiEq3LAbkAgAFSbnA=
Date:   Fri, 2 Sep 2022 16:35:42 +0000
Message-ID: <BYAPR05MB5573B477ED53CBC4C996729DD97A9@BYAPR05MB5573.namprd05.prod.outlook.com>
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
 <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
 <56cabf3be3b9e228bc948da372db4c9d11fd3926.1661962145.git.gitgitgadget@gmail.com>
 <bdf26d53-7068-87a6-484b-aeef99be35bd@jeffhostetler.com>
In-Reply-To: <bdf26d53-7068-87a6-484b-aeef99be35bd@jeffhostetler.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67ba8e0e-34d9-49d7-5296-08da8d012d71
x-ms-traffictypediagnostic: SN6PR05MB4046:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: d+inERm7mWAANfoV1U+vsArlJAH6v882uNknDKpf7DPhT6HZxe4eukxM1tqx1f4akw35G5VD1o3DyzJHd4lHyvRK+7Ah6zYE46142UEbJ/nUiKQ/sqfIWCq3IGWGBfPPYbv7Vd2Lj6mIIMgvvWwzZn1X7Yc9lmpR3l2KT8X+QT4VuVZ2nQJjNKlBHAReB/UvLq55RS/X5F/CJYRlmM8UrZRjv2n+5MjV3A0D3/iydfLdvV5k6Yf2nNG7ggEwG3tmsUTr52BpqaeW8cBsVXPVq4seXSWzkmVuFq3IegsvaZNsHC9s7S10bP2kMdlpu8t13A4OFMniyPqjAC5KxqLxBksXWCWrXvYcdPP/qA6YK73KZi67t3f01WQ4mqXwmu+1Txf14oCzzZhkwl4KK8KFj/5NUouSUKC9XhzmaL9TamdveHIopHvR5KFeaF9LT9ngZzPT/jndxN0kTW/oVup/dG7iPompIUHf6DnR0XzYWsqgToeggh4D5eTIB5OucpD/0I6GY7Nunrdk0Opfo3nplyfGyo8rvFviYMyQelk3oQ9q9dK+jqlKnNZf30YPJmnDs5yE+6hoRW4jczBg34jh1Rqx8uZUBZ+q7XbjWeDPCO/ntENl9MtSgl0EaXyOVIy6dGKhcZw8243aeJlzXyw8+15DtUFVTI4H3YCS7ZSsCY9tTvTB0vbjf+OODqEttks5U4w4K90gt8qSmsGw9Uv/zq/GQu5WGYq+U0EMHW7B+tvPGh/J55Ns4u7NyYOVmkDoj0wD/f2sDcvt1SyVMR352w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5573.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(478600001)(55016003)(38070700005)(41300700001)(110136005)(5660300002)(26005)(66946007)(9686003)(8936002)(86362001)(316002)(8676002)(66476007)(64756008)(52536014)(76116006)(66446008)(66556008)(53546011)(186003)(7696005)(6506007)(33656002)(2906002)(71200400001)(122000001)(38100700002)(83380400001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTdCQjZGd000YXEzVFlEcmM3SkxBMVNVb3lnMVJTTXdHWlRUV005Vi9WcGhN?=
 =?utf-8?B?U1RDQ3NlakpXTGZKL0ZXbDdRMVFOaEZCbTA1ZG5VS2N0N0Qxa0wxMkg5c2sv?=
 =?utf-8?B?ellrckIzMURUc1RWbEZEcUN5TUZwWjRKN1BRM3hnaDF4YllIK3ZldFdwM3Rh?=
 =?utf-8?B?VTJsb05scGdkcUlZMlhrR0pweDhndlhJdTJxblpTK3ZiSm4yWGpvU2hMaUJJ?=
 =?utf-8?B?ckY5eHBCeEY5Y1ExdUxWelN2NmpXbVVrNWNUS2pBcW9QQmJONUFQQWxYMEkw?=
 =?utf-8?B?c1NmMzQvMUJwYjN6ZC9rR1UwME1QcFVrVTg5VTloMDVjeTdHNEhNSEx3Z1V0?=
 =?utf-8?B?WDRRNFQ0NU9VMVZJdVd6SEk4VDFGVDU3K0g1Yi9uZmVrUUdVZmk0Vm9HbVVE?=
 =?utf-8?B?RlZ0QThaQ3BqdEdpdWVNVXBseWRHYkhsQkpUb05FRGdVam9Yb3hKek5pOXFU?=
 =?utf-8?B?WEo2cys1aVA4djFzT0ViUTVFanRxZXNWOTBGV2lLaTMxcWN1YjUrY3dTSjQ4?=
 =?utf-8?B?Z0Iwb2NrV3R6U0pnYnFpQlBzTG5vYnk5QndvK3IvWG9scmM0UGd1Y2lFQ1Bh?=
 =?utf-8?B?VzNxSTJIWC8zcjRHRnR1TjNMd21Ca084NE85NS9QZnRKTkNXekVFcXRrYW1m?=
 =?utf-8?B?SVc0dHd5Q2wvT2ppUlEvQXlsTFB4ODJpc0I2RWVFRHBaZ2xTU2JoenQyeE5z?=
 =?utf-8?B?RXBwb0c4SE1obDR1RW9lYjFXMldYTkVWMjAxWThBaU4zdGovTkl2bk93cCty?=
 =?utf-8?B?R05XN0lSQjhwbWt5dVJpZGRESi94ZUNobjJVK0krQ2Z6RzR3QTN0dnNZcUx0?=
 =?utf-8?B?VjFHY1JYV1o2b3dIeUp5Q2xmV09OVkk4M3NtU2lVR2xBSWhnRFE1OWV6TTQy?=
 =?utf-8?B?R2IrUXM5VVJGVjJ5VWZvMG5IUDlHblVsbjRmdTFTazFZZHprT0U4N1JXYmc1?=
 =?utf-8?B?VG1WK3lkY21MdXd0aVg3UitRRjNESXpZN2IxTklmaVB5NW8reGRJbCtHWi81?=
 =?utf-8?B?SGVGS1lJSjdNOWR1SzFJWXN1eVAzWloxRURuRXM1bjdsZUNxQlV1QlFneitO?=
 =?utf-8?B?OWhaWGxDU1BiVXc2K0x3akVMYUJ2dkNKbE1xaFFoUGl4L093UUtKTjl0R1pZ?=
 =?utf-8?B?TTk0WHlETlJWNWdlZ2h0bXFZSWdlUkRoanhTaGNKUVpkd3N1bTA0UHJRbzRJ?=
 =?utf-8?B?ZTNPUU9UQXdzTzY5dEZXQWk0Vk5CMFM4WTRQSldTOXljT1JQUnlieU9yMWlS?=
 =?utf-8?B?b1BHVnZlMTNoTjcwNWRvaDlBZ2FNNXpNZDArRExpbTlJYVQvQk00eTlTYTUr?=
 =?utf-8?B?V3ZuRHNEbWxwMlc2alAyeUhZamd4MVJUaDY2MWxjL2puQnZ6cHFCTGw1MFht?=
 =?utf-8?B?clhHM2hzZWdJcy9wNm12elQxN0FYSU1QNnl1K0ZSNHFqVUo1dzhLSFk0dys3?=
 =?utf-8?B?QVU1QVg0T2FNVUMzTTJNTVA0SHBCOWtvNFJsd1ptSnpJb3dLMm9PMjhhUEZw?=
 =?utf-8?B?TTZOcVBHeDJwVzFsSTFQUUt6TFY4WHZTam8wNDREUG5XWlBvVmkraklNSUNL?=
 =?utf-8?B?SmhDd05sRWlXSndGYytzcEgrWWhJYm9uNFdjOE8wakpxY2xiMG1YM0h6dzNk?=
 =?utf-8?B?SlJ0dGN5TU1EUXZaVzdPdXAzYXcra3F1Zkk2aldYOGJRMUJzNFQxbURQVVBR?=
 =?utf-8?B?NE5STDRiM1hVcG5uM3l5WU5qWm8vS1NmWmlKUGxjNXRJWHZXeDhyYUs3Q0tO?=
 =?utf-8?B?aUdnZDR3TTRWWm9iZGVuVUJNL1RqTldqZUVkWXROemkrY3I2YVQrKzlhbEZG?=
 =?utf-8?B?NG82MDZRcnVxQUl3d2Y3Uk1KbnpXd1hkNmJnV010QVdYQUYvczJCTjgwZG1E?=
 =?utf-8?B?UU1FMlBjOWxaY0lnOUErRkdEOFVRbXovanZ2dU43VFBHbElOWXl6QmhiY0FZ?=
 =?utf-8?B?SVJZTnIyOW95OEV5aXVndDRVR2RDUWNXUlZOSmVsQ0ZJVUIyZUJNMWJWY0pP?=
 =?utf-8?B?UkhKYmx3TWxkZmpwYzNTMDduWXlHSXkyNzlucngxYStZTi9QdUd3Ym5pdW5X?=
 =?utf-8?B?VWVUSWVxSERGMTh1azErclRyMVJJOW14c1pVRUlLRWVxWXJoMXUvWnlLYnNN?=
 =?utf-8?Q?qEN2mNErSNoSNco64jQCxkdVN?=
MIME-Version: 1.0
X-OriginatorOrg: mathworks.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4046
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBIb3N0ZXRsZXIg
PGdpdEBqZWZmaG9zdGV0bGVyLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAxLCAy
MDIyIDQ6MDYgUE0NCj4gVG86IEVyaWMgRGVDb3N0YSB2aWEgR2l0R2l0R2FkZ2V0IDxnaXRnaXRn
YWRnZXRAZ21haWwuY29tPjsNCj4gZ2l0QHZnZXIua2VybmVsLm9yZw0KPiBDYzogRXJpYyBEZUNv
c3RhIDxlZGVjb3N0YUBtYXRod29ya3MuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDQv
NF0gZnNtb25pdG9yOiBub3JtYWxpemUgRlNFdmVudHMgZXZlbnQgcGF0aHMgdG8gdGhlDQo+IHJl
YWwgcGF0aA0KPiANCj4gDQo+IA0KPiBPbiA4LzMxLzIyIDEyOjA5IFBNLCBFcmljIERlQ29zdGEg
dmlhIEdpdEdpdEdhZGdldCB3cm90ZToNCj4gPiBGcm9tOiBFcmljIERlQ29zdGEgPGVkZWNvc3Rh
QG1hdGh3b3Jrcy5jb20+DQo+ID4NCj4gPiBDb25zaWRlciB0aGUgZm9sbG93aW5nIG5ldHdvcmsg
d29ya2luZyBkaXJlY3RvcnkgdGhhdCBpcyBtb3VudGVkIHVuZGVyDQo+ID4gL1N5c3RlbS9Wb2x1
bWVzL0RhdGE6DQo+ID4NCj4gPiAvbmV0d29yay93b3JraW5nL2RpcmVjdG9yeQ0KPiA+DQo+ID4g
VGhlIGdpdCB3b3JraW5nIGRpcmVjdG9yeSBwYXRoIGlzOg0KPiA+DQo+ID4gL1N5c3RlbS9Wb2x1
bWVzL0RhdGEvbmV0d29yay93b3JraW5nL2RpcmVjdG9yeQ0KPiA+DQo+ID4gVGhlIHBhdGhzIHJl
cG9ydGVkIGJ5IEZTRXZlbnRzIGFsd2F5cyBzdGFydCB3aXRoIC9uZXR3b3JrLiBmc21vbml0b3IN
Cj4gPiBleHBlY3RzIHBhdGhzIHRvIGJlIHVuZGVyIHRoZSB3b3JraW5nIGRpcmVjdG9yeTsgdGhl
cmVmb3JlIGl0IGZhaWxzIHRvDQo+ID4gbWF0Y2ggL25ldHdvcmsvLi4uIGFuZCBpZ25vcmVzIHRo
ZSBjaGFuZ2UuDQo+IA0KPiBJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kIHdoYXQncyBnb2luZyBv
biBoZXJlLg0KPiBBcmUgeW91IHNheWluZyB0aGF0IEZTRXZlbnRzIHJlcG9ydHMgbmV0d29yayBt
b3VudGVkIGRpcmVjdG9yaWVzIHdpdGggYQ0KPiBwYXRoIHJlbGF0aXZlIHRvIHRoZSBtb3VudC1w
b2ludCByYXRoZXIgdGhhbiBhbiBhYnNvbHV0ZSBwYXRoPw0KPg0KDQpZZXMNCg0KPiBJbiB5b3Vy
IGV4YW1wbGUsIGlzICIvbmV0d29yay93b3JraW5nL2RpcmVjdG9yeSIgYSB2YWxpZCBwYXRoIG9u
IHlvdXINCj4gc3lzdGVtICh0aGF0IGFsc28gaGFwcGVucyB0byBiZSB0aGUgc2FtZSBkaXJlY3Rv
cnkgYXMNCj4gIi9TeXN0ZW0vVm9sdW1lcy8uLi4iKQ0KPiANCj4gVGhhdCBpcywgZG8geW91IGhh
dmUgc29tZSBhbGlhc2luZyBnb2luZyBvbiB3aGVyZSBib3RoIHBhdGhzIGFyZSB2YWxpZCAtLSBs
aWtlDQo+IGEgcGFpciBvZiBoYXJkLWxpbmtlZCBkaXJlY3Rvcmllcz8NCj4gT3IsIGlzIHRoZXJl
IHNvbWV0aGluZyBzcGVjaWFsIGFib3V0IGEgbmV0d29yayBtb3VudCBwb2ludD8NCj4gDQo+IA0K
PiBEaWQgeW91IGhhdmUgdG8gImNkIC9TeXN0ZW0vVm9sdW1lcy8uLi4iIHRvIGdldCBHaXQgdG8g
aGF2ZSB0aGUgYWJzb2x1dGUNCj4gcGF0aCBiZSB0aGlzPyAgT3Igd2VyZSB5b3UgZG9pbmcgYSAi
Y2QgL25ldHdvcmsvLi4uIj8NCj4gKFNvcnJ5IHRvIGFzayBzbyBtYW55IHF1ZXN0aW9ucyBidXQg
SSBkb24ndCBoYXZlIGEgcGFpciBvZiBzeXN0ZW1zIHRvIHRlc3QgYW55DQo+IG9mIHRoaXMgb24g
cmlnaHQgbm93LikNCj4gDQoNCiAiL25ldHdvcmsvd29ya2luZy9kaXJlY3RvcnkiIGlzIG1vdW50
ZWQgdW5kZXIgDQoiL1N5c3RlbS9Wb2x1bWVzL0RhdGEvbmV0d29yay93b3JraW5nL2RpcmVjdG9y
eSINCg0KVGhlcmUgaXMgYWxzbyBhIHN5bWxpbms6DQoNCiIvbmV0d29yayIgLT4gIi9TeXN0ZW0v
Vm9sdW1lcy9EYXRhL25ldHdvcmsiDQoNCk5vIG1hdHRlciBpZiBJICJjZCAvU3lzdGVtL1ZvbHVt
ZXMvRGF0YS9uZXR3b3JrL3dvcmtpbmcvZGlyZWN0b3J5Ig0Kb3IgImNkIC9uZXR3b3JrL3dvcmtp
bmcvZGlyZWN0b3J5IiB0aGUgcGF0aHMgcmVwb3J0ZWQgYnkgRlNFdmVudHMNCmFsd2F5cyBzdGFy
dCB3aXRoICIvbmV0d29yay93b3JraW5nL2RpcmVjdG9yeSINCg0KSWYgSSBkbyBhIHNpbWlsYXIg
c3ltbGluayB3aXRoIGxvY2FsIGRpcmVjdG9yaWVzLCBJIGRvIG5vdCBnZXQgdGhpcw0KdW5leHBl
Y3RlZCBiZWhhdmlvci4NCg0KSSBuZWVkIHRvIHJlbW92ZSB0aGUgc3ltbGluayBhbmQgdHJ5IGl0
IHRoYXQgd2F5LCBidXQgSSBuZWVkIHRvDQpjb29yZGluYXRlIHdpdGggdGhlIG1hY2hpbmUncyBv
d25lci4NCg0KPiA+DQo+ID4gQ2hhbmdlIHRoaW5ncyBzdWNoIHRoYXQgaWYgZnNtb25pdG9yLmFs
bG93UmVtb3RlIGlzIHRydWUgdGhhdCB0aGUNCj4gPiBwYXRocyByZXBvcnRlZCB2aWEgRlNFZXZl
bnRzIGFyZSBub3JtYWxpemVkIHRvIHRoZSByZWFsIHBhdGguDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBFcmljIERlQ29zdGEgPGVkZWNvc3RhQG1hdGh3b3Jrcy5jb20+DQo+ID4gLS0tDQo+ID4g
ICBjb21wYXQvZnNtb25pdG9yL2ZzbS1saXN0ZW4tZGFyd2luLmMgfCAxMSArKysrKysrKy0tLQ0K
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9jb21wYXQvZnNtb25pdG9yL2ZzbS1saXN0ZW4tZGFyd2luLmMN
Cj4gPiBiL2NvbXBhdC9mc21vbml0b3IvZnNtLWxpc3Rlbi1kYXJ3aW4uYw0KPiA+IGluZGV4IDhl
MjA4ZTgyODllLi4yZWQ4Mjg2NDlmZiAxMDA2NDQNCj4gPiAtLS0gYS9jb21wYXQvZnNtb25pdG9y
L2ZzbS1saXN0ZW4tZGFyd2luLmMNCj4gPiArKysgYi9jb21wYXQvZnNtb25pdG9yL2ZzbS1saXN0
ZW4tZGFyd2luLmMNCj4gPiBAQCAtMjYsNiArMjYsNyBAQA0KPiA+ICAgI2luY2x1ZGUgImZzbW9u
aXRvci5oIg0KPiA+ICAgI2luY2x1ZGUgImZzbS1saXN0ZW4uaCINCj4gPiAgICNpbmNsdWRlICJm
c21vbml0b3ItLWRhZW1vbi5oIg0KPiA+ICsjaW5jbHVkZSAiZnNtb25pdG9yLXNldHRpbmdzLmgi
DQo+ID4NCj4gPiAgIHN0cnVjdCBmc21fbGlzdGVuX2RhdGENCj4gPiAgIHsNCj4gPiBAQCAtMTgz
LDcgKzE4NCw2IEBAIHN0YXRpYyB2b2lkIG15X2FkZF9wYXRoKHN0cnVjdCBmc21vbml0b3JfYmF0
Y2gNCj4gKmJhdGNoLCBjb25zdCBjaGFyICpwYXRoKQ0KPiA+ICAgCWZyZWUoY29tcG9zZWQpOw0K
PiA+ICAgfQ0KPiA+DQo+ID4gLQ0KPiA+ICAgc3RhdGljIHZvaWQgZnNldmVudF9jYWxsYmFjayhD
b25zdEZTRXZlbnRTdHJlYW1SZWYgc3RyZWFtUmVmLA0KPiA+ICAgCQkJICAgICB2b2lkICpjdHgs
DQo+ID4gICAJCQkgICAgIHNpemVfdCBudW1fb2ZfZXZlbnRzLA0KPiA+IEBAIC0yMDksNyArMjA5
LDEyIEBAIHN0YXRpYyB2b2lkDQo+IGZzZXZlbnRfY2FsbGJhY2soQ29uc3RGU0V2ZW50U3RyZWFt
UmVmIHN0cmVhbVJlZiwNCj4gPiAgIAkJLyoNCj4gPiAgIAkJICogT24gTWFjLCB3ZSByZWNlaXZl
IGFuIGFycmF5IG9mIGFic29sdXRlIHBhdGhzLg0KPiA+ICAgCQkgKi8NCj4gPiAtCQlwYXRoX2sg
PSBwYXRoc1trXTsNCj4gPiArCQlpZiAoZnNtX3NldHRpbmdzX19nZXRfYWxsb3dfcmVtb3RlKHRo
ZV9yZXBvc2l0b3J5KSA+IDApIHsNCj4gPiArCQkJc3RyYnVmX3Jlc2V0KCZ0bXApOw0KPiA+ICsJ
CQlzdHJidWZfcmVhbHBhdGhfZm9yZ2l2aW5nKCZ0bXAsIHBhdGhzW2tdLCAwKTsNCj4gPiArCQkJ
cGF0aF9rID0gdG1wLmJ1ZjsNCj4gPiArCQl9IGVsc2UNCj4gPiArCQkJcGF0aF9rID0gcGF0aHNb
a107DQo+IA0KPiBUaGlzIGZlZWxzIHdyb25nLg0KPiANCj4gSXQgaXMgbm90IHRoYXQgZnNtb25p
dG9yLmFsbG93UmVtb3RlIGlzIHRydWUsIGJ1dCB3aGV0aGVyIG9yIG5vdCB0aGlzDQo+IHBhcnRp
Y3VsYXIgZmlsZSBzeXN0ZW0gKklTKiByZW1vdGUsIHJpZ2h0Pw0KDQpUcnVlLiBJIHN1cHBvc2Ug
ZWFjaCBwYXRoIGNvdWxkIGJlIGNoZWNrZWQsIG9yIHNvbWUgYml0IGNvdWxkIGJlIHNldA0KaWYg
dGhlIHdvcmtpbmcgZGlyZWN0b3J5IGlzIHJlbW90ZSwgcGVyaGFwcyBhbG9uZyB0aGUgbGluZXMg
b2YNCmZzbW9uaXRvcl9pcGNfX2dldF9wYXRoLiBUaGVuIHRoZSBkZXRlcm1pbmF0aW9uIG9mIHRo
ZSBJUEMgcGF0aA0KYW5kIHdoZXRoZXIgaXQgaXMgcmVtb3RlIHdvdWxkIGJlIGluIG9uZSBwbGFj
ZS4gZnNtLXNldHRpbmdzLSoNCndvdWxkIHRoZW4ganVzdCBnZXQgdGhhdCBiaXQgYW5kIGNoZWNr
IGl0IGFnYWluc3QgYWxsb3dSZW1vdGUuDQoNClRob3VnaHRzPw0KDQoNCj4gPg0KPiA+ICAgCQkv
Kg0KPiA+ICAgCQkgKiBJZiB5b3Ugd2FudCB0byBkZWJ1ZyBGU0V2ZW50cywgbG9nIHRoZW0gdG8N
Cj4gR0lUX1RSQUNFX0ZTTU9OSVRPUi4NCj4gPiBAQCAtMjM3LDYgKzI0Miw3IEBAIHN0YXRpYyB2
b2lkDQo+IGZzZXZlbnRfY2FsbGJhY2soQ29uc3RGU0V2ZW50U3RyZWFtUmVmDQo+ID4gc3RyZWFt
UmVmLA0KPiA+DQo+ID4gICAJCQlmc21vbml0b3JfZm9yY2VfcmVzeW5jKHN0YXRlKTsNCj4gPiAg
IAkJCWZzbW9uaXRvcl9iYXRjaF9fZnJlZV9saXN0KGJhdGNoKTsNCj4gPiArCQkJYmF0Y2ggPSBO
VUxMOw0KPiA+ICAgCQkJc3RyaW5nX2xpc3RfY2xlYXIoJmNvb2tpZV9saXN0LCAwKTsNCj4gPg0K
PiA+ICAgCQkJLyoNCj4gPiBAQCAtMzEzLDcgKzMxOSw2IEBAIHN0YXRpYyB2b2lkDQo+IGZzZXZl
bnRfY2FsbGJhY2soQ29uc3RGU0V2ZW50U3RyZWFtUmVmDQo+ID4gc3RyZWFtUmVmLA0KPiA+DQo+
ID4gICAJCWNhc2UgSVNfV09SS0RJUl9QQVRIOg0KPiA+ICAgCQkJLyogdHJ5IHRvIHF1ZXVlIG5v
cm1hbCBwYXRobmFtZXMgKi8NCj4gPiAtDQo+ID4gICAJCQlpZiAodHJhY2VfcGFzc19mbCgmdHJh
Y2VfZnNtb25pdG9yKSkNCj4gPiAgIAkJCQlsb2dfZmxhZ3Nfc2V0KHBhdGhfaywgZXZlbnRfZmxh
Z3Nba10pOw0KPiA+DQo+ID4NCg0K

