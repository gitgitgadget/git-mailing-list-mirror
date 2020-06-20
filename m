Return-Path: <SRS0=73cz=AB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_IMPORTANCE_HIGH,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56940C433DF
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 18:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A34AB2417C
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 18:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mavenir.com header.i=@mavenir.com header.b="MxDOPrYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgFTSVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:21:45 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:41409
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726838AbgFTSVo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jun 2020 14:21:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6gKHjcYdO1M7z1YQx28c6A2YD1DzKTLCEzU/9Y63mJBpB1gUS9mR9JEmnWKQBWNnyhpqsQ4lRkNrgpANE03ZVE+pXlD6d/9TuNf8plgmjxkNPGLDMFDR+SqQJ10TIZ9+gGStbQO+QjxJxXFpgtIHeVVhAmLigb/SNUQH1CdAsi/hnGn5ex04aIzXXKlYrIljpOwG/H+LcVMDPR9yEI10Q4RbT7Xz1KqwEZhfCxBdiCGguvK4Gy6TdO2iOl6S+SMD1gXRS3fYX+bRpKk+4MredIfZmeN8QPS1L28OFVoLOp70uqsnrpvCQtM7Qs1Cy95tkq9nm/jfmgYEc+0dNyN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3BO1lU9hZ/WE8UI/mlEEHXBXTVVJmXDULGr24XWUKQ=;
 b=HLiGcgdhEScW//hXe3I6d+AIkwHhIThiEZ8dxA9h+YVpotyH+QVeMtpf9/VwjtD15qlsI1egaPscQNJ3PyxBHm30nS7imzGIqeF/AHqj3dJMzrIakNtNz3hSkFK7bBRxsyIHPYVjeoY4ygM6R46kEg7lGsjMYQcSuE8KvLVh1tbgYKg3qx+moERUk1kX1dCMGYbwhU82tdnEqdHmh+vpBfuwjsSf2vbXMsu+63X9GsJOC9Yy70z6vhs7/D5zkiuM+6ikn0+yB2RJM2MiygMXoon7Uu/13fuslNx1PQi2kv8E1xu0hBXPFlvuumDgr1ELHIwu2exrZLs0LOXEQ9HDBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mavenir.com; dmarc=pass action=none header.from=mavenir.com;
 dkim=pass header.d=mavenir.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mavenir.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3BO1lU9hZ/WE8UI/mlEEHXBXTVVJmXDULGr24XWUKQ=;
 b=MxDOPrYvRTF8q4890W3XM7PKQm5ic9OYp88BkGndLwh/RgBDhQcOShSN8b79xpCevdFqQzcMxOcF5N2dWCxC0OCVLS5PhNQAT3nNaWM4afaXXAD68gmifOEyiWRiM7iafNgoFoxYxZBXpxMPx3nAw9+kXkjtCJzvktGhry9Wke0=
