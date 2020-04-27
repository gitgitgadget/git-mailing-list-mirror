Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980C3C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 01:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E15E2070A
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 01:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=audinate.com header.i=@audinate.com header.b="CsDVBj8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgD0BbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 21:31:14 -0400
Received: from mail-eopbgr1360077.outbound.protection.outlook.com ([40.107.136.77]:11769
        "EHLO AUS01-ME1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbgD0BbN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Apr 2020 21:31:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xe4BwY3xX3/gRuL4iZhKrL3+oiaTbAor/lIDo4jYShd0I4Sd3GYRE+Wl3+pjECBxAjzeOBFKHFpGHvq18zLepe3NDOAko9oG3fR7CfwrROpjklQXAGLfc7+KzP4D/TfPsZXvJpdRXCyHkL8KDk4n6ecsbZTcDpa1sZBL5RYcd5FlvWsO1ZD4B+gJivEUZAsLYS+sA0a46/WaXBhDmiGFlJCthaJbBNTl/gtVsDhRwMAhlrWlrvdX1ThZQOzKlpNZB2hiNp3FoF5QBi9AKEml1jCTj9NxMFebPupULxhU+PRL7b+pIz5d2pFRokds03YHj7FPu3PecRgaTZUmgeXWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Yq+EhXXPYz2rD2ECQ+oZLE4aY8+esYIzKvyYCwQNok=;
 b=kFzReBtmfO7EbgEfo2+dI8NFLChbu04zOW8vwTU63F25aV1CequegLLKEN5kh0NR4qge7JvH/fsqzrrq21HdHdVISTpOqdCRLetZ2FuxtJekaSSdjXEmzqc+JgpZDsEWqkFcFJNBhR1cVJRHi7fwkcAdqKZOeFuVQ/npX2K0LMCrE+Idt/o0JngAW9TzeGvtc+t9p3Kkr1YqR8NDhi2uXwZlBIh3SJ4ETimLTdYaSPIqlGwUj41R2azhUn/Hansy4IEg+QUEOnxPlUrACk36WiWsI5rHBOF7zHdk2/zXWrhOySMWVcJrKOhngG9fZNaXFMCSdHthdfPhCDpEXIv6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=audinate.com; dmarc=pass action=none header.from=audinate.com;
 dkim=pass header.d=audinate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=audinate.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Yq+EhXXPYz2rD2ECQ+oZLE4aY8+esYIzKvyYCwQNok=;
 b=CsDVBj8tisDzNQY0v5Sinc/xhw8YWWYUg5lbKg12LbY926qPyIzO2IYC/4EifXGetHdGrvWrZPOgztE9M3cJ7PZRFvMgqxnCOHscZkcxucT+W2lJ0FoNfRB5ozVidl2E0AJXgno4qyCxrUnx1w7UqgFucdYMSeB42XlGYdj252s=
Received: from SYYP282MB1406.AUSP282.PROD.OUTLOOK.COM (20.180.46.202) by
 SYYSPR01MB0004.AUSP282.PROD.OUTLOOK.COM (20.180.47.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Mon, 27 Apr 2020 01:31:09 +0000
Received: from SYYP282MB1406.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f9a0:94fc:37e:70f9]) by SYYP282MB1406.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f9a0:94fc:37e:70f9%6]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 01:31:09 +0000
From:   Andrew White <andrew.white@audinate.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug v2.23.0: command help for 'git push --recurse-submodules' is
 incorrect
Thread-Topic: Bug v2.23.0: command help for 'git push --recurse-submodules' is
 incorrect
