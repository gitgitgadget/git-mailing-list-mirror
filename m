Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80274C6FA82
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 08:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiIVI5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 04:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiIVI5p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 04:57:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A048FD01E7
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 01:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyxWOmvqrSeh1Keq74RMQCCEkzY0xMCHnnTTJByamf0jvtZZF589d+1SmNlN9oF1KkLsikCuR6In5EeFBKscqjQUsIibrkkUFwOExciMarRUI25bmmqtkF1me5BGopvc3UksOocd8zHZQdMkfWkLukeMRHtTzi8XRwFgKxbMVsAcljCSAw1Orx032/u/6mYTaARVl4lKTtuW6SQCbtOW0X5P6z2o//HYQCrWetQIBuZgJEGy2tZahX3EJB+Iz9OXIRLqYhxWAQqyfZAx4GwosZgDTiDaxClDJzLS6A7VGvC/fViXnC/A3HKXpXEPHcL3xP57gSQOG8vW+1iwWMGwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMGFe6KkmuWldIKlWTW8w4VlXtLjomhiMdiqF9Y0u/U=;
 b=k9WNeYV3Q7nq1y9905kHm2Ta+gjRFDlMcc3HuN8g/GgrpbwG3TR8Bf6zh/kqC8Fo/RST4VwpVZNyqEwIFqNQ1lbotzgT/yknvK86YLMDGPmgA5LXQLfY2Xj9foBnQxsqLJWR3bs6kleoxWOWl8JwfGedFLIVlaqjTOWkxlsIpVRCEDGx4ymmUYY1hNZ7hYIgeSb4C3d8U+fN3ZcI79HSgpVsbQ6k/6EOrExuStpIFOsd0AAmEWftgTR97nvQsfQmLMoRk2J5lxD4KX//P05U4Wjcb/CxHpk8IlIRMzeV1PVTMqCLV7wm7b/J0SFgMI9EE+lsadmwAdfguzJj+zZFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMGFe6KkmuWldIKlWTW8w4VlXtLjomhiMdiqF9Y0u/U=;
 b=Kk6eXGPvyM7t25GXezzNOaXuWlRLzcdubxkMXHnCUi7oqeqDDB7pb7qnaF6vbs+xFvVERj4P/GTeXQSMaa15ehi8O2CuiA/6SzEaEnSrY0wXUXpL/Ki81vf+FHlK5y2bNdV4jV+2PCnm4417b6xZYyYF6i9ezm8ZYVZdABykafHnLpuqxbm1ZZuWWYHtyCbYR1Zo86bDd3LBmN0AKzi5hq+Y5xvfGzNTewksTYlChxCqMUwdVF3NaupgEIgwgn1cVsXz3Vp0czRex5yEvy9XLhp548Bvlx9nks45pE2ftCMs/ZxKL+GVIKhCMFk5V49pwu6232YLrhZSzOaKDoCZeQ==
