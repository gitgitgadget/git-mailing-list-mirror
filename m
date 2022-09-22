Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79544C6FA91
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 14:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiIVOMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiIVOLa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 10:11:30 -0400
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2083.outbound.protection.outlook.com [40.107.127.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4FEF3101
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 07:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAo6wzI6KDuYfosz5u9Z9QsZMD3g7xGMFjQefHWaU4asAtybtxY8zQo2d+xc96+DXT5ZYk58l4Aed7XMMFqP+P4PAjkyUkxruI8TGRoH3fH/RgNZJl8VSUJf1ykCv7E5VKlIM6o4nup4knc6OdrnVeOqihBC4VNRYmuVNVyGX3aXx0uNEfyeFO4R/6vyIe5nzvSWHTbAXwCM+KcnmBTz93poGpfoaZL69jSw2h6p0wk8jTmqixNfN+cmDyS8i1eo4AsWLIVGtPit36Mz4x3ui3mZpWr84KcNujug+eXfwmvgQEP824Ux044wqjurbp+/1BfG+Qv8jx2EIFcGS7rkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xX/nrMZFG7FE7yMj9izK6BjWuajzOR2lnEgDjWuolA=;
 b=I0X3bUVSTcZ009+IqU+CqPuprLi0i/GmqK+IJFB2hQ7DJtuewy5htkiI47rXb6JkV6y//rf1TY8SxrUqFXQY3mWLEc2SdCk+pUWnG1EIjDG5qEW3XlpOCoAcdjqfUu/xwOIq+3ZhXlP7+ZbGJY/kHWu0r+MtKHsS3x0PtZ57GcRUH70BlFgSLqaMews+NiVX9V3MoQCS5NtEvPph3JMhv+IjEun1875pV1/bBV2H9AONMtoBqACL/Hw7i0fqtOtfvIAv4fYaD3bcaeL/+pOv/BWZUK39J+NGJakm+zeivFRLTNiEbmllf+DUvU+8vNKoL5lkksoSJWBm49jVeUp9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softwareag.com; dmarc=pass action=none
 header.from=softwareag.com; dkim=pass header.d=softwareag.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softwareag.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xX/nrMZFG7FE7yMj9izK6BjWuajzOR2lnEgDjWuolA=;
 b=lHOhgwGBGxvui/qCEChhHO1oZOKoaszfVq7pT13Gd/WEezGZLWQR0CpOwai+A2DcyNH7dUnOjUwOAMOgSXwfGp+XXdSUXf2TE6R/l5xmTps/y3QcmsTg0m/tULpT6mBew03jdDJqafPp74aGYU2tHCptNmZ1rTKJiW1g7P8UCRs=
Received: from BEZP281MB2519.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:2c::13)
 by FR2P281MB3117.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7; Thu, 22 Sep
 2022 14:11:18 +0000
