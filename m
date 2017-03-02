Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2E762023D
	for <e@80x24.org>; Thu,  2 Mar 2017 03:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753579AbdCBDJr (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 22:09:47 -0500
Received: from mail-bl2nam02on0110.outbound.protection.outlook.com ([104.47.38.110]:62080
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753152AbdCBDJp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 22:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=O96+M/Ta7WBQgrjlMih2STxNqHDk+E+UL0JaEHMOvOo=;
 b=BHCS8MWpBGQmoCnGAtFvHSvKlwSZe2LSOZHx9EVpJlDhGdFqljt83qkDLiMHK0HMbx+wDSt//4Eku4KwYQCdX7cyoq+GjkA5xKuFcU5Gas4aeCqVvsUxmBCW1beu99eRpunKuEq5MBTbr883VQvqHZaV4X+n3cm2Rmuo+PD7BgY=
Received: from CY1PR0301MB2107.namprd03.prod.outlook.com (10.164.2.153) by
 CY1PR0301MB2107.namprd03.prod.outlook.com (10.164.2.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.933.12; Thu, 2 Mar 2017 01:31:17 +0000
Received: from CY1PR0301MB2107.namprd03.prod.outlook.com ([10.164.2.153]) by
 CY1PR0301MB2107.namprd03.prod.outlook.com ([10.164.2.153]) with mapi id
 15.01.0933.020; Thu, 2 Mar 2017 01:31:17 +0000
From:   Dan Shumow <danshu@microsoft.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff King <peff@peff.net>
CC:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc.stevens@cwi.nl>
Subject: RE: [PATCH] Put sha1dc on a diet
Thread-Topic: [PATCH] Put sha1dc on a diet
Thread-Index: AQHSkiMIUGTsYtffFU+WRTsYHJQFFqGAUwj9gAAB7oCAABGiAIAABgQAgAAFjoCAADN5AIAAEf1g
Date:   Thu, 2 Mar 2017 01:31:17 +0000
Message-ID: <CY1PR0301MB21073D82F4A6AB0DAD8BF1FCC4280@CY1PR0301MB2107.namprd03.prod.outlook.com>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan>
 <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
 <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
 <20170301195302.3pybakmjqztosohj@sigill.intra.peff.net>
 <CA+55aFwf3sxKW+dGTMjNAeHMOf=rvctEQohm+rbhEb=e3KLpHw@mail.gmail.com>
 <20170301203427.e5xa5ej3czli7c3o@sigill.intra.peff.net>
 <CA+55aFz4ixVKVURki8FeXjL5H51A_cQXsZpzKJ-N9n574Yy1rg@mail.gmail.com>
In-Reply-To: <CA+55aFz4ixVKVURki8FeXjL5H51A_cQXsZpzKJ-N9n574Yy1rg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2001:4898:80e8:e::7c1]
x-ms-office365-filtering-correlation-id: 0cc20cc6-412b-41d6-d78b-08d4610bd297
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081);SRVR:CY1PR0301MB2107;
x-microsoft-exchange-diagnostics: 1;CY1PR0301MB2107;7:God9s1a38Q/5R5YGjfrn9TOo+sRje16ddgb/wkGtxxghz+K17qijXaXNYm258W9pb/Zvf6u5b6c/RZOVp+8rCCxLzWLsMX5kAzyP2NTVGnQbFAhkvg94yvALBHPKhnofTtr2xZT46+8xtT+bC9xUykLtwSrLUnS4cffOfl3EUK4W8zCXOHtKjQ97FZw/9Wd7ELFNjcuUVArAkqtxWqexIxxutKu/9hhRUz/q6NA4KLCxF7jbe9Xb6nBCwxygFZBv8WEe2r/dJHwB3IZ2tsEE1jYRtWnQMwrWI6oB1ncqc8UJzVhpisdWHfQnssZFZtEjptbDRVe1xFVKeRLw4Ab7nzKvpftSwa3clXEHnZQkCeA=
x-microsoft-antispam-prvs: <CY1PR0301MB2107B797F614DF04D30D4366C4280@CY1PR0301MB2107.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(20161123564025)(20161123560025)(20161123558025)(20161123555025)(6072148)(6042181);SRVR:CY1PR0301MB2107;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB2107;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(7916002)(33656002)(6246003)(102836003)(53936002)(6116002)(38730400002)(4326008)(25786008)(2950100002)(50986999)(54356999)(76176999)(93886004)(74316002)(305945005)(7736002)(9686003)(8656002)(55016002)(54906002)(99286003)(5660300001)(7696004)(77096006)(6436002)(122556002)(106116001)(6506006)(2900100001)(229853002)(10290500002)(5005710100001)(3660700001)(189998001)(2906002)(3280700002)(86362001)(92566002)(10090500001)(8936002)(8676002)(81166006)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0301MB2107;H:CY1PR0301MB2107.namprd03.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2017 01:31:17.0533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB2107
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSBwbGF5ZWQgYXJvdW5kIHR3ZWFraW5nIHRoZSBjb2RlIGEgYml0IG1vcmUgYW5kIEkgZ290IG91
ciBwZXJmb3JtYW5jZSBkb3duIHRvIGEgMi4wNzcxODJ4IHNsb3dkb3duIHdpdGggY2hlY2sgYW5k
IGEgMS4wNTU5NjF4IHNsb3dkb3duIHdpdGhvdXQgY2hlY2tpbmcuICBIb3dldmVyLCB0aGF0IHNs
b3dkb3duIGlzIGJhc2ljYWxseSB3aXRoIHRoZSBjaGVjayB0dXJuZWQgb2ZmIHRocm91Z2ggb3Vy
IEFQSS4gIElmIEkgcmlwIGV4dHJhbmVvdXMgY29kZSBmb3Igc3RvcmluZyBzdGF0ZXMgYW5kIGNo
ZWNraW5nIGlmIHdlIGFyZSBkb2luZyBjb2xsaXNpb24gZGV0ZWN0aW9uIG91dCwgSSBjYW4gcmVh
Y2ggcGVyZm9ybWFuY2UgcGFyaXR5IHdpdGggdGhlIGJsb2NrLXNoYTEgaW1wbGVtZW50YXRpb24g
aW4gdGhlIEdpdCBjb2RlYmFzZSwgd2hpY2ggYmFzaWNhbGx5IHRlbGxzIG1lIHRoYXQgaXMgYWJv
dXQgYXMgZ29vZCBhcyBJIGNhbiBkbyBmb3Igb3B0aW1pemluZyB0aGUgQyBjb2RlLg0KDQpTSEEx
IGlzIG1vcmUgYW1lbmFibGUgdG8gYXNzZW1ibGVyIGltcGxlbWVudGF0aW9uIGJlY2F1c2UgaXRz
IHVzZSBvZiByb3RhdGlvbnMsIHdoaWNoIGFyZSBub3RvcmlvdXNseSBkaWZmaWN1bHQgdG8gYWNj
ZXNzIHRocm91Z2ggQyBjb2RlLiAgQW5kIGFzIHRoaXMgaGFwcGVucyBpbiB0aGUgaW5uZXIgbG9v
cCBvZiB0aGUgZnVuY3Rpb24sIHRoZSBpbmxpbmUgYXNtIHRlbmRzIHRvIG5vdCBjdXQgaXQuICBU
aGlzIGlzIG9uZSBvZiB0aGUgcmVhc29ucyB0aGF0IHRoZSBPcGVuU1NMIFNIQS0xIHJ1bnMgbGlr
ZSBhIHNjYWxkZWQgbW9ua2V5LCBjb21wYXJlZCB0byB0aGUgQyBpbXBsZW1lbmF0aW9ucy4gIE1h
cmMgYW5kIEkgaGF2ZSBhbHNvIGRpc2N1c3NlZCB1c2luZyBTSU1EIG9wZXJhdGlvbnMgdG8gc3Bl
ZWQgdXAgdGhlIFVCQyBjaGVja3MsIHdoaWNoIGNvdWxkIGRlZmluaXRlbHkgaGVscCBhY2hpZXZl
IGJldHRlciBwZXJmb3JtYW5jZSwgYnV0IGlzIGhpZ2hseSBkZXBlbmRlbnQgb24gcHJvY2Vzc29y
IHN1cHBvcnQuICBJdCB3aWxsIHRha2Ugc29tZSB0aW1lIHRvIGRvIGVpdGhlciBhIFNJTUQgaW1w
bGVtZW50YXRpb24gb2YgdGhlIFVCQyBjaGVja3Mgb3IgYW4gYXNzZW1ibGVyIGltcGxlbWVudGF0
aW9uLg0KDQpBdCB0aGlzIHBvaW50LCBJIHdvdWxkIHN1Z2dlc3QgdGhhdCBJIHRha2UgdGhlIEMg
b3B0aW1pemF0aW9ucywgY2xlYW4gdGhlbSB1cCBhbmQgZm9sZCB0aGVtIGluIHdpdGggdGhlIGRp
ZXQgY2hhbmdlcyBMaW51cyBoYXMgc3VnZ2VzdGVkLiAgVGhlIHNsb3dkb3duIGlzIHN0aWxsIDJ4
IG92ZXIgYmxvY2stc2hhMSBhbmQgbW9yZSBvdmVyIE9wZW5TU0wuICBCdXQgaXQgaXMgYmV0dGVy
IHRoYW4gbm90aGluZy4gIEFuZCB0aGVuIGlmIHRoZXJlIGlzIGludGVyZXN0IE1hcmMgYW5kIEkg
Y2FuIGludmVzdGlnYXRlIG90aGVyIHByb2Nlc3NvciBzcGVjaWZpYyBvcHRpbWl6YXRpb25zIGxp
a2UgQVNNIG9yIFNJTUQgYW5kIGNpcmNsZSBiYWNrIHdpdGggdGhvc2UgcGVyZm9ybWFuY2Ugb3B0
aW1pemF0aW9ucyBhdCBhIGxhdGVyIGRhdGUuDQoNCkFsc28sIHRvIEpvaGFubmVzIFNjaGluZGVs
aW4ncyBwb2ludDoNCj4gTXkgY29uY2VybiBpcyBhYm91dCB0aGF0IHVuZXhwZWN0ZWQgdHVybiAi
b2gsIGxldCdzIGp1c3Qgc3dpdGNoIHRvIEM5OSBiZWNhdXNlLCB3ZWxsLCBiZWNhdXNlIG15IGNv
bXBpbGVyIGNhbmVoYW5kbGUgaXQsIGFuZCBldmVyeWJvZHkgZWxzZSBzaG91bGQganVzdCBzd2l0
Y2ggdG4gYSBtb2Rlcm4gY29tcGlsZXIiLiBUaGF0IHJlYWxseSBzb3VuZGVkIGNhcmVsZXNzLg0K
DQpXaGlsZSBpdCB3aWxsIHByb2JhYmx5IGJlIGEgcGFpbiwgaWYgaXQgaXMgYSByZXF1aXJlbWVu
dCwgd2UgY2FuIG1vZGlmeSB0aGUgY29kZSB0byBtb3ZlIGF3YXkgZnJvbSBhbnkgYzk5IHNwZWNp
ZmljIHN0dWZmIHdlIGhhdmUgaW4gaGVyZSwgaWYgaXQgbWFrZXMgYWRvcHRpbmcgdGhlIGNvZGUg
bW9yZSBwYWxhdGFibGUgZm9yIEdpdC4NCg0KVGhhbmtzLA0KRGFuDQoNCg0K
