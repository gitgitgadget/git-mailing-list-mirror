Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90D0720986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965014AbcJVXdO (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:33:14 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35595 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964974AbcJVXdH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:07 -0400
Received: by mail-it0-f42.google.com with SMTP id 198so53158015itw.0
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IBkmQWNlIFS99hCTVdsl8B1CeLGsZHgpvwKdwJqyWEA=;
        b=REzKiB5eoE1OdMxk/fKwjeSA2zywJxvn9nxtczr30sal7R1/jOe0bxuSKK5Tx13q8Z
         ci0TrP28/Fmko2827sivwPCWR+RezoTCIjqLsXsHlBnW3aFSKhfkCz9+mZTi0PP0/Vj4
         m3BX93DWA4N+FYl0aqhRnDPzq74HJN3xAQRqS+1N2/L8lRHLrpoGWx8FlVAqL+/qOlby
         bmCwjN54zKBc4Sj2QsGPi7gcejHXeaFjKwsIS69CUHSX1rPr0pQxo59k812W5vtSjkmD
         R2EYeBuSM4cx9hHT0G8qhWEly4oZOHZUbFsMkrl7VWe6R20uaQ8FEMpfBpxxwJCJrB9D
         OmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBkmQWNlIFS99hCTVdsl8B1CeLGsZHgpvwKdwJqyWEA=;
        b=KEDzDwAPnY/pfIvV8rbJLVMtbPTJBy64aBDVAFUdB8GJqZYjBNM+VryAyJGUp1984G
         xzEjyDd0ccTnDZuc5FozfkdKv/FG8IgGF9AuSKvEDYbx7YIFdeQ1fxB2pjBabkITswpk
         2F7wp+U4Xvrku/jJrOC6rsyVrWLbxarH9Y0MV/FPlFUnyDw309U3R47l8xDdh2WJzB5X
         HsNh4YLwEmZXIax3YRWOWPx3B28XZR9TEQwA9XW1KvUqyrPeYmRk66NeY8sI2JhitWGz
         zFGavTNxgD2mXG1MT/+Q/cuEYPfetThA1tgCHw+mTJ65kiMl89XjDhU4Qxt25b/j8zqx
         C8Ig==
X-Gm-Message-State: ABUngvewbgGEIBoG17J/AF4uW7EdXf/6mAX6CJEVGT+VmINXcMdQNsgDe7qULwhzGSzYkpgU
X-Received: by 10.107.160.20 with SMTP id j20mr7313647ioe.27.1477179186681;
        Sat, 22 Oct 2016 16:33:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id h90sm4569299iod.18.2016.10.22.16.33.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:33:06 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 18/36] attr: support quoting pathname patterns in C style
Date:   Sat, 22 Oct 2016 16:32:07 -0700
Message-Id: <20161022233225.8883-19-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

Full pattern must be quoted. So 'pat"t"ern attr' will give exactly
'pat"t"ern', not 'pattern'. Also clarify that leading whitespaces are
not part of the pattern and document comment syntax.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/gitattributes.txt |  8 +++++---
 attr.c                          | 15 +++++++++++++--
 t/t0003-attributes.sh           | 26 ++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 7aff940..8a061af 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -21,9 +21,11 @@ Each line in `gitattributes` file is of form:
 	pattern	attr1 attr2 ...
 
 That is, a pattern followed by an attributes list,
-separated by whitespaces.  When the pattern matches the
-path in question, the attributes listed on the line are given to
-the path.
+separated by whitespaces. Leading and trailing whitespaces are
+ignored. Lines that begin with '#' are ignored. Patterns
+that begin with a double quote are quoted in C style.
+When the pattern matches the path in question, the attributes
+listed on the line are given to the path.
 
 Each attribute can be in one of these states for a given path:
 
diff --git a/attr.c b/attr.c
index 659dc41..eba582b 100644
--- a/attr.c
+++ b/attr.c
@@ -13,6 +13,7 @@
 #include "attr.h"
 #include "dir.h"
 #include "utf8.h"
+#include "quote.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
@@ -225,12 +226,21 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 	const char *cp, *name, *states;
 	struct match_attr *res = NULL;
 	int is_macro;
+	struct strbuf pattern = STRBUF_INIT;
 
 	cp = line + strspn(line, blank);
 	if (!*cp || *cp == '#')
 		return NULL;
 	name = cp;
-	namelen = strcspn(name, blank);
+
+	if (*cp == '"' && !unquote_c_style(&pattern, name, &states)) {
+		name = pattern.buf;
+		namelen = pattern.len;
+	} else {
+		namelen = strcspn(name, blank);
+		states = name + namelen;
+	}
+
 	if (strlen(ATTRIBUTE_MACRO_PREFIX) < namelen &&
 	    starts_with(name, ATTRIBUTE_MACRO_PREFIX)) {
 		if (!macro_ok) {
@@ -250,7 +260,6 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 	else
 		is_macro = 0;
 
-	states = name + namelen;
 	states += strspn(states, blank);
 
 	/* First pass to count the attr_states */
@@ -293,9 +302,11 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 			cannot_trust_maybe_real = 1;
 	}
 
+	strbuf_release(&pattern);
 	return res;
 
 fail_return:
+	strbuf_release(&pattern);
 	free(res);
 	return NULL;
 }
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f0fbb42..f19ae4f 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -13,10 +13,31 @@ attr_check () {
 	test_line_count = 0 err
 }
 
+attr_check_quote () {
+
+	path="$1"
+	quoted_path="$2"
+	expect="$3"
+
+	git check-attr test -- "$path" >actual &&
+	echo "\"$quoted_path\": test: $expect" >expect &&
+	test_cmp expect actual
+
+}
+
+test_expect_success 'open-quoted pathname' '
+	echo "\"a test=a" >.gitattributes &&
+	test_must_fail attr_check a a
+'
+
+
 test_expect_success 'setup' '
 	mkdir -p a/b/d a/c b &&
 	(
 		echo "[attr]notest !test"
+		echo "\" d \"	test=d"
+		echo " e	test=e"
+		echo " e\"	test=e"
 		echo "f	test=f"
 		echo "a/i test=a/i"
 		echo "onoff test -test"
@@ -69,6 +90,11 @@ test_expect_success 'command line checks' '
 '
 
 test_expect_success 'attribute test' '
+
+	attr_check " d " d &&
+	attr_check e e &&
+	attr_check_quote e\" e\\\" e &&
+
 	attr_check f f &&
 	attr_check a/f f &&
 	attr_check a/c/f f &&
-- 
2.10.1.508.g6572022

