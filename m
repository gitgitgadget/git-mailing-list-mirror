Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F88CC7EE23
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 23:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjFGXC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjFGXCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 19:02:25 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5673E1FEA
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 16:02:22 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b162127472so3684918a34.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 16:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686178940; x=1688770940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XdSUjfb12ZWJ7TVasbJqnGF4IrrXWVIaZoyRPRUCVz4=;
        b=td/Wx1Z1YCqjSRuxc98eZBoR7BHdxOjh/gWbsaRnJjgf3f1IYaxwi8Fxfx5eINDOiK
         lkZMCOa6z8qM32XeqyIhPoALqgdhRqVDhy59XkXMNSeEVcaV1TBouC7g8kxGWcZ209za
         g/4k33CFOa5pRS0c5bt5YnVuPtX5aWlQyV72a3qJwiDUEfw3sXDjmzIY6Kuf83cjaryW
         TZfSxCNyNJI9CSQp2px20mtdAnKBjbheop3RjstVzwgBIuiNVSYfP6Es6PvNn+K5AHzQ
         qPghY9j4GJyNqZBk/c4n1J55yZKGWeYoAyWYSE0dtTGrs3uwhj3xk3hp6difW9bBtwOA
         UKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686178940; x=1688770940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdSUjfb12ZWJ7TVasbJqnGF4IrrXWVIaZoyRPRUCVz4=;
        b=CjC50P6g58alvShJwpXDhbXtE86feWRKYYFGPpZG5dNsSRJfwc+iuElaOi8lyrzNRR
         fTZYFzk8r65dS8+IvkG2burzqdy9pQqXDEBefQuUBHIQT8jq+i1+sykmbDJhBcuoRzfV
         0BKvraJZxVMmyDMAdL8kk5MMah+iOWu/645+FW/CVHqbfcbDpIdvgli7G6R4qVnNuYW1
         7pqBPPaL+aqiWxFJS/KJFIHzHNkHsard9YXERouXj8PFcctr/2YQziRCMxGJ5IyRq2YV
         3rvSKN26kXtyUQQfVteRT/dKNmGqoiYDlklnm3Z+63b6GsKiwB/516rHxf9/Rn4KCcQY
         WWcA==
X-Gm-Message-State: AC+VfDzwBL1xoujeNmyOmEChE+C8QT76Vfyzp3YtRrljgHmWExrPBbpn
        DEtz6QVn0LPTYvP8baodguumfWM6m4UXBWFBG2oxI3mf
X-Google-Smtp-Source: ACHHUZ5ir723WrjKCVBu51ABE+bzGKP3eIoqC42nu03cvdIbvxTPPNh+f7lx31kwt3pyLOzy0N3oAA==
X-Received: by 2002:a05:6830:1bd6:b0:6b2:a874:693c with SMTP id v22-20020a0568301bd600b006b2a874693cmr2482837ota.12.1686178939847;
        Wed, 07 Jun 2023 16:02:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e72-20020a25694b000000b00bb131cd635bsm226355ybc.8.2023.06.07.16.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 16:02:19 -0700 (PDT)
Date:   Wed, 7 Jun 2023 19:02:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] shortlog: introduce `--email-only` to only show emails
Message-ID: <44179d28fa7676965a28734e20584d54b44e051b.1686178917.git.me@ttaylorr.com>
References: <cover.1686178917.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1686178917.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a shortlog caller wants to group output by, say, author email, they
can easily express this with:

    $ git shortlog --group=format:%ae

and restrict output to specific email(s) with the new `--group-filter`
option introduced by the previous commit.

But they are not able to apply the same treatment to identities that
appear in trailers. Doing:

    $ git shortlog -e --group=format:%ae --group=trailer:Co-authored-by

will produce funky results, interspersing proper emails with full "Name
<email>" identities from the Co-authored-by trailer (or anything else
that might appear there), like:

    461  me@ttaylorr.com
     11  Taylor Blau <me@ttaylorr.com>

So if the caller wants to restrict output to a set of matching email
addresses (say, "me@ttaylorr.com"), they cannot do it with a
`--group-filter`, since it would discard the group "Taylor Blau
<me@ttaylorr.com>".

Introduce a new `--email-only` option, which extracts the email
component of an identity from all shortlog groups, including trailers.
It behaves similarly to the `-e` option, but replaces its output with
just the email component, instead of adding it on to the end.

Now, `shortlog` callers can perform:

    $ git shortlog -s --group=author --group=trailer:Co-authored-by \
        --email-only --group-filter="<me@ttaylorr.com>"
       472  <me@ttaylorr.com>

