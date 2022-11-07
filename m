Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B12C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 14:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiKGOxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 09:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiKGOxv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 09:53:51 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2048.outbound.protection.outlook.com [40.92.52.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF5813D3A
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 06:53:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCOJ+NlQA+zd/m4Wp5Lc8UPuPplUMwHG3qZ4D3Ni+npa/QnJzlim3MkD47spWBnj7ks5CF0xOVstTBIkPSZgo5QCTU50tzAG0q90ogb307QmFexa8CcMYbBrLtYD1T3XapobYVyACDm1fE5YjV3t0aJ4JAVQ6DKyWnGMtdLYBcWq6s2yFmdLcv+eNBpceohIqwO6rxkmjbU0O86ZbGJhOXNwfLfblo56oPCdXlaW9oqPOrfUOoqrchrWtUl+u+Ionq2ua3PQ6bK4DEiMo2EIatkIbW5KSadDtszq7a1v6YFNoTH+yIxxcoM2V84dIYZIw7XvzzMTcKtIU4rQEI9kng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsaH4M9FQOlXErJIBZz904uSDs4SYBkP0oc9Yb+XR9E=;
 b=grUqbzxGoS/IuVjsf5M4/+rsR8QE7vvhEgfrxawzqHZUh4AzfTlrL/RLZz03mJ0CZjTlWdNot19V4rkSCPA5RPJTUo8D1w808n6AiG0nA7garzGaANSBz+adqdx9NYx6aRBmSBnol9kHFL0llaFrFPHh9BHIs3HYuBr8KoOzEdpq+vLcoCBdSiGyVyuO7Zlyw0LHhnU4Te9BlaBogh9ENLBtkvpZvT0iG9yB5QgI8MpFiGxXv3nHitVkYsUZHkWqskqSOCiR44OPaaFPYaC6lPxdVMtu1NxiJH7rZBWUjhRL+vtqDG1Pw1j+2Dm/srMh3N8u7pgCmn0PRxUuVseL1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsaH4M9FQOlXErJIBZz904uSDs4SYBkP0oc9Yb+XR9E=;
 b=rqMEwyVZITkV5gJc/gJv+LnWx2iz3Qy+gCbElfGqEmbU8yiHa3wNjUZxWqmktOeUHh6vYCcGy3BoCsjg/cYNchn9vJzZdurJO9Z98i5Oa215vHRhsAQQJTijEkWGgEh7Li+T5sA/8qukSl1n38+Q18RCwf7hryiP1m4kJTu//eku1nEDPowpfSNHvz2q4Q5FAJJQLvadteltCTJpZgV1WroEyP7FMig1eTDV38Vt4i9unXSLtAaLbJ8LjrR9R+gnx3zkIwncNh34pju5HBUgbBemPZwP22eRqEewozF7jqp+QPfiflK7W2EaCsDm9tyxLk5IcIZd9D7qk6k4hZ0cqw==
Received: from PSBPR01MB3541.apcprd01.prod.exchangelabs.com
 (2603:1096:301:d::14) by SEYPR01MB5291.apcprd01.prod.exchangelabs.com
 (2603:1096:101:dc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Mon, 7 Nov
 2022 14:53:46 +0000
Received: from PSBPR01MB3541.apcprd01.prod.exchangelabs.com
 ([fe80::c3a3:5acd:6247:d44f]) by PSBPR01MB3541.apcprd01.prod.exchangelabs.com
 ([fe80::c3a3:5acd:6247:d44f%5]) with mapi id 15.20.5791.027; Mon, 7 Nov 2022
 14:53:46 +0000
From:   Albert Lv <albert.lv-us-icloud@outlook.com>
To:     Derrick Stolee <derrickstolee@github.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogR2l0IEJ1ZyBSZXBvcnQ6ICdzY2FsYXIgcmVnaXN0ZXInIGNvbW1h?=
 =?gb2312?Q?nd_failed_at_Mac_m1?=
Thread-Topic: Git Bug Report: 'scalar register' command failed at Mac m1
Thread-Index: AQHY8edNBhdE4df0YUCT5vLc/+Zgja4yw/uAgADGhMI=
Date:   Mon, 7 Nov 2022 14:53:46 +0000
Message-ID: <PSBPR01MB3541B7081894BAAD85118202FA3C9@PSBPR01MB3541.apcprd01.prod.exchangelabs.com>
References: <PSBPR01MB3541FDC2CB117051A01A9418FA3D9@PSBPR01MB3541.apcprd01.prod.exchangelabs.com>
 <42804b53-7035-1ba0-3076-2207e63681b7@github.com>
In-Reply-To: <42804b53-7035-1ba0-3076-2207e63681b7@github.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [0Yc5W88eKR2dA1ypImm5oRkG/9tOPh7E]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSBPR01MB3541:EE_|SEYPR01MB5291:EE_
x-ms-office365-filtering-correlation-id: c81d0c86-71c4-48d6-c4a8-08dac0cfdf30
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5IC0Az384zCdORAKFhVCtTf8BKC6hATWDcbW8N03/HD8nR9lfNwwGv2KUDohzJUnVzKQfZQ2mkrSN+QpIqaAtfpP31SeNZzKd//vX+dbpGLU54P4NeZynehwmWxhuyuY9j3UI5tfbdAPWoyyG4i6tX7iNwIdmJUfNDznf7a005+iay9BY91rVGbd9GHNTeGGBFlAymqXa0SOmmLkC8W3oXNNXhpUl2ZErAv6re7SmgE4p7rUw9CowiQXmCXst4Io9as2Vsx7sa6YGqZGpi3cXxwD4aiXOgARCCPwTjDQCfOifrxouLI+nCWyOBqNnYytNJE65ZH9l/2s1QuFnB3xjhzVRKHxoLA11ZWkZH1HsH3pgtxJ7p+Ii+Ogvde3UV4KpvpWgFFNuyyeSyhxjukXBx4fwnasYmNbLPkPnLf6saoJM4U0mEWiZ4nNqqdPROotpS25JfInLtRXb893UCztA7CQRn4gBaWYVMdARoh5bdD5uBxsnM9D5uiwqCHr5pgK5re5WTVaotPpP2bGvPTElHmsScjTwMZ0ITyuD7OjgaJ1UxLVJH/+tbudINtwtnKJSrrfGPV1J2fdUU9Os/HiSq8izeo+Zm1tkCoSEXfCQ1Ss+1o4wuTyllrk2Y2jrCCs
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?L2IxZTFreFluY0o0dkVVZm9Ja3BobFlVMmpyaktGMXNVM2FZaU5ZWUg5QVpD?=
 =?gb2312?B?QzFEWERWMzZEV0N6elBFQ1FXdjc2M2Y3cXZuMjZCNlVuZEw1YlQzTmRsK0Yz?=
 =?gb2312?B?NWNPWm00ZG41c3JVdi9LR0xnckdmY0FScFlxdFY5WnZsaXBTa2dEUEwxeTBn?=
 =?gb2312?B?Z25xQW9ZbkhhbU1HYmRCNFlrMmJONDVmVWdwejNhRkxrWERZRmZNUjB0OFU1?=
 =?gb2312?B?OFIvajgwK0RXYUxTd056T0JFbENKSHUwK29WY0REU3VkR20xN0lTQzZKdmN2?=
 =?gb2312?B?WW56azVCcitmS21abVBiTFBFSWJINTJsN0JMb3RzdFpyUzZFMG13ZVVHMEFk?=
 =?gb2312?B?ajB1Y0FjWFVXTlVhaHBPQThCM1d3U3ZYb016Y3VkRnE4TG95ZU5COEZVTXll?=
 =?gb2312?B?Rnp6azNObUFkclFnNEVwTGhzLy9YUjdPUmY1RE1hcFd4TmxRd0wzRW5VRjl2?=
 =?gb2312?B?MkVoQ1EvbEVwUXFWSVlNYnYxV05TbGZzbjNocEFUbVM1USsxd0syTWlCM1ky?=
 =?gb2312?B?MjcrbmhUM3I0TU1FcjhBZEtVWmFRcUExbnlCYmxvR0tXbFBJWGJRSnppQk1X?=
 =?gb2312?B?TXppelNoaEYreGVucGlJYmhXbUczYWhLM0l3QkpITmVtZEVvOTlCTVlrWnpo?=
 =?gb2312?B?SGNoc2NwZExHR3JLeVB6RWROVzNvb1h4T21ZdjhCTWhBYk5lbnV3TmZ3L3ov?=
 =?gb2312?B?U2V1TGYrTUEyY3B3RVlDMjI3Nkc1ZXFMWUt4Y0VyRmlET3JjWVIveTdacW9W?=
 =?gb2312?B?UUlmbHBIYm93cWpvRWJEMmo0OVgwai9BVUVZd3VqeHZnYTc4WlNKZjRlc0ND?=
 =?gb2312?B?ZEpBSWtXaVNMZXV5aEVZTWZXQXBtbVRlWnV4Zmt1cjI5SHE2R0Frdko0VmMy?=
 =?gb2312?B?SnRDT2djcDZ4VmxRM2NqTENGVWZBbHJCa0IxVEdiSFUvQlFMRGZIc2d1WkZv?=
 =?gb2312?B?UGFISDJaSXYvaHdzNVIzK1FkQmY0anU1dmxySWQ0N0ZSQ1daVTdISTRmS3Bs?=
 =?gb2312?B?eFpYOG4xVFdaeE5hWWFzbTNPNFhoRmdmbWZnYWkzT1R5d0hGYitpZy9kSHAx?=
 =?gb2312?B?NUE5bGo3NFlURGVSN3VBTE5ZVDMwbHdLdXBFTStIanhoL0I4Mm1PeGlueGxM?=
 =?gb2312?B?YTZTNlIvaDdPbVVKT1paTitpZnJRc2pSRlNGTGh2N0wyL1dXSzhKVTFJVHNK?=
 =?gb2312?B?NkJtcVZMUmY0SmJZSWI2RFBQTFRUNWFEM0V4UzFmeDNpUTkwdEtKRjY1Rkpx?=
 =?gb2312?B?OWUvcW1EZEh1Tndob0lveGJGQ3VmR0piT3lMY1V6d1BhWnJyZlNrZUNKWU1v?=
 =?gb2312?B?NFhDa1IvQlkxbW1LSXJTK2JpckdaMWI2WE02cDQ3L1RENDRRcDRwaUJVUjlX?=
 =?gb2312?B?Smt5TUJweUUwYUk2aWZHSjdHa3NOTUU2ZndCM0NiYjFvTlgxZmJoMEx2ejdt?=
 =?gb2312?B?QWZKdVVzbkZuSk5XbVpSRmJPeXlEcjJ1R1o5U0I1NGZjV3h0bU8zbWt1UldD?=
 =?gb2312?B?V0VTMjg0SVB4TlBjOUNXeVhDK2RCdXhJSnZUN0VzNGR3WVJ0SEVyUkx4WHdm?=
 =?gb2312?B?SGpWVEpuR1dZdFNvSCtRTDYrU2J6OUtobDZiV2tzeTF0d2hTZnl5amg5c2R4?=
 =?gb2312?B?UDdtclhybVduc0owUkptNWYxZFZ1bjZ2bGwrMmJUN3UvSXk3aU5KMURaY0hj?=
 =?gb2312?B?ME5zeThIdmM3RWRlcllMTzhzKzVJeHlGcDNYWjRzbUw0V21QUExBNmxGMlRq?=
 =?gb2312?Q?TboLTjfCBr1/amIK3M=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSBPR01MB3541.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c81d0c86-71c4-48d6-c4a8-08dac0cfdf30
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 14:53:46.1156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5291
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIGEgbG90LCBEZXJyaWNrIQ0KDQoibHMgLWFsIH4vTGlicmFyeSIgc2hvd2VkIHRoYXQg
In4vTGlicmFyeS9MYXVuY2hBZ2VudHMvIiB3YXMgb3duZWQgYnkgcm9vdCB1c2VyLiBUaGVuIEkg
Y2hhbmdlZCB0aGUgb3duZXIgb2YgdGhlICJ+L0xpYnJhcnkvTGF1bmNoQWdlbnRzLyIgdG8gbXkg
dXNlci4gQWZ0ZXIgdGhhdCwgInNjYWxhciByZWdpc3RlciIgc3VjY2Vzc2Z1bGx5IHdvcmtlZC4N
Cg0KVGhhbmtzLA0KLUFsYmVydA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQq3orz+yMs6IERlcnJpY2sgU3RvbGVlIDxkZXJyaWNrc3RvbGVlQGdpdGh1Yi5jb20+
DQq3osvNyrG85DogMjAyMsTqMTHUwjfI1SAxMDo1MQ0KytW8/sjLOiBBbGJlcnQgTHY7IGdpdEB2
Z2VyLmtlcm5lbC5vcmcNCtb3zOI6IFJlOiBHaXQgQnVnIFJlcG9ydDogJ3NjYWxhciByZWdpc3Rl
cicgY29tbWFuZCBmYWlsZWQgYXQgTWFjIG0xDQoNCk9uIDExLzYvMjIgODo1NiBBTSwgQWxiZXJ0
IEx2IHdyb3RlOg0KPiBUaGFuayB5b3UgZm9yIGZpbGxpbmcgb3V0IGEgR2l0IGJ1ZyByZXBvcnQh
DQo+IFBsZWFzZSBhbnN3ZXIgdGhlIGZvbGxvd2luZyBxdWVzdGlvbnMgdG8gaGVscCB1cyB1bmRl
cnN0YW5kIHlvdXIgaXNzdWUuDQo+DQo+IFdoYXQgZGlkIHlvdSBkbyBiZWZvcmUgdGhlIGJ1ZyBo
YXBwZW5lZD8gKFN0ZXBzIHRvIHJlcHJvZHVjZSB5b3VyIGlzc3VlKQ0KPiAxLiBGaXJzdCBJIHJ1
biAnc2NhbGFyIHJlZ2lzdGVyJyB0byByZWdpc3RlciBjdXJyZW50IGdpdCByZXBvJy4NCj4gMi4g
QmVjYXVzZSBwcmV2aW91cyBjb21tYW5kIHJlcG9ydCAnUGVybWlzc2lvbiBkZW5pZWQnLCBzbyBJ
IHJ1biAnc3VkbyBzY2FsYXIgcmVnaXN0ZXInLg0KPg0KPiBXaGF0IGRpZCB5b3UgZXhwZWN0IHRv
IGhhcHBlbj8gKEV4cGVjdGVkIGJlaGF2aW9yKQ0KPiBTY2FsYXIgc3VjY2Vzc2Z1bGx5IHJlZ2lz
dGVyZWQNCj4NCj4gV2hhdCBoYXBwZW5lZCBpbnN0ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKQ0KPiBD
b21tYW5kIHJlcG9ydDoNCj4gZmF0YWw6IGZhaWxlZCB0byBib290c3RyYXAgc2VydmljZSAvVXNl
cnMvYWxiZXJ0L0xpYnJhcnkvTGF1bmNoQWdlbnRzL29yZy5naXQtc2NtLmdpdC5ob3VybHkucGxp
c3QNCj4gZXJyb3I6IGNvdWxkIG5vdCB0dXJuIG9uIG1haW50ZW5hbmNlDQoNClRoYW5rcyBmb3Ig
dGhlIHJlcG9ydCwgQWxiZXJ0IQ0KDQpJIHN1c3BlY3QgdGhhdCB5b3UgZ2V0IHRoZSBzYW1lIHBy
b2JsZW0gd2l0aA0KImdpdCBtYWludGVuYW5jZSBzdGFydCIgd2hpY2ggaXMgdGhlIHVuZGVybHlp
bmcNCmNvbW1hbmQgdGhhdCAic2NhbGFyIHJlZ2lzdGVyIiBpcyBydW5uaW5nIGF0IHRoaXMNCnBv
aW50IG9mIGZhaWx1cmUuDQoNClRoZSAifi9MaWJyYXJ5L0xhdW5jaEFnZW50cy8iIHNob3VsZCBi
ZSBvd25lZCBieQ0KeW91ciB1c2VyLCBhbGxvd2luZyB0aGlzIHRvIHdvcmsgd2l0aG91dCBuZWVk
aW5nDQp0byAic3VkbyIuIEhvd2V2ZXIsIGlmIHlvdXIgcGVybWlzc2lvbnMgb24gdGhhdA0KZGly
ZWN0b3J5IGhhdmUgY2hhbmdlZCwgdGhlbiB0aGUgInN1ZG8iIHdpbGwgYmUNCm5lY2Vzc2FyeS4g
Q291bGQgeW91IGRvdWJsZS1jaGVjayB5b3VyIHBlcm1pc3Npb25zDQpieSBydW5uaW5nICJscyAt
YWwgfi9MaWJyYXJ5Ij8NCg0KVGhhbmtzLA0KLVN0b2xlZQ0K
