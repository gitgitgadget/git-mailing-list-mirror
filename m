Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A13D206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 18:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753737AbcLLSRG (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 13:17:06 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34170 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753656AbcLLSRD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 13:17:03 -0500
Received: by mail-pg0-f52.google.com with SMTP id x23so37842613pgx.1
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 10:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mv8ehLzPiU/DsxO2RDtsjKM7no3qbyM1FB+xR4Z4/nY=;
        b=b9SCEfmGuv9+qk+4TfoQkwSkxzqTgg+H2MUgAcoLT5GglZeI7oE9n1tv7OspiSA6oO
         lDPX2DaA6LCpkZMgYWVgd+DHvdeVOrgMv+/VGt6kO3UWAIhzuAzoj7jr0i/QHEGS8vdO
         oGz5/g04pmJjWJClqKDRStn2dFDCG2siFqj7c9923CN9YKQse9OsIWuOd3OQlPW6uRCA
         w7Pc2cUzu/hfjWHKR8wcDvocIdaWVpoH4e+2ECXTZmiHgbzXeW1SDUVLegncUNSqwaAY
         Ww14ZO8CyUZ5cGPFyzguVhlsUfnhf7oq/vUrJfJZpppcGXBZXLY3QvO2lis6BVTfBfx/
         D5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mv8ehLzPiU/DsxO2RDtsjKM7no3qbyM1FB+xR4Z4/nY=;
        b=P6ARZrQWgl3kpPQe+s59IZRWeHc7GSV7SFNSHnDUDzQ5HLMH/tVa+GNGOjMkne1zcN
         bnnw0gEvK6V5Il7a/W+BxU+aQysa28cJDPJdQcUQVYKTZCYN/yyGtmJ7dNdWuxw3ej+k
         4faNElqZJ0SaZbtTHVbl8aeWICq3lernplQlkr+hnivj/0Gc6UPyZn16KFg4UF/xYMDY
         HASBIzMpmvhXCy4KPjbrM7n6R8uqNbdiSSejCsuvPqf+QGrUdu1QZdmmokT4X5cp8ySt
         PhZmaNERfHdd0MC7hmlvO5fAvCwzo1uOKfTAOtM3Ieurb03l/7Cg1+FjXpuGI7dISBFB
         Dsew==
X-Gm-Message-State: AKaTC01b0ln9E+I7F4LqUvNnoKFqYitAQvZmcNjfPdaWW8/5za2zwlh+q4bnrnw+Urmpp9tA
X-Received: by 10.99.22.65 with SMTP id 1mr168175229pgw.70.1481566622661;
        Mon, 12 Dec 2016 10:17:02 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y66sm77644889pgb.21.2016.12.12.10.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 10:17:01 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, j6t@kdbg.org,
        pclouds@gmail.com
Subject: [PATCH v3 0/4] road to reentrant real_path
Date:   Mon, 12 Dec 2016 10:16:51 -0800
Message-Id: <1481566615-75299-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481241494-6861-1-git-send-email-bmwill@google.com>
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v3:

* Rewrite of `strip_last_component()` as the v2 verison didn't properly handle
  inputs like '/foo'.  Thanks to Johannes for pointing this out and suggesting
  a solution.
* Small style changes
* Revert the call in `get_common_dir_noenv()` to maintain proper functionality.

Brandon Williams (4):
  real_path: resolve symlinks by hand
  real_path: convert real_path_internal to strbuf_realpath
  real_path: create real_pathdup
  real_path: have callers use real_pathdup and strbuf_realpath

 abspath.c         | 222 ++++++++++++++++++++++++++++++++++++------------------
 builtin/init-db.c |   6 +-
 cache.h           |   3 +
 environment.c     |   2 +-
 setup.c           |  13 ++--
 sha1_file.c       |   2 +-
 submodule.c       |   2 +-
 transport.c       |   2 +-
 worktree.c        |   2 +-
 9 files changed, 169 insertions(+), 85 deletions(-)

--- interdiff from v2

diff --git a/abspath.c b/abspath.c
index df37356..79ee310 100644
--- a/abspath.c
+++ b/abspath.c
@@ -14,10 +14,17 @@ int is_directory(const char *path)
 /* removes the last path component from 'path' except if 'path' is root */
 static void strip_last_component(struct strbuf *path)
 {
-	if (path->len > offset_1st_component(path->buf)) {
-		char *last_slash = find_last_dir_sep(path->buf);
-		strbuf_setlen(path, last_slash - path->buf);
-	}
+	size_t offset = offset_1st_component(path->buf);
+	size_t len = path->len;
+
+	/* Find start of the last component */
+	while (offset < len && !is_dir_sep(path->buf[len - 1]))
+		len--;
+	/* Skip sequences of multiple path-separators */
+	while (offset < len && is_dir_sep(path->buf[len - 1]))
+		len--;
+
+	strbuf_setlen(path, len);
 }
 
 /* get (and remove) the next component in 'remaining' and place it in 'next' */
@@ -112,7 +119,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 
 		if (lstat(resolved->buf, &st)) {
 			/* error out unless this was the last component */
-			if (!(errno == ENOENT && !remaining.len)) {
+			if (errno != ENOENT || remaining.len) {
 				if (die_on_error)
 					die_errno("Invalid path '%s'",
 						  resolved->buf);
@@ -203,7 +210,7 @@ char *real_pathdup(const char *path)
 	struct strbuf realpath = STRBUF_INIT;
 	char *retval = NULL;
 
-	if(strbuf_realpath(&realpath, path, 0))
+	if (strbuf_realpath(&realpath, path, 0))
 		retval = strbuf_detach(&realpath, NULL);
 
 	strbuf_release(&realpath);
diff --git a/setup.c b/setup.c
index 0d9fdd0..1b534a7 100644
--- a/setup.c
+++ b/setup.c
@@ -254,7 +254,7 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
 		if (!is_absolute_path(data.buf))
 			strbuf_addf(&path, "%s/", gitdir);
 		strbuf_addbuf(&path, &data);
-		strbuf_realpath(sb, path.buf, 1);
+		strbuf_addstr(sb, real_path(path.buf));
 		ret = 1;
 	} else {
 		strbuf_addstr(sb, gitdir);

-- 
2.8.0.rc3.226.g39d4020

