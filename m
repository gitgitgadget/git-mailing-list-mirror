Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57DCA207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 22:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933318AbcIZWnE (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 18:43:04 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34849 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932624AbcIZWm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 18:42:57 -0400
Received: by mail-qk0-f196.google.com with SMTP id n185so8558165qke.2
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LBfBKYGGuKhB74lAROIKuEjOAQJffgnVrkro+OctNQM=;
        b=JiTpfpKOIKYV8tVCjMo0Fn3not+nXYApBo9nJGAFwX+r0WZPsJQ6io0EYO2jn4GK+o
         oIR02LfamgeDWutjRGacaB7h7QawF5KYxcDb5Zfx9rRkPG2TosKu37/1cqaDAJ0borL+
         jix0t7i4qiPqNbx9KnvsfXZFovW3cCoU2rhv3EnLRmid7rgrmecjBq5exEctgd8LACQX
         CSxrYa7l2+exmU2KkUzzSH+0ELKOAiVuoALCL1T3YSCy42OQCWedu/u+otMWybrCcwhU
         8+UTO0bdKZ4IlXMseKHdPbiXc0LfwuoQByM3NB+DfhCkk4mOApUWIouLX171TTxbr6lg
         zf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LBfBKYGGuKhB74lAROIKuEjOAQJffgnVrkro+OctNQM=;
        b=JqcOIQati/RLVXtKDMuHl3Rsj/eaKoyFyMOUYd/AuCOn6QIxito73Z6rAaSBcZWnWA
         v/qTeNiUfI4t02Fk7Dtyd5q5MLbVAYXjGd6kb3GXc12C4W/UK5O6deRV59jNtT1HAfIv
         mUZ45f9w9JjMCb1uAD6OIJuyxW7fp5Q0bGAYiL2Uqe++PL2eLw9ATGzVNxUMm/tA01/Q
         EpAj+EBEFeiS57zfxW2pLt6ZVW9b3P6etzngi+/iuSxUa23m7NyVo40ImiNCMAS0Sifi
         iheU3h4LXbSTtWhz2RYjsMLJjvCOFDlxztbh1QAU6dv3lEWybcHhUlACDApi/SYo8K5u
         Eumg==
X-Gm-Message-State: AA6/9RknZaeVNYLxV/wlBHF9YtmS4XiQH4Zbb+GTsUaYwEVZK80XuLNeawSqQqlsUMYBE7Rz
X-Received: by 10.55.160.209 with SMTP id j200mr5211866qke.167.1474929775883;
        Mon, 26 Sep 2016 15:42:55 -0700 (PDT)
Received: from LykOS.localdomain (cpe-74-65-203-27.nyc.res.rr.com. [74.65.203.27])
        by smtp.gmail.com with ESMTPSA id 62sm12840092qtg.14.2016.09.26.15.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Sep 2016 15:42:55 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>
Subject: [PATCH v2 5/5] builtin/tag: add --format argument for tag -v
Date:   Mon, 26 Sep 2016 18:42:33 -0400
Message-Id: <20160926224233.32702-6-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160926224233.32702-1-santiago@nyu.edu>
References: <20160926224233.32702-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas P <luk.puehringer@gmail.com>

Adding --format to git tag -v mutes the default output of the GPG
verification and instead prints the formatted tag object.
This allows callers to cross-check the tagname from refs/tags with
the tagname from the tag object header upon GPG verification.

Caveat: The change adds a format specifier argument to the
(*each_tag_name_fn) function pointer, i.e. delete_tag now receives this
too, although it does not need it.

Signed-off-by: Lukas P <luk.puehringer@gmail.com>
---
 builtin/tag.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 14f3b48..f53227e 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -24,7 +24,7 @@ static const char * const git_tag_usage[] = {
 	N_("git tag -d <tagname>..."),
 	N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]"
 		"\n\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"),
-	N_("git tag -v <tagname>..."),
+	N_("git tag -v [--format=<format>] <tagname>..."),
 	NULL
 };
 
@@ -66,9 +66,10 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 }
 
 typedef int (*each_tag_name_fn)(const char *name, const char *ref,
-				const unsigned char *sha1);
+				const unsigned char *sha1, const char *fmt_pretty);
 
-static int for_each_tag_name(const char **argv, each_tag_name_fn fn)
+static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
+		const char *fmt_pretty)
 {
 	const char **p;
 	char ref[PATH_MAX];
@@ -87,14 +88,14 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn)
 			had_error = 1;
 			continue;
 		}
-		if (fn(*p, ref, sha1))
+		if (fn(*p, ref, sha1, fmt_pretty))
 			had_error = 1;
 	}
 	return had_error;
 }
 
 static int delete_tag(const char *name, const char *ref,
-				const unsigned char *sha1)
+				const unsigned char *sha1, const char *fmt_pretty)
 {
 	if (delete_ref(ref, sha1, 0))
 		return 1;
@@ -103,9 +104,15 @@ static int delete_tag(const char *name, const char *ref,
 }
 
 static int verify_tag(const char *name, const char *ref,
-				const unsigned char *sha1)
+				const unsigned char *sha1, const char *fmt_pretty)
 {
-	return verify_and_format_tag(sha1, name, NULL, GPG_VERIFY_VERBOSE);
+	int flags;
+	flags = GPG_VERIFY_VERBOSE;
+
+	if (fmt_pretty)
+		flags = GPG_VERIFY_QUIET;
+
+	return verify_and_format_tag(sha1, name, fmt_pretty, flags);
 }
 
 static int do_sign(struct strbuf *buffer)
@@ -424,9 +431,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (filter.merge_commit)
 		die(_("--merged and --no-merged option are only allowed with -l"));
 	if (cmdmode == 'd')
-		return for_each_tag_name(argv, delete_tag);
-	if (cmdmode == 'v')
-		return for_each_tag_name(argv, verify_tag);
+		return for_each_tag_name(argv, delete_tag, NULL);
+	if (cmdmode == 'v') {
+		if (format)
+			verify_ref_format(format);
+		return for_each_tag_name(argv, verify_tag, format);
+	}
 
 	if (msg.given || msgfile) {
 		if (msg.given && msgfile)
-- 
2.10.0

