Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06DE320986
	for <e@80x24.org>; Fri,  7 Oct 2016 21:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756526AbcJGVIb (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 17:08:31 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35200 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756067AbcJGVIM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 17:08:12 -0400
Received: by mail-qk0-f196.google.com with SMTP id v138so2013763qka.2
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 14:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cHE1Hs20NQCYmfEDPYLRCU7pDqOBJ8u1GLvv6vimzY0=;
        b=GWZe9ng3FkaU9n1ie+esHua57xCC+8GseufsgCNJkWv9Wn4c1Yab9GMc/rG3RxN3MP
         J0LRp7t4w4W7XseQ28bnbXQB1tDb/udg1BFqstvq8YykPCg5Z7Xyk1QEtWnNgVA2nGWv
         UfhyhWlz7oaisL+NSQzY4hRlPwi71yN4WJN/pTq9XY+N2idYnS1q//QJhq/gsZGnIoiO
         +29yyJK/jL2MMs65DSRchgFY0pBYnoLoXdsp9Y/slsV8L26fIBkeIC1AMz97WaLzGUui
         Dp7Q+tHHgOs3EpAQnOG+AuKX8oo3tn+0Btfl6vB+Lq7BGzeO2U44ahFge8rSMn3I03Xb
         NTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cHE1Hs20NQCYmfEDPYLRCU7pDqOBJ8u1GLvv6vimzY0=;
        b=DgQj0qxCCP7ZoZnWMLR07oDhSRf0kuLbGMqf2HHXQPV/DIk8VjNwuxDP3NLNs0Xcsc
         65JRwhaCVAZoGse7Va4Em9l0bo2jI6Dy91IA2ZWf/fD9h2hkFBvS81pfrsNwpvChqWgf
         iXQKB0vk5r+mSzXedMsT1G75XDPhX2ghNhFRAp52hWJzsX3GBuq4IPdrqCTjfwoY7GHO
         nASVBIenE5dvCXzfvR3Ub5z4wFxLIba3bQnz5RZrLQUcT9zde3iAGLAQ3r4hiAZGKAVt
         aEpV0TD6FIkduYOamwrTmvjOBEO4ybs/vocCO6WijaDKcxQMLatpNcchvvSOnVtPAkRg
         qjqQ==
X-Gm-Message-State: AA6/9RlKchPy8PJv8eBrLkmrz2CVW1k/W8ndznFSUI8J+fYGbnznB0fivBzuP8caFqruEEng
X-Received: by 10.55.68.81 with SMTP id r78mr20617523qka.310.1475874451092;
        Fri, 07 Oct 2016 14:07:31 -0700 (PDT)
Received: from LykOS.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-05.NATPOOL.NYU.EDU. [216.165.95.76])
        by smtp.gmail.com with ESMTPSA id a192sm7544808qkc.26.2016.10.07.14.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2016 14:07:30 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: [PATCH v4 5/7] builtin/tag: add --format argument for tag -v
Date:   Fri,  7 Oct 2016 17:07:19 -0400
Message-Id: <20161007210721.20437-6-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161007210721.20437-1-santiago@nyu.edu>
References: <20161007210721.20437-1-santiago@nyu.edu>
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
 builtin/tag.c             | 34 +++++++++++++++++++++++-----------
 builtin/verify-tag.c      |  2 +-
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 7ecca8e..3bb5e3c 100644
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
index 14f3b48..7730fd0 100644
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
+	return verify_and_format_tag(sha1, name, fmt_pretty, flags);
 }
 
 static int do_sign(struct strbuf *buffer)
@@ -334,7 +343,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct strbuf err = STRBUF_INIT;
 	struct ref_filter filter;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
-	const char *format = NULL;
+	char *format = NULL;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
@@ -424,9 +433,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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

