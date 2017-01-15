Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB6CA2079E
	for <e@80x24.org>; Sun, 15 Jan 2017 18:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbdAOSrf (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 13:47:35 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36012 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbdAOSr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 13:47:29 -0500
Received: by mail-qk0-f195.google.com with SMTP id a20so13916567qkc.3
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 10:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uBV8dyzptgWVb4W+WBbMPN9OtwEC0VmBfaQGKSxwIbo=;
        b=hAaoBD1AY7ekqRESMChu0VcVMv8I4GxeRewcNdU2CbNVf5YBEoihzCoiBzQavFd9cM
         phJFnCg0KwXIW74fWBa1dc3g0Og3JmwPGND1Fo7ZFZe7qdgS88QTxAKgXnyoNkRTRsrH
         rI/FtAQbaD7APBi/Uh//j/x+aCl9vmyXMST7xJyd+diQKworki40Bhb1Te4/voskdgDK
         oH2mtkR61urmHrekFW67yRlC2n9mYw12kEYLQs/2s+teeuFm1i5WIlXYtJZVWBpMOcRH
         93p4Uu8Pm3UvYyYADtZK125gHAACT4nqPhIQWSIQdM9BLyobgob4KKrI0U4jUjk706cu
         GxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uBV8dyzptgWVb4W+WBbMPN9OtwEC0VmBfaQGKSxwIbo=;
        b=NM5e9zxAMArRFfLXJZsSEtJx2mfqgAaPfxB4ZLSyFXQeUZRx4v/fxTaiztoxMLbk2J
         Z+vo5PSvyAq2zZZES0K2rD1/9TGg2C3NglKUQq1uVW3zEDdOxHxgLXyFrYgcnxuslP6v
         L2PXG7G79csC+4vnDpEyTidsJSwjh8jLLUKSafzxa8BJXZZlFvUHnyzTEymPAn5Lxk1Z
         nrrxx7xy0Gjwq1SYVWauQLPcf5fdSbpXMrN4aWIB21S3gf2x886q75qd3aJO1pd050Od
         rlNd6+6xLO7mb5vf9akWEE7zcjc1ZVJw6lA+ES3HDzy3A/9da8TnqW7KwLtdMZYObpv3
         XUuQ==
X-Gm-Message-State: AIkVDXKmkRkdbFkxBRrF6UZXW3Ns64kPQEEuZCdphfqcXHkgmrh4yJe8SIc56ZtTWLbJJHIz
X-Received: by 10.55.22.97 with SMTP id g94mr26428376qkh.287.1484506048685;
        Sun, 15 Jan 2017 10:47:28 -0800 (PST)
Received: from localhost.localdomain ([2604:2000:8183:da00::3])
        by smtp.gmail.com with ESMTPSA id x40sm14362243qtx.12.2017.01.15.10.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jan 2017 10:47:28 -0800 (PST)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: [PATCH v5 5/7] builtin/tag: add --format argument for tag -v
Date:   Sun, 15 Jan 2017 13:47:03 -0500
Message-Id: <20170115184705.10376-6-santiago@nyu.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170115184705.10376-1-santiago@nyu.edu>
References: <20170115184705.10376-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas Puehringer <luk.puehringer@gmail.com>

Adding --format to git tag -v mutes the default output of the GPG
verification and instead prints the formatted tag object.
This allows callers to cross-check the tagname from refs/tags with
the tagname from the tag object header upon GPG verification.

The callback function for for_each_tag_name() didn't allow callers to
pass custom data to their callback functions. Add a new opaque pointer
to each_tag_name_fn's parameter to allow this.

Signed-off-by: Lukas Puehringer <luk.puehringer@gmail.com>
---
 Documentation/git-tag.txt |  2 +-
 builtin/tag.c             | 32 ++++++++++++++++++++++----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 76cfe40d9..586aaa315 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
 	[--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>]
 	[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]
-'git tag' -v <tagname>...
+'git tag' -v [--format=<format>] <tagname>...
 
 DESCRIPTION
 -----------
diff --git a/builtin/tag.c b/builtin/tag.c
index 880677df5..9da11e0c2 100644
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
 
@@ -66,15 +66,17 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 }
 
 typedef int (*each_tag_name_fn)(const char *name, const char *ref,
-				const unsigned char *sha1);
+				const unsigned char *sha1, void *cb_data);
 
-static int for_each_tag_name(const char **argv, each_tag_name_fn fn)
+static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
+		void *cb_data)
 {
 	const char **p;
 	char ref[PATH_MAX];
 	int had_error = 0;
 	unsigned char sha1[20];
 
+
 	for (p = argv; *p; p++) {
 		if (snprintf(ref, sizeof(ref), "refs/tags/%s", *p)
 					>= sizeof(ref)) {
@@ -87,14 +89,14 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn)
 			had_error = 1;
 			continue;
 		}
-		if (fn(*p, ref, sha1))
+		if (fn(*p, ref, sha1, cb_data))
 			had_error = 1;
 	}
 	return had_error;
 }
 
 static int delete_tag(const char *name, const char *ref,
-				const unsigned char *sha1)
+				const unsigned char *sha1, void *cb_data)
 {
 	if (delete_ref(ref, sha1, 0))
 		return 1;
@@ -103,9 +105,16 @@ static int delete_tag(const char *name, const char *ref,
 }
 
 static int verify_tag(const char *name, const char *ref,
-				const unsigned char *sha1)
+				const unsigned char *sha1, void *cb_data)
 {
-	return verify_and_format_tag(sha1, name, NULL, GPG_VERIFY_VERBOSE);
+	int flags;
+	char *fmt_pretty = cb_data;
+	flags = GPG_VERIFY_VERBOSE;
+
+	if (fmt_pretty)
+		flags = GPG_VERIFY_QUIET;
+
+	return verify_and_format_tag(sha1, ref, fmt_pretty, flags);
 }
 
 static int do_sign(struct strbuf *buffer)
@@ -428,9 +437,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
2.11.0

