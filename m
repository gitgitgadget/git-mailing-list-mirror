Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEF7220A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751605AbdAWUfz (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:35:55 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:32812 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751550AbdAWUfw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:35:52 -0500
Received: by mail-pg0-f46.google.com with SMTP id 204so47798588pge.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y8AclS5Yr/ayzoJKwXwIAgkpFAG3mkJFELI91DfHeTI=;
        b=prQTL6EtOkWycmD7qAeHGHZvbLbpUfsbiHj8KsBZ4LAUJ/IGpEAuU2APuddjAfTJu8
         xYnVmFaxAzs8FbOtGvWwgrLUZLYvCwJ++LNDrFCwdQJM3/bAvjgG6ax2xR5YOtslch+z
         LCd7uMzKh9VQFFXszLM4MSX72orFFs6t2FcKf9jxFKTcYc/mNt+qA9dg3pCuV9tMrHYW
         se8V2crX+UBVj3gYIooyYl0qt4LNpIjsdVRdOkDVomfsrI6sijftA4IMwFXFB5GJyafk
         2xM26ZKj7XwCl1YkCG7ojxCQWcKDo5yV5faE0QYbsxVeVp0YXG0L7qpA3L1qhQdax2/w
         hnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y8AclS5Yr/ayzoJKwXwIAgkpFAG3mkJFELI91DfHeTI=;
        b=Vmf+CfPvlHECFCabdFJ+trhSgXcUnrOjfrU0Dvz3XSA85Ea9mMmyAmT4YHqj/yPDs2
         ECrvOlwC8csdxf3L0Esu8/HEfCTPCnwzlEsQTE7J1aNZFZERXCOr85HSQKRxbKcEN65Q
         yNav32Ce7kvQzTLBjkXT9VIiFPMrPkaHlCvSlYYqWoGDDvzI+QE/uo16Grcjbyj+jhiI
         EzFW6dLcbEFchc6ybPPkROHscrMjml/g+2hlCN6LSPagM+zaPSvMsSz+wQrQWnXVHier
         LOGbPccCITDgFjmGOeJxgXb2g4f2coNs73Y7TTVXzQlB+xnYdKrBocs/yR6WZxmKzLCD
         I40w==
X-Gm-Message-State: AIkVDXKPXHmnPF/qJ9BNJ3DnhqO0jtHIIAXOxsXDnHy638xG21vTyQL9RzyJuTknZAdno9K/
X-Received: by 10.98.149.93 with SMTP id p90mr34535762pfd.72.1485203751962;
        Mon, 23 Jan 2017 12:35:51 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:35:51 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, sbeller@google.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 10/27] attr: support quoting pathname patterns in C style
Date:   Mon, 23 Jan 2017 12:35:08 -0800
Message-Id: <20170123203525.185058-11-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
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
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/gitattributes.txt |  8 +++++---
 attr.c                          | 15 +++++++++++++--
 t/t0003-attributes.sh           | 26 ++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e0b66c122..3173dee7e 100644
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
index d180c7833..e1c630f79 100644
--- a/attr.c
+++ b/attr.c
@@ -13,6 +13,7 @@
 #include "attr.h"
 #include "dir.h"
 #include "utf8.h"
+#include "quote.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
@@ -212,12 +213,21 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
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
@@ -239,7 +249,6 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 	else
 		is_macro = 0;
 
-	states = name + namelen;
 	states += strspn(states, blank);
 
 	/* First pass to count the attr_states */
@@ -282,9 +291,11 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
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
index f0fbb4255..f19ae4f8c 100755
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
2.11.0.483.g087da7b7c-goog

