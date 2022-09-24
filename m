Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E671BC07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 11:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiIXLfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 07:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiIXLfD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 07:35:03 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2076.outbound.protection.outlook.com [40.107.96.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FD79F8E6
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 04:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lpb44S6eGt7Q1Ksi92kGMeFCSlgN1DvJz+DYNmilPOHltRVwsb6li6LYz8A1dQPaOrmJPIRlU5/GsKqDplV+v/UP0sr2Q5sn0mlroAaLnTc250tNHEqv0SbBFgAqBynuPkZhH9csShYmfrcB9sGNx6HQ1NUl40A6o/8zD1SIukQU+oqPH61eVSAUVF5r4cdHL1tFj+X8yImkOQAZYS0y0U1/x5U7KhrA5OGr4RFHSzLMO9+viDbVov51CHgT4zcMk7M8W+WPpL/H0GDKrI+2bjwmRF+bg9tAV6I8ZYRyhqzyAa9GOvkp2hCnTKiKWq6ZAwfqZrPEcAX5ojvcV+Pk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xRsddr3bPT7rdvH4UMiaiKq4vC9hZlMfFDcimrlTwM=;
 b=SusT++yG6rFc3d+/4fWHkxTPwV4EhlqzslJewLBarEgeCgHneiaW77gGMPwH2IlG2jI1s5FVt6TCng+Gb7mynfzPO+ZEp+987DoSjScGaGc+vV4xVFFE3ttWBt5KZNmgO3ohB7Qxu2puN7gndr9fPs1bIuBpYPMswz3Vdk8Uel7/7pYzeP9by195wAiVuH+l72ODZmPwJWmfW1o768LhEidCpHTNpVZh9PioZg+NEcPIcaVGOpuYxMnThxktEsIV+pWgBodcG+6f4FPRihlP44KBDj/6pzzwmDCUeUedQBZPsyrUmJdM8k1oI+r+VJ9+tobOksdFT9j+acOqgz8P4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xRsddr3bPT7rdvH4UMiaiKq4vC9hZlMfFDcimrlTwM=;
 b=oijcENxgSMbuEQB/fg4pva/xRwtG05rKTs5TJzmVq3hAySdb2SM0bnxJweO153w+swR6o1inwqURof3qDiN5mrmyzqkUT6m3vbDeGNawDjJkEy7oe26ZfYJQDpKU06Nz+4bimnXME9aMEVgPSa8JVPFNqEWM1PeZ582wk0t/bQZu4g3YEL8Qfq3+eWW0fVraeRnx2SIgo/x7ASETIk3fK+H+nefbL4uiyb3aAxvuj4P7nKY2OPuN7tFoSJziv0kfq8yEIaBDzSxsOWiBHZq6xw0134wAug9JBQ7TwbpR2I0EP+pqvQb4b94NOZ+cJ09lWBxyPQ3/UnVOO98EK8WOqg==
Received: from PH0PR06MB7639.namprd06.prod.outlook.com (2603:10b6:510:4e::18)
 by PH0PR06MB7541.namprd06.prod.outlook.com (2603:10b6:510:5d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Sat, 24 Sep
 2022 11:34:58 +0000
Received: from PH0PR06MB7639.namprd06.prod.outlook.com
 ([fe80::b8e8:9340:e9ea:7f18]) by PH0PR06MB7639.namprd06.prod.outlook.com
 ([fe80::b8e8:9340:e9ea:7f18%8]) with mapi id 15.20.5654.022; Sat, 24 Sep 2022
 11:34:57 +0000
From:   "Scheffenegger, Richard" <Richard.Scheffenegger@netapp.com>
To:     =?utf-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git --archive
Thread-Topic: git --archive
Thread-Index: AdjOYUggigRgkiEITWKCyoo+Qa1cmQAXoZumAAAHifAACZc6AAAg48+QACJ71oAABKMwwA==
Date:   Sat, 24 Sep 2022 11:34:57 +0000
Message-ID: <PH0PR06MB7639DAA5CA112495E3EB43AB86509@PH0PR06MB7639.namprd06.prod.outlook.com>
References: <PH0PR06MB763962EB6321F85803C5CE2D864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
 <xmqqleqbxj4h.fsf@gitster.g>
 <PH0PR06MB7639720FB3A1611F4C96E52C864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
 <Yy0ChPPqZUwVFyAt@tapette.crustytoothpaste.net> <xmqqedw2vysc.fsf@gitster.g>
 <8eb5131e-5ae1-79bd-df0c-bf0b2ec8583f@web.de>
In-Reply-To: <8eb5131e-5ae1-79bd-df0c-bf0b2ec8583f@web.de>
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
x-ms-traffictypediagnostic: PH0PR06MB7639:EE_|PH0PR06MB7541:EE_
x-ms-office365-filtering-correlation-id: e69d0f72-1b43-46bd-0ea1-08da9e20cf22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xq5ORJetQ2IdNmaeEeJlLg7FMH+z0dRsiKQRSFd+EkkRadHSba2tF1mDKyM3BEYknwd1DXudxrggqUNhG3/t6wXCIm83hgIqzpUxOmjvLtNKFFAgLLCjBHkae/hNFvSg9p/hBvocMFdKcm2xf73rgvxpLODrmKoJLJTDnFMFlUjoPSkOwpV6UR5JlaDbG0DH+srqj3gYCpAI57unT/q3knctd8S3Q+kSqqo0PEU1MDpJE/AbQlYTIAnehBTvk/YkRATEMuot9QUZ9uTJa1YzgObvQEDJjjk66a1mZWbE6TUMTde3BJJQ7tdO6B9GVq+/iW/tLaUdFU7Qvarg5zOz+FXAzR99e2q1ncKmSj/vxZe7uA7rMKWFi/vPnLvJT4yBOwaH14lWeUNTJ2nDRML64m1DpoxjV8BNjKdqReqiOztYrwgzg1TPd53FbfhSIcANspBUzVR1/qdugW3VLXj37nS9HBA0mDQfuGLjsXflejWF22WwubSVdTUq1LP+bzEQpQPtlzYpeYyvfH20ER1tiIQM473Nnr+I81h3E4E1JJagaBXOIGf1b5djo1CSliRGfmfAya+Adfd+0Cfne42vAzpfdkQ/inTauwScfq2ONnSPb4aGkBVdiZZ/Gz82cUMBoey93DG+UgU2UlNeMrUh2YmO8sjo567tWW2G0bHrR4QbNMPQ1fSZp9mw0mCS03QgAL4pAkXszD7XmAxNW0z0PMd/m9f+GpSl9JqPNXXXZ/+HKJlPTt3W5K/orujvAHjuvi1kUwR+B0xKP8I8/VxasQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR06MB7639.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199015)(2906002)(478600001)(9686003)(110136005)(33656002)(71200400001)(122000001)(83380400001)(55016003)(26005)(38100700002)(86362001)(316002)(52536014)(66946007)(8936002)(41300700001)(5660300002)(186003)(4326008)(66446008)(66476007)(64756008)(8676002)(76116006)(38070700005)(66556008)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djRyMms5ZkE0NjhJVGw2WXdkVVh5VVBUVzV5VEVzeXAyQytKK2lvTDF0Mzc3?=
 =?utf-8?B?T24rTWUyeTZwajcwNlFVdVB2b1IzUDVnWGlOZHM1Z0JWNURxd2I2dEErM1pQ?=
 =?utf-8?B?YTBUWkRYVGRNREZzN3dkQkdrbHEwMVY0bXlmeGgwSHNHZ0tXV01KS0NDTW1k?=
 =?utf-8?B?eDlmdnp5UmwyOUl3bXVmb1RKaEN5SHM4V3JTWnIzbGF3SEd3V2xvMDlGeXNy?=
 =?utf-8?B?WUtYUWgzREhIWVVYWllOU3hreUxINUE3OFlNa3V0MXVWZXdHY3lmbWRYL3M0?=
 =?utf-8?B?MEFEYytlTGdYSS9KOTVuMlJsKzRrRUVNQXcyeG0vRG5RRWp2Q0IreHlZc3RP?=
 =?utf-8?B?S2dUekNsemRySEF5THZjSU92cUNlNzNJMGpkSWxZZTJiOFRrR1Fsci9aeWdp?=
 =?utf-8?B?RkFrWnMzY243a29YK3hqbmhKSmdRd1JlSzhNcWlwS3hNVWhnN2xKMXpqMEkv?=
 =?utf-8?B?OW4ycEtlWWJsZzFXUzAvSytKOWVnVGFVMGhFODR3OGsrV3NSbTlWL2tyK0ZW?=
 =?utf-8?B?WmlsZWl1VC9tOWl5ODVVYzBoMng5VzBLYnJ4YmlRR0U4bU5qcnhnYmxjMnpC?=
 =?utf-8?B?aUFOdG94T3gyT25rRWhnQ3F2TmtweGRSTVJ4OWVqSGRRVVJtWFNXU3pxY2Va?=
 =?utf-8?B?RHBJTDNtNVhSTjlrMmZ0SkJweUNrQUF3dDZ6dHhOYXErTkhTcS9EbW44cHg4?=
 =?utf-8?B?ZDRGNThIcFh2UEhJSkxlUjlIZ0F6cUxtblExRnpYbmtSUWNjYnBvTmlTYWlt?=
 =?utf-8?B?TFNEMkVidTVFSThvWi8zb3VEeGwrdGszdkV0a2V6c1BxRnhueDVwNHhieFQz?=
 =?utf-8?B?VVl2YWVPWTEzc2xIZVppUW9WRlowZmluMnBZWXpteXd4VVh0NnhadnlvYnkz?=
 =?utf-8?B?Sit3OEJsV1dWamxLKzlTRzRuNkpDeXFZc1VBZEllckRXV2hpVHdtcFZDMGNu?=
 =?utf-8?B?ZDdETGM1bDlNdkRkSlhlR2pQT2Jab2w4N2tYS3FkN2U3cDZWcEpiLytnNXRH?=
 =?utf-8?B?eFRvMndLckQ0SktCWDF2UmI3UmRJeTE3UTJjUjRKcmxubXpnYzUzRmhBeVds?=
 =?utf-8?B?NjN2QmVlNFBkZGlVM3RWQWlUY2RkM3psL1p2cGtvWDY1am8zby9DcDd6MEZS?=
 =?utf-8?B?TDhyV25CRDVWdEt1OGljOVQzSFNVeHRKOU8rUE5haHdOMDZCVGk5U0JYVlVL?=
 =?utf-8?B?T043OGc1Y0RITUJNRjJ0QmVVWG9JR202bTdzSGcwVGE5RitFTUFKQ1RSODhY?=
 =?utf-8?B?TE9jRndMS25SbmFyVHk3dGdFN2hJbmtaazF2a1pOL2pHSGhoc1pQUVh6QWJM?=
 =?utf-8?B?bHQ2VTZIUkJnWDlwckhxdDJHdmRSMCtBOEFObjdWc3BrSE1BY293bmgweXRP?=
 =?utf-8?B?V0I0ZjhzeEFadkREbW5ydEw3eVZwMlorR0c5V0tzOWNKcnU3aDZnemJVNDVI?=
 =?utf-8?B?ZkhERVF3cy9EZFMzZUdzMDQ3bDZVT2RVb2hocER5dDc0N1lGL21uS245TXdk?=
 =?utf-8?B?VitkZGlDcWxWVEowdUtXU3JobjUxWXFTTTB5R0pQZW5jWmd5ZURaRmhETTQx?=
 =?utf-8?B?MWxQbm0xNG5OUzAwQk9mZ1ZVTFpLK3B1RzcyK3RGRjdvZ0dYblFqbFBDK09F?=
 =?utf-8?B?bkROR2phanBMWlhHSUlsc0EvbU1vY2k1dEF6eko4czlveFdGb3Z1bXRkT09W?=
 =?utf-8?B?d0RNK29ZYTMwaHVhc1J2ak9MeG9JMWJ1QmtyTE11bUZrS2RQM0VyZ3BpV2pE?=
 =?utf-8?B?YWdHUTVMYnR2K0VvK1FSK014SWRuNS9VYm03ODB6MitKVEF4VGx4RkpYdjhC?=
 =?utf-8?B?QTVOV0Fmak4xd2V5VlNGM2d5RkU0eGU3blE3K0pxQUJIemFsNE9rb2gzcEhS?=
 =?utf-8?B?L3JkRC9vMlNUUCtaYWIzUk1hL0dRbmdMSHV6ZWloR2pmcm4zQ3R6aDl3QXNC?=
 =?utf-8?B?NVhWVGZOQjQxalNxWmxMRVBnUTFrMmJucjIzb1NBUVg5T0dhdEpmWVF3K3l3?=
 =?utf-8?B?eTBwKytTNGlWVlNhcUU5YWJUQkRhbUwyOWxHWjl6eXFFcjJTeGt4YVNiM0Er?=
 =?utf-8?B?emJMSWpVbWJONHhEZG1nU0srOUpRdHdmU0N1TGxTck1wWkJsNHQ5bDFJdHow?=
 =?utf-8?Q?9sNwO7k8cOJ756w+b644Uz9+9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR06MB7639.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e69d0f72-1b43-46bd-0ea1-08da9e20cf22
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2022 11:34:57.7291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9Y/ArszHIRF8MyyVNYYykGXmzjhYnhmeWtGmEICh9nl21fa+ebXl/1+o6CPWagvGo2OIJOHkIUnwKRpc3Ay5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR06MB7541
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgUmVuZSwNCg0KPiAgZ2l0IGFyY2hpdmUgY29tcHJlc3NlcyBhIHNtYWxsIGZpbGUgYnkgcmVh
ZGluZyBpdCBmdWxseSBhbmQgd3JpdGluZyB0aGUgcmVzdWx0IGluIG9uZSBnby4gIEl0IHN0cmVh
bXMgYmlnIGZpbGVzLCB0aG91Z2gsIGkuZS4gcmVhZHMsIGNvbXByZXNzZXMgYW5kIHdyaXRlcyB0
aGVtIGluIHNtYWxsIHBpZWNlcy4gIFRoYXQgd29uJ3Qgd29yayBhcyBlYXNpbHkgaWYgbXVsdGlw
bGUgZmlsZXMgYXJlIGNvbXByZXNzZWQgaW4gcGFyYWxsZWwuDQoNClRoZSBhc2sgd2FzIG5vdCB0
byBwYXJhbGxlbGl6ZSB0aGUgY29tcHJlc3Npb24gc3RlcCAoc2NhbGUgQ1BVIGVmZmljaWVuY3kg
bG9jYWxseSksIGJ1dCB0byBoZWF0IHVwIHRoZSAqcmVtb3RlIGZpbGVzeXN0ZW0qIG1ldGFkYXRh
IGFuZCBkYXRhIGNhY2hlcyBieSBtYXNzaXZlIHBhcmFsbGVsL211bHRpdGhyZWFkZWQgcmVhZHMg
KGlmIG9uZSBzbyBkZXNpcmVzKSwgaW4gb3JkZXIgZm9yIHRoZSBzdHJpY3R5IHNlcXVlbnRpYWws
IG9uZS1hZnRlci1hbm90aGVyIGV4aXN0aW5nIGFyY2hpdmluZyBzdGVwcyB0byBjb21wbGV0ZSBm
YXN0ZXIuDQoNCj4gR2l2aW5nIHVwIG9uIGRldGVybWluaXN0aWMgb3JkZXIgd291bGQgcmVkdWNl
IHRoZSBtZW1vcnkgdXNhZ2UgZm9yIGtlZXBpbmcgY29tcHJlc3NlZCBzbWFsbCBmaWxlcy4gIA0K
DQpUaGF0IHdhcyBqdXN0IG9uZSBpZGVhLiBSZXRhaW5pbmcgYSBkZXRlcm1pbmlzdGljIG9yZGVy
IHRvIGhhdmUgc3RhYmxlIHNlY3VyZSBoYXNoZXMgb2YgdGhlIHJlc3VsdGluZyBmaWxlcyBpcyBh
IHZhbHVhYmxlIHByb3BlcnR5Lg0KDQo+IFRoYXQgb25seSBtYXR0ZXJzIGlmIHRoZSBwcm9kdWN0
IG9mIGNvcmUuYmlnRmlsZVRocmVzaG9sZCAoZGVmYXVsdCB2YWx1ZSA1MTIgTUIsIHRoZSBudW1i
ZXIgb2YgcGFyYWxsZWwgdGhyZWFkcyBhbmQgdGhlIGNvbXByZT5zc2lvbiByYXRpbyBleGNlZWRz
IHRoZSBhdmFpbGFibGUgbWVtb3J5LiAgVGhlIHNhbWUgZWZmZWN0IGNvdWxkIGJlIGFjaGlldmVk
IGJ5IHVzaW5nIHRlbXBvcmFyeSBmaWxlcy4gIFdlJ2Qgc3RpbGwgaGF2ZSB0byBrZWVwIHVwIHRv
IGNvcmUuYmlnRmlsZVRocmVzaG9sZCB0aW1lcyB0aGUgbnVtYmVyIG9mIHRocmVhZHMgb2YgdW5j
b21wcmVzc2VkIGRhdGEgaW4gbWVtb3J5LCB0aG91Z2guDQoNCkFnYWluLCBub25lIG9mIHRoZSBk
YXRhIHJlYWQgZHVyaW5nIHRoZSBwcmVwYXJhdG9yeSwgaGlnaGx5IGNvbmN1cnJlbnQgc3RlcCB3
b3VsZCBuZWVkIHRvIGxpbmdlciBhcm91bmQgYW55d2hlcmUuIEp1c3QgaGVhdGluZyB1cCAqcmVt
b3RlKiBmaWxlc3lzdGVtIG1ldGFkYXRhIGFuZCBkYXRhIGNhY2hlcyBpcyBzdWZmaWNpZW50IHRv
IGRyYW1hdGljYWxseSByZWR1Y2UgYWNjZXNzIGFuZCByZWFkIGxhdGVuY3kgLSB3aGljaCBpcyB0
aGUgcHJpbWFyeSBkZXRlcm1pbmluZyBmYWN0b3Igb2YgaG93IGxvbmcgaXQgdGFrZXMgdG8gcHJl
cGFyZSBhbiBhcmNoaXZlIChlLmcgNTAwIHNlYyBmb3IgODBrIC8xLjMgR0IgdW5jb21wcmVzc2Vk
IC8gMjUwIE0gY29tcHJlc3NlZCBmaWxlcyB3aGVuIGRhdGEgcGFydGlhbGx5L21vc3RseSByZXNp
ZGVzIG9uIGNvbGQgc3RvcmFnZSkuDQoNCj4gSWYgSS9PIGxhdGVuY3kgaW5zdGVhZCBvZiBDUFUg
dXNhZ2UgaXMgdGhlIGxpbWl0aW5nIGZhY3RvciBhbmQgcHJlZmV0Y2hpbmcgd291bGQgaGVscCB0
aGVuIHN0YXJ0aW5nIGdpdCBncmVwIG9yIGdpdCBhcmNoaXZlIGluIHRoZSBiYWNrZ3JvdW5kIG1p
Z2h0IHdvcmsuICBJZiB0aGUgb3JkZXIgb2YgdmlzaXRlZCBibG9icyBuZWVkcyB0byBiZSByYW5k
b21pemVkIHRoZW4gcGVyaGFwcyBzb21ldGhpbmcgbGlrZSB0aGlzIHdvdWxkIGJlIGJldHRlcjoN
Cj4NCj4gICBnaXQgbHMtdHJlZSAtciBIRUFEIHwgYXdrICd7cHJpbnQgJDN9JyB8IHNvcnQgfCBn
aXQgY2F0LWZpbGUgLS1iYXRjaCA+L2Rldi9udWxsDQoNCklzbid0IHRoZSAybmQgZ2l0LCByZWNl
aXZpbmcgaW5wdXQgZnJvbSBzdGRpbiwgcnVubmluZyBzaW5nbGUtdGhyZWFkZWQ/DQoNCk1heWJl
DQoNCkdpdCBscy10cmVlIC1yIEhFQUQgfCBhd2sgJ3twcmludCAkM30nIHwgc29ydCB8IHNwbGl0
IC1kIC1sIDEwMCAtYSA0IC0gc3BsaXR0ZWQgOyBmb3IgaSBpbiAkKGxzIHNwbGl0dGVkPz8/Pykg
OyBkbyAiZ2l0IGNhdC1maWxlIC0tYmF0Y2ggPiAvZGV2L251bGwgJiI7IGRvbmU7IHJtIC1mIHNw
bGl0dGVkPz8/Pw0KDQpUbyBwYXJhbGxlbGl6ZSB0aGUgcmVhZGluZyBvZiB0aGUgb2JqZWN0cz8N
Cg0KT3RoZXJ3aXNlLCB0aGUgbWFpbiBwcm9ibGVtIG9mIGxhY2tpbmcgY29uY3VycmVuY3kgaW4g
cmVhZGluZyBpbiBhbGwgdGhlIG9iamVjdGVkIHdoaWxlIG1ldGFkYXRhL2RhdGEgY2FjaGVzIGFy
ZSBjb2xkIHdvdWxkIG9ubHkgbW92ZWQgZnJvbSB0aGUgYXJjaGl2ZSBzdGVwIHRvIHRoZSBjYXQt
ZmlsZSBzdGVwLCB3aGlsZSBvdmVyYWxsIGNvbXBsZXRpb24gd291bGQgbm90IGJlIGFueSBmYXN0
ZXIuIA0KDQo+IE5vIGlkZWEgaG93IHRvIHJhbmRvbWl6ZSB0aGUgb3JkZXIgb2YgdHJlZSBvYmpl
Y3QgdmlzaXRzLg0KDQpUbyBoZWF0IHVwIGRhdGEgY2FjaGVzLCB0aGUgb3JkZXIgb2Ygb2JqZWN0
cyB2aXNpdGVkIGlzIG5vdCByZWxldmFudCwgdGhlIG9yZGVyIG9yIElPcyBpc3N1ZWQgdG8gdGhl
IGFjdHVhbCBvYmplY3QgaXMgcmVsZXZhbnQuIFRyaXZpYWwgc2VxdWVudGlhbCByZWFkcyAoZnJv
bSBzdGFydCB0byBlbmQpIHR5cGljYWxseSBnZXQgbWFya2VkIGZvciBjYWNoZSBldmljaXRpb24g
YWZ0ZXIgaGF2aW5nIGJlZW4gZGVsaXZlcmVkIG9uY2UgdG8gdGhlIGNsaWVudCAtIHRoYXQgY2Fj
aGUgbWVtb3J5IGJlY29tZXMgYXZhaWxhYmxlIGZvciBpbW1lZGlhdGUgb3ZlcndyaXRlLiBUbyBp
bmNyZWFzZSB0aGVpciAic3RpY2tpbmVzcyIgaW4gY2FjaGVzLCB0aGUgb2JqZWN0IHJlYWRzIHdv
dWxkIG5lZWQgdG8gYmUgcGVyZm9ybWVkIGluIGEgcHNldWRvLXJhbmRvbSBmYXNoaW9uLCBlLmcu
IGlmIHRoZSBJTyBibG9jayBzaXplIGlzIDFNQiwgYWNjZXNzaW5nIGJsb2NrcyBpbiBpbiBhbiBv
cmRlciBsaWtlIDEwLDEsOSw0LDcsMyw4LDIsNiw1IHdvdWxkIGhhdmUgdGhlbSBtYXJrZWQgZm9y
IGxvbmdlciBjYWNoZSByZXRlbnRpb24gKGluIHJlbW90ZSBmaWxlc3lzdGVtIHNlcnZlcnMpLg0K
DQpSaWNoYXJkDQoNCg==
