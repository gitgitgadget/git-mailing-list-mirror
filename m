Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267F020769
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965649AbcKJUfO (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:14 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35205 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965015AbcKJUe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:34:59 -0500
Received: by mail-pf0-f179.google.com with SMTP id i88so151080828pfk.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mne0/QVs1OKhE+t00sgr5UBeiokAIfLagiSnsVrtP1o=;
        b=CTqdjSNsWVx3C1U2y+TmHUCeswiRBL9Xb+6xOuFoW6REaAd9oTXEH1Jx7kAMk2zGPL
         1zrPI0d+fE6mEzZ3pS+bUD1L/mQZUFPwTPxN9zI/wHfRTCgPsruf3ZqBjDwGcCDmLkff
         29tHglLzO9ldC2HhvFoKuTxZXwbVzVHO2AicVBSgHMow8Gt2TndfXRi42GDBLNP07NIw
         M4BuIAjTCXfJH7R1qdDnkAFgyT4++b/y3t7IK98TozKRI6nrYGxlgTnPVpLwlTs0kWwi
         pmu9+RjKfxRwVpyc8lRnjepHJ6uJ+6KHPPd+1PeB5EUA0J1V+9r+kdAC4Wqx8aKWvdF/
         hUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mne0/QVs1OKhE+t00sgr5UBeiokAIfLagiSnsVrtP1o=;
        b=nFeL6dT3Crr9fhzsVt9h86UqgwENWf7/U25F5ACFGkE5a07cRIsuaTxHrE8j4zyGRm
         qt2UJmiT6w+/y9fOTEnKgGQGd9Yl9mv14x/osZAQ3RLZQVAaLtd/Knaeja7zTuTebhTN
         LxPSAAyUdVUgVowI/yhWZAUCTrTFdBJezQvGyYS6itw8qk/8luBt8CmjwTwlMVYhbqEs
         PsT1bNbOs7rR+r4f98Qj/pLckYIxe0rZaGenNBU9xbly4fFpZFjdrRCTz2jRYrrWW99i
         QObQucuQv2tdmP1flZani7QnhFo+E0J6yznqIeRGZGELUQFnb7TKnAb4/s3B+cnxKaCc
         evfw==
X-Gm-Message-State: ABUngvclA2zQTccCfcmwzu86zSRwFsy+w+DwBSulGXywszEMD+KmqKBxPn7riVcKU2yQk89G
X-Received: by 10.98.52.194 with SMTP id b185mr13391569pfa.41.1478810098726;
        Thu, 10 Nov 2016 12:34:58 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id yp3sm9328399pac.22.2016.11.10.12.34.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:34:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 17/35] attr: support quoting pathname patterns in C style
Date:   Thu, 10 Nov 2016 12:34:10 -0800
Message-Id: <20161110203428.30512-18-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 14bbfd4..88fcb7c 100644
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
2.10.1.469.g00a8914

