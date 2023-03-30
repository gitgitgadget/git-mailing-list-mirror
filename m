Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF92C761A6
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 10:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjC3Kc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 06:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjC3Kc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 06:32:26 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2667692
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 03:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOjbCbWPbbAu+EQJJHH//iWqSAlChKPvTL4KbKr4MB4kpy0SW0Tytfbib39Z058IalYpsWmumgLwMb70r9ZBtKwnNEeYefjjAwjYUa0MYxtwCVTiZrQriTo+FoNAat5GOoh6uaosjwksYYsfsOzxAaPSj7jnuDmgMhCwUT72iIDdNsm2Ui6h2XRIxKWIREa3sIHrRkRW3yNSaqBdc/VX+zlD5ljs20SCMAiOFWhAvyzoPJZLpVdOxkooecLFJaOMik4m07wyuVOJR+FEhtFrIvN2Qya8ZOFUlK3v8QP5cr+aQCtEx2pm03nuuHzH40sacqS8tDa37uLIkFAQ0cU0mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SmEXO2FAgcEei2+ax6aE29q08RLi73fw4rD9uvNPc8=;
 b=Ip91DXmZ9zZkiCa12fQJyfWMxvbCEoOgfKoHRF8vuAodYPRAEEEA5wn5K5VDUghYl653LzF3VkN08SlcXZgIu1Y3onEPxDVokKW+2BrkfC1GgR5mna/Zwi2H4v2hNEIYHq9FFFzBjwyNqg6M31468HG0saNOIGI8JCrR6P8ZfLFXfyQTYAO+M4fQXAAKnYFBGSlFxepbxaoxex6hoPbryDsPBX1glOzCJsEg3S5USPBZn+Em4hOpOddmrcxoqv7fEuAGAq7P3QDzwm4OdHri0yW9c0v2dDIVGw+EWsl/RovwmjgHZPSzDPmDrCYIDLjrzZgv560bJ62LwjoeEN7PBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SmEXO2FAgcEei2+ax6aE29q08RLi73fw4rD9uvNPc8=;
 b=KO0/hYrV0cgO0T1cofnjVCkM2fyELJWdwfvPNoETVOm4EVSC0QE+pxncAziv08dRZBB4AAlvzwIwgRd/8igNiFAkrJ59gJkg5B5VDX7mn9yNC94IIIjRBPr60LgWdB1I1bdMTjP4nRYNuyKHIrAYdaWEiYkVOvJ33F+Cux8yLqMXXOCSknVDDPWf0fzHTAS/k098FUOlsXAcaGpUgM5+LXXG32KdGPZc/iezeaNVFCqiM4hrafI+kN8WCtrOidVw+AgSBcE3YRTgKwl2tvid9E9frs+1sE/BenvcQ/n60giG4yM9+2A4jdgPhnVpfUOlSdQpqiZRFTf9huIG5YdxdA==
Received: from AS1PR02MB8185.eurprd02.prod.outlook.com (2603:10a6:20b:474::9)
 by AS8PR02MB9209.eurprd02.prod.outlook.com (2603:10a6:20b:5b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.34; Thu, 30 Mar
 2023 10:32:16 +0000
Received: from AS1PR02MB8185.eurprd02.prod.outlook.com
 ([fe80::6cf1:746f:8bbf:ae7a]) by AS1PR02MB8185.eurprd02.prod.outlook.com
 ([fe80::6cf1:746f:8bbf:ae7a%6]) with mapi id 15.20.6222.029; Thu, 30 Mar 2023
 10:32:16 +0000
From:   "Baumann, Moritz" <moritz.baumann@sap.com>
To:     Jeff King <peff@peff.net>
CC:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH] docs: document caveats of rev-list's object-name output
Thread-Topic: [PATCH] docs: document caveats of rev-list's object-name output
Thread-Index: AQHZYaLfdd/na3kwpka4vNepc7/N/K8THktg
Date:   Thu, 30 Mar 2023 10:32:16 +0000
Message-ID: <AS1PR02MB81854CDA4768A8DB3C51FCCA948E9@AS1PR02MB8185.eurprd02.prod.outlook.com>
References: <AS1PR02MB8185A45DB63216699AFB2C5494849@AS1PR02MB8185.eurprd02.prod.outlook.com>
 <20230324192848.GC536967@coredump.intra.peff.net>
 <AS1PR02MB8185DF947EBC583318481E1994889@AS1PR02MB8185.eurprd02.prod.outlook.com>
 <20230328182650.GC18558@coredump.intra.peff.net>
