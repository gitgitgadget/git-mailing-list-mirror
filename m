Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B05BEB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 15:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345815AbjFPPIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 11:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345888AbjFPPIG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 11:08:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC063589
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 08:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgevRoPM/VTsiBd248wGy8b2nrk9m4y/ofxVPi3JXW70sntycJhc3VzlIrGtf/w1XkQcC12oJgF/p8L4IML9DjZytceQjYXj+4zwS7JcN0qU7FOrz3UhOsqZlOSaxllcPs4+DZ/k0mVVm3YqxHoiavLV1iEuZ1nCmPH8334BtBwCweg/u8xIcsZUF43JEdiG5BCdb34KW+ZzmyJR+7zev4ByOjCfx1f3/bsEzwbmYrHOq0EK5CllN9LOVcWkkyQrA1/k6PNveQnsu6+gcYU5xzehtrzgjcChl4p8YpCTdp+eSIRbD8qQQC6SBT3fK5PGl8ijWcMuccdJd1074Em5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrTPLb1Vp9sbZKsyHSLgEX3Tp6zGM4lVilwH7VJmRQQ=;
 b=ARUHsAKJ5czW1H2MtPeSYQZ0EDaj4mZDIAm8VKNKqI9M8e5VQ1aCeavXwATYEsN+4hOY/xLKpXP/141jhPQKbeffrJT9TBCsLF8hba72l20nFcXugkOoJsI8DnljkWwPodS7wqwp0F36jo/0g0CCs4PN1cyWCxPYU7E+oGeSpcz/5sfejOt2Z4QvSpszWSA6bMqPREln1C+Qt+q4q+1JHlvBuYfhi+2bi21IEx5tEzlqCmCtVzvxSdgo8Kr7ZUeeF8KAQhTgp7uO9QYdSQYfadpMkh35kHgfVhghPlAUGdJwtsTDhyZOeZSHD9e703sPCxMcbYnaAttfx/Aoxfh87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrTPLb1Vp9sbZKsyHSLgEX3Tp6zGM4lVilwH7VJmRQQ=;
 b=SPym3/4++bXdCjilau0E1dwkAlZhlOVUIKV9ZhSVCepvtWgLpOg6FTe/lII2zfS66aojB3EkplTMAteW+t7DejRc6M/99lQLKNzFRgNNDlmQ1obb/WBXT9zsXR62imWmVvVQRvsWPWpZWNHSnG/gY1Tsb2GwjsCjS7uhMIxxFIV/uxGb1GBCZ60Rz+NnJ3C2hGxt4yDaODihOkzXUnkE/WeHKs1N3UyLfXGUFsvSI29A+rRVj6rC+M1S/TIG03CWNHa1L2jxeAIKbrKLTbc7Ca+l5IAhQzvnDuj+gJmJRGNr9EaRIDry1SaUeU2pG2jL299Fv93YlxP4MUCA3QiuMQ==
