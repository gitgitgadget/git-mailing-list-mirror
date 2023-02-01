Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03F3C636CD
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 13:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjBANFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 08:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBANFF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 08:05:05 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906661E2B3
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 05:05:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTOifFwh0dfbX26I+outrCj5PlMMHbMy/3+lRUBMiBQUpGjUZoyw/9mn8ZgpSd8xh0JBbshDi2CtrV1Si+SyNV3h9SaQAlJTbkfv3DZ+a3Pl4FLv2/PiO/M+aDawcpyblJUSU4xibLBXuZpDHQ+tJ01QJ6nqDCQueFW+AGhIQ6pJiNZn1TNr6czx710yzY66Iutj3F6LJCYo+cXW8N5JWMVFK2PxARzTNGaSOj4t7kqixSxIDnzvrQ6weMxbZvS/55F9TCi5joBt/zVj61JyUtYTo2mamwmq2k48otmdQ2m30uvr8Ot6JufZFCmVtpyuqh69R18T0lRMLwA/n1FyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2UqvuDmTcIXQ76AUFfIzzffworAiJDzY8w5JyofUPo=;
 b=X9Y4qNYEg+KTqnfdNXxSxDRpdQOU1pEKIfdRcKeLEyRNOKdxZGICTEalPDRCluB50LC8CdSF93mPYjGtJhi/zi86MH0dI4C7FcajJnB+OKF4eAaTUE13Z3+QDEw54APlwKDHqTgKvmQ+wz3s2XMBlnlZqpcVSk5MW91K2gLFLyAKbHR/aYJ+7jfTAuyMAfDOYJpMyFIZXZhrJvCK+xzlboiAcgwJ8X+ZF09vI7MMKDLwn1comD8wzgkIIFGZ/yW3/yNAlr9x8Q0MMBNy6o0Wrk3BYBMpxLdBJ2xMYq2iCFtQrmX9KsVxlm/FfYcqtWrZlTFy1PspwM2Q+VeS1YOAew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2UqvuDmTcIXQ76AUFfIzzffworAiJDzY8w5JyofUPo=;
 b=g3sU4K203Ao3LAS+qdJ2jyoE3JvS3lEGI8LUCAPullwisJYgr2onA035CjPlUliRJ7gHxGFqUB5914XiZjUCTBeNqR142Pfj1r/6XMrRbHB3U1OcJIi6F8rvqBpqgZnvDqubN4lmBzvGRfFrANaYqvV68jTUvHw6REg4fOr/rTCSWz84ofKfhWrStHIqtr0SI2Rm7md6ySmZY2xD86XryoZHbiMDhlwSpj7abYc2D3vVNfqE3ZGiJ5po4OTCzaEx03/7oLiC7Zia4uQG03Cac0mEMr+6bUozjqjvkRM//l5n50afvPzF0J3NPNX7kacWu+eO/fz3jo2wIAx81CYVmA==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by VE1PR10MB3839.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 13:05:01 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2533:fec7:4a5a:fcbf]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2533:fec7:4a5a:fcbf%8]) with mapi id 15.20.6064.022; Wed, 1 Feb 2023
 13:05:01 +0000
From:   "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To:     "peff@peff.net" <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "greg.pflaum@pnp-hcl.com" <greg.pflaum@pnp-hcl.com>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>,
        "gerhard@dest-unreach.org" <gerhard@dest-unreach.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>
Subject: Re: Bug: Cloning git repositories behind a proxy using the git://
 protocol broken since 2.32
Thread-Topic: Bug: Cloning git repositories behind a proxy using the git://
 protocol broken since 2.32
