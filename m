Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876CCC433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 20:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 424AF20758
	for <git@archiver.kernel.org>; Wed, 20 May 2020 20:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IE3IchGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgETU7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 16:59:34 -0400
Received: from mail-eopbgr640101.outbound.protection.outlook.com ([40.107.64.101]:60864
        "EHLO NAM06-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727018AbgETU7e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 16:59:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P34QN9MOsbdYoKybOa5Sehv5ND1VSPILoe2iy73DfFFW3PRfW/lVFEVvNkectapWCxNNJIbvNABWg8Ut8rQCzRa8DzAAxW++lqKaelkD2xjlwlOOX58C8BW8jrUw/BYdeUalkfcB8dKeP+9cE5WmTOnXwclQhl26uruPf9cYu53kET4iMic40HP/AKgxfx66BuxDbSBbSRfsH8KGD8Kv/fWSrMxxW59dL4YtjNRB6VXHKECSs36htgiH2NWJYad7NADOQww8SrMu9+3EuAVmHqkk/mrzK5MaCd295nu3EA6cUqbDiueBfOKfOGzjeWA0h4LXIh+CxXQ+GGnF9aCYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzFkwHGxSgnmd0izuLbZ5rKZL+WBTgioXVkc2IGMOGU=;
 b=RAYuGHzMxMhqk+Z1pkwv7JbsPRVs1vzxkrApqOqFDLlVhSQXOq6kP5Tm3X2Wi6k/RgxLZ7iYMQuIZfV1OtVJeixJFMWlZtAGoDrpvvfRgfC28t48eGAvd1CNtf47Ar6evUks84s0Fzp9ixz4MsCtx1u94jKcOTtI7M77pwxZGlZNEu4w1s7QoEe9mFhYqfgBYVaRTJqJxnQpY9efth/pUliu3s38Vh5+GtCS9l+KOofw1t/1fHhbnXFHswD7qt7ImxWfIeskeK8zyiqE5h1HV3Lkx37MKZO7LAaKcQqg1unakEaJ7p1dHmUMiTn7qalC/15YHiaKzd+urOxfvD9e8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzFkwHGxSgnmd0izuLbZ5rKZL+WBTgioXVkc2IGMOGU=;
 b=IE3IchGIv6ewKxvCt9nC+ZMQXV2VlBCxKQJVtddFDLBCVrI1vu1fwnhU2mnkWarMMgPKOGrsf0QpCXbUj7e9lU9cpVZghNanRk/cYXX9L56ksAdSUIc9bkQKMm/hGJCbUUpgXba7bcmtZ9mvOZVY8UVPuEpPHyZD05psdIzJnT0=
Received: from DM5PR00MB0439.namprd00.prod.outlook.com (2603:10b6:4:a1::21) by
 DM6PR00MB0859.namprd00.prod.outlook.com (2603:10b6:5:220::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3064.0; Wed, 20 May 2020 20:59:31 +0000
Received: from DM5PR00MB0439.namprd00.prod.outlook.com
 ([fe80::8951:8372:c8fb:fb26]) by DM5PR00MB0439.namprd00.prod.outlook.com
 ([fe80::8951:8372:c8fb:fb26%8]) with mapi id 15.20.3064.000; Wed, 20 May 2020
 20:59:30 +0000
From:   "Christopher Warrington (CHRISTOPHER)" 
        <Christopher.Warrington@microsoft.com>
To:     =?utf-8?B?Q2FybG8gTWFyY2VsbyBBcmVuYXMgQmVsw7Nu?= 
        <carenas@gmail.com>, Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "liu.denton@gmail.com" <liu.denton@gmail.com>,
        Garima Singh <Garima.Singh@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: RE: [EXTERNAL] Re: [PATCH 2/3] bisect: remove CR characters from
 revision in replay
Thread-Topic: [EXTERNAL] Re: [PATCH 2/3] bisect: remove CR characters from
 revision in replay
Thread-Index: AQHWLrbZ8l1PhbN+dEqVUekik8OBc6ixNTOAgAArO/A=
Date:   Wed, 20 May 2020 20:59:30 +0000
Message-ID: <DM5PR00MB0439A347273E56C8697A587A9BB60@DM5PR00MB0439.namprd00.prod.outlook.com>
References: <20200520034444.47932-1-carenas@gmail.com>
 <20200520034444.47932-3-carenas@gmail.com>
 <xmqqzha2wt7t.fsf@gitster.c.googlers.com> <20200520170843.GC20332@Carlos-MBP>
In-Reply-To: <20200520170843.GC20332@Carlos-MBP>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:8300:2f1f:b82e:382d:7af5:e532]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b173c7b-caff-4ac0-55df-08d7fd00b11d
x-ms-traffictypediagnostic: DM6PR00MB0859:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR00MB0859BD30C0F0CC3D090BC1189BB60@DM6PR00MB0859.namprd00.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kmVFcNN/P6v35AjQ681oDOtwm8GMl2gXe7/ULIa8tml2uO0IMOvLxPSQFag0PN++Qkc1ITvUHn0FzoLWqnUIg4/FPFguqUcUo0vN1jMgXQJ1E0P1QuQIAsKd9mENaqQxdJk2Gozpsb3anmjbwZ26VqLfctPE9NP/hDhtwNbVwMXs6nsW2qxpuOpMXuzDVUQB4TGzh9BGMrPr3lfwrWxaFHRE9b1YZ2KC7hgb4ljzv2hExbWfCqVrFcj7E9/Hsp6Gow4kelDUKX0wwR9SDkuh918WuMeGZarI/OT6mNunpJWiteVjkeewbZ+JlqNJa4XB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR00MB0439.namprd00.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(8936002)(55016002)(9686003)(6506007)(7696005)(8676002)(186003)(8990500004)(5660300002)(66476007)(71200400001)(66946007)(66446008)(66556008)(64756008)(86362001)(76116006)(52536014)(2906002)(54906003)(66574014)(110136005)(316002)(82950400001)(82960400001)(33656002)(4326008)(478600001)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /3kcJ+qbNJIU+7n2++YKhntsXRCcwBJzfT3wsny1iLwh70gF6F2AQVRk9DvEQ2kABpstCyOGYIppOqyFKNwRMr+8Ri/vvIiv0s8wc/brFjMNwtFH7vppOIDDVhAHDya9/r669edQnNBFkz7ElOtFqw+dt07T5of+014SIUdAsSoRvo2IRZE3pbNQVI9BoNthTLjLG75VxPCEHqYm2EHiTyUzD22xYx+7CW/loOABBNSxTJ6zmF57wyqsHT/ZcpBzJhBcD9W3r0Rf/jPZwdkHJFCwuR0GBp4QbbSvv+NZj73o65L+pBm7fas7l2ft5wHFNnTOlbR35Y4zOC2TvA1gOO2cFQaZaTfA3aF64do2d6rbAl7XnxJO0MNIvhlClrU5jwbVtLWbIo5KNDEjOaiA9luy3psBckUniz6lSTv9AZnhbiGXlzy1K+1Advd9U1yGfokH7JO7+atOFoB9I6jFhr8+GGbFog46tyQ21yLx087xwsNfFaikFnyBIt8RsMZhuM1uBXVf/zmfwJP8y/UAjVCkv7M+lrJQyYaOinCejEOKS2MuWY9fecnS+dopbqg8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR00MB0439.namprd00.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b173c7b-caff-4ac0-55df-08d7fd00b11d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 20:59:30.8482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXofjDz0mHwFyPaBBcnJtHW1wfE6Mo0vo4xzsOrNjWSZ91ku8q5d/bhg76O2K3rXLpztvlnIRJ1oFSpQmh+ocQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR00MB0859
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gMjAyMC0wNS0yMCBhdCAxMDowOS0wNzowMCwgQ2FybG8gTWFyY2VsbyBBcmVuYXMgQmVsw7Nu
IHdyb3RlOg0KDQo+IElNSE8gaXQgd2lsbCBiZSBwcm9iYWJseSBzdGlsbCBjbGVhbmVyIHRvIGRv
IGB0ciAtZCAnXDAxNSdgLCBldmVuIGlmIHRoZQ0KPiBwYXRjaCBiZWxvdyBhdm9pZHMgYWxsIGN1
cnJlbnQgaXNzdWVzIGZyb20gdGhlIHRlc3RzdWl0ZS4NCg0KTXkgaW5pdGlhbCBhdHRlbXB0IHRv
IGhhbmRsZSBDUkxGIGxvZ3Mgd2FzIHNoYXBlZCBsaWtlIHRoaXM6DQoNCgl0ciAtZCAnXHInIDwi
JGZpbGUiIHwgd2hpbGUgcmVhZCAuLi4NCg0KVGhpcyBpbnRyb2R1Y2VzIGEgc3Vic2hlbGwsIHNv
IHRoZXJlIHdlcmUgY29uY2VybnMgYWJvdXQgcHJvcGFnYXRpbmcNCnZhcmlhYmxlcyBhbmQgZXhp
dHMuIFNvLCBQZWZmIGFsc28gc3VnZ2VzdGVkIHByZXByb2Nlc3NpbmcgdG8gYSBmaWxlLiBBcm91
bmQNCnRoZSBzYW1lIHRpbWUgSnVuaW8gdHJpZWQgdXNpbmcgSUZTLCBhbmQgdGhhdCB3YXMgc2lt
cGxlci4NCg0KSXQgd291bGQgYmUgcHJldHR5IGVhc3kgdG8gdHIgLWQgJ1xyJyA+IiRHSVRfRElS
L0JJU0VDVF9SRVBMQVlfTE9HIiAob3Igc29tZQ0Kb3RoZXIgbmFtZSkgYW5kIHRoZW4gcmVhZCBm
cm9tIHRoYXQuDQoNClR3byB0aGluZ3MgSSdtIG5vdCBzdXJlIG9mIHdpdGggc3VjaCBhbiBhcHBy
b2FjaDoNCg0KMS4gSXMgJEdJVF9ESVIgdGhlIHJpZ2h0IHBsYWNlIHRvIHB1dCB0aGlzPyBJZiBu
b3QsIGlzIHRoZXJlIGEgaGVscGVyIHRvDQogICBjcmVhdGUgYSB0ZW1wb3JhcnkgZmlsZT8gbWt0
ZW1wIG1heSBub3QgYmUgYXZhaWxhYmxlIGV2ZXJ5d2hlcmUuIEkgb25seQ0KICAgc2VlIGdpdC1t
ZXJnZXRvb2wuc2ggdXNpbmcgaXQgYW5kIG9ubHkgYmVoaW5kIHRoZSBtZXJnZXRvb2wud3JpdGVU
b1RlbXANCiAgIHZhcmlhYmxlLg0KDQoyLiBIb3cgYW5kIHdoZW4gZG9lcyB0aGlzIHRlbXAgZmls
ZSBuZWVkIHRvIGJlIGNsZWFuZWQgdXA/IExvb2tpbmcgYXQgdXNpbmcNCiAgIHNvbWV0aGluZyBs
aWtlIHRyYXAgInJtIC1mIFwiJHRlbXBfZmlsZVwiIiAwIHdpbGwgY29uZmxpY3Qgd2l0aCB0aGUg
dHJhcHMNCiAgIHRoYXQgZ2l0LWJpc2VjdC5zaCdzIGJpc2VjdF9zdGFydCBpbnN0YWxscywgYW5k
IGJpc2VjdF9yZXBsYXkgY2FsbHMNCiAgIGJpc2VjdF9zdGFydC4gSSBjb3VsZCBpbnRyb2R1Y2Ug
YSBoZWxwZXIgbGlrZQ0KICAgbWF5YmVfdW5saW5rX3RlbXBfcmVwbGF5X2xvZyBhbmQgaW52b2tl
IHRoYXQgZnJvbSBhIHRyYXAgaW5zdGFsbGVkIGluDQogICBib3RoIGJpc2VjdF9yZXBsYXkgYW5k
IGJpc2VjdF9zdGFydC4NCg0KICAgSSBsb29rZWQgYXQgd2hldGhlciBiaXNlY3QuYydzIGJpc2Vj
dF9jbGVhbl9zdGF0ZSgpIGlzIHRoZSByaWdodCBwbGFjZSB0bw0KICAgYWRkIHN1Y2ggY2xlYW4g
dXA6IGl0IGRvZXMgbm90IGxvb2sgbGlrZSB0aGUgcmlnaHQgcGxhY2UuIEl0IHdvdWxkIHJlc3Vs
dA0KICAgaW4gdGhlIHRlbXAgZmlsZSBnZXR0aW5nIGRlbGV0ZWQgd2hpbGUgaXQgd2FzIGJlaW5n
IHJlYWQuIChnaXQtYmlzZWN0LnNoDQogICAtPiBiaXNlY3RfcmVwbGF5KCkncyBsb29wIC0+IGJp
c2VjdF9zdGFydCgpIC0+IGJpc2VjdC0taGVscGVyLmMncw0KICAgYmlzZWN0X3N0YXJ0KCkgLT4g
YmlzZWN0LmMncyBiaXNlY3RfY2xlYW5fc3RhdGUoKSkgQWxhcywgbm90IGFsbCBmaWxlDQogICBz
eXN0ZW1zIGFyZSBPSyB3aXRoIHRoYXQgaGFwcGVuaW5nLg0KDQpBbnkgZ3VpZGFuY2U/DQoNCkhl
cmUncyBhIHNrZXRjaCB0aGF0IGxlYXZlcyBjbGVhbnVwIG9uIG5vbi1zdWNjZXNzZnVsIHBhdGhz
IHVuYWRkcmVzc2VkLg0KDQpiaXNlY3RfcmVwbGF5ICgpIHsNCglmaWxlPSIkMSINCgl0ZXN0ICIk
IyIgLWVxIDEgfHwgZGllICIkKGdldHRleHQgIk5vIGxvZ2ZpbGUgZ2l2ZW4iKSINCgl0ZXN0IC1y
ICIkZmlsZSIgfHwgZGllICIkKGV2YWxfZ2V0dGV4dCAiY2Fubm90IHJlYWQgXCRmaWxlIGZvciBy
ZXBsYXlpbmciKSINCglnaXQgYmlzZWN0LS1oZWxwZXIgLS1iaXNlY3QtcmVzZXQgfHwgZXhpdA0K
DQoJc2NydWJiZWRfZmlsZT0iJEdJVF9ESVIvQklTRUNUX0NMRUFORURfTE9HIg0KCXRyIC1kICdc
cicgPCIkZmlsZSIgPiJzY3J1YmJlZF9maWxlIiB8fCBkaWUgImJhZG5lc3MiDQoNCgl3aGlsZSBy
ZWFkIGdpdCBiaXNlY3QgY29tbWFuZCByZXYNCglkbyAuLi4gZG9uZSA8IiRzY3J1YmJlZF9maWxl
Ig0KDQoJcm0gLWYgIiRzY3J1YmJlZF9maWxlIg0KCWJpc2VjdF9hdXRvX25leHQNCg0KLS0NCkNo
cmlzdG9waGVyIFdhcnJpbmd0b24gPGNod2FyckBtaWNyb3NvZnQuY29tPg0KTWljcm9zb2Z0IENv
cnAuDQo=