Received: from PH7PR07MB9467.namprd07.prod.outlook.com (2603:10b6:510:1ee::12)
 by BLAPR07MB8273.namprd07.prod.outlook.com (2603:10b6:208:325::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 15:07:57 +0000
Received: from PH7PR07MB9467.namprd07.prod.outlook.com
 ([fe80::a5d1:273b:d763:6af1]) by PH7PR07MB9467.namprd07.prod.outlook.com
 ([fe80::a5d1:273b:d763:6af1%4]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 15:07:57 +0000
From:   "eric.frederich@siemens.com" <eric.frederich@siemens.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: Possible bug regarding trailers
Thread-Topic: Possible bug regarding trailers
Thread-Index: Admfq2AaKG0ibEbJSseXK7cc2YIRTgAELm0AACeSNZA=
Date:   Fri, 16 Jun 2023 15:07:57 +0000
Message-ID: <PH7PR07MB9467AD34C96AEE60D5A4369F8C58A@PH7PR07MB9467.namprd07.prod.outlook.com>
References: <PH7PR07MB9467452EBAFAB2C825295C0C8C5BA@PH7PR07MB9467.namprd07.prod.outlook.com>
 <42e4373e-b700-45a6-99cc-db2f8896d5b7@app.fastmail.com>
In-Reply-To: <42e4373e-b700-45a6-99cc-db2f8896d5b7@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-06-16T15:07:55Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=99c7cf91-79dc-458a-a0c8-7749270e5236;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9467:EE_|BLAPR07MB8273:EE_
x-ms-office365-filtering-correlation-id: af6b8088-d7d0-4d72-e909-08db6e7b77d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h/uxqWe8sYdrIQSMl+PkaBywnwFsliTwB6YZxDAV+sbJ8uKRinDlp3UOPRQfdzrVomxX20H5SEGUb0ge1k00eVTUhbhyF/BkNuQNeBZ2zs3uFH7GURjRaqUG3l4aMsj3rIhMs/D1fcvSlYPpFk3/nWzCMchHXlDeEL5he5z7SLhQQZxqnEdvwDOlRbhDyYu54osGLNS7FXMNlgLpaJ4ccy+Yrbx6/m1M7fTEABWY7Ycq6dzD8tQerBDDgyfMPBJ4LxnGiRqPRW5ZFCmQT6aqybd1b+tasPPGNzdLpHYWgNvPJ9lObxCVohoZAIwgsVdP0een074D8NyTx3axWEq3dGCDXe3GBrEaP/objMFHgiopHHjftXz7RMyCq5nSTazWMQew1r2zIjS3Pd1Xa98s+dqSmfidE7koKJ4jynR2MO7RMYXEj8PaceTh2tMSpnmRwicaCJ+qxBkE9EbTc7HamPQn813FBCVLByzTGjfqEMpTftu/e4S20aLLWrOHYIQzls+q6ZQwKiqtJCFaNTZptZ4WrPI/s8jjlt7+ItQpalEZghtkZ1Iu2TAEk/YeDTBxMMyRSJehkvYBd9FDKmmZAj3QwjubNJ+wHg2FgUjqTA4eHfm3+YmvF+BdTlkJy4HD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9467.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(38100700002)(122000001)(38070700005)(82960400001)(83380400001)(2906002)(3480700007)(55016003)(8936002)(76116006)(41300700001)(8676002)(316002)(71200400001)(7696005)(5660300002)(52536014)(33656002)(54906003)(4326008)(66946007)(66446008)(66556008)(66476007)(478600001)(6916009)(64756008)(86362001)(66899021)(53546011)(6506007)(186003)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXZtZ3dSSm0zeXVHV3dTaXlldnA5cE95c0dSUCtyUmova1pzejdyWU1sUVdv?=
 =?utf-8?B?bVBVNzNhNEROTjFaU2F2ZWNkcURrSU5GTE5ob1JhbDN0RUxQeDg4NXZyUE5G?=
 =?utf-8?B?SnFHUEJ3SS84cjBsRUxUZ0hWbTNEemNwcmdOZ3p4QkdEdU4wQlhhV0wrK3po?=
 =?utf-8?B?eEZHa1lkbE9ka2ZJSmU0cVpXVFdIa29XQ0hrVDVQWWhTYzFlM21BM0ZNVmRI?=
 =?utf-8?B?b2tLTUN3blVRUTFwZHJPVlZDcjRndkNXclFHTTlDNTlmYk1XVGlzTnJpR3Rm?=
 =?utf-8?B?L3ZNRkNUbHc5N3E2alVqTjkwdzFWbEliT0RTRmQrcWhkQll3cHk2VW5HdFpD?=
 =?utf-8?B?NnR3MjZjOEpPT01mNlc0bTcrMXNsZVJqRnVVbnlVLzR5TkFLUUZRQXlzN29D?=
 =?utf-8?B?bENVeWxZc3JIcWVReXpPTGJZeHMzcXk3UHl2cEtjL2dDUTZDaTJncS9mNEVZ?=
 =?utf-8?B?Ni9qQmw2RDJVblg2eWg4by9sNDBCUjVuQjhKUkdZc3pyN1ZpT3dUTVhQeHVj?=
 =?utf-8?B?cE54b0FwRFZZa2VWbGpLY0NVdEVpTm1veFQzaVpJRVovNDdDeEJyVnZZaWxs?=
 =?utf-8?B?ODhBNmYxVnUzaGVLSmpKQm1CeUhTTFl4YW1ReGdHTXhRTXNHSlZ5aSt0VXdX?=
 =?utf-8?B?MGlzcjBBWFpVRXNJcElqMUR3WXQ0ZndvL2VjdXRZaEVNWng0ZFZPd3gvWUZ5?=
 =?utf-8?B?ZmhLaW5uMTVrc2F1dkFWam9oOEs5LzRFZElXM2lZeVB2ek9XaEwyVmVFNFdG?=
 =?utf-8?B?a0VpT0lBcUEydC9YZG1QZTg4alVjNHRWL2loSnZWQW41bTRtRHZ0ZFF5M2pE?=
 =?utf-8?B?SXpuSm0rRDZyeURoazl3MThVTkZveEtVWTd0UzRRVUhWMkpXUjRpWW9VM2Ny?=
 =?utf-8?B?WDdxczFMUHRKS2taQ2hkUjVTQ3U3ZG9mcG9lY1p1K1hmeXFGSXJqRGx4YnNJ?=
 =?utf-8?B?QW0vWDZIbHYzWFJTdHRUbFo2REVhZkVuYzJWOTJIVm1LUXJKTTZkOEU0dVJy?=
 =?utf-8?B?MEJJUVhhN25lYjM0WUVNWHFjeUdBMXFnNGRjWVR3Zm1qbFZPNFFGWEhVNVVh?=
 =?utf-8?B?dXZjbndqWkgwLzhEMjhTTktCTHBVM052Y1plZXdzRTkvTXFTY1N6bDBwWGhJ?=
 =?utf-8?B?Z05CK20wZ0hwQ0VkdEpZV0pBbDlKaGFMdnF0a1NlOWhBbzk3WXpCUEIvdGFx?=
 =?utf-8?B?NStIcjFLUDUvRXlxM0ZHSEtwenRWaXJzM3NuNTFHbXg2amQ1NTdCK2pycXJr?=
 =?utf-8?B?UE5UMUV6aUZaMmpUalczcjFUMGVzUUJaSmNiMDlIREpVc2pLSGxKdS9UTTFp?=
 =?utf-8?B?YTJOcnpvSDE4UUl4N2JMM3d4N290NmJqN1NsN3pMTVA4bVl2dUZteVMzc3FK?=
 =?utf-8?B?NjBqa1djU1NSTktsM3JlbXYvK2VHenVzNExXRDV3QlJDUzEvM2hRM0o5TFVi?=
 =?utf-8?B?SS9JQ0NnZlA1MmZYQlFibFZtWGxQZFJicWNtUjBqV2tJRjFNL1ZDMm5Cd1NW?=
 =?utf-8?B?cXB1WG5uMDZ6ejZZejhwbEZKc1hTYlAyRHhvd2dibVY5clFEak9lZzg5c3k5?=
 =?utf-8?B?VFI5OHJnZmw0VThjTVNobHBGQkZwRzQ2MExqTXlqV3YzdmphNDNZQURoMmND?=
 =?utf-8?B?bmxsM29lUWVYSE5VTlZkZnlmR3dsQ21Xb2U1ZzNDeWYzREZCQ0c2Z3g3VGRt?=
 =?utf-8?B?NWhub1NVZEgyRGJOUUVUUTRzVW9aUEV1ekcvYlUybk8ydldHSVhZamRXazRj?=
 =?utf-8?B?azg5NFh4SHdQR3BXR3QyNjBQMUdGSUdDc25RbnV3UEhYeGNhaE5OYmFMY1Ro?=
 =?utf-8?B?cWFyelpockZoTnFRNHVNeHUvL09TZ2NZVGZJbW9TUDRMZ3JKVHN4WGd5bHFj?=
 =?utf-8?B?OFRHbTJidFBIUjJ3a2MxeGxDMnpQZ0tiMi94dWRha0hVT3EzK3ozakl3R2cv?=
 =?utf-8?B?WklPdEJRSGFRZHNjWW8wRHhMYktLcnhxT1NjWmoyWUVQSXpDbUllbHR2QnYx?=
 =?utf-8?B?K0VacEUrZ1ZiV2lBMGM4SFg1NE1wMHFmOXBLNlZPOWxSVjUxZjdUaUh1ampl?=
 =?utf-8?B?R1V0eitXdkFocExLMklqMzBnVzJnVDFrN2lpMWM0R0lUeU1jb2JiQW95WjYv?=
 =?utf-8?Q?exuCSdnOurLl1pQ3Wcx7TFi8g?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9467.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af6b8088-d7d0-4d72-e909-08db6e7b77d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 15:07:57.2786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x7dxlo8O/ozgFczen/jgU03VSBXcOl2/qOZ1liehBbK+ZJk/FzVfiZ0s8B6+6c0K1sjTL/U6b5gZQ2KIY08l67ILiorTIv+Dv0iCtvHswr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB8273
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcmVwbHkgYW5kIGZpbmRpbmcgdGhhdCBjb2RlLg0KSSdtIHdvbmRlcmlu
ZyBhIGNvdXBsZSBvZiB0aGluZ3MuDQoNCkEpDQpJcyBpdCByZWFzb25hYmxlIHRvIGV4cGVjdCB0
aGF0IGEgdHJhaWxlciBhZGRlZCBkdXJpbmcgY29tbWl0IHdpdGggYGdpdCBjb21taXQgLS10cmFp
bGVyIHNvbWUta2V5OnNvbWUtdmFsdWVgIGFsd2F5cyBiZSBhYmxlIHRvIGJlIHJldHJpZXZlZCBy
ZWdhcmRsZXNzIG9mIHRoZSBjb250ZW50cyBvZiB0aGUgY29tbWl0IG1lc3NhZ2U/DQpJIGFtIG1p
Z3JhdGluZyBzb3VyY2UgY29kZSBoaXN0b3J5IGZyb20gYW4gb2xkZXIgU0NNIHRvIEdpdCBhbmQg
d291bGQgbGlrZSB0byBwcmVzZXJ2ZSB0aGUgY2hhbmdlIG1lc3NhZ2VzLg0KDQpCKQ0KU2hvdWxk
IGFueXRoaW5nIHRoYXQgaXMgcmV0cmlldmVkIHZpYToNCiAgICBgZ2l0IGNhdC1maWxlIGNvbW1p
dCAkU0hBIHwgZ2l0IGludGVycHJldC10cmFpbGVycyAtLXBhcnNlYA0KYWxzbyBiZSBkaXNwbGF5
ZWQgdmlhOg0KICAgYGdpdCBsb2cgLTEgLS1mb3JtYXQ9IiUodHJhaWxlcnM6a2V5PXNvbWUta2V5
LHZhbHVlb25seSxzZXBhcmF0b3I9JXgyYykgJUggJVQiICRTSEFgDQoNCi4uLiB3aHkgaXMgdGhl
cmUgYSBkaWZmZXJlbmNlPyAgKEV4cGxpY2l0IGNhbGwgdG8gaW50ZXJwcmV0LXRyYWlsZXJzIHNo
b3dzIHRoZSB0cmFpbGVyLCBidXQgdGhlIGxvZyBjb21tYW5kIGRvZXMgbm90KS4NCg0KV2l0aCBz
b21lIG1pbmltYWwgaW52ZXN0aWdhdGlvbiAoSSBhZGRlZCBhIHByaW50ZiBhdCB0aGUgdG9wIG9m
IGZpbmRfcGF0Y2hfc3RhcnQpLCBJIG5vdGljZWQgdGhhdCBmaW5kX3BhdGNoX3N0YXJ0IGlzIGNh
bGxlZCBkdXJpbmcgY2FsbCB0byBgZ2l0IGludGVycHJldC10cmFpbGVyc2AgYnV0IGl0IGlzIE5P
VCBjYWxsZWQgZHVyaW5nIGNhbGwgdG8gYGdpdCBsb2dgLg0KVGhpcyBtZWFucyB0aGUgc2FtZSBj
b2RlIHBhdGhzIGFyZSBub3QgYmVpbmcgZm9sbG93ZWQgaW4gdGhvc2UgdHdvIGNhc2VzIGRlYWxp
bmcgdy8gdHJhaWxlcnMuDQpJIHdvdWxkIGV4cGVjdCB0aGF0IGl0IHNob3VsZCB1c2UgdGhlIHNh
bWUgY29kZSBwYXRocyBpbiBib3RoIGNhc2VzLg0KDQpUaGFua3MsDQp+RXJpYw0KDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLcmlzdG9mZmVyIEhhdWdzYmFrayA8Y29kZUBr
aGF1Z3NiYWtrLm5hbWU+IA0KU2VudDogVGh1cnNkYXksIEp1bmUgMTUsIDIwMjMgMzowNCBQTQ0K
VG86IEZyZWRlcmljaCwgRXJpYyAoREkgU1cgVCZJIFRPIENMRCBYQ0QpIDxlcmljLmZyZWRlcmlj
aEBzaWVtZW5zLmNvbT4NCkNjOiBnaXRAdmdlci5rZXJuZWwub3JnOyBwZWZmQHBlZmYubmV0DQpT
dWJqZWN0OiBSZTogUG9zc2libGUgYnVnIHJlZ2FyZGluZyB0cmFpbGVycw0KDQpIaQ0KDQpPbiBU
aHUsIEp1biAxNSwgMjAyMywgYXQgMTk6NDYsIGVyaWMuZnJlZGVyaWNoQHNpZW1lbnMuY29tIHdy
b3RlOg0KPiBJIGFtIGFibGUgdG8gcHJvZHVjZSBhIGNvbW1pdCB3aXRoIGEgdHJhaWxlciB3aGlj
aCBkb2VzIG5vdCBzaG93IHVwIGluOg0KPiAgICAgYGdpdCBsb2cNCj4gLS1mb3JtYXQ9IiUodHJh
aWxlcnM6a2V5PW9sZC1zY20tY2hhbmdlLWlkLHZhbHVlb25seSxzZXBhcmF0b3I9JXgyYykgDQo+
ICVIICVUIiBIRUFEYCBCdXQgZG9lcyBzaG93IHVwIGluOg0KPiAgICAgYGdpdCBjYXQtZmlsZSBj
b21taXQgSEVBRCB8IGdpdCBpbnRlcnByZXQtdHJhaWxlcnMgLS1wYXJzZWANCg0KSXQgc2VlbXMg
dGhhdCB0aGUgYC0tLSBgIChub3RlIHRoZSBzcGFjZSkgaXMgaW50ZXJwcmV0ZWQgYXMgbWFya2lu
ZyB0aGUgc3RhcnQgb2YgdGhlIHBhdGNoIHBhcnQgKGFzIGluIGEgcGF0Y2ggZmlsZSB3aGljaCBj
b250YWlucyBhIGNvbW1pdCBtZXNzYWdlIGZvbGxvd2VkIGJ5IGEgcGF0Y2gpLg0KDQpTZWUgYHRy
YWlsZXJzLmM6ZmluZF9wYXRjaF9zdGFydGAgKGhlcmUgb24gZDdkODg0MWY2NyAoU3RhcnQgdGhl
IDIuNDIgY3ljbGUsIDIwMjMtMDYtMTMpOg0KDQoJZm9yIChzID0gc3RyOyAqczsgcyA9IG5leHRf
bGluZShzKSkgew0KCQljb25zdCBjaGFyICp2Ow0KDQoJCWlmIChza2lwX3ByZWZpeChzLCAiLS0t
IiwgJnYpICYmIGlzc3BhY2UoKnYpKQ0KCQkJcmV0dXJuIHMgLSBzdHI7DQoJfQ0KDQpJ4oCZbSBu
b3QgZ29vZCB3aXRoIEMgYnV0IGl0IHNlZW1zIHRoYXQgdGhpcyBsaW5lIHdpbGwgbWF0Y2g6DQoN
CiAgICAtLS0gbGV0J3MgbWVzcyBzdHVmZiB1cCAtLS0NCg0KV2hpY2ggaW5zdHJ1Y3RzIHRoZSBj
b2RlIHRvIHB1dCB0aGUgdHJhaWxlciAqYmVmb3JlKiB0aGlzIOKAnHBhdGNoIHBhcnTigJ0uDQoN
CihPciBhdCBsZWFzdDogaWYgSSByZW1vdmUgdGhpcyBpZi1ibG9jayB0aGVuIHlvdXIgc2NyaXB0
IHNlZW1zIHRvIHdvcmsgbGlrZSB5b3Ugd2FudCBpdCB0by4pDQoNClRoaXMgc2VlbXMgdG8gYmUg
aW4gbGluZSB3aXRoIHRoZSBkb2N1bWVudGF0aW9uIGluIGBtYW4gZ2l0DQppbnRlcnByZXQtdHJh
aWxlcnNgOg0KDQo+IFRoZSBncm91cCBtdXN0IGVpdGhlciBiZSBhdCB0aGUgZW5kIG9mIHRoZSBt
ZXNzYWdlIG9yIGJlIHRoZSBsYXN0IA0KPiBub24td2hpdGVzcGFjZSBsaW5lcyBiZWZvcmUgYSBs
aW5lIHRoYXQgc3RhcnRzIHdpdGggLS0tIChmb2xsb3dlZCBieSBhIA0KPiBzcGFjZSBvciB0aGUg
ZW5kIG9mIHRoZSBsaW5lKS4gU3VjaCB0aHJlZSBtaW51cyBzaWducyBzdGFydCB0aGUgcGF0Y2gg
DQo+IHBhcnQgb2YgdGhlIG1lc3NhZ2UuIFNlZSBhbHNvIC0tbm8tZGl2aWRlciBiZWxvdy4NCg0K
Tm90ZSDigJxieSBhIHNwYWNlIG9yIHRoZSBlbmQgb2YgdGhlIGxpbmXigJ0uDQoNClRoaXMgY2hl
Y2sgdXNlZCB0byBiZSBzaW1wbGVyOiBiZWZvcmUgaXQgb25seSBjaGVja2VkIGZvciBhIGxpbmUg
dGhhdCBzdGFydGVkIHdpdGggYC0tLWAsIG5vIG1hdHRlciB3aGF0IGNhbWUgYWZ0ZXIgb24gdGhh
dCBsaW5lLiBCdXQgdGhhdCB3YXMgY2hhbmdlZCB0byBtYXRjaCBvbiBgLS0tYCBmb2xsb3dlZCBi
eSBgaXNzcGFjZSh2KilgIGluIGMxODg2NjhlMzgNCihpbnRlcnByZXQtdHJhaWxlcnM6IHRpZ2h0
ZW4gY2hlY2sgZm9yICItLS0iIHBhdGNoIGJvdW5kYXJ5LCAyMDE4LTA4LTIyKS4gUmVhZGluZyB0
aGUgY29tbWl0IG1lc3NhZ2UgaXQgc2VlbXMgdGhhdCB0aGUgY2hhbmdlIHdhcyBjb25zZXJ2YXRp
dmUuIE1heWJlIGl0IHdvdWxkIGhhdmUgYmVlbiBtb3JlIHN0cmljdCAobGlrZSBkZW1hbmRpbmcg
b25seSBsaW5lcyBsaWtlIGVpdGhlciBgLS0tXG5gIG9yIGAtLS1cbiBgKSBpZiB0aGVyZSB3ZXJl
buKAmXQgY29uY2VybnMgYWJvdXQgaG93IHRoZSBiZWhhdmlvciBoYWQgYmVlbiBkb2N1bWVudGVk
IHRvIG1hdGNoIGxvb3NlbHkgdXAgdW50aWwgdGhhdCBwb2ludC4NCg0KKCtDYyB0aGUgY29tbWl0
IGF1dGhvcikNCg0KLS0NCktyaXN0b2ZmZXIgSGF1Z3NiYWtrDQo=
