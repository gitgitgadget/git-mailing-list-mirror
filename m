Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92654C4332B
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB2264DDD
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240271AbhBDUfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 15:35:50 -0500
Received: from mail-bn8nam12on2079.outbound.protection.outlook.com ([40.107.237.79]:21952
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240083AbhBDUfj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 15:35:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzEiAm1RZDsQNsGDsdUhXEDP8SIuB5kxP+igk4jGgVV7h2orPDuK4v4cKT0ez9+ezuFTLbhChm6IidHs//Oqf9WhUqeK6VMgAQopvqaWjV1Ko/7kxIg+lRJAREUBblcJLvDEIPf3kpTpENo/t0ZrjC/ZR3ni9uwSFbKUCpfI3Vrp6tlx9OLU9JaeyTalnLi971mo+bIuMlmZ5M7JdcxZftnv8ttK3TB2Y/I7n4elNc9/D1GI8aYh22ru/7LyEY9YoNDGjL2rRZ7KFUR5yX1GKboR7OaeO+Z1vuO4r/jjC3TwqV4w8Ts6lFQDeGFcYB0CjZf9AAat4640OXXxhl8uRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64KV5YfXVp3yrxTc7gk3xH4OxW91JYUg8UnEwxINt90=;
 b=RjhPW4jTlP5H9gbeniq6uQZGSDHU7Dks8m3sddsZ7yFf9vOqgumHmvq+yZanDFODRlIcHBWeoPuOI27Tx+KBZifW+DZQNnEEt78lLZsRN/6My1ebZCsu5viwvnUQbRRxPNURTL+gcOoepOZeaPekuLSmvvGQLLD177rLn5VhpZiDIMHzm6KkbFViT1mV0GhmBG3sMKpkf40bkw6Q2vpmk1mn5LYMclQ65U20yvNjH8ob5EdqRnZ3dsrBTdlVkV8rVMge6AKsVMqGvxKQ25tQGXBtHNQnB+aHP6vVKIgiQ7Kq5ntqcTP2DwzdR41LZh+3dd1jqs/ClzU3J+luBEryqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.201.127.2) smtp.rcpttodomain=peff.net smtp.mailfrom=astronics.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=astronics.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=astronics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64KV5YfXVp3yrxTc7gk3xH4OxW91JYUg8UnEwxINt90=;
 b=IzhioD0ECI+3rJLFRPR7sRzmNphD3wCFglzW0zNlJEsnivyfV1QHLZOYYg/wFJ6TeB0P/RtMHC1skxypP3ubNXSQ3VKrVDAlIXjQX8GG5/PvwBdEx+CEUhrmdAVug8wGfgHP+saaV6s2W7e1wgEiAvswEJoHS6BQ3XkkbFWhQxs=
Received: from MWHPR21CA0045.namprd21.prod.outlook.com (2603:10b6:300:129::31)
 by DM5PR11MB1274.namprd11.prod.outlook.com (2603:10b6:3:12::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17; Thu, 4 Feb 2021 20:34:22 +0000
Received: from CO1NAM04FT047.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::d6) by MWHPR21CA0045.outlook.office365.com
 (2603:10b6:300:129::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.2 via Frontend
 Transport; Thu, 4 Feb 2021 20:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.201.127.2)
 smtp.mailfrom=astronics.com; peff.net; dkim=none (message not signed)
 header.d=none;peff.net; dmarc=pass action=none header.from=astronics.com;
