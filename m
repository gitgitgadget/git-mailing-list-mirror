Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45C1C00A5A
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 23:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjAQXEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 18:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjAQXD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 18:03:57 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F85212F3E
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 13:36:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkH9czQphSdtCDW9EuDZcWucJL/D2OEjbQ2AsrqEy56wPbI2HxgzV+iT027MxjniOCl6xU0Y33773U7b1Ojch6NuIO8dCxdD3E0q6A+QhMe053hqgRNvUxNdgD7KAh8vtdyNX4oZAPDtYCxSVG0D8iKnScdxHI1r7yivazyObeXsjlHLSWNcKQZo4KuhT+GdnAwxsmUU3btz4rZrQg3E5LXQWHh2qYAFhW7ihBvEVzPOtZCmzYaceHjEwoP5IW8kjW/Exu5D8hsnWSKwUyPEIgsiYUSxihYl/RD19zb4QH2Adg2Y54p3o3o1BobDbIGWe96YN//cD0NSN59mbc/BiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YswzlSTkhhXuIV9mYQPWUCyx3Jr3cR2ncF+Q8Khbu9w=;
 b=mKlNt5tAIYlcRlw4w0WZGlDoX9oKCK1njpGCx/0UPD2rPhcaZbpSAqhurkR8VCk8MOCC28L2icb7vKW0qSlNdGS68D/rxtmB9UF+xqKwX5W9gx0auGwUuDicsHqS0VyW6ZOHwgY2PLcDj1Vborw1oDHRzgJlourw9shWmtYMT3HUOl13yVmALB/GgxPnP/R/mGShVIlObfLoX/0j5fJqbPuv80hdNBocZ/0l//6iJ3CmmaH+/SBuRZz4JFxgwerNNs0HHQZ7zn2OjPxuR8FdhKE10qGf0fUa9espH4978Ez5upRHJNatdyk5N71xsQ/XH/3jbBUEG8azq5CPtIV1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YswzlSTkhhXuIV9mYQPWUCyx3Jr3cR2ncF+Q8Khbu9w=;
 b=zX5jXop7L/AYMJvOT2UpHV5Kog8JOc6SVT63xmM2KPYi6fW1oMxZrwNuOi9NowBp/WP6m/TR0+abgC7wqVXTuS2YxFQ+hjLH+7WFLmvcAysMrXN9QXfkaxGJyErtzQLSuvSwAf5avhZD054SJNup5ChVUeqgioyWNz8hM21iOyc=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 BN9PR12MB5084.namprd12.prod.outlook.com (2603:10b6:408:135::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 21:36:45 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77%3]) with mapi id 15.20.5986.019; Tue, 17 Jan 2023
 21:36:45 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "avarab@gmail.com" <avarab@gmail.com>
