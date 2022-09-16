Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85177ECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 20:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiIPUCZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 16:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiIPUCX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 16:02:23 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.129.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705DC9E685
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 13:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1663358541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JzDEld+jgIdhor8wSq+QccT5SAhwbhKwDiuosE+uwEQ=;
        b=VyX5vBVkCNVXpma/2dZ5/WzbaZtscWLhhNmTaEV79WYOeCp2VgKnT2XZRGhgKWy1hyGh1N
        Tv6yADn4deouzKUSW678iry2F9CwRyIMagpNdMs60oooZvXUusJUWB4krg39hO4dbKIpwo
        pynPBwAbrVjo2kASSpcXO81amZkPVfg=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eastusazlp17011016.outbound.protection.outlook.com [40.93.11.16]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-LraZvKIZMZScsaoTIFOp8g-1; Fri, 16 Sep 2022 16:02:19 -0400
X-MC-Unique: LraZvKIZMZScsaoTIFOp8g-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by MW4PR05MB8905.namprd05.prod.outlook.com (2603:10b6:303:132::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.5; Fri, 16 Sep
 2022 20:02:16 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7%6]) with mapi id 15.20.5632.011; Fri, 16 Sep 2022
 20:02:16 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: [PATCH v6 0/6] fsmonitor: option to allow fsmonitor to run
 against network-mounted repos
Thread-Topic: [PATCH v6 0/6] fsmonitor: option to allow fsmonitor to run
 against network-mounted repos
Thread-Index: AQHYx69J+hDSrgDG4E6Urnu+10cbsa3iXJiAgAAgVHA=
Date:   Fri, 16 Sep 2022 20:02:15 +0000
Message-ID: <BL0PR05MB55713024EE4938946AD9DEC8D9489@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
 <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
 <ac9c12cf-866d-565f-fbf8-58dbfdd92ef1@jeffhostetler.com>