Received: from BEZP281MB2519.DEUP281.PROD.OUTLOOK.COM
 ([fe80::e298:a9ee:ddc9:8def]) by BEZP281MB2519.DEUP281.PROD.OUTLOOK.COM
 ([fe80::e298:a9ee:ddc9:8def%9]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 14:11:18 +0000
From:   "Lindeke, Cord" <Cord.Lindeke@softwareag.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git diff-index considers touched files as dirty and changes behaviour
Thread-Topic: git diff-index considers touched files as dirty and changes
 behaviour
Thread-Index: AdjOjS5obICwbtzOQNiMgP97CIFWxQ==
Date:   Thu, 22 Sep 2022 14:11:18 +0000
Message-ID: <BEZP281MB25194116180654CE60001F6CEC4E9@BEZP281MB2519.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ee9ddd37-01c2-47a1-893c-5c0bdc1f6d39_ActionId=fead5413-9eb1-49e7-b9e4-a917e4514841;MSIP_Label_ee9ddd37-01c2-47a1-893c-5c0bdc1f6d39_ContentBits=0;MSIP_Label_ee9ddd37-01c2-47a1-893c-5c0bdc1f6d39_Enabled=true;MSIP_Label_ee9ddd37-01c2-47a1-893c-5c0bdc1f6d39_Method=Standard;MSIP_Label_ee9ddd37-01c2-47a1-893c-5c0bdc1f6d39_Name=Public;MSIP_Label_ee9ddd37-01c2-47a1-893c-5c0bdc1f6d39_SetDate=2022-09-22T14:06:52Z;MSIP_Label_ee9ddd37-01c2-47a1-893c-5c0bdc1f6d39_SiteId=d9662eb9-ad98-4e74-a8a2-04ed5d544db6;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softwareag.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2519:EE_|FR2P281MB3117:EE_
x-ms-office365-filtering-correlation-id: 0636c661-2e59-4691-5f10-08da9ca4519b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QDP01GzlnpDSPFpifU4odO/0hoS1Iya9T86cuBDxi8FUqCDnLyps/Wl0L0RuEAG2ZY0BMGYHxZOJC1ljs85nQ538kaiwXxbMBoP8Q8vm9qCFldob8BbPrmUC3BpZz9pNf8CympjLBAQa8eOfGWakTZz+soMudF9Z2yBNk+5i38YaE0DNYHrLnwlFWLKMy+jE+r3bmUmcCNsFcKQ2LqZMIo/m7sHSml2MmyCy1+7D73tOuK/i1XgkQZ8NBB7nmHrFm6zba95QbX8oM8H8kNTrO4ZylCjIbg4kzHz2t8JGWbvizq6mH++wz2wEQ7qFyMVR7Cylsk7x20XOG2NHPW3gWIktStR0UVuhkUDW1bAJJyKV8nuR7TJEVK4dL3rLriUcnlMJnkfNzyhI8yIwE/n50iqzlOz6sY15L2K1J/l3jl4mmItW6RjXVij60di6x4n7QXqtfvQe+TWnSKoAlTFk0cyrEDqvUElzGtahybrHmTXzVYRirXV/ozXWK9T9y/CDNvUXxkwkMgp6yzAyA1+2v16cbj2rdzxVOVCDOU12lgVTNtRD/CJlesnT3LFSDabncbubWpjOcux9jlersb2XwFDcFkpSp4oiaoHkCwnka94dBwMWq5IBER33sF/ZCerHLxyNLTePN9mZ5eR71DgqROUHGwsFniMuhUvsAsz0NYoskGhmiiGmXzw4HxlRAFd0/8ItRVmMv07Sx17OW5DGQVrvBOJlMtZdWfOUCqzAI0/FVfc2NBL1VuY3cfasgbXuP4CCT6juaLLsBm/eOT/0iEtRVjoVudm1eUKCSTjJORY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2519.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(8936002)(55016003)(52536014)(6506007)(86362001)(38070700005)(5660300002)(7696005)(8676002)(6916009)(71200400001)(33656002)(66556008)(41300700001)(66446008)(66476007)(76116006)(66946007)(64756008)(316002)(478600001)(2906002)(83380400001)(122000001)(186003)(966005)(66574015)(38100700002)(9686003)(26005)(14143004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGo3WEVkL05wU2FDQjVKWnJLMDI2T0NTeFA5TCsrTGIwZ0k0UkJlbnZ2MEx6?=
 =?utf-8?B?RlN5RDFNaFE1SWt4S01vQ2dNVWlEdzZaZkNNcE95NDdHSUY5SDNaa1ZDWmVw?=
 =?utf-8?B?amZnT1NrdU9hL2FuZ29aZ3lFaDM5YWgydDdSeGFUS2ZTRDRjTm16R3BYMkln?=
 =?utf-8?B?OVhyZ2lsajJpL3JKczliK0xJcE1xdkd3cmNaNzM5VnVsampmKzVxMlk4TE1M?=
 =?utf-8?B?SjFDQWhtaEdSb1lYeXBsRnRlVXF3ZGJXMFArdVd3dWlzSzZ5alAraG5mN3dQ?=
 =?utf-8?B?MGYydk43WGpNUThQMU1kOVdqVmxVQmJYazhMaVkydFdPSkFGZDJmQUFYUjUr?=
 =?utf-8?B?amlOaGJBYkN3dGk5cDVZMFlwNlJNQzJJUlBYZjV5WXpHVERWdkdkajZIWWlt?=
 =?utf-8?B?MzZRV3RZZHpIT29PbHRld3p2blUyZGZqaFczTFpWQ09rL3BnbExoc0JYcUpG?=
 =?utf-8?B?eW40ZFZhNW1yc2s1TzkyMG1GbmZtV0VlZ0ZJbnh1bUN0S1JzZW1LY0g1TUN0?=
 =?utf-8?B?Q2N1aTc1ZWxSYWk5QUJCSS9vcVoyYUprZ282ZlovUkhIcjR4OXN6U09FSjdH?=
 =?utf-8?B?SjZVcko4WUtFd002QkwxY3Z1NWNnckdLTkhWTG5PRHJhZjBBMWwzWHlqU2Jt?=
 =?utf-8?B?RlVUamxXT0NoVSs0TE1mVExJT0Rsd1RoSzlhSEhBd2JSRmZVemlMSjJDcWIx?=
 =?utf-8?B?WlRQRVIybGxZZU9Zd3dGb1dUdmRXSU1sVTNUOG8vTk0wMnpwSVBOemlSVVRp?=
 =?utf-8?B?VW13K1J4aGFNWHREUStaR1Q0UFdjVkFlZ2xSeHVZdUJwQVo3ZTRJMlplZUEy?=
 =?utf-8?B?bDl6dHBvOWdwVUt4M0ZjUWlnb0tFL0crTjVuN2NPUHVkSWtuZjRrVlNOTGZO?=
 =?utf-8?B?YjltSHlRSGFIK1pha0NXWkQrSnBWeVcrQzZZT2lycUZ0bUV5eTJETC82VXZq?=
 =?utf-8?B?Rno4T0tvejlWMGF1eC9lUUdnc091R1pGYmREdENPMVlydkY5MHhaeTNIUCth?=
 =?utf-8?B?NkJCbVEra0xlaVFRRVN4dFVFWlkvZE1WTDhRS2paRHNNb01GVWtOaWxuR2sv?=
 =?utf-8?B?Wm1WSTRsNXJQa0RIRzI0TUZVZjE2K29NK29WR2VnMDRUVjFTdXBsNXVwWWE3?=
 =?utf-8?B?aG80YlpYU29nNEpjY2l0WStjcjdRMkUyRjludHQrOVY2M0puOWNndHNNRDNE?=
 =?utf-8?B?Q09UZWtPTjNyZzJXZDF3SW00aVl2R2JYc1lxQ2g2alNCU3M2cmFDRHdmSHlI?=
 =?utf-8?B?am8vZFdGZkNHenFvOVNQVC90VGh4L2trbVRYck56Q0I1ZUNyaFI1bXhwZmxT?=
 =?utf-8?B?Zng5QURMZ3YwdTYrS2NvaE8zR3JmVlEwbXNXRXN0L1BNNXEvQklRVnlNMlVY?=
 =?utf-8?B?Uzd5ZHBySGh4eGhOL1k0K1VVS3QzUm9LdHNSZ01CLy83dkpDRkxCUi9aR1A4?=
 =?utf-8?B?SlA2VTdZNktTRVcwVnMyR3pSTnpPNVhYRjNMa3FUT3NzdVFDc09DNHVZNjdu?=
 =?utf-8?B?MHhuTVRWR2xsRU5MbHM5ZTdlSmwyQXlHanQ1M3gvTFJCTUtoVkZNRFh0N2k4?=
 =?utf-8?B?eU1PVXdZcFg1QXJhT29Zdlo4RmdEZ0dDSGlZUmlLRlpXVmpDaFVtdXlYU3Uz?=
 =?utf-8?B?MzZUa0FxQUNTb3JJblh0SEM5MFA0aEdNUU1qUU44Y29CV0RLSUR0Sjh2SmZ5?=
 =?utf-8?B?SUVzN3FIRjYzTEdJMXdjWjljK2V1WEUxeFZuVy9LRllzdSt2OFhhRGt6VFdi?=
 =?utf-8?B?c3NxTFp6cHNxSkRvU3dyNXh6MjVsTk5LemxtT2pMU2xIek5xUGliM3ZoQlZN?=
 =?utf-8?B?ZFowTjBhQVdacG9oZFl4TUoyMVpmc3dCaW9nWVZ1Q29EQmxiWEJ4SDRkUVAz?=
 =?utf-8?B?SzNLME1PVDljN2s4ZGh2S1hBRU9nTXp2L0FxTEluVTIzVEFGcUxILzVRcElN?=
 =?utf-8?B?K0xFMEZ5L210dGJ4SFk3RlVEOE15SE1ISU9sUWttK28zUGtnZ1QwdWtkYTd0?=
 =?utf-8?B?Wm9yNG05cTdIK3hQWmFlazlkZ3RqYWJNZmxnQUljY0VMVHZHc2lxY1d3Zzk5?=
 =?utf-8?B?T2xFNzY4a1l2V1lueklYRHczRk8wSWhHWlE1aHRYUXRCNVpBb0dQV1VBclVE?=
 =?utf-8?Q?3/bfzQx2mRjUFbFAxpy2/fLdK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: softwareag.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2519.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0636c661-2e59-4691-5f10-08da9ca4519b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 14:11:18.3896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9662eb9-ad98-4e74-a8a2-04ed5d544db6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QTb5RS+mnS4BZMMumegqQxXT/7bLn1OK6r81h5NB3tE00DOsSNpgyxLlfjkSUsEXlfm4efKqQAwbL3J2Wj2xdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB3117
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVwcm9k
dWNlIHlvdXIgaXNzdWUpDQo+IHRvdWNoIFJFQURNRS5tZA0KPiBnaXQgZGlmZi1pbmRleCAtLWV4
aXQtY29kZSBIRUFEDQo6MTAwNjQ0IDEwMDY0NCA2NGMxZWZlY2Q1NzE2ZjU2MTU1YjgwNmNhYWY5
ZmE2YTc3MWZhZTQ3IDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAgTSAg
ICAgIFJFQURNRS5tZA0KPiBlY2hvICQ/DQoxDQo+IGdpdCBzdGF0dXMNCk9uIGJyYW5jaCBtYXN0
ZXINCllvdXIgYnJhbmNoIGlzIHVwIHRvIGRhdGUgd2l0aCAnb3JpZ2luL21hc3RlcicuDQoNCm5v
dGhpbmcgdG8gY29tbWl0LCB3b3JraW5nIHRyZWUgY2xlYW4NCj4gZ2l0IGRpZmYtaW5kZXggLS1l
eGl0LWNvZGUgSEVBRA0KPiBlY2hvICQ/DQowDQoNCldoYXQgZGlkIHlvdSBleHBlY3QgdG8gaGFw
cGVuPyAoRXhwZWN0ZWQgYmVoYXZpb3IpDQpUaGUgZmlyc3QgImdpdCBkaWZmLWluZGV4IiBzaG91
bGQgbm90IGRldGVjdCBhbnkgZGlmZmVyZW5jZXMsIGJ1dCByZXR1cm4gMCBpbnN0ZWFkLg0KDQpX
aGF0IGhhcHBlbmVkIGluc3RlYWQ/IChBY3R1YWwgYmVoYXZpb3IpDQpUaGUgZmlyc3QgImdpdCBk
aWZmLWluZGV4IiBjb25zaWRlcnMgdGhlIHRvdWNoZWQgUkVBRE1FLm1kIGFzIGRpcnR5IGFuZCBy
ZXR1cm5zIDEuDQpTb21laG93LCBjYWxsaW5nICJnaXQgc3RhdHVzIiBmaXhlcyB0aGlzIGJlaGF2
aW91ciBzbyB0aGF0IHRoZSBzZWNvbmQgImdpdCBkaWZmLWluZGV4IiBiZWhhdmVzIGFzIGV4cGVj
dGVkLg0KDQpXaGF0J3MgZGlmZmVyZW50IGJldHdlZW4gd2hhdCB5b3UgZXhwZWN0ZWQgYW5kIHdo
YXQgYWN0dWFsbHkgaGFwcGVuZWQ/DQpUaGUgcmVzdWx0IG9mIHRoZSBmaXJzdCAiZ2l0IGRpZmYt
aW5kZXgiIHNob3VsZCBoYXZlIGJlZW4gMC4NCkFuZCB0aGUgYmVoYXZpb3VyIHNob3VsZCBub3Qg
YWx0ZXIgYXQgYWxsIHdpdGggY2FsbGluZyBhbnkgb3RoZXIgZ2l0IGNvbW1hbmRzIGxpa2UgImdp
dCBzdGF0dXMiIG9yICJnaXQgZGlmZiIgaW4gYmV0d2Vlbi4NCg0KQW55dGhpbmcgZWxzZSB5b3Ug
d2FudCB0byBhZGQ6DQpUaGUgc2FtZSBpc3N1ZSBob2xkcyB0cnVlIGZvciAiZ2l0IGRpZmYtZmls
ZXMiLg0KDQpQbGVhc2UgcmV2aWV3IHRoZSByZXN0IG9mIHRoZSBidWcgcmVwb3J0IGJlbG93Lg0K
WW91IGNhbiBkZWxldGUgYW55IGxpbmVzIHlvdSBkb24ndCB3aXNoIHRvIHNoYXJlLg0KDQoNCltT
eXN0ZW0gSW5mb10NCmdpdCB2ZXJzaW9uOg0KZ2l0IHZlcnNpb24gMi4zNy4zDQpjcHU6IHg4Nl82
NA0Kbm8gY29tbWl0IGFzc29jaWF0ZWQgd2l0aCB0aGlzIGJ1aWxkDQpzaXplb2YtbG9uZzogOA0K
c2l6ZW9mLXNpemVfdDogOA0Kc2hlbGwtcGF0aDogL2Jpbi9zaA0KdW5hbWU6IExpbnV4IDQuMTUu
MC0xOTMtZ2VuZXJpYyAjMjA0LVVidW50dSBTTVAgRnJpIEF1ZyAyNiAxOToyMDoyMSBVVEMgMjAy
MiB4ODZfNjQNCmNvbXBpbGVyIGluZm86IGdudWM6IDcuNQ0KbGliYyBpbmZvOiBnbGliYzogMi4y
Nw0KJFNIRUxMICh0eXBpY2FsbHksIGludGVyYWN0aXZlIHNoZWxsKTogL2Jpbi9iYXNoDQoNCg0K
W0VuYWJsZWQgSG9va3NdDQoNCkJlc3QgcmVnYXJkcw0KQ29yZCBMaW5kZWtlDQpTci4gU29mdHdh
cmUgU3BlY2lhbGlzdA0KY29yZC5saW5kZWtlQHNvZnR3YXJlYWcuY29tDQpTb2Z0d2FyZSBBRywg
VWhsYW5kc3RyYXNzZSAxMiwgNjQyOTcgRGFybXN0YWR0LCBHZXJtYW55DQoNCg0KDQoNCg0KDQoN
Cg0KDQoNCg0KDQoNCg0KDQpTb2Z0d2FyZSBBRyDigJMgU2l0ei9SZWdpc3RlcmVkIG9mZmljZTog
VWhsYW5kc3RyYcOfZSAxMiwgNjQyOTcgRGFybXN0YWR0LCBHZXJtYW55IOKAkyBSZWdpc3Rlcmdl
cmljaHQvQ29tbWVyY2lhbCByZWdpc3RlcjogRGFybXN0YWR0IEhSQiAxNTYyIC0gVm9yc3RhbmQv
TWFuYWdlbWVudCBCb2FyZDogU2FuamF5IEJyYWhtYXdhciAoVm9yc2l0emVuZGVyL0NoYWlybWFu
KSwgRHIuIEVsa2UgRnJhbmssIERyLiBNYXR0aGlhcyBIZWlkZW4sIERyLiBTdGVmYW4gU2lnZywg
RHIuIEJlbm5vIFF1YWRlLCBKb3NodWEgSHVzayAtIEF1ZnNpY2h0c3JhdHN2b3JzaXR6ZW5kZXIv
Q2hhaXJtYW4gb2YgdGhlIFN1cGVydmlzb3J5IEJvYXJkOiBDaHJpc3RpYW4gTHVjYXMgLSBodHRw
czovL3d3dy5zb2Z0d2FyZWFnLmNvbQ0K
