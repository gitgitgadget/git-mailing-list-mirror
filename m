Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E0C620966
	for <e@80x24.org>; Thu, 30 Mar 2017 15:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934047AbdC3P0Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 11:26:24 -0400
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:60352
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933729AbdC3P0V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 11:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=01fUiYC9OKgOkihIzETjUMjgIzDhXzjL39vM4sLcLwc=;
 b=WrXJBDVRU3QTGBqy25gSv+jrPfs1mepSJV0kXDMsRqFVB7OQXxTBCnClYNvW1UAznVj1ua65Th8HHn2CwR+DBNRlP3fYfu3ft3GXrfSs4kQBHVSkqnQBsYhdZCh23O35upBeICaZNckXaaAZMxnhlDU79OUnu1QK2MNBpZnzIrI=
Received: from BL2PR03MB323.namprd03.prod.outlook.com (10.141.68.22) by
 BL2PR03MB321.namprd03.prod.outlook.com (10.141.68.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.991.14; Thu, 30 Mar 2017 15:26:02 +0000
Received: from BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) by
 BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) with mapi id
 15.01.0991.021; Thu, 30 Mar 2017 15:26:02 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>
Subject: RE: [PATCH v3 0/8] refactor the filter process code into a reusable
 module
Thread-Topic: [PATCH v3 0/8] refactor the filter process code into a reusable
 module
Thread-Index: AQHSqKSlE4MqOKOtUUKA0VjEKpjKAaGsPKqLgAFFq9A=
Date:   Thu, 30 Mar 2017 15:26:02 +0000
Message-ID: <BL2PR03MB3239451B27A74171F20AF0DF4340@BL2PR03MB323.namprd03.prod.outlook.com>
References: <20170329155330.12860-1-benpeart@microsoft.com>
 <xmqqr31fam77.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqr31fam77.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [65.222.173.206]
x-microsoft-exchange-diagnostics: 1;BL2PR03MB321;7:UgbiXhERRaQPg6rMRvMSQV++QuZHo4fhzWUzSsOllw9JXN01atMWK3I0REgP3lpe7l/F4ikqX1tS1rGiX3FUtolhKTY5mKnhKY09ofnxJk9bDAEe8jUdbrf/wuL8gNGlmtdNHr8Utvv2z8fhaeRVE/B8NtPtkuF8L+lKS0XHb4p97LmiI0A7wjCA+nZgMyzJwascfapMZUME33LU+b/W6qz+aHsQ+4r4uuc/EK2MKkR6jn9C0p0B/J1ipc3nqFQP5r/+O6JDmeMNxOZVRXhzYvlA4l9Nr7nlOh4A1dzJR7YrvcpsK9W9cRNKW5U2Iw47aGdHp+cZWxaLYv8cOzViEmZu/xzvVeFEHodhmQ0lBqc=
x-ms-office365-filtering-correlation-id: f7922992-1e43-4ddf-5d76-08d47781135a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254075)(48565401081)(201703131423075)(201703031133081);SRVR:BL2PR03MB321;
x-microsoft-antispam-prvs: <BL2PR03MB3213B9FD33B1D21DF96C259F4340@BL2PR03MB321.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040450)(601004)(2401047)(8121501046)(5005006)(93006067)(93001067)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(201703131423075)(201702281528075)(201703061421075)(20161123560025)(20161123555025)(20161123562025)(20161123564025)(6072148);SRVR:BL2PR03MB321;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB321;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39840400002)(39450400003)(39860400002)(39410400002)(39850400002)(39400400002)(377424004)(3660700001)(3280700002)(8656002)(54356999)(102836003)(3846002)(6116002)(86612001)(6506006)(33656002)(25786009)(6436002)(86362001)(2906002)(50986999)(77096006)(66066001)(76176999)(8936002)(229853002)(10090500001)(5660300001)(9686003)(4326008)(2900100001)(8676002)(81166006)(38730400002)(2950100002)(6246003)(7696004)(39060400002)(53936002)(97736004)(305945005)(7736002)(74316002)(55016002)(189998001)(8990500004)(5005710100001)(54906002)(99286003)(122556002)(10290500002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR03MB321;H:BL2PR03MB323.namprd03.prod.outlook.com;FPR:;SPF:None;MLV:ovrnspm;PTR:InfoNoRecords;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2017 15:26:02.3246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB321
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Junio C Hamano [mailto:gitster@pobox.com]
>=20
> Ben Peart <peartben@gmail.com> writes:
>=20
> > Ben Peart (8):
> >   pkt-line: add packet_writel() and packet_read_line_gently()
> >   convert: Update convert to use new packet_writel() function
> >   convert: Split start_multi_file_filter into two separate functions
> >   convert: Separate generic structures and variables from the filter
> >     specific ones
> >   convert: Update generic functions to only use generic data structures
> >   convert: rename reusable sub-process functions
> >   sub-process: move sub-process functions into separate files
> >   convert: Update subprocess_read_status to not die on EOF
>=20
> This presentation is much easier to digest, compared to the large ball of=
 wax
> we saw previously.  It highlights the key modification that cmd2process i=
s
> now "subclassed" from subprocess_entry which is a more generic structure
> by embedding the latter at the beginning, and have its user
> start_multi_file_filter_fn() explicitly downcast the latter to the former=
 around
> patches 4/8 and 5/8.
>=20
> If I were doing this series, I would organize the first two slightly diff=
erently,
> namely:
>=20
>  * 1/8 just adds packet_read_line_gently().
>=20
>  * 2/8 moves packet_write_line() from convert.c to pkt-line.c while
>    renaming it, with the justification that this function must be
>    made more widely available.  It would naturally involves
>    adjusting existing callers.
>=20
> because write and read done in your 1/8 are independent and orthogonal
> changes, and doing it that way also avoids needless temporary duplication=
 of
> the same function.
>=20

I'll go ahead and do it that way.
=20
> I may later have further comments on 3-8/8 after giving them another read=
,
> but I haven't seen anything questionable in them so far.
>=20
> Thanks.

