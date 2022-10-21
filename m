Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A701EC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 03:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJUDL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 23:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJUDLm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 23:11:42 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E51BECDD
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:11:40 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id l127so1237944iof.12
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 20:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4f+L5daK31D8okaMwSpnCIUCs/le7fnuZBmfmTtUqc0=;
        b=gHHMYHNYSsOPDjnSrM+jaj6XTQ7SmzHwop5tAask4ixm/+K04w1pAAKIUo59s2WNh1
         syHwVMh2KE9bQ3chezBZUSQiiVh1wFtvPORq/C+sV+K/e0JMMuvdS+nS+3lmUHcN6/I1
         1J17Iz0jfzcAAZAlSTkU/GEtwbZYTU6GWZVIY6qi/IhBtl+dnv8hdYDgq7jzOYdS4l7i
         D9zP+zb8My3qnhu0p4TS9ri7vaxH05lG2DmnRxtq7E/GyaQQFOQ9am8Q3+3wPIQarF2u
         war+ne/T08am5zgc2G6KKC0MsoSlzT3HQuHa7kZnIHJG2ogQrlXfUIIWlY/xcb3UeepJ
         EUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4f+L5daK31D8okaMwSpnCIUCs/le7fnuZBmfmTtUqc0=;
        b=eqjo2B31peQfZo+Y39iLdqYVfSiVpGxZGEOHsVqD411Qxnc8kCCRaSz6rXlBLb+T8h
         3bsO3tNJ1z5DAsGp8u3O5vZrkFzJCDie543ImGC2fNp4urE46f6o7dPp59CwdWqPeUeq
         Ajnibwhhh5QmZO1/K2lz0Lc7BR0VymDUg6jsf9pEaBgv+KwkevXkjkvPWCZwDvfpobnA
         Z8YnmuJV+Ugz/pzPjMgClAcIlEyRDXJZg8jw8jhLJxTBuWVtGdwouZXiu4rbB6uLbXOg
         7aVkdMtLPaK9IQpFpIpi6yRZXTxD4wFKPVmQlrvUewuCizOIUIR/7oRQHemejW/GZk0Y
         ia1Q==
X-Gm-Message-State: ACrzQf3Tat7rh2//br7sWLMcizU9PgzsXFBYkyvwBkfjjzMC8xCp0lWR
        0nWaoiQHFXp92+WHTcv2t9VFitwUxRWxOB9Z
X-Google-Smtp-Source: AMsMyM4xameyUKeMlBOq6WX/cXFTD9WmbyIrqlYcrg0zB3piVDHK7+3e5lFJimA2TVUosA/c0KRzIg==
X-Received: by 2002:a05:6638:4185:b0:363:cdcd:ce1 with SMTP id az5-20020a056638418500b00363cdcd0ce1mr13042253jab.101.1666321899502;
        Thu, 20 Oct 2022 20:11:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j3-20020a026303000000b00363e4730a41sm3859295jac.175.2022.10.20.20.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 20:11:39 -0700 (PDT)
Date:   Thu, 20 Oct 2022 23:11:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: [PATCH v2 4/6] shortlog: support arbitrary commit format `--group`s
Message-ID: <4a36c0ca4e840d53e2fd257e2d97498ced6fb28c.1666320509.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666320509.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666320509.git.me@ttaylorr.com>
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
 Documentation/git-shortlog.txt |  3 +++
 builtin/shortlog.c             | 37 +++++++++++++++++++++++++++-
 shortlog.h                     |  2 ++
 t/t4201-shortlog.sh            | 44 ++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 311c041c06..8cf5a2e3c7 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
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
index d0645769d7..0358397a7b 100644
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
@@ -203,6 +205,28 @@ static void insert_records_from_trailers(struct shortlog *log,
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
+		if (!(log->format.nr > 1 || log->trailers.nr) ||
+		    strset_add(dups, buf.buf))
+			insert_one_record(log, buf.buf, oneline);
+	}
+
+	strbuf_release(&buf);
+}
+
 void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 {
 	struct strbuf ident = STRBUF_INIT;
@@ -244,6 +268,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 			insert_one_record(log, ident.buf, oneline_str);
 	}
 	insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
+	insert_records_from_format(log, &dups, commit, &ctx, oneline_str);
 
 	strset_clear(&dups);
 	strbuf_release(&ident);
@@ -315,6 +340,7 @@ static int parse_group_option(const struct option *opt, const char *arg, int uns
 	if (unset) {
 		log->groups = 0;
 		string_list_clear(&log->trailers, 0);
+		string_list_clear(&log->format, 0);
 	} else if (!strcasecmp(arg, "author"))
 		log->groups |= SHORTLOG_GROUP_AUTHOR;
 	else if (!strcasecmp(arg, "committer"))
@@ -322,8 +348,15 @@ static int parse_group_option(const struct option *opt, const char *arg, int uns
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
@@ -341,6 +374,7 @@ void shortlog_init(struct shortlog *log)
 	log->in2 = DEFAULT_INDENT2;
 	log->trailers.strdup_strings = 1;
 	log->trailers.cmp = strcasecmp;
+	log->format.strdup_strings = 1;
 }
 
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
@@ -481,4 +515,5 @@ void shortlog_output(struct shortlog *log)
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
index 7547da539d..13ac0bac64 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -244,6 +244,36 @@ test_expect_success 'shortlog --group=trailer:signed-off-by' '
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
+test_expect_success 'shortlog multiple --group=format' '
+	git shortlog -s --date="format:%Y" --group="format:%cN (%cd)" \
+		HEAD >actual &&
+	cat >expect <<-\EOF &&
+	     4	C O Mitter (2005)
+	     1	Sin Nombre (2005)
+	EOF
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
@@ -326,6 +356,20 @@ test_expect_success 'shortlog can match multiple groups' '
 	test_cmp expect actual
 '
 
+test_expect_success 'shortlog can match multiple format groups' '
+	cat >expect <<-\EOF &&
+	     2	User B <b@example.com>
+	     1	A U Thor <author@example.com>
+	     1	User A <a@example.com>
+	EOF
+	git shortlog -ns \
+		--group="%(trailers:valueonly,key=some-trailer)" \
+		--group="%(trailers:valueonly,key=another-trailer)" \
+		-2 HEAD >actual.raw &&
+	grep -v "^$" actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'set up option selection tests' '
 	git commit --allow-empty -F - <<-\EOF
 	subject
-- 
2.38.0.16.g393fd4c6db

