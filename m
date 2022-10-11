Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4811BC433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiJKAeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJKAeY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:34:24 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC26A8262E
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:34:14 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id i9so6422222ilv.9
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mh9R6QPzogMv8jvYFbpSxQ/I5UGXAkD+RxoUtwAy5/w=;
        b=PQudKv4/dP+gf79hRxT547gKpgXE9osybtdcGqsgVbGF0ZIUv0aSP69gOOenNL3AgL
         McYQAIYBxdUckYA++0hgoaQEmIRSJXbvC2u1tS7aQWnovclPFsOSW6wQ+lSuJRDjkMfH
         2kUQIWT7E6iAVE5x+d+loWZsn54wHxPArDdhAdIMbeBAeAoU6tiEZk8i99MZE0ITi/bD
         ulolqoHSbkurooXi2X7FPQTeC/MS55SBKV+PQuoY2mw9fDI96pfg4SDV6solDkn3QcHL
         dwkrHVPdZDCnzdrE/kusBfdJLWyP/T0iI9hciTIh4lGqErj4kefwIy7GuIy1bUIQBLFH
         raUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mh9R6QPzogMv8jvYFbpSxQ/I5UGXAkD+RxoUtwAy5/w=;
        b=3XSkBc9SFhU5Q5+2WR4H8qbG+Ml3q34+Q93vxQrO3zeI6IWl3VEMYW8M+OPlWCOMDK
         MvoJkZ0hXouq7b7CRhscCRDUJ/4v82rUI/MEejAh5IFMPeK5NT4zzt7PhliN+tgQs5dg
         hEdHOURefluy5nf3YUp4TuIy70fBWCOA+4t0doEvMHiqkSncvy1XHACjdYkPcjm7ZfXK
         IDPqWdiNXZU+H9ExBgcLXJSF80yOHCT+JCa1q6HkVqYNlwOPjZZE3zXWy3bGzn7YpMSk
         qxM1WLEUNDnewUx6/pY+ydSQ34+bI5sh3Rppb+3xABW8GnHqIA07zSAoOX3qYC9pPfrF
         eHBg==
X-Gm-Message-State: ACrzQf0xX/Z2zzG6K5qJOLHLrQHw4xSNy9XFP8LR9XcONxe1cED2WgyX
        APzib9UE2TEGpWpJBfrsnfxcHMunYq/CeYpA
X-Google-Smtp-Source: AMsMyM6xiX9QzZTzuOfW30w08iYkhPBnF//GSgnGtEE3YaceCeTZrtGRQquEHql5+XxqbMg+j3lERA==
X-Received: by 2002:a05:6e02:1c47:b0:2fc:2672:d9c6 with SMTP id d7-20020a056e021c4700b002fc2672d9c6mr4950025ilg.35.1665448453352;
        Mon, 10 Oct 2022 17:34:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j8-20020a0566022cc800b006a27832c535sm4909080iow.30.2022.10.10.17.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 17:34:13 -0700 (PDT)
Date:   Mon, 10 Oct 2022 20:34:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com
Subject: [PATCH 4/7] shortlog: support arbitrary commit format `--group`s
Message-ID: <6f38990cc2ea8460ce37437e0770784d9b712dab.1665448437.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1665448437.git.me@ttaylorr.com>
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
 Documentation/git-shortlog.txt |  2 ++
 builtin/shortlog.c             | 33 ++++++++++++++++++++++++++++++++-
 shortlog.h                     |  2 ++
 t/t4201-shortlog.sh            |  9 +++++++++
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 4982ceee21..ca15643f45 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -59,6 +59,8 @@ OPTIONS
    example, if your project uses `Reviewed-by` trailers, you might want
    to see who has been reviewing with
    `git shortlog -ns --group=trailer:reviewed-by`.
+ - `<format>`, any string accepted by the `--format` option of 'git log'.
+   (See the "PRETTY FORMATS" section of linkgit:git-log[1].)
 +
 Note that commits that do not include the trailer will not be counted.
 Likewise, commits with multiple trailers (e.g., multiple signoffs) may
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 051c97bd5a..f708d96558 100644
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
@@ -200,6 +202,27 @@ static void insert_records_from_trailers(struct shortlog *log,
 	unuse_commit_buffer(commit, commit_buffer);
 }
 
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
+		if (strset_add(dups, buf.buf))
+			insert_one_record(log, buf.buf, oneline);
+	}
+
+	strbuf_release(&buf);
+}
+
 void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 {
 	struct strbuf ident = STRBUF_INIT;
@@ -243,6 +266,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	if (log->groups & SHORTLOG_GROUP_TRAILER) {
 		insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
 	}
+	insert_records_from_format(log, &dups, commit, &ctx, oneline_str);
 
 	strset_clear(&dups);
 	strbuf_release(&ident);
@@ -314,6 +338,7 @@ static int parse_group_option(const struct option *opt, const char *arg, int uns
 	if (unset) {
 		log->groups = 0;
 		string_list_clear(&log->trailers, 0);
+		string_list_clear(&log->format, 0);
 	} else if (!strcasecmp(arg, "author"))
 		log->groups |= SHORTLOG_GROUP_AUTHOR;
 	else if (!strcasecmp(arg, "committer"))
@@ -321,8 +346,12 @@ static int parse_group_option(const struct option *opt, const char *arg, int uns
 	else if (skip_prefix(arg, "trailer:", &field)) {
 		log->groups |= SHORTLOG_GROUP_TRAILER;
 		string_list_append(&log->trailers, field);
-	} else
+	} else if (strchrnul(arg, '%')) {
+		log->groups |= SHORTLOG_GROUP_FORMAT;
+		string_list_append(&log->format, arg);
+	} else {
 		return error(_("unknown group type: %s"), arg);
+	}
 
 	return 0;
 }
@@ -340,6 +369,7 @@ void shortlog_init(struct shortlog *log)
 	log->in2 = DEFAULT_INDENT2;
 	log->trailers.strdup_strings = 1;
 	log->trailers.cmp = strcasecmp;
+	log->format.strdup_strings = 1;
 }
 
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
@@ -480,4 +510,5 @@ void shortlog_output(struct shortlog *log)
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
index 3095b1b2ff..2417ac8896 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -237,6 +237,15 @@ test_expect_success 'shortlog --group=trailer:signed-off-by' '
 	test_cmp expect actual
 '
 
+test_expect_success 'shortlog --group=<format>' '
+	git shortlog -s --date="format:%Y" --group="%cN (%cd)" HEAD >actual &&
+	cat >expect <<-\EOF &&
+	     4	C O Mitter (2005)
+	     1	Sin Nombre (2005)
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'trailer idents are split' '
 	cat >expect <<-\EOF &&
 	     2	C O Mitter
-- 
2.37.0.1.g1379af2e9d