CC:     "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Subject: [PATCH v5 1/2] send-email: refactor header generation functions
Thread-Topic: [PATCH v5 1/2] send-email: refactor header generation functions
Thread-Index: AQHZKrvMvsHed68DvU6Hzj+LfJmvTw==
Date:   Tue, 17 Jan 2023 21:36:45 +0000
Message-ID: <20230117213624.73926-1-michael.strawbridge@amd.com>
References: <230117.86wn5lxpl0.gmgdl@evledraar.gmail.com>
In-Reply-To: <230117.86wn5lxpl0.gmgdl@evledraar.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|BN9PR12MB5084:EE_
x-ms-office365-filtering-correlation-id: bf07127b-e729-4ef6-9857-08daf8d2ee82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LqYZixH2PiOgb0bncrrRKPyCRZqDyXZKQTmMUB0UIGxdGKDavJnqjTUVcagKuPjVQ1F8dL7XDCLBSROb9CNklMEQf+1NwnqvhSMh6lim/naJ83vf530GlSw/w+sW1kSbN3A2Po4CIQAiG4UXxkcvuAxucKMh4C9WyMPnMFyodNaPDZ7uHCI/sqlyGxbOxIltjf3J0lKXrtQkIGhd56n6mV/fk9GBAPfdmWhyQaouxt2Z50c775Z2J+OobsLIR5j4z43tmKL5/54dAuHWtUXgsBoJ+omZec8VBh+te51fVqyswR+Rg7ReQjWvWWJt93shRkPkuap2nyDeaeiaWZmm3Xu/IoGGUCnNfOMdwL1D5zNd5baEncyWbEzMHzOn7SwIfovjHAFb0SmqIuLwN8+Y8Jv0iaqMRR/GOLY3cTKQhGtmcrP0ow/mh04pG8yX8Gd3Mt5zGhDeIZQph2f7IEVdFbbaYb92oWolVnw0YxnILIX/N92jJgwqLM6gVsUkugCMIx91T94H5oHQVdlN0fh6qX72PKTKyLdrarbW+hFW5avVKFxQ0bEtM8cu/PrrnpuMLUgZLsfuUQjh2zBl/+y0Fa5TDsH/5eqetW3Tx7uIu0SYv3q22GGhZ7tcofKqwSSciW7Q6MZ5RRexeiCrEkhQaz9ywCmj2CWWR6K0BfTo56JwhEMInXzj+uep9Zl6iCpnZ2Rt3KXbwn4mcKoVgW+XDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199015)(36756003)(86362001)(38070700005)(66476007)(64756008)(76116006)(66446008)(6916009)(66556008)(71200400001)(5660300002)(66946007)(4326008)(8936002)(8676002)(2906002)(83380400001)(122000001)(38100700002)(478600001)(6486002)(316002)(54906003)(66574015)(91956017)(41300700001)(2616005)(1076003)(26005)(186003)(6512007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3VZL0twZURNWGpsMFBDTHl1cVRsZXFHT3hZN3JQNW4wNmcreGMzV2dGMDRI?=
 =?utf-8?B?cHplc2FXMm85YS82Tmo0dW1PQ0dHOURFbmF6bEZIcllIMHgxMmJSbHFPdHZI?=
 =?utf-8?B?K1dJNEF1Y3NmRlJyRFVJNVZ3Zy9yWGpYcGw5WVErR2R5aUdTbDNBWVBQZDRT?=
 =?utf-8?B?bGVoeGRMU3o2dXd4WmpybS82Q095YlRhSkNqZzhiMEc0emg2bGxjNEhrWWdu?=
 =?utf-8?B?ajVlNzBZcjA4OEZyNVBXWXBqSEE0UnFQN3B3NW16S3Y2TXZJVUYxTVdXOXdB?=
 =?utf-8?B?U3ppb05sNEhRTys5aitLRDlaSlRKN0hiWmZKNEFwRHordWtaOEFBR1U2Q2Vk?=
 =?utf-8?B?akJUekpHVkpzQ05LZE15a0xYbWpSand4WlFZYjBsM0I3eVYvY1ZwWDRMc2NE?=
 =?utf-8?B?N084OTJDQVZSc0RYbTdNWFVKVThjdlZjQ0VOYi9KcHFBODBBQktGZ1k5Q1BP?=
 =?utf-8?B?OFE3RVZUalBWRXRzUlpFWk92UHp4MDQ4NVg5L3RtUHpSTzI5Uzd1aFJPTUU1?=
 =?utf-8?B?Y296aEdYakNhSmoyaVNCRWFPVGRheWhhK2V3ZzNweDdDd243dXJMK2tqdTZ0?=
 =?utf-8?B?eFdQUXlZeHFleTgyMjdTNGRVYXA1M0tvMEI2endrOWxMOEhrUmtDb3RVUzQz?=
 =?utf-8?B?bnJjN3N2M2E5RzBTK0NVTkhiNENSeHFEYS9kbkhPTlpZeC9hbU1nNFFITE8v?=
 =?utf-8?B?ajdxZWtjcDVOcWNkbGVoL0ZCWS9WekZ1a2pEaXJVYmd2Y0NyWFgzQ3gwNmZK?=
 =?utf-8?B?ZHhxcHVSK2pveXBWUnZiR2NuVVBIR1hURVFEQitUYlFhUlFqZy9nN0hSMHp1?=
 =?utf-8?B?OFU0MVpFNUJnRlRjNWw1RHROdDNTT1YzMllWTXQ0MXJKWmZFbTliUlZMVnQw?=
 =?utf-8?B?VS9Vc3ZqM2hYQkVMS2hVQW5yTzk3bnplTjJMczhLc3pZbWY5eFg5NUkyRUFO?=
 =?utf-8?B?SFE4T2dhTlM2Vi9UdXlCR3JLeTJhNkdxZS9Jb3ZLeUE1anhvYVh3STBWR0tk?=
 =?utf-8?B?MWNrS3Z3SFBEUWJidDNHaDdGWWRMNC96eWs4S1YxSnlCQ3cySTIxeitxVEc2?=
 =?utf-8?B?OXlwUHRJZXQ3V1Z6dVZYZ2Z4ZDBUSUhxQUMyYTNWMVhPeTdBYXYxWE94Vnhu?=
 =?utf-8?B?Um54OVVJQmNCU2tVd3NsUnFEbnQ1cmJ4MHYyVktrZ0JSRnA2R2NCZGZsN0lN?=
 =?utf-8?B?cHA0cFU0cEd4QWtzOEpSZ0piNFp2c0FUNlRlNUN3YTQzVTJ2Ui9mbGxGYzds?=
 =?utf-8?B?YkpJUktDNHorWmppd2hER0JNUFdnSVh0djJXWEhKRDh1OHZER0kyVzNMMUdz?=
 =?utf-8?B?S3I0NUpaVUFXQ3FFdEF3RTRBZ0tBd1N5d1kvZ0hOTklaREMrOXNBNnlJMXdq?=
 =?utf-8?B?eWxORzNWMWVjZFZWNkJnaW15cEw3SndWSlZQWHEwVDdEbWs0MWczU2tRNlpG?=
 =?utf-8?B?dGJqeUNIK3phbEhzcHZKa08yK0xBaDI3VFNtUmVHSG1CTUR0dHpHcUx0d0Zz?=
 =?utf-8?B?OC9rQW9aaTNaYUw1U0RabzF5QmtPV1NOVTJvWFJiWmszODdiNlhyOHJZZWR5?=
 =?utf-8?B?RGhGcE5DMllrZjJDMStwU2xrUkNpZHV0VFpFczd0QVkwVURyTHh1NnFEUEF3?=
 =?utf-8?B?L09IMEt4VU9JWlMvWkZDMVZoUEsrSzlzTEpHZDJOc09CNXpkYmlUTFgzcW43?=
 =?utf-8?B?OUo4VkJvS1A5RVZEdFBQY1haRWVCTTZ0azV3MVRVZlhJK0hiTzY1V2VPV2FK?=
 =?utf-8?B?S0FwblVHVFh5OCtic2FsR3dDeWVxVi9BTDlVQldncTZMYWlUdTZEOTVaenVT?=
 =?utf-8?B?THE0ZXdZaWVlOEJjZS9SNEJ1VG8xUXhzNGw4Wm1CRXY2bDhKcTByKzlXaktC?=
 =?utf-8?B?L3A0bGE5SWxOL3RoZnNEekwrVGx3NEFxNk5jeDB4a1lHS1cxOHJIZGxqL0FZ?=
 =?utf-8?B?ZkFhYWJOak96ZG1VSEFsbW43ekNwdEJ1L3FoUTMwZ0UzZUN1dTNlRnRwQWE1?=
 =?utf-8?B?Y1A0TVVFYWM2bGpVRWZTOVExZUZqTnpVeE1EMHpWWTZycHl6a2xQazFXVWov?=
 =?utf-8?B?T1NVeDVYc0Rwc0VTK0g5NEd3VVROZWhDV3k3NjlWRFJVZmNkZGVLY3d2bXU5?=
 =?utf-8?Q?gwGzIllbBBabm+eLSsFfJoN40?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92EBA34F0EB7694FA0BB6F3D2237B273@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf07127b-e729-4ef6-9857-08daf8d2ee82
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 21:36:45.4546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: htYgolrIbPJwn0eURlp1EKgAOf28GfbySL+J0QcQhNF2ruD6ur173GIMZUF2Uj0QnN+gyW0L7LlXoSg/B4VSQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5084
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gVHVlLCBKYW4gMTcgMjAyMywgw4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24gd3JvdGU6DQo+
T24gVHVlLCBKYW4gMTAgMjAyMywgU3RyYXdicmlkZ2UsIE1pY2hhZWwgd3JvdGU6DQo+DQo+PiBT
cGxpdCBwcm9jZXNzX2ZpbGUgYW5kIHNlbmRfbWVzc2FnZSBpbnRvIGVhc2llciB0byB1c2UgZnVu
Y3Rpb25zLg0KPj4gTWFraW5nIFNNVFAgaGVhZGVyIGluZm9ybWF0aW9uIG1vcmUgd2lkZWx5IGF2
YWlsYWJsZS4NCj4+DQo+PiBDYzogTHViZW4gVHVpa292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4N
Cj4+IENjOiBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBNaWNoYWVsIFN0cmF3YnJpZGdlIDxtaWNoYWVsLnN0cmF3YnJpZGdlQGFtZC5jb20+DQo+
PiAtLS0NCj4+ICBnaXQtc2VuZC1lbWFpbC5wZXJsIHwgNDkgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDMxIGluc2VydGlv
bnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9naXQtc2VuZC1lbWFp
bC5wZXJsIGIvZ2l0LXNlbmQtZW1haWwucGVybA0KPj4gaW5kZXggNTg2MWU5OWE2ZS4uODEwZGQx
ZjFjZSAxMDA3NTUNCj4+IC0tLSBhL2dpdC1zZW5kLWVtYWlsLnBlcmwNCj4+ICsrKyBiL2dpdC1z
ZW5kLWVtYWlsLnBlcmwNCj4+IEBAIC0xNDk1LDE2ICsxNDk1LDcgQEAgc3ViIGZpbGVfbmFtZV9p
c19hYnNvbHV0ZSB7DQo+PiAgCXJldHVybiBGaWxlOjpTcGVjOjpGdW5jdGlvbnM6OmZpbGVfbmFt
ZV9pc19hYnNvbHV0ZSgkcGF0aCk7DQo+PiAgfQ0KPj4gIA0KPj4gLSMgUHJlcGFyZXMgdGhlIGVt
YWlsLCB0aGVuIGFza3MgdGhlIHVzZXIgd2hhdCB0byBkby4NCj4+IC0jDQo+PiAtIyBJZiB0aGUg
dXNlciBjaG9vc2VzIHRvIHNlbmQgdGhlIGVtYWlsLCBpdCdzIHNlbnQgYW5kIDEgaXMgcmV0dXJu
ZWQuDQo+PiAtIyBJZiB0aGUgdXNlciBjaG9vc2VzIG5vdCB0byBzZW5kIHRoZSBlbWFpbCwgMCBp
cyByZXR1cm5lZC4NCj4+IC0jIElmIHRoZSB1c2VyIGRlY2lkZXMgdGhleSB3YW50IHRvIG1ha2Ug
ZnVydGhlciBlZGl0cywgLTEgaXMgcmV0dXJuZWQgYW5kIHRoZQ0KPj4gLSMgY2FsbGVyIGlzIGV4
cGVjdGVkIHRvIGNhbGwgc2VuZF9tZXNzYWdlIGFnYWluIGFmdGVyIHRoZSBlZGl0cyBhcmUgcGVy
Zm9ybWVkLg0KPj4gLSMNCj4+IC0jIElmIGFuIGVycm9yIG9jY3VycyBzZW5kaW5nIHRoZSBlbWFp
bCwgdGhpcyBqdXN0IGRpZXMuDQo+PiAtDQo+PiAtc3ViIHNlbmRfbWVzc2FnZSB7DQo+PiArc3Vi
IGdlbl9oZWFkZXIgew0KPj4gIAlteSBAcmVjaXBpZW50cyA9IHVuaXF1ZV9lbWFpbF9saXN0KEB0
byk7DQo+PiAgCUBjYyA9IChncmVwIHsgbXkgJGNjID0gZXh0cmFjdF92YWxpZF9hZGRyZXNzX29y
X2RpZSgkXyk7DQo+PiAgCQkgICAgICBub3QgZ3JlcCB7ICRjYyBlcSAkXyB8fCAkXyA9fiAvPFxR
JHtjY31cRT4kLyB9IEByZWNpcGllbnRzDQo+PiBAQCAtMTU0Niw2ICsxNTM3LDIyIEBAIHN1YiBz
ZW5kX21lc3NhZ2Ugew0KPj4gIAlpZiAoQHhoKSB7DQo+PiAgCQkkaGVhZGVyIC49IGpvaW4oIlxu
IiwgQHhoKSAuICJcbiI7DQo+PiAgCX0NCj4+ICsJbXkgJHJlY2lwaWVudHNfcmVmID0gXEByZWNp
cGllbnRzOw0KPj4gKwlyZXR1cm4gKCRyZWNpcGllbnRzX3JlZiwgJHRvLCAkZGF0ZSwgJGdpdHZl
cnNpb24sICRjYywgJGNjbGluZSwgJGhlYWRlcik7DQo+PiArfQ0KPj4gKw0KPj4gKyMgUHJlcGFy
ZXMgdGhlIGVtYWlsLCB0aGVuIGFza3MgdGhlIHVzZXIgd2hhdCB0byBkby4NCj4+ICsjDQo+PiAr
IyBJZiB0aGUgdXNlciBjaG9vc2VzIHRvIHNlbmQgdGhlIGVtYWlsLCBpdCdzIHNlbnQgYW5kIDEg
aXMgcmV0dXJuZWQuDQo+PiArIyBJZiB0aGUgdXNlciBjaG9vc2VzIG5vdCB0byBzZW5kIHRoZSBl
bWFpbCwgMCBpcyByZXR1cm5lZC4NCj4+ICsjIElmIHRoZSB1c2VyIGRlY2lkZXMgdGhleSB3YW50
IHRvIG1ha2UgZnVydGhlciBlZGl0cywgLTEgaXMgcmV0dXJuZWQgYW5kIHRoZQ0KPj4gKyMgY2Fs
bGVyIGlzIGV4cGVjdGVkIHRvIGNhbGwgc2VuZF9tZXNzYWdlIGFnYWluIGFmdGVyIHRoZSBlZGl0
cyBhcmUgcGVyZm9ybWVkLg0KPj4gKyMNCj4+ICsjIElmIGFuIGVycm9yIG9jY3VycyBzZW5kaW5n
IHRoZSBlbWFpbCwgdGhpcyBqdXN0IGRpZXMuDQo+PiArDQo+PiArc3ViIHNlbmRfbWVzc2FnZSB7
DQo+PiArCW15ICgkcmVjaXBpZW50c19yZWYsICR0bywgJGRhdGUsICRnaXR2ZXJzaW9uLCAkY2Ms
ICRjY2xpbmUsICRoZWFkZXIpID0gZ2VuX2hlYWRlcigpOw0KPg0KPlRoaXMgbWFrZXMgdGhlIGRp
ZmYgc21hbGxlciwgYnV0IGlmIHdlJ3JlIHJlZmFjdG9yaW5nIHRoZXNlIGZ1bmN0aW9ucyB0bw0K
PnJldHVybiBhcmd1bWVudHMgaXQncyBwcm9iYWJseSBiZXR0ZXIgdG8gcmV0dXJuIGEgaGFzaCBy
ZWZlcmVuY2UgcmF0aGVyDQo+dGhhbiByZW1lbWJlcmluZyBhbGwgdGhlIHBhcmFtZXRlciBuYW1l
cy4NCj4NCj5CdXQgaW4gdGhpcyBjYXNlIGl0J3MgcHJvYmFibHkgZmluZS4uLg0KPg0KSSBoYWRu
J3Qga25vd24gYWJvdXQgcGFzc2luZyBhIGhhc2ggcmVmZXJlbmNlIG9uIHBlcmwuICBBbHRob3Vn
aCBhZnRlcg0KbG9va2luZyBpbnRvIGl0LCBJJ20gbm90IHN1cmUgSSB3aWxsIGdvIHRoYXQgd2F5
IHRoaXMgdGltZS4NCg0KPj4gKwlteSBAcmVjaXBpZW50cyA9IEAkcmVjaXBpZW50c19yZWY7DQo+
PiAgDQo+PiAgCW15IEBzZW5kbWFpbF9wYXJhbWV0ZXJzID0gKCctaScsIEByZWNpcGllbnRzKTsN
Cj4+ICAJbXkgJHJhd19mcm9tID0gJHNlbmRlcjsNCj4+IEBAIC0xNzM1LDExICsxNzQyLDggQEAg
c3ViIHNlbmRfbWVzc2FnZSB7DQo+PiAgJHJlZmVyZW5jZXMgPSAkaW5pdGlhbF9pbl9yZXBseV90
byB8fCAnJzsNCj4+ICAkbWVzc2FnZV9udW0gPSAwOw0KPj4gIA0KPj4gLSMgUHJlcGFyZXMgdGhl
IGVtYWlsLCBwcm9tcHRzIHRoZSB1c2VyLCBzZW5kcyBpdCBvdXQNCj4+IC0jIFJldHVybnMgMCBp
ZiBhbiBlZGl0IHdhcyBkb25lIGFuZCB0aGUgZnVuY3Rpb24gc2hvdWxkIGJlIGNhbGxlZCBhZ2Fp
biwgb3IgMQ0KPj4gLSMgb3RoZXJ3aXNlLg0KPj4gLXN1YiBwcm9jZXNzX2ZpbGUgew0KPj4gLQlt
eSAoJHQpID0gQF87DQo+PiArc3ViIHByZV9wcm9jZXNzX2ZpbGUgew0KPj4gKwlteSAoJHQsICRx
dWlldCkgPSBAXzsNCj4NCj5UaGlzLCBJIHRoaW5rLCBpcyBhbiBhbnRpLXBhdHRlcm4gaW4gdGhp
cyBmaWxlLiBXZSBjYW4ganVzdCByZWFkIHRoZQ0KPiIkcXVpZXQiIGFuZCBvdGhlciB0aGluZ3Mg
dGhhdCB3ZSBzZXQgdXAgd2hlbiB3ZSBwYXJzZSB0aGUgcGFyYW1ldGVycyBhcw0KPmdsb2JhbHMs
IHdlIGRvbid0IG5lZWQgdG8gcGFzcyB0aGVtIGFzIG5hbWVkIHBhcmFtZXRlcnMuDQo+DQo+SXQg
ZG9lc24ndCBoZWxwIHJlYWRhYmlsaXR5IHRvIHNoYWRvdyB0aGF0IHZhcmlhYmxlIHdpdGggYW5v
dGhlciBsZXhpY2FsDQo+aGVyZSBiZWxvdzoNCj4NCkkgYW0gb3BlbiB0byBndWlkYW5jZSBoZXJl
LiAgVGhlIHJlYXNvbiBJIGluY2x1ZGVkIHF1aWV0IGFzIGFuIGFyZ3VtZW50DQp3YXMgYmVjYXVz
ZSBJIHdhbnRlZCB0byBvdmVycmlkZSB0aGUgZ2xvYmFsIHF1aWV0IHZhbHVlIGZvciB0aGUgY2Fs
bCBvZg0KcHJlX3Byb2Nlc3NfZmlsZSBmcm9tIHRoZSB2YWxpZGF0aW9uIHNlY3Rpb24gKGxpbmUg
MTczNikuICBUaGlzIGlzIG5lZWRlZA0Kb3RoZXJ3aXNlIHRoZSB1c2VyIGdldHMgc3BhbW1lZCB3
aXRoIGRvdWJsZSBwcmludCBzdGF0ZW1lbnRzLiAgT25jZSBpbg0KdGhlIHZhbGlkYXRpb24gbG9v
cCBhbmQgYW5vdGhlciB0aW1lIGluIHRoZSBhY3R1YWwgc2VuZGluZyBtZXNzYWdlIHBhcnQuDQoN
ClRoZSBwYXRocyBmb3J3YXJkIHRoYXQgSSBjYW4gY3VycmVudGx5IHNlZSBhcmU6DQoxKSBhKSBy
ZW1haW4gYXMgaXQgaXMNCiAgIGIpIHJlbmFtZSBxdWlldCBpbiBwcmVfcHJvY2Vzc19maWxlIGJ1
dCBrZWVwIHRoZSBsb2dpYyB0aGUgc2FtZQ0KMikgaW4gdGhlIHZhbGlkYXRpb24gc2VjdGlvbiwg
dGVtcG9yYXJpbHkgc2F2ZSB0aGUgcXVpZXQgdmFsdWUsIGFsdGVyIGl0IHRvDQppbmRpY2F0ZSBx
dWlldGluZyBvZiB0aGUgcHJpbnQgc3RhdGVtZW50cywgYW5kIHRoZW4gcHV0IHRoZSBxdWlldCB2
YWx1ZSBiYWNrDQozKSBzZXBhcmF0ZSBvdXQgdGhlIHByaW50IHN0YXRlbWVudHMgaW5zaWRlIHBy
ZV9wcmNvZXNzX2ZpbGUgaW50byBhIGRpZmZlcmVudA0KZnVuY3Rpb24gYW5kIG9ubHkgY2FsbCB0
aGF0IGZ1bmN0aW9uIGluIHRoZSBzZW5kIG1lc3NhZ2UgY29kZS4NCg0KPj4gWy4uLl0NCj4+ICt9
DQo+PiArDQo+PiArIyBQcmVwYXJlcyB0aGUgZW1haWwsIHByb21wdHMgdGhlIHVzZXIsIHNlbmRz
IGl0IG91dA0KPj4gKyMgUmV0dXJucyAwIGlmIGFuIGVkaXQgd2FzIGRvbmUgYW5kIHRoZSBmdW5j
dGlvbiBzaG91bGQgYmUgY2FsbGVkIGFnYWluLCBvciAxDQo+PiArIyBvdGhlcndpc2UuDQo+PiAr
c3ViIHByb2Nlc3NfZmlsZSB7DQo+PiArCW15ICgkdCkgPSBAXzsNCj4+ICsNCj4+ICsgICAgICAg
IHByZV9wcm9jZXNzX2ZpbGUoJHQsICRxdWlldCk7DQo+PiAgDQo+PiAgCW15ICRtZXNzYWdlX3dh
c19zZW50ID0gc2VuZF9tZXNzYWdlKCk7DQo+PiAgCWlmICgkbWVzc2FnZV93YXNfc2VudCA9PSAt
MSkgew0KPj4gQEAgLTIwMDIsNyArMjAxNSw3IEBAIHN1YiBwcm9jZXNzX2ZpbGUgew0KPj4gICMg
RXhlY3V0ZSBhIGNvbW1hbmQgKGUuZy4gJHRvX2NtZCkgdG8gZ2V0IGEgbGlzdCBvZiBlbWFpbCBh
ZGRyZXNzZXMNCj4+ICAjIGFuZCByZXR1cm4gYSByZXN1bHRzIGFycmF5DQo+PiAgc3ViIHJlY2lw
aWVudHNfY21kIHsNCj4+IC0JbXkgKCRwcmVmaXgsICR3aGF0LCAkY21kLCAkZmlsZSkgPSBAXzsN
Cj4+ICsJbXkgKCRwcmVmaXgsICR3aGF0LCAkY21kLCAkZmlsZSwgJHF1aWV0KSA9IEBfOw0KPj4g
IA0KPj4gIAlteSBAYWRkcmVzc2VzID0gKCk7DQo+PiAgCW9wZW4gbXkgJGZoLCAiLXwiLCAiJGNt
ZCBcUSRmaWxlXEUiDQoNCkkgYXBwcmVjaWF0ZSB5b3VyIGZlZWRiYWNrIQ0KDQotLSANCjIuMzQu
MQ0K
