Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89115C433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 11:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbiKPL52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 06:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbiKPL4p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 06:56:45 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503A0D9D
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 03:48:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNhK/6Aft4BPzAWSbLjuURwjWkOTI6YZGXQ8V5dSp94u6rQHdlmJQGUAAUbTApROlrghLQSIZvZUBfAbV3LsdpS7W5w91Yp31+j9Wz9cjwyHxlv4pSr+LPI7CnmWEQwPCpO42Sd79fQKDgAUrhhWDoZnDMf9fVqdqKp+wBT5btI0crVbVwQ0tc3EyBnreHNtgPhhJMRrGn9kuAcst6IqPKBJZcdPaMr3pphndJsi+G44HkfDFdiInob9qlA2gRYFHdRS+01hVEWKvcdrZY5QDEQj84SJj2LRFo/V5biO1WDMRBrMnOM05yJOJEm3Wn/fUi5eZoe8NlZLR7hYi+65Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwZFa07vlMU1IM40emvr/37k2G73d66+JXeEzdPJRl0=;
 b=CqEKjVW4/nOUJLMLDiQ7RNDNoFsoaxzsfU+fylKmBNFFPg2i0aQFC5uG9MCkjhLKH3jYaX9IR1/ruaIt7DbHbSC/CGgHDR67Z1PQZ/uFPtxhuq5ivRF/3APywM9a6jDZom84/yXwiWguMzWQfuFZ2MYtKGvP1ZKNk+4iuvQkzspfUeNID6boOqijTlp2TtXCFACE5g5wlhmy8o/Xd6gxSAed97p7UQNZMlxZQ4gV0cusa/UGRxq5NA1RhRF+SQM4dyfs9670ZwYPEINezR+0pWsZLzuDJxzoutwLZBik8dg69kjcFIUs5qjZQESItQ6LmXtDIkEJvSyyItU9OrSRYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwZFa07vlMU1IM40emvr/37k2G73d66+JXeEzdPJRl0=;
 b=XxE1m4tNLTseB06MikM/c3gyqLi+jfVFbcgyjbzu/l/E3l+DfPZ7JL4KWpZMUvaBO2/JdsfbpU8bWYa/s9cayzKq91iEGhxNQSMajHpdzKI3PIU6+jZq3qYbJ8wG9QhATP66gKJLbT3RjMAWagPyGAZEoteZepirzP3GYflAkjQ=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 16 Nov
 2022 11:48:21 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66%8]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 11:48:21 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     Taylor Blau <me@ttaylorr.com>
