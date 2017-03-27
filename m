Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47AE81FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 22:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbdC0WVS (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 18:21:18 -0400
Received: from mail-by2nam01on0104.outbound.protection.outlook.com ([104.47.34.104]:7616
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752108AbdC0WVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 18:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=A0fUUANj/5SOlmtW4R6mEmaYlIzyzsTGEsflXWrvKBA=;
 b=E20JfNPiWmy9adk3iwWnpdqPzAfD+FWc8fjUJWMQ64/n5V6w2QghHirDO5FfoSZFk7XDY/llbzEimee/Q8CvJtPjGf462HnbSngCF2R/g9yJ0pvc08wY9tfaRf2fJO41SYIE8QmfVUwBzwXd9T89aA2atn+vtLon9ddamQwvRBs=
Received: from BL2PR03MB323.namprd03.prod.outlook.com (10.141.68.22) by
 BL2PR03MB321.namprd03.prod.outlook.com (10.141.68.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.991.14; Mon, 27 Mar 2017 22:04:50 +0000
Received: from BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) by
 BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) with mapi id
 15.01.0991.020; Mon, 27 Mar 2017 22:04:50 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     Ben Peart <peartben@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>
Subject: RE: [PATCH v1 2/3] sub-process: refactor the filter process code into
 a reusable module
Thread-Topic: [PATCH v1 2/3] sub-process: refactor the filter process code
 into a reusable module
Thread-Index: AQHSoyzpU8K8fsRaT0qa2gB4ccvUfKGh87z3gAH74XCAADxhGYAAEixUgAUE2xA=
Date:   Mon, 27 Mar 2017 22:04:50 +0000
Message-ID: <BL2PR03MB3237E6E03677DAFB22F58FEF4330@BL2PR03MB323.namprd03.prod.outlook.com>
References: <20170322165220.5660-1-benpeart@microsoft.com>
        <20170322165220.5660-3-benpeart@microsoft.com>
        <xmqqk27gfrga.fsf@gitster.mtv.corp.google.com>
        <BL2PR03MB32308D0F2BB1C7D6F04141BF43E0@BL2PR03MB323.namprd03.prod.outlook.com>
        <xmqqpoh68xld.fsf@gitster.mtv.corp.google.com>
 <xmqqd1d68ukr.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqd1d68ukr.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [65.222.173.206]
x-microsoft-exchange-diagnostics: 1;BL2PR03MB321;7:Vr3GTYWka0D7LBVTeZYDC+nZ9LBTOBK/EG6whSGPFy8W97HKA+kHieC+Bbk4/73HTLmJOWzYGy9FvqMOAjT0n2H84nZX/bHsc1ariMizWDIeuPst7vyBVjOg0+E+AYpHsXHkYG9lXnWU4XxBHUDq7OrQ5KKpfWzFVig5kdTLrsl+Tr80U1j5L2nPjIqL8KcpmBg/kiOcVXFK3RwEgr6E/NdJORR+SwUFxMb+vM+aes0rl9V1k/0XUSI7BHxvafjA65hFxUHpW+Xmel1FAJl5Ug1CBtn0NMvbqFdowg3ebzpRR9uZ846gm3aqEEW5du17VYaCitbGy/cREAIgAWmdFCFWk6iX2nTtKaVp1VvuNFo=
x-ms-office365-filtering-correlation-id: e1843b4f-60d3-4a11-8c8b-08d4755d4a66
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254075)(48565401081)(201703131423051)(201703031133057)(201702281549051);SRVR:BL2PR03MB321;
x-microsoft-antispam-prvs: <BL2PR03MB321E26788D4848C2D3D6AD8F4330@BL2PR03MB321.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040425)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041248)(201703131423050)(201702281528050)(201703061421050)(201703061406050)(20161123558025)(20161123562025)(20161123555025)(20161123564025)(20161123560025)(6072148);SRVR:BL2PR03MB321;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB321;
x-forefront-prvs: 02596AB7DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39410400002)(39850400002)(39400400002)(39450400003)(39860400002)(39840400002)(66066001)(4326008)(38730400002)(110136004)(7696004)(229853002)(6246003)(122556002)(93886004)(25786009)(39060400002)(6436002)(2950100002)(6506006)(77096006)(6916009)(33656002)(86612001)(189998001)(50986999)(2900100001)(76176999)(2906002)(54356999)(86362001)(3660700001)(3280700002)(305945005)(8676002)(81166006)(8936002)(55016002)(99286003)(54906002)(10090500001)(8990500004)(10290500002)(5005710100001)(9686003)(5660300001)(53936002)(3846002)(74316002)(102836003)(7736002)(6116002)(8656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR03MB321;H:BL2PR03MB323.namprd03.prod.outlook.com;FPR:;SPF:None;MLV:ovrnspm;PTR:InfoNoRecords;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2017 22:04:50.5564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB321
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> writes:
>=20
>=20
> To avoid confusion (although readers may not require), even though I
> explained "boring mechanical part" first and "refactoring", that was pure=
ly
> for explanation.
>=20
> In practice, I would expect that it would be easier to both do and review=
 if
> refactoring is done with the original name.
>=20
> A function that will keep its name in the final result (e.g.
> start_multi_file_filter()) will call a new and more generic helper functi=
on.  The
> new helper may start using the new name from the get-go (e.g.
> subprocess_start()), but the data types it shares with the original part =
of the
> code (e.g. 'struct cmd2process') may still be using the original name.
>=20
> And after completing "2 or more" refactoring would be a good place to do
> the remaining "boring mechanical rename".  IOW, the count above could be
>=20
>      2 or more (refactoring) +
>      1 (boring mechanical part) +
>      1 (final movement)
>=20
> and I didn't mean to say that you need to rename first.  What we want is =
"if
> you need to have a single large patch that cannot be split, see if you ca=
n
> make it purely mechanical.", as a single large patch that is _not_ mechan=
ical
> conversion is the worst kind of patch for reviewers.

Thanks, I think I better understand what you are looking for in a patch ser=
ies.  In short, any non trivial refactoring should take place within the sa=
me file using 1 or more patches to keep each patch as simple as possible.  =
Any large or cross file refactoring should be made as boring/mechanical as =
possible. This is to make it easier to see any complex changes within a sin=
gle format patch section and avoid having to look between two file patches =
to ensure the refactoring didn't unintentionally change behavior.

I'll throw out my current refactoring and do it again attempting to follow =
these guidelines as soon as I can find the time ($DAYJOB tends to take prio=
rity over my open source work).

