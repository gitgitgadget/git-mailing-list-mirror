Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EE3C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 11:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiLPLYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 06:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiLPLYL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 06:24:11 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2104.outbound.protection.outlook.com [40.107.7.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71D5BDA
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 03:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpp.canon;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUu6OyBxKDRq5oJXURlsJ9KO2eylLqs0Go2tuAriLJg=;
 b=pOEvOQGQRk8x//kUGpdhf1jzDvkzBIqiRJixrpA4kTAnAHXhW7kdc2zUoelZvsBsGQo1mOEFXfEtCEz2bnJVJiIEyXjP7z34yUBd8d72h5yy2+XeByDJe8G7mmxqhyS3YXnSHD009g/QDd8Rw1ErEDAA29PPEJxt887l982epSM=
Received: from ZR0P278CA0033.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::20)
 by AS2P195MB2390.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:645::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 11:24:08 +0000
Received: from VI1EUR05FT028.eop-eur05.prod.protection.outlook.com
 (2603:10a6:910:1c:cafe::66) by ZR0P278CA0033.outlook.office365.com
 (2603:10a6:910:1c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15 via Frontend
 Transport; Fri, 16 Dec 2022 11:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.138.15.33)
 smtp.mailfrom=cpp.canon; dkim=fail (body hash did not verify)
 header.d=cpp.canon;dmarc=pass action=none header.from=cpp.canon;
