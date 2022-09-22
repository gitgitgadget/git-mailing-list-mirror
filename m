Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B16C54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 23:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiIVX03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 19:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiIVX01 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 19:26:27 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DB510BB3D
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 16:26:26 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 207so10660928pgc.7
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 16:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rsfIm759xZpL5nrs6Bgi1icEW4q/Eb9Jojx4CPdoj1U=;
        b=buUiWc5wMBS13abqWgSHI2lP/gewfL4kPTIT8oOpCCmNg12Ck4BpQ9vlk7/KUUKUmr
         W01jyOozR0U6vnE/JUWSb0056W4EvAS3Dc06Y9vHlz4fxkRFI0SfLUCoJCVqr7WEHcS4
         IPST4Wh+XtXBu46Sqx7YR2ocXf3cgoBJ5vzw6alFHWrrmO56cNuWogSaxuEn6d3zWgeb
         /JkfZ2+UK1pfPjCW7f9qei6MBBELfnA/Srb0N3R7yI16N3tbW0jpKyjeWWuPMYr7mnIL
         WWd/jHafmpkN3YS+t6WtBep41qAPHsG404sMb9xtCBE9YhfOh92YVEEyMYI6OjWi4Sqj
         YtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rsfIm759xZpL5nrs6Bgi1icEW4q/Eb9Jojx4CPdoj1U=;
        b=d59XZr/8EwCQN2+1sHpcNvfWXeatEHL/UZ3PyuNzBNaUvVmD6oyH6W0vbmWYlZM6cF
         dRUGSpUeCdGc56HRYyOUgwYJSdfIGtBTjbvNaGbPrem6lQRIPgHRCgOyjb6YveDCR9vf
         /7e5gJTHNNiDUU+1gSaVKzHMB6FaQOX4MNg7HQllKgohRbU3oNTyQamcaeLItK/gUt2h
         1/vHQrSEnTQkgSgPwljEMoA6URnn2hBIReHvX/N3lF0wZswCz60ebsd2oJg7drzySp6F
         5fy0z9xhHc+pybgf9Ha0nDDEQD8/zdc591dlRGYZeEzqNG+0K+mV568aVutLLyowGi25
         3dyw==
X-Gm-Message-State: ACrzQf1QjStdMO6yaMEhtcWYCkwq/4p/NiLBaT5pOoAeFxTtjmTeJwIk
        Gfdh94wgDYRKtvQn1QacoKKyzQMqG0AxqSkD
X-Google-Smtp-Source: AMsMyM4eBDYf2VvT+YESlrneUHA2PUhEk6AV5g3fvf6bFRbhR/TnjNoQOnMjjBt7M7fkWQSxgCX1+A==
X-Received: by 2002:a63:9141:0:b0:43b:d645:e057 with SMTP id l62-20020a639141000000b0043bd645e057mr5047047pge.225.1663889184807;
        Thu, 22 Sep 2022 16:26:24 -0700 (PDT)
Received: from localhost.localdomain ([2600:8801:9c0a:f300:449a:6533:97b5:bdb6])
        by smtp.gmail.com with ESMTPSA id 65-20020a621744000000b005289a50e4c2sm5048552pfx.23.2022.09.22.16.26.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Sep 2022 16:26:24 -0700 (PDT)
From:   Jacob Stopak <jacob@initialcommit.io>
To:     git@vger.kernel.org
Cc:     Jacob Stopak <jacob@initialcommit.io>, martin.agren@gmail.com
Subject: [RFC PATCH v2] shortlog: add group-by options for year and month
Date:   Thu, 22 Sep 2022 16:25:36 -0700
Message-Id: <20220922232536.40807-1-jacob@initialcommit.io>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922061824.16988-1-jacob@initialcommit.io>
References: <20220922061824.16988-1-jacob@initialcommit.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can be useful to group commits using time-based attributes in
addition to author/committer. Currently, this can somewhat be
done using "git shortlog --since=x --until=y", however all commits
will be displayed in that single time chunk, grouped by author.

However, much more versatile time groupings can be achieved by adding
options to group by year or month. This can lead to more interesting
commit summaries breaking down the commits an author made during each
year or month, using something like:

"git shortlog --group=month --group=author --author=Stopak"

Shorthand flags added for month grouping are "-m" or "--month", and for
year groupings are "-y" or "--year".

If grouped _only_ by month or year (ie no "--group=author" option),
shortlog will group commits made by ALL authors during each time period.

It turns out that combining these with existing flags "-s" or "-n" or
both leads to various useful grouped commit summaries which can be
ordered chronologically (default) or based on number of commits during
each time period (when the "-n" flag is added), as in:

"git shortlog -nsy"

Furthermore, these new groupings can be combined with "--since" or
"--until" to generate yearly or monthly groupings within those
overarching time slices.

Note that (at least for now) using the year and month groupings
are not supported when shortlog is reading from stdin, since the
default log output for date might require some assumptions to reformat
during parsing, mainly regarding the first 2 digits of the year.

Since the year and/or month part used for grouping comes directly
from each commit, and commits are already being parsed by the existing
shortlog logic, I don't think adding these new flags should have a
noticeable performance impact. The only added time should be to format
the month or year into the shortlog messages. The ordering was already
handled by the existing shortlog output logic.

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
Thx a lot for the feedback! Added v2 patch here.

> I would actually skip using/testing `git help` and just go
> straight for the rendered page using, e.g, something like ...

Cool I was able to use your steps to get the local man page working.

