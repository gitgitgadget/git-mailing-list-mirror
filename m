Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7E5C7EE23
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 23:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjFGXCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjFGXCR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 19:02:17 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373F51FDF
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 16:02:16 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-565ba53f434so88366867b3.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 16:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686178935; x=1688770935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mJsxXj/8PnDgEzdnbn/jHRrCfBggVONqaE79r5ojXjw=;
        b=sGLhKForDmOC/eWOceLTapoHPnoQMm4ZVvQ2ZvBjUjYF7HhEyzO3ok5LXgs+c4Clfn
         XGHnR22o3NPbSXvh7eEc1mLUWN4vcdoWipMOV2wDng2mGTyVhcJJ5Zty6xe6Sjz3L+m1
         7547Hec0q0s6HmweLqCJE3o/lOqLoByM96qgkppig7Q172h6Qx3Wh+ariwhV/NwdOTOb
         pywD94zQj+z3XzRXRG/59trBZObrsSwGAGJfSxZZy91yAdqL+Z+J5tzlZpG4X6SjVXI0
         XPTHZJcrPTL9A2EEKSLOZKnDwGJFLxyT90GvyFmhRvwofJjWFF3FpGcivIdNLd55R3bV
         TUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686178935; x=1688770935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJsxXj/8PnDgEzdnbn/jHRrCfBggVONqaE79r5ojXjw=;
        b=hpiJz67C5Ag+mc1Xb0l2FWM1U8VOFDQERY2cgHgFysNlVs0z/hWdO8t7EPECXqP117
         WwlEGk7mfY5qkjA+fdrcGd6kBNFYO+4fSsGb5YI+lC7bvyTw/8hTNWkvdg8Gl5otHwxO
         yh0AnIMlSQkgX8QqcWZZ602q+xTsci9UlmBsaZRoReydxBGWkMUkXoWPXG5lG7yF46DR
         F3nMtMgiw2s6D1xJ+x8knDrn61Dc0kxYB3nIt/2tzN3Zi/qjA6h2cIjVaCkHPAe4rejn
         CK7yZyNhBXRa1MVqYRKlDOUM8waP1G8LzlNUk6QWWEtDUu0GgJBGrR9Wc4YKZfu5q+RG
         9z0g==
X-Gm-Message-State: AC+VfDzPEy0bLU+IJYi+CzMTP+pKJQVy7EIEH7/w+vcVfw3ADTLgHW+H
        qK1CwPLqSrahhjukrqxaD+zusfK4bIWhTk6sW99aTyTT
X-Google-Smtp-Source: ACHHUZ6LPE+9nI72fRSHRs98TJfTnH15EZbhMF27dtPbzFw6I/Uv5sbd0Mt9GVb9yl3T+uw2ofS0Uw==
X-Received: by 2002:a81:53c4:0:b0:561:18c6:528c with SMTP id h187-20020a8153c4000000b0056118c6528cmr8647666ywb.30.1686178934816;
        Wed, 07 Jun 2023 16:02:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m12-20020a819c0c000000b0055a416529bbsm9058ywa.24.2023.06.07.16.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 16:02:14 -0700 (PDT)
Date:   Wed, 7 Jun 2023 19:02:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] shortlog: introduce `--group-filter` to restrict output
Message-ID: <5cec04b65d350ca8b482ca14260ef118341e4039.1686178917.git.me@ttaylorr.com>
References: <cover.1686178917.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1686178917.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes it is useful to ask, "how many commits have I authored or been
mentioned in via the Co-authored-by trailer"? `git shortlog` is a
reasonable tool for this, and the answer can easily be obtained by
running:

    $ git shortlog -ns --group=author --group=trailer:Co-authored-by

and reading off the corresponding value from its output. But what if you
want to know which commits contribute to the above count? You can drop
the `-s` option and parse through the results, but you'll have to skip
past everything you don't want (and stop reading after matching
everything you do want).

That is a script-able task, but it is cumbersome, and potentially very
slow, if there is a large amount of output that does not match the given
query.

Instead, this patch introduces `--group-filter` in order to restrict the
output of `git shortlog` to only matching group(s). Items match if they
are in a group which is strictly equal to one of the specified filters.

This means that you could easily view the hashes of all commits you
either wrote or co-authored with something like:

    $ git shortlog -n --group=author --group=trailer:Co-authored-by \
        --group-filter="$(git config user.name)"

When filtering just by trailers, it is tempting to want to introduce a
new grep mode for matching a given trailer, like `--author=<pattern>`
for matching the author header. But this would not be suitable for the
above, since we want commits which match either the author or the
Co-authored-by trailer, not ones which match both.

An alternative approach might be to implement trailer filtering as
above in revision.c, and show commits matching either the `--author`
value or some hypothetical `--trailer` filter. That would give shortlog
fewer commits, which may improve its performance. But it would restrict
the interpretation of these options to be an OR (i.e. show commits
matching either the `--author` or `--trailer` field).

In fact, this is already not possible to do, since the `--author` and
`--committer` options are documented as:

> Limit the commits output to ones with author/committer header lines
> that match the specified pattern

So introducing another option which changes the behavior of existing
ones is a non-starter.

