Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE707C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FECC20719
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ECglwAyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgIJRCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:02:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61756 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgIJRCb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 13:02:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 721E076059;
        Thu, 10 Sep 2020 13:02:05 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=BBKjwfiyvzXymCBJWHU88ABwe
        eM=; b=ECglwAyVyvvbJ/YofmhIWr9PYk/ja66cTxgu5D/forVuBQ8qyta10A4GG
        3VBfyUkoLU8GdzbNd8ecEMOmlsOSxRUxe+YvBKnCZvi4rxd2v8xcjZkrlltpzBvM
        6DNA2vR7SHBQDcGQuSzyvFAOiebLTjPNGUPrykFpWRB387Ygh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=x9arM5WZJ84hACXluqc
        8DmsXMTXP5PyCk77Mm0zlC/Lh1t4R6iLL5hzapipbCYefeQzQopMFfYyUcYcrnUU
        /x14jpwFTbxiWO/nvh+RPl7ZXQOZAM2jPPMAEeKOY+tEGpzQcK2t374l9RtUoGBv
        1U0tVY54DlLcqD5FoOz5UQAU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6826576058;
        Thu, 10 Sep 2020 13:02:05 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 929F776055;
        Thu, 10 Sep 2020 13:02:04 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 1/7] quote_path: rename quote_path_relative() to quote_path()
Date:   Thu, 10 Sep 2020 10:01:53 -0700
Message-Id: <20200910170159.1278781-2-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-603-ga98dad7d4d
In-Reply-To: <20200910170159.1278781-1-gitster@pobox.com>
References: <20200908205224.4126551-1-gitster@pobox.com>
 <20200910170159.1278781-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 5A1C5694-F387-11EA-8389-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no quote_path_absolute() or anything that causes confusion,