> One of the nice things about `--group` is that we can potentially
> have many groupings without having to carry correspondingly many `--option`s.
>
> In particular, it might be wise to wait with implementing `-y` and `-m`
> until we know that your new feature turns out to be so hugely successful
> that people start craving `-m` as a short form for `--group=month`. ;-)

Haha yes I might have gotten a bit excited with the shorthand flags, BUT
let me give my pitch for why I think it makes sense to keep them :)

Adding these new time-based groups makes it more likely that folks will
specify multiple groups at once, (like pairing with "--group=author")
which makes it painful to write "--group=..." over & over again,
especially when running/editing the command many times.

Also, having shorthands -y and -m pairs very nicely when using other
shorthand flags -s, -n, and -c, for stuff like "git shortlog -nsy".

To justify why the new year/month groups should have shorthand flags
while "--group=trailer:value" does not, I'd say that the fact that
trailer requires a custom value would make the shorthand version clunky,
and it wouldn't fit in well with other shorthand options like -n or -s.
Since year/month have no custom value, the flags make a bit more sense
and would match up with how "-c, --committer" currently works.

So overall the shorthand flags can be more convenient in several ways,
which increases the odds folks will use the new feature often :D. Thoughts?

> This trips up `-Werror=declaration-after-statement`. If you build with
> `DEVELOPER=Yes`, you should see the same thing.

Hm, I tried setting the DEVELOPER flag at the top of Makefile, and also
passing as argument to "make DEVELOPER=Yes git-shortlog", but didn't see
those warnings - I'm on a mac fwiw. Anyway I moved the statement after
the declarations so I think it should be fixed.

> I can easily imagine going even more granular with this
> (`--group=week`?), but that can wait for some other time. :-)

I'd love to add a week option in the future if this gets accepted...

> BTW, I got this when `git am`-ing your patch: ...

Fixed those pesky whitespace issues!

 Documentation/git-shortlog.txt | 10 ++++
 builtin/shortlog.c             | 83 ++++++++++++++++++++++++++++++----
 shortlog.h                     |  2 +
 t/t4201-shortlog.sh            | 42 +++++++++++++++++
 4 files changed, 127 insertions(+), 10 deletions(-)

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
index 7a1e1fe7c0..1beba9b91c 100644
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
@@ -200,10 +204,28 @@ static void insert_records_from_trailers(struct shortlog *log,
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
+		strftime(sb->buf, strbuf_avail(sb), "%Y/%m", &commit_date);
+		snprintf(sb->buf+7, strbuf_avail(sb), "%s", format);
+	} else if (log->groups & SHORTLOG_GROUP_YEAR) {
+		strftime(sb->buf, strbuf_avail(sb), "%Y", &commit_date);
+		snprintf(sb->buf+4, strbuf_avail(sb), "%s", format);
+	}
+}
+
 void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 {
 	struct strbuf ident = STRBUF_INIT;
 	struct strbuf oneline = STRBUF_INIT;
+	struct strbuf buffer;
+
 	struct strset dups = STRSET_INIT;
 	struct pretty_print_context ctx = {0};
 	const char *oneline_str;
@@ -214,6 +236,8 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	ctx.date_mode.type = DATE_NORMAL;
 	ctx.output_encoding = get_log_output_encoding();
 
+	strbuf_init(&buffer, 100);
+
 	if (!log->summary) {
 		if (log->user_format)
 			pretty_print_commit(&ctx, commit, &oneline);
@@ -222,20 +246,47 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	}
 	oneline_str = oneline.len ? oneline.buf : "<none>";
 
-	if (log->groups & SHORTLOG_GROUP_AUTHOR) {
-		strbuf_reset(&ident);
+	if ((log->groups & SHORTLOG_GROUP_MONTH) && (log->groups & SHORTLOG_GROUP_YEAR))
+		log->groups ^= SHORTLOG_GROUP_YEAR;
+
+	if (((log->groups & SHORTLOG_GROUP_MONTH) || (log->groups & SHORTLOG_GROUP_YEAR))
+	      && !HAS_MULTI_BITS(log->groups)) {
+		format_commit_date(commit, &buffer, "", log);
 		format_commit_message(commit,
-				      log->email ? "%aN <%aE>" : "%aN",
+				      buffer.buf,
 				      &ident, &ctx);
+
+		if (strset_add(&dups, ident.buf))
+			insert_one_record(log, ident.buf, oneline_str);
+	}
+	if (log->groups & SHORTLOG_GROUP_AUTHOR) {
+		strbuf_reset(&ident);
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
+					      log->email ? "%cN <%cE>" : "%cN",
+					      &ident, &ctx);
+		}
 		if (!HAS_MULTI_BITS(log->groups) ||
 		    strset_add(&dups, ident.buf))
 			insert_one_record(log, ident.buf, oneline_str);
@@ -247,6 +298,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	strset_clear(&dups);
 	strbuf_release(&ident);
 	strbuf_release(&oneline);
+	strbuf_release(&buffer);
 }
 
 static void get_from_rev(struct rev_info *rev, struct shortlog *log)
@@ -314,15 +366,20 @@ static int parse_group_option(const struct option *opt, const char *arg, int uns
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
@@ -363,6 +420,12 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 			&parse_wrap_args),
 		OPT_CALLBACK(0, "group", &log, N_("field"),
 			N_("group by field"), parse_group_option),
+		OPT_BIT('m', "month", &log.groups,
+			N_("group by month rather than author"),
+			SHORTLOG_GROUP_MONTH),
+		OPT_BIT('y', "year", &log.groups,
+			N_("group by year rather than author"),
+			SHORTLOG_GROUP_YEAR),
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
-- 
2.37.3

