Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB06C388F7
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 16:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E7A206CB
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 16:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="D0qpQu2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgKIQFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 11:05:41 -0500
Received: from mout.web.de ([212.227.15.4]:43327 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgKIQFl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 11:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1604937935;
        bh=XLHLFQhLcYhCQ/rRkKKFZVb6gbJPgCb8uqO3K3RiLfQ=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=D0qpQu2YC5bzqPGILdEvdlculh3bsD4JalC+vdJE+cJlF6m8lcepPukMl9r/intoX
         4BgNCIXTros91wUDFENUsAmLV2S6M8fITQ66k3xQvpfmGyuLT2fZ3UTvDJbbti9ekZ
         +/lkD8dW12cnhaYboIFKfmoQfm6tHd0+o6/ivjzA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEIQq-1kVWuV2fVY-00FUUK; Mon, 09
 Nov 2020 17:05:35 +0100
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] archive: support compression levels beyond 9
Message-ID: <96e6e2ce-fc7b-1e73-0112-93589b28506d@web.de>
Date:   Mon, 9 Nov 2020 17:05:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8U5IcKCyrErFk9baLn5yeWaf6HglCDWum03J03UrZzVeDZFXnS3
 3f2RLr1PMz1tCFsYickADRWpCV3fUM1rj6tpXvyxHyv+S8K9QTJKCaW5dzSY4m+5shzAZl6
 aB3yioDXcJO2+JLHeytISIhusGCQ5UTUY1nW8IJyJLM87sEhc4hnu0dPQlhR/44A5c0gJGk
 jP4GGUet6OOYgOGIAI2pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZyLxZwx+OaI=:dOL9CWniUAr+i8bafUYomM
 N7AUwGAFBWnhRxT6o7Wu4+sBZct97TwHpj0yHUhrOcurPZxqV3b6GbL3FHh+HkDxzei9lGaQj
 1nTjPB7Nhk+IXtdP2c4XkjgC3ApyyX8pBF/hSJRVajtd9N2h62Thvo1me7jtIB0LUQneZtDgb
 TFyfRal5omMB+vyt+rWFyfsf5ltwfdyuHBw4IFeo4PMCIxVL/FcGe5PKWZKg9eYQHjClubeUw
 e20o8LSHFJESEOIAL+GmnWG0/daGzGwuuvYy5Pkg34xBAiV033ezihMx13VwBXBeKXhyH089n
 DajfuEaptIhYzXbvTXqi0P40TqXBUf8kzlILtvcvRPD9Q04kRn2v6OcjMhIX4VnMgxzUdoPgh
 XXTzv9GNpVM3LpFND0QSKNjoMx6Z+XhfIviCcloP9bhfcwsX8fCHvpr7W9reVImGKXATY24Sq
 auvuoZUqQBMdvPGc3Szt1PP9PYegbinuH6iU5FDqRFUhCyRlPW08IvzQJtnWfCoKGMk8wmAhN
 D3Pb3nAzaKAIes07VeNyL1gtK9qh4w3cLvzPyaM/Ms6GmNiC1et0GBv6ztoilhEycC0VmW416
 tYtbVs/pyL4H7fhwzMiTGT6KRyRTlRUPEbWX4PWY/2F9CAGbhNlnHJpQjaE5jR5jL/zBz4W50
 TMsSSkTHdR9gDqSNy13+8/tvl9csWFufE7xZFub5jzXbEL2ZZggVCbEco1aeIMUe8BVjfAOI/
 54uDBQZMIvk8+gANOmetBfDAeZ5Ra0ncCwuVEzbqy7hcTZOc55E6MkaV51VBvmbFsVGfLy8H8
 X7HIFa92p6r8xgJSic1agxRrwPLMNPG3bHNQRc3uBlXdzNL2CJcXS941LEC8jidUhwPrSy9I0
 8v/qy0lxQYSyLOIMdlnw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compression programs like zip, gzip, bzip2 and xz allow to adjust the
trade-off between CPU cost and size gain with numerical options from -1
for fast compression and -9 for high compression ratio.  zip also
accepts -0 for storing files verbatim.  git archive directly support
these single-digit compression levels for ZIP output and passes them to
filters like gzip.

Zstandard additionally supports compression level options -10 to -19, or
up to -22 with --ultra.  This *seems* to work with git archive in most
cases, e.g. it will produce an archive with -19 without complaining, but
since it only supports single-digit compression level options this is
the same as -1 -9 and thus -9.

