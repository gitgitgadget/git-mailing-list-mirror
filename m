Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32518C433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B23520767
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mavenir.com header.i=@mavenir.com header.b="i5IORdvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgFVSnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:43:04 -0400
Received: from mail-eopbgr680051.outbound.protection.outlook.com ([40.107.68.51]:32133
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729605AbgFVSnD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 14:43:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epcFSpDq4znyE29u0TiR/CKijZF/KR/RZy8AM06OmeA77R0BrWrI2nbv8/yEhr9myIg3ju/QyRv2t2uun1OavQg5uM1DEbpF8ZUEvPSL0QF9HIdsOs1Kuvgfrlu1ZcEgGR/GAtgnZ7wQnMYt4Iz4p4OLHB/q0QlA77PKGXx3UxDymbsenk7ng3F/GMxKWD7tgmcm7A3Xr1PBLQhjckBp+KqiVgiPKa645NZDvO+J2j/+PhTJrymqlsu7sHYcBHPpvDJijl4kGKHC3R7IllS9MbdoLwgfbHCu41q3AsIITWZyDbQogMYPXG2pG4rfMenMTV80pOdfwVOyGCA0yZPmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLrn70eoY4zi7+ZSg1SLT6Wqpw4Lb9OWi+hlvdKVF1U=;
 b=SOvigWhFHgYZrIPKLxPZsZyfn3H3itYeFZ7wBH3yqAPcH+HeXNTnbPZBKFyZTf6peQy0gnKUxVUK7h4Om2H5sIlunFURA/NWB4mNPCSrUHHPSvjed22esdvepxRsrfZ1hd1WxJgKaTIGJ2oe5FHokzHqykIU3kg94hKwv245eZ3yim+nVFTEYjoarG51P/dY/lgK6fa3S23py1zK3wqJ+gv7kYzCKUnOMeT6u8MTxB8LrAm1FtV6cRxKuaAFRwU7sxuJfHqWBench/jsb6hXiWt4oo/JDAz0bv83LzZjOAptwTPfFVamxUotYKKJzC3SRRJrmVZ860r/+tUPW0oLfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mavenir.com; dmarc=pass action=none header.from=mavenir.com;
 dkim=pass header.d=mavenir.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavenir.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLrn70eoY4zi7+ZSg1SLT6Wqpw4Lb9OWi+hlvdKVF1U=;
 b=i5IORdvRVdqDI7YwKTRJi7DubuFaqyEf6xZGNBQn23ynOI98jeYWBnlfgdoa0aSuOWGQ18XQNxyEWLGYpIbjdIKlUzs8EW4MVlfsE1Gz7xN2lqmilGf0G0V+YRAOoBp1KrI7SXKB/NXhtsW7ERjmIhsw/Suc8/TbYMVTqTi+WE0=
Received: from DM6PR11MB2795.namprd11.prod.outlook.com (2603:10b6:5:bf::24) by
 DM6PR11MB4708.namprd11.prod.outlook.com (2603:10b6:5:28f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21; Mon, 22 Jun 2020 18:42:59 +0000
Received: from DM6PR11MB2795.namprd11.prod.outlook.com
 ([fe80::9caf:c724:631e:b29c]) by DM6PR11MB2795.namprd11.prod.outlook.com
 ([fe80::9caf:c724:631e:b29c%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 18:42:59 +0000
From:   Tiran Meltser <Tiran.Meltser@mavenir.com>
To:     Philip Oakley <philipoakley@iee.email>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Amir Yosef <Amir.Yosef@mavenir.com>,
        Tiran Meltser <Tiran.Meltser@mavenir.com>
Subject: RE: [E] Re: Request for adding a simple mechanism to exclude files
 from Git merge operation
Thread-Topic: [E] Re: Request for adding a simple mechanism to exclude files
 from Git merge operation
Thread-Index: AdZHL59dp1Qf6POUSX+2nZyYTIowNgAsw32AADhLzcA=
Date:   Mon, 22 Jun 2020 18:42:59 +0000
Message-ID: <DM6PR11MB2795F789FD7011DCF0D3D5C5E5970@DM6PR11MB2795.namprd11.prod.outlook.com>
References: <DM6PR11MB27958B80E3994CEEF13971ECE5990@DM6PR11MB2795.namprd11.prod.outlook.com>
 <e9534404-7c2c-bec0-465e-7c0149734e3a@iee.email>
In-Reply-To: <e9534404-7c2c-bec0-465e-7c0149734e3a@iee.email>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: iee.email; dkim=none (message not signed)
 header.d=none;iee.email; dmarc=none action=none header.from=mavenir.com;
x-originating-ip: [109.186.30.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d19df44-8fba-4054-8ef4-08d816dc1660
x-ms-traffictypediagnostic: DM6PR11MB4708:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4708C262D823EC690CF34581E5970@DM6PR11MB4708.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rd9S+wtMy2W8O/w+E9h1W34E+6OcSTPgpA6IubnIOwqZ/01BZUT/uvyIoI6Ly4sBJY/FjxuabJcd1EezY+QYtiXQlNqVczW2rxJzTXt2jIhYwpXYzaEpUThbwfJ3k1+A4mf+0z94/VIZDhrZRJZ/aYUnGISfYxhWmLhK5mcbYTCE2PTbxBGLGfp2fmTO5Uyzz1kWaWfMVzIEnYT5MjTiNfkOcyuOo/eNrRTunTkhSbS9cc2JtwP3esyyrdYRcoK3bY7Pko9eCliLgljcwQMHM+jEykhcv5akK/ymKSdAjz8E0oVZ3fqwYHdKxAqV8CuGMZeLtp1jwYVch1p1AXW70fljKlgouBlCBtakE7T2yL1Z0Ba+oUlvon9ofU/rbZ+rBqh8Lw2Xd+S9ANddD/1Czg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2795.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(366004)(39860400002)(346002)(136003)(9686003)(316002)(76116006)(45080400002)(66946007)(83380400001)(26005)(8676002)(478600001)(5660300002)(7696005)(86362001)(6506007)(53546011)(966005)(4326008)(8936002)(186003)(66476007)(66556008)(64756008)(66446008)(52536014)(55016002)(54906003)(71200400001)(33656002)(107886003)(110136005)(2906002)(66574015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 32in2tlyINx19V5L6U0jX5X8iz0wht2AODvFV7+tACX0eMDXDKOz7awFTr1J2F4BG1tNXAVeYrS76AqSkdIv63UC/8LgSfZT33kG1o9vrksJYmEOHlxK5P9f5iQTt9Q9/tErXttGhYRymQW2qramv9JuCdVkx73eIUyPdBpCDJ3H8M3dEKo7tlYsftwDitQ68SaahyQH3o+rVxkH6pFCGZK/DDtQ0pyqicGUivNjTPqEIKjRZz9zAouOkFptfjVP/foykhzFHdsTYAdU9axSXwQzSqtmQeynvDJqoD7lcohcCGI2PRGsYgnGhyZwVeBepXBo8nP3EDC+ceCvJ8f0fDP+BNTL5uYFi8tY5ltk0A82qccw65gljsLBMI8ZtcZQZOWt/YIC3FG5I9oODnBhxXTYBtCFc4iOAGbCUi+wQheisYDblbrnLvhCU4SdsTnM9Y/KAUV8j/IJktC+BlB9WogzOnBANq2h8tRJiBL0D1U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mavenir.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d19df44-8fba-4054-8ef4-08d816dc1660
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 18:42:59.5019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7fa7d4ff-bf19-464b-89a6-a132b269d68c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: URmgCgxepo2I/kRkkzpPBFejjw0embUr8iz7RoWOH8YkN7NjhI0BhhMmR+zeOoQjGlQtR++YeSdr40eZmHh/muhhF5/RaK7Wbo2nVVHRAXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4708
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgUGhpbGlwLA0KRmlyc3QgLSB0aGFua3MgZm9yIHRha2luZyB0aGUgdGltZSB0byBjb21tZW50
IG9uIHRoZSBpc3N1ZS4NClNlY29uZCAtIGFzIGZvciB0aGUgInByZWNpb3VzIiBmaWxlLCBub3Qg
c3VyZSB0aGlzIGlzIG15IGNhc2U7IGl0IGNvdWxkIGdvIHRoZXJlLCBidXQgYXMgeW91IGluZGlj
YXRlZCBpdCBoYXMgYmVlbiBhcm91bmQgZm9yIHNvbWUgdGltZSB3aXRob3V0IHByb2dyZXNzaW5n
IGFueXdoZXJlLg0KVGhpcmQgLSB0aGUgbGFzdCBsaW5rIHlvdSBzZW50IGRvZXNuJ3Qgc2VlbSB0
byBiZSByZWxhdGVkIHRvIG15IGlzc3VlIGFzIGl0IGRlYWxzIHdpdGggY29tcGxleCBtZXJnZXMs
IHdoaWxlIG15IHJlcXVlc3QgaXMgdmVyeSBzaW1wbGUgLSBnaXZlIHRoZSBhYmlsaXR5IHRvIG1h
cmsgZmlsZXMvZm9sZGVycyBhcyBvbWl0dGVkIGZyb20gYSBtZXJnZSBvcGVyYXRpb24gKGJyYW5j
aCBzcGVjaWZpYyBmaWxlcykuDQoNCklNSE8gdGhpcyBmZWF0dXJlIGlzbid0IGNvbXBsaWNhdGVk
IGFuZCBjYW4gYnJpbmcgbG90cyBvZiBiZW5lZml0cyB0byB0aGUgdGFibGUuDQoNCkhvcGUgc29t
ZW9uZSB3aWxsIHRha2UgdXAgdGhlIGdsb3ZlLi4uDQoNClRpcmFuLg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IFBoaWxpcCBPYWtsZXkgPHBoaWxpcG9ha2xleUBpZWUuZW1haWw+
DQpTZW50OiBTdW5kYXksIEp1bmUgMjEsIDIwMjAgNjo0MyBQTQ0KVG86IFRpcmFuIE1lbHRzZXIg
PFRpcmFuLk1lbHRzZXJAbWF2ZW5pci5jb20+OyBnaXRAdmdlci5rZXJuZWwub3JnDQpDYzogQW1p
ciBZb3NlZiA8QW1pci5Zb3NlZkBtYXZlbmlyLmNvbT4NClN1YmplY3Q6IFtFXSBSZTogUmVxdWVz
dCBmb3IgYWRkaW5nIGEgc2ltcGxlIG1lY2hhbmlzbSB0byBleGNsdWRlIGZpbGVzIGZyb20gR2l0
IG1lcmdlIG9wZXJhdGlvbg0KDQpbRVhURVJOQUwgRU1BSUxdIERPIE5PVCBDTElDSyBsaW5rcyBv
ciBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUuDQoNCk9uIDIwLzA2LzIwMjAgMTk6MjEsIFRpcmFuIE1lbHRzZXIg
d3JvdGU6DQo+IEhpLA0KPiBUaGlzIHRvcGljIGlzIHF1aXRlIGNvbW1vbiBpbiB2YXJpb3VzIHVz
ZSBjYXNlcyAoZS5nLiBwcm9kdWN0aW9uIGNvbmZpZ3VyYXRpb24gdnMuIHN0YWdpbmcgb25lKSBh
bmQgdGhlcmUgYXJlIHF1aXRlIGEgZmV3IHRhbGtzIGFib3V0IGl0IGluIHRoZSB3ZWIuDQo+IE5l
dmVydGhlbGVzcywgdGhlcmUgaXMgbm8gc3BlY2lmaWMgc29sdXRpb24gdG8gdGhpcyBwcm9ibGVt
LCBvbmx5IHBhcnRpYWwgd29ya2Fyb3VuZHMgKGluY2x1ZGluZyB0aGUgZmFtb3VzIG1lcmdlIGRy
aXZlciDigJxvdXJz4oCdKS4NCj4NCj4gSSB3b3VsZCBsaWtlIHRvIHN1Z2dlc3QgYWRkaW5nIHRo
ZSBnaXQgYSBzaW1wbGUgYW5kIHByZWNpc2UgaGFuZGxpbmcgZm9yIHRoZSBuZWVkIHRvIG1hcmsg
ZmlsZShzKS9mb2xkZXIocykgdGhhdCBhcmUgYnJhbmNoIHNwZWNpZmljIGFuZCBzaG91bGQgbm90
IGJlIGludm9sdmVkIGluIG1lcmdlIG9wZXJhdGlvbiBhdCBhbGwuDQo+DQo+IDIgc3VnZ2VzdGlv
bnMgSSBjYW4gdGhpbmsgb2YgYXJlIChidXQgYW55IGdvb2Qgc29sdXRpb24gd291bGQgc3VmZmlj
ZSk6DQo+IOKAoiBBZGRpbmcgYWRkaXRpb25hbCBtZXJnZSBzdHJhdGVneSBpbmRpY2F0aW9uIHRo
ZSBmaWxlL2ZvbGRlciBpcw0KPiBleGNsdWRlZCBmcm9tIG1lcmdlcyAoZS5nLiBtZXJnZT1kaXNh
YmxlZC9ub25lL3NraXAv4oCmKSDigKIgQWRkaW5nIGEgbmV3DQo+IGNvbmZpZ3VyYXRpb24gZmls
ZSAobGlrZSAuZ2l0aWdub3JlKSBmb3IgdHJhY2tpbmcgdGhlc2Ugc3BlY2lhbA0KPiBmaWxlcy9m
b2xkZXJzLCBmb3IgZXhhbXBsZToNCj4gLmdpdGlzb2xhdGUvLmdpdHF1YXJhbnRpbmUvLmdpdGJy
YW5jaHNwZWNpZmljLy5naXRzaWxvL+KApg0KPg0KPiBBbnkgY29tbWVudCB3b3VsZCBiZSBhcHBy
ZWNpYXRlZC4NCj4NCj4NClRoZXJlIGhhcyBiZWVuIGEgbG90IG9mIHByZXZpb3VzIGRpc2N1c3Np
b24gb24gInByZWNpb3VzIiBmaWxlcyBpbiB0aGUgcGFzdCwgYnV0IHdpdGhvdXQgYW55IHNvbGlk
IHNvbHV0aW9uLg0KKGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2dpdC8/cT1wcmVjaW91cytmaWxl
IHRvIHN0YXJ0KS4NCg0KDQpUaGVyZSBpcyBhIGN1cnJlbnQgdGhyZWFkIG9uIHByb2dyZXNzaXZl
IG1lcmdlIHJlc29sdXRpb24sIHdoZXJlIG5vdCBhbGwgY29uZmxpY3RzIGNhbiBiZSByZXNvbHZl
ZCBieSBvbmUgcGVyc29uIGF0IG9uZSB0aW1lLCB3aGljaCBtYXkgYWxzbyBiZSBvZiBpbnRlcmVz
dC4NCmh0dHBzOi8vcHVibGljLWluYm94Lm9yZy9naXQvQlk1UFIxOU1CMzQwMERDNkI2MDY1QzFG
RkYyRUQyODk4OTA5OTBAQlk1UFIxOU1CMzQwMC5uYW1wcmQxOS5wcm9kLm91dGxvb2suY29tL1Qv
I201NmIzNDU1NDYxMmI0NGJlMTdlNjFkYTY0ODZjMWY3MDljMmNmZTU0DQoNClBoaWxpcA0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NClRoaXMgZS1tYWlsIG1lc3NhZ2UgbWF5IGNv
bnRhaW4gY29uZmlkZW50aWFsIG9yIHByb3ByaWV0YXJ5IGluZm9ybWF0aW9uIG9mIE1hdmVuaXIg
U3lzdGVtcywgSW5jLiBvciBpdHMgYWZmaWxpYXRlcyBhbmQgaXMgaW50ZW5kZWQgc29sZWx5IGZv
ciB0aGUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykuIElmIHlvdSBhcmUgbm90IHRo
ZSBpbnRlbmRlZCByZWNpcGllbnQgb2YgdGhpcyBtZXNzYWdlLCB5b3UgYXJlIGhlcmVieSBub3Rp
ZmllZCB0aGF0IGFueSByZXZpZXcsIHVzZSBvciBkaXN0cmlidXRpb24gb2YgdGhpcyBpbmZvcm1h
dGlvbiBpcyBhYnNvbHV0ZWx5IHByb2hpYml0ZWQgYW5kIHdlIHJlcXVlc3QgdGhhdCB5b3UgZGVs
ZXRlIGFsbCBjb3BpZXMgaW4geW91ciBjb250cm9sIGFuZCBjb250YWN0IHVzIGJ5IGUtbWFpbGlu
ZyB0byBzZWN1cml0eUBtYXZlbmlyLmNvbS4gVGhpcyBtZXNzYWdlIGNvbnRhaW5zIHRoZSB2aWV3
cyBvZiBpdHMgYXV0aG9yIGFuZCBtYXkgbm90IG5lY2Vzc2FyaWx5IHJlZmxlY3QgdGhlIHZpZXdz
IG9mIE1hdmVuaXIgU3lzdGVtcywgSW5jLiBvciBpdHMgYWZmaWxpYXRlcywgd2hvIGVtcGxveSBz
eXN0ZW1zIHRvIG1vbml0b3IgZW1haWwgbWVzc2FnZXMsIGJ1dCBtYWtlIG5vIHJlcHJlc2VudGF0
aW9uIHRoYXQgc3VjaCBtZXNzYWdlcyBhcmUgYXV0aG9yaXplZCwgc2VjdXJlLCB1bmNvbXByb21p
c2VkLCBvciBmcmVlIGZyb20gY29tcHV0ZXIgdmlydXNlcywgbWFsd2FyZSwgb3Igb3RoZXIgZGVm
ZWN0cy4gVGhhbmsgWW91DQo=
