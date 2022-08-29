Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CABCECAAD2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 21:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiH2Viu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 17:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiH2Vil (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 17:38:41 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A816D816B2
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 14:38:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q15so4087442pfn.11
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 14:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date;
        bh=j/MfIrQY4laDXr69h8Jg/zDjk2oNKxg1wyWNe1Ccfjc=;
        b=lXOSXCk3GelFzIljLJgC/ebHdKJlI5MsvnwhjGH0i3yeh0fyvX5C+WKdyCVcEF7by3
         r7C1aDpA/ugOGyzDeFYe7xo5yZqf5xkYvx2kCoB5f9TKAZPXHPcYV3ZtQUOxxMnyAB4X
         r2bq+XV4zIZ+Qr0t366TY1T+9GxEhqtCAnHEgH96uyjggqaGFmECLdwygvQ2LfN9TrHd
         DTV+ctQggLz+14w1EnhZKcV/EJx5TYbOJdNA2F85PgTLTOO9TQwyMcQwrvoiDpkwgLRw
         F10+C1XNAaVYNm4G6kL8y3fjKjWL+tR1V4REe3SskLl/s1bLJHWND+mhu5mw+GoqXLTl
         nY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date;
        bh=j/MfIrQY4laDXr69h8Jg/zDjk2oNKxg1wyWNe1Ccfjc=;
        b=mmXe5cymCu6jIfeTZv26FiAyzNf+PJ0raBPXqLZhzClR3CMkwZycOfWzR2/rF/TV0J
         f1N/oEhHMkLrKEeNrMt/VMxEa8pZ2gMeSH5b6wyTGakslkpqLMTVj5yfuHkRZbbo9966
         kn6qHnIGyil6tTvzfvNVbnBiV0M61PwqBAqcllxbbfXP+V2uJc9leJfC3GtM3xKTbKk8
         88f08r6fFQYXmA9JWwmCs4GntPdkV6ftdw+YixDPKupVPgqgVXDAPCJ2Z2fWF+TojUyy
         Bi2eXTXHulEZvTdt5aqAs7baOXEqxDpAB7u9tltLjqKS+Y4z/ukB+qGkVaNxXi7fERHo
         W4gw==
X-Gm-Message-State: ACgBeo2H+eM4CpyXiRg23C4Q8VPeY0Q3JbyLohyADqm8QenaCxkAZKEO
        /w9xPXRYg8j3szS0bW3nmqBZFhZKbDc=
X-Google-Smtp-Source: AA6agR6JFPxpm4Jqsg2M70FqGDr6yQBaf/ug7g6R8YiBVb39c9oDo2r8G+xBeA+c4JbJwaDyuTlLjA==
X-Received: by 2002:a65:6491:0:b0:42a:c39a:e58e with SMTP id e17-20020a656491000000b0042ac39ae58emr15221797pgv.68.1661809119810;
        Mon, 29 Aug 2022 14:38:39 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w85-20020a627b58000000b00535d094d6ecsm7775014pfc.108.2022.08.29.14.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 14:38:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 2/3] format-patch: allow forcing the use of in-body From: header
Date:   Mon, 29 Aug 2022 14:38:36 -0700
Message-Id: <20220829213837.13849-3-gitster@pobox.com>
X-Mailer: git-send-email 2.37.2-621-gd3a800faf0
In-Reply-To: <20220829213837.13849-1-gitster@pobox.com>
References: <20220826213203.3258022-1-gitster@pobox.com>
 <20220829213837.13849-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users may be authoring and committing their commits under the same
e-mail address they use to send their patches from, in which case
they shouldn't need to use the in-body From: line in their outgoing
e-mails.  At the receiving end, "git am" will use the address on the
"From:" header of the incoming e-mail and all should be well.

Some mailing lists, however, mangle the From: address from what the
original sender had; in such a situation, the user may want to add
the in-body "From:" header even for their own patches.

