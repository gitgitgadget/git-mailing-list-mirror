Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CDDC43217
	for <git@archiver.kernel.org>; Sun,  6 Nov 2022 13:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiKFN4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Nov 2022 08:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiKFN4r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2022 08:56:47 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2076.outbound.protection.outlook.com [40.92.107.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE91062E0
        for <git@vger.kernel.org>; Sun,  6 Nov 2022 05:56:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsacYCDogZpDKxEQaFXw5aaYccagCHAVFcQWx1nOO240ZcDVJ5l2THOAlU2yDWhJXYCLbTKVCEr95/Domw8sgVPKopOqkZnTGiZGkDjqr7DPqJN52tz9uPtTf3926kQSBoKtUPTH0g8+B8D06ijswbeGrb+/Ldf8oAPATGCvPRC5Pg58EBhCkLud3AzOxifotrNIdTT09IT5LoEuzw8jf/ztYwhnmY3W7Y0QhpQafppZlyCA73Iqws4i88J09Ze9fzogKdZwnFQaG1z7WS2h4kMD+IOTiAXI5N5PA8dnk8BSTGmzC2n/uCWeJr/R1nCH9luZs/Pl1yDM0YDBXTn9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92oy7TCsmYxqi41zWttDR0BT5/REhzO7aVEkUpc3drA=;
 b=jAcwBQd7sWh5oo3pJEqJsz8LKjR9kqcYCPNJv4fdeCj6S1k720KsHmuLjb3aa+tOdxsPHAuGOnTiSZ7NHHyAvSCvdeKYTPGq7CXJeK6/7oDO5cZWw1NWiRvqSC9MdQ8f0zPg+PzJhgIFCAt8NYzsW6EOypQGQtpWhjTXvWvCdb9kGVg5ldUQfTPKa46iBurPCUDfYj2u0Mmnrjq2OeY8Jq741M0uhEs77Jy2MNyg54KJxXVoQQsfBUTDX0R4xKeuK09ai+9eaJmUcs5mvMfZjWesiETit22ItdoaoX48W6HPbxjFncD/nF2mpqS3uh32ZdzyB/9xNXQuYilXsVhmlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92oy7TCsmYxqi41zWttDR0BT5/REhzO7aVEkUpc3drA=;
 b=JqRZHDlN8PVfBPgHiLCBWyS+21szDb6wb5omhdRpMFq6NqY9ATvSD5wGqdo51RE1+GaIXST8q7Zl8usyzhTWxUQpBScGxvxz88EOxKxw64JnbdBwux4kB/nGKWYoZwHhs4YWknrdJwS28/sv3pohp3L8qYqYBdPJZoF0BqCB8TGW7yRjJQM3oCa0l2aVtPKnWa1f5W37uU81n4ty8TS8g9e7Lj/jpUJI1VIHfEOwKBDtS+i08NZ14KPpeeq3O9UQoSNBgoL1y97FGvBWTR7domKK1CN/laGzdXmb20VCj046ODej77OYSCaVJmGQMNzJ3FasN2WbUBhrM03a6jZifQ==
Received: from PSBPR01MB3541.apcprd01.prod.exchangelabs.com
 (2603:1096:301:d::14) by TYUPR01MB5060.apcprd01.prod.exchangelabs.com
 (2603:1096:400:35e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Sun, 6 Nov
 2022 13:56:44 +0000
Received: from PSBPR01MB3541.apcprd01.prod.exchangelabs.com
 ([fe80::c3a3:5acd:6247:d44f]) by PSBPR01MB3541.apcprd01.prod.exchangelabs.com
 ([fe80::c3a3:5acd:6247:d44f%5]) with mapi id 15.20.5791.025; Sun, 6 Nov 2022
 13:56:44 +0000
From:   Albert Lv <albert.lv-us-icloud@outlook.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git Bug Report: 'scalar register' command failed at Mac m1
Thread-Topic: Git Bug Report: 'scalar register' command failed at Mac m1
Thread-Index: AQHY8edNBhdE4df0YUCT5vLc/+ZgjQ==
Date:   Sun, 6 Nov 2022 13:56:44 +0000
Message-ID: <PSBPR01MB3541FDC2CB117051A01A9418FA3D9@PSBPR01MB3541.apcprd01.prod.exchangelabs.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [/uriwoO1N3uZs7mQ7mWfSJ8LHU1kFBcW]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSBPR01MB3541:EE_|TYUPR01MB5060:EE_
x-ms-office365-filtering-correlation-id: 8c65a26c-288c-4496-e8b4-08dabffebd73
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1nMmxwOVrL9oBnnXH63ECBc5A/TY0iCrQnU3cP/86N4t3dMDeCO0QE86g8i2Mz03c4fd/ZtHVkPjQPSRSifWLuXlqOlR1BLaLcxxQs8pbOMbOwhRc8dEb6Ks9OXNTgg6ZxKWLb2bVZOmjNVrANhDergDcA4sH22WxUlgvkHlG79NCpSfEHddDPusZ/rEEhcDB+v3taSKtcd44uT2QsGuGFv9glbNOgd6VMyvQw2KXr4lSfQPWjMnSO0e056ONm/KG68oAQabqnzD2NVKvz//6OXayf90YOrYmo6nt8RjogLhdRMFqypyFdyK6VvUCvSZpmtEErzbWD+nlSB+fuoRot2LI5VDQIaEpUTFIXpcYHBimtowL4XqVfdGwnNp3zYMEMMBs2L5u80qjsnnbVhoyzsaagOAhKR6+kF0ghlMEXkZ8G8uyEDsIigwzBIxqkRiG33NXTG4wIPL0igb2hAT7XpAOIA2bRqs5K1CGa9+B8owTwAS4uwkUHqp2rCb/SFPlJ4PyLi8hETbxmdMIUcgByxuxHzphQaXZn0AVfd29uRPaoowgGsH3w+++Em8qbqryDjHSYAH01Owa8uom6J4GUijOgmaD5ZGjacY1FDSC9iY0H21DT+aBM2aojwSAspCGwURr4c97PFk6CA3nGDcAQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NUV0aUFrM21za1djcUVDdHRtWEpQV0I3SFRkRkhjZHZpSHhCUmlrNzhsOGtz?=
 =?gb2312?B?MnB2aG9ERmVYZklQTXR0bDYvRjVyNUltdVdHdkNvTVA5ZGlVeWpWQ3pFSnlK?=
 =?gb2312?B?VjVEQ2tZeG1yaTY1WitOK053cHJHd1Vac1Q0aWNxaEd0cnIxMW8xa3lFSkxl?=
 =?gb2312?B?RU8vQklLalNxQ3VjUk0xQkxUVXI5YllOd3BINCt2c2NEQWVMSUVMbFlXQ2pv?=
 =?gb2312?B?RkN2REhWa2VOYnZGWVBZWTZ2VDZMZ21BTThIQnArVVZxSTY1MVVJRHJPbC9X?=
 =?gb2312?B?dGZodjl3Zkd4RkhheUFaUzJzeGJkaFlGTUhTMldQU2V2eExqNU1zYkZ1a1pZ?=
 =?gb2312?B?NGFjR1pzVG5Ra2pWb21SM29CRGFhbEVDL1V5SjNkM3FFcDJSeUF0M1QzNUhO?=
 =?gb2312?B?SDVqMGFvQmo2UEFJdzQ2WXU3TS9qZzhySFBtcGFvYjZKdmdTYktQbWFmTGIy?=
 =?gb2312?B?V0dHY1ovcGtOYmRsSXFkNFVGZTA0SzdPOEt6YzhjMENCSmY4dmFaajQxTGF6?=
 =?gb2312?B?VlRrVHRHamN1NXBrSzAvZUVveGZ0cENSNVcwTjFvTkR6SmsyQTExS2h5S0dT?=
 =?gb2312?B?OS85eUxwaEFyK1VUTVI2T3RvTE5mditYN3cyTGNreWJmSmZvcXNDYm5wYXVZ?=
 =?gb2312?B?OXhmVG94OWpmc3Rqd0xoSXFVdzI1KzViTlhuekdVNCsrRjNHNDVKU1hnR1Uw?=
 =?gb2312?B?NUhtRnRTTlpxblByaDNITTJxVGkyVkVMeThWL1hMRDRtbUhaUjhxbVRGUlBF?=
 =?gb2312?B?dzZObkZnSUhKcmR3UXRJVUZRN0RjdEhPc3RPb28wVXVRTmVoWUJXMHhZS2gy?=
 =?gb2312?B?U0I5ci9rTFY0dHRSazlGaUx4RGFFbnhMdzBTaDhwbWcxQVcydU1wbTNKbHZm?=
 =?gb2312?B?dWZ3dU1MSGFGQjVGeldsc0FrSjBZdFV3amQ2TGNiYlVzUnJocjNPNDh1ek0r?=
 =?gb2312?B?c1lmeGwxZ0cxSXc3NTFyaEpQdXBoRjVFMkhzU0xVenVtZVlMM2lHanQ3c2xB?=
 =?gb2312?B?b0s4ZElnRTVQYVZsU1JJTExIaXhBblBZYXdIVkI5OENQS1RSVGpBS3VZb2VW?=
 =?gb2312?B?bVZqcW53cFFhY1hMMUFCaHZvcytRQnlsdWZNakVKMTRib3RhbE8zc0w5R1Yr?=
 =?gb2312?B?VGZmeDdsMklYM0hJc2xacjVCeHY0VDFadEd5LzBiK2hIZ0F0YkxWTTEyaUgz?=
 =?gb2312?B?QldxcWlWek85TXRUUEl2RmFVZFNPK1hOdStuL25vem0xc0d3NEJrTlA5NEwx?=
 =?gb2312?B?anEyUE80TW5TaTBmYmt0dnZjQWtpRHM2NzB6dkY4aVF6aW5iNndyMnlRdExE?=
 =?gb2312?B?Z2ZySkkzaitTVTk1bUxsZXp5a1loNDVOMHpKZFBKaWY2cFBkNEF0cmlxVVgy?=
 =?gb2312?B?WUNab0p1c2M5VEpiTFVxd2FMbzh2SGtELzFzM0QyOVVrcjE0Qi95NS9nTWZo?=
 =?gb2312?B?Y3NudDgzOC9aUFoybzF4RnhrR1l1YURxYkxDQnJGcFE1ZUQ5Vk9DUndHc1gy?=
 =?gb2312?B?YldiMjV4ZWk1b1lZN0lYTFU5b2lJNDJiVmhIWjRSZkVSUXQ0NXpPcFNwRDNo?=
 =?gb2312?B?OFpzQkU4RmNUeC85UnJDRzBTT2h6ZlpKNzJOeStiY094cUFuMnR6dkFuMVo3?=
 =?gb2312?B?TloyUkpDaXQrVXRySU82RU5uKytnQ3M2T3lESjBNb3dpNHBHWDFGcWNLTFBQ?=
 =?gb2312?B?WkZIaldSQiswSTdkT3YrTVJzNDU2UllZdUJqWWtQcFE3UWJwT1VTNVk3ZDRM?=
 =?gb2312?Q?xRzVcqHO+1MGwL6Hl4=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSBPR01MB3541.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c65a26c-288c-4496-e8b4-08dabffebd73
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2022 13:56:44.7122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR01MB5060
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCjEuIEZpcnN0IEkgcnVuICdzY2FsYXIgcmVnaXN0ZXInIHRvIHJl
Z2lzdGVyIGN1cnJlbnQgZ2l0IHJlcG8nLgoyLiBCZWNhdXNlIHByZXZpb3VzIGNvbW1hbmQgcmVw
b3J0ICdQZXJtaXNzaW9uIGRlbmllZCcsIHNvIEkgcnVuICdzdWRvIHNjYWxhciByZWdpc3Rlcicu
CgpXaGF0IGRpZCB5b3UgZXhwZWN0IHRvIGhhcHBlbj8gKEV4cGVjdGVkIGJlaGF2aW9yKQpTY2Fs
YXIgc3VjY2Vzc2Z1bGx5IHJlZ2lzdGVyZWQKCldoYXQgaGFwcGVuZWQgaW5zdGVhZD8gKEFjdHVh
bCBiZWhhdmlvcikKQ29tbWFuZCByZXBvcnQ6CmZhdGFsOiBmYWlsZWQgdG8gYm9vdHN0cmFwIHNl
cnZpY2UgL1VzZXJzL2FsYmVydC9MaWJyYXJ5L0xhdW5jaEFnZW50cy9vcmcuZ2l0LXNjbS5naXQu
aG91cmx5LnBsaXN0CmVycm9yOiBjb3VsZCBub3QgdHVybiBvbiBtYWludGVuYW5jZQoKV2hhdCdz
IGRpZmZlcmVudCBiZXR3ZWVuIHdoYXQgeW91IGV4cGVjdGVkIGFuZCB3aGF0IGFjdHVhbGx5IGhh
cHBlbmVkPwpDb21tYW5kIGZhaWxlZAoKQW55dGhpbmcgZWxzZSB5b3Ugd2FudCB0byBhZGQ6Ckkg
YW0gdXNpbmcgbWFjIG0xIGFuZCBtYWNPUyAxMy4wCgpQbGVhc2UgcmV2aWV3IHRoZSByZXN0IG9m
IHRoZSBidWcgcmVwb3J0IGJlbG93LgpZb3UgY2FuIGRlbGV0ZSBhbnkgbGluZXMgeW91IGRvbid0
IHdpc2ggdG8gc2hhcmUuCgoKW1N5c3RlbSBJbmZvXQpnaXQgdmVyc2lvbjoKZ2l0IHZlcnNpb24g
Mi4zOC4xLmRpcnR5CmNwdTogYXJtNjQKYnVpbHQgZnJvbSBjb21taXQ6IGQ1YjQxMzkxYTQ3MmRj
Zjk0ODYwNTVmZDViODUxN2Y4OTNlODhkYWYKc2l6ZW9mLWxvbmc6IDgKc2l6ZW9mLXNpemVfdDog
OApzaGVsbC1wYXRoOiAvYmluL3NoCmZlYXR1cmU6IGZzbW9uaXRvci0tZGFlbW9uCnVuYW1lOiBE
YXJ3aW4gMjIuMS4wIERhcndpbiBLZXJuZWwgVmVyc2lvbiAyMi4xLjA6IFN1biBPY3QgIDkgMjA6
MTQ6MzAgUERUIDIwMjI7IHJvb3Q6eG51LTg3OTIuNDEuOX4yL1JFTEVBU0VfQVJNNjRfVDgxMDMg
YXJtNjQKY29tcGlsZXIgaW5mbzogY2xhbmc6IDEyLjAuNSAoY2xhbmctMTIwNS4wLjIyLjkpCmxp
YmMgaW5mbzogbm8gbGliYyBpbmZvcm1hdGlvbiBhdmFpbGFibGUKJFNIRUxMICh0eXBpY2FsbHks
IGludGVyYWN0aXZlIHNoZWxsKTogL2Jpbi96c2g=
