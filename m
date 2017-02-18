Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABACA201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 23:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbdBRXxB (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 18:53:01 -0500
Received: from mail-bn3nam01on0128.outbound.protection.outlook.com ([104.47.33.128]:45121
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750893AbdBRXw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 18:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=oRDnyTvpvVhU8izOhaOjppQBRCboqzeszqknXVy+9xc=;
 b=ffw1Y6OA18QVq1DqYZ7PW7GSNZ3qblAgfpkIVRNjl1kYkFRnvT7lq74cJ+hyKkY6RMJ12XJ8HUYyFFjPjuSTaJ9tQpG6gDI2OjpWrFHubnKsHoj1+txnudKnjwgqRmhMro3wVIBqp3Qif2TYc7uYdZK4+TM3bjjvk1CjApSQOLE=
Received: from MWHPR03MB2958.namprd03.prod.outlook.com (10.175.136.139) by
 MWHPR03MB2957.namprd03.prod.outlook.com (10.175.136.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.919.13; Sat, 18 Feb 2017 23:52:37 +0000
Received: from MWHPR03MB2958.namprd03.prod.outlook.com ([10.175.136.139]) by
 MWHPR03MB2958.namprd03.prod.outlook.com ([10.175.136.139]) with mapi id
 15.01.0919.013; Sat, 18 Feb 2017 23:52:21 +0000
From:   Jeff Hostetler <Jeff.Hostetler@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
CC:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <Jeff.Hostetler@microsoft.com>
Subject: RE: [PATCH 0/5] A series of performance enhancements in the memihash
 and name-cache area
Thread-Topic: [PATCH 0/5] A series of performance enhancements in the memihash
 and name-cache area
Thread-Index: AQHShrXyB0sqhRdBvkSwHrNCSoEwwqFpDvAAgAETBoCABCinnYAACL6AgADwAM6AAC0kEA==
Date:   Sat, 18 Feb 2017 23:52:20 +0000
Message-ID: <MWHPR03MB2958D975B3B3022D6BC9AFBB8A5C0@MWHPR03MB2958.namprd03.prod.outlook.com>
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
        <20170214220332.753i4tgclm62er4f@sigill.intra.peff.net>
        <16b1259c-4cdc-8f4d-db47-d724386a3d2b@jeffhostetler.com>
        <xmqqo9y0m45e.fsf@gitster.mtv.corp.google.com>
        <20170218062943.j2llxuuylqs2qemy@sigill.intra.peff.net>
 <xmqqk28nmdi4.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqk28nmdi4.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jeff.Hostetler@microsoft.com; 
x-originating-ip: [76.182.13.114]
x-ms-office365-filtering-correlation-id: 7916d19c-aaaf-4b02-5d61-08d458592dd6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081);SRVR:MWHPR03MB2957;
x-microsoft-exchange-diagnostics: 1;MWHPR03MB2957;7:oS6pVtGw2nH1MRytkG8lha4Gqp88Qji+clzNODhvIYdzOkpMLfHRNfGi/TZP3uN0m8tgpQwXNLJux/nDAa046vuUzVpQ7+IHx0bNofDvBDchcNAO2ePO2V1PBGZVcqpBXQ7D5CfRci7/jERAdnber3VdH0OtTZy918Wj+j1jLsc+PQoCYPdFF5a+skjkcI9yyaXptGsHiTX8aFmZNkdLgUXy37Co2nRcA7Ce5gjpuLlOU/Eymfb78i7/lVTdMFDCMKN3RAQUEJpsFfkhL8KS9esXwX/VDUwfY1M+WvUOYB2uOZ+wndgR65pf22zH5BC6qV0gw8zNQ/hfDtFQsFSPsizkFMB/ouRSvQ4U307N104=
x-microsoft-antispam-prvs: <MWHPR03MB29577E45AD7C0CACFF28F3488A5C0@MWHPR03MB2957.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123555025)(20161123562025)(20161123564025)(20161123560025)(20161123558025)(6072148)(6042181);SRVR:MWHPR03MB2957;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2957;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(7916002)(199003)(55674003)(189002)(24454002)(106116001)(189998001)(105586002)(106356001)(101416001)(68736007)(2900100001)(3280700002)(122556002)(50986999)(54356999)(3660700001)(66066001)(86362001)(97736004)(86612001)(76176999)(8936002)(2950100002)(8676002)(9686003)(107886003)(6246003)(74316002)(54906002)(10090500001)(38730400002)(8990500004)(3846002)(81166006)(25786008)(7736002)(99286003)(55016002)(8656002)(8666007)(93886004)(5005710100001)(10290500002)(53936002)(305945005)(92566002)(77096006)(2906002)(229853002)(33656002)(6116002)(102836003)(5660300001)(81156014)(4326007)(6436002)(6506006)(7696004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR03MB2957;H:MWHPR03MB2958.namprd03.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2017 23:52:20.8688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2957
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jeff King <peff@peff.net> writes:
>=20
>> On Fri, Feb 17, 2017 at 09:58:21PM -0800, Junio C Hamano wrote:
>>
>>> Jeff Hostetler <git@jeffhostetler.com> writes:
>>>=20
>>> > I'll try to put together a before/after perf-test to better
>>> > demonstrate this.
>>>=20
>>> I didn't pick up the series while watching these exchanges, as I
>>> didn't know how quick your turnaround would be, but now a few days
>>> have passed.  Just to make sure we won't forget this topic, I'll
>>> pick up these 5 patches in the meantime.
>>
>> Yeah, to be clear my question was not an objection, but mostly
>> curiosity and interest.
>
> Yes, it was very clear that it wasn't an objection.
>=20
> But the other Jeff sounded like a follow-up was to follow shortly if
> not imminent so I decided to allocate my time on other topics still
> only on the list first while waiting to see what happens.

Sorry, I was out of the office for a family emergency on Thursday
and Friday.  Add to that the long weekend, and I won't get back around
to this until Tuesday or Wednesday at the earliest.

Jeff



=20
