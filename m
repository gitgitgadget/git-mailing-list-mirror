Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D12FA373F
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 20:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbiJXUtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbiJXUtV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 16:49:21 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7676B2B76AE
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:56:34 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n73so8459736iod.13
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HG7Zjqk48NTmcEW1096NR7eZ1DiVQhQGPNTDxQKNLgk=;
        b=uL9AkU7Y3ZmSEEAUHie/4+Otr5GKUfigE7wHryC5YdOwToUM7dE/yLT9Kbok9oXLgX
         e23F3qXnK178Fy8rjybc0kUNNtAFWovgvR9V9rvwMXRicOlMG1N8GmHv+bScDnP7jexA
         TibBbMFAzr/UdUiclpdm2Uv/miP3EXRAKcOKHvzdBNkSlI0ainRqWYJze5aPjuKELCQf
         tVqm3asy4VNlHxlHUFN5X3934Etkh+HSLXq2CnXYO4e5LFpvk7VsqhVIT5ol3o1bBuJD
         2rJMjsxTcUw9D+jN20HTu7eyBThzUs/SlyiP5pUK52JLygLLCLF/SGqKVO7UrPBFuHx6
         4r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG7Zjqk48NTmcEW1096NR7eZ1DiVQhQGPNTDxQKNLgk=;
        b=RV96Dhn6QiPdRgm/IgY8EmcNKL6v2GjdtpUnHVX25oAiCTOPwrmEfV4EGqV2xIonsA
         ye/E0/YzcdO/hKc9ERrl45nH6pCsbuFUUOWzaOlsFGxWrOfyTWZvgyHTHwy8qtaNi5YV
         1Gqrztz+JKH9q7B1xsPk/HSdfDtMH97+gwQDsEI4ek6TbJG6+KEQXMcIQGsnuKwLGtYv
         rNeFexaMtAOqeXHEeLDY2746cz1Ksxjccd6gMShU35+WKCMuN4Pro7BKpvtPI+VXNEaF
         kl1BgQ3io+cKdlosbn0/3A80OLxC5bJBUt6BUIayTNPkfe+9/z/4K1SH6bZSFve3/zgg
         5Gxg==
X-Gm-Message-State: ACrzQf1LJrAQH+rBW+8/yWAUnibJPS4iv1qDoR/Q/a617Tag9CP9fHSA
        1OhBm7OFbylixbhSdJISBhzJflnN2ONZctgB
X-Google-Smtp-Source: AMsMyM52BJzRpFqRohkKbmMZUbtGc24BcgyR02gQg3nb7NtqvtvlUM06Ju0Xt6DTi0dJvtxDJ2NLvQ==
X-Received: by 2002:a05:6602:358f:b0:6bc:bc3b:10cd with SMTP id bi15-20020a056602358f00b006bcbc3b10cdmr20031195iob.63.1666637740277;
        Mon, 24 Oct 2022 11:55:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i11-20020a92540b000000b002f6699c86eesm222387ilb.68.2022.10.24.11.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:55:39 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:55:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jacob Stopak <jacob@initialcommit.io>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 4/7] shortlog: support arbitrary commit format `--group`s
Message-ID: <baee19cb8c0375478072ddfce06dc4708a49ef77.1666637725.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666637725.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666637725.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In addition to generating a shortlog based on committer, author, or the
identity in one or more specified trailers, it can be useful to generate
a shortlog based on an arbitrary commit format.

This can be used, for example, to generate a distribution of commit
activity over time, like so:

    $ git shortlog --group='%cd' --date='format:%Y-%m' -s v2.37.0..
       117  2022-06
       274  2022-07
       324  2022-08
       263  2022-09
         7  2022-10

Arbitrary commit formats can be used. In fact, `git shortlog`'s default
behavior (to count by commit authors) can be emulated as follows:

    $ git shortlog --group='%aN <%aE>' ...

and future patches will make the default behavior (as well as
`--committer`, and `--group=trailer:<trailer>`) special cases of the
more flexible `--group` option.

Note also that the SHORTLOG_GROUP_FORMAT enum value is used only to
designate that `--group:<format>` is in use when in stdin mode to
declare that the combination is invalid.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-shortlog.txt |  5 ++++-
 builtin/shortlog.c             | 41 +++++++++++++++++++++++++++++++++-
 shortlog.h                     |  2 ++
 t/t4201-shortlog.sh            | 32 ++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 9ed9d6a9e7..7d0277d033 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -50,7 +50,7 @@ OPTIONS
 --date=<format>::
 	Show dates formatted according to the given date string. (See
 	the `--date` option in the "Commit Formatting" section of
-	linkgit:git-log[1]).
+	linkgit:git-log[1]). Useful with `--group=format:<format>`.
 
 --group=<type>::
 	Group commits based on `<type>`. If no `--group` option is
@@ -64,6 +64,9 @@ OPTIONS
    example, if your project uses `Reviewed-by` trailers, you might want
    to see who has been reviewing with
    `git shortlog -ns --group=trailer:reviewed-by`.
+ - `format:<format>`, any string accepted by the `--format` option of
+   'git log'. (See the "PRETTY FORMATS" section of
+   linkgit:git-log[1].)
 +
 Note that commits that do not include the trailer will not be counted.
 Likewise, commits with multiple trailers (e.g., multiple signoffs) may
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index d0645769d7..f3b237c5ff 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -133,6 +133,8 @@ static void read_from_stdin(struct shortlog *log)
 		break;
 	case SHORTLOG_GROUP_TRAILER:
 		die(_("using %s with stdin is not supported"), "--group=trailer");