Received-SPF: Pass (protection.outlook.com: domain of cpp.canon designates
 193.138.15.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.138.15.33; helo=smtp.cpp.canon; pr=C
Received: from smtp.cpp.canon (193.138.15.33) by
 VI1EUR05FT028.mail.protection.outlook.com (10.233.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16 via Frontend Transport; Fri, 16 Dec 2022 11:24:08 +0000
Received: from oce-exmb03.oce.net (10.95.6.32) by smtp.cpp.canon
 (193.138.15.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Fri, 16 Dec
 2022 12:24:07 +0100
Received: from oce-exmb04.oce.net (10.95.6.33) by oce-exmb03.oce.net
 (10.95.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Fri, 16 Dec
 2022 12:24:07 +0100
Received: from oce-exet04.cppinter.net (193.138.15.34) by oce-exmb04.oce.net
 (10.95.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13 via Frontend
 Transport; Fri, 16 Dec 2022 12:24:07 +0100
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.57) by
 smtp.cpp.canon (193.138.15.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.13; Fri, 16 Dec
 2022 12:24:06 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+PRfGanfwXqebkeeNhe0C/HSc9VbiD9xvQghNAuMPLiesWKSZQLlwWurXMp8P4rBmRV1xpfPhmehdRoIrL/lzNz0XGfR5KIVtQjXD7RpcSaSI9fzFSe3q2LTvlAKCI9Sgvwgxeo3ZBPb6pKUC0pJijaZY4TD1gHp6TWcyDDJG1p+ZS+gyeWpctmVXc1/NEKGRlxxK3LubTimMotnCRN3typLARnfS8+kMuAu6zLufUkOk5KKi8bh3c7EK+98to7b8URMbBZYxJE2GxE3ikAaVkLVtGTdUqOkMa3++BkSoIVM6Kg8oPV2J8QEE+8cmRbh4t4eE7ocQPNSWGcPBD++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCem9MeS+rCqcvJoE7Ooao8GaRg8MU6Dw4Z4tgNbdg4=;
 b=OiUf1Q+l9yTAHuSMwb9wjIoseemjB1UWTTFDoubu1ZoPLhvqao82xWVtz9IIpYvuaSv3WA11Tnt11ZzInPzGuSo9YB4P6acYiX5B5DgeZAPGBDM9uH4JVDl9qBVlZklgpytY6ikzgO7l16NkYFIyYY0VgiUsBVu3WQNOgh9AgtRhT1opGL6Jzodu5ud+PVhznlmvCVog/J/2CQmyoqYrug2J8Ir+pGKo4a6PrHkA+PvdHAdxMOeEc6os3xTQHd1ojT7znrSm15p1nhBZ8i7dWmakaZePhElbkmUJkS7YdW1n4kY2xbHtdk2KrYsA9qsQ8icb6pMPgPvvhcEth5xMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cpp.canon; dmarc=pass action=none header.from=cpp.canon;
 dkim=pass header.d=cpp.canon; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cpp.canon;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCem9MeS+rCqcvJoE7Ooao8GaRg8MU6Dw4Z4tgNbdg4=;
 b=G6r+ltxBpEthYGI+EDz9q54+CaLNhNDF3VsltlzE1tM+8zCfAB2/tjvVRGGCiWeUHKnlp/nwUxAarCL+3dg4fPU+9YHLbHuqZwB/pGGQJzn7L72sFtcnXCLg7rinw6PVW14I7vdC0vpWPya67C7gaYxKX8r61zy95vMld/X3a6I=
Received: from AM8P195MB0820.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::9)
 by VI1P195MB2383.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Fri, 16 Dec
 2022 11:24:00 +0000
Received: from AM8P195MB0820.EURP195.PROD.OUTLOOK.COM
 ([fe80::7cd8:8bb1:6d72:6219]) by AM8P195MB0820.EURP195.PROD.OUTLOOK.COM
 ([fe80::7cd8:8bb1:6d72:6219%4]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 11:24:00 +0000
From:   "Nemmaier, Christoph" <christoph.nemmaier@cpp.canon>
To:     "'rsbecker@nexbridge.com'" <rsbecker@nexbridge.com>,
        "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: AW: PROBLEM: "git pull -v" fails with exit code denoting a submodule
 syntax error
Thread-Topic: PROBLEM: "git pull -v" fails with exit code denoting a submodule
 syntax error
Thread-Index: AdkRKEgzislgucz/T6+rKojgCV9oPwAAgZyAAAPYJPAAALpnsA==
Date:   Fri, 16 Dec 2022 11:24:00 +0000
Message-ID: <AM8P195MB082046CBEF1E7E3F9B124D2480E69@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
References: <AM8P195MB0820A54FEA04231D440F74D780E69@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
 <000b01d9112a$541c4de0$fc54e9a0$@nexbridge.com>
 <AM8P195MB0820B1C168C7C45F3F055CFD80E69@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
In-Reply-To: <AM8P195MB0820B1C168C7C45F3F055CFD80E69@AM8P195MB0820.EURP195.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cpp.canon;
x-ms-traffictypediagnostic: AM8P195MB0820:EE_|VI1P195MB2383:EE_|VI1EUR05FT028:EE_|AS2P195MB2390:EE_
X-MS-Office365-Filtering-Correlation-Id: bf706184-b174-4734-08b3-08dadf580c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 0XUb14Use1cnrrpemgilfEenBDf10jpxO6mdpoxVx2euYwFot1m5BFbwTStZh/3+RQ+69ZUCJiZxgMrc+oI0qO/atiDm/J0iR3YaQM7ZgRdDzzDh4eShWZIc5372bU8k+zs29HRo7yx0QV4Z7yIhvPq26ciOmhuOqtfeexvkm3y3xbxAhA/Q6mQnvbzGB/0C+sFkpqpmrmwaYpyZyJ7G68WWB1DA/DGN1oCiLN5UGgyKWyLedBRHPFnssSvqus9Hggy4yR7yffAnUpAM22XKtJEabWWBFs8BcKRzNc12fA4/8quTGLfCS7pHxeCtZJisXLcWRpoLtG38Q26pI15D+6W6WYrkw4oV2CpXdaFOvWKjwmmE6/jLo8Zte1g7y2u2nQzAB+MUfFSdnthemrwRE+lkaeqmbFNlh1i+VXTJdEOhIXmsP0vDe9it6XcxveunefBKpjkchonhLhGhbVicxhLXbZJHOxDSh5/eGEMIq5dT2a05zEEoviV890hcDJEsg9h4HNj6EbxdINEmzOMXtTgKy0TViBszukJl5+6RKurTs815lgqwoU8L/mv2S5YTfsAAJNupTZ7L4KvPGQb0+EXyt07KCwgQ6NgC5oBcyMLFhmcG7VkbKHcOedzdjNyohMDEbT5eJbzM9B6rDNN8nxDHA70BG9XttzXKwlw7qS9TvckRKjAyWBixzlNbNbKzMRzQFi0N1WkXcX4/AB/XxeYxkbjGgN33Vv/mQYQHW4hjRdmgdgfAuSben9QWHv39LQHS7lvDZB/LJkJ1xA4+yQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8P195MB0820.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39850400004)(366004)(136003)(376002)(451199015)(8936002)(66946007)(8676002)(66476007)(52536014)(66446008)(66556008)(64756008)(41300700001)(316002)(5660300002)(55016003)(110136005)(2906002)(122000001)(66574015)(83380400001)(38100700002)(76116006)(26005)(33656002)(38070700005)(71200400001)(86362001)(186003)(2940100002)(9686003)(6506007)(478600001)(7696005)(82960400001)(46492015)(491001)(460985005);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB2383
X-C2ProcessedOrg: a6a72299-2f6b-49c6-b092-048da1ac2e4b
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR05FT028.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: de8778ab-3f39-4d25-2e07-08dadf580794
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5P4Q+IAB6hcj37m8NGQCtrkF4hsx23O8fQ7MDZWFARmeIp3J64Cd9+ROlBkiTRid6yz5+CwAB+51txBurQvTZ/oUZtZoosZ5jrE1R3nXoGJTbvklXgk83hrMMCbtmPnhVeo9T3Ym8nYAlY17kACYcHn94ztx/iARVwQpxlVPVu9nt4VPengQCDbraRzNjych1F6AGMO9HZLmB61gDHxPngISr4ZHcS2Q5wan1viwNbV6hreKLdMpKa205kCs7yeWXq9e/jt8Exuo1hyaDNQowJ61nLbQ6mDcPMyDvxA1K3FjB7OLyfvdvRqGkHososPK00kQm5oKCWw+UFR/96j1eeL6uy2qDoL1Z0+xpPQVTWHmy4vXLKv4hv5KWktJ6Sg7GVZI9D06vAULe5yPtGIf3EP38Y1QByfhBd4GTHTqH9GhmnOTvAe7Jx25vfRblUKzAnkCkEpHbgore1OijyRgmS+ov0hvD/0s/pDXlWe8ctGOTcqet5akD3LCyd+FOs4YgetshTufQ048nXYOYeOy7+D3Vj2qiJoiHz66Z2mXuHL5K5cHylIx2xuIjFRH6RR2/7sFVtddu3myl/GT5JWEgBBlz74wxwvOF+r2Zt0l1EIYCNdqp1Z0PcvMbYP9JPMA72HM2k3dIs5gyhz2g2mYKR58oKFRopqgC7aGFuBby6Fn08q2qsXqS8igAU9fN7d31IVUXENg3vKKqRa35VNIsHw6yeohqX1z9utIxjLq9n03s9cHFs+aOqIbAuzlAZqArRr+7cHOH9DNpTffYwJeWBGWy4QhpsKsRri2bk/G0Pb/J8Jf+6pFL5vwvIlJIRl
X-Forefront-Antispam-Report: CIP:193.138.15.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.cpp.canon;PTR:oce-exet03.cppinter.net;CAT:NONE;SFS:(13230022)(39860400002)(346002)(396003)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(82740400003)(83380400001)(52536014)(66574015)(356005)(47076005)(81166007)(5660300002)(86362001)(2906002)(40460700003)(336012)(55016003)(8936002)(36860700001)(82960400001)(40480700001)(82310400005)(26005)(9686003)(41300700001)(8676002)(478600001)(70586007)(2940100002)(70206006)(7696005)(6506007)(110136005)(186003)(316002)(33656002)(15974865002)(46492015)(491001)(460985005);DIR:OUT;SFP:1102;
X-OriginatorOrg: cpp.canon
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 11:24:08.0957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf706184-b174-4734-08b3-08dadf580c41
X-MS-Exchange-CrossTenant-Id: 9c30c788-860c-43db-b7d7-e8337f2f0238
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9c30c788-860c-43db-b7d7-e8337f2f0238;Ip=[193.138.15.33];Helo=[smtp.cpp.canon]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT028.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2390
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T2gsIEkgb3Zlcmxvb2tlZCB0aGUgcXVlc3Rpb24gZm9yIHRoZSBnaXQgdmVyc2lvbjogQXMgY29u
dGFpbmVkIGluIG15IGZpcnN0IG1haWwsIGl0IGlzIDIuMzguMS53aW5kb3dzLjEuDQoNCkkgaGVh
ciBmcm9tIGNvbGxlYWd1ZXMgdGVsbHMgbWUgdGhhdCAyLjIzIGlzIHdvcmtpbmcgT0suIEkgaW50
ZW5kIHRvIHZlcmlmeSB0aGlzLg0KDQoNCg0KQ2Fub24gUHJvZHVjdGlvbiBQcmludGluZyBHZXJt
YW55IEdtYkggJiBDby4gS0cNClAuTy4gQm94IDEyNjAsIDg1NTgxIFBvaW5nIA0KU2llbWVuc2Fs
bGVlIDIsIDg1NTg2IFBvaW5nIA0KR2VybWFueSB8IHd3dy5jcHAuY2Fub24NCkNhbm9uIFByb2R1
Y3Rpb24gUHJpbnRpbmcgR2VybWFueSBHbWJIICYgQ28uIEtHLiANClRoZSBjb21wYW55IGlzIGEg
bGltaXRlZCBwYXJ0bmVyc2hpcCB3aXRoIGl0cyByZWdpc3RlcmVkIG9mZmljZSBpbiBQb2luZyAN
ClRyYWRlIFJlZ2lzdGVyIEhSQSAxMDA5NTUgKEFtdHNnZXJpY2h0IE3DvG5jaGVuKSAtIFdFRUUt
UmVnLiAtIE5vLiBERSA4ODggMDUgNDQzDQoNCkdlbmVyYWwgUGFydG5lcjogQ2Fub24gUHJvZHVj
dGlvbiBQcmludGluZyBHZXNjaMOkZnRzZsO8aHJ1bmdzZ2VzZWxsc2NoYWZ0IG1iSCBSZWdpc3Rl
cmVkIE9mZmljZTogUG9pbmcNClRyYWRlIFJlZ2lzdGVyIEhSQiAyMDY0ODAgKEFtdHNnZXJpY2h0
IE3DvG5jaGVuKSANCkV4ZWN1dGl2ZSBPZmZpY2VyOiBKb2hhbm4gTWV5ZXINCsKgIA0KDQoKVGhp
cyBtZXNzYWdlIGFuZCBhdHRhY2htZW50KHMpIGFyZSBpbnRlbmRlZCBzb2xlbHkgZm9yIHVzZSBi
eSB0aGUgYWRkcmVzc2VlIGFuZCBtYXkgY29udGFpbiBpbmZvcm1hdGlvbiB0aGF0IGlzIHByaXZp
bGVnZWQsIGNvbmZpZGVudGlhbCBvciBvdGhlcndpc2UgZXhlbXB0IGZyb20gZGlzY2xvc3VyZSB1
bmRlciBhcHBsaWNhYmxlIGxhdy4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVu
dCBvciBhZ2VudCB0aGVyZW9mIHJlc3BvbnNpYmxlIGZvciBkZWxpdmVyaW5nIHRoaXMgbWVzc2Fn
ZSB0byB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCB5b3UgYXJlIGhlcmVieSBub3RpZmllZCB0aGF0
IGFueSBkaXNzZW1pbmF0aW9uLCBkaXN0cmlidXRpb24gb3IgY29weWluZyBvZiB0aGlzIGNvbW11
bmljYXRpb24gaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhp
cyBjb21tdW5pY2F0aW9uIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRp
YXRlbHkgYnkgdGVsZXBob25lIG9yIHdpdGggYSAncmVwbHknIG1lc3NhZ2UgYW5kIGRlbGV0ZSB0
aGUgbWVzc2FnZSBhbmQgaXRzIGF0dGFjaG1lbnQocyksIGlmIGFueSwgZnJvbSB5b3VyIHN5c3Rl
bShzKS4gVGhhbmsgeW91IGZvciB5b3VyIGNvLW9wZXJhdGlvbi4gCi0tLS0tVXJzcHLDvG5nbGlj
aGUgTmFjaHJpY2h0LS0tLS0NClZvbjogTmVtbWFpZXIsIENocmlzdG9waCANCkdlc2VuZGV0OiBG
cmVpdGFnLCAxNi4gRGV6ZW1iZXIgMjAyMiAxMTo0Mw0KQW46IHJzYmVja2VyQG5leGJyaWRnZS5j
b207IGdpdEB2Z2VyLmtlcm5lbC5vcmcNCkJldHJlZmY6IEFXOiBQUk9CTEVNOiAiZ2l0IHB1bGwg
LXYiIGZhaWxzIHdpdGggZXhpdCBjb2RlIGRlbm90aW5nIGEgc3VibW9kdWxlIHN5bnRheCBlcnJv
cg0KDQpIaSwNCg0Kbm8gYWxpYXMgLSB0aGUgY29tbWFuZCBpcyB1c2VkIGJ5IFRvcnRvaXNlU1ZO
LCBsaWtlIGluOg0KDQpnaXQuZXhlIHB1bGwgLS1wcm9ncmVzcyAtdiAtLW5vLXJlYmFzZSAib3Jp
Z2luIg0KRnJvbSBnaXRsYWIub3BzLm9jZS5uZXQ6bmVtbWFpZWMvY3Bwb3NhdGVzdA0KPSBbdXAg
dG8gZGF0ZV0gICAgICBtYXN0ZXIgICAgIC0+IG9yaWdpbi9tYXN0ZXINCkFscmVhZHkgdXAgdG8g
ZGF0ZS4NCnVzYWdlOiBnaXQgc3VibW9kdWxlIFstLXF1aWV0XSBbLS1jYWNoZWRdDQpvcjogZ2l0
IHN1Ym1vZHVsZSBbLS1xdWlldF0gYWRkIFstYiA8YnJhbmNoPl0gWy1mfC0tZm9yY2VdIFstLW5h
bWUgPG5hbWU+XSBbLS1yZWZlcmVuY2UgPHJlcG9zaXRvcnk+XSBbLS1dIDxyZXBvc2l0b3J5PiBb
PHBhdGg+XQ0Kb3I6IGdpdCBzdWJtb2R1bGUgWy0tcXVpZXRdIHN0YXR1cyBbLS1jYWNoZWRdIFst
LXJlY3Vyc2l2ZV0gWy0tXSBbPHBhdGg+Li4uXQ0Kb3I6IGdpdCBzdWJtb2R1bGUgWy0tcXVpZXRd
IGluaXQgWy0tXSBbPHBhdGg+Li4uXQ0Kb3I6IGdpdCBzdWJtb2R1bGUgWy0tcXVpZXRdIGRlaW5p
dCBbLWZ8LS1mb3JjZV0gKC0tYWxsfCBbLS1dIDxwYXRoPi4uLikNCm9yOiBnaXQgc3VibW9kdWxl
IFstLXF1aWV0XSB1cGRhdGUgWy0taW5pdCBbLS1maWx0ZXI9PGZpbHRlci1zcGVjPl1dIFstLXJl
bW90ZV0gWy1OfC0tbm8tZmV0Y2hdIFstZnwtLWZvcmNlXSBbLS1jaGVja291dHwtLW1lcmdlfC0t
cmViYXNlXSBbLS1bbm8tXXJlY29tbWVuZC1zaGFsbG93XSBbLS1yZWZlcmVuY2UgPHJlcG9zaXRv
cnk+XSBbLS1yZWN1cnNpdmVdIFstLVtuby1dc2luZ2xlLWJyYW5jaF0gWy0tXSBbPHBhdGg+Li4u
XQ0Kb3I6IGdpdCBzdWJtb2R1bGUgWy0tcXVpZXRdIHNldC1icmFuY2ggKC0tZGVmYXVsdHwtLWJy
YW5jaCA8YnJhbmNoPikgWy0tXSA8cGF0aD4NCm9yOiBnaXQgc3VibW9kdWxlIFstLXF1aWV0XSBz
ZXQtdXJsIFstLV0gPHBhdGg+IDxuZXd1cmw+DQpvcjogZ2l0IHN1Ym1vZHVsZSBbLS1xdWlldF0g
c3VtbWFyeSBbLS1jYWNoZWR8LS1maWxlc10gWy0tc3VtbWFyeS1saW1pdCA8bj5dIFtjb21taXRd
IFstLV0gWzxwYXRoPi4uLl0NCm9yOiBnaXQgc3VibW9kdWxlIFstLXF1aWV0XSBmb3JlYWNoIFst
LXJlY3Vyc2l2ZV0gPGNvbW1hbmQ+DQpvcjogZ2l0IHN1Ym1vZHVsZSBbLS1xdWlldF0gc3luYyBb
LS1yZWN1cnNpdmVdIFstLV0gWzxwYXRoPi4uLl0NCm9yOiBnaXQgc3VibW9kdWxlIFstLXF1aWV0
XSBhYnNvcmJnaXRkaXJzIFstLV0gWzxwYXRoPi4uLl0NCg0KSSB2ZXJpZmllZCB0aGF0IHRoZSAt
diBwYXJhbWV0ZXIgaXMgdGhlIGN1bHByaXQuIFRvZGF5IEkgYWxzbyBmb3VuZCBvdXQgdGhhdCB0
aGlzIG9ubHkgaGFwcGVucyBpZiAuZ2l0Y29uZmlnIGNvbnRhaW5zIGEgW3N1Ym1vZHVsZV0gc2Vj
dGlvbiBzZXR0aW5nICJyZWN1cnNlID0gdHJ1ZSIuDQoNCk1lYW53aGlsZSBhIGNvbGxlYWd1ZSBv
ZiBtaW5lIHN0dW1ibGVkIG92ZXIgYW5vdGhlciBwcm9ibGVtIHRoYXQgKGhlIGNsYWltcykgd2Fz
IG5vdCB0aGVyZSB1bnRpbCBoZSB1cGdyYWRlZCBnaXQ6IEdpdEV4dGVuc2lvbnMgdXNlcyAiLS1q
b2JzPTAiLCB3aGljaCBkb2VzIG5vdCB3b3JrIGFueW1vcmUuIEJ1dCwgb2YgY291cnNlLCB0aGF0
J3Mgb2J2aW91c2x5IGEgR2l0RXh0ZW5zaW9ucyBwcm9ibGVtLCBqdXN0IG5ldmVyIGhhdmluZyBz
aG93ZWQgdXAgYmVmb3JlLg0KDQpDaHJpc3RvcGgNCg0KDQpnaXQgZGlkIG5vdCBleGl0IGNsZWFu
bHkgKGV4aXQgY29kZSAxKSAoMzYxMCBtcyBAIDE2LjEyLjIwMjIgMTE6MzM6MzUpDQoNCi0tLS0t
VXJzcHLDvG5nbGljaGUgTmFjaHJpY2h0LS0tLS0NClZvbjogcnNiZWNrZXJAbmV4YnJpZGdlLmNv
bSA8cnNiZWNrZXJAbmV4YnJpZGdlLmNvbT4NCkdlc2VuZGV0OiBGcmVpdGFnLCAxNi4gRGV6ZW1i
ZXIgMjAyMiAwOTo0Mg0KQW46IE5lbW1haWVyLCBDaHJpc3RvcGggPGNocmlzdG9waC5uZW1tYWll
ckBjcHAuY2Fub24+OyBnaXRAdmdlci5rZXJuZWwub3JnDQpCZXRyZWZmOiBSRTogUFJPQkxFTTog
ImdpdCBwdWxsIC12IiBmYWlscyB3aXRoIGV4aXQgY29kZSBkZW5vdGluZyBhIHN1Ym1vZHVsZSBz
eW50YXggZXJyb3INCg0KT24gRGVjZW1iZXIgMTYsIDIwMjIgMzoyOCBBTSwgTmVtbWFpZXIsIENo
cmlzdG9waCB3cm90ZToNCj5JIGV4cGVjdGVkICJnaXQgcHVsbCAtdiIgdG8gc2ltcGx5IHdvcmsg
YW5kIGV4aXQgY29ycmVjdGx5IHdpdGhvdXQgDQo+dGVsbGluZyBtZSB0aGUgc3ludGF4IG9mICJn
aXQgc3VibW9kdWxlIi4NCj4NCj5XaGF0IGhhcHBlbmVkIGluc3RlYWQ/IChBY3R1YWwgYmVoYXZp
b3IpDQo+DQo+VGhpczoNCj4+IEZyb20gZ2l0bGFiLm9wcy5vY2UubmV0Om5lbW1haWVjL2NwcG9z
YQ0KPj4gPSBbdXAgdG8gZGF0ZV0gICAgICBkZXZlbG9wLzEuMCAtPiBvcmlnaW4vZGV2ZWxvcC8x
LjANCj4+IEFscmVhZHkgdXAgdG8gZGF0ZS4NCj4+IHVzYWdlOiBnaXQgc3VibW9kdWxlIFstLXF1
aWV0XSBbLS1jYWNoZWRdDQo+PiAgICBvcjogZ2l0IHN1Ym1vZHVsZSBbLS1xdWlldF0gYWRkIFst
YiA8YnJhbmNoPl0gWy1mfC0tZm9yY2VdIFstLW5hbWUgDQo+PiA8bmFtZT5dIFstLQ0KPnJlZmVy
ZW5jZSA8cmVwb3NpdG9yeT5dIFstLV0gPHJlcG9zaXRvcnk+IFs8cGF0aD5dDQo+PiAgICBvcjog
Z2l0IHN1Ym1vZHVsZSBbLS1xdWlldF0gc3RhdHVzIFstLWNhY2hlZF0gWy0tcmVjdXJzaXZlXSBb
LS1dIFs8cGF0aD4uLi5dDQo+PiAgICBvcjogZ2l0IHN1Ym1vZHVsZSBbLS1xdWlldF0gaW5pdCBb
LS1dIFs8cGF0aD4uLi5dDQo+PiAgICBvcjogZ2l0IHN1Ym1vZHVsZSBbLS1xdWlldF0gZGVpbml0
IFstZnwtLWZvcmNlXSAoLS1hbGx8IFstLV0gPHBhdGg+Li4uKQ0KPj4gICAgb3I6IGdpdCBzdWJt
b2R1bGUgWy0tcXVpZXRdIHVwZGF0ZSBbLS1pbml0IA0KPj4gWy0tZmlsdGVyPTxmaWx0ZXItc3Bl
Yz5dXSBbLS1yZW1vdGVdIFstDQo+TnwtLW5vLWZldGNoXSBbLWZ8LS1mb3JjZV0gWy0tY2hlY2tv
dXR8LS1tZXJnZXwtLXJlYmFzZV0NCj5OfFstLVtuby1dcmVjb21tZW5kLQ0KPnNoYWxsb3ddIFst
LXJlZmVyZW5jZSA8cmVwb3NpdG9yeT5dIFstLXJlY3Vyc2l2ZV0gDQo+Wy0tW25vLV1zaW5nbGUt
YnJhbmNoXSBbLS1dIFs8cGF0aD4uLi5dDQo+PiAgICBvcjogZ2l0IHN1Ym1vZHVsZSBbLS1xdWll
dF0gc2V0LWJyYW5jaCAoLS1kZWZhdWx0fC0tYnJhbmNoDQo+PiA8YnJhbmNoPikgWy0tXQ0KPjxw
YXRoPg0KPj4gICAgb3I6IGdpdCBzdWJtb2R1bGUgWy0tcXVpZXRdIHNldC11cmwgWy0tXSA8cGF0
aD4gPG5ld3VybD4NCj4+ICAgIG9yOiBnaXQgc3VibW9kdWxlIFstLXF1aWV0XSBzdW1tYXJ5IFst
LWNhY2hlZHwtLWZpbGVzXSANCj4+IFstLXN1bW1hcnktbGltaXQgPG4+XQ0KPltjb21taXRdIFst
LV0gWzxwYXRoPi4uLl0NCj4+ICAgIG9yOiBnaXQgc3VibW9kdWxlIFstLXF1aWV0XSBmb3JlYWNo
IFstLXJlY3Vyc2l2ZV0gPGNvbW1hbmQ+DQo+PiAgICBvcjogZ2l0IHN1Ym1vZHVsZSBbLS1xdWll
dF0gc3luYyBbLS1yZWN1cnNpdmVdIFstLV0gWzxwYXRoPi4uLl0NCj4+ICAgIG9yOiBnaXQgc3Vi
bW9kdWxlIFstLXF1aWV0XSBhYnNvcmJnaXRkaXJzIFstLV0gWzxwYXRoPi4uLl0NCj4NCj5XaGF0
J3MgZGlmZmVyZW50IGJldHdlZW4gd2hhdCB5b3UgZXhwZWN0ZWQgYW5kIHdoYXQgYWN0dWFsbHkg
aGFwcGVuZWQ/DQo+DQo+VGhlIHRleHQgSSBxdW90ZWQgYWJvdmUsIGFuZCBhbiBleGl0IHdpdGgg
ZXJyb3IgY29kZS4NCj4NCj5Bbnl0aGluZyBlbHNlIHlvdSB3YW50IHRvIGFkZDoNCj4NCj5UaGUg
Jy12JyBwYXJhbWV0ZXIgaXMgdXNlZCBieSBUb3J0b2lzZUdpdCBhbmQgR2l0RXh0ZW5zaW9ucywg
d2hpY2ggbm93IA0KPmJvdGggY3JvYWsgb24gcHVsbGluZy4NCg0KSGkgQ2hyaXN0b3BoLA0KDQpJ
IGhhdmUgZ29uZSBiYWNrIHRvIGdpdCAyLjM2LjAgYW5kIGNhbm5vdCBmaW5kIHN1cHBvcnQgZm9y
IHRoZSAtdiBzdWJtb2R1bGUgY29tbWFuZCBwYXJhbWV0ZXIuIEF0IHdoYXQgdmVyc2lvbiBkaWQg
dGhpcyBsYXN0IHdvcmsgZm9yIHlvdT8gRG8geW91IGhhdmUgYSBnaXQgYWxpYXMgaW4gZWZmZWN0
IHRoYXQgbWlnaHQgYmUgYWRkaW5nIC12Pw0KLS1SYW5kYWxsDQoNCg==
