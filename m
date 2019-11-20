Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A730C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D9A206F4
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt4xi4/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfKTVSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:18:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44195 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKTVSt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 16:18:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id az9so376296plb.11
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 13:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GJy7X3pKqJj9Y40YvoPbGXtnc6cAxsPSDRUu9ErTuZw=;
        b=Lt4xi4/ahr3QNZoGz8a07zPkmO96gWUt0dqG30FxoPKLKpPB8rzdc6LdurW1bxsJt6
         0B0lv3+zvsWgynh9cxdWEx99SD0fDBb0VQ00gu9ml05nX5PVot249hX+j5bqM9IcVVHh
         wxBPlIc+65nFk66TxoFBe/pLpWV7ZCICMx4T3xuHss2U65DDGYROlG2fZvOnApvsZ/yv
         Rx0Gq3ZGmD1ZDKVqdC23TYEkJsQj66iaaVHry0ilOEMRqhJfoDSLwhPONxO4UYmOJOhD
         1voovW908/mS3tdnukY8Spy6zFxuOLi+yappSKHN3QZrFgHmjMWEHvYyudxrdijpLbEJ
         TMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GJy7X3pKqJj9Y40YvoPbGXtnc6cAxsPSDRUu9ErTuZw=;
        b=tUJ9yDK3cTS4xn8k9v+C6RAjyM4ZnrJZG8Njli/MPzeC2Q49TDHKOFqFbqZMirRodE
         1GzURrZC/Owi04EJg7awqk/J5T8XFi1jYA0WsBbno9b9Z86lh4hKyqSqw3kQ2NHv/ohj
         12mLisKPYi3waMuhUuqVxHbB5fZPwq9NmMYYAea57ZAu/JSWADbS9lg535jTVPiFh8c0
         0GNYosF3dMnkPq9H31AifKKfTxnKPQWOv23CHtdC9OOat/mhlxzGoiaglmvTcFMsm6tz
         26wOeT54QWpjS0cvlRoHlxhKklX+0aLdcAzqUuY/j1xTUWoAqt4BY9U6sDBIJn8/SnYy
         zx9Q==
X-Gm-Message-State: APjAAAXdKo0qXbHJUMWPMmuMN22vl9FGhMr+4rm6RqLxU74PnYwE6oPY
        41m5NyY6fm2VQgeY8YvThX8YTZYC
X-Google-Smtp-Source: APXvYqxkQVP8Q4drKNKDQvh6H/Zd9337nhV6bk965W5PDcvNLaZ4zmjA8Przw88UsHig3RkJFCCSpg==
X-Received: by 2002:a17:90b:d85:: with SMTP id bg5mr6876252pjb.5.1574284727744;
        Wed, 20 Nov 2019 13:18:47 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id c3sm315724pfi.91.2019.11.20.13.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 13:18:47 -0800 (PST)
Date:   Wed, 20 Nov 2019 13:18:45 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 09/10] range-diff: pass through --notes to `git log`
Message-ID: <9c144e14c52ddc5ea3c280d51124fbf56c54c215.1574284470.git.liu.denton@gmail.com>
References: <cover.1574207673.git.liu.denton@gmail.com>
 <cover.1574284470.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574284470.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a commit being range-diff'd has a note attached to it, the note
will be compared as well. However, if a user has multiple notes refs or
if they want to suppress notes from being printed, there is currently no
way to do this.

Pass through `--[no-]notes[=<ref>]` to the `git log` call so that this
option is customizable.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-range-diff.txt |  6 +++-
 builtin/log.c                    |  2 +-
 builtin/range-diff.c             |  6 +++-
 log-tree.c                       |  2 +-
 range-diff.c                     | 15 ++++++----
 range-diff.h                     |  4 ++-
 t/t3206-range-diff.sh            | 47 ++++++++++++++++++++++++++++++++
 7 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 8a6ea2c6c5..a2c25f4490 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -57,6 +57,10 @@ to revert to color all lines according to the outer diff markers
 	See the ``Algorithm`` section below for an explanation why this is
 	needed.
 
+--[no-]notes[=<ref>]::
+	This flag is passed to the `git log` program
+	(see linkgit:git-log[1]) that generates the patches.
+
 <range1> <range2>::
 	Compare the commits specified by the two ranges, where
 	`<range1>` is considered an older version of `<range2>`.
@@ -75,7 +79,7 @@ to revert to color all lines according to the outer diff markers
 linkgit:git-diff[1]), most notably the `--color=[<when>]` and
 `--no-color` options. These options are used when generating the "diff
 between patches", i.e. to compare the author, commit message and diff of
-corresponding old/new commits. There is currently no means to tweak the
+corresponding old/new commits. There is currently no means to tweak most of the
 diff options passed to `git log` when generating those patches.
 
 OUTPUT STABILITY
diff --git a/builtin/log.c b/builtin/log.c
index a26f223ab4..047ac4594d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1189,7 +1189,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 		diff_setup_done(&opts);
 		fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
 		show_range_diff(rev->rdiff1, rev->rdiff2,
-				rev->creation_factor, 1, &opts);
+				rev->creation_factor, 1, &opts, NULL);
 	}
 }
 
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 9202e75544..98acf3533e 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -15,12 +15,16 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 {
 	int creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
 	struct diff_options diffopt = { NULL };
+	struct argv_array other_arg = ARGV_ARRAY_INIT;
 	int simple_color = -1;
 	struct option range_diff_options[] = {
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("Percentage by which creation is weighted")),
 		OPT_BOOL(0, "no-dual-color", &simple_color,
 			    N_("use simple diff colors")),
+		OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
+				  N_("notes"), N_("passed to 'git log'"),
+				  PARSE_OPT_OPTARG),
 		OPT_END()
 	};
 	struct option *options;