Received: from BYAPR06MB5542.namprd06.prod.outlook.com (2603:10b6:a03:df::11)
 by PH0PR06MB7591.namprd06.prod.outlook.com (2603:10b6:510:58::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 08:57:41 +0000
Received: from PH0PR06MB7639.namprd06.prod.outlook.com (2603:10b6:510:4e::18)
 by BYAPR06MB5542.namprd06.prod.outlook.com (2603:10b6:a03:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Thu, 22 Sep
 2022 08:57:10 +0000
Received: from PH0PR06MB7639.namprd06.prod.outlook.com
 ([fe80::b8e8:9340:e9ea:7f18]) by PH0PR06MB7639.namprd06.prod.outlook.com
 ([fe80::b8e8:9340:e9ea:7f18%8]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 08:57:10 +0000
From:   "Scheffenegger, Richard" <Richard.Scheffenegger@netapp.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git --archive
Thread-Topic: git --archive
Thread-Index: AdjOYUggigRgkiEITWKCyoo+Qa1cmQ==
Date:   Thu, 22 Sep 2022 08:57:10 +0000
Message-ID: <PH0PR06MB763962EB6321F85803C5CE2D864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.600.2
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR06MB7639:EE_|BYAPR06MB5542:EE_|PH0PR06MB7591:EE_
x-ms-office365-filtering-correlation-id: 854d98e0-8a90-4e5e-ea04-08da9c786f70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HZ7PnDEy668aWqYOl/KFFLqE+cRKqYZ02rCVRf8xRnRND+2jkWF4Djh9WmoeDiusbk/IqBmED/7c5SWTXJD041aOFTBW+5pXd86E0IyrKS++zSP8CIb0pKIg7b+6h+g9jacO7v1UeqYQ9jN0KDCt5dBEG0ElXM62EGP0DO6B9kC2gvl9vS1KwR5MjqQTkepKNqgty0d4xnQKrtJ0xm353cpsOkGEKqAv6qbEYDrpVCFCjibAqCAQJZ/HvnA7xYoXT0/Stq8e40DDPKExJI9JOMUdED7IJQ+Y34YLY2BubW68QmnkoknQ5yIjLUwcBhttNig1nOCfbH2NdozKH/OSlSSh7jhFHebe/piwiZgPR0XeL3e8vmNTbMrZJvzbBAzjs5i+JZCVPnOGMpqVSE684aXdmsOCtN4+Z2l4unIv8JzojbhvmmcjlL4mdhNxIWK74p0TXR/VfKGhL37MkybBizaR3jquwXkkUwiqeq9kdIKYDpspvjoJjyebvvsZXDxg3w0bcDjbDb1GK2PDC0kOSzFW0uBwj9jXqU24JI0n1GHyg9V+RIwSBMiFNw+kAG2y5C83SI+S423jCy7dNWPYZFljcLxs3m5wIQgnjLl7aRwcGPonenXGC20TskZvhcRz2vpisiUdLdAv6nWrNr9xTX2zoGzjPrhndcDwkT5+o1fqk9cWPczFf8yaKVouKFsE1SoU5oTGDWWPzG8kb6TcCHiZesT0H8iXx/mqb5hjDCOgSIje6s+ZSV7gt+AGqrWlq65wr+dqq7Ooud0v6Ddp6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB5542.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199015)(55016003)(2906002)(66556008)(122000001)(66476007)(8676002)(38100700002)(66446008)(26005)(316002)(66946007)(33656002)(52536014)(5660300002)(6916009)(83380400001)(86362001)(76116006)(186003)(9686003)(38070700005)(478600001)(6506007)(64756008)(8936002)(71200400001)(7696005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHNtck9wYVByZ3Z0NlRscHF4UnA5UEo1M3JPQU0yNkhGa3JkVEp6eFRwUlN0?=
 =?utf-8?B?UHJpbWhIZTliNEpFSVNJeWozOVlDZ1JQTk5VTTV1b25sZ2tPWVlBSmhjUlVa?=
 =?utf-8?B?RC84Nno4T0pjWm5uTXUxMlNreXR4QnVrMVgwR0Y3UjY1bjhBVEh2YmQyNjhX?=
 =?utf-8?B?ZFFKem5LdW14Y3YrRXBCczFMYzhPMkFxNU1KR1JPNVlZaFZGbm9ZTGFtUVFZ?=
 =?utf-8?B?VXIrMG1PMnEzemwvdWVQUmd5MXF1ZFRTbmw5TldkTmxjd2VKTi9OYU02azlL?=
 =?utf-8?B?aGlNUmZuc2pWSU9nVG5LY0N3N01UZHZvL2tWc1NUZURMUjRFajRKN3Qra3h3?=
 =?utf-8?B?NzliOEFZbXZLMWxrcDFJTzNEZm5Pc0duRG1GVkdhNWN6WHNCOGdlOEZTZ05y?=
 =?utf-8?B?dVNiNVEyQWNOc1Q0WXBWR2ovZFRrcjM1MHRnbE4yakluN0F3UG81T1ZuT3NT?=
 =?utf-8?B?SFkxQW9nMFZVY1J6QmtaNFI0cjJZSmdSbzMxQ2pBbU1jYklOLzI0b2ZPZTdl?=
 =?utf-8?B?MjdMc2gxbFo3K3lHMWRpcmJlUGJ0Q3hwNXJvVHFNZFFkMTRoU3FnVjAxdk8y?=
 =?utf-8?B?NWxwak5neWJ0aUIwUlZvVUQ5azVwdE5Sd3JMbmZrMGdVcERSZ3hwcHgzMDFM?=
 =?utf-8?B?SEtJY1BOTUQ2Q0RGV3NmQ2gxNlNaNzdpQ2tPUm1uZG9TeER6dkl4eFd6VGYr?=
 =?utf-8?B?WEJaNGR4ZUhuSWZqVGRPZXUxOEY3VHRJQ1cxZU8vZkdFOVc5Y0tkK2FwZFF5?=
 =?utf-8?B?OEhOdHFZeEtvVnByZVpKVWUxR1dwYVI0SGNKWEp0RC9IMmZVbENlbXR0Qno5?=
 =?utf-8?B?Wi9WK2h6VEtxRnBFeWM3cjg2R2RUd25DWFZLMklnRXdQUGdHSnBqU3JLNVgw?=
 =?utf-8?B?OUNxQmxlMUNrQm83d0JuUGZpY2syM2RnQmZXMDRZd2VQUXEwa2N6dHA0N0hE?=
 =?utf-8?B?M2JQY0xSMjUxajk3ZUV0ZEJ5NzBJN2wybENXY0k4SS9ZaW5EcklMbGJNTTJR?=
 =?utf-8?B?KzhES0VRN0dQaVNqd2ZydGxMTmg4SlpDSHBUZElWajcveVlvVTNvRHBOQTIy?=
 =?utf-8?B?enk1OVllc28yNmw4SUpoa1I1c2tpLzN4cTZWd3JDQWRHcFgzM2E4ZktINWY2?=
 =?utf-8?B?dHRac3VpWWJ1Sk52bFQzRGM1Y3R6Wm1lZ0Rpa0ltaE5scWtqUlVFc0dabzM5?=
 =?utf-8?B?MnBKSldxSzhRZHpFTEhydlcrWFY0Qm40a3ZCQmVEb0k4cHpVSCtiZ2FuU3lx?=
 =?utf-8?B?VnUveWFTbmlRSEQ4ZStmV3loOU05N2hXNjlsOXc3d0JMbWt1eGZHRlpDSERN?=
 =?utf-8?B?Q0M1eURiU1hZR1d3NExSdWFFSnNMaWZ2WWt4UTBXK2JBNWdEc3VzN1A4c0Rv?=
 =?utf-8?B?d0ZEVzJXNTRpZSs2bW10NlY3bGdPOFpsNFd4aWF1MzdZQ1NTN0VJYXBleFJw?=
 =?utf-8?B?QmtMYjdUT0YwelZDY0dicnN2Y0VocVQ5NXJlVXJtRE4rM1lNY2tNN0FwYWxs?=
 =?utf-8?B?UUM2K0NWeXRlTmtwcElpdVJlYm16OXBzODFIeDFvQVJoZEkvKzhYaWptdDN0?=
 =?utf-8?B?c1d1Z2wrMk5vMVM2WnhRZTNkd2Y0MnlndG5IbW1xUDRNR25tZ0YwdEZYdmNm?=
 =?utf-8?B?UmN0NjNlZGdjNXdTMUlDaHFROE9CWWFtNFlBZUd6N201RmJVRHkzZG1WYlc4?=
 =?utf-8?B?cUN2b1RNSkJaKzhrT1NpdWhVQmRwYWZwY2NTKzRHWm9OVlZlM2p2d1JCVGVX?=
 =?utf-8?B?c0I4SmU2UVZlaU41YVBaNDh4Y1hVN3JkVVMwRmhZSSt0ZjYyTlQzY0pmNk15?=
 =?utf-8?B?elVDS2dqc1pneWdCbGxJS3Z6b2ljNlVWOVNJVE5IbllMY0NqdG11NXBNSEc2?=
 =?utf-8?B?MUVSeVhBdEJTUWFGUFRFZUFLSGZOSnVub0xQT29YSDVRcEFmR3hJREszcVVJ?=
 =?utf-8?B?SXRYUDF3VGZMYWdKTG5aKzZvT0lsRmRsUDVHamJ3bVNRaENQOVpRU2tLQ3Az?=
 =?utf-8?B?T1RTMmVONTB2RTRjaThaOFdVQlZhc1JUUEQ3YUVaWG84VzY2MlRkajJnUFUy?=
 =?utf-8?B?TllWZmRJNUV4UWcxYjJvS1JpV2pDdnhQRG5wNWh2MXo0eVlRS3hRSmJRNnZx?=
 =?utf-8?Q?Deod8irPH/sjF5ag1aBUYATmp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR06MB7639.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854d98e0-8a90-4e5e-ea04-08da9c786f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 08:57:10.5401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WGBc16SaoyBs4eNgMOLDU0Vs3aHGTLTAoWUa6munURo8IBIh61v+JLCeTxeC/i3Af7Jy8K2JI39zoKJxo9MpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR06MB7591
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgZ3JvdXAsDQoNClVubGVzcyBJ4oCZbSBtaXN0YWtlbiwgdGhlIHByb2NlZHVyZSB0byBjcmVh
dGUgYSB6aXAgYXJjaGl2ZSByZWFkcyBsaWtlIGEgcmVjdXJzaXZlIGNvbGxlY3Rpb24gb2YgYWxs
IHJlbGV2YW50IG9iamVjdHMsIGFuZCB0aGVuIHdyaXRpbmcgdGhlbSBvdXQgc2VxdWVudGlhbGx5
LCBpbiBhIHNpbmdsZSB0aHJlYWQuIA0KDQpJcyB0aGlzIGFzc2Vzc21lbnQgY29ycmVjdD8NCg0K
SSB3YXMgd29uZGVyaW5nIGlmIGEgaGlnaGx5IGNvbmN1cnJlbnQgZmV0Y2hpbmcgcGhhc2UgY291
bGQgYmUgb3B0aW9uYWxseSBhZGRlZOKApg0KDQpCYWNrZ3JvdW5kIGlzIHRoZSBwcm9saWZlcmF0
aW9uIG9mIGNvbGQgYXJjaGl2ZSAvIGhpZ2ggbGF0ZW5jeSBzdG9yYWdlIOKAkyB0cmF2ZXJzaW5n
IGEgdHJlZSBpbiBhIHJlY3Vyc2l2ZSBtYW5uZXIsIHNpbmdsZSB0aHJlYWRlZCwgd2lsbCBhY2N1
bXVsYXRlIHRoZSBtYXhpbXVtIGFtb3VudCBvZiB3YWxsY2xvY2sgdGltZTsgDQoNCkEgZmlyc3Qg
aW1wcm92ZW1lbnQgY291bGQgYmUgdG8gcnVuIGFsbCB0aGUgcmVjdXJzaXZlIHRyYXZlcnNhbHMg
aW4gYSBwYXJhbGxlbCAobXVsdGkgdGhyZWFkZWQpIHdheSDigJMgd2l0aCBkaXNwYXRjaGVkIHRo
cmVhZHMgdG8gaXNzdWUgcHJlZmV0Y2ggcmVhZCBjYWxscyAodG8gd2FybSB1cCB0aGUgdmFyaW91
cyBjYWNoZXMpLiBBbmQgaW4gYSBzZWNvbmQgcGhhc2UgdHJhdmVyc2UgdGhlIChub3cgd2FybWVk
IHVwKSB0cmVlIHNpbmdsZS10aHJlYWRlZCwgYW5kIGFwcGVuZCB0aGUgb2JqZWN0cyB0byB0aGUg
YXJjaGl2ZeKApg0KDQpTdWJzZXF1ZW50bHksIGlmIHN1ZmZpY2llbnQgbWVtb3J5IGNhbiBiZSBh
bGxvY2F0ZWQsIHRoZSBhc3luY2hyb25vdXNseSBkaXNwYXRjaGVkIHJlYWRzIGNvdWxkIGJlIGZl
dGNoZWQgaW4gbWVtb3J5LCBhbmQgYXMgc29vbiBhcyB0aGUgcmVhZHMgZm9yIHRoZSBuZXh0IGlu
LW9yZGVyIG9iamVjdCBpcyBjb21wbGV0ZWQgKHRoZXNlIHJlYWRzIGluZGl2aWR1YWxseSBtYXkg
bm90IGNvbXBsZXRlIGluLW9yZGVyKSwgYXBwZW5kIHRoZSBvYmplY3RzIHRvIHRoZSBhcmNoaXZl
4oCmIA0KDQpCZXN0IHJlZ2FyZHMsDQoNClJpY2hhcmQgU2NoZWZmZW5lZ2dlcg0KDQo=