CC:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: ms/sendemail-validate-headers, was Re: What's cooking in git.git
 (Nov 2022, #03; Mon, 14)
Thread-Topic: ms/sendemail-validate-headers, was Re: What's cooking in git.git
 (Nov 2022, #03; Mon, 14)
Thread-Index: AQHY+K3KqHDPeniB1kW9OcX2cYFDTa5AwgF2gACpoQA=
Date:   Wed, 16 Nov 2022 11:48:21 +0000
Message-ID: <874juzglx8.fsf@amd.com>
References: <Y3Mag8qG2D3qjlmg@nand.local>
 <4p90qnq3-580o-9n59-34n0-rs3pp635908o@tzk.qr> <Y3Q69UlrmyCXLCsY@nand.local>
In-Reply-To: <Y3Q69UlrmyCXLCsY@nand.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.7.0; emacs 28.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|SJ1PR12MB6147:EE_
x-ms-office365-filtering-correlation-id: c2b7714f-93f6-41b4-3be1-08dac7c8760e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qlkf3+st7T13t6gnHfud/5zzdY91+yYKzE/AKYz7J7U5LcblctE1SRktM+ACyLVUDJaooyrwWs2M0Nu6v1yLglSY+Kxh9d31Rynh+zKbsrZXvBaN21jqJFQ2alj99ePZw5YnoCYUUTeERqfmjhfa/yoyUDNVVRNhpg+lq1GlR0faxB3pi58EtTcZS10sxclPFo7K29GRIU3iXNnS2gEggprIdNZTvh1cWnjo57zN2sER98G9Pxx6+xO7as/d/fmuiGHLnqYbPpoNvLOyFQDE2hUoE248+Dl5nQX6C15lgAQ0wX9i5fM9HEVySKSiJ+i3V78wyPg03TLd69w1ZDUpg02XdPUgh4vKDVxjOVKKa8IuPVUieGAHl4YmE1PIE6IYEyA5wPhK7tiND7MFRh3Hm3gDFEKnJzQaweW8/Xg0c8r332MhmE2QjlaZ+lVkoLtbWiOH0xqBjsLNIHkyi1+Anlqf1aKrHKAqKLySZZ0G7PcCiYbv4blmuXBWHiujfBlnbwjQNE55rKZpu7HM3b6Mjh0MRxQT65lNuwma5dcjgdhMCcRJfw529WlKQQa67iIia/unDPKvWR/SEkdac/hqb4pnETLUYiJ2a08u61XcMCWNU+lRHoUW/3KKoLWxcV9Pp3MXJSWRKxvkRvz5Jui2OvdtK4kw+pviIQUub6A6Pn1rAbCFmYk7eAtxf8xYNVha7r4/noAmnZZGRvGffIw4vaxuOdIJ7abjIFJYgnzEMUb1dErn8zlC+FRG3uKME0KellB4EMKnV2b/ypwhTGhxNDiHgXGHnMM+FeRzejpAcrE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(38070700005)(2906002)(15650500001)(8936002)(41300700001)(5660300002)(4001150100001)(4326008)(64756008)(8676002)(478600001)(36756003)(86362001)(76116006)(6916009)(54906003)(316002)(6486002)(66446008)(66574015)(66476007)(66946007)(91956017)(966005)(71200400001)(45080400002)(2616005)(6512007)(66556008)(186003)(38100700002)(122000001)(6506007)(83380400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3RqWEdtL2hlMnJrc3ZMQk1WUXZQWkxxYzBFOUR4cFJXdUxzM0JpTlNxUnpP?=
 =?utf-8?B?eTNhVjRhd2tSd2Q3QS9aZlRjbnZ6dzQrcVBnTmRKQTZJREJxT2QzbTFKam83?=
 =?utf-8?B?SXJHQ2xoRHpjWnNaK0FCTm94MEl3MzdaR2x2TVNucmdZcGdXWjZPQTU3WWcz?=
 =?utf-8?B?VUxLVnRHSkdFT0lETWRkS01kTVlUZjgrcGcxL3dmQzFIM2xEb1RpZEFITTdO?=
 =?utf-8?B?OW9nTXh6SmV6c0tXeG5lbDVQVDJuRW5QaDV4S09NNW5COW9keWRiV2RsYW1Z?=
 =?utf-8?B?VWthbjlhN3F3RnlEcGxBc1cyVGMzYTJhK3g0LzFyR2JKUGpGY05rTGd4ZWNa?=
 =?utf-8?B?TElpWExJQ0NocUw0eGM0ZFA5QTBkYmpRUXRDZEFKenNUbm04NGxuYXZzSTFT?=
 =?utf-8?B?WXZnUTdOOXlqOS91Z2pMYXpoaW4wQjZMTlZnR0dYeHNpSzdhTndrUlB3K3BI?=
 =?utf-8?B?cVFLbFMrY09mc2FwN08vZ2FIV1Bpbk9HMzNCcndjT3Rab3JjK0k1OTBmRmNK?=
 =?utf-8?B?NityaFFpRVRiU0FKTjQ1c3Y2NHJGRGhlQkVFQUtiZW1oT0x0WFAybXFxNGNt?=
 =?utf-8?B?d3h3bWs2UGFKTTZXMVFYRFVYYnN5OVNDeW9DeUhIazRZOU00UlpGaWo4d3pM?=
 =?utf-8?B?MERINm52RXM3bWx3bVlyZU5wZVo3cDEvdU1CUnBncS9WQWl4ZTNrYnFROElx?=
 =?utf-8?B?KzdZTEF1Z01LTGNMdE1BclZ3Mi9EV1BkUzBZOG1uSFVKMG5CbTlkV3YrMU9j?=
 =?utf-8?B?M1VPdjNFeDNhVDVTQWhPb0lWL1E5Vk94cUlaS21ZaEhhQWNiQlVqSldDcXd2?=
 =?utf-8?B?RHg3anRTR2RWZTcvRFNtYUczNmsrMkNJUW15c3VMdDY5NmdWeXlXU09GL0tz?=
 =?utf-8?B?Ykw5OC9Zay9sZ0RWc2pLMUZqQUplc1QyclBoNzAvanpjL2phSkxDZEpqTlA0?=
 =?utf-8?B?WlFmZytkZHZ1djNBMUt3RER6Y0I0RUQwSDljUEp1R2pSS2lMNmxwUlVHekN3?=
 =?utf-8?B?RUFGdEtJeStaYldWQk9id25aVndoRDRDR2dtQi9BWnZ6NS8wVjdXTDF3U1Vs?=
 =?utf-8?B?RFlLbHZmSENSU2Zqb1hkZGJ0cTBWZjRyV1BLWk1rNXpYa0x3Q1hkSExuN3Zx?=
 =?utf-8?B?RXYvUXpRZ3N2aDczdlJZQVBaajhsZDhvL1lxbU0wWXkxV2RPczJoZlFtNGhB?=
 =?utf-8?B?dGxYL1BETk9zbzlmNGJSSlA4dnNXYi9lVmhQK2RQck4xemY5N2xKa3ozZ1kz?=
 =?utf-8?B?R2ZuRlRXRUhhM2l5MHE5dFZHYVJEZG4zeGJJZmxxVWxtYUFWR01tWXhORkt5?=
 =?utf-8?B?WDF0aERwNE83L2NNVm5US2xjUnkyL1c5b1VWWEV2R1VBYThQc2NCOWJyQzNZ?=
 =?utf-8?B?K0pPUlRvSXR4TnNYVXUxT3NYcWgvV1RBclhZcUt0YkhSMmNCUHVOZXZJalAz?=
 =?utf-8?B?Zno5aUo3WVZKLzRlZTN2UnE5dXhiSWZSVnE4MjdPd0o2c2RmMkJWWVc5RThs?=
 =?utf-8?B?UEY1ZlNNSjhJQklSRHFoenNsdlV6aWs2NTlyL1l2ZGRiYTZSQ0NIS1lLMEls?=
 =?utf-8?B?QWJaWWJBaDhLSVpoMU5oZUJzL2tIYmNZTWxIbjZzL3ZKdzkrUEw4a0hhcWk3?=
 =?utf-8?B?WDZIUXlBQUY0ZVYzM0ovcG5KdWpWN3d5M2JuRGNFUUVLdXFsMHY5MHNvVk13?=
 =?utf-8?B?OVpRcVo1QmlPVHl6QVQ4L09hbkpoUkxkRS85TkViQTEvUWhqdDF1SVhNSlBk?=
 =?utf-8?B?RkFoUWRJL0h4dUN6dUpVV3hqSWtsMVpJakVFQ1EzZG1vRGVKd1drZTdFdGI2?=
 =?utf-8?B?bVFNZlJ2Rmllc3ovSmhpMzBaN280SjJNbVlyUFJHVUlPREVuRzdZT2VyK2FT?=
 =?utf-8?B?WkRLZ0tQeUNMT1c4aEFFWFhFdkIxay9QcWpVWG9RL3dqYy9ZcVF4b2szMmdO?=
 =?utf-8?B?OXFkbkM2ZDNxaEZ5MXZJblJPdjgxMmNHUkY3a0dhczFjTUN3eEJOYVFaWFhy?=
 =?utf-8?B?Ums1T3dkQTNEY3k1ZHlPUU9rTFBPRHBvVytMNXVZMWlRMGVYUGlsa0ZFRzJY?=
 =?utf-8?B?UnF2cmZaaXdtRElBUjh6MURlcWgzemFMRUhWbWVDb0I5SlllUjgvckozRTZr?=
 =?utf-8?Q?V25GDVRmv71QbMydncLJ6Mq8I?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <676DEFADD3C9DC42BFF88A226CC34906@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b7714f-93f6-41b4-3be1-08dac7c8760e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 11:48:21.4221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 304dzo+ir8ebtRlpOcef+1utfX5JlX35i8Mz5H0G3KyyUPeF0iXbghvm56thUkS2uutfoAu82DTZyrEoQ3X/OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQpGb3IgbXMvc2VuZGVtYWlsLXZhbGlkYXRlLWhlYWRlcnMgKDIwMjItMTEtMTEpIDEgY29tbWl0
Og0KDQpNeSBhcG9sb2dpZXMuICBJIHRoaW5rIG5vdCBoYXZpbmcgdGhlIHBhdGNoZXMgY2hhaW5l
ZCBpbiB0aGUgc2FtZSBlbWFpbA0KaXMgY2F1c2luZyBjb25mdXNpb24uICBJIGRpZCBoYXZlIHNv
bWUgcmV2aWV3IG9uIHRoZXNlIGVtYWlsczoNCg0KdjAgLSBodHRwczovL3B1YmxpYy1pbmJveC5v
cmcvZ2l0LzIwMjIxMTA5MTgyMjU0LjcxOTY3LTEtbWljaGFlbC5zdHJhd2JyaWRnZUBhbWQuY29t
L1QvI3UgDQogICsgcmVwbGllczogQnJpYW4gTSBDYXJsc29uLCBUYXlsb3IgQmxhdQ0KdjEgLSBo
dHRwczovL3B1YmxpYy1pbmJveC5vcmcvZ2l0LzIwMjIxMTExMDIxNTAyLjQ0OTY2Mi0xLW1pY2hh
ZWwuc3RyYXdicmlkZ2VAYW1kLmNvbS9ULyN0DQogICsgcmVwbGllczogTHViZW4gVHVpa292LCDD
hnZhciBBcm5masO2csOwIEJqYXJtYXNvbg0KdjIgLSBodHRwczovL3B1YmxpYy1pbmJveC5vcmcv
Z2l0LzIwMjIxMTExMTkzMDQyLjY0MTg5OC0xLW1pY2hhZWwuc3RyYXdicmlkZ2VAYW1kLmNvbS9U
LyN0DQp2MyAtIGh0dHBzOi8vcHVibGljLWluYm94Lm9yZy9naXQvMjAyMjExMTExOTQyMjMuNjQ0
ODQ1LTEtbWljaGFlbC5zdHJhd2JyaWRnZUBhbWQuY29tL1QvI3QNCiAgKyByZXBsaWVzOiBKb2hh
bm5lcyBTY2hpbmRlbGluDQoNCkknbSBjdXJyZW50bHkgaW4gdGhlIHByb2Nlc3Mgb2YgdHJ5aW5n
IHRvIHJ1biB0aGUgVDkwMDEgdGVzdHMuICBJIGFtDQpnZXR0aW5nOiBlcnJvcjogdGVzdF9ib29s
X2VudiByZXF1aXJlcyBib29sIHZhbHVlcyBib3RoIGZvcg0KJEdJVF9URVNUX1BBU1NJTkdfU0FO
SVRJWkVfTEVBSyBhbmQgZm9yIHRoZSBkZWZhdWx0IGZhbGxiYWNrLiAgSSBkbw0Kd29uZGVyIGlm
IHRoZSBjaGFuZ2UgaW4gdmFsaWRhdGlvbiBsb2NhdGlvbiAoYXMgQnJpYW4gbWVudGlvbmVkKSBp
cw0KY2hhbmdpbmcgb3V0cHV0IChldmVuIHRob3VnaCB0aGUgbmV3IGxvY2F0aW9uIGlzIG5lZWRl
ZCB0byBoYXZlIGFsbA0KaW5mb3JtYXRpb24gZm9yIGhlYWRlcnMpLiAgSSdsbCBrZWVwIGxvb2tp
bmcgaW50byBpdC4NCg0KVGhhbmtzLA0KTWljaGFlbCBTdHJhd2JyaWRnZQ0KDQpUYXlsb3IgQmxh
dSA8bWVAdHRheWxvcnIuY29tPiB3cml0ZXM6DQoNCj4gT24gVHVlLCBOb3YgMTUsIDIwMjIgYXQg
MDM6MDQ6MjlQTSArMDEwMCwgSm9oYW5uZXMgU2NoaW5kZWxpbiB3cm90ZToNCj4+IEhpIFRheWxv
ciwNCj4+DQo+PiBPbiBNb24sIDE0IE5vdiAyMDIyLCBUYXlsb3IgQmxhdSB3cm90ZToNCj4+DQo+
PiA+ICogbXMvc2VuZGVtYWlsLXZhbGlkYXRlLWhlYWRlcnMgKDIwMjItMTEtMTEpIDEgY29tbWl0
DQo+PiA+ICAtIEV4cG9zZSBoZWFkZXIgaW5mb3JtYXRpb24gdG8gZ2l0LXNlbmQtZW1haWwncyBz
ZW5kZW1haWwtdmFsaWRhdGUgaG9vaw0KPj4gPg0KPj4gPiAgRXhwZWN0aW5nIGEgcmVyb2xsLg0K
Pj4gPiAgc291cmNlOiA8MjAyMjExMTExOTQyMjMuNjQ0ODQ1LTItbWljaGFlbC5zdHJhd2JyaWRn
ZUBhbWQuY29tPg0KPj4NCj4+IEkgc2VlIHRoaXMgbWFpbCwgYnV0IG5vIHJlcGxpZXMuIElzIGl0
IHJlYWxseSBhcHByb3ByaWF0ZSB0byBsYWJlbCB0aGlzIGFzDQo+PiAiRXhwZWN0aW5nIGEgcmVy
b2xsIj8NCj4NCj4gVGhhbmtzIGZvciBzcG90dGluZy4gSSB3cm90ZSB0aGlzIG9uZSBmcm9tIG1l
bW9yeSwgYnV0IGluIHJldHJvc3BlY3QgSQ0KPiB0aGluayBJIHdhcyB0aGlua2luZyBvZiBhIGRp
ZmZlcmVudCB0aHJlYWQgWzFdIGJldHdlZW4gdGhlIHBhdGNoIGF1dGhvcg0KPiBhbmQgYnJpYW4g
d2hlcmUgdGhlcmUgd2FzIHNvbWUgZGlzY3Vzc2lvbiAoYnV0IG5vIHBhdGNoZXMpLg0KPg0KPj4g
QSBtb3JlIGFwcHJvcHJpYXRlIGxhYmVsIHdvdWxkIGJlICJCcmVha3MgdDkwMDEiLCBJIHdvdWxk
IHRoaW5rLCBhbmQgdGhlDQo+PiByZWZlcmVuY2Ugc2hvdWxkIHByb2JhYmxlIGJlIDwzNnMwcjRz
OS1uMjFyLXBvcDktbzdybi1xMHFycTQ4N3A4MzFAdHprLnFyPg0KPj4gaW5zdGVhZCAoYnV0IEkg
c2VudCB0aGF0IG91dCBvbmx5IGEgY291cGxlIG9mIG1pbnV0ZXMgYWdvLCBzbyBJIHdvdWxkDQo+
PiBzdGlsbCBiZSBjdXJpb3VzIHdoeSBpdCB3YXMgbWFya2VkIGFzICJFeHBlY3RpbmcgYSByZXJv
bGwiKS4NCj4NCj4gWWVzLCBsZXQncyBrZWVwIHRoaXMgb3V0IG9mICdzZWVuJyBzaW5jZSBpdCBo
YXMgc2VlbiBubyByZXZpZXcgYW5kDQo+IGJyZWFrcyB0OTAwMS4gSSdsbCB1cGRhdGUgbXkgbm90
ZXMgYWNjb3JkaW5nbHksIHRoYW5rcy4NCj4NCj4gVGhhbmtzLA0KPiBUYXlsb3INCj4NCj4gWzFd
Og0KPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9
aHR0cHMlM0ElMkYlMkZsb3JlLmtlcm5lbC5vcmclMkZnaXQlMkY4N2N6Y203bWFmLmZzZiU0MGFt
ZC5jb20lMkYlMjN0JmFtcDtkYXRhPTA1JTdDMDElN0NNaWNoYWVsLlN0cmF3YnJpZGdlJTQwYW1k
LmNvbSU3Qzk4YWZlYWM5MjlhYzQxMDlmN2M4MDhkYWM3NzBjZmNlJTdDM2RkODk2MWZlNDg4NGU2
MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzODA0MTU4NDU4MTI5ODg0OCU3Q1Vua25vd24l
N0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJ
NklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJmFtcDtzZGF0YT1oTHQwUENB
T0hsT1BPVU8zV1RueThQNUkzTE1YMTdyJTJGVzVKJTJGcVg1dUZmcyUzRCZhbXA7cmVzZXJ2ZWQ9
MA0K
