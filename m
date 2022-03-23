Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BEBC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 09:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243087AbiCWJP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243078AbiCWJPY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 05:15:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A925675E70
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:46 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n7-20020a17090aab8700b001c6aa871860so1160599pjq.2
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zj9pkTsFlErJXEhnU3DaQ6sNjOOJhZ5dYfJBZ0HaiNw=;
        b=YX4vt0r5QiTPbcernH11cO3rbUCWzEKCiSeuK3OrHYXJLghqNiH05d2228+oDNLjpI
         KUN6HG+k+EylnMTfPV975sWRbcn+8Ohb9fKpMNbSPNf/4FVpEa7nAPkhZFPceAE/FCtH
         SP9xUyIL8DJA8AoC5UIlB5ONYSDSfIms/iNhEljpKdMv72en9ix4PzpK2IZ8YY3DiphS
         YCxDTVPgNgsYDMu2xSJnthkTJESRyo4wOeNg7m3J2mcT9sYRrc0yhviZCZGnc9Kg/vHF
         I3s3b4s3pqR+BR8grCcNAqdUCtNFbjG1jz9plerdQSp1eTki6hquUSP+lu4rI83RA2xz
         iyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zj9pkTsFlErJXEhnU3DaQ6sNjOOJhZ5dYfJBZ0HaiNw=;
        b=d0QerILjRLtpWRecSZVfNH1BJ31C2Ng+sO9oStosdc3o2DuPRuFv7We9YhAfeq2wOd
         350uswpAPSr192gYlrF7Rz6l/YGnEDwByoqvmCfFAVr6InhFaM2mfeB4W6s3UkSfMW29
         45zv+kjkDSW1rTODvdPiFLIhHmOrQhJ6Vra/kM4fuwfcgzmznF4Sas4uzRuTJ3oWVwk9
         9RuZ0Jt7jxVFLDzUaQVs85+22a2CTbqz6kNcTwR+GehZx/wfwrfl/p9n2aMttZVgAGfq
         I1JoOOp9bbD5GbrBefzL6dJd2IZnPpsSv0Y0NGpXbKwQ5qY1vSR5zNLxzclYlGTOXZvH
         5Jrg==
X-Gm-Message-State: AOAM533YrOjAHZKtute6HkrYlBoz3rY+9AGiWEUZpefoewXiHeMGOAcx
        7UXtnSD4Sg+Gz/8gIzpa/lc=
X-Google-Smtp-Source: ABdhPJyHusehLEZj1D6UAImTIh0NdREbgbmGSWiK+sR10atMLpjvuMGc9IT3t2XK5n39lk/dzO7kVg==
X-Received: by 2002:a17:902:f643:b0:14d:7b8f:14b3 with SMTP id m3-20020a170902f64300b0014d7b8f14b3mr22610865plg.19.1648026826144;
        Wed, 23 Mar 2022 02:13:46 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id s135-20020a63778d000000b0038259e54389sm10224261pgc.19.2022.03.23.02.13.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:13:45 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v14 09/15] ls-tree: slightly refactor `show_tree()`
Date:   Wed, 23 Mar 2022 17:13:09 +0800
Message-Id: <f4fc377dfa8b5c979740d8916a3ed8f8089957bb.1648026472.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.404.g92931a4a2c.dirty
In-Reply-To: <cover.1648026472.git.dyroneteng@gmail.com>
References: <cover.1648026472.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a non-functional change, we introduce an enum "ls_tree_cmdmode"
then use it to mark which columns to output.

