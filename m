Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E84CC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 19:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36A6206F1
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 19:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ukUiBAWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbgKITX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 14:23:57 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53927 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbgKITX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 14:23:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 85036FDA08;
        Mon,  9 Nov 2020 14:23:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=AcGTcTYUeOoE/ORZSQUb2dyX3YY=; b=ukUiBAWTdp3U9Tp+JXSO
        LMHj7KR9zGElNqkI6tyCS92oQ+Lt7MaHRe8ChqH3eyMBMTNYCVSop/GKCJlO/kO1
        iSm35AtGUSLA68PIXsvui75dyL9nnYXbJok9pho/g2zFUfR2vl9yWQLkNS7qUOzF
        dFrlRRb9asMfdsiESdcVbKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=ECmgbcAFPEBVul5c/iDUY6Flxljl9QSCi7hIL8gDmVllSQ
        LfGBnlmqNn/rZdOt8DzdpdsYdPy2Q6jdYSxhLJAyZ/IQo5Wz0UQpf1KjAFCgozHW
        x+BqKA+Nme+SQguiHYTD7rSNM0h0yjvUsYRnKXcWL32PHZc2Z2VnNkB/WV7Xg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7CBC7FDA07;
        Mon,  9 Nov 2020 14:23:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B90E5FDA04;
        Mon,  9 Nov 2020 14:23:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Hu Keping <hukeping@huawei.com>, zhengjunling@huawei.com,
        zhuangbiaowei@huawei.com, Patrick Hemmer <git@stormcloud9.net>,
        Rafael Ascensao <rafa.almas@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2] format-patch: make output filename configurable
References: <20201105201548.2333425-1-hukeping@huawei.com>
        <20201105150149.GA107127@coredump.intra.peff.net>
        <xmqqimajijwa.fsf@gitster.c.googlers.com>
        <xmqqwnyydxaw.fsf@gitster.c.googlers.com>
        <xmqqo8kadu9j.fsf_-_@gitster.c.googlers.com>
        <CAPig+cQAreDJn_tS_K4sR9HwsSVNoFid9sWSdxzwSqkJLRidgQ@mail.gmail.com>
Date:   Mon, 09 Nov 2020 11:23:48 -0800
Message-ID: <xmqqwnyubagr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 185DA1EA-22C1-11EB-AD23-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the past 15 years, we've used the hardcoded 64 as the length
limit of the filename of the output from the "git format-patch"
command.  Since the value is shorter than the 80-column terminal, it
could grow without line wrapping a bit.  At the same time, since the
value is longer than half of the 80-column terminal, we could fit
two or more of them in "ls" output on such a terminal if we allowed
to lower it.

Introduce a new command line option --filename-max-length=<n> and a
new configuration variable format.filenameMaxLength to override the
hardcoded default.

