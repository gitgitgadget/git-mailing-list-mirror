Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1760FC433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 16:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbiGTQc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 12:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiGTQc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 12:32:58 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00059.outbound.protection.outlook.com [40.107.0.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837966474
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 09:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOjGfGRkB4Ue8LEQ2Yrc7Q1uTmVdLyT+2NfGrHu5exaajpNeTtmu9TCtAcPXRtIYT5um6AF/txkTzdgtcxQx7wXQMBuz75POa6ql871ImS05xiDSpPdi3HbUHCFJXIAYDFdznW/5nEu96SsLSexkYrjJjfPkwqWnF7n4IjHhPHTqHDcZBrKaju/iK3dh5lda2a6TLS0CFFE6P3JBrS6VI6qb5aOPBa1QpWa7KGc4Rd2XIlISqx6QYHRmwrPLdinHFtX1AsDo1Fc9ov4I0Tp8qpEPcMVnY9FnGKeqgSTRCrCDzjuv2u1niFPJCwHV2hdjuOcWxZE0hv+i2Su6PyxeIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBG5lRmzHpk/9NtxNtlQfYsX6aOcePN628ajSrdGBJc=;
 b=n8JOsw82mFzGsSf+NqFMC6Fl5yShcCLZC/Ax73RM5ZHrtbKp1BSY24EV1cSi9dOwkYESirG0bIqqlwfdbKLMkRg3kQ0vfX7QkptnO+ctkw87gE8OozgxObUS77vB91cCQdWmXQ4vLX11XuI9ozafbepINSE9qfDRW5q7pHtndpXsxSC2nV6lgv6or0LdfFzeSF5NzxAX4C7kvDuYP9lRGWx2hpEYuepTX3TEDHk5WgQRNxacFN2sjKgTS11QeIRBOGcAyST8+Xd/cZhNkhuEo2Wv2RluZtgXE+hhbgX/jbAIsRWVjrgTvWhtcx8mwD0UGkvcgocL8rkkAUOc3mbWIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBG5lRmzHpk/9NtxNtlQfYsX6aOcePN628ajSrdGBJc=;
 b=M0xaHOrurBuW8R9HCZHb2SwZaqKktbb00+ZNkaGVAO16CPYvN5Bl7veTyLpBNpUmuETyGsv+tEUvkDAquUaCTmvKu6z5JFBFpBXLRI97AF9lW3s1brD4cfQQ4926zGbqCGJCtv444S7UOK7se5KPSDzyZ1JeD2OQOvJbqi9e+vx0i7Wd4K+TyeRykLOFUIBZnuLg2oGmx+KEMVGTiAzRttsh/2xvPFmuqRVD6Ry3igpOhwScVSFG7E0FF7RX+oGjFPBHszffO89V+35PDukaUznYF2UnN94j3ZjE1TUxmh/xQcjkn8X5TT25+fWJk4Hx1SEPUnef6Gml3izsyK8rqA==
Received: from AS1PR02MB8185.eurprd02.prod.outlook.com (2603:10a6:20b:474::9)
 by AM0PR02MB3617.eurprd02.prod.outlook.com (2603:10a6:208:45::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 20 Jul
 2022 16:32:52 +0000
Received: from AS1PR02MB8185.eurprd02.prod.outlook.com
 ([fe80::98a3:f871:a033:7ef7]) by AS1PR02MB8185.eurprd02.prod.outlook.com
 ([fe80::98a3:f871:a033:7ef7%3]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 16:32:52 +0000
From:   "Baumann, Moritz" <moritz.baumann@sap.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Moritz Baumann via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Tao Klerks <tao@klerks.biz>
Subject: RE: [PATCH] git-p4: fix crlf handling for utf16 files on Windows
Thread-Topic: [PATCH] git-p4: fix crlf handling for utf16 files on Windows
Thread-Index: AQHYm/l3LFy9BBJVKEKsN2z33TOv5q2HbhiSgAABjUA=
Date:   Wed, 20 Jul 2022 16:32:51 +0000
Message-ID: <AS1PR02MB8185D1041A96B0384554EE32948E9@AS1PR02MB8185.eurprd02.prod.outlook.com>
References: <pull.1294.git.git.1658294873702.gitgitgadget@gmail.com>
 <xmqqilnr4vhn.fsf@gitster.g>
In-Reply-To: <xmqqilnr4vhn.fsf@gitster.g>
Accept-Language: en-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de23866b-4e4d-4764-aca2-08da6a6d7dc3
x-ms-traffictypediagnostic: AM0PR02MB3617:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kiRHEOdG8D+aCZw3YiORTpgSnL6IwgadZuw/lUtI74EWlf2OOFCBIeg4W3dENLi3A1E7wHcD8YBlTZ7k8sBovN66qsx/SPewEOL98mbDsj0yGHITM1nJAezjrNwv/sDDaOUyfJq+rFwuUwD/B3sDhTExkr2phteRFhS2t3X5NDJzGv65zKDTkyxFYN/+DeWvUx213rE8W9bNgtLHtN1ogZL3KhrrSMt95TE4Np0kFIifilH0ZoHr9supAjqXajHVH9EtXj0uOCENLnA5/r7bvwlPVof6BJP8BGO/5ZAKxFquaAWOMqMrERY7xaWrgAtaZiWcTcExvoYB/4huJrLmdH5S/dW8V+Civ25nBw1d/MvNK3J+un8vXX5wwxT63wjneQmnla+eLFDzq1g7NtcsZqNof7sB9N/3ykk8RT+Q3/2I7Cod7WV6V/CIPyP6tjfN5O/iS0E7aPm7sZmXsfBfoTkjok0RCRJ4JtnjSM/JJOfP2UJRer+ljz9thjNTkO7kK/+x4/gTZG0ZAB3s61Bmmi1PJOwdkDEDQzTW23da0rIqX/H4jpTHPUVbHA/KhXOlVDW7rVpZ9scI6S8N4PSnywrgipdpknwOX6OiHG6MCZye3BBB2uO1fzBbU1/lNf3PsD+yhNPhemHArPpa88wVJqL9b/FyjbVLm3HwZHb8EcapQ/Un8OYZ0hhRZ2SyohDB/xxXRrE7F+p+LhbzMRKMB1nEDJ3ZClaHNb3v8Ho2t/t3mPpzuurEBIL26HyfV9fP+aXS13NYi/ybbr/bsxnROzeyF9EAWV82AP15ep45VBQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR02MB8185.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(41300700001)(26005)(71200400001)(54906003)(316002)(110136005)(186003)(33656002)(4326008)(478600001)(66476007)(64756008)(66446008)(76116006)(66946007)(66556008)(38070700005)(82960400001)(5660300002)(8676002)(86362001)(2906002)(8936002)(52536014)(38100700002)(122000001)(9686003)(55016003)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1czVWZWSEcvL2JJMklLZDNSSDdQUlFSaE5mRUtXOTJxZmRoWmMxT0M3K3RO?=
 =?utf-8?B?S2cwUmNMMzlUNU1wcVlkNjZCQWxBa1Q5ck1IQ1o0a0UveE9KZ0hWRzhJSGxn?=
 =?utf-8?B?YkExdjM5dm1VTWRoeHBGRkRBNFcrSVJVcUxRdDUvUVFTbHl2ZjBScFFtTnps?=
 =?utf-8?B?UDZZWWgvZmY0a3g1NEE0OTNKNDlmVHNnWmtvcmdUOHNCMGZ2YTJ3b1VhaTVN?=
 =?utf-8?B?RHNkRnp5UWFTR0U0clVEdndpbVFRNHBpQUlQdnlqaTBYYVgvbWhTRzZtN1Ru?=
 =?utf-8?B?ZjZBZHZITVYxNklLK1A5VXRaMk1KY2l4TE13R0t6cGxUVk43c0haNDFGdDZv?=
 =?utf-8?B?VGFhTWltYUF5b0hqMWIvdzBsNEw4WVRmeHhWSnlnYUU1V3ljcGVHRG9CUTQ5?=
 =?utf-8?B?T0pzUENxYWNCVlE4bnZWY1piTk9xaVZNRFpJeWtRdzA4dDVSRHFYeTZITkZq?=
 =?utf-8?B?Z2ZZWGUrQ25Yc1N4dVNMcDRwcHJaUDdrNU13Z3RteVBPeUZJRTc4QVlPZW14?=
 =?utf-8?B?YnRkZ3FCc3BqNVIzaTNGWVMwY3BuTUxtV2pseGM4ZzFvTFBMZWxLRHBDdks5?=
 =?utf-8?B?b3B4MFZkN282ay8zTlBwZkoyQzV0bVI5eTZ4V3ZVTGZPeU15ekE2SjB1aDhs?=
 =?utf-8?B?M0RUMGt3N3JCdFNnOGx3bllPRy84THNITTY5dWVJRTNYNFZZSk1yREc4T3ky?=
 =?utf-8?B?eUw1YVhiOWVCV3A4L3gwczU3R01RN2hXREp4ZVZiN25vNC9MMHBqcjJ0U3cy?=
 =?utf-8?B?U3NUYWwwUkF3UHBmQmFlenRkeFV3Q1JVQUNUSCs2M3pRNUsySkxCcGxXckZz?=
 =?utf-8?B?MWJqVzZQbzNhc3Qxd2lXam45Y1dUdEMrbHpjZVZQR1NSZUZwMmx1YzdTY2kz?=
 =?utf-8?B?M0YzT09acWVHYi9McGJ4aXdwN2J3aFZpeE96bHNnNnkzbEhOZGk4cy9ubVhH?=
 =?utf-8?B?YWV2NWZqU3FRM00xY0VuMW5uZG03dlo4L0JHaTAweU81NTNNbFZ3MFlHTUJE?=
 =?utf-8?B?aEQ2VWFaUHlPOHBXSkdDSm5ja1FuaHBxdi9FRzRvbWcxZ29mTE1SM3oxbG9V?=
 =?utf-8?B?b2hhQk8zSjNTSEZzTk5xRWo1L3pISDJOa3Z1eGMxWWhPSUF0SFpXNk8zeHhQ?=
 =?utf-8?B?eFZRU2JFcmNGMU9Bc0gzUVJoMTVxcHNxay9WelI4YXJnY2tIeUx6Um5wbDht?=
 =?utf-8?B?OWVqZ2VmbkdKMExJdVdXc2FvbjN0ZEgxbUtBVVdRdjU2eWlqd0xCSGhJc0Z1?=
 =?utf-8?B?Vkh4eGJnNWcvMHdSQXNEUWhmK1JCUHR3N0lScGI1K29lajJsb0dsZkZHOXda?=
 =?utf-8?B?Rmpucmh4STR3d0x3QWdQaUhGK0toUGdpUDdBMUhyTHpkU2wrYlE1eVNUNXRH?=
 =?utf-8?B?VW9vNDVFQk5vYURwdnBRMVRaY1QzQ2RSYmQ0a21iYW9KaERLNWtNZ0xweisx?=
 =?utf-8?B?M2JkT21qbDA1Rnh3WFlwd1UrcnZHUm1vU2h2bC9IdFhMSjJwcmtoREsrRHIw?=
 =?utf-8?B?VEZsWm1CbGlRaW11b21qcjQwK0R5UG5aYzlCVFo4dkR6cmx6MDg5eFZXM1NM?=
 =?utf-8?B?ZlM2cjExMWlKdTNkL29oL0NrZGFRT3lvZ0VIOGdoVHZaWHhUbTQ1YVBmc0RP?=
 =?utf-8?B?cUlNQUxaWlhpOVhKOW1oRGVZZUNuU0JVMHlHcmRpNFVxWFQxd25QTUdWZ3JR?=
 =?utf-8?B?VnVOWE55cHJzcDkyMVI0YkN3RW5VN1RUNXZPVStIUlVqUVp1dzR5OFd4Rzdv?=
 =?utf-8?B?LzVPd3hqbXpWWWtHSUczTW5hSnRVa05USUxQTHZYU05jMFNpV0tDbkE3NlJk?=
 =?utf-8?B?YTdTLzRQemVINDg5T2Y4NGxkb2ZDN2NXYkY2NjdCRDhOZVZiNTRmMmh5dldr?=
 =?utf-8?B?bFFsaE9aSjA4MTJ6aE5HRHpLclBEeWZkSmZHckp4YWlHU21DME9tV0ltVi93?=
 =?utf-8?B?U0ovaFRFYThFS3BPbjNTaTdMaU00ZlpsOXhCd0hqby9oT1d6eWxOS01MdHkr?=
 =?utf-8?B?WHEvUFJDRnBjZ0IvK3VlaWx1SWFSRkEwaGxTU1pwVEt6eFROV3ErMWtHR0Fo?=
 =?utf-8?B?NS9SSnZTNCtuOU50SkdXV2l1REdVRXlwcXloV1QzeFZiY1ZHZ29XMDhMdnhB?=
 =?utf-8?Q?UJ/ISpRoFcpkw6o1GiTOnjCjO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR02MB8185.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de23866b-4e4d-4764-aca2-08da6a6d7dc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 16:32:51.9989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: um28bvQwkt9gvVarwc8qKw2So/LjDTrM/z/JPLyO4unDv3mRrT+4l0QjEt3teDi9i4KnQVwc/xBXCTaSJI59/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB3617
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgSnVuaW8sDQoNClRoYW5rIHlvdSBmb3IgeW91ciBub3Rlcy4gSSBhc3N1bWVkIHRoZSBpbnRl
bnQgb2YgdGhlIG9yaWdpbmFsIGNvZGUgd291bGQgYmUgY2xlYXIsIGluIHdoaWNoIGNhc2UgdGhl
IGZpeCBzaG91bGQgYWxzbyBiZSBjbGVhciwgYnV0IEkgYW0gaGFwcHkgdG8gZWxhYm9yYXRlLg0K
DQo+IENhbiB5b3UgZGVzY3JpYmUgYnJpZWZseSB3aGF0IHByb2JsZW0gaXMgYmVpbmcgc29sdmVk
IGFuZCBob3cgdGhlIGNoYW5nZQ0KPiBzb2x2ZXMgaXQgaW4gdGhpcyBwbGFjZSBhYm92ZSB5b3Vy
IFNpZ24tb2ZmPyAgW+KApl0gSXQgdGFsa3MgYWJvdXQNCj4gIlVURi0xNiBmaWxlcyBvbiBXaW5k
b3dzIiwgYnV0IGRvZXMgaXQgbWVhbiBnaXQtcDQgcnVubmluZyBvbiBXaW5kb3dzIG9yDQo+IGdp
dC1wNCBydW5uaW5nIGFueXdoZXJlIHRoYXQgKG92ZXIgdGhlIHdpcmUpIHRhbGtzIHdpdGgNCj4g
UDQgcnVubmluZyBvbiBXaW5kb3dzPyAgSU9XLCB3b3VsZCB0aGUgc2FtZSBwcm9ibGVtIHRyaWdn
ZXIgaWYgeW91IGFyZSBvbg0KPiBtYWNPUyBidXQgdGhlIGNvbnRlbnRzIG9mIHRoZSBmaWxlIHlv
dSBleGNoYW5nZSB3aXRoIFA0IGhhcHBlbnMgdG8gYmUgaW4NCj4gVVRGLTE2Pw0KDQpUaGUgcG90
ZW50aWFsIHByb2JsZW0gdGhhdCB0aGUgb3JpZ2luYWwgY29kZSB3YXMgdHJ5aW5nIHRvIHNvbHZl
IGlzIHRoZSBmb2xsb3dpbmc6IElmIGEgZmlsZSBpcyBtYXJrZWQgYXMgdXRmMTYgaW4gUGVyZm9y
Y2UsIGFuZCBpZiB0aGUgUGVyZm9yY2UgY2xpZW50IGlzIG9uIFdpbmRvd3MsIHRoZW4gUGVyZm9y
Y2Ugd2lsbCByZXBsYWNlIGFsbCBMRiBsaW5lIGVuZGluZ3Mgd2l0aCBDUkxGIHdoZW4gdGhlIGZp
bGUgaXMgc3luY2VkLiBUaGlzIGlzIGRpZmZlcmVudCBmcm9tIGdpdCdzIGF1dG9jcmxmIGJlaGF2
aW9yLCB3aGljaCBpZ25vcmVzIFVURi0xNiBlbmNvZGVkIGZpbGVzIGFuZCBhbHdheXMgdHJlYXRz
IHRoZW0gYXMgYmluYXJ5IGZpbGVzLiBXaXRob3V0IHNwZWNpYWwgaGFuZGxpbmcsIHRoaXMgY2Fu
IGxlYWQgdG8gZ2l0LXA0IGNyZWF0aW5nIGZpbGVzIHdpdGggZGlmZmVyZW50IGhhc2hlcyB3aGVu
IHJ1biBvbiBXaW5kb3dzLiAoV2hpY2ggaXMgaG93IEkgc3R1bWJsZWQgdXBvbiB0aGlzIGlzc3Vl
LikNCg0KVGhlcmVmb3JlLCBnaXQtcDQgY2hlY2tzIHRoZSBQZXJmb3JjZSAiZmlsZSB0eXBlIiBh
bmQgdHJpZXMgdG8gdW5kbyB0aGUgbGluZSBlbmRpbmdzIGNoYW5nZXMuDQoNCj4gU28gdGhlIGlu
dGVudCBvZiB0aGUgZXhpc3RpbmcgY29kZSBpcyAid2Uga25vdyB3ZSBhcmUgZGVhbGluZyB3aXRo
DQo+IFVURi0xNiB0ZXh0LCBhbmQgYWZ0ZXIgc3VjY2Vzc2Z1bGx5IHJlYWRpbmcgJ3RleHQnIHdp
dGhvdXQgZXhjZXB0aW9uLCB3ZSBuZWVkDQo+IHRvIGNvbnZlcnQgQ1JMRiBiYWNrIHRvIExGIGlm
IHdlIGFyZSBvbiAndGhlIG5hdGl2ZSBOVCB0eXBlJyIuICBQcmVzdW1hYmx5DQo+ICd0ZXh0JyB0
aGF0IGNhbWUgZnJvbSBwNF9yZWFkX3BpcGUoLi4uIHJhdz1UcnVlKSBpcyBub3QgdW5pY29kZSBz
dHJpbmcgYnV0IGp1c3QNCj4gYSBidW5jaCBvZiBieXRlcywgc28gZWFjaCAiY2hhciIgaXMgcmVw
cmVzZW50ZWQgYXMgdHdvLWJ5dGUgc2VxdWVuY2UgaW4gVVRGLQ0KPiAxNj8NCg0KRXhhY3RseS4g
VGhlIG9yaWdpbmFsIGNvZGUgdHJpZWQgdG8gZG8gdGhlIHJpZ2h0IHRoaW5nIHRvIGVuc3VyZSBz
dGFibGUgaGFzaGVzIHRoYXQgYXJlIGluZGVwZW5kZW50IG9mIHRoZSBvcGVyYXRpbmcgc3lzdGVt
IGdpdC1wNCBpcyBydW4gb24sIGJ1dCBmYWlsZWQgdG8gZG8gc28gc3VjY2Vzc2Z1bGx5LiBXaXRo
IG15IGZpeCwgSSBmaW5hbGx5IGdvdCBkZXRlcm1pbmlzdGljIGhhc2hlcyBvbiBteSB0ZXN0IHJl
cG9zaXRvcnkuDQoNCj4gV2l0aCB0aGF0IChzcGVjdWxhdGl2ZSkgdW5kZXJzdGFuZGluZywgSSBj
YW4gZ3Vlc3MgdGhhdCB0aGUgcGF0Y2ggbWFrZXMgc2Vuc2UsDQo+IGJ1dCB0aGUgcGF0Y2ggc2hv
dWxkIG5vdCBtYWtlIHJlYWRlcnMgZ3Vlc3MuDQoNCkRvIHlvdSBuZWVkIG1lIHRvIHJlc3VibWl0
IHRoZSBwYXRjaCB3aXRoIGFuIGV4cGxhbmF0b3J5IGRlc2NyaXB0aW9uPyBJZiBzbywgSSBjYW4g
dHJ5IHRvIHN1bW1hcml6ZSB0aGUgYWJvdmUuDQoNCkJlc3QgcmVnYXJkcywNCk1vcml0eg0K
