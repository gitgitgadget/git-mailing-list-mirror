Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C807C07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 19:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiIXToa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 15:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiIXTo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 15:44:29 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A373A491
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 12:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyXmaiuO0N59UceB3rFz8JmJyGS1W6ew5DfNUJqOAX/7R1ZnfYd+4Q4+To2MJPQ8Wss0Knha3BsQ9zMJh5mROGXpK8o5BkU4bivK5o4Q15/wLBk7F67fm6Hgl4t6q7GlzCIcW0W8ZpdzXstP8L8X7xmotsbzuub2A5WJv3z6gJ1kTWnZLNkAPNGPA0sOwuicAR8PIna6P6iJ5riTfRwWhYphXC+EwLRgCJ5AkAKuWM5ranqmQYnOye3vWSRW5FO9LutZguxsuIzJ0XJPlggIt5ohn4lWmlpnrDyV+hq42d1fQdbo+vYaCo0dYH637TFTeI3rsHQ4RVauIbPmoS1Xig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ad/YMsYNKVO9tcpHydAYB4ayPCbgLhXURZ0eY+M/Ozg=;
 b=DYsbqdAJGdPluk2FC27HzpgXjKtka3k8ME0lXRRfoK53u/HzCEzSThilFSFcOJjApdCYa37XfJR8E4kXcC11hBPu71ddh+4ONZxSqtnxRbEZpzNmZooMW+lgqg27rYBo/ajdKg61CErjSw2hbyr+z3nnSXShSQTP1++jfiSewUpSsh39TO/QEuhPQJ7avimhQUI/ZMVT83xljAS10xTi8OStF33RUnXzalueS9hE/9/dHUirz9QoD9Dk1bcPdeLWt/Xyq2BKQ+YSsZLBSU7mKqeAi4W+HU8bupDscCq10DM+qt+RDiPIfwP2wnd4Y+a+8N0l8bmOrFbqy2oVrt8cHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ad/YMsYNKVO9tcpHydAYB4ayPCbgLhXURZ0eY+M/Ozg=;
 b=Qrtkn2RECiJOlbhnOGWjlm8vD5M0Q/cXIJn21/kcXsn0pXBY9tzQLrlN3HhsRAw0TM9jnqTDqzn/wCuO4aw27gBkx9GeI1qZdtepPOmPyCR/4tf/lGfP4wnqX/ApbZ/K9iyXs+5KBZ+VULYS7L11T8QSOGs1JGUXyAN+RF9w56QoRBBvUwx0vIKMIyyCkxr2n3fNzhDvHtMGKEAWbIu7BEils4pOhSQSBf29LsNNTwgsgQvXTOonvqgYi8thfCElzTOtQBDiBhy+hYIlMQEr9jJc153NcWALCUQYj5DVoRU3XdqTyfJbFt+950fv/WZdxGwTP+VyqDnjcK+jhoyp4Q==
