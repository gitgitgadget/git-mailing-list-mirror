Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0F3C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 13:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A828A207FD
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 13:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="PLMfBhzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgA1NLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:11:43 -0500
Received: from mail-oln040092010057.outbound.protection.outlook.com ([40.92.10.57]:63366
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbgA1NLn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 08:11:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3z2xwODK9AL1cyxBZnoWFcLAUqluRAQshJFJVlUoUKajJ6d/Qnz02Obbe5mouSmbvO8H7CoGL/YMCf8vaT6P6k3XtBTNZ33j/VdpNWhRFCtm8hhYQv+grdYA4sgU2+Kgxrb4KZ3kGyO9QNX4+BGtdFNiLR/aig/CZQSKFgSBWfc6qrAGW7nDMd5vTe6TsaK4ms+NgQQ7UVkz8CwbQeKxUy3436T24rN0Sosn/tBsWPBtWyHgYFZD5Puoi3MWa0FrDgN53E5K8RccN7h/FeSpKamSeOMQAELNeYsHeYPx0AqsA0B2jJdPhN6uDNv45DiqihsjxgrhFP4GeB/RJVcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGJFLuHV6kOtNsclFPU7jnWPJi+l3BQDm45GqX/Ijfg=;
 b=WRorlOB2ySPS0uefFkOAtwNSaWH8IW5npfH/jzil+yB2jua42ue+UC+uU3jbYv9l7mQ72UVEMkOZeizu9Zh+YKtdFGG03Gmh0iHecUYcYV4m9+Wh6hpqCcACOGx3w3vJDta1muRfsn3AEbhGC3ctakR734EsPdvHy1u/gIE4OKcIia2hiF5//+Bn7i/eMlDnKUnHTyoZYNY4xKiguQyl+RyvXenbvZPzh9NidrDPrIv9iXf2Vi8uHeaBToJjm2/O45dLsfDvQzIMvFNO3YiESACeseuxEY+QKM6GRL21hJX7rcbOXbABqoJ8wy1dNvwY1IdojXJOU94tog/gPvjWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGJFLuHV6kOtNsclFPU7jnWPJi+l3BQDm45GqX/Ijfg=;
 b=PLMfBhzm3ewYkWJ7HCr31tgqf3tSmExlQS+pZ533bV1E3soR9EAgXdY8Ln2AqosbAsEeVq/8yifRjYcyrIOELwHtFmc1Titz2ESSPtcGvtFZNWcdeVU6ljebTHSXA/Ifvcz9Js01OneH/DkxpNy70JNJo9txkPtq2I0OzlLDGiqO4HodeZIn43YQJOJzDGbk2rouMBH2AxC2z8MQWNtpCrTPFKFKWuA3s3ISzwJsKt7aR711tsJcAYvEgZU7WiS6aahQ62aD0Q2TpXzbg3Baf4oWChAkP9wypGn+ll+j4H6qzq7PVDQ4/KUegAmF/Qo03vNWVkrVBZHAkDMYmyxx9Q==
Received: from BN3NAM04FT046.eop-NAM04.prod.protection.outlook.com
 (10.152.92.52) by BN3NAM04HT155.eop-NAM04.prod.protection.outlook.com
 (10.152.92.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.18; Tue, 28 Jan
 2020 13:11:40 +0000
Received: from MN2PR16MB2894.namprd16.prod.outlook.com (10.152.92.60) by
 BN3NAM04FT046.mail.protection.outlook.com (10.152.93.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.18 via Frontend Transport; Tue, 28 Jan 2020 13:11:40 +0000
Received: from MN2PR16MB2894.namprd16.prod.outlook.com
 ([fe80::49d0:6608:b71f:d90c]) by MN2PR16MB2894.namprd16.prod.outlook.com
 ([fe80::49d0:6608:b71f:d90c%7]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 13:11:40 +0000
From:   gopi basker <gopibasker91@live.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git clone issue 
Thread-Topic: Git clone issue 
Thread-Index: AQHV1dx65+24/4skT0ektUsETwrq7g==
Date:   Tue, 28 Jan 2020 13:11:40 +0000
Message-ID: <MN2PR16MB2894BF58BA9107EC1EE26362B60A0@MN2PR16MB2894.namprd16.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:F2C55CA556524F770D0A0D18113A3FFF95E2CFA79E50C373AE1D1D08AB2594FD;UpperCasedChecksum:02CCA0AC7E9CA1F48454F854FDB2EBC1393108152A0817616C6FD27F63F64633;SizeAsReceived:6819;Count:43
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [NoSDt35vHfGfzBF/bmeg2ZiF1MJN4l021WfWYKNFq5ey5NBCAhbA3ber178awlYZ]
x-ms-publictraffictype: Email
x-incomingheadercount: 43
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 60875b9b-42c8-4355-af46-08d7a3f39d3c
x-ms-traffictypediagnostic: BN3NAM04HT155:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jtS8HAfjSNx1tVEafCEflrXMfwhc3ztFSWC0BRkFyv7O1CZzdluxqbv7IifkrMcq8b5IOX4HqrUyzfzah0NFWdsMnbZmAwSM+j77AbxID6K6Yv5HzxhAMz9U/bTa1EUgE5Zwiam2QlpLTmFLXmNU6mJ+daEOOAfJRsihEePWCPdoPUXtZdvnsRIh3M/Ssu0g
x-ms-exchange-antispam-messagedata: Mg5jIGHXpM8vS4uWo71jxEOjApwJ+52i0Cm0Wp2NXzm/itn1fFQGFTL6cpTg1Hge1ZaB8e/Eflcz7FFykJQX6r9EfQn7fMpUCOWrwyTau9iRiPbkSKASGxG99C9ybt0m1OA44qpE5MqVWGZV4LqaABAvD3nW/nRohRzrKYTujX7emvsFfsfGR86W69LSVr54eaODarL99g11xVObJE34Jw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A62C36186E35254A9E54E5E0BCD024FC@sct-15-20-2387-20-msonline-outlook-941ae.templateTenant>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 60875b9b-42c8-4355-af46-08d7a3f39d3c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 13:11:40.5605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3NAM04HT155
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgdGVhbSwNCg0KSSBhbSBmYWNpbmcgaXNzdWUgd2hlbiBJIHRyeSB0byBjbG9uZSB1c2luZyBn
aXQgY2xvbmUgY29tbWFuZCANCg0KR2V0dGluZyBmb2xsb3dpbmcgZXhjZXB0aW9uIA0KDQpmYXRh
bDogYW1iaWd1b3VzIGFyZ3VtZW50IOKAmHN2buKAmSA6IHVuIGtub3duIHJldmlzaW9uIG9yIHBh
dGggbm90IGluIHRoZSB3b3JraW5nICB0cmVlIA0KDQpDb3VsZCB5b3UgcGxlYXNlIGhlbHAgdG8g
dW5kZXJzdGFuZCB0aGUgaXNzdWUgDQoNClNlbnQgZnJvbSBteSBpUGhvbmU=