Instead, `git shortlog` will process more commits than necessary. But
this is a marginal cost, since implementing the hypothetical revision
options from above as an OR would mean that revision.c has to process
every commit anyway.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-shortlog.txt |  5 ++++
 builtin/shortlog.c             | 20 ++++++++++++-
 shortlog.h                     |  2 ++
 t/t4201-shortlog.sh            | 54 ++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 7d0277d033..dab6d09648 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -97,6 +97,11 @@ counts both authors and co-authors.
 If width is `0` (zero) then indent the lines of the output without wrapping
 them.
 
+--group-filter=<group>::
+	Only show output from the given group. If given more than once,
+	show output from any of the previously specified groups. May be
+	cleared with `--no-group-filter`.
+
 <revision-range>::
 	Show only commits in the specified revision range.  When no
 	<revision-range> is specified, it defaults to `HEAD` (i.e. the
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 46f4e0832a..679db22c57 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -365,6 +365,7 @@ void shortlog_init(struct shortlog *log)
 	log->trailers.strdup_strings = 1;
 	log->trailers.cmp = strcasecmp;
 	log->format.strdup_strings = 1;
+	log->group_filter.strdup_strings = 1;
 }
 
 void shortlog_finish_setup(struct shortlog *log)
@@ -377,6 +378,7 @@ void shortlog_finish_setup(struct shortlog *log)
 				   log->email ? "%cN <%cE>" : "%cN");
 
 	string_list_sort(&log->trailers);
+	string_list_sort(&log->group_filter);
 }
 
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
@@ -400,6 +402,8 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 			&parse_wrap_args),
 		OPT_CALLBACK(0, "group", &log, N_("field"),
 			N_("group by field"), parse_group_option),
+		OPT_STRING_LIST(0, "group-filter", &log.group_filter,
+				N_("group"), N_("only show matching groups")),
 		OPT_END(),
 	};
 
@@ -476,6 +480,13 @@ static void add_wrapped_shortlog_msg(struct strbuf *sb, const char *s,
 	strbuf_addch(sb, '\n');
 }
 
+static int want_shortlog_group(struct shortlog *log, const char *group)
+{
+	if (!log->group_filter.nr)
+		return 1;
+	return string_list_has_string(&log->group_filter, group);
+}
+
 void shortlog_output(struct shortlog *log)
 {
 	size_t i, j;
@@ -486,6 +497,9 @@ void shortlog_output(struct shortlog *log)
 		      log->summary ? compare_by_counter : compare_by_list);
 	for (i = 0; i < log->list.nr; i++) {
 		const struct string_list_item *item = &log->list.items[i];
+		if (!want_shortlog_group(log, item->string))
+			goto next;
+
 		if (log->summary) {
 			fprintf(log->file, "%6d\t%s\n",
 				(int)UTIL_TO_INT(item), item->string);
@@ -505,11 +519,15 @@ void shortlog_output(struct shortlog *log)
 					fprintf(log->file, "      %s\n", msg);
 			}
 			putc('\n', log->file);
+		}
+
+next:
+		if (!log->summary) {
+			struct string_list *onelines = item->util;
 			onelines->strdup_strings = 1;
 			string_list_clear(onelines, 0);
 			free(onelines);
 		}
-
 		log->list.items[i].util = NULL;
 	}
 
diff --git a/shortlog.h b/shortlog.h
index 28d04f951a..8ebee0e2d6 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -18,6 +18,8 @@ struct shortlog {
 	int abbrev;
 	struct date_mode date_mode;
 
+	struct string_list group_filter;
+
 	enum {
 		SHORTLOG_GROUP_AUTHOR = (1 << 0),
 		SHORTLOG_GROUP_COMMITTER = (1 << 1),
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 8e4effebdb..0695c42ca8 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -346,6 +346,60 @@ test_expect_success 'shortlog can match multiple groups' '
 	test_cmp expect actual
 '
 
+test_expect_success '--group-filter shows only matching groups (single groups)' '
+	cat >expect <<-\EOF &&
+	     1	A U Thor
+	EOF
+	git shortlog -ns \
+		--group=trailer:another-trailer \
+		--group-filter="A U Thor" \
+		-2 HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--group-filter shows only matching groups (multiple groups)' '
+	cat >expect <<-\EOF &&
+	     2	A U Thor
+	EOF
+	git shortlog -ns \
+		--group=author \
+		--group=trailer:some-trailer \
+		--group=trailer:another-trailer \
+		--group-filter="A U Thor" \
+		-2 HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--group-filter can be specified more than once' '
+	cat >expect <<-\EOF &&
+	     2	User B
+	     1	User A
+	EOF
+	git shortlog -ns \
+		--group=author \
+		--group=trailer:some-trailer \
+		--group=trailer:another-trailer \
+		--group-filter="User A" \
+		--group-filter="User B" \
+		-2 HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-group-filter reset group filters' '
+	cat >expect <<-\EOF &&
+	     2	A U Thor
+	     2	User B
+	     1	User A
+	EOF
+	git shortlog -ns \
+		--group=author \
+		--group=trailer:some-trailer \
+		--group=trailer:another-trailer \
+		--group-filter="A U Thor" --no-group-filter \
+		-2 HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'shortlog can match multiple format groups' '
 	GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME" \
 		git commit --allow-empty -m "identical names" &&
-- 
2.41.0.1.gf123b68cb8