In-Reply-To: <ac9c12cf-866d-565f-fbf8-58dbfdd92ef1@jeffhostetler.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|MW4PR05MB8905:EE_
x-ms-office365-filtering-correlation-id: 27461b9f-5f9f-42e4-7d46-08da981e5a6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 49Bsaj72NOV7iOZRDNSJKet53IhlQIHZpRNAYZWjPqj6LNcuWhKC9qHq3TfrGLTvfBzxX2FACdpNUjMuXxw2QZXNJ96k2y6QdpZK1ivwmNDh1SfTzyKgbQOW3MV1PO1CmRIFz+234794dX/8SNdc60H44n5ZKIs4gn9sIICd+lcJAN1WvC9QH7iTkx/6jf7OlrX53wQ4p1jiUR0pVQNDAFtWcUlL6DJ8hdGfR9XM2hlik5N0lX72Te1KfC5Y2FhXz1+KRXrpPzjtVRf0gqGrLmfQnhG7wLpZhekaTd+VirZLq5p0c8GyauaYBqoIX5vyC0fmwQ7HCaY05BsjnrZNfjVaqPRDM+uwRHKYp/8vQL/D/c8DQsXKoOohuBvemUCRbH/XMe79dN7ERv3uqjwmJNUo4r3bkL1qww06hYtaTtxvGaO648txMzhyy1wPhz9yOokM9Fa8w+fi19iq6gP3fNntq3J1z6p9ocrOL5w9loXcp8VmFxpT0Fl9xFocYAFoenXvDOcYo6jsn/OTgS/9A89ZLpyI6bTCRd1MLaUDVdxtb0te6KAs7JELmuE9jfoLvUGnYqclLS/Pb51P5nuaBU5asQKsRAHw48tyl5kbzf0ULRGMw3C2dISVO/7QFtxI/8Sbp9YGiyC1M2utOOyRHn+F1Hb0xxvywi72oUNwvQ8lRmbyErSJDuBRJNwWjUiYA7oxmZcPJ4RYkn3F9/BXsXSqaxKyiT/f4WXR8ekvvA6izEGrR2zZjSBLH8Ne7achQilT2jvBMJZx35eq3/nrEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199015)(86362001)(66899012)(316002)(66574015)(38070700005)(33656002)(5660300002)(66946007)(52536014)(122000001)(38100700002)(8936002)(2906002)(66446008)(64756008)(66556008)(66476007)(7696005)(478600001)(41300700001)(26005)(110136005)(54906003)(8676002)(4326008)(6506007)(53546011)(186003)(9686003)(76116006)(71200400001)(55016003)(83380400001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDRSelNtVTFvdSs4QWl0cmRNd0V6bUZGcER3RGQzQkpscVBNTzdQVUVaZzcr?=
 =?utf-8?B?K0o0ZUVNbnlkaG5OejFGNzNDVU5SOTVQdkVBOTRGMklReVJLM3UyYjdpS0VR?=
 =?utf-8?B?N2RYVVVablg0ZjRZUGxvRjlmNGVDTU1FcGsza00xVVZERlRadERjeEV2NFpn?=
 =?utf-8?B?SmhXTnE1cUxzYTk4Z3ZyV2o4MU44RWNCZmxsUjlzdUtWQ2Q3aWRjdDM1cWgy?=
 =?utf-8?B?Y1pZaE8wZTh0TWlwTFlrSUIvbk1PeDhSUVB3R2NyaSsrWHNjcGUxc3U1T0JM?=
 =?utf-8?B?ZGFDaFlLTEZ5cUo4ekVpYkZNcEJtVFJWS0VZSHZtcUFkNi8xaVk5REtnWGV3?=
 =?utf-8?B?U3ljM1hKNGc3ZURDaDdlSUNkNHRVb2RURWhiRkkvOW9WMnlXMjdERTFXajg3?=
 =?utf-8?B?cHYvbUEzSDNZSFdWYmovY3YzMlpIZ0p2L1MrWnpYWFZneTBENENkS09zdmhp?=
 =?utf-8?B?SjFWV0FmSGpCek1jMGdqZ2MzR2VPNi9wYnJTN1NFLzBFK3ZpWVBaOVNMRU5G?=
 =?utf-8?B?YWpWM211YVFzQ05uU0F6NkFWYW9zWGd2UlR6OHZULzNhTDdWNkxQaEJ0WHFt?=
 =?utf-8?B?RWI3NTlCN3JMbWEya3B3VlorbElSRUsyclZBbGZLUXNzVXVHbnpxZ1V0OU84?=
 =?utf-8?B?OENrN2VIKy9PemVQQzhYOGFYaXJIY01ueDFxTVd1QnlLdDJTWHFxN0RUMCtm?=
 =?utf-8?B?MDE3Yk5VblNwOG8vbS9vMjhKNVBid3pjUlJ1SWdYdTZzeHNPSTRKNHZDT2FO?=
 =?utf-8?B?SW5JNk9DT1pRNUxmZVNRY1BZMDhjYW9Ia0ljV29iQ3N1ei8yOHpiUzNFanky?=
 =?utf-8?B?ZEZqdncvSHIydTF3YVQ5cEt6cXJxSnlkR0xQWHJUVEk2K3U4MXBiQk5rQjZY?=
 =?utf-8?B?K0RmZW15WXcraVFTZXZQZndLdVladUtkN3ZxR1I3STF5c1E3bFIxYll0bytu?=
 =?utf-8?B?eDgrM2cyaVJSM28xUDAwQXBzVk9JcDh0R3Vvcmh6OEwrZk9JRzVDUHBuakhN?=
 =?utf-8?B?WkJ5REc4THdkaThuZGhrRUFkbmJCNE5DcVRKbWNjcCt2amRtZFJFMk1VMXNy?=
 =?utf-8?B?WGc3dFBnSHByZjNjQXAzc2JGMmRTaThDdG90aC9SZmhoRkoyMzExeXFIb0h0?=
 =?utf-8?B?ZGhxeE40cXpVZmVrNm9IY2c0SUxCbE5XNXBjSmt3blVGVjlzOWdaaU1XcGFi?=
 =?utf-8?B?dFFScFR3S1o0SWJWaXowaEpVQ2paSUl1TFBzSjMrcW84N0RzQlplQm90Wk1M?=
 =?utf-8?B?TEcyZjBYeUtERDFaVk5BdVp2WERueldpMjFPSFE5eUJrWTZpdTROcWVEbGlp?=
 =?utf-8?B?NmhIWGFaNWtpRVdNMEFJL1ZsbGNmbjArNDdWNC96OUV1NEJqblFIeERZUkFp?=
 =?utf-8?B?eHpnS25GZ2dmZ0RCTXN4VUtuNk9mZEM5VWJpbm94KzJlc3Y2VWZsZzdmdmR2?=
 =?utf-8?B?NVh0Y1hFYWlnYTdRSTVzQUpaMVZaMVdER2Q2cHFwNnd0Mk9uYlp3Mlp6OEQv?=
 =?utf-8?B?TWlZWXc2RmM1YmlZS3FJclc2RXN3bm9oeE5KT3VGODNGc1RzUFZTa3pkUlRJ?=
 =?utf-8?B?SkRBQ0Q3SHRTbWNPbDJ0MDJ6UDhSa1JOSTZRMElyM05reUhBNHoyMEduRjFw?=
 =?utf-8?B?MXREOTd1U2prclpoaG9zMjdtNmZSR3dwTHVTUWdwVkV1NVp4Y0RGZWRzQUx3?=
 =?utf-8?B?YnZ1VHRiditoUjdxRm9qY1U5T2xLYkJIbnkwOVlHWEYzT3B4M09QWVY5cEhX?=
 =?utf-8?B?bndrUitvK2hGSmtialZPYUdEbXN6RC9QRWhmMk5MZG5FamdNeFhNcnAvTWxW?=
 =?utf-8?B?M1IzMDI4UFNteldLNkNteW1KS2FBMnNsNUd3cU5xS0ozZCtYZTV4eDBiSUYx?=
 =?utf-8?B?QnFGRVJ2Zm92QjVSOGM1Q0RqQXRNb3VQYTE2OTBKYWFwT2FNMnVOQjFRcGVp?=
 =?utf-8?B?Q3BxcWFJNHkrd2RLSXBSaFVEL0I3LzY2WGNmekY0anZCUEZLSFdseUdMRERF?=
 =?utf-8?B?MlRWQVNEREhBRW94Q2luNXFPUFpHaUZhMVhrL2lzSUFGWHYxUjRiT1U4QlBk?=
 =?utf-8?B?cHZDdHNYZjVLL2dSVjdDYVg2NUxFbEtIM2xMNFl6Rmw2THNEODdSNnBZaEJn?=
 =?utf-8?Q?hPsh4A/C6Jj+jplhRkCJGKiCS?=
MIME-Version: 1.0
X-OriginatorOrg: mathworks.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8905
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVmZiBIb3N0ZXRsZXIg
PGdpdEBqZWZmaG9zdGV0bGVyLmNvbT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMTYsIDIw
MjIgMTo1OSBQTQ0KPiBUbzogRXJpYyBEZUNvc3RhIHZpYSBHaXRHaXRHYWRnZXQgPGdpdGdpdGdh
ZGdldEBnbWFpbC5jb20+Ow0KPiBnaXRAdmdlci5rZXJuZWwub3JnDQo+IENjOiBFcmljIFN1bnNo
aW5lIDxzdW5zaGluZUBzdW5zaGluZWNvLmNvbT47IFRvcnN0ZW4gQsO2Z2Vyc2hhdXNlbg0KPiA8
dGJvZWdpQHdlYi5kZT47IMOGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uIDxhdmFyYWJAZ21haWwu
Y29tPjsgUmFtc2F5DQo+IEpvbmVzIDxyYW1zYXlAcmFtc2F5am9uZXMucGx1cy5jb20+OyBKb2hh
bm5lcyBTY2hpbmRlbGluDQo+IDxKb2hhbm5lcy5TY2hpbmRlbGluQGdteC5kZT47IEVyaWMgRGVD
b3N0YSA8ZWRlY29zdGFAbWF0aHdvcmtzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAw
LzZdIGZzbW9uaXRvcjogb3B0aW9uIHRvIGFsbG93IGZzbW9uaXRvciB0byBydW4NCj4gYWdhaW5z
dCBuZXR3b3JrLW1vdW50ZWQgcmVwb3MNCj4gDQo+IA0KPiANCj4gT24gOS8xMy8yMiA0OjI3IFBN
LCBFcmljIERlQ29zdGEgdmlhIEdpdEdpdEdhZGdldCB3cm90ZToNCj4gPiBGb2xsb3ctb24gdG8g
dGhlIHdvcmsgZG9uZSB0byBhbGxvdyBXaW5kb3dzIHRvIHdvcmsgYWdhaW5zdA0KPiA+IG5ldHdv
cmstbW91bnRlZCByZXBvcyBmb3IgbWFjT1MuDQo+ID4NCj4gPiBIYXZlIG1hY09TIHRha2UgYWR2
YW50YWdlIG9mIHRoZSBzYW1lIGNvbmZpZ3VyYXRpb24gb3B0aW9uLA0KPiA+ICdmc21vbml0b3Iu
YWxsb3dSZW1vdGUnIHRoYXQgd2FzIGludHJvZHVjZWQgZm9yIFdpbmRvd3MuIFNldHRpbmcgdGhp
cw0KPiA+IG9wdGlvbiB0byB0cnVlIHdpbGwgb3ZlcnJpZGUgdGhlIGRlZmF1bHQgYmVoYXZpb3Ig
KGVycm9yaW5nLW91dCkgd2hlbg0KPiA+IGEgbmV0d29yay1tb3VudGVkIHJlcG8gaXMgZGV0ZWN0
ZWQgYnkgZnNtb25pdG9yLg0KPiA+DQo+ID4gVGhlIGFkZGVkIHdyaW5rbGUgYmVpbmcgdGhhdCB0
aGUgVW5peCBkb21haW4gc29ja2V0IChVRFMpIGZpbGUgdXNlZA0KPiA+IGZvciBJUEMgY2Fubm90
IGJlIGNyZWF0ZWQgaW4gYSBuZXR3b3JrIGxvY2F0aW9uOyBpbnN0ZWFkICRIT01FIGlzIHVzZWQN
Cj4gPiBpZiB0aGUgZGVmYXVsdCBsb2NhdGlvbiBpcyBvbiB0aGUgbmV0d29yay4gVGhlIHVzZXIg
bWF5LCBvcHRpb25hbGx5LA0KPiA+IHNldCB0aGUgJ2ZzbW9uaXRvci5zb2NrZXREaXInIGNvbmZp
Z3VyYXRpb24gb3B0aW9uIHRvIGEgdmFsaWQsIGxvY2FsDQo+ID4gZGlyZWN0b3J5IGlmICRIT01F
IGl0c2VsZiBpcyBvbiB0aGUgbmV0d29yayBvciBpcyBzaW1wbHkgbm90IHRoZQ0KPiA+IGRlc2ly
ZWQgbG9jYXRpb24gZm9yIHRoZSBVRFMgZmlsZS4NCj4gPg0KPiA+IEFuIGFkZGl0aW9uYWwgaXNz
dWUgaXMgdGhhdCBmb3IgbW91bnQgcG9pbnRzIGluIHRoZSByb290IGRpcmVjdG9yeSwNCj4gPiBG
U0V2ZW50cyBkb2VzIG5vdCByZXBvcnQgYSBwYXRoIHRoYXQgbWF0Y2hlcyB0aGUgd29ya3RyZWUg
ZGlyZWN0b3J5DQo+ID4gZHVlIHRvIHRoZSBpbnRyb2R1Y3Rpb24gb2YgJ3N5bnRoZXRpYyBmaXJt
bGlua3MnLiBmc21vbml0b3IgbXVzdCBtYXANCj4gPiB0aGUgRlNFdmVudHMgcGF0aHMgdG8gdGhl
IHdvcmt0cmVlIGRpcmVjdG9yeSBieSBpbnRlcnJvZ2F0aW5nIHRoZSByb290DQo+ID4gZmlsZXN5
c3RlbSBmb3Igc3ludGhldGljIGZpcm1saW5rcyBhbmQgdXNpbmcgdGhhdCBpbmZvcm1hdGlvbiB0
byB0cmFuc2xhdGUgdGhlDQo+IHBhdGguDQo+ID4NCj4gPiB2NiBkaWZmZXJzIGZyb20gdjU6DQo+
ID4NCj4gPiAgICogaW5jb3Jwb3JhdGVzIGVhcmxpZXIsIFdpbmRvd3Mtc3BlY2lmaWMgY2hhbmdl
cyB0aGF0IGhhdmUgbm90IG1hZGUgaXQNCj4gYmFjaw0KPiA+ICAgICB5ZXQgdG8gdGhlIG1hc3Rl
ciBicmFuY2gNCj4gPiAgICogaW5jb3Jwb3JhdGVzIGNvZGUgcmV2aWV3IGZlZWRiYWNrDQo+ID4g
ICAqIGFkZHMgZG9jdW1lbnRhdGlvbiBmb3IgJ2ZzbW9uaXRvci5hbGxvd1JlbW90ZScgYW5kDQo+
ICdmc21vbml0b3Iuc29ja2V0RGlyJw0KPiA+DQo+ID4gdjUgZGlmZmVycyBzaWduaWZpY2FudGx5
IGZyb20gZWFybGllciB2ZXJzaW9uczoNCj4gPg0KPiA+ICAgKiByZWRlc2lnbiBvZiBoYW5kbGlu
ZyAnZnNtb25pdG9yLmFsbG93UmVtb3RlJyBhbmQgJ2ZzbW9uaXRvci5zb2NrZXREaXInDQo+ID4g
ICAgIHN1Y2ggdGhhdCB0aGVzZSBvcHRpb25zIGFyZSBubyBsb25nZXIgYWRkZWQgdG8gdGhlIHNl
dHRpbmdzIGRhdGENCj4gPiAgICAgc3RydWN0dXJlIGJ1dCBhcmUgcmF0aGVyIHJlYWQgZnJvbSBj
b25maWcgYXQgcG9pbnQgb2YgdXNlDQo+ID4gICAqIHJlZmFjdG9yaW5nIG9mIGNvZGUgZm9yIGhh
bmRsaW5nIHBsYXRmb3JtLXNwZWNpZmljIGZpbGUgc3lzdGVtIGNoZWNrcyB2aWENCj4gPiAgICAg
YSBjb21tb24gaW50ZXJmYWNlIHRvIGF2b2lkIHBsYXRmb3JtICNpZmRlZiBpbiBJUEMgY29kZSBh
bmQgYmUgaW4tbW9kZWwNCj4gPiAgICAgd2l0aCBvdGhlciBwbGF0Zm9ybS1zcGVjaWZpYyBmc21v
bml0b3IgY29kZQ0KPiA+ICAgKiBkZWFsaW5nIHdpdGggJ3N5bnRoZXRpYyBmaXJtbGlua3MnIG9u
IG1hY09TDQo+ID4NCj4gDQo+IEkndmUgbG9va2VkIGF0IHY1IGFuZCB2NiBhbmQgSSBsaWtlIHRo
ZSBkaXJlY3Rpb24gdGhpcyBpcyBoZWFkaW5nLCBzbyBJJ2xsIG1hcmsgdGhpcw0KPiBMR1RNLiAg
KEknbSBzdGlsbCB0cmF2ZWxpbmcgYmFjayBmcm9tIEdpdCBNZXJnZSwgc28gSSBoYXZlbid0IGhh
ZCB0aW1lIHRvIHRlc3QgaXQNCj4gb3V0LCBidXQgSSB0aGluayB3ZSBzaG91bGQgcHJvY2VlZCB3
aXRoIGl0LikNCj4gDQo+IFRoYW5rcyBmb3IgeW91IHBhdGllbmNlIGFuZCBhdHRlbnRpb24gdG8g
ZGV0YWlsIG9uIHRoaXMhDQo+IEplZmYNCg0KR3JlYXQhIEkganVzdCBjcmVhdGVkIHY3IHdpdGgg
c29tZSBzbWFsbCB1cGRhdGVzIGJhc2VkIG9uIEp1bmlvJ3MgZmVlZGJhY2suDQoNCkkgdGhpbmsg
dGhpcyBsYW5kZWQgaW4gYSBwcmV0dHkgZ29vZCBwbGFjZS4gSSBkb24ndCBrbm93IHRoYXQgdGhl
IHBsYW5zIGFyZSBmb3IgZnNtb25pdG9yIG9uIExpbnV4LCBidXQgSSd2ZSBhbHJlYWR5IHN0YXJ0
ZWQgdGlua2VyaW5nIGFyb3VuZCB3aXRoIGFuIGlub3RpZnktYmFzZWQgaW1wbGVtZW50YXRpb24g
Zm9yIHRoYXQgcGxhdGZvcm0uIFRoZSBkZXZpbCBpcyBpbiB0aGUgZGV0YWlscywgb2YgY291cnNl
LCBidXQgaXQgbG9va3MgZmFpcmx5IHN0cmFpZ2h0LWZvcndhcmQuDQoNCi1FcmljDQo=