In-Reply-To: <20230328182650.GC18558@coredump.intra.peff.net>
Accept-Language: en-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 7.51.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR02MB8185:EE_|AS8PR02MB9209:EE_
x-ms-office365-filtering-correlation-id: 4f70222d-81cc-4c49-94f0-08db310a08ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v9E5wHNmiH+Bkr4A2p6RcCZJ3kyFxIgCOx3mRVMy9mNSFeA3emgnP9f10XC/wVo5j6xXkBt5Yo5NUMh1qAIoVVzkMjRb2BFQRu48M+w5kvwQnjPOuQ7+eHnL0i24wvbhUdkRAqE2gCr2z3I4MXkUEUUNI1MuK0y62AS6aMf76GWnHkUyhucC4BSmrjhun4+Rv/QzQJqdkvUDog1TbwSjpwPe6Z0gnRHEnNvyO6R3sLsAEU+iIz/1qGP8AvtXkxDd5rqm4QLxkgrCDtgAt5nAPFooQVFqI4qUNvJz/pItcf0UbqNyBCnexJ49WA2NUGYM1YTccfuew1vYGDUdEnC9ZriM63nNrrcUcooyqKpVpko09E5OxR4WdNwnW6RU0TtVT8Q4Qo/PYk1WXOiLV+Ty+lJeOgOoUHGiJvSYqcEt8VheX7xGU7lCHvUPgRIFP/5lS5lVoaw1sPng0h38QqDMk88+qqVowZtyUMeGcrGRtM43GjVgL8itsuYc1AKDvASuluXWzD2nyEuechV4iAJOB7x3pCNH5sy8+v6Kr7tiQ9meG+PXskPIndiAVxavux8p+4nq+qwLrj0NE0KATxQemrteJAY4DyU+3lbHKfjEEiI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR02MB8185.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199021)(6506007)(26005)(83380400001)(186003)(966005)(71200400001)(7696005)(82960400001)(478600001)(9686003)(6916009)(4326008)(64756008)(54906003)(55016003)(66946007)(76116006)(66446008)(122000001)(66556008)(41300700001)(8676002)(316002)(2906002)(5660300002)(52536014)(33656002)(4744005)(38100700002)(8936002)(66476007)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDErY2RzcE1xalQzMW1QYXlpOEwrQjh5L0d5L1NrSit2MzBadG1lamtjbE9I?=
 =?utf-8?B?bUdzVEIvWkhXdHZNcUdKVkJKQW04WUVMZUQ4TElZRTl2MFBZN1JKaVkrdXRY?=
 =?utf-8?B?YmllOUhqSlQ3L1oxYVJFcFFCOTZSQ1hnMENYd3BXdEhDVHZlSnM1YkZrRGpw?=
 =?utf-8?B?RDFGNjl2Sy96N2FaZXlUYmhveFFhRG5xY0gya1krOUJCY3BGV3JTWjc0N0M0?=
 =?utf-8?B?RFd0clFHN2JDeGo0NjRmYmxyeGpXZHdWQTEyYWI1cGNhWjlaenNZWkw2aFNn?=
 =?utf-8?B?eGRoZkE2alhzS0doU0NUUGJzSEplbDRwbXpaZlI1QkdzL05XVTF0Qy91SkFP?=
 =?utf-8?B?Y2pkVnh6ODVReGNSVE5hN2huT1BGbE5iTTc0RHpQMm9nTFM0WW5uR0N6ZVN5?=
 =?utf-8?B?SkNRK2tnQWpZL3k4SHJ1SFRYSHlKcE95VUl5VEZtNlJXbDNzTHlqTE9DRzBx?=
 =?utf-8?B?ZFRkRnZHSUlEUWxPOTM0YU1zMkYzVUdudkFOY05oTHRGSHRTbHhkZDJxUkpR?=
 =?utf-8?B?dTg1c1hGOTliaDN1NkpJY2NycGRLK1pGZTdUcFNTWDRMRHhoSmJQOEJ3RTIz?=
 =?utf-8?B?N3JuSzNzYm5jZVc5Y2hINEo2Vm8ycnRXNklhci96M3JsUks5aWxRRUxkanFt?=
 =?utf-8?B?U1dSUFlrWFQvUHF6NUt2UkFvejZUbHpPRldXdkhLZ0lpalVXd0h6Mk83R29H?=
 =?utf-8?B?V3FzTVhndERTUGRRNlhLTG9KaVVlTzMveU05NktKckQrTHNOQ1JCN3RWUy9u?=
 =?utf-8?B?Vkl0K2U1R3MwSjZ4WGRqSUNVUEVLaFV4cnlIU1M5T0N4VDNFZkhnNUNCc0N1?=
 =?utf-8?B?b2Q4R3hjNU5Hc2dTRXZ6UTRkMWd4ejg0ZU8yc1NzbkhqZkZHWEVkUUdmU0N2?=
 =?utf-8?B?VmFjejVYNlIvakdiRVFRTk92dHJ6UzVlRlF3bEpwN3J4bUtCMVNGcS9MMkcr?=
 =?utf-8?B?N1F5NDlnb2ljVWtxNWcwVlIvY0EzemhrektUQTkrcU1Fa3NmWmxPYW5oWlFj?=
 =?utf-8?B?VklSTzNsUzdCTTVob0pSV0JOaFF1UG16VnZpVWNDQ2gxaW5sbDlMd0NRYW9q?=
 =?utf-8?B?SFBmNzRjRmpkVC9XN05xckxSSkFPaS9TVG41dTBmMVRsWldlVEhyK3kwd3pp?=
 =?utf-8?B?Q0F5cHlITEtORjJPMmMwZWh6Q2YzOUNkU2VKeFVEeGtONEVrZnMrV2xicTN0?=
 =?utf-8?B?UnNnQ1AxcjhaYnAzQTdrbTU5M2JXbHUweWYyc0VkakRxdnJqMnUzQUVweXlF?=
 =?utf-8?B?WFN4QiszTEUzK0NyVTJ1YlZsLzVQQjV0SkJxbnpTZUQxaE9PY3FCbUdQQlZO?=
 =?utf-8?B?RlVJTFY3MU0xTmIrNVRsbUtDTGd1aHVrK3hRdzNHNk90TmErOEJqbVg1SEIx?=
 =?utf-8?B?dFd2bWtzRGE2Z0dlY21BYWxVb21iUnl6MTVhL2NPSUxZR2FaWTUwMkIwK1J5?=
 =?utf-8?B?VWlHS3V6bnJpZ09aVkZ0U3BsQTE0SjYyZ0loY1dZOURDeXBpZjgwcUpaVUo5?=
 =?utf-8?B?RjhQMVd4ZXI2VlhtZFp4OURSRm5PRnhHWlo5a2Z0eW9UUU04cit3OElPei84?=
 =?utf-8?B?cFE3ZjVqaFhjbFVaemwwNUQxOWJDSWF0RkU0TWFIOXoyY3pRN09XaU1hL0JN?=
 =?utf-8?B?RHlSQ3VVSEUycWVBZ1B4UW5VNWFIZDloWHp1K0RxUDFGRS9pUEFlSWVQSkp1?=
 =?utf-8?B?a0MvS01QZzJqY1ZSUlNjTkFyRXk3N0F2ekVCWXNLUER2bkNQN1o4b3ZDb3hz?=
 =?utf-8?B?T1F0ZDlXZWhkSjVpNW1lN3doMGNlSmx5V2RkTWlmYnNFYzFFV2x5OFRzL1FB?=
 =?utf-8?B?M0E0eVYweEpxWUR2bWhTdnN4VWRld0I1by9hMExacExNYnpLZDRSaUFSSGtI?=
 =?utf-8?B?YnlEd3VwV0ZlMkI2L0FIYktLWnJhUStZWW5xMXFCNmlQNXNZa3ppRTdRV0Zy?=
 =?utf-8?B?MkdHMFkyRVFKcGt4QyttVEIwakZySlhoWTRqc2ZmSnlxRWpwamh2R1UyWGEz?=
 =?utf-8?B?aFJoVnE5ZURZdjlZdC93bmsyWGdtNGluMnZlc0lsdEJGS3RkbDZRdEpzUndL?=
 =?utf-8?B?bWZVYURGTjk1Vmc1U0VpM210WjVoZkQ3N01aWmd6SUhpQ1hYZGNoUDIxd240?=
 =?utf-8?Q?xg2XRG/nL3Vg9L//OczhZ4l1w?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR02MB8185.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f70222d-81cc-4c49-94f0-08db310a08ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 10:32:16.7542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xf7SG3rNv4BcxNCKQlYYC1HAlOD7PLeFo7NM/e70zvuN8VYNz7pRIQiealm6e2l0GsC84shdWsfXagREvBnfNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9209
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiA+ID4gVGhvc2UgbmFtZXMgYXJlIHJlYWxseSBqdXN0IGludGVuZGVkIGFzIGhpbnRzIGZvciBw
YWNrLW9iamVjdHMuIEkNCj4gPiA+IHN1c3BlY3QgdGhlIGRvY3VtZW50YXRpb24gY291bGQgYmUg
bW9yZSBjbGVhciBhYm91dCB0aGVzZSBsaW1pdGF0aW9ucy4NCj4gPg0KPiA+IFRoYXQgd291bGQg
aW5kZWVkIGJlIGdyZWF0IGFuZCB3b3VsZCBoYXZlIGxpa2VseSBwcmV2ZW50ZWQgdGhlIG9idmlv
dXMNCj4gPiBtaXNjb25jZXB0aW9ucyBvbiBteSBzaWRlLg0KPg0KPiBIZXJlJ3Mgd2hhdCBJIGNh
bWUgdXAgd2l0aC4NCg0KVGhhbmtzLCB0aGlzIGlzIG9uZSBoYWxmIG9mIHdoYXQgSSB3b3VsZCBo
YXZlIG5lZWRlZCB0byByZWFkLg0KDQo+IEkgYWxzbyBjb25zaWRlcmVkIGFkZGluZyBhIHNwZWNp
ZmljICJpZiB5b3Ugd2FudCB0aGUgbmFtZXMgb2YgZWFjaCBmaWxlDQo+IGluIGEgcmFuZ2Ugb2Yg
Y29tbWl0cywgcGlwZSB0byBkaWZmLXRyZWUiIGV4YW1wbGUuIEJ1dCBpdCBzZWVtZWQgbGlrZSBp
dA0KPiB3b3VsZCBjbHV0dGVyIHVwIHRoaXMgc2VjdGlvbi4gSXQgbWlnaHQgYmUgT0sgYXMgYSBz
dGFuZC1hbG9uZSBpbiB0aGUNCj4gRVhBTVBMRVMgc2VjdGlvbiwgYnV0IHNob3VsZCBwcm9iYWJs
eSBiZSBkb25lIGFzIGEgc2VwYXJhdGUgcGF0Y2ggaWYNCj4gYW55b25lIGlzIGludGVyZXN0ZWQu
DQoNClRoYXQgd291bGQgYmUgdGhlIG90aGVyIGhhbGYuIFNpbmNlIGUuZy4gR2l0SHViJ3Mgb3du
ICJiZXN0IHByYWN0aWNlIiBleGFtcGxlcw0KZG8gbm90IHVzZSB0aGlzIHBhdHRlcm4gWzBdLCBJ
IHdvdWxkIGFzc3VtZSB0aGF0IEknbSBub3QgdGhlIG9ubHkgb25lIHdobw0KZGlkbid0IGtub3cg
YWJvdXQgaXQuDQoNClswXSBodHRwczovL2dpdGh1Yi5jb20vZ2l0aHViL3BsYXRmb3JtLXNhbXBs
ZXMvYmxvYi9tYXN0ZXIvcHJlLXJlY2VpdmUtaG9va3MvYmxvY2tfZmlsZV9leHRlbnNpb25zLnNo
DQo=
