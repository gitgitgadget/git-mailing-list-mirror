Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7C8C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 10:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiLPKno (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 05:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLPKnh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 05:43:37 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2120.outbound.protection.outlook.com [40.107.13.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220915216D
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 02:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpp.canon;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJRKvBWHJ00tEmrCdf6JbK8SFveJrZxi/Bksm+YWo40=;
 b=TGf9k9KwSEHQFIU/ej9dXBXFjdNVuVo7QeNtDGz2sKnW8T3wtFRMsZYF5bFUTlVrdrjRr36rfQkMxkcjJq/c2XJNT/Q75x8pXSYi0SF8aG7nH280+8i/QIU+FHxAihvkIwvwF6+f90NedMzlVFukNWyWMP/siOQe2VPYzKxLwXc=
Received: from ZR2P278CA0059.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:53::7) by
 DB5P195MB2377.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:488::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.11; Fri, 16 Dec 2022 10:43:32 +0000
Received: from VI1EUR05FT030.eop-eur05.prod.protection.outlook.com
 (2603:10a6:910:53:cafe::b3) by ZR2P278CA0059.outlook.office365.com
 (2603:10a6:910:53::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15 via Frontend
 Transport; Fri, 16 Dec 2022 10:43:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.138.15.33)
 smtp.mailfrom=cpp.canon; dkim=fail (body hash did not verify)
 header.d=cpp.canon;dmarc=pass action=none header.from=cpp.canon;
Received-SPF: Pass (protection.outlook.com: domain of cpp.canon designates
 193.138.15.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.138.15.33; helo=smtp.cpp.canon; pr=C
Received: from smtp.cpp.canon (193.138.15.33) by
 VI1EUR05FT030.mail.protection.outlook.com (10.233.243.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16 via Frontend Transport; Fri, 16 Dec 2022 10:43:31 +0000
Received: from oce-exmb03.oce.net (10.95.6.32) by smtp.cpp.canon
 (193.138.15.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Fri, 16 Dec
 2022 11:43:31 +0100
Received: from oce-exmb03.oce.net (10.95.6.32) by oce-exmb03.oce.net
 (10.95.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Fri, 16 Dec
 2022 11:43:29 +0100
Received: from oce-exet04.cppinter.net (193.138.15.34) by oce-exmb03.oce.net
 (10.95.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13 via Frontend
 Transport; Fri, 16 Dec 2022 11:43:29 +0100
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (104.47.11.107)
 by smtp.cpp.canon (193.138.15.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.13; Fri, 16 Dec
 2022 11:43:29 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+b01DRhePyv+FlHp/qhthT9XGZPiNv56GwQQ5qOuqumxCGxzc8J4U/ajN7QCWM1ryxEwSSZ658ENdN7j9c6ukGRRhCKyKymQZ0w6KTX7noN3A7rmk8CcowstlMzRQmrjfnf5HwGcC+KFse7QziqDlSo4eYLtJKCajyZq0iM7V1AY68IoSPJY7i/rejYjS6pWUgMAkZiOTLj0dqv1AAoZ4upE93TWsiNcmom4QukZMcG9PnmDTdTWvDUmgr47MoAIsxsTlX8o4Uk6mYq1DkF9Zbe5nNmtmBSQKtbK1BlIjSJ4DPH/HYpyQtY1Ihbd5fgSU898Lkgj5tsD6GOCIHbyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kiFREzCRn5UvqoomEJcK9VonIV4dI5clQCCCq1UqhQ=;
 b=iqOQ9uLRKxZAHuj2P4+y6U3oLykENY8AaFegy7yM6X6c/59EXxV2DFsBK49dC6nAYfCEsA7I5IT73LulnP5bK5He4+EN1L7H8QaodUeh1i3No2nzrHBTsCZm6+b4DO6bkdFdVcasE5pdrtssD10gLdrJX3QEnbrxKT/13mIaEiMGrkyVu5EHuepr1pNj3UlIZ7MT052oltbR2rTmt5HmBGwLMp73Ceop3MFViZPz69y1csMObi7drANWJMTWemHY18ouuksK9p+ctMkMaXLPx/8rfslblJrN7PSlpM3gfVjMppkU952HZLIS6MhNL+BiR/24skoO7LZNQMBA923LDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpp.canon; dmarc=pass action=none header.from=cpp.canon;
 dkim=pass header.d=cpp.canon; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpp.canon;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kiFREzCRn5UvqoomEJcK9VonIV4dI5clQCCCq1UqhQ=;
 b=t+iCQFlOizrt4b/AxDYWJyF9+yk32OBVTBM+uVFfB4PAJT753CFbTVY0k/grflNO2xEC/ZxhtTu4Hb87e9Jy4pmqgK/SlrnGkFmrARv8F+zrtY7lOQTvX3Y/7rsQ6tjGhH+qjcLNdXX9KlWdZ27LaIcyo4fkTfnPB5wLCNX9dC8=
Received: from AM8P195MB0820.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::9)
 by DB8P195MB0680.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:152::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Fri, 16 Dec
 2022 10:43:28 +0000
Received: from AM8P195MB0820.EURP195.PROD.OUTLOOK.COM
 ([fe80::7cd8:8bb1:6d72:6219]) by AM8P195MB0820.EURP195.PROD.OUTLOOK.COM
 ([fe80::7cd8:8bb1:6d72:6219%4]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 10:43:28 +0000
From:   "Nemmaier, Christoph" <christoph.nemmaier@cpp.canon>
To:     "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: AW: PROBLEM: "git pull -v" fails with exit code denoting a submodule
 syntax error
Thread-Topic: PROBLEM: "git pull -v" fails with exit code denoting a submodule
 syntax error
Thread-Index: AdkRKEgzislgucz/T6+rKojgCV9oPwAAgZyAAAPYJPA=
Date:   Fri, 16 Dec 2022 10:43:28 +0000
Message-ID: <AM8P195MB0820B1C168C7C45F3F055CFD80E69@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
References: <AM8P195MB0820A54FEA04231D440F74D780E69@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
 <000b01d9112a$541c4de0$fc54e9a0$@nexbridge.com>
In-Reply-To: <000b01d9112a$541c4de0$fc54e9a0$@nexbridge.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpp.canon;
x-ms-traffictypediagnostic: AM8P195MB0820:EE_|DB8P195MB0680:EE_|VI1EUR05FT030:EE_|DB5P195MB2377:EE_
X-MS-Office365-Filtering-Correlation-Id: c637e199-d60f-4a75-bab7-08dadf525ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Zstz617He/BUuQIGmu2krohlHxV5NXMwkbSdKV6fyn3GJvBWBjNEFdcC6zm16Q1N13nELNDx/riji52LzFrL4AU8L3E0Vi/fmJDxHsQvN7zWgXB5GTNVR6uNNAgDnb2etD2oZnT5m9WDAFniKLhJNpO6pn4a8UrOEdUoT50rPPsSNuVvmUhsuBV3BmN1s24A6KsBpViMtGhKTZv9lQlUwXhbgQ54usCWhLUoEpiwwt5W15AD5XP50dFTa9dpUwGE9cgx9GTpw6MhmDa6qUZ7hsyJQx5Vv+b//COCqRGFS1zi57p0d9n7EUdSpFePqtKtp3xmeA8xi1F+X6Wc+/ZPNq20LLLIGB+1ECh0ojOP+sqQJ3lzWEhc5eTibmy+4pC/SiNGMihTucYeACQVNp6whlMDCBwStPKFUhT52rdUz2HeGcjr4BLw8ZexlBk5CmHSkBjHbiEaRIZLjWYR39dNTBf5Dg3ILFxdxB0O58K4UOtPx9Wfx1aW93IZBqBFVKd5G79/sGxoUNeDc4e/dhKa1MWaAXXYBWb91MFN+uEFzpzqBqXDikxCOuL/AyO3Wy9RRnS34BV3ou8jj0NmiaZEVou4vcGhd5KORTYoNXhX4ghcpXSMiuyVKUbr7DMnPOgFPtfrGlwPAOtSYbL7dWzXrDNOs8nm/p8QNLyuFZu3FHua4s1YPkdNNDhsHKsQT2D3rEMfFDGZlFn2qhGCnH+uVp5sTAx1i+nmskAw4uDxCbaDTreIqc8GYWmLVoQGt50n
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8P195MB0820.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(33656002)(55016003)(41300700001)(76116006)(66574015)(64756008)(66446008)(66946007)(66556008)(8676002)(8936002)(5660300002)(52536014)(83380400001)(6506007)(7696005)(71200400001)(478600001)(110136005)(316002)(66476007)(9686003)(186003)(26005)(82960400001)(86362001)(38070700005)(2906002)(122000001)(38100700002)(46492015)(460985005);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0680
X-C2ProcessedOrg: a6a72299-2f6b-49c6-b092-048da1ac2e4b
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR05FT030.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 48723c69-eec7-4d9c-79c1-08dadf525de2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDvi8Eq6Yu0NhXANy5GT7oLjeQa249wSJDRouCFCoxf6Bk91Jy3jVficRtQLVNEv/SrvL85fNnvXEKTyLhPzpcGgv1NmaiKGHZLVtrrQDg64Rr95qgkAHqljwrgJrtL9acuT3TiRtDHbUd4XM+HZjpF1oguViZbx4va0EIM+iUxm762rgVZg43aXkDyU+RNTUqauBUZ4ZeHWxbRYuOnBG0zMT02N6MTCYKtABw5kBiYMlNSDNZ+2sYdL2upTi+vLNqzkbl58Rg1UBiDgAmR1egjRYqdlPKK4ELU5wtGTx+XQlW9YFyRpaALAifQJDjbT7NEROwaEmD8HUtpBLMw8PUNBqKhaaXdCLkvweaRPnVonJqM3xjwJJFyAyCt4CDuK8j8+ObiEk3LjMBDyGuuElGdbc+X9fxPxEDwF71m6dd2CCRLR0GYSvzFT28ni58mvg65eZXtBxtDjHqODb4GFWodMTLRdsaj2ty1TzLveBrjnIpFbBfoSJQBZr9SNMq8zbf11Z0P478lZApkpDn8pr49LTcmxsJPNT/DQCIy3n7LLnu5cJGOjA2/aNIq9BpfxV4JcMDLeFm5bBdHCgiGfwgbXGhiRGg93uIIIpeYqI6zxJUtsKm4ECWuCq85fz/c6wDIhZr6dEm8rCVR0eT87KFg3MwJMruzzHtOXR7qSMNQCkanuThxejuc6QSXTVDv7FWB6Vd8Hqhax7smDObS/4yk4mjppSDC3IKyciTQd0dUsZL+pTFu3YWfJOoxKR8WW/jMoY5HHTBqNMVvVGHBJjS2RMrNPtF3AXRxtAQSpjTc=
X-Forefront-Antispam-Report: CIP:193.138.15.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.cpp.canon;PTR:oce-exet03.cppinter.net;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(336012)(83380400001)(186003)(86362001)(316002)(15974865002)(81166007)(110136005)(478600001)(356005)(40460700003)(40480700001)(55016003)(82960400001)(82740400003)(6506007)(9686003)(33656002)(66574015)(82310400005)(47076005)(7696005)(26005)(8676002)(52536014)(5660300002)(36860700001)(2906002)(41300700001)(70206006)(70586007)(8936002)(46492015)(460985005);DIR:OUT;SFP:1102;
X-OriginatorOrg: cpp.canon
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 10:43:31.5020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c637e199-d60f-4a75-bab7-08dadf525ff0
X-MS-Exchange-CrossTenant-Id: 9c30c788-860c-43db-b7d7-e8337f2f0238
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9c30c788-860c-43db-b7d7-e8337f2f0238;Ip=[193.138.15.33];Helo=[smtp.cpp.canon]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT030.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5P195MB2377
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksDQoNCm5vIGFsaWFzIC0gdGhlIGNvbW1hbmQgaXMgdXNlZCBieSBUb3J0b2lzZVNWTiwgbGlr
ZSBpbjoNCg0KZ2l0LmV4ZSBwdWxsIC0tcHJvZ3Jlc3MgLXYgLS1uby1yZWJhc2UgIm9yaWdpbiIN
CkZyb20gZ2l0bGFiLm9wcy5vY2UubmV0Om5lbW1haWVjL2NwcG9zYXRlc3QNCj0gW3VwIHRvIGRh
dGVdICAgICAgbWFzdGVyICAgICAtPiBvcmlnaW4vbWFzdGVyDQpBbHJlYWR5IHVwIHRvIGRhdGUu
DQp1c2FnZTogZ2l0IHN1Ym1vZHVsZSBbLS1xdWlldF0gWy0tY2FjaGVkXQ0Kb3I6IGdpdCBzdWJt
b2R1bGUgWy0tcXVpZXRdIGFkZCBbLWIgPGJyYW5jaD5dIFstZnwtLWZvcmNlXSBbLS1uYW1lIDxu
YW1lPl0gWy0tcmVmZXJlbmNlIDxyZXBvc2l0b3J5Pl0gWy0tXSA8cmVwb3NpdG9yeT4gWzxwYXRo
Pl0NCm9yOiBnaXQgc3VibW9kdWxlIFstLXF1aWV0XSBzdGF0dXMgWy0tY2FjaGVkXSBbLS1yZWN1
cnNpdmVdIFstLV0gWzxwYXRoPi4uLl0NCm9yOiBnaXQgc3VibW9kdWxlIFstLXF1aWV0XSBpbml0
IFstLV0gWzxwYXRoPi4uLl0NCm9yOiBnaXQgc3VibW9kdWxlIFstLXF1aWV0XSBkZWluaXQgWy1m
fC0tZm9yY2VdICgtLWFsbHwgWy0tXSA8cGF0aD4uLi4pDQpvcjogZ2l0IHN1Ym1vZHVsZSBbLS1x
dWlldF0gdXBkYXRlIFstLWluaXQgWy0tZmlsdGVyPTxmaWx0ZXItc3BlYz5dXSBbLS1yZW1vdGVd
IFstTnwtLW5vLWZldGNoXSBbLWZ8LS1mb3JjZV0gWy0tY2hlY2tvdXR8LS1tZXJnZXwtLXJlYmFz
ZV0gWy0tW25vLV1yZWNvbW1lbmQtc2hhbGxvd10gWy0tcmVmZXJlbmNlIDxyZXBvc2l0b3J5Pl0g
Wy0tcmVjdXJzaXZlXSBbLS1bbm8tXXNpbmdsZS1icmFuY2hdIFstLV0gWzxwYXRoPi4uLl0NCm9y
OiBnaXQgc3VibW9kdWxlIFstLXF1aWV0XSBzZXQtYnJhbmNoICgtLWRlZmF1bHR8LS1icmFuY2gg
PGJyYW5jaD4pIFstLV0gPHBhdGg+DQpvcjogZ2l0IHN1Ym1vZHVsZSBbLS1xdWlldF0gc2V0LXVy
bCBbLS1dIDxwYXRoPiA8bmV3dXJsPg0Kb3I6IGdpdCBzdWJtb2R1bGUgWy0tcXVpZXRdIHN1bW1h
cnkgWy0tY2FjaGVkfC0tZmlsZXNdIFstLXN1bW1hcnktbGltaXQgPG4+XSBbY29tbWl0XSBbLS1d
IFs8cGF0aD4uLi5dDQpvcjogZ2l0IHN1Ym1vZHVsZSBbLS1xdWlldF0gZm9yZWFjaCBbLS1yZWN1
cnNpdmVdIDxjb21tYW5kPg0Kb3I6IGdpdCBzdWJtb2R1bGUgWy0tcXVpZXRdIHN5bmMgWy0tcmVj
dXJzaXZlXSBbLS1dIFs8cGF0aD4uLi5dDQpvcjogZ2l0IHN1Ym1vZHVsZSBbLS1xdWlldF0gYWJz
b3JiZ2l0ZGlycyBbLS1dIFs8cGF0aD4uLi5dDQoNCkkgdmVyaWZpZWQgdGhhdCB0aGUgLXYgcGFy
YW1ldGVyIGlzIHRoZSBjdWxwcml0LiBUb2RheSBJIGFsc28gZm91bmQgb3V0IHRoYXQgdGhpcyBv
bmx5IGhhcHBlbnMgaWYgLmdpdGNvbmZpZyBjb250YWlucyBhIFtzdWJtb2R1bGVdIHNlY3Rpb24g
c2V0dGluZyAicmVjdXJzZSA9IHRydWUiLg0KDQpNZWFud2hpbGUgYSBjb2xsZWFndWUgb2YgbWlu
ZSBzdHVtYmxlZCBvdmVyIGFub3RoZXIgcHJvYmxlbSB0aGF0IChoZSBjbGFpbXMpIHdhcyBub3Qg
dGhlcmUgdW50aWwgaGUgdXBncmFkZWQgZ2l0OiBHaXRFeHRlbnNpb25zIHVzZXMgIi0tam9icz0w
Iiwgd2hpY2ggZG9lcyBub3Qgd29yayBhbnltb3JlLiBCdXQsIG9mIGNvdXJzZSwgdGhhdCdzIG9i
dmlvdXNseSBhIEdpdEV4dGVuc2lvbnMgDQpwcm9ibGVtLCBqdXN0IG5ldmVyIGhhdmluZyBzaG93
ZWQgdXAgYmVmb3JlLg0KDQpDaHJpc3RvcGgNCg0KDQpnaXQgZGlkIG5vdCBleGl0IGNsZWFubHkg
KGV4aXQgY29kZSAxKSAoMzYxMCBtcyBAIDE2LjEyLjIwMjIgMTE6MzM6MzUpDQoNCg0KDQpDYW5v
biBQcm9kdWN0aW9uIFByaW50aW5nIEdlcm1hbnkgR21iSCAmIENvLiBLRw0KUC5PLiBCb3ggMTI2
MCwgODU1ODEgUG9pbmcgDQpTaWVtZW5zYWxsZWUgMiwgODU1ODYgUG9pbmcgDQpHZXJtYW55IHwg
d3d3LmNwcC5jYW5vbg0KQ2Fub24gUHJvZHVjdGlvbiBQcmludGluZyBHZXJtYW55IEdtYkggJiBD
by4gS0cuIA0KVGhlIGNvbXBhbnkgaXMgYSBsaW1pdGVkIHBhcnRuZXJzaGlwIHdpdGggaXRzIHJl
Z2lzdGVyZWQgb2ZmaWNlIGluIFBvaW5nIA0KVHJhZGUgUmVnaXN0ZXIgSFJBIDEwMDk1NSAoQW10
c2dlcmljaHQgTcO8bmNoZW4pIC0gV0VFRS1SZWcuIC0gTm8uIERFIDg4OCAwNSA0NDMNCg0KR2Vu
ZXJhbCBQYXJ0bmVyOiBDYW5vbiBQcm9kdWN0aW9uIFByaW50aW5nIEdlc2Now6RmdHNmw7xocnVu
Z3NnZXNlbGxzY2hhZnQgbWJIIFJlZ2lzdGVyZWQgT2ZmaWNlOiBQb2luZw0KVHJhZGUgUmVnaXN0
ZXIgSFJCIDIwNjQ4MCAoQW10c2dlcmljaHQgTcO8bmNoZW4pIA0KRXhlY3V0aXZlIE9mZmljZXI6
IEpvaGFubiBNZXllcg0KwqAgDQoNCgpUaGlzIG1lc3NhZ2UgYW5kIGF0dGFjaG1lbnQocykgYXJl
IGludGVuZGVkIHNvbGVseSBmb3IgdXNlIGJ5IHRoZSBhZGRyZXNzZWUgYW5kIG1heSBjb250YWlu
IGluZm9ybWF0aW9uIHRoYXQgaXMgcHJpdmlsZWdlZCwgY29uZmlkZW50aWFsIG9yIG90aGVyd2lz
ZSBleGVtcHQgZnJvbSBkaXNjbG9zdXJlIHVuZGVyIGFwcGxpY2FibGUgbGF3LiBJZiB5b3UgYXJl
IG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IG9yIGFnZW50IHRoZXJlb2YgcmVzcG9uc2libGUg
Zm9yIGRlbGl2ZXJpbmcgdGhpcyBtZXNzYWdlIHRvIHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHlv
dSBhcmUgaGVyZWJ5IG5vdGlmaWVkIHRoYXQgYW55IGRpc3NlbWluYXRpb24sIGRpc3RyaWJ1dGlv
biBvciBjb3B5aW5nIG9mIHRoaXMgY29tbXVuaWNhdGlvbiBpcyBzdHJpY3RseSBwcm9oaWJpdGVk
LiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGNvbW11bmljYXRpb24gaW4gZXJyb3IsIHBsZWFz
ZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBieSB0ZWxlcGhvbmUgb3Igd2l0aCBhICdy
ZXBseScgbWVzc2FnZSBhbmQgZGVsZXRlIHRoZSBtZXNzYWdlIGFuZCBpdHMgYXR0YWNobWVudChz
KSwgaWYgYW55LCBmcm9tIHlvdXIgc3lzdGVtKHMpLiBUaGFuayB5b3UgZm9yIHlvdXIgY28tb3Bl
cmF0aW9uLiAKLS0tLS1VcnNwcsO8bmdsaWNoZSBOYWNocmljaHQtLS0tLQ0KVm9uOiByc2JlY2tl
ckBuZXhicmlkZ2UuY29tIDxyc2JlY2tlckBuZXhicmlkZ2UuY29tPiANCkdlc2VuZGV0OiBGcmVp
dGFnLCAxNi4gRGV6ZW1iZXIgMjAyMiAwOTo0Mg0KQW46IE5lbW1haWVyLCBDaHJpc3RvcGggPGNo
cmlzdG9waC5uZW1tYWllckBjcHAuY2Fub24+OyBnaXRAdmdlci5rZXJuZWwub3JnDQpCZXRyZWZm
OiBSRTogUFJPQkxFTTogImdpdCBwdWxsIC12IiBmYWlscyB3aXRoIGV4aXQgY29kZSBkZW5vdGlu
ZyBhIHN1Ym1vZHVsZSBzeW50YXggZXJyb3INCg0KT24gRGVjZW1iZXIgMTYsIDIwMjIgMzoyOCBB
TSwgTmVtbWFpZXIsIENocmlzdG9waCB3cm90ZToNCj5JIGV4cGVjdGVkICJnaXQgcHVsbCAtdiIg
dG8gc2ltcGx5IHdvcmsgYW5kIGV4aXQgY29ycmVjdGx5IHdpdGhvdXQgDQo+dGVsbGluZyBtZSB0
aGUgc3ludGF4IG9mICJnaXQgc3VibW9kdWxlIi4NCj4NCj5XaGF0IGhhcHBlbmVkIGluc3RlYWQ/
IChBY3R1YWwgYmVoYXZpb3IpDQo+DQo+VGhpczoNCj4+IEZyb20gZ2l0bGFiLm9wcy5vY2UubmV0
Om5lbW1haWVjL2NwcG9zYQ0KPj4gPSBbdXAgdG8gZGF0ZV0gICAgICBkZXZlbG9wLzEuMCAtPiBv
cmlnaW4vZGV2ZWxvcC8xLjANCj4+IEFscmVhZHkgdXAgdG8gZGF0ZS4NCj4+IHVzYWdlOiBnaXQg
c3VibW9kdWxlIFstLXF1aWV0XSBbLS1jYWNoZWRdDQo+PiAgICBvcjogZ2l0IHN1Ym1vZHVsZSBb
LS1xdWlldF0gYWRkIFstYiA8YnJhbmNoPl0gWy1mfC0tZm9yY2VdIFstLW5hbWUgDQo+PiA8bmFt
ZT5dIFstLQ0KPnJlZmVyZW5jZSA8cmVwb3NpdG9yeT5dIFstLV0gPHJlcG9zaXRvcnk+IFs8cGF0
aD5dDQo+PiAgICBvcjogZ2l0IHN1Ym1vZHVsZSBbLS1xdWlldF0gc3RhdHVzIFstLWNhY2hlZF0g
Wy0tcmVjdXJzaXZlXSBbLS1dIFs8cGF0aD4uLi5dDQo+PiAgICBvcjogZ2l0IHN1Ym1vZHVsZSBb
LS1xdWlldF0gaW5pdCBbLS1dIFs8cGF0aD4uLi5dDQo+PiAgICBvcjogZ2l0IHN1Ym1vZHVsZSBb
LS1xdWlldF0gZGVpbml0IFstZnwtLWZvcmNlXSAoLS1hbGx8IFstLV0gPHBhdGg+Li4uKQ0KPj4g
ICAgb3I6IGdpdCBzdWJtb2R1bGUgWy0tcXVpZXRdIHVwZGF0ZSBbLS1pbml0IA0KPj4gWy0tZmls
dGVyPTxmaWx0ZXItc3BlYz5dXSBbLS1yZW1vdGVdIFstDQo+TnwtLW5vLWZldGNoXSBbLWZ8LS1m
b3JjZV0gWy0tY2hlY2tvdXR8LS1tZXJnZXwtLXJlYmFzZV0gDQo+TnxbLS1bbm8tXXJlY29tbWVu
ZC0NCj5zaGFsbG93XSBbLS1yZWZlcmVuY2UgPHJlcG9zaXRvcnk+XSBbLS1yZWN1cnNpdmVdIA0K
PlstLVtuby1dc2luZ2xlLWJyYW5jaF0gWy0tXSBbPHBhdGg+Li4uXQ0KPj4gICAgb3I6IGdpdCBz
dWJtb2R1bGUgWy0tcXVpZXRdIHNldC1icmFuY2ggKC0tZGVmYXVsdHwtLWJyYW5jaCANCj4+IDxi
cmFuY2g+KSBbLS1dDQo+PHBhdGg+DQo+PiAgICBvcjogZ2l0IHN1Ym1vZHVsZSBbLS1xdWlldF0g
c2V0LXVybCBbLS1dIDxwYXRoPiA8bmV3dXJsPg0KPj4gICAgb3I6IGdpdCBzdWJtb2R1bGUgWy0t
cXVpZXRdIHN1bW1hcnkgWy0tY2FjaGVkfC0tZmlsZXNdIA0KPj4gWy0tc3VtbWFyeS1saW1pdCA8
bj5dDQo+W2NvbW1pdF0gWy0tXSBbPHBhdGg+Li4uXQ0KPj4gICAgb3I6IGdpdCBzdWJtb2R1bGUg
Wy0tcXVpZXRdIGZvcmVhY2ggWy0tcmVjdXJzaXZlXSA8Y29tbWFuZD4NCj4+ICAgIG9yOiBnaXQg
c3VibW9kdWxlIFstLXF1aWV0XSBzeW5jIFstLXJlY3Vyc2l2ZV0gWy0tXSBbPHBhdGg+Li4uXQ0K
Pj4gICAgb3I6IGdpdCBzdWJtb2R1bGUgWy0tcXVpZXRdIGFic29yYmdpdGRpcnMgWy0tXSBbPHBh
dGg+Li4uXQ0KPg0KPldoYXQncyBkaWZmZXJlbnQgYmV0d2VlbiB3aGF0IHlvdSBleHBlY3RlZCBh
bmQgd2hhdCBhY3R1YWxseSBoYXBwZW5lZD8NCj4NCj5UaGUgdGV4dCBJIHF1b3RlZCBhYm92ZSwg
YW5kIGFuIGV4aXQgd2l0aCBlcnJvciBjb2RlLg0KPg0KPkFueXRoaW5nIGVsc2UgeW91IHdhbnQg
dG8gYWRkOg0KPg0KPlRoZSAnLXYnIHBhcmFtZXRlciBpcyB1c2VkIGJ5IFRvcnRvaXNlR2l0IGFu
ZCBHaXRFeHRlbnNpb25zLCB3aGljaCBub3cgDQo+Ym90aCBjcm9hayBvbiBwdWxsaW5nLg0KDQpI
aSBDaHJpc3RvcGgsDQoNCkkgaGF2ZSBnb25lIGJhY2sgdG8gZ2l0IDIuMzYuMCBhbmQgY2Fubm90
IGZpbmQgc3VwcG9ydCBmb3IgdGhlIC12IHN1Ym1vZHVsZSBjb21tYW5kIHBhcmFtZXRlci4gQXQg
d2hhdCB2ZXJzaW9uIGRpZCB0aGlzIGxhc3Qgd29yayBmb3IgeW91PyBEbyB5b3UgaGF2ZSBhIGdp
dCBhbGlhcyBpbiBlZmZlY3QgdGhhdCBtaWdodCBiZSBhZGRpbmcgLXY/DQotLVJhbmRhbGwNCg0K