to obtain the output they want.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-shortlog.txt |  5 +++++
 builtin/shortlog.c             | 33 ++++++++++++++++++++++++---------
 shortlog.h                     |  1 +
 t/t4201-shortlog.sh            | 28 ++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index dab6d09648..160c11aead 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -39,6 +39,11 @@ OPTIONS
 --email::
 	Show the email address of each author.
 
+--email-only::
+	Show only the email address of each author, or committer. If
+	using a different kind of group (e.g. trailers, custom format,
+	etc.), only values which contain name/email-pairs will be shown.
+
 --format[=<format>]::
 	Instead of the commit subject, use some other information to
 	describe each commit.  '<format>' can be any string accepted
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 679db22c57..bbe01a376f 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -108,9 +108,13 @@ static int parse_ident(struct shortlog *log,
 	maillen = ident.mail_end - ident.mail_begin;
 
 	map_user(&log->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
-	strbuf_add(out, namebuf, namelen);
-	if (log->email)
-		strbuf_addf(out, " <%.*s>", (int)maillen, mailbuf);
+	if (log->email_only) {
+		strbuf_addf(out, "<%.*s>", (int)maillen, mailbuf);
+	} else {
+		strbuf_add(out, namebuf, namelen);
+		if (log->email)
+			strbuf_addf(out, " <%.*s>", (int)maillen, mailbuf);
+	}
 
 	return 0;
 }
@@ -198,6 +202,8 @@ static void insert_records_from_trailers(struct shortlog *log,
 		strbuf_reset(&ident);
 		if (!parse_ident(log, &ident, value))
 			value = ident.buf;
+		else if (log->email_only)
+			continue;
 
 		if (!strset_add(dups, value))
 			continue;
@@ -370,12 +376,19 @@ void shortlog_init(struct shortlog *log)
 
 void shortlog_finish_setup(struct shortlog *log)
 {
-	if (log->groups & SHORTLOG_GROUP_AUTHOR)
-		string_list_append(&log->format,
-				   log->email ? "%aN <%aE>" : "%aN");
-	if (log->groups & SHORTLOG_GROUP_COMMITTER)
-		string_list_append(&log->format,
-				   log->email ? "%cN <%cE>" : "%cN");
+	if (log->email_only) {
+		if (log->groups & SHORTLOG_GROUP_AUTHOR)
+			string_list_append(&log->format, "<%aE>");
+		if (log->groups & SHORTLOG_GROUP_COMMITTER)
+			string_list_append(&log->format, "<%cE>");
+	} else {
+		if (log->groups & SHORTLOG_GROUP_AUTHOR)
+			string_list_append(&log->format,
+					   log->email ? "%aN <%aE>" : "%aN");
+		if (log->groups & SHORTLOG_GROUP_COMMITTER)
+			string_list_append(&log->format,
+					   log->email ? "%cN <%cE>" : "%cN");
+	}
 
 	string_list_sort(&log->trailers);
 	string_list_sort(&log->group_filter);
@@ -397,6 +410,8 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 			 N_("suppress commit descriptions, only provides commit count")),
 		OPT_BOOL('e', "email", &log.email,
 			 N_("show the email address of each author")),
+		OPT_BOOL(0, "email-only", &log.email_only,
+			 N_("only show the email address of each author")),
 		OPT_CALLBACK_F('w', NULL, &log, N_("<w>[,<i1>[,<i2>]]"),
 			N_("linewrap output"), PARSE_OPT_OPTARG,
 			&parse_wrap_args),
diff --git a/shortlog.h b/shortlog.h
index 8ebee0e2d6..3fb28639c3 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -30,6 +30,7 @@ struct shortlog {
 	struct string_list format;
 
 	int email;
+	int email_only;
 	struct string_list mailmap;
 	FILE *file;
 };
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 0695c42ca8..d747a402ff 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -400,6 +400,34 @@ test_expect_success '--no-group-filter reset group filters' '
 	test_cmp expect actual
 '
 
+test_expect_success '--email-only shows emails from author' '
+	cat >expect <<-\EOF &&
+	     2	<author@example.com>
+	EOF
+	git shortlog -ns --group=author --email-only -2 HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--email-only shows emails from committer' '
+	cat >expect <<-\EOF &&
+	     2	<committer@example.com>
+	EOF
+	git shortlog -ns --group=committer --email-only -2 HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--email-only shows emails from trailers with idents' '
+	cat >expect <<-\EOF &&
+	     1	<a@example.com>
+	     1	<b@example.com>
+	EOF
+	# at this point, HEAD~3 has a trailer "Repeated-trailer: Foo",
+	# which is not shown here since it cannot be parsed as an ident
+	git shortlog -ns --group=trailer:some-trailer --email-only -3 \
+		HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'shortlog can match multiple format groups' '
 	GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME" \
 		git commit --allow-empty -m "identical names" &&
-- 
2.41.0.1.gf123b68cb8
