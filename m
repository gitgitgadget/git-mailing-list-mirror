Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2F2C6FA8B
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 06:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiIVGTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 02:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiIVGTS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 02:19:18 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35918B6010
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 23:18:55 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id b5so21850pgb.6
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 23:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=chNhfoJUKTgkgeLjjbU0hz85UHG0I1fi81hkgBF5Z1s=;
        b=tJ36hB+k6yEqyBOdADBmO3hU98aoUq0H7TLEKxJ5UBWLmFffOUOLrRK+rdNVhswYV+
         9iUdMxz0+tf5xsMpc5LEG/niVaZ32ntnGR/Q3wCBAtz/6G3iUyB6EgA7yV2oVchO66rH
         ymp05OM4pEDRa0PSqSJxByc7BAAEant68IlmdWJuRdc4Mb1kbnlmi8Hc3pa7SrLsRRBR
         37CVaOfv3Av/3bs5YZIsjcA5xbFq0Pzb949A2WOoHFDCgLJYQ6G/DNYaTo+YzNXmVURo
         +WZ5U6MdTJCSs+ZMLm8BPCPCf6lzYdRrpi4Kmr2kHnAm8uK8K9Hmf/WR3tjvffI++3cH
         mvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=chNhfoJUKTgkgeLjjbU0hz85UHG0I1fi81hkgBF5Z1s=;
        b=z7fnvanF9pQBV0DSw2grd4ICbATMgOHbM/0JamgZPfLOtykPnIJWMoFIBH+1G8N5vn
         uv576H5FV9i8z5gbVo6jDry/Yp7lamfMUIu2/rmoDB532EYqeA2v5Yf1fkPLGGjjDh1v
         xQsqXmnUx4CSHit9cIOcudz2OAR+1iR9KlhgycOEU+3pC268odcB/q3RIU9X+yU+dJwd
         svQFQ+okc3+nTWkW5Vvl+lET5DvDIDLNd2Vq79kEYkv+kQSansGrj727fECYDyj4c9hg
         VMtrwK1px3eUPPGQQ6WN3pUizmAxg+PAPsVeZKl67tHqt0kAYzRS/KzhBOWeqdjhsFRe
         PSWA==
X-Gm-Message-State: ACrzQf2tHelwXPWDgEi/WkNEEPfgRUpKZueV9GoP7F3laa/tTkR+c2BH
        2hxoaZYIJE1HJm3rC2LQgr1yZSER24XoxRKY
X-Google-Smtp-Source: AMsMyM5vkecdmwoqZxsrDzz2RDvR2uufhtGwYnmuGvGmo0JAuXKm17zA+sPI9/vlmmitnsX8q007zA==
X-Received: by 2002:a63:2014:0:b0:43b:f4a2:fff5 with SMTP id g20-20020a632014000000b0043bf4a2fff5mr1690938pgg.328.1663827529207;
        Wed, 21 Sep 2022 23:18:49 -0700 (PDT)
Received: from localhost.localdomain ([2600:8801:9c0a:f300:449a:6533:97b5:bdb6])
        by smtp.gmail.com with ESMTPSA id f126-20020a623884000000b0052e987c64efsm3420305pfa.174.2022.09.21.23.18.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2022 23:18:48 -0700 (PDT)
From:   Jacob Stopak <jacob@initialcommit.io>
To:     git@vger.kernel.org
Cc:     Jacob Stopak <jacob@initialcommit.io>
Subject: [RFC PATCH] shortlog: add group-by options for year and month
Date:   Wed, 21 Sep 2022 23:18:24 -0700
Message-Id: <20220922061824.16988-1-jacob@initialcommit.io>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can be useful to group commits using time-based attributes in
addition to author/committer. Currently, this can somewhat be
accomplished using "git shortlog --since=x --until=y", however
all commits will be displayed in that single time chunk, grouped
by author.

However, much more versatile time groupings can be achieved by adding
options to group by year or month. This can lead to more interesting
commit summaries breaking down the commits an author made during each
year or month, using something like:

"git shortlog --group=month --group=author --author=Stopak"

Shorthand flags added for month grouping are "-m" or "--month", and for
year groupings are "-y" or "--year".

Note that if grouped _only_ by month or year (with no "--group=author"
option), shortlog will group commits made by ALL authors during each time
period.

It turns out that combining these with existing flags "-s" or "-n" or
both leads to various useful grouped commit summaries which can be
ordered chronologically (default) or based on number of commits during
each time period (when the "-n" flag is added).

Furthermore, these new groupings can be combined with "--since" or
"--until" to generate yearly or monthly groupings within those
overarching time slices.

Since the year and/or month part used for grouping comes directly
from each commit, and commits are already being parsed by the existing
shortlog logic, I don't think adding these new flags should have a
noticeable performance impact. The only added time should be to format
the month or year into the shortlog messages. The ordering was already
handled by the existing shortlog output logic.

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
Considering this is my first (rfc) patch that actually touches code,
I figured I'd mention a few things I'm not totally sure about.

First is my usage of "strbuf" and associated functions, especially my
guess at an initial buffer size of 100 bytes.

