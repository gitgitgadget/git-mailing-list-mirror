Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36241F461
	for <e@80x24.org>; Thu,  5 Sep 2019 08:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbfIEIZm (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 04:25:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:42399 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732493AbfIEIZm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 04:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567671930;
        bh=HM1yBTk30ImjfAL7skcaWQmkDj5DVMn3K2qiXtw3LPc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=S880/8MH9bId0tdRLteXQRyHoXN6BmYTW0UjLw8EeYu/T0GzSuVANzUeFzigqXfb9
         WavRfAcbEgtZmdAKtEtv5ng7WLtZfvURrl+Nw8Ittcvj7rpyrsjYRL9nl4/PoayquS
         VtX4FHff4wRTRF9af49Jx2zHs5oV/jCHAc10rqwY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([88.70.128.63]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M6O1v-1iLpir1S1r-00yPdU; Thu, 05 Sep 2019 10:25:30 +0200
From:   Stephan Beyer <s-beyer@gmx.net>
To:     Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Shawn O. Pearce" <spearce@spearce.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
Subject: [PATCH] Fix maybe-uninitialized warnings found by gcc 9 -flto
Date:   Thu,  5 Sep 2019 10:24:59 +0200
Message-Id: <20190905082459.26816-1-s-beyer@gmx.net>
X-Mailer: git-send-email 2.23.0.38.g7ab3f3815a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lJ52IZOQb9PvpGbmSUs1eeSO/BlkHnnpW1yzlggRy0xWwq0YwWj
 h3sCBZlWBKKp5mimlRSnjSFosqTLGkCPJPQJuhSKfFohB0wERbB2WVJzx+AYW3h/BohfdNt
 lZeKOhi/5dSXUKeTXagzQtDolR3a9kuVOfQ0WPrrCVgCVWjzkWCbHTQoDXTOkX71BQl4pz4
 dJ9HjtFTAflptqW6vASEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L1CHq3TsyLY=:1MNUarI5NZNf/IQCsbjSWF
 W3WVpbCBOAtOsYHgA2UQWoRvLWx4QVKvGV8XSBQjfWAKJCSBiW3yIJVq3odMb+lbl4blqyoRv
 oH/C/VtU8j9+QHSJizrYD76FFn5uR/pRQZyynhK0eMGA1zjcEiQ3Tq4DZtEy3WlSc9+d1QjIz
 cgwd/V3jPb8fYcGPb/ccU2o1wVfLoOmDM4n52L8apd6gcr76gcr25okmxDosBGWWCsCvDZkQv
 MyEGRvaueqZdlyFBurtHJxeu4AkOHAh684D/TKA0zVR0mDrRexD1G5qsgfUaG7l3JWe+wKWMB
 gndMhivjhGvMx+MmoyRhaimz8Mu3fAN5EkQPjMW6i2GPyjlaiuUOnz7dEgeGx/c956mTU5oC/
 yoFyVYir8alqndmKTk+cQK4G0n1gge5NTnUI23m8uERLvaz1x5hfRTFSqC5LlYfitGIOrLAql
 wPw7c4RpZCC6BUJB+yufWFCVcJf9mnnKL9dz2jLhzAN+2kZS/mQZkjkrxexJsDDwVXx0jPLZr
 V29p5SR854Q5aSX6CSpwLis6cjnvKJYpTgdrsBVEq0CPAOYSIMLoWqdJEKa9V9MhL5Zn46mkN
 +NNkp62WA27eJZZe4DJkC4DPLDFYGwgzz0hQ0oGd9ZA1or01SFB5TydNvBTlT79Ld1bxHANQ/
 qeFJzp9zcOr7lDKRyxZG/Ga+mddvBr8h3//x3HD8ztmyYc1lYY6RxH3EA9UaheaAlj9OcduaG
 kfjBEvETzIalZK06VIubgmVlNepKQTxoPYt9yW5M1m8wHOMH1vkE4Bdc7R95JgDaSDx1RuzTc
 Ch5GsyUUyc6+7X7zidHv9orf3JVTqawJfbdW97TgOxSr6Jd6No6UTvr44jlVZQM0LETAAd3yA
 BDAgl8jsGfh6HaL0+k2kL6Ycyg/bss24IRSm2JaVryzRgln0eXyiFY1Jdod0FPaHOCcNKY2wP
 E5h79T5vSAuYeZxv9GLoMVbaBNvqE8fVajkMBv3u/XEaVKh/jLfu19J5niNQ3e2ISIDhyZoBJ
 mht6YCHHDBV9++S3G3+tUDqpu4qb5vkbivv5+/pzIM3TQa0ypTSyzKzkzNAmSEmw0KChjfFRn
 PrvP1hFDpg5j8Q8kYI/ZuGUMZmOmYkRA+FdJPUtwNoApILt2phS33J9J6bY46jtMg5A0tfKlV
 ekW+aqpO7tcsg1IkHahOdfD8CNA9xVNn6aqyDTTNFTSL/VjjdVE50vU0Tr4dvqQDgN8uqCaM0
 V9o9LkB5IVG3uNIMo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compiler heuristics for detection of potentially uninitialized variables
may change between compiler versions and enabling link-time optimization
may find new warnings.  Indeed, compiling with gcc 9.2.1 and enabled
link-time optimization feature resulted in a few hits that are fixed by
this patch in the most na=C3=AFve way.  This allows to compile git using t=
he
DEVELOPER=3D1 switch (which sets -Werror) and using the -flto flag.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
=2D--
 builtin/am.c               | 2 +-
 builtin/pack-objects.c     | 2 +-
 bulk-checkin.c             | 2 ++
 fast-import.c              | 3 ++-
 t/helper/test-read-cache.c | 2 +-
 5 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1aea657a7f..ab914fd46e 100644
=2D-- a/builtin/am.c
+++ b/builtin/am.c
@@ -1266,7 +1266,7 @@ static int get_mail_commit_oid(struct object_id *com=
mit_id, const char *mail)
 static void get_commit_info(struct am_state *state, struct commit *commit=
)
 {
 	const char *buffer, *ident_line, *msg;
-	size_t ident_len;
+	size_t ident_len =3D 0;
 	struct ident_split id;

 	buffer =3D logmsg_reencode(commit, NULL, get_commit_output_encoding());
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 76ce906946..d0c03b0e9b 100644
=2D-- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1171,7 +1171,7 @@ static int add_object_entry(const struct object_id *=
oid, enum object_type type,
 {
 	struct packed_git *found_pack =3D NULL;
 	off_t found_offset =3D 0;
-	uint32_t index_pos;
+	uint32_t index_pos =3D 0;

 	display_progress(progress_state, ++nr_seen);

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 39ee7d6107..87fa28c227 100644
=2D-- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -200,6 +200,8 @@ static int deflate_to_pack(struct bulk_checkin_state *=
state,
 	struct hashfile_checkpoint checkpoint;
 	struct pack_idx_entry *idx =3D NULL;

+	checkpoint.offset =3D 0;
+
 	seekback =3D lseek(fd, 0, SEEK_CUR);
 	if (seekback =3D=3D (off_t) -1)
 		return error("cannot find the current offset");
diff --git a/fast-import.c b/fast-import.c
index b44d6a467e..58f73f9105 100644
=2D-- a/fast-import.c
+++ b/fast-import.c
@@ -903,7 +903,8 @@ static int store_object(
 	struct object_entry *e;
 	unsigned char hdr[96];
 	struct object_id oid;
-	unsigned long hdrlen, deltalen;
+	unsigned long hdrlen;
+	unsigned long deltalen =3D 0;
 	git_hash_ctx c;
 	git_zstream s;

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 7e79b555de..ef0963e2f4 100644
=2D-- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -4,7 +4,7 @@

 int cmd__read_cache(int argc, const char **argv)
 {
-	int i, cnt =3D 1, namelen;
+	int i, cnt =3D 1, namelen =3D 0;
 	const char *name =3D NULL;

 	if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=3D", &name)) {
=2D-
2.23.0.38.g7ab3f3815a

