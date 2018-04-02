Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B51F91F404
	for <e@80x24.org>; Mon,  2 Apr 2018 00:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754096AbeDBAxE (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 20:53:04 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38854 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753988AbeDBAxD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 20:53:03 -0400
Received: by mail-lf0-f65.google.com with SMTP id u3-v6so18604418lff.5
        for <git@vger.kernel.org>; Sun, 01 Apr 2018 17:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IqbkyiSQYE8mOwCJVPBz+BSIpLIMaCqLXsQKgUrqzso=;
        b=GdTpa6oqWzTtTcGqWr64ckVp8TYHuzffSXdMyctYRVwYuMxbyZ0f9H9qWIWCjRatn4
         x7blGdFO7u8pJTDIe5RdBxDdaWIANve3CeyOeAN9hMust0fTxQQ7WK5ZsHdptfPx4wkn
         djWQtK0wQLaPGmDlLxQNPkqTWBt1aF3DD/C5Mws+624eYDztz/kRHYtSS2drYDDK+xsX
         orn9EsWMNzcuhtDCSH3+vsdMK2Wpd7AKSZ0mG2vdHybmuNvV90jdLxd02lr8EqxRUT/c
         wRlleh/aWUm1/4fdwrYJnImh+iXDKqfUJNcUgYT8MYyLaK1yGX6WKz+H2tVFQ5aDfYB7
         Q+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IqbkyiSQYE8mOwCJVPBz+BSIpLIMaCqLXsQKgUrqzso=;
        b=XiG1wS7Xg2QNzX54uzICmsET2fYCIHcF7Muszzpyilo3i29ERPUApYt/yFs4XnJ9yq
         25Ry9T5DvoF4SYb21YDcDp3fPFXufrFLWKyJ3wrJrvyLrfR711QqclyC6eJ176rX3ZGM
         jFERnU8izkpSh/ynevUKfYAg920XxytovNuSB66WG4VZON1yf5JvZm4wWqs01/f+8kko
         WhfhYO0vDTZqLx9iS3yDjB7d0jApo49g4uLmv+Uv7P8b0YHqg8vZOzeIxLw1MJwwE/4X
         eAJAHfX6C9NEdfL5ucqeqpc0i4gmeLnpcRA8ad30KvLrVn0pjEOXXHjWpn04TytlVtgc
         CghA==
X-Gm-Message-State: ALQs6tDgbZgChobOp4ELMO3bHr4wGYeNVM3ulP0xAFjiIITLON+f+utv
        XI3nJB/P453CpiuDcYiUlBmPZYED
X-Google-Smtp-Source: AIpwx48aKowP8yUZnCzQIi/VAQ5y1IPrGIpioE/ZVjecNht0hR2m5cS2whhP9b9qljxC05vqccNmMg==
X-Received: by 10.46.99.93 with SMTP id x90mr4792218ljb.2.1522630381524;
        Sun, 01 Apr 2018 17:53:01 -0700 (PDT)
Received: from localhost.localdomain ([94.234.36.18])
        by smtp.gmail.com with ESMTPSA id h68-v6sm2755528lfk.67.2018.04.01.17.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Apr 2018 17:53:00 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH] ls-remote: create option to sort by versions
Date:   Mon,  2 Apr 2018 02:52:48 +0200
Message-Id: <20180402005248.52418-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create the options '-V ' and '--version-sort' to sort
'git ls-remote' output by version semantics. This is useful e.g. for
the Go repository after the release of version 1.10, where otherwise
v1.10 is sorted before v1.2. See:

	$ git ls-remote -t https://go.googlesource.com/go
	...
	205f850ceacfc39d1e9d76a9569416284594ce8c	refs/tags/go1.1
	d260448f6b6ac10efe4ae7f6dfe944e72bc2a676	refs/tags/go1.1.1
	1d6d8fca241bb611af51e265c1b5a2e9ae904702	refs/tags/go1.1.2
	bf86aec25972f3a100c3aa58a6abcbcc35bdea49	refs/tags/go1.10
	ac7c0ee26dda18076d5f6c151d8f920b43340ae3	refs/tags/go1.10.1
	9ce6b5c2ed5d3d5251b9a6a0c548d5fb2c8567e8	refs/tags/go1.10beta1
	594668a5a96267a46282ce3007a584ec07adf705	refs/tags/go1.10beta2
	5348aed83e39bd1d450d92d7f627e994c2db6ebf	refs/tags/go1.10rc1
	20e228f2fdb44350c858de941dff4aea9f3127b8	refs/tags/go1.10rc2
	1c5438aae896edcd1e9f9618f4776517f08053b3	refs/tags/go1.1rc2
	46a6097aa7943a490e9bd2e04274845d0e5e200f	refs/tags/go1.1rc3
	402d3590b54e4a0df9fb51ed14b2999e85ce0b76	refs/tags/go1.2
	9c9802fad57c1bcb72ea98c5c55ea2652efc5772	refs/tags/go1.2.1
	...

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/ls-remote.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 540d56429..740c6f117 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "transport.h"
+#include "ref-filter.h"
 #include "remote.h"
 
 static const char * const ls_remote_usage[] = {
@@ -33,11 +34,20 @@ static int tail_match(const char **pattern, const char *path)
 	return 0;
 }
 
+static int cmp_ref_versions(const void *_a, const void *_b)
+{
+	const struct ref *a = *(const struct ref **)_a;
+	const struct ref *b = *(const struct ref **)_b;
+
+	return versioncmp(a->name, b->name);
+}
+
 int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 {
 	const char *dest = NULL;
 	unsigned flags = 0;
 	int get_url = 0;
+	int version_sort = 0;
 	int quiet = 0;
 	int status = 0;
 	int show_symref_target = 0;
@@ -47,6 +57,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	struct remote *remote;
 	struct transport *transport;
 	const struct ref *ref;
+	const struct ref **refs = NULL;
+	int nr = 0;
 
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("do not print remote URL")),
@@ -60,6 +72,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
 		OPT_BOOL(0, "get-url", &get_url,
 			 N_("take url.<base>.insteadOf into account")),
+		OPT_BOOL('V', "version-sort", &version_sort,
+			 N_("sort tags by version numbers")),
 		OPT_SET_INT_F(0, "exit-code", &status,
 			      N_("exit with exit code 2 if no matching refs are found"),
 			      2, PARSE_OPT_NOCOMPLETE),
@@ -101,13 +115,22 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (transport_disconnect(transport))
 		return 1;
 
-	if (!dest && !quiet)
-		fprintf(stderr, "From %s\n", *remote->url);
 	for ( ; ref; ref = ref->next) {
 		if (!check_ref_type(ref, flags))
 			continue;
 		if (!tail_match(pattern, ref->name))
 			continue;
+		REALLOC_ARRAY(refs, nr + 1);
+		refs[nr++] = ref;
+	}
+
+	if (version_sort)
+		QSORT(refs, nr, cmp_ref_versions);
+
+	if (!dest && !quiet)
+		fprintf(stderr, "From %s\n", *remote->url);
+	for (int i = 0; i < nr; i++) {
+		const struct ref *ref = refs[i];
 		if (show_symref_target && ref->symref)
 			printf("ref: %s\t%s\n", ref->symref, ref->name);
 		printf("%s\t%s\n", oid_to_hex(&ref->old_oid), ref->name);
-- 
2.14.3 (Apple Git-98)