Second is my direct usage of functions localtime_r(), strftime(), and
snprintf(). I searched around a bit for non-static api functions to use
instead, but maybe I missed the right ones to use.

Oh and third, for documentation, I updated "git-shortlog.txt", but
wasn't able to test "git help shortlog" locally and see the updates. Is
there a way to make that work locally or did I miss a step somewhere?

One last note - I added some curly braces for consistency on an if/else
block related to some code that I touched.

-Jack

 Documentation/git-shortlog.txt | 10 +++++
 builtin/shortlog.c             | 82 +++++++++++++++++++++++++++++-----
 shortlog.h                     |  2 +
 t/t4201-shortlog.sh            | 42 +++++++++++++++++
 4 files changed, 126 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index f64e77047b..ab68b287d8 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -54,6 +54,8 @@ OPTIONS
 --
  - `author`, commits are grouped by author
  - `committer`, commits are grouped by committer (the same as `-c`)
+ - `month`, commits are grouped by month (the same as `-m`)
+ - `year`, commits are grouped by year (the same as `-y`)
  - `trailer:<field>`, the `<field>` is interpreted as a case-insensitive
    commit message trailer (see linkgit:git-interpret-trailers[1]). For
    example, if your project uses `Reviewed-by` trailers, you might want
@@ -80,6 +82,14 @@ counts both authors and co-authors.
 --committer::
 	This is an alias for `--group=committer`.
 
+-m::
+--month::
+	This is an alias for `--group=month`.
+
+-y::
+--year::
+	This is an alias for `--group=year`.
+
 -w[<width>[,<indent1>[,<indent2>]]]::
 	Linewrap the output by wrapping each line at `width`.  The first
 	line of each entry is indented by `indent1` spaces, and the second
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 7a1e1fe7c0..99592f1c59 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -133,6 +133,10 @@ static void read_from_stdin(struct shortlog *log)
 		break;
 	case SHORTLOG_GROUP_TRAILER:
 		die(_("using --group=trailer with stdin is not supported"));
+	case SHORTLOG_GROUP_YEAR:
+		die(_("using --group=year with stdin is not supported"));
+	case SHORTLOG_GROUP_MONTH:
+		die(_("using --group=month with stdin is not supported"));
 	default:
 		BUG("unhandled shortlog group");
 	}
@@ -200,10 +204,29 @@ static void insert_records_from_trailers(struct shortlog *log,
 	unuse_commit_buffer(commit, commit_buffer);
 }
 
+static void format_commit_date(struct commit *commit, struct strbuf *sb,
+			       char *format, struct shortlog *log)
+{
+	time_t t = (time_t) commit->date;
+	struct tm commit_date;
+	localtime_r(&t, &commit_date);
+
+	if (log->groups & SHORTLOG_GROUP_MONTH) {
+        	strftime(sb->buf, strbuf_avail(sb), "%Y/%m", &commit_date);
+		snprintf(sb->buf+7, strbuf_avail(sb), "%s", format);
+	} else if (log->groups & SHORTLOG_GROUP_YEAR) {
+        	strftime(sb->buf, strbuf_avail(sb), "%Y", &commit_date);
+		snprintf(sb->buf+4, strbuf_avail(sb), "%s", format);
+	}
+}
+
 void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 {
 	struct strbuf ident = STRBUF_INIT;
 	struct strbuf oneline = STRBUF_INIT;
+	struct strbuf buffer;
+	strbuf_init(&buffer, 100);
+
 	struct strset dups = STRSET_INIT;
 	struct pretty_print_context ctx = {0};
 	const char *oneline_str;
@@ -222,20 +245,47 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	}
 	oneline_str = oneline.len ? oneline.buf : "<none>";
 
