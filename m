Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3B0C0502C
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 10:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiH1Key (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Aug 2022 06:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiH1Kex (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2022 06:34:53 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97D5656E
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 03:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1661682887;
        bh=qpxW7aS6wf77uSKbHspfa8X9tlVbuQ5SVlZP2BWE5jk=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=P7bschu95JEXyyXloYIN/cDClWU96SuVp2tMAQKvL3pA7pwmrOOrwtH2CyKMpOZH0
         Y4Y9RBImqVp7x4ngoamwqceDdHwJP1pYY6MwVUP1z9H4oqv8YLpxWDwFLqxK7Cm6c9
         vAHORc+C2l3YAxpmFFLDLbP8ycBCPiYeRp8vzn60=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.35] ([79.203.21.84]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvbn2-1pJfBx2HEk-00sRwS; Sun, 28
 Aug 2022 12:34:47 +0200
Message-ID: <a597ca34-04d7-4505-2e6b-f8f33d7e817e@web.de>
Date:   Sun, 28 Aug 2022 12:34:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: [PATCH 2/2] test-mergesort: use mem_pool for sort input
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <128f0fb8-d29b-8622-0cfe-2ecadc999db5@web.de>
In-Reply-To: <128f0fb8-d29b-8622-0cfe-2ecadc999db5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4BNmBkIiw2SfuJcKVPmHkFuHJOUDBNVgJ/G9Sex/RqfrUrp4MXr
 xFNOTkHas0BtLrRnpEAp3vgHgGtH7gpUofLQo3O/4UQjN996MEtEPwOAyetHo4yU7dM/Mmz
 7be0hKGvArPxfylHyKcrMzKTm9RDVKwHAKMYG2PC6C2NQDIYbgM4LJPrF+JlvIuqCViQjiE
 uAiO9uFcqp4SyKA/z8OAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cScU/rWQ+Ac=:xtEvPnzWlsQ8IWzMjE4/hY
 tyjWi2pi2zd4tAs33/GopMZfYdVqFk7eWco2qXYY7al0UyO4qRUGKUwcncDPwRQCTXV/Ke3xg
 mdSyVSySZnmUtmiO6Mrn1rvwsXjZfrNqyWdbR2gFNdjZSzjlO+oGCKcjjh/N4BfonzrKxmVjS
 ylkkhtJ7gWYpPqJEzyxG3f4eD9feCuRXqGtFDLJ2fVyMme3Or4FXt1Wl5adahGJbVk00H/ZYk
 /sPNpf72FQnEotJ3qXshqzIBD++lYyKA+KPTRqh1aJh6c/GrMye39pXGfSz5rtDAG+sD0xcYP
 IDMLyi7D3Z1BWZUIAbxiDWb9S9n30dRlxarTrQUXaZ4qldnwYan++BJFIDEhM96Tzzu3LicP2
 8I74RaPezzDHm/5+NYN7WVGGM+ZobwDL2KqLQs/0EmX2jwqFwfELJKMHG5TQxfh10G1rSirCT
 NFTSl6X7uTAbg1nx/Fw2rrpvi0lTYvFqC42ZmGep6oI0E0MJqbbPdaxlVNIUzOF8bq2rX4XL6
 wNjkPGb6pxPifUE6IQ2ganii4nNMKmZAFB8tH5fn5OOE6xkvgXgoqobp2dYNddploVtcDCRRG
 aX6v4vLJcc5YHlYbdDqBXMmG1LltT5QslAkDhh/W9PuUg2wZ074v5/jYsqzU40xMzhYW4x71J
 p/9HWJ+VqYO0bJ4mwaBcEXV1K4SEru/J61l5LpcYRG95bPwEMZJZ5AaIC+nE29AteL9vLpYeP
 kECR9LjBDxaG5ChPm45p9YRBxTVk8wBo5+aXmdDgehQ1L8wl3zGSKJauu0rAV/VQLo58Q15tQ
 99NwQW4UiJ6hHO7E97g/VS+zXIX60yqO6ml2O/Gv18s13DEO6va3z7LV3JsSytFF6iovPhcAb
 W1UYzVfTAPD06oKEHjaSEUOit0VpInd1zRy61kr1g/mDPx+Dp/Y2KxvnziewDn4dA1AdXJbv2
 uRpZ6BvdPhyEqcRGtxzqL+ItKEG2Pum7JqxwChVQU5urt+DOoVsbdE0W+0FZCht997iXsAzXR
 LIaascWAYIdTf0B4v8BogkoA+8cD7uCDWa9lByCL8rDgVE0hfd8UgCMwJXKVFy8llvKKysX+N
 4WH6eKKBPIM1d5h7TqaZTSJpl/g9yegJ1xM
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous patch almost halved the number of heap allocations for the
sort subcommand.  Reduce it further by using a mem_pool for the line
objects.

Note that t/perf/run can't be used directly to compare two versions of
test-mergesort because it always runs the helpers from the checked-out
version.  So I hand-merged the results of separate runs before and with
this patch:

macOS 12.5.1 on M1:
0071.12: DEFINE_LIST_SORT unsorted     0.22(0.20+0.01)     0.21(0.19+0.01)
0071.14: DEFINE_LIST_SORT sorted       0.10(0.08+0.01)     0.10(0.08+0.01)
0071.16: DEFINE_LIST_SORT reversed     0.10(0.08+0.01)     0.10(0.08+0.01)

Git SDK 64-bit on Windows 11 21H2 on Ryzen 7 5800H:
0071.12: DEFINE_LIST_SORT unsorted     0.54(0.00+0.06)     0.44(0.01+0.06)
0071.14: DEFINE_LIST_SORT sorted       0.21(0.03+0.03)     0.19(0.04+0.01)
0071.16: DEFINE_LIST_SORT reversed     0.21(0.01+0.04)     0.19(0.04+0.04)

Debian bullseye on WSL2 on the same system:
0071.12: DEFINE_LIST_SORT unsorted     0.29(0.27+0.01)     0.22(0.19+0.02)
0071.14: DEFINE_LIST_SORT sorted       0.07(0.06+0.01)     0.06(0.04+0.02)
0071.16: DEFINE_LIST_SORT reversed     0.07(0.04+0.03)     0.06(0.04+0.02)

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-mergesort.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 540537224f..335e5bb3a9 100644
=2D-- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -25,6 +25,7 @@ static int sort_stdin(void)
 	struct line *lines;
 	struct line **tail =3D &lines;
 	struct strbuf sb =3D STRBUF_INIT;
+	struct mem_pool lines_pool;
 	char *p;

 	strbuf_read(&sb, 0, 0);
@@ -36,10 +37,11 @@ static int sort_stdin(void)
 	if (sb.len && sb.buf[sb.len - 1] =3D=3D '\n')
 		strbuf_setlen(&sb, sb.len - 1);

+	mem_pool_init(&lines_pool, 0);
 	p =3D sb.buf;
 	for (;;) {
 		char *eol =3D strchr(p, '\n');
-		struct line *line =3D xmalloc(sizeof(*line));
+		struct line *line =3D mem_pool_alloc(&lines_pool, sizeof(*line));
 		line->text =3D p;
 		*tail =3D line;
 		tail =3D &line->next;
=2D-
2.30.2