Allow git archive to accept multi-digit compression levels to support
the full range supported by zstd.  Explicitly reject them for the ZIP
format, as otherwise deflateInit2() would just fail with a somewhat
cryptic "stream consistency error".

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive-tar.c |  3 ++-
 archive.c     | 26 +++++++++++---------------
 archive.h     |  1 +
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index f1a1447ebd..a971fdc0f6 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -374,7 +374,8 @@ static int tar_filter_config(const char *var, const ch=
ar *value, void *data)
 		ar =3D xcalloc(1, sizeof(*ar));
 		ar->name =3D xmemdupz(name, namelen);
 		ar->write_archive =3D write_tar_filter_archive;
-		ar->flags =3D ARCHIVER_WANT_COMPRESSION_LEVELS;
+		ar->flags =3D ARCHIVER_WANT_COMPRESSION_LEVELS |
+			    ARCHIVER_HIGH_COMPRESSION_LEVELS;
 		ALLOC_GROW(tar_filters, nr_tar_filters + 1, alloc_tar_filters);
 		tar_filters[nr_tar_filters++] =3D ar;
 	}
diff --git a/archive.c b/archive.c
index 3c1541af9e..7a888c5338 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -529,10 +529,12 @@ static int add_file_cb(const struct option *opt, con=
st char *arg, int unset)
 	return 0;
 }

-#define OPT__COMPR(s, v, h, p) \
-	OPT_SET_INT_F(s, NULL, v, h, p, PARSE_OPT_NONEG)
-#define OPT__COMPR_HIDDEN(s, v, p) \
-	OPT_SET_INT_F(s, NULL, v, "", p, PARSE_OPT_NONEG | PARSE_OPT_HIDDEN)
+static int number_callback(const struct option *opt, const char *arg, int=
 unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	*(int *)opt->value =3D strtol(arg, NULL, 10);
+	return 0;
+}

 static int parse_archive_args(int argc, const char **argv,
 		const struct archiver **ar, struct archiver_args *args,
@@ -561,16 +563,8 @@ static int parse_archive_args(int argc, const char **=
argv,
 		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
 			N_("read .gitattributes in working directory")),
 		OPT__VERBOSE(&verbose, N_("report archived files on stderr")),
-		OPT__COMPR('0', &compression_level, N_("store only"), 0),
-		OPT__COMPR('1', &compression_level, N_("compress faster"), 1),
-		OPT__COMPR_HIDDEN('2', &compression_level, 2),
-		OPT__COMPR_HIDDEN('3', &compression_level, 3),
-		OPT__COMPR_HIDDEN('4', &compression_level, 4),
-		OPT__COMPR_HIDDEN('5', &compression_level, 5),
-		OPT__COMPR_HIDDEN('6', &compression_level, 6),
-		OPT__COMPR_HIDDEN('7', &compression_level, 7),
-		OPT__COMPR_HIDDEN('8', &compression_level, 8),
-		OPT__COMPR('9', &compression_level, N_("compress better"), 9),
+		OPT_NUMBER_CALLBACK(&compression_level,
+			N_("set compression level"), number_callback),
 		OPT_GROUP(""),
 		OPT_BOOL('l', "list", &list,
 			N_("list supported archive formats")),
@@ -617,7 +611,9 @@ static int parse_archive_args(int argc, const char **a=
rgv,

 	args->compression_level =3D Z_DEFAULT_COMPRESSION;
 	if (compression_level !=3D -1) {
-		if ((*ar)->flags & ARCHIVER_WANT_COMPRESSION_LEVELS)
+		int levels_ok =3D (*ar)->flags & ARCHIVER_WANT_COMPRESSION_LEVELS;
+		int high_ok =3D (*ar)->flags & ARCHIVER_HIGH_COMPRESSION_LEVELS;
+		if (levels_ok && (compression_level <=3D 9 || high_ok))
 			args->compression_level =3D compression_level;
 		else {
 			die(_("Argument not supported for format '%s': -%d"),
diff --git a/archive.h b/archive.h
index 82b226011a..e3d04e8ab3 100644
=2D-- a/archive.h
+++ b/archive.h
@@ -36,6 +36,7 @@ const char *archive_format_from_filename(const char *fil=
ename);

 #define ARCHIVER_WANT_COMPRESSION_LEVELS 1
 #define ARCHIVER_REMOTE 2
+#define ARCHIVER_HIGH_COMPRESSION_LEVELS 4
 struct archiver {
 	const char *name;
 	int (*write_archive)(const struct archiver *, struct archiver_args *);
=2D-
2.29.2
