Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CE1C201B0
	for <e@80x24.org>; Sun, 19 Feb 2017 00:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751012AbdBSAUR (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 19:20:17 -0500
Received: from mail-cys01nam02on0118.outbound.protection.outlook.com ([104.47.37.118]:45236
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750838AbdBSAUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 19:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GIYf9pt6n34rT6tssu2ihH0Fd3k+R/MOab5eA6cR8SY=;
 b=OHNB94KYtp+G6qwcKmDtu4y3ozQShFQspLwvoHSC0MHM5K7paSQSrRL5Tdjxgv3IQvpVh0EIhbMs8nICrDfKsS8AovibzQkiNquUcrmCw2gumOltfPbPdTpbMw/8DKLXx3ZBz7ODLobRGw4gPJiyByiNLNf8XJPmpcsf8WcUhzg=
Received: from MWHPR03MB2958.namprd03.prod.outlook.com (10.175.136.139) by
 MWHPR03MB2960.namprd03.prod.outlook.com (10.175.136.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.919.13; Sun, 19 Feb 2017 00:19:58 +0000
Received: from MWHPR03MB2958.namprd03.prod.outlook.com ([10.175.136.139]) by
 MWHPR03MB2958.namprd03.prod.outlook.com ([10.175.136.139]) with mapi id
 15.01.0919.013; Sun, 19 Feb 2017 00:19:58 +0000
From:   Jeff Hostetler <Jeff.Hostetler@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff Hostetler <Jeff.Hostetler@microsoft.com>
Subject: RE: [PATCH 3/5] name-hash: precompute hash values during
 preload-index
Thread-Topic: [PATCH 3/5] name-hash: precompute hash values during
 preload-index
Thread-Index: AQHShrYGeaT62Itouk+oNkOJwz/r0KFuR5hWgAEx8kA=
Date:   Sun, 19 Feb 2017 00:19:58 +0000
Message-ID: <MWHPR03MB295845950BB87BA9479E973E8A5F0@MWHPR03MB2958.namprd03.prod.outlook.com>
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
        <8621305c69898e012720d4fe66d42b096f053073.1487071883.git.johannes.schindelin@gmx.de>
 <xmqq37fcnj7v.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq37fcnj7v.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jeff.Hostetler@microsoft.com; 
x-originating-ip: [76.182.13.114]
x-ms-office365-filtering-correlation-id: f0d6c798-a653-4b9c-8dc1-08d4585d09d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081);SRVR:MWHPR03MB2960;
x-microsoft-exchange-diagnostics: 1;MWHPR03MB2960;7:60+fdNROWCK6Co+6j1LBleRvxobkxo3+p/tcYVpYgvgNcbTxaAus5+A5p6eE3kiqFJ1ijOKbvWh5tNy8i629J3r6DpQxV98EYCi8jQ4KSUFaYqwpVQDefsKqkEXzMHBp/GnhNxGjvHJuXTItsA0myi5aDnHnZ0UqJXJAaC9d7VI/CDfxXpqF7S1SN27Ll1rjD2WoBgqeuQKqF85MaNlhdQOgXtMi5VjNSsAoU4T8tgfHBiGRy8aY/D+MgVm+z68VohJOBlCX1BxAoPzaBM94cZVEr1nZWm2288pzIFGyRy36ilywMsZWuSDYwuxC9mxAoPdf24L/jSd0PIGLLpjXyvUifuH38FmeOhBP6OLDV8k=
x-microsoft-antispam-prvs: <MWHPR03MB2960CA4D7E92E97A860B57FE8A5F0@MWHPR03MB2960.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123558025)(20161123564025)(20161123562025)(20161123555025)(6072148);SRVR:MWHPR03MB2960;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2960;
x-forefront-prvs: 02234DBFF6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(7916002)(39840400002)(39410400002)(39850400002)(39860400002)(39450400003)(189002)(199003)(105586002)(6916009)(106356001)(106116001)(305945005)(2950100002)(68736007)(229853002)(5660300001)(74316002)(7736002)(86362001)(53936002)(6246003)(110136004)(38730400002)(107886003)(7696004)(122556002)(86612001)(102836003)(97736004)(54356999)(8676002)(8936002)(3280700002)(6116002)(3846002)(25786008)(6436002)(99286003)(189998001)(55016002)(2900100001)(9686003)(6506006)(3660700001)(81166006)(8656002)(81156014)(8666007)(54906002)(77096006)(92566002)(66066001)(4326007)(33656002)(2906002)(50986999)(10090500001)(76176999)(5005710100001)(8990500004)(10290500002)(101416001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR03MB2960;H:MWHPR03MB2958.namprd03.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2017 00:19:58.5094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2960
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



From: Junio C Hamano [mailto:jch2355@gmail.com] On Behalf Of Junio C Hamano
>=20
> The fact that each preload_thread() still walks the index in-order
> makes me wonder if it may allow us to further optimize the "dir"
> part of the hash by passing the previous ce for which we already
> precomputed hash values.  While the loop is iterating over the paths
> in the same directory, .dir component from the previous ce can be
> reused and .name component can "continue", no?
>=20
> It's possible that you already tried such an optimization and
> rejected it after finding that the cost of comparison of pathnames
> to tell if ce and previous ce are still in the same directory is
> more than unconditionally memihash() the directory part, and I am in
> no way saying that I found a missed optimization opportunity you
> must pursue.  I am just being curious.

I looked at doing this, but I didn't think the complexity and overhead to
forward search for peers at the current level didn't warrant the limited ga=
ins.
(I was just looking at the complexity of clear_ce_flags_1() in unpack-trees=
.c
and how hard it has to look to find the end of the current directory and th=
e
effect that that has on the recursion and it felt like too much work for th=
e
potential gain.)

Whereas remembering the previous one was basically free.  Granted, it only
helps us for adjacent files in the index, so it's not perfect, but gives us=
 the
best bang for the buck.

Jeff