Received: from PH0PR06MB7639.namprd06.prod.outlook.com (2603:10b6:510:4e::18)
 by SJ0PR06MB8391.namprd06.prod.outlook.com (2603:10b6:a03:38b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sat, 24 Sep
 2022 19:44:23 +0000
Received: from PH0PR06MB7639.namprd06.prod.outlook.com
 ([fe80::b8e8:9340:e9ea:7f18]) by PH0PR06MB7639.namprd06.prod.outlook.com
 ([fe80::b8e8:9340:e9ea:7f18%8]) with mapi id 15.20.5654.022; Sat, 24 Sep 2022
 19:44:22 +0000
From:   "Scheffenegger, Richard" <Richard.Scheffenegger@netapp.com>
To:     =?utf-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git --archive
Thread-Topic: git --archive
Thread-Index: AdjOYUggigRgkiEITWKCyoo+Qa1cmQAXoZumAAAHifAACZc6AAAg48+QACJ71oAABKMwwAAEeeQAAAzPrxA=
Date:   Sat, 24 Sep 2022 19:44:22 +0000
Message-ID: <PH0PR06MB763997C841605AEA42D8E8A986509@PH0PR06MB7639.namprd06.prod.outlook.com>
References: <PH0PR06MB763962EB6321F85803C5CE2D864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
 <xmqqleqbxj4h.fsf@gitster.g>
 <PH0PR06MB7639720FB3A1611F4C96E52C864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
 <Yy0ChPPqZUwVFyAt@tapette.crustytoothpaste.net> <xmqqedw2vysc.fsf@gitster.g>
 <8eb5131e-5ae1-79bd-df0c-bf0b2ec8583f@web.de>
 <PH0PR06MB7639DAA5CA112495E3EB43AB86509@PH0PR06MB7639.namprd06.prod.outlook.com>
 <712ffe78-c3e3-dacf-c3e3-f339385e9bb4@web.de>
In-Reply-To: <712ffe78-c3e3-dacf-c3e3-f339385e9bb4@web.de>
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
x-ms-traffictypediagnostic: PH0PR06MB7639:EE_|SJ0PR06MB8391:EE_
x-ms-office365-filtering-correlation-id: ca77dfcb-4c41-4bce-33d7-08da9e652e1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XCgffIzRdwnfqn9EfPQPKwL3aGSp0+FOavHSWTRvrbka0ZPa38yWpNxgpjHeXPmTNqSAqEy9k+TjMvRoSnFwXM9uZL99jTUjh+Jw5SMnZEaVhCof7605q87mZ0ocn8nE10bEpIuGS9uKbaW+Ts7ZbiynCGmJH6HZwdglWsvsnTQbRFX/6Vexi6ph9pnqy+9u7UkgSiKSBvsgc8cNU7C1eA6+FuvmcLioApRGfiTh2zs9QNZS/Ugrc4U2Hn0/lA2dEpW5aYH5QMtLNn7Ruj8FrYCqbTxGuHrpGeunO8CM26jpPwUOJv8kQF35aSU+OBwjZaN/my6TnRX8Fjuj7t1VhWPjmU8btyDSn5pc8CwnPISgp0tpp5cCD7lmOyKB2eYdGc9fwZeF+L9nBC65h3eiY0IkvfjBLWaGqVBMFKjGo6j7qhGH/VVE8fT9bfl6Cc98tj817IOHYn1x9/SDlVfcouJgpXXFUzm3rgHtA6BU31UpZJmynL9z4fSmrAMcVZFw1CbhoNXeVOKteTQUL4TjY0mc/lfe3g8MLFe82MtYhtJV0rRH/YjJ9aDghw6y9OUp4zjJArzVrA6LUCP1bEudeKbsQtvxDpKrUnQG4AIz715GkpkhJqU3rhTsh7lwvnTsbA+kZATflyAd3QOQ7mu1Quf9QHGVh5n3zP0hxqIDym5O7ZU4DAOuzlVszW3N7NQ30LSR6Z8WpCZ2IkHywdJ9YinTEAMfXhoM+26e6hrZc5LvQbAohUyQS8YqFKoSaEIUOFsPP7Q1+UfLCMoJuokh2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR06MB7639.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199015)(6506007)(7696005)(66899012)(41300700001)(86362001)(8676002)(55016003)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(38070700005)(110136005)(33656002)(52536014)(8936002)(5660300002)(2906002)(316002)(71200400001)(38100700002)(122000001)(26005)(9686003)(478600001)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2t1dFRqUzhhaThSRWRWSGZtWEhzalBqdmdmSjNodnY5WjRyZVdMN1RYYU5S?=
 =?utf-8?B?ZVZpSWVqd1NFVFkxRTQyb3NCMncvS3o3ejhLemlaN2padGsyN0l0NmpSUUVG?=
 =?utf-8?B?RFAxZWFrK1V6NkZTSjFveFdCSmNaeDgwRi9Md1RHeDExcFg4eTJYTFJ5alJr?=
 =?utf-8?B?Rm9BcnFVVjJzSUhlNGZlMGUzZ2dEYUc5bVZOZExxTWZ5UVRoeit2bXZYZUlC?=
 =?utf-8?B?ZXVHZk4vbmlsVEpSdGVGcC9QcHhjdWNGUFY1SlNRTnh4Ymt2R2kwUU5tNXRp?=
 =?utf-8?B?Njk5YThXSHY2bDh2OFczMlphblZudS9Qa2JlS3M5UWduQUVzMldSS1VPTGhU?=
 =?utf-8?B?UURLNDJNZHFreXZIOWsyeEJKQVVidDZOMDZWOFlETThWTzM3ZTE3Nmx3UnBU?=
 =?utf-8?B?T2VWb1c5N01xbnNrdG1VR1RpaVk4Z1hnd3luZi81SnV1UHZEbjlITGMxNUps?=
 =?utf-8?B?SVdKT0Ftb1pJa25MT01aM1R3WEdrQlc5cG9yR1FBRTFQenBmUHdKbG5NMk5q?=
 =?utf-8?B?d0k2NjhyQ09HSWZYZVllQkZsaFBTazN5eUlzTURSWkp2TTlLMDBBSDUxMVRZ?=
 =?utf-8?B?ditvRUZ3SGhhRzU0RTY1RzQyaHBYRkRZVStRZGcreXJ6LzNqSDFUWEFTR0ZY?=
 =?utf-8?B?V25mQU1GWjdidWF6SUpSR1dsaitlOVdvZjBuUW00MExBRWNOYWhubkhhbTc4?=
 =?utf-8?B?bVprNkhYWlJpUnhsU2NlUmNNanREWFVMajZ3L3JsSmJRNkJaVTFzaUJlSStq?=
 =?utf-8?B?YzlnNFNPVXkzZG1KeWJ1M2VwNEg3OFlxV0w5RnVCTmRyN29vQkwwcVV0c3Bi?=
 =?utf-8?B?UjVpK3RMYU1RcUNXOVdSL00xUUl6b1hLelc3WmJURExBcGdKVEdYMnlsb2Ev?=
 =?utf-8?B?YU81bzdmektZb0RHOThUZkxRb1QwYnVJNHhTdHlJcVcxQUgvRmsxVTE2SVI3?=
 =?utf-8?B?a2xSV1Y4TEh6aVR2d2Ftc1pnUnQ1Z3ZCUzV2bkl4Rk4yZUQrQXhJTmdqMThY?=
 =?utf-8?B?K3ZWV3JRaGU3SHk5OG9rMkxRUElDa2dWYlVBNFhldnlpUFExcUQzc2prU1Bx?=
 =?utf-8?B?L1RFa3M3b0ptZDUzcW1IcE92c0dDdm1PSWNoWUxFT0VHa0I0MjY2cThoWEJt?=
 =?utf-8?B?a1A2SXRkcVN2Q255bzNteDIraGkzdit6V2d5VGRkWWptN2d3M3RhY2tXWHNw?=
 =?utf-8?B?VEkrMnB1ZGVuMEV2UTZMSVYwa2RpUUExRkc3NkNESUVWNDJHVTRXTDAwNzZq?=
 =?utf-8?B?ZjNiSnNkY0lHR2xxRVcxMzVjQ2NtS0RRZnR6RXo3eXlob3BwMnl2ZnNxN2w1?=
 =?utf-8?B?c1FHVWFLQjd2NUNXSGJSeTR1UmhRZE9vS3hGQ2NuNUhQZnhOZm5rMXd2b2RJ?=
 =?utf-8?B?empoZXZtMUNqeTJkQlJkQnVTczBSRVRSTEJmVUxaYlljL0RMaW5Fa3hWUTlD?=
 =?utf-8?B?c29rYm1QdUlLdmh3V2E2RGVzWmlycUZmNlhYZitYVldtM1AyRnRNS3hDSzRB?=
 =?utf-8?B?MHJCaGdYQ3FDU0M2Uk9XS2swMkdXSWVMTFpBUm5WRjQzck5Md01yeUpYQk8y?=
 =?utf-8?B?UmU0b0k4amFIdDRDWVhoSngwamdoSnBiQnNVWGllRmNQMG52Slc4WG43NjhX?=
 =?utf-8?B?YVZXekNIbTZ1UjZ4ZFJ6TnArekh1Q0ltY0FBTFJCdkVhaE52WU9vV0ZVZ1lh?=
 =?utf-8?B?c3lwTmRmM0pOaUlDNFdXTzVtUjUwTTdiSUVrbm94eDI0cGIrWFh3OGkyODFo?=
 =?utf-8?B?VVlYZ0xMQzF4UFd6U2VGUnhWSG5OaUt3RDJYSVVqelRMNDNlcmFwS0NmbnFI?=
 =?utf-8?B?QVQzb1hwbitPSkdCa2tzZGd6TzMycWxIVHBaWkZzcnFFTTVIV1VGUlBRcG1j?=
 =?utf-8?B?WU1BL1pBKzJ0OXVhUHB2d21va2h6WWs0cDVDVU9pOTB1MUMyOHM0TmkvNjUr?=
 =?utf-8?B?dlFnZGZ6S3RDZ0dGQWpRZTZsOEdkcWlFQU03ZG9vYzVhQUJXa0ZWd2hna0dY?=
 =?utf-8?B?eDFZUDJmSno2RUhyUEFVek1jaGg5SmlIdWcrOUZBcmJUV2VvSEM0cnRWTngy?=
 =?utf-8?B?REpFZks3MW1Zc2FqZElkZGVnSUJ1RVNKa1UwYlRHZ0ZPNlZheFNOc0RlSVVr?=
 =?utf-8?Q?xQta7/RicipmCsCwgR/I/zNvo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR06MB7639.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca77dfcb-4c41-4bce-33d7-08da9e652e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2022 19:44:22.8650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68RgDiJmws6CI43dacdowbla87igsAlM4GVVdQc3ha9yTfk62VQML1AoGB7bR6bZNWU9VUeVDpT9OR5VNPPrFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR06MB8391
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pj4gTWF5YmUNCj4+DQo+PiBHaXQgbHMtdHJlZSAtciBIRUFEIHwgYXdrICd7cHJpbnQgJDN9JyB8
IHNvcnQgfCBzcGxpdCAtZCAtbCAxMDAgLWEgNA0KPj4gLSBzcGxpdHRlZCA7IGZvciBpIGluICQo
bHMgc3BsaXR0ZWQ/Pz8/KSA7IGRvICJnaXQgY2F0LWZpbGUgLS1iYXRjaCA+IA0KPj4gL2Rldi9u
dWxsICYiOyBkb25lOyBybSAtZiBzcGxpdHRlZD8/Pz8NCj4+DQo+PiBUbyBwYXJhbGxlbGl6ZSB0
aGUgcmVhZGluZyBvZiB0aGUgb2JqZWN0cz8NCj4NCj4gU3VyZSwgYnV0IGluIGEgcmVwb3NpdG9y
eSB3aXRoIDEwMDAwMCBmaWxlcyB5b3UnZCBlbmQgdXAgd2l0aCAxMDAwIHBhcmFsbGVsIHByb2Nl
c3Nlcywgd2hpY2ggbWF5IGJlIGEgZmV3IHRvbyBtYW55LiAgU3BsaXR0aW5nIHRoZSBsaXN0IGlu
dG8gc2ltaWxhci1zaXplZCBwYXJ0cyBiYXNlZCBvbiBhIGdpdmVuIGRlZ3JlZSBvZiBwYXJhbGxl
bGlzbSBpcyBwcm9iYWJseSBtb3JlIHByYWN0aWNhbC4NCg0KV2l0aCB0aGUgaGlnaCBvdmVyaGVh
ZCBvZiBzdGFydGluZyB1cCBuZXcgcHJvY2Vzc2VzLCBhbmQgbW9zdCBvYmplY3RzIHByb2JhYmx5
IGJlaW5nIHNtYWxsLCBJIHdvdWxkIGV4cGVjdCBhIGZhaXIgbnVtYmVyIHRvIHJ1biB0byBjb21w
bGV0aW9uIGJlZm9yZSB0aGUgbG9vcCBpcyBmaW5pc2hlZDsgSG93ZXZlciwgc2F2aW5nIG9uIHBy
b2Nlc3Mgc3RhcnR1cCBjb3N0IGV0YywgYW5kIGludGVybmFsaXppbmcgc29tZXRoaW5nIGxpa2Ug
dGhpcyBpbnRvIHRoZSBnaXQgYXJjaGl2ZSBjb2RlIChwZXJoYXBzIHdpdGggc29tZSBjb2RlIHRv
IGRldGVjdCBsb2NhbCB2cyByZW1vdGUgZmlsZXN5c3RlbXMsIGUuZy4gYnkgbWVhc3VyaW5nIGlu
aXRpYWwgcmVzcG9uc2UgbGF0ZW5jeSkgd291bGQgaGVscCBtb3JlLiBUaGVuLCB5ZXMsIHJlc3Ry
aWN0aW5nIHRoZSBjb25jdXJyZW5jeSB0byBzb21ldGhpbmcgcmVhc29uYWJsZSBsaWtlIGEgY291
cGxlIDEwMCB0aHJlYWRzLCBtYXliZSAxMDAwLTIwMDAgd291bGQgYmUgZ29vZC4gKEFuZCBpbmRl
ZWQsIGRpZmZlcmVudCBzdG9yYWdlIHN5c3RlbXMgaGF2ZSBkaWZmZXJlbnQgc3dlZXQgc3BvdHMg
Zm9yIGNvbmN1cnJlbmN5IC0gd2hlcmUgdGhlIG92ZXJhbGwgY29tcGxldGlvbiB0aW1lIGlzIG1p
bmltYWwuIDEgaXMgY2VydGFpbmx5IG5vdCBpdCDwn5iJDQoNCj4gSXQgY291bGQgYmUgZG9uZSBi
eSByZWx5aW5nIG9uIHRoZSByYW5kb21uZXNzIG9mIHRoZSBvYmplY3QgSURzIGFuZCBwYXJ0aXRp
b25pbmcgYnkgYSBzdWItc3RyaW5nLiAgT3IgcGVyaGFwcyB1c2luZyBwc2V1ZG8tcmFuZG9tIG51
bWJlcnMgaXMgc3VmZmljaWVudDoNCj4NCj4gICBnaXQgbHMtdHJlZSAtciBIRUFEIHwNCiA+ICBh
d2sgJ3twcmludCAkM30nIHwNCiA+ICBzb3J0IHwNCiA+ICBhd2sgLXYgcGllY2VzPTggLXYgcHJl
Zml4PWZpbGUgJw0KID4gICAgIHsNCiA+ICAgICAgICBwaWVjZSA9IGludChyYW5kKCkgKiBwaWVj
ZXMpDQogPiAgICAgICAgZmlsZW5hbWUgPSBwcmVmaXggcGllY2UNCiA+ICAgICAgICBwcmludCAk
MCA+IGZpbGVuYW1lDQogPiAgICAgfScNCj4NCj4gU28gaG93IG11Y2ggZG9lcyBzdWNoIGEgd2Fy
bXVwIGhlbHAgaW4geW91ciBjYXNlPw0KDQpDb2xkIHRpZXIgZGF0YSB3aXRoIG5vIG1ldGFkYXRh
IGluIGNhY2hlIC0gSU8gbGF0ZW5jeSBpbiB0aGUgbWlkZGxlLWRvdWJsZSBkaWdpdHMgbWlsbGlz
ZWNvbmRzLiBXYXJtZWQgdXAgbWV0YWRhdGEgY2FjaGUgLSBoaWdoIHNpbmdsZSBkaWdpdCB0byBs
b3cgZG91YmxlIGRpZ2l0IG1pbGxpc2Vjb25kcyAofjItNHggaW1wcm92ZW1lbnQpLiBXYXJtZWQg
dXAgYW5kIGZ1bGx5IGluIGV4dGVybmFsIHN0b3JhZ2UgY2FjaGUgLSBzdWItbWlsbGlzZWNvbmQg
bGF0ZW5jeSAoMTAtMTAweCBmYXN0ZXIpLg0KDQpXaXRoIG90aGVyIHdvcmRzIC0gd2FybWluZyB1
cCB0aGUgY2FjaGUgaW4gYSBwcmUtcGhhc2Ugd2l0aCAodmVyeSkgaGlnaCBjb25jdXJyZW5jeSAt
IGFjY2Vzc2luZyBhcyBtYW55IG9iamVjdHMgaW4gcGFyYWxsZWwgYXMgcG9zc2libGUgLSBjYW4g
aGl0IHRoZSB0aHJvdWdocHV0IGxpbWl0ICgxMEcsIDI1RyBFdGgpIGJ1dCBpbmRpdmlkdWFsbHks
IGVhY2ggSU8gd291bGQgc3RpbGwgdGFrZSBzb21lIDEwLTUwbXMuIEhvd2V2ZXIsIGlmIGZ1bGx5
IChleHRlcm5hbGx5KSBjYWNoZWQsIGEgc2luZ2xlLXRocmVhZGVkLCBzaW5ndWxhciBJTyBhcHBs
aWNhdGlvbiB3aWxsIGNlcnRhaW5seSBub3QgbWF0Y2ggdGhlIEV0aCB0aHJvdWdocHV0IGxpbWl0
cywgYnV0IGNvbXBsZXRlIG11Y2ggZmFzdGVyIHRoYW4gc2ltcGx5IGFjY2Vzc2luZyB0aGUgZGF0
YSBjb2xkLiBPbmx5ICJjb3N0IiBpcyB0aGF0IHRoZSBkYXRhIGlzIGVmZmVjdGl2ZWx5IHRyYW5z
ZmVycmVkIHR3aWNlIC0gdW5sZXNzIHNvbWUgbW9yZSBjbGV2ZXIgbG9jYWwgbWFyc2hhbGxpbmcg
bWVjaGFuaXNtIGlzIGltcGxlbWVudGVkIChidXQgdGhhdCBpcyBiZXlvbmQgdGhlIHNjb3BlIG9m
IG15IGFzaykuDQoNCg0KPj4+IE5vIGlkZWEgaG93IHRvIHJhbmRvbWl6ZSB0aGUgb3JkZXIgb2Yg
dHJlZSBvYmplY3QgdmlzaXRzLg0KPj4NCj4+IFRvIGhlYXQgdXAgZGF0YSBjYWNoZXMsIHRoZSBv
cmRlciBvZiBvYmplY3RzIHZpc2l0ZWQgaXMgbm90IHJlbGV2YW50LCANCj4+IHRoZSBvcmRlciBv
ciBJT3MgaXNzdWVkIHRvIHRoZSBhY3R1YWwgb2JqZWN0IGlzIHJlbGV2YW50Lg0KPg0KPiBXaGF0
J3MgdGhlIGRpZmZlcmVuY2U/DQoNClRyaXZpYWwgc2VxdWVudGlhbCByZWFkIGFjY2VzcyBkYXRh
IChyZWFkaW5nIGJsb2NrIDEsIDIsIDMsIDQsIDUpLCB3aGlsZSB0cmlnZ2VyaW5nIHNvbWUgcHJl
ZmV0Y2hpbmcsIHdpbGwgYWxzbyBtYXJrIHRoZSBjYWNoZSBmb3IgdGhlc2UgYmxvY2tzIGZvciBx
dWljayByZXVzZSAtIG5vdCBMUlUgcmV1c2UuIFdoaWxlIHRoaXMgd2lsbCB3YXJtIHVwIHRoZSBt
ZXRhZGF0YSBjYWNoZSAoZGlyZWN0b3JpZXMsIGlub2RlcyksIGJ5IHRoZSB0aW1lIHRoZSByZWFk
LXRyZWUgdGFzayBpbiBhcmNoaXZlIG1vZGUgKDEgb2JqZWN0IGFmdGVyIGFub3RoZXIsIHJlYWQg
ZnJvbSBzdGFydCB0byBlbmQpIGNvbWVzIGJ5LCB0aGUgYmxvY2tzIHdvdWxkIG5lZWQgdG8gYmUg
cmV0cmlldmVkIGFnYWluIGZyb20gc3RhYmxlIHN0b3JhZ2UuDQoNCldoZW4gdGhlcmUgaXMgc29t
ZSBwc2V1ZG8tcmFuZG9tIElPIHBhdHRlcm4gd2hlbiBhY2Nlc3NpbmcgdGhlIG9iamVjdCBkYXRh
LCB0aGVzZSBibG9ja3Mgd2lsbCBiZSBtYXJrZWQgZm9yIExSVSByZXVzZSBpbiBtb3N0IHN0b3Jh
Z2Ugc3lzdGVtcy4gVGh1cyBzdGF5IGluIENhY2hlICh0eXBpY2FsbHkgbWVhc2luZyBhIGZldyBU
QiBub3dhZGF5cyB0b28sIGltcGxlbWVudGVkIGFzIFNSQU0sIERSQU0sIFNDTSAoSW50ZWwgT3B0
YW5lIHdoaWxlIGl0IGxhc3RlZCkgb3IgbmF0aXZlIE5WTWUpLiBTbyBhZnRlciB0aGUgZmlyc3Qg
cGhhc2Ugb2YgaGlnaC1jb25jdXJyZW5jeSwgcHNldWRvLXJhbmRvbSByZWFkcywgdGhlIHNpbXBs
aXN0aWMgdHJlZSB0cmF2ZXJzYWwgYW5kIHNlcXVlbnRpYWwgcmVhZCBvZiBvYmplY3RzIHdvdWxk
IGJlIHNlcnZlZCBmcm9tIHRoZSBjYWNoZSwgd2l0aCBJTyBsYXRlbmN5IGluIHRoZSBzdWItbWls
bGlzZWNvbmQgcmFuZ2UgLSBvciBhcm91bmQgMS0yIG9yZGVycyBvZiBtYWduaXR1ZGUgZmFzdGVy
LiBBcyB0aGUgY29tcGxldGlvbiB0aW1lIG9mIGEgdGFzayB3aXRoIGNvbmN1cnJlbmN5IDEgaXMg
anVzdCB0aGUgc2VyaWFsIGNvbmNhdGVuYXRpb24gb2YgYWxsIHRoZSBJTyBsYXRlbmNpZXMgKHRv
IGEgdmVyeSBnb29kIGFwcHJveGltYXRpb24pLCB0aGUgY29tcGxldGlvbiB0aW1lIGZvciAiZ2l0
IGFyY2hpdmUiIHdvdWxkIGJlIHNpbWlsYXJseSByZWR1Y2VkIC0gZnJvbSBlLmcgNDAwIHNlYyBk
b3duIHRvIDQtOCBzZWMuLi4gDQoNCj4gTkI6IFdoZW4gSSB3cm90ZSAidHJlZSBvYmplY3RzIiBJ
IG1lYW50IHRoZSB0eXBlIG9mIG9iamVjdHMgZnJvbSBHaXQncyBvYmplY3Qgc3RvcmUgKG1hZGUg
dXAgb2YgcGFja3MgYW5kIGxvb3NlIGZpbGVzKSB0aGF0IHJlcHJlc2VudCBzdWItZGlyZWN0b3Jp
ZXMsIGFuZCB3aXRoICJ2aXNpdCIgSSBtZWFudCByZWFkaW5nIHRoZW0gdG8gdHJhdmVyc2UgdGhl
IGhpZXJhcmNoeSBvZiBHaXQgYmxvYnMgYW5kIHRyZWVzLg0KPiANCj4gSGVyZSdzIGFuIGlkZWEg
YWZ0ZXIgYWxsOiBVc2luZyAiZ2l0IGxzLXRyZWUiIHdpdGhvdXQgIi1yIiBhbmQgaGFuZGxpbmcg
cmVjdXJzaW5nIGluIHRoZSBwcmVmZXRjaCBzY3JpcHQgd291bGQgYWxsb3cgdHJhdmVyc2luZyB0
cmVlcyBpbiBhIGRpZmZlcmVudCBvcmRlciBhbmQgZXZlbiBpbiBwYXJhbGxlbC4gIE5vdCBzdXJl
IGhvdyB0byBsaW1pdCBwYXJhbGxlbGlzbSB0byBhIHNhbmUgZGVncmVlLg0KDQpJZGVhbGx5LCB0
aGUgImdpdCBhcmNoaXZlIiBjb21tYW5kIGNvdWxkIHRha2UgY2FyZSBvZiBtb3JlIGVmZmVjdGl2
ZSAoaGlnaGVyIGNvbmN1cnJlbmN5KSBpbiB0aGUgY29kZSB1bHRpbWF0ZWx5IPCfmIoNCg0KQmVz
dCByZWdhcmRzLA0KICBSaWNoYXJkDQoNCg==