"git format-patch --[no-]force-in-body-from" was invented for such
users.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-format-patch.txt |  9 +++++++++
 builtin/log.c                      |  5 +++++
 pretty.c                           |  2 ++
 revision.h                         |  1 +
 t/t4014-format-patch.sh            | 13 +++++++++++++
 5 files changed, 30 insertions(+)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index be797d7a28..7c7f244e57 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -275,6 +275,15 @@ header). Note also that `git send-email` already handles this
 transformation for you, and this option should not be used if you are
 feeding the result to `git send-email`.
 
+--[no-]force-in-body-from::
+	With the e-mail sender specified via the `--from` option, by
+	default, an in-body "From:" to identify the real author of
+	the commit is added at the top of the commit log message if
+	the sender is different from the author.  With this option,
+	the in-body "From:" is added even when the sender and the
+	author have the same name and address, which may help if the
+	mailing list software mangles the sender's identity.
+
 --add-header=<header>::
 	Add an arbitrary header to the email headers.  This is in addition
 	to any configured headers, and may be used multiple times.
diff --git a/builtin/log.c b/builtin/log.c
index 9b937d59b8..78ccd37bd9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -52,6 +52,7 @@ static int default_encode_email_headers = 1;
 static int decoration_style;
 static int decoration_given;
 static int use_mailmap_config = 1;
+static unsigned int force_in_body_from;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static int fmt_patch_name_max = FORMAT_PATCH_NAME_MAX_DEFAULT;
 static const char *fmt_pretty;
@@ -1897,6 +1898,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			   N_("show changes against <refspec> in cover letter or single patch")),
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("percentage by which creation is weighted")),
+		OPT_BOOL(0, "force-in-body-from", &force_in_body_from,
+			 N_("show in-body From: even if identical to the e-mail header")),
 		OPT_END()
 	};
 
@@ -1940,6 +1943,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
 			     PARSE_OPT_KEEP_DASHDASH);
 
+	rev.force_in_body_from = force_in_body_from;
+
 	/* Make sure "0000-$sub.patch" gives non-negative length for $sub */
 	if (fmt_patch_name_max <= strlen("0000-") + strlen(fmt_patch_suffix))
 		fmt_patch_name_max = strlen("0000-") + strlen(fmt_patch_suffix);
diff --git a/pretty.c b/pretty.c
index cf418a6b20..b7553e3fe0 100644
--- a/pretty.c
+++ b/pretty.c
@@ -480,6 +480,8 @@ static void append_line_with_color(struct strbuf *sb, struct grep_opt *opt,
 static int use_in_body_from(const struct pretty_print_context *pp,
 			    const struct ident_split *ident)
 {
+	if (pp->rev && pp->rev->force_in_body_from)
+		return 1;
 	if (ident_cmp(pp->from_ident, ident))
 		return 1;
 	return 0;
diff --git a/revision.h b/revision.h
index bb91e7ed91..6e346a60ab 100644
--- a/revision.h
+++ b/revision.h
@@ -221,6 +221,7 @@ struct rev_info {
 			missing_newline:1,
 			date_mode_explicit:1,
 			preserve_subject:1,
+			force_in_body_from:1,
 			encode_email_headers:1,
 			include_header:1;
 	unsigned int	disable_stdin:1;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index fbec8ad2ef..347f7f7f35 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1400,6 +1400,19 @@ test_expect_success '--from omits redundant in-body header' '
 	test_cmp expect patch.head
 '
 
+test_expect_success 'with --force-in-body-from, redundant in-body from is kept' '
+	git format-patch --force-in-body-from \
+		-1 --stdout --from="A U Thor <author@example.com>" >patch &&
+	cat >expect <<-\EOF &&
+	From: A U Thor <author@example.com>
+
+	From: A U Thor <author@example.com>
+
+	EOF
+	sed -ne "/^From:/p; /^$/p; /^---$/q" patch >patch.head &&
+	test_cmp expect patch.head
+'
+
 test_expect_success 'in-body headers trigger content encoding' '
 	test_env GIT_AUTHOR_NAME="éxötìc" test_commit exotic &&
 	test_when_finished "git reset --hard HEAD^" &&
-- 
2.37.2-621-gd3a800faf0

