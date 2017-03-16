Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D93420953
	for <e@80x24.org>; Thu, 16 Mar 2017 22:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752756AbdCPWHs (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:07:48 -0400
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:39487
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752122AbdCPWHq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=iBws3+lF9SzUsOZl/pzTWVVsKIg92H1Y1xyvzmyAszs=;
 b=a0KWINELKKPrsGCdXx/Xg+ydVT40cMX4PFpn3vs5R5iUWJy/w/IxtbeBIwigAw0j6PLAjlZjw0Yb630JWkS1NmfZG1wkwlec+7KvCAxO0YOTZQCmWCTsvgXsXpKuq/SoOdK72POAcO+SmSTwRhA0Yr46X3yefws2+CZQD5NQfUk=
Received: from CY1PR0301MB2107.namprd03.prod.outlook.com (10.164.2.153) by
 CY1PR0301MB2105.namprd03.prod.outlook.com (10.164.2.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.961.17; Thu, 16 Mar 2017 22:07:43 +0000
Received: from CY1PR0301MB2107.namprd03.prod.outlook.com ([10.164.2.153]) by
 CY1PR0301MB2107.namprd03.prod.outlook.com ([10.164.2.153]) with mapi id
 15.01.0961.022; Thu, 16 Mar 2017 22:07:43 +0000
From:   Dan Shumow <danshu@microsoft.com>
To:     Jeff King <peff@peff.net>, Marc Stevens <Marc.Stevens@cwi.nl>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: RE: [PATCH] Put sha1dc on a diet
Thread-Topic: [PATCH] Put sha1dc on a diet
Thread-Index: AQHSkiMIUGTsYtffFU+WRTsYHJQFFqGAUwj9gAAB7oCAABGiAIAABgQAgAAFjoCAADN5AIAAEf1ggABBsMWAAujfkIAPEkAAgAA0EQGAABacoIAAAkiAgAAGowCAAAIWAIAAB8kAgAADfYCAAAQxgIAEhp4AgAA+nQCAAAA8YA==
Date:   Thu, 16 Mar 2017 22:07:43 +0000
Message-ID: <CY1PR0301MB2107A6C40342CC8F25D0F661C4260@CY1PR0301MB2107.namprd03.prod.outlook.com>
References: <20170301195302.3pybakmjqztosohj@sigill.intra.peff.net>
 <CY1PR0301MB2107876B6E47FBCF03AB1EA1C4250@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <20170313194848.2z2dlgpomu6e3dkh@sigill.intra.peff.net>
 <1e6a592f-7da1-8043-0b29-0bb7c8cda3f3@cwi.nl>
 <CA+55aFyNi2uHwd9nzjy3dOu2L1A0jPN6AD43WKj-05km1GNtRQ@mail.gmail.com>
 <161775901.3349663.1489438074825.JavaMail.zimbra@cwi.nl>
 <20170313210023.bumtp6wyw6blmymp@sigill.intra.peff.net>
 <1392458356.3351662.1489439723458.JavaMail.zimbra@cwi.nl>
 <2006239187.136016.1489688534478.JavaMail.zimbra@cwi.nl>
 <20170316220620.ihq4ulg4t6m7ktrh@sigill.intra.peff.net>
In-Reply-To: <20170316220620.ihq4ulg4t6m7ktrh@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: peff.net; dkim=none (message not signed)
 header.d=none;peff.net; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2001:4898:80e8::7ac]
x-microsoft-exchange-diagnostics: 1;CY1PR0301MB2105;7:5wD6sNknQPmuourlS1oZOTMgV7hHAm32f2Yzj32doPOrjdu6985p1s+nPoeQDpIkGqNH2Mb12jC7K+PH6V3wB8gmTNyQAlijNOdjwGJO+mvtyM2YWNqsGvscD60eS/EhoqNKY5eZXp63ceNE/2bmxejGSOzCyb951qjO5RNH7Y+CaLOm3UBGXzCDfcZnqfMdiVDS1xsNGHKfjJHm7UjO9hVy3vRB3HrOjcdO/GrAh+TJ0FT/OXp+AwTUH1nH/yO9N4sDNtUZetaqDOND7GQBXs67TnHZa9JnuTgdynHSPIww3kz/nL7Nk4EoXcujIpLuXu76wGkd4liFm9fJm9FLvbJ8wVwgJ/bi99DDEVAjLyA=
x-ms-office365-filtering-correlation-id: 66d2348b-5ffe-45cd-3127-08d46cb8ded7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081);SRVR:CY1PR0301MB2105;
x-microsoft-antispam-prvs: <CY1PR0301MB21058763016811DC5BAE70A2C4260@CY1PR0301MB2105.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040375)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123564025)(20161123558025)(20161123562025)(20161123555025)(6072148);SRVR:CY1PR0301MB2105;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB2105;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39450400003)(39860400002)(39840400002)(24454002)(13464003)(377454003)(122556002)(38730400002)(3660700001)(2900100001)(305945005)(54356999)(10090500001)(102836003)(6246003)(50986999)(7736002)(76176999)(6116002)(3280700002)(189998001)(10290500002)(5005710100001)(4326008)(33656002)(2906002)(8656002)(7696004)(9686003)(54906002)(6506006)(229853002)(6436002)(55016002)(81166006)(99286003)(74316002)(86362001)(8676002)(25786008)(8936002)(77096006)(5660300001)(53936002)(93886004)(53546008)(2950100002)(32563001)(473944003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0301MB2105;H:CY1PR0301MB2107.namprd03.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2017 22:07:43.2790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB2105
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

R3JlYXQhIEtlZXAgdXMgcG9zdGVkIGlmIHRoZXJlIGlzIGFueXRoaW5nIGVsc2UgdGhhdCB5b3Ug
d291bGQgbGlrZSBmcm9tIHRoZSBjb2RlLiAgT3IgYW55d2F5IHdlIGNhbiBtYWtlIHRoZSBwcm9j
ZXNzIGdvIG1vcmUgc21vb3RobHkuDQoNClRoYW5rcywNCkRhbg0KDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBKZWZmIEtpbmcgW21haWx0bzpwZWZmQHBlZmYubmV0XSANClNl
bnQ6IFRodXJzZGF5LCBNYXJjaCAxNiwgMjAxNyAzOjA2IFBNDQpUbzogTWFyYyBTdGV2ZW5zIDxN
YXJjLlN0ZXZlbnNAY3dpLm5sPg0KQ2M6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1m
b3VuZGF0aW9uLm9yZz47IERhbiBTaHVtb3cgPGRhbnNodUBtaWNyb3NvZnQuY29tPjsgSnVuaW8g
QyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPjsgR2l0IE1haWxpbmcgTGlzdCA8Z2l0QHZnZXIu
a2VybmVsLm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIFB1dCBzaGExZGMgb24gYSBkaWV0DQoN
Ck9uIFRodSwgTWFyIDE2LCAyMDE3IGF0IDA3OjIyOjE0UE0gKzAxMDAsIE1hcmMgU3RldmVucyB3
cm90ZToNCg0KPiBUb2RheSBJIG1lcmdlZCB0aGUgcGVyZi1icmFuY2ggaW50byBtYXN0ZXIgYWZ0
ZXIgY29kZSByZXZpZXcgYW5kIGNvcnJlY3RuZXNzIHRlc3RpbmcuDQo+IFNvIG1hc3RlciBpcyBu
b3cgbW9yZSBwZXJmb3JtYW50IGFuZCBzYWZlIHRvIHVzZS4NCg0KR3JlYXQsIHRoYW5rIHlvdSAo
YW5kIERhbikgc28gbXVjaCBmb3IgYWxsIHlvdXIgd29yay4gV2UncmUgbG9va2luZyBhdCBpbnRl
Z3JhdGluZyB0aGlzIHZlcnNpb24gaW4gYSBuZWFyYnkgdGhyZWFkLg0KDQotUGVmZg0K