Received: from DM6PR11MB2795.namprd11.prod.outlook.com (2603:10b6:5:bf::24) by
 DM5PR11MB1372.namprd11.prod.outlook.com (2603:10b6:3:11::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.24; Sat, 20 Jun 2020 18:21:41 +0000
Received: from DM6PR11MB2795.namprd11.prod.outlook.com
 ([fe80::9caf:c724:631e:b29c]) by DM6PR11MB2795.namprd11.prod.outlook.com
 ([fe80::9caf:c724:631e:b29c%7]) with mapi id 15.20.3109.026; Sat, 20 Jun 2020
 18:21:41 +0000
From:   Tiran Meltser <Tiran.Meltser@mavenir.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Amir Yosef <Amir.Yosef@mavenir.com>
Subject: Request for adding a simple mechanism to exclude files from Git merge
 operation
Thread-Topic: Request for adding a simple mechanism to exclude files from Git
 merge operation
Thread-Index: AdZHL59dp1Qf6POUSX+2nZyYTIowNg==
Importance: high
X-Priority: 1
Date:   Sat, 20 Jun 2020 18:21:40 +0000
Message-ID: <DM6PR11MB27958B80E3994CEEF13971ECE5990@DM6PR11MB2795.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mavenir.com;
x-originating-ip: [62.168.56.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6447e6a-f6b1-4042-270e-08d81546c795
x-ms-traffictypediagnostic: DM5PR11MB1372:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB13727F13AFDB703BF65ECD60E5990@DM5PR11MB1372.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0440AC9990
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IkZKkBkS16K1RNGnMzhBhzN3+gcLFp/4sXBAoFEbQ6/AZPFIWdvwG7cXV7tCtznyDT9aF0foVTXLHyqUXzPwzO816Amw7OiK7G+5weLrRD+hWoaeaUH7ZXfYFQusR2hJQXML1rFhMXR9tuBc6Td8WIcacX418b4qgNq96Nzh/UHWylxeApZVgghpy4cy84sbXWOJy3uKstmLgugB90zZPva/35o7sHJIDAmI2wPemJjoL5PcSWeKfVu8icqpw1dZpmP6R5ssvszx3z3slpXhRHURVXt0Ed7uG0k21JoDSkHQlAsWbsjQ56wpVhCqcNFKqUT7viNpKWzoY8ckwkeZkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2795.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(346002)(376002)(396003)(39850400004)(66574015)(83380400001)(55016002)(9686003)(66476007)(107886003)(2906002)(66446008)(64756008)(66556008)(8676002)(478600001)(66946007)(76116006)(33656002)(86362001)(8936002)(52536014)(5660300002)(71200400001)(6916009)(316002)(186003)(7696005)(6506007)(26005)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: HmjkTs9GxlopuCKU4tvQ3lJmePjHU4gE7bMWzcinDEEqbg/fdCuc0VOs54r3ejdKaDIZPlVgrNMW1RLS3C0NWg2TtEGu7/lapwx3nLUz5l00HuydwHArifenNd1MmaOzfBe12D4uyihHDwbxls/C1bMSZkqJKTCJkBxPsvNfH0SALLlcTvbD59bhbIwmrsAU+b3bxgedl3+bm72mLnZMv2imrOA6sGuqOwbFmNqePFRpnR88EhxtYXsZVevciLEZH4UOw1mpJFD4nKjbdeLvY1RwKf2RS4ft5l5RpY/Pb+l3uwJOT4rKfinvx1hG5naGkuMch+rscqrXfgl5pgpofGJKiNdAapv2XyPICOJvCzI4lRmFGVZayhxJgMTdX6Iz6eXfTX4aeYzqhN3dRWrGDWxnAVhtXKkAaQELmiIRoHcKdT9X+6Vg+yBTi6js13x18DOsdU/0rnCKcuaYBbVQ12xMXp3wXP+9nMDpan7YCQw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mavenir.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6447e6a-f6b1-4042-270e-08d81546c795
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2020 18:21:41.2650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7fa7d4ff-bf19-464b-89a6-a132b269d68c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Pj+o4mG5hvNOgs4r59AVLOM+enzkqk+Qln7k438RAujaIz5TJ+PtMH9vh84F1yYgF+Z6XbVgpkTRxsiZntPVHpaS8a1M3k2Y1m3NciBjYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1372
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksDQpUaGlzIHRvcGljIGlzIHF1aXRlIGNvbW1vbiBpbiB2YXJpb3VzIHVzZSBjYXNlcyAoZS5n
LiBwcm9kdWN0aW9uIGNvbmZpZ3VyYXRpb24gdnMuIHN0YWdpbmcgb25lKSBhbmQgdGhlcmUgYXJl
IHF1aXRlIGEgZmV3IHRhbGtzIGFib3V0IGl0IGluIHRoZSB3ZWIuDQpOZXZlcnRoZWxlc3MsIHRo
ZXJlIGlzIG5vIHNwZWNpZmljIHNvbHV0aW9uIHRvIHRoaXMgcHJvYmxlbSwgb25seSBwYXJ0aWFs
IHdvcmthcm91bmRzIChpbmNsdWRpbmcgdGhlIGZhbW91cyBtZXJnZSBkcml2ZXIg4oCcb3Vyc+KA
nSkuDQoNCkkgd291bGQgbGlrZSB0byBzdWdnZXN0IGFkZGluZyB0aGUgZ2l0IGEgc2ltcGxlIGFu
ZCBwcmVjaXNlIGhhbmRsaW5nIGZvciB0aGUgbmVlZCB0byBtYXJrIGZpbGUocykvZm9sZGVyKHMp
IHRoYXQgYXJlIGJyYW5jaCBzcGVjaWZpYyBhbmQgc2hvdWxkIG5vdCBiZSBpbnZvbHZlZCBpbiBt
ZXJnZSBvcGVyYXRpb24gYXQgYWxsLg0KDQoyIHN1Z2dlc3Rpb25zIEkgY2FuIHRoaW5rIG9mIGFy
ZSAoYnV0IGFueSBnb29kIHNvbHV0aW9uIHdvdWxkIHN1ZmZpY2UpOg0K4oCiIEFkZGluZyBhZGRp
dGlvbmFsIG1lcmdlIHN0cmF0ZWd5IGluZGljYXRpb24gdGhlIGZpbGUvZm9sZGVyIGlzIGV4Y2x1
ZGVkIGZyb20gbWVyZ2VzIChlLmcuIG1lcmdlPWRpc2FibGVkL25vbmUvc2tpcC/igKYpDQrigKIg
QWRkaW5nIGEgbmV3IGNvbmZpZ3VyYXRpb24gZmlsZSAobGlrZSAuZ2l0aWdub3JlKSBmb3IgdHJh
Y2tpbmcgdGhlc2Ugc3BlY2lhbCBmaWxlcy9mb2xkZXJzLCBmb3IgZXhhbXBsZTogLmdpdGlzb2xh
dGUvLmdpdHF1YXJhbnRpbmUvLmdpdGJyYW5jaHNwZWNpZmljLy5naXRzaWxvL+KApg0KDQpBbnkg
Y29tbWVudCB3b3VsZCBiZSBhcHByZWNpYXRlZC4NCg0KMTB4LA0KVGlyYW4gTWVsdHNlcg0KX19f
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