and one of the two large consumers already rename the long name
locally with a preprocessor macro.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clean.c | 22 +++++++++++-----------
 builtin/grep.c  |  2 +-
 quote.c         |  3 +--
 quote.h         |  3 +--
 wt-status.c     |  2 --
 5 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index e53ea52d89..dee44fff6e 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -162,7 +162,7 @@ static int remove_dirs(struct strbuf *path, const cha=
r *prefix, int force_flag,
 	if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
 	    is_nonbare_repository_dir(path)) {
 		if (!quiet) {
-			quote_path_relative(path->buf, prefix, &quoted);
+			quote_path(path->buf, prefix, &quoted);
 			printf(dry_run ?  _(msg_would_skip_git_dir) : _(msg_skip_git_dir),
 					quoted.buf);
 		}
@@ -177,7 +177,7 @@ static int remove_dirs(struct strbuf *path, const cha=
r *prefix, int force_flag,
 		res =3D dry_run ? 0 : rmdir(path->buf);
 		if (res) {
 			int saved_errno =3D errno;
-			quote_path_relative(path->buf, prefix, &quoted);
+			quote_path(path->buf, prefix, &quoted);
 			errno =3D saved_errno;
 			warning_errno(_(msg_warn_remove_failed), quoted.buf);
 			*dir_gone =3D 0;
@@ -202,7 +202,7 @@ static int remove_dirs(struct strbuf *path, const cha=
r *prefix, int force_flag,
 			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
 				ret =3D 1;
 			if (gone) {
-				quote_path_relative(path->buf, prefix, &quoted);
+				quote_path(path->buf, prefix, &quoted);
 				string_list_append(&dels, quoted.buf);
 			} else
 				*dir_gone =3D 0;
@@ -210,11 +210,11 @@ static int remove_dirs(struct strbuf *path, const c=
har *prefix, int force_flag,
 		} else {
 			res =3D dry_run ? 0 : unlink(path->buf);
 			if (!res) {
-				quote_path_relative(path->buf, prefix, &quoted);
+				quote_path(path->buf, prefix, &quoted);
 				string_list_append(&dels, quoted.buf);
 			} else {
 				int saved_errno =3D errno;
-				quote_path_relative(path->buf, prefix, &quoted);
+				quote_path(path->buf, prefix, &quoted);
 				errno =3D saved_errno;
 				warning_errno(_(msg_warn_remove_failed), quoted.buf);
 				*dir_gone =3D 0;
@@ -238,7 +238,7 @@ static int remove_dirs(struct strbuf *path, const cha=
r *prefix, int force_flag,
 			*dir_gone =3D 1;
 		else {
 			int saved_errno =3D errno;
-			quote_path_relative(path->buf, prefix, &quoted);
+			quote_path(path->buf, prefix, &quoted);
 			errno =3D saved_errno;
 			warning_errno(_(msg_warn_remove_failed), quoted.buf);
 			*dir_gone =3D 0;
@@ -266,7 +266,7 @@ static void pretty_print_dels(void)
 	struct column_options copts;
=20
 	for_each_string_list_item(item, &del_list) {
-		qname =3D quote_path_relative(item->string, NULL, &buf);
+		qname =3D quote_path(item->string, NULL, &buf);
 		string_list_append(&list, qname);
 	}
=20
@@ -753,7 +753,7 @@ static int ask_each_cmd(void)
 	for_each_string_list_item(item, &del_list) {
 		/* Ctrl-D should stop removing files */
 		if (!eof) {
-			qname =3D quote_path_relative(item->string, NULL, &buf);
+			qname =3D quote_path(item->string, NULL, &buf);
 			/* TRANSLATORS: Make sure to keep [y/N] as is */
 			printf(_("Remove %s [y/N]? "), qname);
 			if (git_read_line_interactively(&confirm) =3D=3D EOF) {
@@ -1047,19 +1047,19 @@ int cmd_clean(int argc, const char **argv, const =
char *prefix)
 			if (remove_dirs(&abs_path, prefix, rm_flags, dry_run, quiet, &gone))
 				errors++;
 			if (gone && !quiet) {
-				qname =3D quote_path_relative(item->string, NULL, &buf);
+				qname =3D quote_path(item->string, NULL, &buf);
 				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 			}
 		} else {
 			res =3D dry_run ? 0 : unlink(abs_path.buf);
 			if (res) {
 				int saved_errno =3D errno;
-				qname =3D quote_path_relative(item->string, NULL, &buf);
+				qname =3D quote_path(item->string, NULL, &buf);
 				errno =3D saved_errno;
 				warning_errno(_(msg_warn_remove_failed), qname);
 				errors++;
 			} else if (!quiet) {
-				qname =3D quote_path_relative(item->string, NULL, &buf);
+				qname =3D quote_path(item->string, NULL, &buf);
 				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 			}
 		}
diff --git a/builtin/grep.c b/builtin/grep.c
index f58979bc3f..9a91ad643a 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -319,7 +319,7 @@ static void grep_source_name(struct grep_opt *opt, co=
nst char *filename,
 	}
=20
 	if (opt->relative && opt->prefix_length)
-		quote_path_relative(filename + tree_name_len, opt->prefix, out);
+		quote_path(filename + tree_name_len, opt->prefix, out);
 	else
 		quote_c_style(filename + tree_name_len, out, NULL, 0);
=20
diff --git a/quote.c b/quote.c
index ced0245e80..7bb519c1a7 100644
--- a/quote.c
+++ b/quote.c
@@ -352,8 +352,7 @@ void write_name_quoted_relative(const char *name, con=
st char *prefix,
 }
=20
 /* quote path as relative to the given prefix */
-char *quote_path_relative(const char *in, const char *prefix,
-			  struct strbuf *out)
+char *quote_path(const char *in, const char *prefix, struct strbuf *out)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	const char *rel =3D relative_path(in, prefix, &sb);
diff --git a/quote.h b/quote.h
index fa09309cf6..837cb42a71 100644
--- a/quote.h
+++ b/quote.h
@@ -72,8 +72,7 @@ void write_name_quoted_relative(const char *name, const=
 char *prefix,
 				FILE *fp, int terminator);
=20
 /* quote path as relative to the given prefix */
-char *quote_path_relative(const char *in, const char *prefix,
-			  struct strbuf *out);
+char *quote_path(const char *in, const char *prefix, struct strbuf *out)=
;
=20
 /* quoting as a string literal for other languages */
 void perl_quote_buf(struct strbuf *sb, const char *src);
diff --git a/wt-status.c b/wt-status.c
index bb0f9120de..6b87592856 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -259,8 +259,6 @@ static void wt_longstatus_print_trailer(struct wt_sta=
tus *s)
 	status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 }
=20
-#define quote_path quote_path_relative
-
 static const char *wt_status_unmerged_status_string(int stagemask)
 {
 	switch (stagemask) {
--=20
2.28.0-603-ga98dad7d4d