@@ -78,7 +82,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	FREE_AND_NULL(options);
 
 	res = show_range_diff(range1.buf, range2.buf, creation_factor,
-			      simple_color < 1, &diffopt);
+			      simple_color < 1, &diffopt, &other_arg);
 
 	strbuf_release(&range1);
 	strbuf_release(&range2);
diff --git a/log-tree.c b/log-tree.c
index 923a299e70..151e12f415 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -770,7 +770,7 @@ void show_log(struct rev_info *opt)
 		opts.use_color = opt->diffopt.use_color;
 		diff_setup_done(&opts);
 		show_range_diff(opt->rdiff1, opt->rdiff2,
-				opt->creation_factor, 1, &opts);
+				opt->creation_factor, 1, &opts, NULL);
 
 		memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
 	}
diff --git a/range-diff.c b/range-diff.c
index 623397221d..f56b4012a2 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -40,7 +40,8 @@ static size_t find_end_of_line(char *buffer, unsigned long size)
  * Reads the patches into a string list, with the `util` field being populated
  * as struct object_id (will need to be free()d).
  */
-static int read_patches(const char *range, struct string_list *list)
+static int read_patches(const char *range, struct string_list *list,
+			struct argv_array *other_arg)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT, contents = STRBUF_INIT;
@@ -61,8 +62,11 @@ static int read_patches(const char *range, struct string_list *list)
 			"--output-indicator-new=>",
 			"--output-indicator-old=<",
 			"--output-indicator-context=#",
-			"--no-abbrev-commit", range,
+			"--no-abbrev-commit",
 			NULL);
+	if (other_arg)
+		argv_array_pushv(&cp.args, other_arg->argv);
+	argv_array_push(&cp.args, range);
 	cp.out = -1;
 	cp.no_stdin = 1;
 	cp.git_cmd = 1;
@@ -502,16 +506,17 @@ static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
 
 int show_range_diff(const char *range1, const char *range2,
 		    int creation_factor, int dual_color,
-		    struct diff_options *diffopt)
+		    struct diff_options *diffopt,
+		    struct argv_array *other_arg)
 {
 	int res = 0;
 
 	struct string_list branch1 = STRING_LIST_INIT_DUP;
 	struct string_list branch2 = STRING_LIST_INIT_DUP;
 
-	if (read_patches(range1, &branch1))
+	if (read_patches(range1, &branch1, other_arg))
 		res = error(_("could not parse log for '%s'"), range1);
-	if (!res && read_patches(range2, &branch2))
+	if (!res && read_patches(range2, &branch2, other_arg))
 		res = error(_("could not parse log for '%s'"), range2);
 
 	if (!res) {
diff --git a/range-diff.h b/range-diff.h
index 08a50b6e98..7d918ab9ed 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -2,6 +2,7 @@
 #define RANGE_DIFF_H
 
 #include "diff.h"
+#include "argv-array.h"
 
 #define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
 
@@ -12,6 +13,7 @@
  */
 int show_range_diff(const char *range1, const char *range2,
 		    int creation_factor, int dual_color,
-		    struct diff_options *diffopt);
+		    struct diff_options *diffopt,
+		    struct argv_array *other_arg);
 
 #endif
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index b936c16dd1..521b4a83ec 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -529,6 +529,53 @@ test_expect_success 'range-diff compares notes by default' '
 	test_cmp expect actual
 '
 
+test_expect_success 'range-diff with --no-notes' '
+	git notes add -m "topic note" topic &&
+	git notes add -m "unmodified note" unmodified &&
+	test_when_finished git notes remove topic unmodified &&
+	git range-diff --no-color --no-notes master..topic master..unmodified \
+		>actual &&
+	cat >expect <<-EOF &&
+	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
+	2:  $(test_oid t2) = 2:  $(test_oid u2) s/4/A/
+	3:  $(test_oid t3) = 3:  $(test_oid u3) s/11/B/
+	4:  $(test_oid t4) = 4:  $(test_oid u4) s/12/B/
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'range-diff with multiple --notes' '
+	git notes --ref=note1 add -m "topic note1" topic &&
+	git notes --ref=note1 add -m "unmodified note1" unmodified &&
+	test_when_finished git notes --ref=note1 remove topic unmodified &&
+	git notes --ref=note2 add -m "topic note2" topic &&
+	git notes --ref=note2 add -m "unmodified note2" unmodified &&
+	test_when_finished git notes --ref=note2 remove topic unmodified &&
+	git range-diff --no-color --notes=note1 --notes=note2 master..topic master..unmodified \
+		>actual &&
+	sed s/Z/\ /g >expect <<-EOF &&
+	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
+	2:  $(test_oid t2) = 2:  $(test_oid u2) s/4/A/
+	3:  $(test_oid t3) = 3:  $(test_oid u3) s/11/B/
+	4:  $(test_oid t4) ! 4:  $(test_oid u4) s/12/B/
+	    @@ Commit message
+	    Z
+	    Z
+	    Z ## Notes (note1) ##
+	    -    topic note1
+	    +    unmodified note1
+	    Z
+	    Z
+	    Z ## Notes (note2) ##
+	    -    topic note2
+	    +    unmodified note2
+	    Z
+	    Z ## file ##
+	    Z@@ file: A
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'format-patch --range-diff compares notes by default' '
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
-- 
2.24.0.450.g7a9a4598a9