+	case SHORTLOG_GROUP_FORMAT:
+		die(_("using %s with stdin is not supported"), "--group=format");
 	default:
 		BUG("unhandled shortlog group");
 	}
@@ -203,6 +205,32 @@ static void insert_records_from_trailers(struct shortlog *log,
 	unuse_commit_buffer(commit, commit_buffer);
 }
 
+static int shortlog_needs_dedup(const struct shortlog *log)
+{
+	return HAS_MULTI_BITS(log->groups) || log->format.nr > 1 || log->trailers.nr;
+}
+
+static void insert_records_from_format(struct shortlog *log,
+				       struct strset *dups,
+				       struct commit *commit,
+				       struct pretty_print_context *ctx,
+				       const char *oneline)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, &log->format) {
+		strbuf_reset(&buf);
+
+		format_commit_message(commit, item->string, &buf, ctx);
+
+		if (!shortlog_needs_dedup(log) || strset_add(dups, buf.buf))
+			insert_one_record(log, buf.buf, oneline);
+	}
+
+	strbuf_release(&buf);
+}
+
 void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 {
 	struct strbuf ident = STRBUF_INIT;
@@ -244,6 +272,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 			insert_one_record(log, ident.buf, oneline_str);
 	}
 	insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
+	insert_records_from_format(log, &dups, commit, &ctx, oneline_str);
 
 	strset_clear(&dups);
 	strbuf_release(&ident);
@@ -315,6 +344,7 @@ static int parse_group_option(const struct option *opt, const char *arg, int uns
 	if (unset) {
 		log->groups = 0;
 		string_list_clear(&log->trailers, 0);
+		string_list_clear(&log->format, 0);
 	} else if (!strcasecmp(arg, "author"))
 		log->groups |= SHORTLOG_GROUP_AUTHOR;
 	else if (!strcasecmp(arg, "committer"))
@@ -322,8 +352,15 @@ static int parse_group_option(const struct option *opt, const char *arg, int uns
 	else if (skip_prefix(arg, "trailer:", &field)) {
 		log->groups |= SHORTLOG_GROUP_TRAILER;
 		string_list_append(&log->trailers, field);
-	} else
+	} else if (skip_prefix(arg, "format:", &field)) {
+		log->groups |= SHORTLOG_GROUP_FORMAT;
+		string_list_append(&log->format, field);
+	} else if (strchr(arg, '%')) {
+		log->groups |= SHORTLOG_GROUP_FORMAT;
+		string_list_append(&log->format, arg);
+	} else {
 		return error(_("unknown group type: %s"), arg);
+	}
 
 	return 0;
 }
@@ -341,6 +378,7 @@ void shortlog_init(struct shortlog *log)
 	log->in2 = DEFAULT_INDENT2;
 	log->trailers.strdup_strings = 1;
 	log->trailers.cmp = strcasecmp;
+	log->format.strdup_strings = 1;
 }
 
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
@@ -481,4 +519,5 @@ void shortlog_output(struct shortlog *log)
 	log->list.strdup_strings = 1;
 	string_list_clear(&log->list, 1);
 	clear_mailmap(&log->mailmap);
+	string_list_clear(&log->format, 0);
 }
diff --git a/shortlog.h b/shortlog.h
index dc388dd459..4850a8c30f 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -22,8 +22,10 @@ struct shortlog {
 		SHORTLOG_GROUP_AUTHOR = (1 << 0),
 		SHORTLOG_GROUP_COMMITTER = (1 << 1),
 		SHORTLOG_GROUP_TRAILER = (1 << 2),
+		SHORTLOG_GROUP_FORMAT = (1 << 3),
 	} groups;
 	struct string_list trailers;
+	struct string_list format;
 
 	int email;
 	struct string_list mailmap;
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 7547da539d..8e4effebdb 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -244,6 +244,26 @@ test_expect_success 'shortlog --group=trailer:signed-off-by' '
 	test_cmp expect actual
 '
 
+test_expect_success 'shortlog --group=format' '
+	git shortlog -s --date="format:%Y" --group="format:%cN (%cd)" \
+		HEAD >actual &&
+	cat >expect <<-\EOF &&
+	     4	C O Mitter (2005)
+	     1	Sin Nombre (2005)
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'shortlog --group=<format> DWIM' '
+	git shortlog -s --date="format:%Y" --group="%cN (%cd)" HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'shortlog bogus --group' '
+	test_must_fail git shortlog --group=bogus HEAD 2>err &&
+	grep "unknown group type" err
+'
+
 test_expect_success 'trailer idents are split' '
 	cat >expect <<-\EOF &&
 	     2	C O Mitter
@@ -326,6 +346,18 @@ test_expect_success 'shortlog can match multiple groups' '
 	test_cmp expect actual
 '
 
+test_expect_success 'shortlog can match multiple format groups' '
+	GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME" \
+		git commit --allow-empty -m "identical names" &&
+	test_tick &&
+	cat >expect <<-\EOF &&
+	     2	A U Thor
+	     1	C O Mitter
+	EOF
+	git shortlog -ns --group="%cn" --group="%an" -2 HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'set up option selection tests' '
 	git commit --allow-empty -F - <<-\EOF
 	subject
-- 
2.38.0.16.g393fd4c6db