Thread-Index: AQHWHDOH/v5Il+ZEGUeyt2mrBRB4Kw==
Date:   Mon, 27 Apr 2020 01:31:09 +0000
Message-ID: <346FFB0C-7419-4E2D-B593-9F64F9403D11@audinatedante.onmicrosoft.com>
Accept-Language: en-AU, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1e.0.191013
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrew.white@audinate.com; 
x-originating-ip: [101.179.218.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aae39c07-89e3-463e-62ac-08d7ea4aaa00
x-ms-traffictypediagnostic: SYYSPR01MB0004:
x-microsoft-antispam-prvs: <SYYSPR01MB00047E85F08B5989F912B272F0AF0@SYYSPR01MB0004.AUSP282.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYYP282MB1406.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(39840400004)(366004)(136003)(396003)(66476007)(66446008)(186003)(316002)(66946007)(86362001)(8936002)(26005)(6512007)(9686003)(66556008)(81156014)(44832011)(33656002)(64756008)(6506007)(8676002)(6486002)(4744005)(71200400001)(76116006)(478600001)(2906002)(5660300002)(6916009)(6396001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: audinate.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NAned3BQmZk9EoO8AteOzbR+PmPLPL8e01c1mR4bj420dSnvliJuXq8rPCOEB030evIAuoEHMdm9iNOIaaWXSttQZTBM3LvmG1ZunjXawfCvjQHwYkfO6D6aJ3wp3okwpSMYTM6gZF3F7Gc/g4CrkwsSvLYJ67opOdm1QsCW4deqn3ZQ5cTwNBIFSUgNTjk77T/pso4VMhPWuW9vHMeg3k1nCON9TNiHxs3M6sV+4VmBB1z/Qotjvzip1m+g0GUYat2V3vIfJddAs1dVmQA4/K1vMVzH4nbcdDEGMJoO1AUCAyK2Nyt/TZGK0UlfLkVXnMfLJkEz6JK4GT8YWeljaAMyadKtr9IXcmbRqSrxP+US+TKtSNHJpuYDHsruNRdl/4e2ZQcUH+EgBMr379N5UYSj665MGK42jResjSYTe4bkWrXHP4rNDLLfKTyN6v9RrBTadKLcRVemT8nfpJBlISp9RnYU21/oUlxGt5qh//o=
x-ms-exchange-antispam-messagedata: siM/IFxDCAn7UVh9En0L+2ExZ7J7c/ZC6DStBmQcqVkECWsMhXC1pCXeM+UmkaeSolY2a7IVsorKSzBoAHZST85ay8MirjrX841VKafM6/uxmdDxfIaSIzEfChAR9v4A3hLwU7P6gZe62kmpchk2CqxJvn7Ky73v09GfQ7wPcAeooVDC7CGBa2jYuEZS0OfOA1BS0ScgsgNPCRH6AcoP7R6q+DOMPWG7MMHG/V33ieJfpRSjT3v4lBdS/5N09+p6H/71OVyLI7yCONB1iVHu3GRtxTBKkzrEaZaenCP74iuNGrPCrvnV9GqSDROWMBU/2t6t0MUq1slR+2lzYOzw0e16iZZVgH0CXEbpYIQ1GwNm5M8JOIgn50a9RmSf91x6oibFgVzEG1pYLIF0KhHrd9cCWCobRFvShU+oRRKTGXxZOJ/W2WH7peOJxSGNVzZbGimTHv2Rr9Fd5Sc6LTitmoYt0MTttPR6r5Fz6kOv5FoGs06HQC9EibiwN5oh0wDTBFaRoJc0jN7HPQvv1eMiLWM4ash5gLCU+K8lJ1LSFVgkMp8gYG55BoA8MK+PoBQLG4lvirb5jyXmM+dm//deDwW3M+srrzzh1PLZacMqpyWXaa5Ixq0vLltzwZ0zVJpo7nPpxVmyWhmSsiW+8IwapfE3IGvKfOzZ9r3bnEG3e9zpy2h5hArtrfE4K9JbQzYOIwPf+o8gzxPM3mPb3BFpzZBSS7mk5xsfidPhhbD4AAry/yVwoiRfk8L8d7oUVS0AsCTdd9PrBNmwoSiuTbZ0nqf6zZwDVwEBbXaEWofnL1U=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <143332354D2AC84E8325D995D3200778@AUSP282.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: audinate.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae39c07-89e3-463e-62ac-08d7ea4aaa00
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 01:31:09.5651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3731d38f-241d-4eab-8aa9-46fae6917fa3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ScXXUkCCNq4YDPAp3jOlWU/zY5vKFmSsvMhwhv/EvG9xFtPRy1JO/3kNXFihsVrXG4vIQSYzK5QnuxL5sfP9PaLuXMIJAeSZ5Hx6RLcU/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYSPR01MB0004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

U3lzdGVtOiBNYWMgT1MgWCAxMC4xMi42DQpnaXQgLS12ZXJzaW9uOiBnaXQgdmVyc2lvbiAyLjIz
LjANCg0KCSUgZ2l0IHB1c2ggLS1cPw0KCWVycm9yOiB1bmtub3duIG9wdGlvbiBgPycNCgl1c2Fn
ZTogZ2l0IHB1c2ggWzxvcHRpb25zPl0gWzxyZXBvc2l0b3J5PiBbPHJlZnNwZWM+Li4uXV0NCg0K
CVtzbmlwXQ0KDQoJICAgIC0tcmVjdXJzZS1zdWJtb2R1bGVzWz0oY2hlY2t8b24tZGVtYW5kfG5v
KV0NCgkgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRyb2wgcmVjdXJzaXZlIHB1c2hpbmcg
b2Ygc3VibW9kdWxlcw0KDQpJIHJlYWQgdGhpcyBhcyBzYXlpbmcgdGhhdCB0aGUgYXJndW1lbnQg
dG8gcmVjdXJzZS1zdWJtb2R1bGVzIGlzIG9wdGlvbmFsLiAgSG93ZXZlciwNCg0KCSUgZ2l0IHB1
c2ggLS1yZWN1cnNlLXN1Ym1vZHVsZXMNCglmYXRhbDogcmVjdXJzZS1zdWJtb2R1bGVzIG1pc3Np
bmcgcGFyYW1ldGVyDQoJenNoOiBleGl0IDEyOCAgIGdpdCBwdXNoIC0tcmVjdXJzZS1zdWJtb2R1
bGVzDQoNCk1hbnVhbCBwYWdlIChnaXQgcHVzaCAtLWhlbHApIHNlZW1zIHRvIGluZGljYXRlIHRo
YXQgYXJndW1lbnQgdG8gcmVjdXJzZS1zdWJtb2R1bGVzIGlzIHJlcXVpcmVkLg0KDQpJJ20gZ3Vl
c3NpbmcgaXQncyBqdXN0IHRoZSBjb21tYW5kIGhlbHAgdGhhdCdzIGluY29ycmVjdC4NCg0KLS0N
CkFuZHJldw0KDQo=
