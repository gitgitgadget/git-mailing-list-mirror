Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7785201B0
	for <e@80x24.org>; Sun, 19 Feb 2017 00:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750893AbdBSAEG (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 19:04:06 -0500
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:27443
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750820AbdBSAEF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 19:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1lfj+vjTbvovwyu6JThN+cu6BPiTnqpL+W/lJ4zPwpc=;
 b=hGneV7A3TZNQ+bcQB2N4zmUYnnLEIIgiOpXfJOXyxkLbzFPyo7gV504T3zahuGFLLZdObssEumQ1kvFnczQVOLblcVgsNW8dE0VX5JXuQlcXQFltt55GIFqsDCeEUcwAJkSJHoFJwT8z4rtGT0BrdKBJDmuuE3/P7w+KKAjCt4U=
Received: from MWHPR03MB2958.namprd03.prod.outlook.com (10.175.136.139) by
 MWHPR03MB2958.namprd03.prod.outlook.com (10.175.136.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.919.13; Sun, 19 Feb 2017 00:02:30 +0000
Received: from MWHPR03MB2958.namprd03.prod.outlook.com ([10.175.136.139]) by
 MWHPR03MB2958.namprd03.prod.outlook.com ([10.175.136.139]) with mapi id
 15.01.0919.013; Sun, 19 Feb 2017 00:02:30 +0000
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
Thread-Index: AQHShrXyB0sqhRdBvkSwHrNCSoEwwqFpDvAAgAETBoCAACYbAIAEAegUgAEssgA=
Date:   Sun, 19 Feb 2017 00:02:29 +0000
Message-ID: <MWHPR03MB29582CB216B01C0A825817A08A5F0@MWHPR03MB2958.namprd03.prod.outlook.com>
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
        <20170214220332.753i4tgclm62er4f@sigill.intra.peff.net>
        <16b1259c-4cdc-8f4d-db47-d724386a3d2b@jeffhostetler.com>
        <20170215164416.tekykkzhm6qlj2h2@sigill.intra.peff.net>
 <xmqqvas8m499.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqvas8m499.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jeff.Hostetler@microsoft.com; 
x-originating-ip: [76.182.13.114]
x-ms-office365-filtering-correlation-id: fa3145d4-f40c-48cc-ed5a-08d4585a98dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081);SRVR:MWHPR03MB2958;
x-microsoft-exchange-diagnostics: 1;MWHPR03MB2958;7:gW+Pri8xOP/O5bU9VaFW5accHnYFDxole1+SG9Yl8+u8QM1496xxOrLKyyBWNsKtGY1ZyujDoFa27tQZ6+gNg8SP0djdjtyCSuNL7kJ9LSGQbchsYR/65d+AoaspTzDZM8B+h8Wt8klMdH1wENP7ya3LuMcGY9OE0bJm3bG7FMLZTc/mipHchUrEhGhiT0182+GqeZCmDm3XXfp17TWR8Pn+yoF9OkHuT1b1znrDYPBwx2/F+oY2N3xutJSY5MZbQOdV8VVCIDUAONkheaVnVSv0TdG1gPDdtj0S8K02FxjSMtmUdNRZiOH+UWRvhVhAsgwa2gmoREC/uWBj8sODr9Wy/xXkEGgVMpPlOVbDgs4=
x-microsoft-antispam-prvs: <MWHPR03MB2958F08C6A6FE92E6CAE6B678A5F0@MWHPR03MB2958.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123558025)(20161123555025)(20161123562025)(20161123564025)(6072148);SRVR:MWHPR03MB2958;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2958;
x-forefront-prvs: 02234DBFF6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(7916002)(39850400002)(39840400002)(39860400002)(39450400003)(39410400002)(24454002)(199003)(189002)(86362001)(54356999)(33656002)(66066001)(50986999)(76176999)(101416001)(86612001)(7736002)(6246003)(122556002)(97736004)(106356001)(3846002)(106116001)(5005710100001)(53936002)(8990500004)(10090500001)(105586002)(189998001)(10290500002)(25786008)(3280700002)(2900100001)(2906002)(92566002)(3660700001)(81156014)(81166006)(8676002)(38730400002)(6116002)(68736007)(102836003)(74316002)(107886003)(305945005)(8936002)(99286003)(9686003)(7696004)(5660300001)(6506006)(77096006)(55016002)(8666007)(8656002)(54906002)(2950100002)(6436002)(229853002)(4326007)(93886004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR03MB2958;H:MWHPR03MB2958.namprd03.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2017 00:02:29.9142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2958
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



From: Junio C Hamano [mailto:jch2355@gmail.com] On Behalf Of Junio C Hamano
> Jeff King <peff@peff.net> writes:
>> On Wed, Feb 15, 2017 at 09:27:53AM -0500, Jeff Hostetler wrote:
>>
>>> I have some informal numbers in a spreadsheet.  I was seeing
>>> a 8-9% speed up on a status on my gigantic repo.
>>>=20
>>> I'll try to put together a before/after perf-test to better
>>> demonstrate this.
>>
>> Thanks. What I'm mostly curious about is how much each individual step
>> buys. Sometimes when doing a long optimization series, I find that some
>> of the optimizations make other ones somewhat redundant (e.g., if patch
>> 2 causes us to call the optimized code from patch 3 less often).
>
> I am curious too.
>
> To me 1/5 (reduction of redundant calls), 4/5 (correctly size the
> hash that would grow to a known size anyway) and 5/5 (take advantage
> of the fact that adjacent cache entries are often in the same
> directory) look like no brainers to take, regardless of the others
> (including themselves).=20

agreed.

> It is not clear to me if 3/5 (preload-index uses available cores to
> compute hashes) is an unconditional win (an operation that is
> pathspec limited may need hashes for only a small fraction of the
> index---would it still be a win to compute the hash for all entries
> upon loading the index, even if we are using otherwise-idel cores?).

I'm not sure about pathspec cases.  What I was seeing was that during
the call to lazy_name_init_hash() was taking 30% of the time in
"git status" and 40% in "git add <one_file>".  (Again this was on my
giant repo with a 450MB index).
=20
> Of course 2/5 is a prerequisite step for 3/5 and 5/5, so if we want
> either of the latter two, we cannot avoid it.

jeff