While we are at it, remove a check that the name of output directory
does not exceed PATH_MAX---this check is pointless in that by the
time control reaches the function, the caller would already have
done an equivalent of "mkdir -p", so if the system does not like an
overly long directory name, the control wouldn't have reached here,
and otherwise, we know that the system allowed the output directory
to exist.  In the worst case, we will get an error when we try to
open the output file and handle the error correctly anyway.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Range-diff against v1:
1:  1b012b4164 ! 1:  d1d91e4833 format-patch: make output filename configurable
    @@ Commit message
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    + ## Documentation/config/format.txt ##
    +@@ Documentation/config/format.txt: format.outputDirectory::
    + 	Set a custom directory to store the resulting files instead of the
    + 	current working directory. All directory components will be created.
    + 
    ++format.filenameMaxLength::
    ++	The maximum length of the output filenames generated by the
    ++	`format-patch` command; defaults to 64.  Can be overridden
    ++	by the `--filename-max-length=<n>` command line option.
    ++
    + format.useAutoBase::
    + 	A boolean value which lets you enable the `--base=auto` option of
    + 	format-patch by default. Can also be set to "whenAble" to allow
    +
      ## Documentation/git-format-patch.txt ##
     @@ Documentation/git-format-patch.txt: SYNOPSIS
      		   [--no-notes | --notes[=<ref>]]
    @@ Documentation/git-format-patch.txt: populated with placeholder text.
     +	Instead of the standard 64 bytes, chomp the generated output
     +	filenames at around '<n>' bytes (too short a value will be
     +	silently raised to a reasonable length).  Defaults to the
    -+	value of the `format.filenamemaxlength` configuration
    ++	value of the `format.filenameMaxLength` configuration
     +	variable, or 64 if unconfigured.
     +
      --rfc::
    @@ builtin/log.c
      
      #define MAIL_DEFAULT_WRAP 72
      #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
    -+#define FORMAT_PATCH_NAME_MAX 64
    ++#define FORMAT_PATCH_NAME_MAX_DEFAULT 64
      
      /* Set a default date-time format for git log ("log.date" config variable) */
      static const char *default_date_mode = NULL;
    @@ builtin/log.c: static int decoration_style;
      static int decoration_given;
      static int use_mailmap_config = 1;
      static const char *fmt_patch_subject_prefix = "PATCH";
    -+static int fmt_patch_name_max = FORMAT_PATCH_NAME_MAX;
    ++static int fmt_patch_name_max = FORMAT_PATCH_NAME_MAX_DEFAULT;
      static const char *fmt_pretty;
      
      static const char * const builtin_log_usage[] = {

 Documentation/config/format.txt    |  5 +++
 Documentation/git-format-patch.txt |  8 +++++
 builtin/log.c                      | 22 ++++++++----
 log-tree.c                         |  2 +-
 log-tree.h                         |  1 -
 revision.h                         |  1 +
 t/t4014-format-patch.sh            | 54 ++++++++++++++++++++++++++++++
 7 files changed, 84 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index c2efd8758a..7f6d11b5d5 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -94,6 +94,11 @@ format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
 	current working directory. All directory components will be created.
 
+format.filenameMaxLength::
+	The maximum length of the output filenames generated by the
+	`format-patch` command; defaults to 64.  Can be overridden
+	by the `--filename-max-length=<n>` command line option.
+
 format.useAutoBase::
 	A boolean value which lets you enable the `--base=auto` option of
 	format-patch by default. Can also be set to "whenAble" to allow
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 0f81d0437b..3347702b71 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -28,6 +28,7 @@ SYNOPSIS
 		   [--no-notes | --notes[=<ref>]]
 		   [--interdiff=<previous>]
 		   [--range-diff=<previous> [--creation-factor=<percent>]]
+		   [--filename-max-length=<n>]
 		   [--progress]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
@@ -200,6 +201,13 @@ populated with placeholder text.
 	allows for useful naming of a patch series, and can be
 	combined with the `--numbered` option.
 
+--filename-max-length=<n>::
+	Instead of the standard 64 bytes, chomp the generated output
+	filenames at around '<n>' bytes (too short a value will be
+	silently raised to a reasonable length).  Defaults to the
+	value of the `format.filenameMaxLength` configuration
+	variable, or 64 if unconfigured.
+
 --rfc::
 	Alias for `--subject-prefix="RFC PATCH"`. RFC means "Request For
 	Comments"; use this when sending an experimental patch for
diff --git a/builtin/log.c b/builtin/log.c
index 0a7ed4bef9..861ac17da0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -37,6 +37,7 @@
 
 #define MAIL_DEFAULT_WRAP 72
 #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
+#define FORMAT_PATCH_NAME_MAX_DEFAULT 64
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -50,6 +51,7 @@ static int decoration_style;
 static int decoration_given;
 static int use_mailmap_config = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
+static int fmt_patch_name_max = FORMAT_PATCH_NAME_MAX_DEFAULT;
 static const char *fmt_pretty;
 
 static const char * const builtin_log_usage[] = {
@@ -150,6 +152,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	rev->abbrev_commit = default_abbrev_commit;
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
+	rev->patch_name_max = fmt_patch_name_max;
 	rev->show_signature = default_show_signature;
 	rev->encode_email_headers = default_encode_email_headers;
 	rev->diffopt.flags.allow_textconv = 1;
@@ -454,6 +457,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return git_config_string(&fmt_pretty, var, value);
 	if (!strcmp(var, "format.subjectprefix"))
 		return git_config_string(&fmt_patch_subject_prefix, var, value);
+	if (!strcmp(var, "format.filenamemaxlength")) {
+		fmt_patch_name_max = git_config_int(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "format.encodeemailheaders")) {
 		default_encode_email_headers = git_config_bool(var, value);
 		return 0;
@@ -955,15 +962,9 @@ static int open_next_file(struct commit *commit, const char *subject,
 			 struct rev_info *rev, int quiet)
 {
 	struct strbuf filename = STRBUF_INIT;
-	int suffix_len = strlen(rev->patch_suffix) + 1;
 
 	if (output_directory) {
 		strbuf_addstr(&filename, output_directory);
-		if (filename.len >=
-		    PATH_MAX - FORMAT_PATCH_NAME_MAX - suffix_len) {
-			strbuf_release(&filename);
-			return error(_("name of output directory is too long"));
-		}
 		strbuf_complete(&filename, '/');
 	}
 
@@ -1751,6 +1752,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("start numbering patches at <n> instead of 1")),
 		OPT_INTEGER('v', "reroll-count", &reroll_count,
 			    N_("mark the series as Nth re-roll")),
+		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
+			    N_("max length of output filename")),
 		OPT_CALLBACK_F(0, "rfc", &rev, NULL,
 			    N_("Use [RFC PATCH] instead of [PATCH]"),
 			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, rfc_callback),
@@ -1822,6 +1825,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	init_display_notes(&notes_opt);
 	git_config(git_format_config, NULL);
 	repo_init_revisions(the_repository, &rev, prefix);
+	rev.subject_prefix = fmt_patch_subject_prefix;
 	rev.show_notes = show_notes;
 	memcpy(&rev.notes_opt, &notes_opt, sizeof(notes_opt));
 	rev.commit_format = CMIT_FMT_EMAIL;
@@ -1831,7 +1835,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.diff = 1;
 	rev.max_parents = 1;
 	rev.diffopt.flags.recursive = 1;
-	rev.subject_prefix = fmt_patch_subject_prefix;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.def = "HEAD";
 	s_r_opt.revarg_opt = REVARG_COMMITTISH;
@@ -1851,6 +1854,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
 			     PARSE_OPT_KEEP_DASHDASH);
 
+	/* Make sure "0000-$sub.patch" gives non-negative length for $sub */
+	if (fmt_patch_name_max <= strlen("0000-") + strlen(fmt_patch_suffix))
+		fmt_patch_name_max = strlen("0000-") + strlen(fmt_patch_suffix);
+
 	if (cover_from_description_arg)
 		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
 
@@ -1935,6 +1942,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 
 	rev.zero_commit = zero_commit;
+	rev.patch_name_max = fmt_patch_name_max;
 
 	if (!rev.diffopt.flags.text && !no_binary_diff)
 		rev.diffopt.flags.binary = 1;
diff --git a/log-tree.c b/log-tree.c
index 1927f917ce..fd0dde97ec 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -367,7 +367,7 @@ void fmt_output_subject(struct strbuf *filename,
 	const char *suffix = info->patch_suffix;
 	int nr = info->nr;
 	int start_len = filename->len;
-	int max_len = start_len + FORMAT_PATCH_NAME_MAX - (strlen(suffix) + 1);
+	int max_len = start_len + info->patch_name_max - (strlen(suffix) + 1);
 
 	if (0 < info->reroll_count)
 		strbuf_addf(filename, "v%d-", info->reroll_count);
diff --git a/log-tree.h b/log-tree.h
index 8fa79289ec..1e8c91dbf2 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -33,7 +33,6 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     int maybe_multipart);
 void load_ref_decorations(struct decoration_filter *filter, int flags);
 
-#define FORMAT_PATCH_NAME_MAX 64
 void fmt_output_commit(struct strbuf *, struct commit *, struct rev_info *);
 void fmt_output_subject(struct strbuf *, const char *subject, struct rev_info *);
 void fmt_output_email_subject(struct strbuf *, struct rev_info *);
diff --git a/revision.h b/revision.h
index f6bf860d19..086ff10280 100644
--- a/revision.h
+++ b/revision.h
@@ -238,6 +238,7 @@ struct rev_info {
 	const char	*extra_headers;
 	const char	*log_reencode;
 	const char	*subject_prefix;
+	int		patch_name_max;
 	int		no_inline;
 	int		show_log_size;
 	struct string_list *mailmap;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 294e76c860..024c0a026d 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -313,6 +313,60 @@ test_expect_success 'multiple files' '
 	ls patches/0001-Side-changes-1.patch patches/0002-Side-changes-2.patch patches/0003-Side-changes-3-with-n-backslash-n-in-it.patch
 '
 
+test_expect_success 'filename length limit' '
+	test_when_finished "rm -f 000*" &&
+	rm -rf 000[1-9]-*.patch &&
+	for len in 15 25 35
+	do
+		git format-patch --filename-max-length=$len -3 side &&
+		max=$(
+			for patch in 000[1-9]-*.patch
+			do
+				echo "$patch" | wc -c
+			done |
+			sort -nr |
+			head -n 1
+		) &&
+		test $max -le $len || return 1
+	done
+'
+
+test_expect_success 'filename length limit from config' '
+	test_when_finished "rm -f 000*" &&
+	rm -rf 000[1-9]-*.patch &&
+	for len in 15 25 35
+	do
+		git -c format.filenameMaxLength=$len format-patch -3 side &&
+		max=$(
+			for patch in 000[1-9]-*.patch
+			do
+				echo "$patch" | wc -c
+			done |
+			sort -nr |
+			head -n 1
+		) &&
+		test $max -le $len || return 1
+	done
+'
+
+test_expect_success 'filename limit applies only to basename' '
+	test_when_finished "rm -rf patches/" &&
+	rm -rf patches/ &&
+	for len in 15 25 35
+	do
+		git format-patch -o patches --filename-max-length=$len -3 side &&
+		max=$(
+			for patch in patches/000[1-9]-*.patch
+			do
+				echo "${patch#patches/}" | wc -c
+			done |
+			sort -nr |
+			head -n 1
+		) &&
+		test $max -le $len || return 1
+	done
+'
+
 test_expect_success 'reroll count' '
 	rm -fr patches &&
 	git format-patch -o patches --cover-letter --reroll-count 4 master..side >list &&
-- 
2.29.2-306-gddee074d3d