This has the advantage of making the show_tree logic simpler and more
readable, as well as making it easier to extend new options (for example,
if we want to add a "--object-only" option, we just need to add a similar
"short-circuit logic in "show_tree()").

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c | 98 +++++++++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 37 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 7be4c13228..173a534e92 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -16,10 +16,8 @@
 
 static int line_termination = '\n';
 #define LS_RECURSIVE 1
-#define LS_TREE_ONLY 2
-#define LS_SHOW_TREES 4
-#define LS_NAME_ONLY 8
-#define LS_SHOW_SIZE 16
+#define LS_TREE_ONLY (1 << 1)
+#define LS_SHOW_TREES (1 << 2)
 static int abbrev;
 static int ls_options;
 static struct pathspec pathspec;
@@ -31,6 +29,11 @@ static const  char * const ls_tree_usage[] = {
 	NULL
 };
 
+static enum ls_tree_cmdmode {
+	MODE_LONG = 1,
+	MODE_NAME_ONLY,
+} cmdmode;
+
 static int show_recursive(const char *base, size_t baselen, const char *pathname)
 {
 	int i;
@@ -61,6 +64,39 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 	return 0;
 }
 
+static int show_default(const struct object_id *oid, enum object_type type,
+			const char *pathname, unsigned mode,
+			struct strbuf *base)
+{
+	size_t baselen = base->len;
+
+	if (cmdmode == MODE_LONG) {
+		char size_text[24];
+		if (type == OBJ_BLOB) {
+			unsigned long size;
+			if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
+				xsnprintf(size_text, sizeof(size_text), "BAD");
+			else
+				xsnprintf(size_text, sizeof(size_text),
+					  "%" PRIuMAX, (uintmax_t)size);
+		} else {
+			xsnprintf(size_text, sizeof(size_text), "-");
+		}
+		printf("%06o %s %s %7s\t", mode, type_name(type),
+		find_unique_abbrev(oid, abbrev), size_text);
+	} else {
+		printf("%06o %s %s\t", mode, type_name(type),
+		find_unique_abbrev(oid, abbrev));
+	}
+	baselen = base->len;
+	strbuf_addstr(base, pathname);
+	write_name_quoted_relative(base->buf,
+				   chomp_prefix ? ls_tree_prefix : NULL, stdout,
+				   line_termination);
+	strbuf_setlen(base, baselen);
+	return 1;
+}
+
 static int show_tree(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, void *context)
 {
@@ -78,34 +114,22 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 			return recurse;
 	}
 
-	if (!(ls_options & LS_NAME_ONLY)) {
-		if (ls_options & LS_SHOW_SIZE) {
-			char size_text[24];
-			if (type == OBJ_BLOB) {
-				unsigned long size;
-				if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
-					xsnprintf(size_text, sizeof(size_text),
-						  "BAD");
-				else
-					xsnprintf(size_text, sizeof(size_text),
-						  "%"PRIuMAX, (uintmax_t)size);
-			} else {
-				xsnprintf(size_text, sizeof(size_text), "-");
-			}
-			printf("%06o %s %s %7s\t", mode, type_name(type),
-			       find_unique_abbrev(oid, abbrev),
-			       size_text);
-		} else {
-			printf("%06o %s %s\t", mode, type_name(type),
-			       find_unique_abbrev(oid, abbrev));
-		}
+	if (cmdmode == MODE_NAME_ONLY) {
+		baselen = base->len;
+		strbuf_addstr(base, pathname);
+		write_name_quoted_relative(base->buf,
+					   chomp_prefix ? ls_tree_prefix : NULL,
+					   stdout, line_termination);
+		strbuf_setlen(base, baselen);
+		return recurse;
 	}
-	baselen = base->len;
-	strbuf_addstr(base, pathname);
-	write_name_quoted_relative(base->buf,
-				   chomp_prefix ? ls_tree_prefix : NULL,
-				   stdout, line_termination);
-	strbuf_setlen(base, baselen);
+
+	if (cmdmode == MODE_LONG ||
+		(!ls_options || (ls_options & LS_RECURSIVE)
+		 || (ls_options & LS_SHOW_TREES)
+		 || (ls_options & LS_TREE_ONLY)))
+			 show_default(oid, type, pathname, mode, base);
+
 	return recurse;
 }
 
@@ -123,12 +147,12 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			LS_SHOW_TREES),
 		OPT_SET_INT('z', NULL, &line_termination,
 			    N_("terminate entries with NUL byte"), 0),
-		OPT_CMDMODE('l', "long", &ls_options, N_("include object size"),
-			    LS_SHOW_SIZE),
-		OPT_CMDMODE(0, "name-only", &ls_options, N_("list only filenames"),
-			    LS_NAME_ONLY),
-		OPT_CMDMODE(0, "name-status", &ls_options, N_("list only filenames"),
-			    LS_NAME_ONLY),
+		OPT_CMDMODE('l', "long", &cmdmode, N_("include object size"),
+			    MODE_LONG),
+		OPT_CMDMODE(0, "name-only", &cmdmode, N_("list only filenames"),
+			    MODE_NAME_ONLY),
+		OPT_CMDMODE(0, "name-status", &cmdmode, N_("list only filenames"),
+			    MODE_NAME_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
 			    N_("use full path names"), 0),
 		OPT_BOOL(0, "full-tree", &full_tree,
-- 
2.34.1.404.g92931a4a2c.dirty

