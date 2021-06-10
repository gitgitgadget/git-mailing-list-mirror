Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F08CC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 05:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F35613D0
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 05:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhFJFJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 01:09:21 -0400
Received: from mail-eopbgr50071.outbound.protection.outlook.com ([40.107.5.71]:25920
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229529AbhFJFJU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 01:09:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0Kky9c1902pg5qnzZN0EWoLmpALvTmKwbmsSvZocwJPllUhXkhNCAw54ynhkkX1bAgua2/dronrlFBOhacNQH0nk5DIFg76/tSG6g57Spr83UiZLJf/l7v/2ToWA0hAKpKMcrpEDDqd0NmfJ5IwyAiQ8kNHpzCL2IQTvfgNTJmyLJ41H9+6v50FKkvXRxPEdvxjLGRCQJxK/CIVanLown7HoaOVXtNtJbFFMEeTivPKDiG0jmguu+Vw8ZwJQejmijoX4VMKQpclqwW0dPt+juIkfHV8UAb0j3ZRnZpUuYlLOBs/CVxBbQ5DM7nOur7L3OoyicOhF1CB2jW+GTnjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkMlPm3vGW0Ys5Vs9zgP8M71xQNJINtNldjXk1PiRr4=;
 b=U4FhvhCefI2uXSBjNRux5xJY7r8jiEgN2NvelXXtpUYGzv5u5CwrxA+rCtH7ju2pe6T5Z2zf1EYXpF/rsfCxPomeIUfMpXdGEwf1f+Ek6Sj4DNCR4HBi5P5IEJhOEnGDyXzWYONlRXMU2qiWUgTDN7P3sijhYHRkkpiP+63m+UlHXOyzmvnbmf7DtBiGy9QwKW1pFhu3chgPWI6Ug+m1i+IGMvRyGx5Al3H/6s+qTB9zHMFBD5bnIRVMUBP4L7hPHoqrJ8UEJxYL4gN7ftMqqJmdt603mO9KbIjVFSMIKNtAlDPURqtvz0vvx+dKcvmbyyyUxuL0enVEW2S8F8t+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=velux.com; dmarc=pass action=none header.from=velux.com;
 dkim=pass header.d=velux.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=velux.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkMlPm3vGW0Ys5Vs9zgP8M71xQNJINtNldjXk1PiRr4=;
 b=jF5qDUB0bFe7L79DH6coPu4NG5ToUU+XN4/2tTkdICxjx8H7F8wScXpwD45Rfkj5M2vdcDv18R5UgxFt2XlMYMAR1JxqqEmEwQjDzT0mekP+AJaH7qw6yROuxoI9PN9DsiINuFh/x8a1mjS+xBRy1+rxWgIUaAObVKbU4F3+0sY=
Received: from DBAPR05MB7510.eurprd05.prod.outlook.com (2603:10a6:10:1a9::9)
 by DB7PR05MB4268.eurprd05.prod.outlook.com (2603:10a6:5:27::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 05:07:21 +0000
Received: from DBAPR05MB7510.eurprd05.prod.outlook.com
 ([fe80::4c3b:2076:6e5:7fef]) by DBAPR05MB7510.eurprd05.prod.outlook.com
 ([fe80::4c3b:2076:6e5:7fef%7]) with mapi id 15.20.4195.030; Thu, 10 Jun 2021
 05:07:21 +0000
From:   =?utf-8?B?Vm9qdMSbY2ggVmxhZHlrYQ==?= <Vojtech.Vladyka@velux.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Removing fully-merged branches
Thread-Topic: Removing fully-merged branches
Thread-Index: AdddDebS75P0rtSWR/qqamRC1aNRGgAi9depAAb4UDA=
Date:   Thu, 10 Jun 2021 05:07:21 +0000
Message-ID: <DBAPR05MB7510739C8AD273CD13FAD0DCEC359@DBAPR05MB7510.eurprd05.prod.outlook.com>
References: <DBAPR05MB7510441970BA87A456B8C0D8EC369@DBAPR05MB7510.eurprd05.prod.outlook.com>
 <xmqqwnr2h4xn.fsf@gitster.g>
In-Reply-To: <xmqqwnr2h4xn.fsf@gitster.g>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=velux.com;
x-originating-ip: [31.30.173.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10877d75-9e07-4c68-b741-08d92bcda0ea
x-ms-traffictypediagnostic: DB7PR05MB4268:
x-microsoft-antispam-prvs: <DB7PR05MB4268EB2D3B032EB0114B30DAEC359@DB7PR05MB4268.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eC1GD6lre7nY0b7895vV53GHcm4TIwSRDbvYtC0t+JVmXUFlHaWj2iAON7M34eb3u/YU3R4tF+RCIJMgcilXA/agblklzWMY8epggsN/7yAezSqpRdQR2P7NCRR0sH2HF4FXgLRyP9BTakLZllb+fm4HlwWa3cad2S+dLUn6KfBB35ce7yNNHhX2I9kN5X+cjfnHXcKD20HNzdKdjFGVXS+4OyDFdD2scjhSu3j8rQjr+x7ZWNdIQtP3Hn3H/43Xao36qf1tnyaXJQXmVRzGG5BMrKVFqheE1vgiVWt0Qj72JlGSDs2R/aV4u8T4bZ8k+fHsM4YwAi64JcO/Ng7FExJrTt17wvleTdJqXSWvATOGltgHdnFP/VfVs0TRAqDYHtrSfwjcCvN7EqZ9mhIJotTgKMjHrkyEM0izU41ZFcBjpCyFfEubtu1W9po2GVN6F8cdv73cZ7+JEJ62a5LLb8MD/0B6nx6NckeeF4udgg6RvZXmHgpfwN0ibXD2DZEVsYkT+oxEsRESfwxc2igYeGNgnXaPHVFJVWlMUIdCBBRb4ESq7kH0VsL7NfkQMOl9Jw3+fnmj0g6VQmB/pzyaQ7jGf12UdekSfaQEpqd9Ey4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR05MB7510.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(396003)(376002)(366004)(346002)(122000001)(38100700002)(8676002)(53546011)(6506007)(86362001)(71200400001)(4326008)(316002)(186003)(478600001)(9686003)(26005)(55016002)(6916009)(52536014)(5660300002)(85182001)(8936002)(85202003)(7696005)(66446008)(76116006)(3480700007)(33656002)(66946007)(66556008)(66476007)(64756008)(83380400001)(66574015)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aHpOcUs2T2xaYzV4OXZlODdYelpFcFRqTThQMGRFUnpZakduMGVjSUhrUWRp?=
 =?utf-8?B?dEZ4ancvN0NQUnNCeGNabDdHNEJPajMzT21MbnBLSlZPekxXTVpMVVJoQ1Q5?=
 =?utf-8?B?UTFqWTdWVW1keVNReFFENXArWVN0Y2JodDVIci8wbmYyRDdXUGFGVDNydDVz?=
 =?utf-8?B?czlkUXBHbWV4OUVHODhDUEF4bVkxWHhCN0dWN0wvcERZYWFaUkpvd2RwQktm?=
 =?utf-8?B?UXdyZ0ZOT2tRc2lVVkZHc3h0YWJJenpNdHZ6MlcrYm43MnJ3amhqOFVLS2lt?=
 =?utf-8?B?blZsbXViNHcrTlJybG1hSXBzSk81N21GSE11akxuaUJtaS9VdWtZRFBCZkZD?=
 =?utf-8?B?c2Z0NDNETDErTHJ2RTdDZXB1cnNNQUdKMGFSTkJac0swT3g4ZWdWc250c1NX?=
 =?utf-8?B?UzRpNUsrbmVYNW1SZDFzR0FldW01dFE1UGdkVEZ1TlNkdzZ3VDA3K0VwRW5S?=
 =?utf-8?B?SUpUYkxtdkxxUUhrSjV3a3lES2poU1paU1NnR082ZkdTTnUydllmQmh3UzFI?=
 =?utf-8?B?WDU5NElzNTluOEcvNUExR0FrS3k4VGpFQWwxbTFzWTVzb1pvK0d5TExQcmNv?=
 =?utf-8?B?NFVFb1ZhR2FJQ0FZckZncmN2L2FlUVNkWXE4MElZNHRYbnNhKy9ob2MvNVVE?=
 =?utf-8?B?ODRreTlLZmhoRHFXOTVDUTF6cGpLZzRLdGNiSlpER3F1bWQ4ajhmYUhQQVVS?=
 =?utf-8?B?M29OaWJUbndDeEdhY3F1YVU5MkFMNDRwL3ZnUXIwZlpvWmJTbDFzQmJETnRl?=
 =?utf-8?B?UHNKQnZEdFFIN05GTVZ0eWdKZWV1d3R3RkM1M1Rjd0NFOFp1OW9VUHpmY2RE?=
 =?utf-8?B?a2RSTXZ3TGphaDFRT1E4RURQZUdMWU85TG9lenk5Z0NDY1Nza05MSXBKeEpo?=
 =?utf-8?B?RmlUMjRVWHFDWnNYaUgvQ01rT3dtZHhmbFV6TEZheHNEbmNCM0dJdXlMZDly?=
 =?utf-8?B?TXk0a0gvcWhFZ1dGN2dWK3FiNkpSU3poNXl1TVVEZ1UwV1J0Yk8xM2lMVVZ0?=
 =?utf-8?B?VFlTMG4rM0crRVlidm1WdDkzVHhrdnB3VWFENEhaNjVNdE1KTVhyVGx4ajRq?=
 =?utf-8?B?WU5SeFNYeTNhVExYNHo1VXJlbmRBV2xrejZUdXFOQXNWUk1NS3FxdTI5Y0N1?=
 =?utf-8?B?dDJvL1pyUkkyUFA0K1ZpVDJ1RzRpckh1M0l3SjY0cmJXSk9vMmd2MTdBN1BU?=
 =?utf-8?B?SnVZeFlIa0F0bjBmRTlxQWo2aU9qM0hjWDBZQ1g0Q2IyZkJ0dDdVZjc0amVW?=
 =?utf-8?B?UGZPSUpmWXZJcmpuZE40VTd0c2VwV2trTEhnRmdHQ0ZQSForRXUzcVpVMzB4?=
 =?utf-8?B?ZzNPRlVMK0k2OXdIWS9kWGZWRzdYQ0F1czVVZ3pyNHdOUm1LdzR0MWJhV0tC?=
 =?utf-8?B?WFNkY0pmelpzTXRXK0NEKzd0dUs4NW9PeTRzd0N4SjhOUzRhZTNvbnZoRVNK?=
 =?utf-8?B?bmJXUXZONDM0T3hUd1RRREk1Mnc3eEtpQ3F5bXMxaUVTcUZ4VTd0UDkxUVJB?=
 =?utf-8?B?aW5kVGtYaUcxSnE2bDhPRmtPMXNhbjFxeUM2REdoL3piWWtpdDVaVSt5WHRL?=
 =?utf-8?B?RzM5ZExHUlQyQUMra0hYOXpPQUIrWlZxSUdGZzB0ZjFpcWlHMWJZTzVqc2Iw?=
 =?utf-8?B?MUpLNkxDN29PNncvUHJjeDNNendkMGNEN3EwRFBsQXM3K05tVkdpYlRJV2Jr?=
 =?utf-8?B?bWJDLy9oajNIdU8vdjBtdzBTaXBLTW5ZRlE0YnU2alk4KzJuZnVvYTNMOUxD?=
 =?utf-8?Q?k2g/g1//qdrYvyw6V7omuyeJUNPGy59Xy5f/k8z?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: velux.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBAPR05MB7510.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10877d75-9e07-4c68-b741-08d92bcda0ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 05:07:21.6677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9a3f3f0f-95b6-4766-93f1-6bd07de19cea
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tfqBQRY95ymhdN10ga9F0tpFEwfLWttTv8p+Rx1q3G3y6yElBSuseKfI+uxzyo8j9sySxofnOmzpdiJzPfc/DdKJIsI2ekavmxIuLpMvpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4268
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgY2xhcmlmeWluZyB0aGlzLiAgSSB0aG91Z2h0IHRoZXJl
IHdvdWxkIGJlIHNvbWUgcmVhc29uIGJlaGluZCBidXQgeW91IGFyZSBmaXJzdCB3aG8gcHJlc2Vu
dGVkIGV4YWN0IHJlYXNvbmluZy4NCg0KQW55d2F5LCBJIHRha2UgdGhhdCB0aHJvd24gZ2xvdmUg
YW5kIHRha2UgYSBsb29rIGF0IGdpdCBzb3VyY2VzIGFuZCBob3cgdG8gY29udHJpYnV0ZS4gTWF5
YmUgSSBjYW4gY29tZSB1cCB3aXRoIHNvbWV0aGluZyB1c2VmdWwuDQoNCkhhdmUgYSBuaWNlIGRh
eSwNClZvanRlY2gNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEp1bmlvIEMg
SGFtYW5vIDxnaXRzdGVyQHBvYm94LmNvbT4gDQpTZW50OiBUaHVyc2RheSwgSnVuZSAxMCwgMjAy
MSAzOjQxIEFNDQpUbzogVm9qdMSbY2ggVmxhZHlrYSA8Vm9qdGVjaC5WbGFkeWthQHZlbHV4LmNv
bT4NCkNjOiBnaXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogUmVtb3ZpbmcgZnVsbHkt
bWVyZ2VkIGJyYW5jaGVzDQoNCkF0dGVudGlvbiEgVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgb3V0
c2lkZSBvZiBWRUxVWC4NCg0KDQpWb2p0xJtjaCBWbGFkeWthIDxWb2p0ZWNoLlZsYWR5a2FAdmVs
dXguY29tPiB3cml0ZXM6DQoNCj4gSSBrbm93IHRoZXJlIGFyZSBjb21tYW5kIGNoYWlucyBkb2lu
ZyB0aGlzIGpvYiB1c3VhbGx5IHN0YXJ0aW5nIHdpdGggDQo+IGdpdCBicmFuY2ggLS1tZXJnZWQg
Zm9sbG93ZWQgYnkgZ3JlcCBhbmQgZW5kaW5nIHdpdGggZ2l0IGJyYW5jaCAtZCBidXQgDQo+IG15
IHBvaW50IGlzIHdoeSBzdWNoIGZ1bmN0aW9uYWxpdHkgaXNuJ3QgaW4gZ2l0IGNsaWVudCBhbHJl
YWR5IHdoZW4gaGUgDQo+IGhhcyBhbGwgcGllY2VzIG9mIGluZm9ybWF0aW9uIGFscmVhZHkgYW5k
IGFiaWxpdHkgdG8gZG8gYWxsIG9mIHRoYXQuIA0KPiBNYXliZSBJIGFtIG1pc3Npbmcgc29tZSBy
ZWFzb24gYmVoaW5kIHRoYXQgYnV0IHRvIG1lIGl0IGxvb2tzIGxpa2UgDQo+IG1pc3NpbmcgZmVh
dHVyZS4NCg0KSSB0aGluayB0aGUgcHJpbWFyeSByZWFzb24gYmVoaW5kIGl0IGlzIGJlY2F1c2Ug
dGhlIHdheSB0byAicHJ1bmUiDQooaS5lLiB5b3UgZ2F2ZSBhIGdvb2Qgb3V0bGluZSB5b3Vyc2Vs
ZiBpbiB5b3VyIG1lc3NhYWdlKSBpcyB0cml2aWFsbHkgZGlzY292ZXJhYmxlIGFuZCBwZW9wbGUg
Y2FuIGRvIHNvIHdpdGggbW9yZSBmbGV4aWJpbGl0eSB0aGFuIGEgaGFyZGNvZGVkICJyZW1vdmUg
ZXZlcnkgYnJhbmNoIHRoYXQgZG9lcyBub3QgaGF2ZSBjb21taXRzIHRoYXQgZG9lcyBub3QgZXhp
c3QgaW4gdGhlICRtYXN0ZXIgYnJhbmNoIi4gIEFkZCB0byBpdCB0aGUgZmFjdCB0aGF0IHRob3Nl
IHdobyB3YW50IHRvIG1ha2UgaXQgaW50byBhICJuYXRpdmUiIGZlYXR1cmUgaGF2ZW4ndCBwcm9k
dWNlZCBhbnkgdXNhYmxlIGRlc2lnbiB5ZXQgWypdLg0KDQpJbiBteSByZXBvc2l0b3J5IHRoYXQg
aXMgdXNlZCB0byBkZXZlbG9wIEdpdCBpdHNlbGYsIGZvciBleGFtcGxlLCAicmVtb3ZlIGFsbCBi
cmFuY2hlcyB0aGF0IGFyZSBtZXJnZWQgdG8gJ21hc3RlciciIGlzIG5vdCBzb21ldGhpbmcgSSdk
IGV2ZXIgd2FudCB0byBydW4sIGFzIGl0IHdpbGwgbG9zZSBhbGwgdGhlIG1haW50ZW5hbmNlIHRy
YWNrcyAoaXQgaXMgYSBydWxlIGluIHRoaXMgcHJvamVjdCB0aGF0IG9sZGVyIG1haW50ZW5hbmNl
IGJyYW5jaGVzIGFyZSBzdWJzZXQgb2YgdGhlIG5ld2VyIG9uZXMgYW5kIHRoZSAnbWFzdGVyJyBi
cmFuY2gpLCBhbmQgcmVtb3ZpbmcgYWxsIHRvcGljIGJyYW5jaGVzIHRoYXQgYXJlIG1lcmdlZCB0
byAnbWFpbnQnIHdvdWxkIG5vdCBnZXQgcmlkIG9mIGFzIG1hbnkgc3RhbGUgdG9waWMgYnJhbmNo
ZXMgdGhhdCBhcmUgYWxyZWFkeSBtZXJnZWQgdG8gJ21hc3RlcicgYW5kIHdpbGwgbmV2ZXIgYmUg
bWVyZ2VkIGRvd24gdG8gJ21haW50JyBvciBvbGRlciBtYWludGVuYW5jZSB0cmFja3MsIHNvIGZv
ciBzdWNoIGEgZmVhdHVyZSB0byBiZSB1c2VmdWwsIEknZCBuZWVkIHRvIGJlIGFibGUgdG8gZXhw
cmVzcyBzb21ldGhpbmcgbGlrZToNCg0KIC0gSWYgYSBicmFuY2ggaXMgbm90IGEgdG9waWMgYnJh
bmNoIChpZGVudGlmeWFibGUgYnkgaGF2aW5nDQogICB0d28tbGV2ZWwgbmFtZXMgbGlrZSB2di90
b3BpYyksIGRvIG5vdCB0b3VjaCBpdC4NCg0KIC0gSWYgYSB0b3BpYyBicmFuY2ggaXMgYmFzZWQg
b24gJ21haW50JyBidXQgbm90IG1lcmdlZCB0aGVyZSB5ZXQsDQogICBrZWVwIGl0Lg0KDQogLSBJ
ZiBhIHRvcGljIGJyYW5jaCBpcyBtZXJnZWQgdG8gJ21hc3RlcicgYW5kIGluIGEgdGFnZ2VkIHZl
cnNpb24NCiAgIChpZGVudGlmeWFibGUgYnkgaGF2aW5nIGEgc2lnbmVkIHRhZyB3aG9zZSBuYW1l
IGRvZXMgbm90IGVuZCB3aXRoDQogICAtcmNYKSwgbG9zZSBpdC4NCg0KU28gdGhhdCBhIGJ1Z2Zp
eCB0b3BpYyB0aGF0IGhhcyBhcHBlYXJlZCBpbiB0aGUgbGFzdCBmZWF0dXJlIHJlbGVhc2UgY2Fu
IGJlIGtlcHQgdG8gbGF0ZXIgYmUgbWVyZ2VkIGRvd24gdG8gb2xkZXIgbWFpbnRlbmFuY2UgdHJh
Y2tzLg0KDQoNCltGb290bm90ZV0NCg0KICogQXMgZmFyIGFzIEkgcmVtZW1iZXIsIHRoZSBtZXNz
YWdlIEkgYW0gcmVzcG9uZGluZyB0byBtaWdodCBiZSB0aGUNCiAgIGZpcnN0IHRvIGV4cGxpY2l0
bHkgYXNrIGZvciBzdWNoIGEgZmVhdHVyZS4NCg==