Thread-Index: AQHZNWIngcTCFaniJkulFJ5t06rCgK64XEKAgAASfACAAIyKgIAALwGAgADcZoCAAAbvAIAAAzIA
Date:   Wed, 1 Feb 2023 13:05:01 +0000
Message-ID: <5cca46fd1e36fdd2d11aab8144b66dd5c63057bd.camel@siemens.com>
References: <4831bbeb0ec29ec84f92e0badfc0d628ecc6921d.camel@siemens.com>
         <Y9j1RxKhNq2TnL4U@tapette.crustytoothpaste.net>
         <339359ee8a228ea108109cf852bcb7e145807dcf.camel@siemens.com>
         <CA+P7+xpgJKojMmcN9TuGDw8oduQSQk-5nUtsWc+4Seqa+eVDJQ@mail.gmail.com>
         <840bbd91453529571a9d4f13472a12f6e472d198.camel@siemens.com>
         <Y9pa/YHnrrMU/ufV@coredump.intra.peff.net>
         <494ac71b378b1afb4349a4fb86767f7f77e781b3.camel@siemens.com>
In-Reply-To: <494ac71b378b1afb4349a4fb86767f7f77e781b3.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.3 (3.46.3-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|VE1PR10MB3839:EE_
x-ms-office365-filtering-correlation-id: d71b1be4-eaea-4cae-9cbc-08db0454ed80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FD8rnEcgpVjZuqBTbiQNUhewTex7grmGPmVpgVtRn6wRsYyxUMIIC+yQN3Ab/twUYSuWm5Fo3eLlc5/Z1172jP9iBb44tdXaUCh4AQ4wdjD+zDGXEuwF/niogApYDP42tFt0GAmTVKRmON55XnIL4KFGse1HcTVlsh+0imJsbz0CxsYDYvsjTkn9vXrXLDjpE7lDb6Kqwcpd/8DatbA0jgElMu6cyUoH8TJR6fU83nzMhR2HdvJb0zKTD0y1QKqEqSy7YhSulRtg1etDmluu+q6ZS4Jlm3y/+J4HKqFQg36hydLSsKdJBf1TDz8KG5vxg/PWsyKxyUJ9cYIsFtaoeOCiXxhphNjI3rp9EG7duhbpEEUKVUe5Bw/G6mPphvl4yy5u6tszFLtPy2fgN42yS2LvAjc3iEMKxJwC39vSGD5rJKE6Egs+MsQLvAnOnHL3TDJpp+ThvRCi4tao2a9UZT7qG0NOO/mmco1DcI3NR39n21feTozLqFWnnZ67AYZSLQqkkUrl6lj9RPRhQyjo8dv1nKwfceWEL7Yzjexk5bi+MCCMhKnDlOTE/mhyk0QB+6IHP/7hX8JjqfPit+XYwU5wZl/VRgfSQtPV4WuIxfr3Kmnux6cAaetaF9cIWBd8jXlg3zzmDUh3VSyKp58u+8E/ozXzc8bmg/eI6TBVpnQQWBwbkPwzNqG8bxPAcL9mZPpKlEOZQwz8i1WvuL9moA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199018)(66899018)(36756003)(86362001)(38100700002)(122000001)(38070700005)(82960400001)(6512007)(83380400001)(186003)(6486002)(26005)(6506007)(2616005)(478600001)(41300700001)(54906003)(6916009)(66476007)(64756008)(66556008)(71200400001)(66446008)(8936002)(2906002)(5660300002)(316002)(66946007)(91956017)(4326008)(76116006)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YndVbm1IZC9zclFDelFiTU9YbkR2YUc4Z1ljKzJSdUhHSW5qR1U3Zy9SdnNX?=
 =?utf-8?B?RFErSk1NTTN2STVOYi9ZVERlNitJQVZsUjJVRkhpRGg5RkRRWFVjTW5uY2My?=
 =?utf-8?B?NUQxdkIyZ3FIMXc3bFFhcEIrdXp1YnBBbTRQRk02U1RzUytBMzZDR3BUSUxZ?=
 =?utf-8?B?Z1cwejdtOXVmK25ObUkyYWhqTUdGSTYrNm5Zblh1UVY2cy9EU3R5cXVxcVBK?=
 =?utf-8?B?c2JhcmVaVG02NGRvaEo4eG1xeGFqOEF5VTJSRkp2YTVESzF0QnNDd3VCakhl?=
 =?utf-8?B?aHEvWmd0UEducTIxQjZncElDM3hEYUtpVDZiNktzUUdLSVpXeHFZQ3o4c1M1?=
 =?utf-8?B?ZVZuUWQ2bDV6TFJPYzZpbWY3TFRBN1U4T3gxb3dzZTFWK0hOa3l2ZUI0dURr?=
 =?utf-8?B?RStSbEcyb0ZxbXBBQzJkci9KVzRNQnpINmVHNElqSVRMenE0bHVVRmN1MEJk?=
 =?utf-8?B?bENxaUpqN2E3MnFwRitDKy93QkxJck9tT0JhOXJDUHpOU01vWVlpNTFiN1FH?=
 =?utf-8?B?UjhQcjlIbmRSZVhwNlhnTmtoS1hNekh6SUVwcE54N0daa3ArQWo5emo1anpw?=
 =?utf-8?B?aHZsSDVMZjJmT2FiMmVLSDg0OVRMNkdYSm05dE83RkJyR2JhdVBUaGtVRk9w?=
 =?utf-8?B?Z0FYN1EzYW9XVWZJMThhTTdRd3RtVnp4YjUycTEwMzY4Y1JKZzdwTTAyZHpU?=
 =?utf-8?B?YUJnRXhqcGJPRWZKN0YrL0djdHdZOFJIelFkRjJCeXZXVDlJckpaOFhOMzNB?=
 =?utf-8?B?UEYyU1ZpWHJ2VHcxRWJlVW1wSVJCTHFCSWdXQ3VMUFlqSWlsNU5uR3ROYTAz?=
 =?utf-8?B?MjJIUkxxQzlaNVI4RkxJZ3krVUc1UUFyMlpPOGtreCtFLzZDTk0xT3BwYm1u?=
 =?utf-8?B?UEc5Nm1ZZHJaQlNrQjI5VGtISGNMaVVHdVQ2SFVkbTZZUGszbFJUT1ZsSnVX?=
 =?utf-8?B?SGgrZXUzR1R3RFlwYXBOTWNOME1kdWp2cFd6ZzJIN2t3TU1BbjNOYmswQVVY?=
 =?utf-8?B?QUZ4cmJXbDQwMENsOEsxWTNqODcya3ZBWFlZNnliRFdDemx2eklpN0dZWDZ1?=
 =?utf-8?B?MmNDaTlsREhIY0FmQUdXM3BIb0pWRFg3UUNLNHhIaTlLQTM3am43SGNKeGhL?=
 =?utf-8?B?bW1hRWpDWEZ5VkE2Q2pvd3R6dnZHNGFHYkVPdCtvSW8vUzlBNkk1SUQyTXNM?=
 =?utf-8?B?SU1OblZiYmNXVVJ6RGR6MDFpV05MWFV3eis2UnNKQVZmTzlJbTlDM3RidmVR?=
 =?utf-8?B?UkczWHJKcUxXNUY2RG9walRSQnJLMmtHdmZydkJ6ZGNobUdjM2FSVXBYZy9n?=
 =?utf-8?B?UUZNS1ZiUzlsNjFTdGU3bjlEeDRpUXRIWFFVMmNBZXo2UFlibDVHSkloZ2Vw?=
 =?utf-8?B?OWxJNVpkdUF5YUVLL1VneW9tM25laUw3bTV6ZEQxeS9ISGx6d2JFeE43RTZK?=
 =?utf-8?B?WVlnRGNLNXlsRi9CL2hWR0l4ZGRwU1hzRmtETTNucG9va29RRUd2a3o4NFlP?=
 =?utf-8?B?OUxMWEt4RGtJS1IvV0ExR1VxVzBubkFnditOTDRoUEVBVUNHc054Q0JSMnhF?=
 =?utf-8?B?ZC9GdjByUGV2Nmx6WCtKaVM3eWM5MjBhZ01HRkhKMFptWXc4WUJQT0ZtQk5R?=
 =?utf-8?B?VHUwa00xdmcrVHgrZlpCR2lxc1pQUkM3YUhEakJ1UmlOZmVJbVZhMVBrUkIw?=
 =?utf-8?B?RzVRNzlkU0V5WmQ2dURhcm1kTGRyUzd6REVIblJ3Y1FPcGp5bHdKYm5XWUxV?=
 =?utf-8?B?bmVpVEZNYWlmYzhoRXJzdzJyK0hRZEVHMVRVNzVvN2x6RlRSczF1V3NmZkoz?=
 =?utf-8?B?cDNxM2dwcVFvME8vYWcxMTMrSnp5eDNPMi9VK0orL0NrbnpTTUYvS29JTUs2?=
 =?utf-8?B?NnFCeHJKbWJTYmdodklEdjFKTVEwTjdKa2QyUFlmNDlJVFQwQjh0TVpoMnlO?=
 =?utf-8?B?NFhTa0lZRGtCdDBvQWlqVjhOMHNaWWVEcTNmTDdTY2Y0YWhtak9ueEpmQjIy?=
 =?utf-8?B?dWpWVzZHVm1pRy9KYUNTYTRaa0Y4T2NOLzROM0Z2eW95ZmFPRWNBN3hkTjJY?=
 =?utf-8?B?UHkzT1R2djZVSGZJOUJCOU1UcUYwWXVDcHZiUGc5SkRqMVNLa2tHMUhtdTRR?=
 =?utf-8?B?NVdjSGUvNmpXeDRaYkJnOStEMTF4ZkxEM1M4MXdtR0Vpa2xObnpHa0hFVzlP?=
 =?utf-8?Q?lSa1qH7NtPWAsppjRq+13Pg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <433BDE4B484BBA4489ADF41B819F1D0E@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d71b1be4-eaea-4cae-9cbc-08db0454ed80
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 13:05:01.1293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dE+VZXRK/C7L1sI8pHXr3OueLj52zvW2zH81uZ4NUjPYGxnzlcY5ePIdiwydp9k0ToD8dJgfsbCZzsCCAOfvzYuhamrhhXzITEmnKs9ZNc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3839
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gV2VkLCAyMDIzLTAyLTAxIGF0IDEzOjUzICswMTAwLCBGbG9yaWFuIEJlemRla2Egd3JvdGU6
DQo+IE9uIFdlZCwgMjAyMy0wMi0wMSBhdCAwNzoyOCAtMDUwMCwgSmVmZiBLaW5nIHdyb3RlOg0K
PiA+IE9uIFdlZCwgRmViIDAxLCAyMDIzIGF0IDEyOjE5OjU1QU0gKzAxMDAsIEZsb3JpYW4gQmV6
ZGVrYSB3cm90ZToNCj4gPiANCj4gPiA+ID4gSnVuaW8gcG9pbnRlZCBvdXQgdGhlIGV4Y2VsbGVu
dCBhbmFseXNpcyBmcm9tIFBlZmYgcmVnYXJkaW5nIHRoZQ0KPiA+ID4gPiBzaXR1YXRpb24gYW5k
IHRoZSBmYWN0IHRoYXQgc29jYXQgaXMgd3JvbmcgaGVyZS4NCj4gPiA+IA0KPiA+ID4gVGhhbmtz
IGZvciBwb2ludGluZyBtZSB0byB0aGUgb2xkIGRpc2N1c3Npb24uIEkgd2FzIHF1aXRlIHN1cmUg
dGhhdCBJJ20NCj4gPiA+IG5vdCB0aGUgZmlyc3Qgb25lIGZhY2luZyB0aGlzIHByb2JsZW0gYnV0
IGNvdWxkbid0IGZpbmQgc29tZXRoaW5nLg0KPiA+ID4gDQo+ID4gPiBJdCBtaWdodCBiZSB0aGF0
IHNvY2F0IGlzIGRvaW5nIHNvbWV0aGluZyB3cm9uZy4gQnV0IGdpdCBpcyB0aGUNCj4gPiA+IGNv
bXBvbmVudCB0aGF0IHRyaWdnZXJzIHRoZSBwcm9ibGVtLiBEaWQgc29tZW9uZSB0YWxrIHRvIHRo
ZSBzb2NhdA0KPiA+ID4gbWFpbnRhaW5lcnMgeWV0Pw0KPiA+IA0KPiA+IEknbSBub3Qgc3VyZSBJ
J2Qgc2F5IHRoYXQgc29jYXQgaXMgd3JvbmcuIEl0J3MgYSBnZW5lcmljIHRvb2wsIGFuZCBpdA0K
PiA+IGRvZXNuJ3Qga25vdyB3aGF0IHR5cGUgb2YgcHJvdG9jb2wgdGhlIHR3byBzaWRlcyBhcmUg
ZXhwZWN0aW5nLCBvciBob3cNCj4gPiB0aGV5J2xsIGhhbmRsZSBoYWxmLWR1cGxleCBzaHV0ZG93
bnMuIFRoZSBkZWZhdWx0IGJlaGF2aW9yIGlzIHRvIHdhaXQNCj4gPiAwLjUgc2Vjb25kcyB0byBz
ZWUgaWYgdGhlIG90aGVyIHNpZGUgaGFzIGFueXRoaW5nIHRvIHNheSwgd2hpY2ggaXMgYQ0KPiA+
IHJlYXNvbmFibGUgY29tcHJvbWlzZS4gSXQncyBqdXN0IG5vdCBlbm91Z2ggZm9yIHVzZSBhIEdp
dCBwcm94eSBpbiB0aGlzDQo+ID4gY2FzZS4NCj4gPiANCj4gPiBUaGUgaWRlYWwsIG9mIGNvdXJz
ZSwgd291bGQgYmUgYW4gb3B0aW9uIHRvIHNlbmQgdGhlIGhhbGYtZHVwbGV4DQo+ID4gc2h1dGRv
d24gdG8gdGhlIHNlcnZlciBhbmQgdGhlbiB3YWl0IGZvciB0aGUgc2VydmVyIHRvIGhhbmcgdXAu
IEJ1dCBJDQo+ID4gZG9uJ3QgdGhpbmsgaXQgaGFzIHN1Y2ggYW4gb3B0aW9uICh5b3UgY2FuIGp1
c3Qgc2ltdWxhdGUgaXQgd2l0aCBhDQo+ID4gcmVhbGx5IGxhcmdlICItdCIpLiBOZXRjYXQgZG9l
cywgRldJVyAoIi1xIC0xIikuDQo+IA0KPiAtdCBkb2Vzbid0IGhlbHAgaGVyZS4gV2l0aCBtYXNz
aXZlIGhlbHAgZnJvbSB0aGUgc29jYXQgbWFpbnRhaW5lcg0KPiAodGhhbmtzIEdlcmhhcmQhLCBu
b3cgaW4gQ0MpIEkgd2FzIGFibGUgdG8gZ2V0IHRoZSBmb2xsb3dpbmcgbG9nIG91dCBvZg0KPiBz
b2NhdDoNCj4gDQo+IDIwMjMvMDIvMDEgMTE6MDY6MjkuOTYwMTk0IHNvY2F0WzE4OTE2XSBEIHJl
YWQoMCwgMHg1NjExMWM4NTgwMDAsIDgxOTIpDQo+IDIwMjMvMDIvMDEgMTE6MDY6MjkuOTYwMjA4
IHNvY2F0WzE4OTE2XSBEIHJlYWQgLT4gMA0KPiANCj4gc3RkaW4gaGFkIEVPRi4gU29jYXQgaGFs
ZiBjbG9zZXMgdGhlIHNvY2tldDoNCj4gDQo+IDIwMjMvMDIvMDEgMTE6MDY6MjkuOTYwMjMxIHNv
Y2F0WzE4OTE2XSBJIHNodXRkb3duKDYsIDEpDQo+IA0KPiBBbmQgdGhlbiwgd2l0aGluIGxlc3Mg
dGhhbiAwLjJzLCB0aGUgcGVlciAocHJveHk/KSBjbG9zZXMgdGhlIG90aGVyDQo+IGNoYW5uZWw6
DQo+IA0KPiAyMDIzLzAyLzAxIDExOjA2OjMwLjExODIxNiBzb2NhdFsxODkxNl0gRCByZWFkKDYs
IDB4NTYxMTFjODU4MDAwLCA4MTkyKQ0KPiAyMDIzLzAyLzAxIDExOjA2OjMwLjExODIzOCBzb2Nh
dFsxODkxNl0gRCByZWFkIC0+IDANCj4gDQo+IEl0J3MgcXVpdGUgY2xlYXIgbm93IHRoYXQgdGhl
IHJlbW90ZSBwZWVyIChwcm94eSBvciBzZXJ2ZXIpIGNsb3NlcyB0aGUNCj4gY29tcGxldGUgY29u
bmVjdGlvbiBhZnRlciByZWNlaXZpbmcgdGhlIHBhcnRpYWwgc2h1dGRvd24uIFRoYXQncw0KPiBu
b3RoaW5nIHRoYXQgaXMgdW5kZXIgbXkgY29udHJvbC4NCj4gDQo+IFdpdGggcHJpdm94eSBhbmQg
dGhlIGluZnJhc3RydWN0dXJlIGF0IHdvcmsgKHpzY2FsZXIgYmFzZWQpIHRoZXJlIGFyZQ0KPiBh
dCBsZWFzdCB0d28gcHJveHkgaW1wbGVtZW50YXRpb25zIHNob3dpbmcgdGhpcyBiZWhhdmlvci4g
DQo+IA0KPiBTd2l0Y2hpbmcgdG8gbmNhdCAtLW5vLXNodXRkb3duIHF1YWxpZmllcyBhcyB3b3Jr
YXJvdW5kIGZvciBub3csIGJ1dCBzbw0KPiBmYXIgSSBkaWRuJ3QgbWFuYWdlIHRvIGdldCBzb2Nh
dCBiYWNrIGludG8gdGhlIGdhbWUuIERvd25ncmFkaW5nIGdpdCBpcw0KPiB0aGUgb3RoZXIgcG9z
c2liaWxpdHkuDQoNCldpdGggYW5vdGhlciBoaW50IGZyb20gR2VyaGFyZDoNCg0KVXNpbmcgaWdu
b3JlZW9mIHdvcmtzIQ0KDQpNeSBwcm94eSBzY3JpcHQgZG9lcyBub3cgKGZvciBvbmUgb2YgdGhl
IHRlc3Qgc2NlbmFyaW9zKToNCg0Kc29jYXQgU1RESU8saWdub3JlZW9mIFBST1hZOjxwcm94eS1k
bnMtbmFtZT46Z2l0LmNvZGUuc2YubmV0Ojk0MTgscHJveHlwb3J0PTk0MDANCiAgICAgICAgICAg
Xg0KICAgICAgICAgICBUaGlzIGlzIG5ldw0KPiANCj4gPiANCj4gPiA+IFBlZmYgYWxzbyBtZW50
aW9uZWQgdGhhdCB0aGUgaGFsZi1kdXBsZXggc2h1dGRvd24gb2YgdGhlIHNvY2tldCBpcw0KPiA+
ID4gaW5jb25zaXN0ZW50IGJldHdlZW4gcHJveHkgYW5kIHJhdyBUQ1AgZ2l0Oi8vLiBJdCBzZWVt
cyBzdGlsbCBhIHZhbGlkDQo+ID4gPiBvcHRpb24gdG8gc2tpcCB0aGUgaGFsZi1zaHV0ZG93biBm
b3IgdGhlIGdpdDovLyBwcm94eSBzY2VuYXJpby4NCj4gPiANCj4gPiBJdCBjb3VsZCBiZSBkb25l
LCBidXQgdGhhdCB3b3VsZCByZWludHJvZHVjZSB0aGUgIm9vcHMsIHNvY2F0IGRpZWQgd2hpbGUN
Cj4gPiB3ZSB3ZXJlIHdhaXRpbmciIHRoYXQgYWUxYTdlZWZmZiB3YXMgc29sdmluZy4gVGhlIG9y
aWdpbmFsIG1vdGl2YXRpb24NCj4gPiB3YXMgd2l0aCBzc2gsIGJ1dCB0aGUgc2FtZSBwcm9ibGVt
IGV4aXN0cyBmb3IgcHJveGllcy4gSXQgX2RvZXNuJ3RfDQo+ID4gZXhpc3QgZm9yIHJhdyBUQ1As
IGJlY2F1c2Ugbm9ib2R5IG5vdGljZXMgdGhlIGNvbm5lY3Rpb24gZGllZCAod2UganVzdA0KPiA+
IGNsb3NlKCkgaXQpLCBhbmQgdGhlcmUncyBubyBlcnJvciB0byBwcm9wYWdhdGUuDQo+ID4gDQo+
ID4gVGhlIHJhdyBUQ1AgdmVyc2lvbiBkb2VzIHN0aWxsIHN1ZmZlciBmcm9tIGxlYXZpbmcgdGhl
IGNvbm5lY3Rpb24gb3Blbg0KPiA+IHVubmVjZXNzYXJpbHksIHNvIGl0IHdvdWxkIGJlbmVmaXQg
ZnJvbSBnZXR0aW5nIHRoZSBzYW1lIHRyZWF0bWVudC4gSQ0KPiA+IGRpZG4ndCBjYXJlIGVub3Vn
aCB0byBpbXBsZW1lbnQgaXQgKGFuZCBUQkgsIEkga2luZCBvZiBob3BlZCB0aGF0IGdpdDovLw0K
PiA+IHdhcyBvbiB0aGUgZGVjbGluZTsgZXNwZWNpYWxseSB3aXRoIHRoZSB2MiBwcm90b2NvbCwg
aXQncyBwcmV0dHkgbXVjaA0KPiA+IHdvcnNlIGluIGV2ZXJ5IHdheSB0aGFuIGdpdC1vdmVyLWh0
dHApLg0KPiA+IA0KPiA+ID4gPiBXaGF0IHZhbHVlIG9mIC10IGRpZCB5b3UgdHJ5Pw0KPiA+ID4g
DQo+ID4gPiBJIHdhcyBwbGF5aW5nIHdpdGggLXQgMTAgYW5kIC10IDYwIHNvIGZhci4gQm90aCBk
b2VzIG5vdCB3b3JrIGZvcg0KPiA+ID4gY2xvbmluZyBhIGtlcm5lbCBzdGFibGUgdHJlZS4gSSBn
dWVzcyBpdCdzIGhhcmQgdG8gZmluZCBhIHZhbHVlIHRoYXQNCj4gPiA+IHdvcmtzIHVuZGVyIGFs
bCBjaXJjdW1zdGFuY2VzIGFzIHRpbWluZ3MgbWlnaHQgYmUgZGlmZmVyZW50IGRlcGVuZGluZw0K
PiA+ID4gb24gc2VydmVyL25ldHdvcmsgc3BlZWQuDQo+ID4gDQo+ID4gQW55dGhpbmcgb3ZlciAi
NSIgc2hvdWxkIGJlIHN1ZmZpY2llbnQsIGJlY2F1c2UgdGhlIG90aGVyIHNpZGUgc2hvdWxkIGJl
DQo+ID4gc2VuZGluZyBrZWVwLWFsaXZlIHBhY2tldHMgKGF0IHRoZSBHaXQgcHJvdG9jb2wgbGV2
ZWwpIGV2ZXJ5IDUgc2Vjb25kcy4NCj4gPiBJdCBtaWdodCBiZSB3b3J0aCBydW5uaW5nIHNvY2F0
IHVuZGVyIHN0cmFjZSB0byBzZWUgd2hhdCBpdCdzIHNlZWluZyBhbmQNCj4gPiBkb2luZy4NCj4g
PiANCj4gPiBBbm90aGVyIHdvcmthcm91bmQgaXMgdG8gc2V0IHByb3RvY29sLnZlcnNpb24gdG8g
IjAiIGluIHlvdXIgR2l0IGNvbmZpZy4NCj4gPiANCj4gPiAtUGVmZg0KPiANCg0K
