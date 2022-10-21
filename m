Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927FDC38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 22:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJUW0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 18:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJUWZv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 18:25:51 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1F2204ACC
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:25:50 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id i65so3552023ioa.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 15:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSopvb+1Nn824ZFphSMRXWhfBJc8qAxPlN76pRZxzbU=;
        b=tb8myT3JLt3N4LXkyb65Wjp35MliP30qPHdw7Gah/Kbkm8xmfWqYJ22q+Cin16zO4W
         FJIiwlltb/suvN7Uphj11dj76lFttQ5w1skPEdDk807qRTZuz6Ze2kxMPws02WJp16kl
         2NeW4AwcpDjrvvqsxSayLCTzDjSOd4X145lPl/Vo2iAHE1ZHig6feX2k73bq4deWZgFH
         wUWHfOl/lpkrZau1tFndIazJgZUf2tIUhPftxDErMLkUSRlorsIRxQHOprMrBBhte4s7
         2PB1acbgwlvDf5jvLj757NywF+WzFo80mbJh/in13MmqILcwkm30yf6LCGVBzIBoa56s
         2VPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSopvb+1Nn824ZFphSMRXWhfBJc8qAxPlN76pRZxzbU=;
        b=Jqp0NMa28kdaovrYBDW8eIRxcVONGeIVtEQg/ga2/koRI7UEhmV8wkAwooBOkLfkSd
         XXyYVDzAp/CAIq4bdjgZEzDpUs5NmtnJ6FvsubbTQa3vWK1jfIJ8U6Mq3FbiHU6m2gRO
         50ZAkgjJauZCNFLhT/EQ7XQ4eMi7lB7MCpPrAzwXy4HMqQ7VD0PHQJumsxRMU7iemUtf
         Mlsnk0IXObpPKjgRF7Jwg1465ArY8wOFbocSot4rPyJpgZURmfDvOd6P6HVf/bKmSDxM
         5eZSFqN8+RObBCb6wCpOtlTdrKbgOtP5k2J7yd9No/4odX23cO67gbul2o/ckvT1F/ub
         1Itg==
X-Gm-Message-State: ACrzQf2Qx/d3EMoxZfjPvUSijtDj8Xd6eVlUP7lY5jaAl/TXq/7bAqyQ
        cx09qmUh8+QPm7Vw+v8z08wqcHROVLLLQYRh
X-Google-Smtp-Source: AMsMyM76gN5NofJNxy6Iqre9HS4w1/X0s+ssQJogpC3JpjVSjDSqUQ2rcZzn5kNauycv2FGvWa/O/g==
X-Received: by 2002:a05:6602:2c02:b0:690:b560:7fae with SMTP id w2-20020a0566022c0200b00690b5607faemr14487614iov.169.1666391150331;
        Fri, 21 Oct 2022 15:25:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q7-20020a056638040700b00363d1aa7515sm4762703jap.16.2022.10.21.15.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:25:50 -0700 (PDT)
Date:   Fri, 21 Oct 2022 18:25:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com
Subject: [PATCH v3 4/7] shortlog: support arbitrary commit format `--group`s
Message-ID: <f75a952421ee1ab531d9977252d6594346a94583.1666391136.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666391136.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666391136.git.me@ttaylorr.com>
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
index d0645769d7..a52288acab 100644
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
+	return log->format.nr > 1 || log->trailers.nr;
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

