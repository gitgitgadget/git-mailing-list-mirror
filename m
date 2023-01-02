Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F184C3DA7A
	for <git@archiver.kernel.org>; Mon,  2 Jan 2023 16:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjABQpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Jan 2023 11:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjABQpA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2023 11:45:00 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2119.outbound.protection.outlook.com [40.107.15.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA470B0
        for <git@vger.kernel.org>; Mon,  2 Jan 2023 08:44:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7iIxVGYFiGThInKEce0bquOiiHeQpgLyv+gh80EjeOXtZWDsyhpMGS966D0Qh/c6IueYTr3WYjzPkgyY8FVb5VwSayKXbboYphgHa38sQHSTY/QHccEdOJLJsm2g/smldF0AOQT2jRNWHXxdEtPOR9/fBVmgFCsBYxRYocGgmGbtIhq+qsj+DFKnsfsY9Ye0xCcKQvE31tikkIUMerOqBFjEvv8RFbSoMGFomZ/gYAuz03b75o0F9q65z929JnDa/Uug5cSrKTNHjgqc8NrzKYfxoN2pRe9xwql8sSH5/4BxmvsdGlH38s3UtLH3udIPPYzZj8JDNBdSJE9bUsOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWEhAn93BFm3gZYdtxqvcqinS2yK69JAScWmzsIy5fI=;
 b=RVfKQbxbIojSqPIsvQ3TMoFTVdCo+SBGBNDui5qfIJ05qk16FfZG3QoYAB2Uhoo820qo9CPMaGtVFf0k/oH4fueRaFlTH8aH7DRd6HTh7EMKGylREMobQYxsbvRwj+rsXkStrso0q4QSrchVPELt9GyraenOrI3Hjdb4q5/RE1EH48m3p78bVy8LGfzUy/Ms/7z2N2GbD06Csub9JsASm/cpmPgp5pk1NxPSezXVxfwRAVxvthaUwMcDqAbpl+PN5kWpaRPO3+bAygz4egkIFuWnzbStNTKrST5mKy4InnHL28/hrMTDxUqYrV6WZRzMJ+Al7Wo6ZWJ2jdlPv7ReVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vitesco.com; dmarc=pass action=none header.from=vitesco.com;
 dkim=pass header.d=vitesco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vitesco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWEhAn93BFm3gZYdtxqvcqinS2yK69JAScWmzsIy5fI=;
 b=CPZi09Fs8f2VbY2wn/aQFTNwrlbQ1Jp5xrTLl4wd4+nEqK3FbphMCRS97iDv6vJLcRFg0/Af5kCdFHKmSPiEdRbt/04omkrylC+tCrZoPRxN9TpXuF1Bubq1QJIAJu2auql/5NP/wShj6AbFkwuuhJ8rP8ZOCU2kWtdux6qWfR0=
Received: from DB5PR02MB10069.eurprd02.prod.outlook.com (2603:10a6:10:3c1::22)
 by AS8PR02MB10106.eurprd02.prod.outlook.com (2603:10a6:20b:631::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 16:44:57 +0000
Received: from DB5PR02MB10069.eurprd02.prod.outlook.com
 ([fe80::ab81:958a:a811:7de]) by DB5PR02MB10069.eurprd02.prod.outlook.com
 ([fe80::ab81:958a:a811:7de%5]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 16:44:57 +0000
From:   "Zitzmann, Christian" <Christian.Zitzmann@vitesco.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Parallelism for submodule update 
Thread-Topic: Parallelism for submodule update 
Thread-Index: AdkeucE8zVh8kEwpTW+MtNPu9m+gTQ==
Date:   Mon, 2 Jan 2023 16:44:57 +0000
Message-ID: <DB5PR02MB100691E6422F5E94228F0E0EC8AF79@DB5PR02MB10069.eurprd02.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_3f3ac890-09a1-47d3-8d04-15427d7fec91_ActionId=eba52539-610f-4ddc-959b-32cfae5f4ba8;MSIP_Label_3f3ac890-09a1-47d3-8d04-15427d7fec91_ContentBits=0;MSIP_Label_3f3ac890-09a1-47d3-8d04-15427d7fec91_Enabled=true;MSIP_Label_3f3ac890-09a1-47d3-8d04-15427d7fec91_Method=Standard;MSIP_Label_3f3ac890-09a1-47d3-8d04-15427d7fec91_Name=Internal;MSIP_Label_3f3ac890-09a1-47d3-8d04-15427d7fec91_SetDate=2023-01-02T14:50:18Z;MSIP_Label_3f3ac890-09a1-47d3-8d04-15427d7fec91_SiteId=39b77101-99b7-41c9-8d6a-7794b9d48476;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vitesco.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10069:EE_|AS8PR02MB10106:EE_
x-ms-office365-filtering-correlation-id: b4041e54-e004-4a93-32db-08daece0aeb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gZFI/wYqAbqGvjFc1DJhaTgtGO/xD+vwLOpI/KN06rugvruC4OL9swL99mYMr0keyjRGsjnnXnaJ25+bS+vIgm/POO20HP0SSOG+KNtJJKI3FsPRCSYVww53ZOX6A79MqYFTgJMViY/ESKYb9iqGD8nJLTPebumYRENMuASWueRD4lRpc7kS0YHD1S+C4js9QkSvn2d/FD848eKotMrGKFRMZrHn5CV6suy9alsESFqbBg6EaYhayXfW1mevO0rFzBS4dwWdvjzinScs4fjhjPwJ40VYytdhJYwhrfNHiGhvHcgWkrJ6oAmIkFz/WkrX6lCy0QrNDFUEl3hcaA+3HJTHJsLBP1ptJljHVO8nfqMwaWR+KQnG4rdxnGM4ELnNnc4uUKaQ9dIPUWH56AvFir1gAaz8KqO1zZkSECbtPHqlY4n1FGLvgl8aF28CR7y+wR6gFexpP3FYdKRRMCy8lBA9ySy+dpQqyxsAkwMN/U6cEBR4+4UTW7mAWSYrqKjOx+3LWsbjBXqudoE2mbSiOGedTx3uS/myogqjRVyCp0DTIkLIOyZkLX94vYeJPy9IHtN4Dec5vC9BOrthIQLn4iNSGeVj0iS6EW94pOclhPJ3/BZYH6a4IjvAKamEQvnTnP/zyLgQ0ufZR5dCg3jOPrspSIsMzF2FCiQ9q+odf/IUa+wUDkC5r/38lulCkCdWfnuaOo+oWsLQWC9932v2t33Ak7VH4oVKO9uPWEpy0b8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10069.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199015)(6506007)(71200400001)(478600001)(86362001)(55016003)(3480700007)(4743002)(82960400001)(122000001)(38070700005)(38100700002)(9686003)(186003)(26005)(33656002)(83380400001)(7696005)(5660300002)(76116006)(52536014)(64756008)(66446008)(8676002)(66476007)(66556008)(8936002)(66946007)(41300700001)(316002)(2906002)(6916009)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tjc5WExXMkNBTmx6cGlTQXVGMU5ZK1ZBaVNQZlRJRFdkWSs4WmhkK2tua0lY?=
 =?utf-8?B?OStjR2o2bkdTM09WYjdUSjlXNis0elFaWHhMVnFSWldyaE1YeWQzRHNiV0JS?=
 =?utf-8?B?WitMdFZYZWROSXBwbzJrSDZma3JvSDFWRTR0cFpKSlF1OGJTSXJSMU5NZGFn?=
 =?utf-8?B?UFozWlI5a3ZsVEVORlNTNDRNQllaazREV2JEQ0hBMFpIRGNpQUgwSERNRy9K?=
 =?utf-8?B?RGcrM1BPNUJpVGtTa1BWWWRGUDJjMUh4RGF1TjFIMGZwdi9VN1JCQURMZlZk?=
 =?utf-8?B?Vjk3T1VoMUV6OWZaL0hKbjc2VTNwRlpqa3ptTk9KNU5JQ0lhUGVUcEQvd3ZF?=
 =?utf-8?B?N3NoTUd2dmhpdXRaeUw0ZjduQXNQZnBQT0tiMVh6NW5kQ1dZTlBQZWtxMmRr?=
 =?utf-8?B?WDNYYmZNU2d1RFV4T1FDNnkzRW5jam0weHpCd3orSHZwSS8wcU51Q1JrRXV4?=
 =?utf-8?B?cXUwUWhOZW5JK0NqVCtYanEzejdMckhuK2Ewak9pVmZFdEg4alZtSktpY2FN?=
 =?utf-8?B?bzVRREh2KzlTdU5LOU1VUUtQMk8vV0RGNFZEcHVpVGZkYXhaa2JTOEtGSDdX?=
 =?utf-8?B?UTdMQUxlMzd6aUdMNUEyRytieFlaL0NpcTYzb2FqLzB1NkErWmR0Y09NSzhh?=
 =?utf-8?B?eUNFdFIxUGtaYTZyUlRRU0tzUk5JWEtGbC9McmZBcUcyZlU1eUZmbFNPREVS?=
 =?utf-8?B?V1hwRHBlWEd5ZVFHbUxPYU54RW1idWRIdlFORHZiZWRreXEyTmJ4SDJSRXEy?=
 =?utf-8?B?K1FDY2IrSVluNGhvZFR0UDRNaGRuVEdheStCUWJIYnQwalRpRmw0d2ozYkd5?=
 =?utf-8?B?eWlKa2ErMkFSZElrdTNoYkFtUXIrU3R1MXhpOVFTWWFSVzkxK1U1NzVjcURO?=
 =?utf-8?B?M2REdVE3Z3NBRUV2WWw4QzFCSUp5aTNkOSsxQjAyR0tnSlNoMVpJMTNXcDRi?=
 =?utf-8?B?RXY5eG9qczlUTU5Dc2JBMzI2VG1HS1pMWkVVdFZxU05mZ0M3WERlSm55TUFO?=
 =?utf-8?B?a1AvWCthVFNrbHhzRFZmUTNTUzY3RmFaREdHKy9HMXJaWXgxd09xOVl3OU9O?=
 =?utf-8?B?M0dqUTduUnRLUDlhSXgxMVdlSWhwN3prRnNmOXNoWE9pYUZ3ZnoyVXNzd2tI?=
 =?utf-8?B?Z3VVV2FNd0FvYkE5aWFUM2hkZmtqbE9vamlYUllIRU9HZzc4ZCtlQW9nTXVX?=
 =?utf-8?B?UEJzQjU0ODF4NEZHdmFJS3g1cFpBMW9pck4zZW9iVGlnMldGUnE5UlVLeWlG?=
 =?utf-8?B?QlcxTXp3V1JHczhkRHpBam02ZnQ5Y3Q5d25XVlQyTXZiSjJ0YUVaRVhzOVJB?=
 =?utf-8?B?ak1Od3JxUzlqTm05WklkbThjeWJHSGFqKzJGZEtnSEpnc0c0c0ZZM3Fjb2Z2?=
 =?utf-8?B?ZXZtOXlxdjgvK2tucnd2elNCajZMTHk4MlkwMFBCbkdwNFBQL0VhK21kejBG?=
 =?utf-8?B?Mnc2eHJ6bXExVUZMTlNiTE12SHljNHhOakpId3VubEU5MHhtZGxjMXVFcjRv?=
 =?utf-8?B?eVFWRHcvODdaZFc3dDZ1RkNoVTBxQktHbFhuYlI2bkhYc2lPcHVwQVg1NlBx?=
 =?utf-8?B?MzA0VHJCNkxHWVRqY3RPajV5WGp2RHRxUTIyYWQwQjcyaE1rWjBsajBzbm9F?=
 =?utf-8?B?TnYyaXFDN05yeDgwdHNRdXloYUxCOXFkNFZQRlNqVWxtQ1dSZklhMVo1blIr?=
 =?utf-8?B?RnJ1Z0tQUjYwVzhqbHlWcWFGVHh2cVBSK203ZGdGLzlFN0JvZWdtbCt5bjdw?=
 =?utf-8?B?Q1VoS0wzd1dPMDQyeXZPUmlqNzllN0loMkFPUkdtSGpFaDF1NUhhYlMwTDln?=
 =?utf-8?B?Q0hwdFg5RDRIekdWMSs0eGVEeXJFV0UvNUlEWEkvZ3BaL0QvT1U3Q3dXdk5M?=
 =?utf-8?B?aWFkN1lWS003NzZYSE00QXdhamt1NytDd24xcktycUxSNGJ4R28zbjQ5Z0Ew?=
 =?utf-8?B?ZHpkL00ya285N3JHY2hSZGFXOFhDUi84ODl3bFhaeDJMakVvN1loRDJHNGdk?=
 =?utf-8?B?dHRnSTlndm9EYUNlb09BZzE5U0Raa0dUK2NxTWcwNDJ4bXh0Z0tZUUoralVI?=
 =?utf-8?B?a01ZQVRSU1N6RVNEVEQxRkh2R0xuK0NLMWV0ZGpYREFFNGlsZDFHNHBCV3F3?=
 =?utf-8?Q?eghidAdFGgK+4Od0fQ+eiArFR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vitesco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10069.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4041e54-e004-4a93-32db-08daece0aeb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2023 16:44:57.3858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 39b77101-99b7-41c9-8d6a-7794b9d48476
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ahQSEuR+RlVPTXTsNsIkNeNwsMw8SCTLmGUgW5qxO5skjeMX9Fyh2NeSVXE60iVVeEZycfytgBxuMa0AXBZvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB10106
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8sDQp3ZSBhcmUgdXNpbmcgZ2l0IHNpbmNlIG1hbnkgeWVhcnMgd2l0aCBhbHNvIGhlYXZp
bHkgdXNpbmcgc3VibW9kdWxlcy4gDQoNCldoZW4gdXBkYXRpbmcgdGhlIHN1Ym1vZHVsZXMsIG9u
bHkgdGhlIGZldGNoaW5nIHBhcnQgaXMgZG9uZSBpbiBwYXJhbGxlbCAod2l0aCBjb25maWcgc3Vi
bW9kdWxlLmZldGNoam9icyBvciAtLWpvYnMpIGJ1dCB0aGUgY2hlY2tvdXQgaXMgZG9uZSBzZXF1
ZW50aWFsbHkNCg0KV2hhdCBJ4oCZdmUgcmVjb2duaXplZCB3aGVuIGNsb25pbmcgd2l0aA0KLSBz
Y2FsYXIgY2xvbmUgLS1mdWxsLWNsb25lIC0tcmVjdXJzZS1zdWJtb2R1bGVzIDxVUkw+DQpvcg0K
LSBnaXQgY2xvbmUgLS1maWx0ZXI9YmxvYjpub25lIC0tYWxzby1maWx0ZXItc3VibW9kdWxlcyAt
LXJlY3Vyc2Utc3VibW9kdWxlcyA8VVJMPg0KDQpXZSBsb29zZSBwZXJmb3JtYW5jZSwgYXMgdGhl
IGZldGNoIG9mIHRoZSBibG9icyBpcyBkb25lIGluIHRoZSBzZXF1ZW50aWFsIGNoZWNrb3V0IHBh
cnQsIGluc3RlYWQgb2YgaW4gdGhlIHBhcmFsbGVsIHBhcnQuDQoNCkZ1cnRoZXJtb3JlLCB0aGUg
dXRpbGl6YXRpb24gLSB3aXRob3V0IHBhcnRpYWwgY2xvbmUgLSBvZiBuZXR3b3JrIGFuZCBoYXJk
ZGlzayBpcyBub3QgYWx3YXlzIGdvb2QsIGFzIGZpcnN0IHRoZSBuZXR3b3JrIGlzIHV0aWxpemVk
IChmZXRjaCkgYW5kIHRoZW4gdGhlIGhhcmRkaXNrIChjaGVja291dCkNCg0KQXMgdGhlIGNoZWNr
b3V0IHBhcnQgaXMgbG9jYWwgdG8gdGhlIHN1Ym1vZHVsZSAobm8gc2hhcmVkIHJlc291cmNlcyB0
byBibG9jayksIGl0IHdvdWxkIGJlIGdyZWF0IGlmIHdlIGNvdWxkIG1vdmUgdGhlIGNoZWNrb3V0
IGludG8gdGhlIHBhcmFsbGVsaXplZCBwYXJ0Lg0KRS5nLiBieSBkb2luZyBmZXRjaCBhbmQgY2hl
Y2tvdXQgKHdpdGggYmxvYiBmZXRjaGluZykgaW4gb25lIHN0ZXAgd2l0aCBlLmcuIHJ1bl9wcm9j
ZXNzZXNfcGFyYWxsZWxfdHIyDQoNCkkgZXhwZWN0IHRoYXQgdGhpcyBzaWduaWZpY2FudGx5IGlt
cHJvdmVzIHRoZSBwZXJmb3JtYW5jZSwgZXNwZWNpYWxseSB3aGVuIHVzaW5nIHBhcnRpYWwgY2xv
bmVzLg0KDQpEbyB5b3UgdGhpbmsgdGhpcyBpcyBwb3NzaWJsZT8gRG8gSSBtaXNzIGFueXRoaW5n
IGluIG15IHRob3VnaHRzPw0KDQpCZXN0IHJlZ2FyZHMsDQoNCkNocmlzdGlhbiBaaXR6bWFubg0K
DQoNCg==
