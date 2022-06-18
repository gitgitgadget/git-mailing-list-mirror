Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E9FC43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 11:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiFRLMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 07:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiFRLMu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 07:12:50 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C32DFDB
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 04:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655550757;
        bh=nZGGRk6zjEkigEmdYUZeasVVXIrhR5OgqfeBdUqnXGI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=aTcx7edDAU8UDPVPLR8Y2FoSsQouooq1ZF1Qe57DI/Wf2XY0Q1AKwCaGF7hzB5RbA
         fYedXKQEFZckJ11Qv1aFpMGo52Fdm9fbnZYdRagdbu5FRe51Iv2CNvQNVlVaEffoDD
         Qn+3N4TI96jV5j0XBky+e3lD0HBTAmICvq9hwrSk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXXN7-1oCirq2nWB-00Z2q8; Sat, 18
 Jun 2022 13:12:37 +0200
Message-ID: <493bbdb3-be73-9aa2-e3f6-82508d15ef88@web.de>
Date:   Sat, 18 Jun 2022 13:12:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: [PATCH 2/2] combine-diff: abort if --output is given
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
References: <a6a14213-bc82-d6fb-43dd-5a423c40a4f8@web.de>
 <patch-1.1-f7fd645468c-20220523T182954Z-avarab@gmail.com>
 <xmqqleusqaff.fsf@gitster.g> <220524.86leurw3my.gmgdl@evledraar.gmail.com>
 <xmqqmtf6hgae.fsf@gitster.g> <220524.86v8tuvfl1.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220524.86v8tuvfl1.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:596uU2OI9pnARMnyOSWR5ieEtmriIl+POGzxBStzSwTK2SHd6B0
 FBGS9I3yP7+ReogK4KghtxKvD9vMemsKW35I3NQErHmk1Wplm5cpJHguNIzVuozknMsZ0G3
 fJkCelyhFdeSgpJM0sqkLh4rZZ/uQ/8MGI52j6hoLOscl69JvCI/WmrCI0RU7tzbJ6kQSfz
 p8b8zMbeORrQmS3q6RaHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PvjwTIIISL0=:/i4DKoI6mnKkQDXmlStoZn
 fHSlVZLCNZoUFrPGaNR7AsCdHQeSiyHQbYs6MYTjeRFLgFcYvmZMuJfVxfbLjvzXNkY3V4H2H
 QIof8lkdE7fSkzPldVbfhFDjVoDtDiEPCY43hYZhtIV7nN2GGcEO6OTVeqD+9Gplcqe/w6/XT
 cvRfBnmuitz91rsuAk9KP/hknEdvhfnskPCsKg8p6/fWWxXRsYI667yAPr6xiAV9/Kx9x9NHe
 uRJQiNiR1JWtO5WL9zsDdG6XBlSjbUjbcCEVdtT0PEPxHqpqg3o0bJwhbyjjjOM40e0LxNkkz
 NME2UFvANx0T1ctqJsx3cTPKD5gIS/gUarhZSsZZk8RdUkQcU4KqV5YwLA0BhrkltxnSqYITz
 PYMY/hB8Ap0cLDtdf19PseS6HqkVyf3lV2TyHSfH0M4ZB4MZ7tERH7V/TZTDp+jjaK8fF+yXl
 BDZA/iFOMoguaudCibY9uI/VhzES01905lQ2NEr5aJkpkMqxSXCCPL5q++ZpFD/9rPuMnCTn4
 ocAQS90Eq+R/0QYCe5N6J1Rg2upebCuU5hCSf/o1Zx5AQqUeSxp+gQ/88GJZ1WnyAADTdZ6u8
 AjBXUaJF69M4fMP8okOOVRUHX8Uixln0wZMdF9TvBKdgOeGCvXG9msPBR3IZl0YaB4Bi01SNO
 y5w2mVXBMXfKJtlsgZaORPT2KJfXq1g7uhT5rUa1AHOW0PMe2F+AFzC+Nsi/SQeCMpiNWh7J0
 BuRSJ4wMbhVYMys7ZXiJxK8pCuB9z3IPwBdMpuO1mxL/VqcuwI8h6iQz3NGFUB8txCNWKtzd6
 FnbwG5GNMZjUrfLFahELB0AvO3QdrCz2uyl7NIRXJmcTlhZA44KsHCJr27XF0ButpMAYNAx6p
 nEXbnBtQfzDhjR4E+cvN+hwut8sui8xI3FRc/2aA9Sw0dsIQ/G00Z6xjhflbvO+hmu8qlYIGw
 1yRXYDHjGixk03kIOn+gnDcDnY7/zDXhHmMKo7kvoVgthgXK97r06NQ4mrhIuIUDHKfcnhUsA
 g543efhBX87Jg6cA04bVJtqDV2I+g/CiMe6SEkTUdr6VJKmZFRHA7i/+ykPM58RhqZo1VfyKH
 PNgRDCNxz/q1Fh+2jvosXScqDWx7AVSsx2A
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code for combined diffs currently only writes to stdout.  Abort and
report that fact instead of silently ignoring the --output option.  The
(empty) output file has already been created at that point, though.

Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 combine-diff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/combine-diff.c b/combine-diff.c
index 11df1d7f39..b0ece95480 100644
=2D-- a/combine-diff.c
+++ b/combine-diff.c
@@ -1501,6 +1501,9 @@ void diff_tree_combined(const struct object_id *oid,
 	if (opt->ignore_regex_nr)
 		die("combined diff and '%s' cannot be used together",
 		    "--ignore-matching-lines");
+	if (opt->close_file)
+		die("combined diff and '%s' cannot be used together",
+		    "--output");

 	/* nothing to do, if no parents */
 	if (!num_parent)
=2D-
2.36.1