+	if ((log->groups & SHORTLOG_GROUP_MONTH) && (log->groups & SHORTLOG_GROUP_YEAR))
+		log->groups ^= SHORTLOG_GROUP_YEAR;
+
+	if (((log->groups & SHORTLOG_GROUP_MONTH) || (log->groups & SHORTLOG_GROUP_YEAR))
+	      && !HAS_MULTI_BITS(log->groups)) {
+		format_commit_date(commit, &buffer, "", log);
+		format_commit_message(commit, 
+                                      buffer.buf, 
+                                      &ident, &ctx);
+
+		if (strset_add(&dups, ident.buf))
+			insert_one_record(log, ident.buf, oneline_str);
+	}
 	if (log->groups & SHORTLOG_GROUP_AUTHOR) {
 		strbuf_reset(&ident);
-		format_commit_message(commit,
-				      log->email ? "%aN <%aE>" : "%aN",
-				      &ident, &ctx);
+		if ((log->groups & SHORTLOG_GROUP_MONTH) || (log->groups & SHORTLOG_GROUP_YEAR)) {
+			format_commit_date(commit, &buffer, log->email ? " %aN <%aE>" : " %aN", log);
+			format_commit_message(commit,
+					      buffer.buf,
+					      &ident, &ctx);
+		} else {
+			format_commit_message(commit,
+					      log->email ? "%aN <%aE>" : "%aN",
+					      &ident, &ctx);
+		}
 		if (!HAS_MULTI_BITS(log->groups) ||
 		    strset_add(&dups, ident.buf))
 			insert_one_record(log, ident.buf, oneline_str);
 	}
 	if (log->groups & SHORTLOG_GROUP_COMMITTER) {
 		strbuf_reset(&ident);
-		format_commit_message(commit,
-				      log->email ? "%cN <%cE>" : "%cN",
-				      &ident, &ctx);
+		if ((log->groups & SHORTLOG_GROUP_MONTH) || (log->groups & SHORTLOG_GROUP_YEAR)) {
+			format_commit_date(commit, &buffer, log->email ? " %cN <%cE>" : " %cN", log);
+			format_commit_message(commit,
+					      buffer.buf,
+					      &ident, &ctx);
+		} else {
+			format_commit_message(commit,
+				      	      log->email ? "%cN <%cE>" : "%cN",
+				      	      &ident, &ctx);
+		}
 		if (!HAS_MULTI_BITS(log->groups) ||
 		    strset_add(&dups, ident.buf))
 			insert_one_record(log, ident.buf, oneline_str);
@@ -247,6 +297,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	strset_clear(&dups);
 	strbuf_release(&ident);
 	strbuf_release(&oneline);
+	strbuf_release(&buffer);
 }
 
 static void get_from_rev(struct rev_info *rev, struct shortlog *log)
@@ -314,15 +365,20 @@ static int parse_group_option(const struct option *opt, const char *arg, int uns
 	if (unset) {
 		log->groups = 0;
 		string_list_clear(&log->trailers, 0);
-	} else if (!strcasecmp(arg, "author"))
+	} else if (!strcasecmp(arg, "author")) {
 		log->groups |= SHORTLOG_GROUP_AUTHOR;
-	else if (!strcasecmp(arg, "committer"))
+	} else if (!strcasecmp(arg, "committer")) {
 		log->groups |= SHORTLOG_GROUP_COMMITTER;
-	else if (skip_prefix(arg, "trailer:", &field)) {
+	} else if (skip_prefix(arg, "trailer:", &field)) {
 		log->groups |= SHORTLOG_GROUP_TRAILER;
 		string_list_append(&log->trailers, field);
-	} else
+	} else if (!strcasecmp(arg, "month")) {
+		log->groups |= SHORTLOG_GROUP_MONTH;
+	} else if (!strcasecmp(arg, "year")) {
+		log->groups |= SHORTLOG_GROUP_YEAR;
+	} else {
 		return error(_("unknown group type: %s"), arg);
+	}
 
 	return 0;
 }
@@ -363,6 +419,12 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 			&parse_wrap_args),
 		OPT_CALLBACK(0, "group", &log, N_("field"),
 			N_("group by field"), parse_group_option),
+		OPT_BIT('m', "month", &log.groups,
+                         N_("group by month rather than author"),
+                         SHORTLOG_GROUP_MONTH),
+		OPT_BIT('y', "year", &log.groups,
+                          N_("group by year rather than author"),
+                          SHORTLOG_GROUP_YEAR),
 		OPT_END(),
 	};
 
diff --git a/shortlog.h b/shortlog.h
index 3f7e9aabca..45b5efb6dc 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -20,6 +20,8 @@ struct shortlog {
 		SHORTLOG_GROUP_AUTHOR = (1 << 0),
 		SHORTLOG_GROUP_COMMITTER = (1 << 1),
 		SHORTLOG_GROUP_TRAILER = (1 << 2),
+		SHORTLOG_GROUP_MONTH = (1 << 3),
+		SHORTLOG_GROUP_YEAR = (1 << 4),
 	} groups;
 	struct string_list trailers;
 
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 3095b1b2ff..981f45f732 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -359,4 +359,46 @@ test_expect_success 'stdin with multiple groups reports error' '
 	test_must_fail git shortlog --group=author --group=committer <log
 '
 
+test_expect_success '--group=year groups output by year' '
+	git commit --allow-empty -m "git shortlog --group=year test" &&
+	cat >expect <<-\EOF &&
+	     1	2005
+	EOF
+	git shortlog -ns \
+		--group=year \
+		-1 HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin with --group=year reports error' '
+	test_must_fail git shortlog --group=year
+'
+
+test_expect_success '--group=month groups output by month' '
+	git commit --allow-empty -m "git shortlog --group=month test" &&
+	cat >expect <<-\EOF &&
+	     1	2005/04
+	EOF
+	git shortlog -ns \
+		--group=month \
+		-1 HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin with --group=month reports error' '
+	test_must_fail git shortlog --group=month
+'
+
+test_expect_success '--group=month and --group=year defaults to month' '
+	git commit --allow-empty -m "git shortlog --group=month --group=year test" &&
+	cat >expect <<-\EOF &&
+	     1	2005/04
+	EOF
+	git shortlog -ns \
+		--group=month \
+		--group=year \
+		-1 HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: dda7228a83e2e9ff584bf6adbf55910565b41e14
-- 
2.37.3

