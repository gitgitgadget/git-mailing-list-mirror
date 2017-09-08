Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC8771FADE
	for <e@80x24.org>; Fri,  8 Sep 2017 20:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757105AbdIHUCi (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 16:02:38 -0400
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:14624
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756846AbdIHUCf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 16:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0+FAS9qP1DSQ1cgNKRqUcJL/5uLtEue1ordnDULIIA8=;
 b=oEEldcgzCTjcc9l20OwSQhmh5MOZy8W9NUfWkRBowbQzlonmOnYvfOmUCdwingFCMkQ+Tpi0yO5+ow70K7JWJYJg/PivPyKTBMeDbnisruT+bK9HkZ3FJT9BCHYQN/H6//E1JQRgRRALCenJG32J+7ncxt2RUUaMCS/HG/WnqZk=
Received: from SN1PR21MB0014.namprd21.prod.outlook.com (10.161.254.12) by
 SN1PR21MB0032.namprd21.prod.outlook.com (10.161.254.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.56.7; Fri, 8 Sep 2017 20:02:33 +0000
Received: from SN1PR21MB0014.namprd21.prod.outlook.com ([10.161.254.12]) by
 SN1PR21MB0014.namprd21.prod.outlook.com ([10.161.254.12]) with mapi id
 15.20.0056.003; Fri, 8 Sep 2017 20:02:33 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Subject: RE: [PATCH 1/1] reset: fix reset when using the sparse-checkout
 feature.
Thread-Topic: [PATCH 1/1] reset: fix reset when using the sparse-checkout
 feature.
Thread-Index: AQHTKMyCASx4J5FrG0SFSfVy0yz4a6KrWy30gAAJb7A=
Date:   Fri, 8 Sep 2017 20:02:33 +0000
Message-ID: <SN1PR21MB0014638E5D9CBFD0D9D85F10B7950@SN1PR21MB0014.namprd21.prod.outlook.com>
References: <20170908180050.25188-1-kewillf@microsoft.com>
        <20170908180050.25188-2-kewillf@microsoft.com>
 <xmqqvaktxawk.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqvaktxawk.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kewillf@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-09-08T14:01:23.4093752-06:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [174.126.250.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR21MB0032;6:zDp6NbG7+PgymrD9wJEDhd4ji9k7Fj5wJ1bV5B30/AB1K3uks7gUkMAFSgNqL2oRnmiop97UCb2NL5WZ5sItLy58EAm8yy29v6Cbs4KaYeAVgCkGUatgTd+9irhmIU9q8ql7X1XPFQ5H1BTx51XRtvmux38puqTNb0jaDHHvsxZRBUEAMlDt9AwE/tZ3nclcKeFEAejnueyw6KN6U+ze+me55nBi8Bs7dl2Pv6AYIdHhNWcVxU49r+RzaHKaV7cNtBLrgakWbEEqR5IUOpS8+9KW+08hQQJVY6U1U1dPhQITrTLX8jfi81l2fDkfAYubqkLcG68f9nJmiK51OF+7hQ==;5:GsEQtEcLj/hCxgGN3BKQkXGzxZg4fl8yLicIH8XMuYz3XJtHsb42rctyc1gmptiSfIIMdS2gUL42M3D5ynpDjkajvxtX9H5QNwtF8E2OJhcDMCB+l+pzKH+7FFbulQXJIW1uVw+6XdRaxSGn6oizcg==;24:AJ7XdzKglHHFli43c4RrF4VEGVSWkwhbBmosAUiPBQzy5tfW8Dg6LpbCxvbd3KoL6u5k4Y8bUaCxATyYkaRAUdq1THvZ/AGCg8v1e+uO6+A=;7:tQ30IZ2zcgTQQl3aHsyrdt9PFMHA9UF/fnKBGgM8t8sHs7T/NPdXPwdJDvr7w8jKnNZD/O+5R/HprDBjeP94Z4Aez6Ooe+NGlbBX361/aYXwjcWdqJjDR8CaYiwl77PHxC8scaJbPgLX1uqsB7yLyZ1UZ4x/Z5MPejKHxZhojd/fufOlKnVGLs5JlXZkyaK7GtwzSHB/q714mk653RvAfVP0rjANSrGUBo2mchB66QU=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 09b81352-3c29-4d7b-71b9-08d4f6f48b1c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN1PR21MB0032;
x-ms-traffictypediagnostic: SN1PR21MB0032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
x-exchange-antispam-report-test: UriScan:(89211679590171)(100324003535756);
x-microsoft-antispam-prvs: <SN1PR21MB003290D72030084E60BB0C07B7950@SN1PR21MB0032.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123555025)(20161123562025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN1PR21MB0032;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN1PR21MB0032;
x-forefront-prvs: 04244E0DC5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(47760400005)(377454003)(199003)(189002)(5660300001)(229853002)(25786009)(66066001)(77096006)(8990500004)(14454004)(33656002)(10090500001)(106356001)(105586002)(97736004)(7696004)(3846002)(102836003)(101416001)(6116002)(53936002)(110136004)(22452003)(6436002)(2950100002)(81156014)(6916009)(81166006)(8676002)(6246003)(76176999)(4326008)(54356999)(8936002)(7736002)(50986999)(39060400002)(74316002)(305945005)(68736007)(8656003)(2906002)(54906002)(55016002)(99286003)(3660700001)(3280700002)(478600001)(2900100001)(86612001)(189998001)(86362001)(9686003)(10290500003)(6506006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR21MB0032;H:SN1PR21MB0014.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2017 20:02:33.1026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR21MB0032
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


From: Junio C Hamano [mailto:gitster@pobox.com]
Sent: Friday, September 8, 2017 1:12 PM
> Kevin Willford <kewillf@microsoft.com> writes:
>=20
> > When using the sparse checkout feature the git reset command will add
> > entries to the index that will have the skip-worktree bit off but will
> > leave the working directory empty.  File data is lost because the index
> > version of the files have been changed but there is nothing that is in =
the
> > working directory.  This will cause the next status call to show either
> > deleted for files modified or deleting or nothing for files added.
>=20
> Getting rid of sparseness may of course be one way to correct the
> discrepancy, but it is unclear to me if that is the best way to do
> so.  An alternative may be to add entries to the index that does
> have the bit on for paths that are meant to be skipped due to
> "sparse" thing, no?  Am I being naive, missing some reason why that
> would give us a worse result?

There are two cases that this is trying to solve.

1. reset mixed when there were files that were added

In this case the index will no longer have the entry at all because
the reset is making the index look like before the file was added
which didn't have it. When not using the sparse-checkout this is fine
because the file is in the working directory and the reset didn't touch
it.  But using the sparse-checkout on that file and if the file was not
in the working directory, the index gets reset and the entry for that
file is gone and if we don't put the index version of the file before the
reset into the working directory, then we have lost the content for
that file

2. reset mixed when there were files modified

This case is similar but with modified files there is an entry in the index
but it is getting changed to a previous version of the file.  If we don't g=
et
the file on disk then the version of the file that, in the non sparse-check=
out
case, would be on disk is lost and cannot be recovered.  So even if we turn
on the skip-worktree bit for this entry and it doesn't show up in status
calls, we lost the previous version of the file.


