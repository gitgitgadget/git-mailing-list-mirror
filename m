Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F3BC761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 18:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbjDDSAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 14:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbjDDSAF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 14:00:05 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021026.outbound.protection.outlook.com [52.101.62.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF200C9
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 11:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdxEGRutUb12oX/hDg8LDuwHdUC6R1NB8NZG8f3asqLgostNo890IJxtc+izw9KwtM8bXwEc/ZVlidELlbP9jLYVUMzy2B8VKB+pblTIMjNEGpEeeIgXPhWdGrM1XxlacGejtmBU/XDO9nxOKU88Uf7p0rLj4wnkJRSQE8UjjDiZJQjd/qzROwkx6N5CzdhmAso6k0gl/Es1msrZ1A36JgV7kCk3Zr1i28ECOhYbQgvadvO9NCqSe4qCXATw/JFAdFbMfW2EBCTHgbjDMR2wzPKZpNa2GmZ59YN0XbksUrllXATC95qugRKXXOWWByI+y3Al7MKs0b+R+hWKTrZugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhJAVyZljPDf3ry5Dwum3ZKXJDpPsHELlqa/aRJeR50=;
 b=fbNkqDKD1Uae+sKwiKHUJoKFabdwMYSxWk402JXr0ZIBh6jAJRx6sTuACFAL2kDp3NUqPnDvpNQVNb6iR0FP8d0kcPOsftZqU4ZX66PonwoiitMrp9rfUoTNzlyvez+zilf61EuD/aW0OlU85yqyF6vByOVjevx1dWHaONTJl1I3kES59GdbOdg0gwWl1zGzKvXwsrnrnuKUVg1UDj3YTEshS0LFr9VPS/BCrdb655fpJtxgitXlRYr/NhAKIq2Qd5wpjaOQd1zTpsxexGI/lHWgx81NB0EAWdQgZX26qPdrNzBmPyP7+9uq0pwG0hb+xoJziqIw7td5596q7WoKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhJAVyZljPDf3ry5Dwum3ZKXJDpPsHELlqa/aRJeR50=;
 b=C3rZJoZ9qXprWUWNhRa/TOHiM5sVj9qrdqKDQwQd2jo3a3OuIbLqh0uoKV06u287nlXetv53P7pHtNCkPHDkyShdjK6vsq6pvnRR5v+PO28GMZF+b0tG41dlxunUL043oMpNLxSmJsI9YSibh9P1KWx58KKYP0ceJs37LD38BE8=
Received: from LV2PR21MB3133.namprd21.prod.outlook.com (2603:10b6:408:179::20)
 by IA0PR21MB4004.namprd21.prod.outlook.com (2603:10b6:208:483::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.11; Tue, 4 Apr
 2023 18:00:01 +0000
Received: from LV2PR21MB3133.namprd21.prod.outlook.com
 ([fe80::811c:96d6:7b64:ca3e]) by LV2PR21MB3133.namprd21.prod.outlook.com
 ([fe80::811c:96d6:7b64:ca3e%7]) with mapi id 15.20.6298.010; Tue, 4 Apr 2023
 18:00:00 +0000
From:   Bran Hagger <brhagger@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Emily Shaffer <nasamuffin@google.com>
Subject: Improving support for name changes in git
Thread-Topic: Improving support for name changes in git
Thread-Index: AQHZZx7oWui50G3+xECCYolSgCDoRQ==
Date:   Tue, 4 Apr 2023 18:00:00 +0000
Message-ID: <LV2PR21MB31334981E02BCA25792BAFFCCF939@LV2PR21MB3133.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-04T17:59:58.003Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR21MB3133:EE_|IA0PR21MB4004:EE_
x-ms-office365-filtering-correlation-id: 15050531-a930-4ac9-e9ca-08db353668ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LDkZvkwgAM27IHELJleG1j2k+iUZVaF26bQIcElqRh6XUUrRJmCSURfNCgkZtf40XirekptW1CadQCuyIawM7NGDYpfx3drxUb18tMMa4rIUCkYBzXymgwnmveSTQ0C6ZCSYtusSlM6y6RhaXZY08hLIgPzqWH5W4dBrO0h8mfj+TmCldYvHotp2U4pbTP679DrYLwGmzKTreIJF6dfnwaRJxMbYCn5QepA5Bd8MXRZ/WT6p3pp4yWJwt8eCwPEMffTfaW4+CCb+79u6iJG1+XkoZT9nuJO0Rg4Uc2W5nMCP9l1GBdUvRq3kxnuglsYO6OEuaMXXvmG3F8SwqtcKwR5SeQU1GgS/11B8cmBXF/IARdbAkhyQplhq5SXipsWwYiAuZDg6+c9e03ZV2iOeUWLKj7UEMJzaK1d92EvkukolRTLgUnDIIk18WF+EIB9gHAXqZXlyQJr3dBNKpucnp5d7VFDmo//Nd+2a8MXkoyOeC4VNq+bSjjAbZvSr/3YM9RqO7EEgWP2xJowkNp+LgX7L3XLQcS61PYPhvT5JVFmk9Z6QYhAI+mYc5gV3AfidaC2qE+92RBkpqMRa3k6WYGy97f5ZXaWkBALLzu5UnBblCgUwiz8AIlSOw+vYV6cdiVU5sw7ZrqZ1rTvsW4A+lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR21MB3133.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(186003)(2906002)(9686003)(26005)(6506007)(83380400001)(66899021)(55016003)(82960400001)(82950400001)(966005)(5660300002)(8936002)(52536014)(7696005)(71200400001)(38100700002)(478600001)(10290500003)(122000001)(41300700001)(38070700005)(76116006)(8990500004)(316002)(33656002)(66446008)(86362001)(8676002)(91956017)(64756008)(786003)(4326008)(66946007)(66476007)(66556008)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGZSR2Rmb0VYZ3ZRTGFPNFFZRWs5WHN0cEVlVkZvZTIyQmRpS2JuTi9wN1o0?=
 =?utf-8?B?a2IxSndPcEZ2MU9YVVdvL1FOcEg1OWI1enZkWUo3dTNKVFJhM0FWOWtLamdu?=
 =?utf-8?B?M1IwVzJrOHhzZFJlUW56YWxoL1N6bVNhRU5Jd3NmWFlnRDlqdVlSRUc3OVE1?=
 =?utf-8?B?REhFcWFZczFJa3loQ3RFT3o0TjZMTGo1OUpFRk51R2dVT0NEVXlHTUZvY0FR?=
 =?utf-8?B?TVB3d2dEaUxzUjMwOUFnQmkvdnUrUnBTOGxDeTk0ZnF3VGRIbGFuOXY2UVNk?=
 =?utf-8?B?bE5xTDArOENmMzVtSnpIS1NKT0VQNUk4SzgzRWtRWE9PZ3UzKzRFakdOdkZZ?=
 =?utf-8?B?MStML1dDS3JJSTA1TFloWVBoVUFTTUM1SVZLdTBxMkNOdnNZc2FjZjVOalRw?=
 =?utf-8?B?MGhCWElUdmxnQnNjdjlyeDhWRTZGNFV0dWVURm04YjFaVnI3cmxwRWlVUENP?=
 =?utf-8?B?dTA5YWlacno4MytYdVlSNU5mdDlkSmNUL3dLbHorWXZDQ1ZsblFnejdPcGV4?=
 =?utf-8?B?ek5vTVlKbnFGcE9HREhkWlFXaHhpSlRRc0VmcW04K1B6bnIyT3hKd2o2Rldj?=
 =?utf-8?B?NjNVUUh0UWhyeWV6dGh4UjBsckhOQXdiSTZvelBlY2xYdG1PNGtUdmVUZEdz?=
 =?utf-8?B?d3ovQWwvZGZ3anJWRWc2MmhPNHI3NnZObnA0LzFlSnh2d1VNNUNHODRobzZt?=
 =?utf-8?B?d2ZOazNpYUxyUWd1dWd4QkIrSFVoandFMjAydlVvUGs1ZHhnYXFiM3FISXFr?=
 =?utf-8?B?OU9lb1FaanhyTEhJakxKNGVqRUlqVUFNWlBYSDN5WWNWUnFONFhjWTFxT2Z1?=
 =?utf-8?B?dTIvdk5CVkNkcEpQb3VQR0tWUzNKdDhnWCs3dXVIV0lDNVBOMkMyZWcwM1NG?=
 =?utf-8?B?NUllNFVjK1NtQmwybEhETjlJYkJDSjZsRlcrU2ZGK29ydlJDSmRJVW9xTHFI?=
 =?utf-8?B?cEZLeVRUWDlEK2ZXT2oyTVQ0cTNKbDFHLytrbkk0SjBtSERmTkJiWGlCUmxy?=
 =?utf-8?B?R2kzMGZ4aU1EVGQ1TXhSdE1Va2lTQ3J6ajhMZjlNcHVqN1k0MjY0KzhkVlFz?=
 =?utf-8?B?cjRkeTZKTlA0SDMreHgwUEdKN3F2KzZWZitGMTV3SnpCN1dGSkpXZGNjQmJ3?=
 =?utf-8?B?WG5JbFYvOW5nTjJXZjFuUGlpNnZVYURMSnY4dFp0KzE5ZEl5WFlNbllEcmtO?=
 =?utf-8?B?dVYwdkU5dkdyMG53QXcveXRzNDArU0RDejdIQUIzOFRQbEY2aFEzRkJBaDU0?=
 =?utf-8?B?VTJVMzdJam5FWW1aSXR4Vjh0eVNmSDN2QStVTnBJb2Z1c1p3Y29ybGdWS0JO?=
 =?utf-8?B?NFd2THV1cVpEQWx1WmRJTXZzRkJ0dTdIb0JFOGZEQjlzSHpEUWI3RG5oTXpL?=
 =?utf-8?B?ZkdnbUJZV09BTkJLcnhRcmk3MmpxQ2NYaTcyVjd1NlUwN2c5K251bGlsZEdE?=
 =?utf-8?B?YVZZSVJWZm9GQStmenBNdk5neE5Qa280TGVXbXE1YzRVSjJtMUd2MlZhc1dQ?=
 =?utf-8?B?MFcwZG9WSU12TkhmcXVqazhGbkNmN3ZSNTJOaHN2TE91cThOd0U1bFk1a3pG?=
 =?utf-8?B?eUc1MENlNVRRbDJITTEySGZuYWkxN3lHbnNFTU5oVkU2VTUvbUNpTStpYzY4?=
 =?utf-8?B?dzV1NlJLRWY3NkJROGRhY3lCeGQ2dThRMmZUekNCS3J2OExYUmxvKzA1MFhj?=
 =?utf-8?B?akRNbG9LY3Y0dzZuK3Joc01IdFlJclVERENzWGVnaDduaEhTS2xxajRFR2lB?=
 =?utf-8?B?a0tNSlBMeE5ZVSsvc05mTm5wR0g4UjM4Wi93U2Z0d2hDRTloUy9tSUliK3Ri?=
 =?utf-8?B?L3B5dDVJcXI0WlIrdXhRVldHV0Npb0ZoRVgrZEYrekJZQWE1Q1lMTVNlY1R3?=
 =?utf-8?B?UG9kSEErSG9IcGJNcjdaeSt2aGpIcVVxY0hSay96TzVBNU1MNkx2Z2R4TVps?=
 =?utf-8?B?NnJlTVdsaXpWbUIvMU1ySlkvRVh3YVByQVdNM0IxOEV3U3hlZ2RXK0tEMTJS?=
 =?utf-8?B?K1h3TkdXemg3MXhkWGJmMFF4eTFXT3FYWVR3QnIvSmVOOTVjeUpSbXJmSE0z?=
 =?utf-8?B?dWpPdkp2bm5RVzE2VDYzaHFhZTFIRWJBYkpwT3ZiYXRLSmIwN21oNEZ1bEls?=
 =?utf-8?Q?d+S8RoH/VB8qnx3AsPlyFddDo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR21MB3133.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15050531-a930-4ac9-e9ca-08db353668ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 18:00:00.8790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oUfmnE/k31va8GV1gbVfMhdmF5JTZMjgt8tmsHMA/V2jOzNb7zrGtczlDeSXfOLCOzinapO1+FT/Vsef+b0rLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR21MB4004
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGVsbG8gR2l0IGNvbW11bml0eSwKCkknbSBpbnRlcmVzdGVkIGluIHZvbHVudGVlcmluZyB0byBo
ZWxwIGltcHJvdmUgdGhlIHByb2Nlc3MgZm9yIHVzZXJzIGNoYW5naW5nIHRoZWlyIG5hbWUgaW4g
R2l0LgoKSSd2ZSBzZWVuIHRoZSBub3RlcyBmcm9tIHRoZSBHaXQgc3VtbWl0WzFdIGFuZCB0aGUg
b2xkIHByb3Bvc2FsIHRvIGNoYW5nZSB0aGUgLm1haWxtYXAgdG8gdXNlIGhhc2hlcyBpbnN0ZWFk
IG9mIHBsYWludGV4dCBuYW1lc1syXS4gVGhlIHByb2JsZW0gd2l0aCBib3RoIGFwcHJvYWNoZXMg
aXMgdGhhdCBpdCBpcyBlYXN5IGZvciBvdGhlciB1c2VycyB0byBmaWd1cmUgb3V0IHRoZSBvbGQg
bmFtZSwgd2hpY2ggaXMgYSBwcml2YWN5IGNvbmNlcm4gZm9yIG1hbnkgcGVvcGxlIHdobyBjaGFu
Z2UgdGhlaXIgbmFtZXMuIFNpbmNlIHRoZSByZXZlcnNlIG9mIHRoZSBoYXNoZXMgaW4gdGhlIHNl
Y29uZCBjYXNlIGNhbiBiZSBlYXNpbHkgYnJ1dGUtZm9yY2VkLCB1c2luZyBoYXNoZXMgaW4gdGhl
IC5tYWlsbWFwIHByb3ZpZGVzIG5vIGFkZGl0aW9uYWwgcHJvdGVjdGlvbi4KCkEgc3lzdGVtIHRo
YXQgcHJldmVudHMgcGVvcGxlIGZyb20gcmV2ZXJzZS1lbmdpbmVlcmluZyB0aGUgb2xkIG5hbWUg
b2YgYSB1c2VyIHdobyBjaGFuZ2VzIHRoZWlyIG5hbWUgd291bGQgcmVxdWlyZSB0d28ga2V5IGNv
bXBvbmVudHM6CgoxLsKgVGhlIG1ldGhvZCBvZiBkZXRlcm1pbmluZyB0aGUgY3VycmVudCBuYW1l
IG9mIHRoZSBhdXRob3Igb2YgYSBnaXQgY29tbWl0IGNhbiBub3QgcmVseSBvbiBhbnkgaW5mb3Jt
YXRpb24gZGVyaXZlZCBmcm9tIHRoZWlyIG9sZCBuYW1lLgoyLiBUaGUgbWFwcGluZyB0byB0aGUg
Y3VycmVudCBuYW1lIG9mIHRoZSBhdXRob3Igb2YgYSBnaXQgY29tbWl0IGNhbiBub3QgY29udGFp
biBhbnkgaGlzdG9yeS4KClNvbHZpbmcgdGhlIGZpcnN0IHByb2JsZW0gc2VlbXMgcmVhc29uYWJs
eSBkb2FibGUuIEluc3RlYWQgb2YgZWFjaCBjb21taXQgaGF2aW5nIGFuIGF1dGhvciBuYW1lIGFu
ZCBlbWFpbCwgdGhlIGF1dGhvciBzZWN0aW9uIGNvdWxkIGNvbnRhaW4gYSBoYXNoIHRoYXQgaXMg
dXNlZCBmb3IgdGhlIG1hcHBpbmcuIFRvIG1haW50YWluIGNvbXBhdGliaWxpdHkgd2l0aCBvbGRl
ciB2ZXJzaW9ucyBvZiBnaXQsIHRoZSBmb3JtYXQgY291bGQgbG9vayBzb21ldGhpbmcgbGlrZToK
QXV0aG9yOiBIYXNoICN1c2VyLmlkSGFzaCA8ZW1haWxAbG9va0luLm5ld01haWxtYXA+4oCLCldp
dGggdGhlIHVzZXIuaWRIYXNoIGlzIGEgcmFuZG9tbHkgZ2VuZXJhdGVkIG51bWJlciBzZXQgaW4g
dGhlIC5naXRjb25maWcgdGhlIHNhbWUgd2F5IHVzZXIubmFtZSBhbmQgdXNlci5lbWFpbCBjdXJy
ZW50bHkgYXJlLiBBIC5uZXdNYWlsbWFwIGZpbGUgKG9yIHdoYXRldmVyIG5hbWUgd2UgY2hvb3Nl
IHRvIGdpdmUgaXQpIHdvdWxkIHRoZW4gbWFwIGZyb20gdXNlciBpZCBoYXNoZXMgdG8gdXNlciBu
YW1lcyBhbmQgZW1haWxzLgoKVGhlIHNlY29uZCBwcm9ibGVtIG9mIGhvdyB0byBtYWludGFpbiBh
IG1hcHBpbmcgb2YgdXNlci5pZEhhc2ggd2l0aG91dCBoaXN0b3J5IGlzIGEgcmFkaWNhbCBkZXBh
cnR1cmUgZnJvbSBob3cgZ2l0IGN1cnJlbnRseSB3b3Jrcy4gV2hpbGUgaGFuZGxpbmcgc3VjaCBh
IGZpbGUgb24gdGhlIGNsaWVudCBzaWRlIGlzIHByb2JhYmx5IG5vdCB0b28gdGVjaG5pY2FsbHkg
Y29tcGxpY2F0ZWQsIGl0IHJhaXNlcyBzZXZlcmFsIHF1ZXN0aW9uczoKCirCoEhvdyBjYW4gYSBn
aXQgcmVwb3NpdG9yeSBhY2NlcHQgY2hhbmdlcyBhbmQgcHJvdGVjdCBhZ2FpbnN0IG1hbGljaW91
cyBhY3RvcnMgbW9kaWZ5aW5nIHRoZSAubmV3TWFpbG1hcCBmaWxlIChvciBob3dldmVyIHdlIGNo
b29zZSB0byBuYW1lIGl0KT8gTWFraW5nIHB1bGwgcmVxdWVzdHMgdG8gbW9kaWZ5IHRoZSBmaWxl
IGFuZCBrZWVwaW5nIHRob3NlIHB1bGwgcmVxdWVzdHMgYXJvdW5kIHJlY3JlYXRlcyB0aGUgb2xk
IGlzc3VlIG9mIGhhdmluZyBhIHJlY29yZCBvZiBldmVyeSBuYW1lIGNoYW5nZS4KKsKgSG93IGFy
ZSBtZXJnZSBjb25mbGljdHMgaGFuZGxlZD8KKsKgSG93IGRvIHdlIGVuc3VyZSB1c2VycyBjYW4g
b25seSBzZXQgdGhlIG5hbWUgYW5kIGVtYWlsIGZvciB0aGVpciBvd24gaGFzaGVzPyBJZiB0aGUg
Y29tbWl0cyBhcmUgc2lnbmVkIHRoaXMgY291bGQgYmUgZG9uZSB2aWEgc2lnbmluZyB2ZXJpZmlj
YXRpb24sIGJ1dCBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgc2lnbmluZyBjb21taXRzIGlzIHJl
bGF0aXZlbHkgcmFyZS4KCkhhcyB0aGVyZSBiZWVuIGFueSBmdXJ0aGVyIHdvcmsgZG9uZSBvbiBz
dXBwb3J0aW5nIGdpdCBuYW1lIGNoYW5nZXMgdGhhdCBJIG1pc3NlZD8gQXJlIHRoZXJlIGFueSBl
eGlzdGluZyBmaWxlcyB3aXRob3V0IGdpdCBoaXN0b3J5IHRoYXQgZmFjZSBzaW1pbGFyIGlzc3Vl
cz8KClsxXcKgaHR0cHM6Ly9jb2RlLmdvb2dsZXNvdXJjZS5jb20vZ2l0L3N1bW1pdC8yMDIwLysv
bWFpbi9ub3Rlcy5tZApbMl3CoGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2dpdC8yMDIxMDEwMzIx
MTg0OS4yNjkxMjg3LTEtc2FuZGFsc0BjcnVzdHl0b290aHBhc3RlLm5ldC8KClRoYW5rIHlvdSwK
QnJhbiAoaGUvaGltKQoKUC5TLiBBcG9sb2dpZXMgZm9yIHBvdGVudGlhbGx5IGRvdWJsZS1zZW5k
aW5nIHRoaXMuIE15IGVtYWlsIGNsaWVudCBhY2NpZGVudGFsbHkgYWRkZWQgSFRNTCB0byB0aGUg
Zmlyc3QgY29weS4=