Received-SPF: Pass (protection.outlook.com: domain of astronics.com designates
 50.201.127.2 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.201.127.2; helo=KIRAST-MXS-02.astronics.com;
Received: from KIRAST-MXS-02.astronics.com (50.201.127.2) by
 CO1NAM04FT047.mail.protection.outlook.com (10.152.90.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Thu, 4 Feb 2021 20:34:21 +0000
Received: from KIRAST-MXS-06.astronics.com (172.27.4.113) by
 KIRAST-MXS-02.astronics.com (172.27.4.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Feb 2021 12:34:20 -0800
Received: from KIRAST-MXS-06.astronics.com (172.27.4.113) by
 KIRAST-MXS-06.astronics.com (172.27.4.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 4 Feb 2021 12:34:18 -0800
Received: from KIRAST-MXS-06.astronics.com ([fe80::cc97:5e0b:df06:aba1]) by
 KIRAST-MXS-06.astronics.com ([fe80::cc97:5e0b:df06:aba1%3]) with mapi id
 15.01.2106.004; Thu, 4 Feb 2021 12:34:18 -0800
From:   "Bulgrien, Dennis" <Dennis.Bulgrien@astronics.com>
To:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: howto-index not found
Thread-Topic: howto-index not found
Thread-Index: Adb7KfhnHM5OLSTJSy+UoMjpWihHWQASTVAAAAEAJ4AAEI7jcA==
Date:   Thu, 4 Feb 2021 20:34:18 +0000
Message-ID: <bda4965e57c74f2a8f855ab7d92e71ca@astronics.com>
References: <68e6a4e1991d4066a39b84ab5924202a@astronics.com>
 <CAPig+cT3qrYB09Z5J5afJUOUU6HvCm6jgjsMNQ_8nqHQUK70Og@mail.gmail.com>
 <YBxYowmCO50QmhVp@coredump.intra.peff.net>
In-Reply-To: <YBxYowmCO50QmhVp@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.27.249.79]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b970c2c-7e43-417e-96e7-08d8c94c4100
X-MS-TrafficTypeDiagnostic: DM5PR11MB1274:
X-Microsoft-Antispam-PRVS: <DM5PR11MB12744A7CC6B4015368197EBEE0B39@DM5PR11MB1274.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftlHB8vNqEo9jsLSv6Isu6tGljP7/Q1WYZ1LL3WxfmLhWMZog17H/ZmAyoxuL3uDpFrPAUweYBh8xUlXnvEfw65BENGZ1U9Y2V/GYkmUx7Vt7+IsSlBZj6LJrbpo863fSyi1zRBudSH/FXZHwYwGfe6VZbX8zDPiKh7LqCmR+csru2S4OKyiHs3/jt6l9PuhhYnf49uyn+N7IUqzQTBqzp3jHpmOVDfpLzOR5zhXbxsOrUKSWEo1jsK+a/hg9KB4Qh8UX39bTS8uoj0uAHUErkdCT33jrO2lQOA2ZKqU6EfVAkv5o/tlALbNkinvpCBZqmtO1CV23XNMimY2wrrnjx62sIAUTyX0/WBPUABXxLUEdnm+yhl0oo/fLy3jmtEpgyl+LOf5ULWHWpXBjHZ+USg5/mTJNAsLPBWboi9X4g1rd9Tj9u0uJrTAr9M52UAyXB7KoLiM3ZCrMHP5tELbH5NviIJKrTpRaajUTmDT0Xy/sRlSafr2LXgT7GzMG79e1XXdzpqTUtxZwVjr84BSzfBwXS7A6qMNVKpQSJd3G5Lf1O41Ksp+8IbNpMOeulCz1LZYEU+94n4hXYKUcR+wCKsQWgatOzAoiR7VhDzA5q8SAjHhVQydZPGxn8QDyhZp/DLsceX1kWpVN8MpzCl74P2Rw43Fu037yPbg29ygf+x1/YvkCY28JPLEtMqNl2T6tkxXgSgejap9aBKNFuXj4yj5p8ep1BUypW4Ki+E0p8I=
X-Forefront-Antispam-Report: CIP:50.201.127.2;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KIRAST-MXS-02.astronics.com;PTR:mx2.astronics.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36756003)(3480700007)(336012)(2906002)(2616005)(110136005)(47076005)(4326008)(82310400003)(498600001)(83380400001)(8936002)(108616005)(24736004)(8676002)(426003)(36860700001)(70206006)(70586007)(66574015)(53546011)(166002)(7696005)(966005)(45080400002)(26005)(186003)(5660300002)(86362001)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: astronics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 20:34:21.7930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b970c2c-7e43-417e-96e7-08d8c94c4100
X-MS-Exchange-CrossTenant-Id: a2ce8a60-0840-49b7-9389-97ad811e2924
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a2ce8a60-0840-49b7-9389-97ad811e2924;Ip=[50.201.127.2];Helo=[KIRAST-MXS-02.astronics.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM04FT047.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1274
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhlIGdpdGh1YiB0cmFja2VyIHJlZGlyZWN0cyBiYWNrIHRvIHRoaXMgZ3JvdXAsIHNheWluZyAi
VGhlc2UgcGFnZXMgYXJlIGdlbmVyYXRlZCBmcm9tIGdpdCBtYW4gcGFnZXMsIHNvIHdlIGhhdmUg
bm8gY29udHJvbCBvdmVyIGl0LiBIYXZlIHlvdSByZXBvcnRlZCBpdCB0byB0aGUgY29tbXVuaXR5
IGF0IGh0dHBzOi8vZ2l0LXNjbS5jb20vY29tbXVuaXR5ID8iDQoNClsxXTogaHR0cHM6Ly9naXRo
dWIuY29tL2dpdC9naXQtc2NtLmNvbS9pc3N1ZXMvMTUyMQ0KDQpEZW5uaXMNCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEplZmYgS2luZyA8cGVmZkBwZWZmLm5ldD4NClNlbnQ6
IFRodXJzZGF5LCBGZWJydWFyeSA0LCAyMDIxIDI6MjcgUE0NClRvOiBFcmljIFN1bnNoaW5lIDxz
dW5zaGluZUBzdW5zaGluZWNvLmNvbT4NCkNjOiBCdWxncmllbiwgRGVubmlzIDxEZW5uaXMuQnVs
Z3JpZW5AYXN0cm9uaWNzLmNvbT47IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBo
b3d0by1pbmRleCBub3QgZm91bmQNCg0KT24gVGh1LCBGZWIgMDQsIDIwMjEgYXQgMDI6NTg6MzZQ
TSAtMDUwMCwgRXJpYyBTdW5zaGluZSB3cm90ZToNCg0KPiBPbiBUaHUsIEZlYiA0LCAyMDIxIGF0
IDI6MTggUE0gQnVsZ3JpZW4sIERlbm5pcw0KPiA8RGVubmlzLkJ1bGdyaWVuQGFzdHJvbmljcy5j
b20+IHdyb3RlOg0KPiA+IFRoZSBodHRwczovL25hbTA0LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXQtc2NtLmNvbSUyRmRvY3MlMkZnaXR0dXRv
cmlhbC0yJmFtcDtkYXRhPTA0JTdDMDElN0NEZW5uaXMuQnVsZ3JpZW4lNDBhc3Ryb25pY3MuY29t
JTdDMzVkZDg4NWRhNzdhNGRjZDI3OGMwOGQ4Yzk0YjQ0MGUlN0NhMmNlOGE2MDA4NDA0OWI3OTM4
OTk3YWQ4MTFlMjkyNCU3QzElN0MwJTdDNjM3NDgwNjcyNDc4NjY1NDkwJTdDVW5rbm93biU3Q1RX
RnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsx
aGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzIwMDAmYW1wO3NkYXRhPXI0QTRhQnV5aThnc3UwZ3ZlVXNR
VEVjSXdzV2pGTThWa3pxSmwwQUt1aEUlM0QmYW1wO3Jlc2VydmVkPTAgc2F5cyAnRm9yIHNvbWUg
aW50ZXJlc3RpbmcgZXhhbXBsZXMgb2YgR2l0IHVzZSwgc2VlIHRoZSA8YSBocmVmPSJodHRwczov
L25hbTA0LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUy
RmdpdC1zY20uY29tJTJGZG9jcyUyRmhvd3RvLWluZGV4JmFtcDtkYXRhPTA0JTdDMDElN0NEZW5u
aXMuQnVsZ3JpZW4lNDBhc3Ryb25pY3MuY29tJTdDMzVkZDg4NWRhNzdhNGRjZDI3OGMwOGQ4Yzk0
YjQ0MGUlN0NhMmNlOGE2MDA4NDA0OWI3OTM4OTk3YWQ4MTFlMjkyNCU3QzElN0MwJTdDNjM3NDgw
NjcyNDc4NjY1NDkwJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFp
TENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzIwMDAmYW1w
O3NkYXRhPUpDN2RVaWU3MlJwaUI2a0FxWFVMTkJoOEZETTQzenVGOWUxUkRVSkd6aEUlM0QmYW1w
O3Jlc2VydmVkPTAiPmhvd3RvczwvYT4iJyBidXQgdGhhdCBkb2VzIG5vdCBleGlzdCBhbmQgcmVk
aXJlY3RzIHRvIGh0dHBzOi8vbmFtMDQuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRmdpdC1zY20uY29tJTJGZG9jcyZhbXA7ZGF0YT0wNCU3QzAxJTdD
RGVubmlzLkJ1bGdyaWVuJTQwYXN0cm9uaWNzLmNvbSU3QzM1ZGQ4ODVkYTc3YTRkY2QyNzhjMDhk
OGM5NGI0NDBlJTdDYTJjZThhNjAwODQwNDliNzkzODk5N2FkODExZTI5MjQlN0MxJTdDMCU3QzYz
NzQ4MDY3MjQ3ODY2NTQ5MCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3
TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MyMDAw
JmFtcDtzZGF0YT1RT3FPMXpyc2p4TlN0JTJCZUlrSzhpNzhDVEVKYkdrWDNMJTJGeDRWOUJjMDRV
USUzRCZhbXA7cmVzZXJ2ZWQ9MC4gV2hlcmUgc2hvdWxkIHRoYXQgbGluayBiZSB1cGRhdGVzIGl0
IHBvaW50Pw0KPg0KPiBgaG93dG9zLWluZGV4YCBkb2VzIGdldCBnZW5lcmF0ZWQgYnkgdGhlIEdp
dCBwcm9qZWN0IGJ1dCBkb2Vzbid0DQo+IGFwcGVhciB0byBiZSBwdWJsaXNoZWQgb24gdGhlIGdp
dC1zY20gc2l0ZSBmb3Igc29tZSByZWFzb24uIGdpdC1zY20gaXMNCj4gbWFpbnRhaW5lZCBhcyBh
IHNlcGFyYXRlIHByb2plY3RbMV0sIHNvIHRoZSBiZXN0IHRoaW5nIHRvIGRvIGlzIHRvDQo+IHJl
cG9ydCB0aGUgcHJvYmxlbSB0aGVyZSB1c2luZyB0aGVpciBidWcgdHJhY2tlclsyXS4NCj4NCj4g
WzFdOg0KPiBodHRwczovL25hbTA0LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZnaXRoDQo+IHViLmNvbSUyRmdpdCUyRmdpdC1zY20uY29tJmFtcDtk
YXRhPTA0JTdDMDElN0NEZW5uaXMuQnVsZ3JpZW4lNDBhc3Ryb24NCj4gaWNzLmNvbSU3QzM1ZGQ4
ODVkYTc3YTRkY2QyNzhjMDhkOGM5NGI0NDBlJTdDYTJjZThhNjAwODQwNDliNzkzODk5N2FkOA0K
PiAxMWUyOTI0JTdDMSU3QzAlN0M2Mzc0ODA2NzI0Nzg2NzU0ODglN0NVbmtub3duJTdDVFdGcGJH
WnNiM2Q4ZXlKV0lqb2lNDQo+IEM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsx
aGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzIwMDAmYW1wO3MNCj4gZGF0YT05aTNvSUxjbTk1NFA2SzJV
R1VOZ0tzZElqTDU0WGpka2ZQSllWV2VvN29zJTNEJmFtcDtyZXNlcnZlZD0wDQo+IFsyXToNCj4g
aHR0cHM6Ly9uYW0wNC5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBz
JTNBJTJGJTJGZ2l0aA0KPiB1Yi5jb20lMkZnaXQlMkZnaXQtc2NtLmNvbSUyRmlzc3VlcyZhbXA7
ZGF0YT0wNCU3QzAxJTdDRGVubmlzLkJ1bGdyaWVuDQo+ICU0MGFzdHJvbmljcy5jb20lN0MzNWRk
ODg1ZGE3N2E0ZGNkMjc4YzA4ZDhjOTRiNDQwZSU3Q2EyY2U4YTYwMDg0MDQ5YjcNCj4gOTM4OTk3
YWQ4MTFlMjkyNCU3QzElN0MwJTdDNjM3NDgwNjcyNDc4Njc1NDg4JTdDVW5rbm93biU3Q1RXRnBi
R1pzYjNkOA0KPiBleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklr
MWhhV3dpTENKWFZDSTZNbjAlM0QlN0MyDQo+IDAwMCZhbXA7c2RhdGE9biUyRnBuaUtkamRtdXpB
U1VJZEduMSUyQmZjSm5rVHVsMUVkR253dDJTdktNa2clM0QmYW1wO3INCj4gZXNlcnZlZD0wDQoN
ClRoZXJlJ3MgYWxyZWFkeSBhbiBpc3N1ZSBoZXJlOg0KDQogIGh0dHBzOi8vbmFtMDQuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdGh1Yi5jb20l
MkZnaXQlMkZnaXQtc2NtLmNvbSUyRmlzc3VlcyUyRjE1MjEmYW1wO2RhdGE9MDQlN0MwMSU3Q0Rl
bm5pcy5CdWxncmllbiU0MGFzdHJvbmljcy5jb20lN0MzNWRkODg1ZGE3N2E0ZGNkMjc4YzA4ZDhj
OTRiNDQwZSU3Q2EyY2U4YTYwMDg0MDQ5Yjc5Mzg5OTdhZDgxMWUyOTI0JTdDMSU3QzAlN0M2Mzc0
ODA2NzI0Nzg2NzU0ODglN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01E
QWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMjAwMCZh
bXA7c2RhdGE9WW52QXFDbEhaYjNOZTVSdElwU1FPJTJCWkk2SWJnbVdycVJqWmhZYWFVanlzJTNE
JmFtcDtyZXNlcnZlZD0wDQoNCkJ1dCBJIHRoaW5rIHRoZXJlJ3MgYSBsYXJnZXIgcHJvYmxlbSB3
aXRoaW4gR2l0J3MgbWFucGFnZXMgdGhlbXNlbHZlcy4NClRoZXJlIGlzIG5vIG1hbnBhZ2UgdmVy
c2lvbiBvZiBtYW55IG9mIHRoZSBwYWdlcywgeWV0IGdpdC50eHQgc3RpbGwgbGlua3MgdG8gdGhl
bS4gU28gIm1hbiBnaXQiIG9uIG15IHN5c3RlbSBwb2ludHMgdG8gdG8gc2V2ZXJhbCBmaWxlOi8v
IHVybHMgdGhhdCBkb2Vzbid0IGV4aXN0LiBUaGlzIGlzIHRydWUgb2YgbXkgY3VzdG9tLWJ1aWx0
IEdpdCwgYnV0IEkgdGhpbmsgYWxzbyB0cnVlIGZvciBzb21lIHN5c3RlbSBwYWNrYWdlIHNldHVw
cyAoZS5nLiwgRGViaWFuJ3MgImdpdCINCnBhY2thZ2Ugc2hpcHMgdGhlIG1hbnBhZ2VzLCBidXQg
eW91IGRvbid0IGdldCB0aGUgaHRtbCB2ZXJzaW9ucyB1bmxlc3MgeW91IGluc3RhbGwgImdpdC1k
b2MiIGFzIHdlbGwpLg0KDQotUGVmZg0KDQpUaGlzIEUtbWFpbCBpcyBjb25maWRlbnRpYWwuIEl0
IG1heSBhbHNvIGJlIGxlZ2FsbHkgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGFkZHJl
c3NlZSB5b3UgbWF5IG5vdCBjb3B5LCBmb3J3YXJkLCBkaXNjbG9zZSBvciB1c2UgYW55IHBhcnQg
b2YgaXQuIElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBpbiBlcnJvciwgcGxlYXNl
IGRlbGV0ZSBpdCBhbmQgYWxsIGNvcGllcyBmcm9tIHlvdXIgc3lzdGVtIGFuZCBub3RpZnkgdGhl
IHNlbmRlciBpbW1lZGlhdGVseSBieSByZXR1cm4gRS1tYWlsLg0KDQpJbnRlcm5ldCBjb21tdW5p
Y2F0aW9ucyBjYW5ub3QgYmUgZ3VhcmFudGVlZCB0byBiZSB0aW1lbHksIHNlY3VyZSwgZXJyb3Ig
b3IgdmlydXMtZnJlZS4gVGhlIHNlbmRlciBkb2VzIG5vdCBhY2NlcHQgbGlhYmlsaXR5IGZvciBh
bnkgZXJyb3JzIG9yIG9taXNzaW9ucy4NClBMRUFTRSBOT1RFIHRoYXQgRnJlZWRvbSBDb21tdW5p
Y2F0aW9uIFRlY2hub2xvZ2llcyBpcyBub3cgYSBwYXJ0IG9mIEFzdHJvbmljcyBUZXN0IFN5c3Rl
bXMgKEFUUykgYW5kIGVtYWlsIGFkZHJlc3NlcyBhcmUgY2hhbmdpbmcuIFBsZWFzZSB1cGRhdGUg
bXkgY29udGFjdCBpbmZvIGJ5IHJlcGxhY2luZyBAZnJlZWRvbWN0ZS5jb20gd2l0aCBAYXN0cm9u
aWNzLmNvbSB0byBkaXJlY3QgeW91ciBtZXNzYWdlcyB0byBteSBuZXcgZW1haWwgYWRkcmVzcyAo
Zm9yIGV4YW1wbGUsIGZpcnN0Lmxhc3RAZnJlZWRvbWN0ZS5jb20gd2lsbCBiZSB1cGRhdGVkIHRv
IGZpcnN0Lmxhc3RAYXN0cm9uaWNzLmNvbSkNCg==
