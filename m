Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 279581F405
	for <e@80x24.org>; Sat, 29 Dec 2018 05:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbeL2Fo0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 00:44:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39423 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeL2Fo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 00:44:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so10820261pgl.6
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 21:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WtUSX52Wm6Qq4G4WJ6SkCkYv66GpjHZamRfIZ5cJ7NY=;
        b=M82LkPLdEwif7vook/7qNik+zKA2rv+CtrngQgYsF/Tl33CwgVHl4Rn27sZh4hmTdM
         73X7ZM/s7yj/xBkdPIofdCBHZE0++0a+SC3jD9pEr/0Ps79Hq5UI2Hd71CI+huC0PftH
         5dXeYLr2mExDrAns66LuDDLyswFiNB45UEptocYbqEMfEyoa6srIMnvPkKTX4dlstQ+s
         HvfNLizYi+8/GwitpLoEY8DV7RJXT4I4fOAYlIgrxO8q3fkniglPCuP9UtY1HzyVVbP1
         RvL2/YT/G57EafH+EivfDPw9hTEDy7TzQEIGIY28QPE6qSr+87vT+rgb9jUmtCm+NpVk
         cgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WtUSX52Wm6Qq4G4WJ6SkCkYv66GpjHZamRfIZ5cJ7NY=;
        b=lGiqr/rLCMJ+NQ+bMW2tM3fFSiuAgEctkAA6UyJhxFUHblnJUW9lF1/kKSkfO+fwca
         x5ulbzOP0Pgxt0uAclaMBhaFnXduAINvTvjkgubqh5+OQRvifXF5ydFuY9DCe/9cxYKG
         LIyG/8cGwTYkDaitdArp1UR0wV8zbXWv4tOq+n8l+Otx3wgaISsQQ9hFX3zfQ0BUEkBu
         MlmyeZ2lvJnHhQy1Jujoq+jMDY4iq5Qturs7iFFrBnXDib74Q8mpIX5NDRDPRTzTc8ht
         XAAnSdB/kePnBtvB6j/DhwM5yUFChWjnAZighWN6tCu+SdGkJYEpvHoi6syroTbc0ZiX
         mKQw==
X-Gm-Message-State: AA+aEWYGq6xvNFIIsxoDa16BRJfE8SNO0ERnPtc51AwPyirW2XVKzZ/9
        mqXtx8ESPvW6wK726qwhURUwJJCT
X-Google-Smtp-Source: AFSGD/UWiP6733q/IWcQ5MtbgLp1/OdPgS++AKuRGDaJXucyf3BeekITVCQdhvPONYnDnGmjLvXC8A==
X-Received: by 2002:a62:81c1:: with SMTP id t184mr31457642pfd.40.1546062264519;
        Fri, 28 Dec 2018 21:44:24 -0800 (PST)
Received: from jet.home ([47.156.14.111])
        by smtp.gmail.com with ESMTPSA id h129sm72043249pfb.110.2018.12.28.21.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Dec 2018 21:44:23 -0800 (PST)
From:   Stan Hu <stanhu@gmail.com>
To:     git@vger.kernel.org, stanhu@gmail.com
Subject: [PATCH v3] sha1-name.c: Fix handling of revisions that contain paths with brackets
Date:   Fri, 28 Dec 2018 21:43:58 -0800
Message-Id: <20181229054357.11716-1-stanhu@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181224080651.GA12708@duynguyen.home>
References: <20181224080651.GA12708@duynguyen.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, calling ls-tree with a revision such as
`master^{tree}:foo/{{path}}` would show the root tree instead of the
correct tree pointed by foo/{{path}}. We improve this by ensuring
peel_onion() consumes all "len" characters or none.

Note that it's also possible to have directories named ^{tree} and other
patterns that look like type restrictions. To handle those cases, scan
from the beginning of the name instead of the end.

Signed-off-by: Stan Hu <stanhu@gmail.com>
---
 sha1-name.c               | 35 ++++++++++--------
 t/t3104-ls-tree-braces.sh | 75 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 14 deletions(-)
 create mode 100755 t/t3104-ls-tree-braces.sh

diff --git a/sha1-name.c b/sha1-name.c
index faa60f69e3..ab372a90be 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -989,7 +989,7 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 		      unsigned lookup_flags)
 {
 	struct object_id outer;
-	const char *sp;
+	const char *sp, *end;
 	unsigned int expected_type = 0;
 	struct object *o;
 
@@ -1001,33 +1001,40 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 	 * "ref^{commit}".  "commit^{tree}" could be used to find the
 	 * top-level tree of the given commit.
 	 */
-	if (len < 4 || name[len-1] != '}')
+	if (len < 4)
 		return -1;
 
-	for (sp = name + len - 1; name <= sp; sp--) {
+	for (sp = name; sp < name + len; sp++) {
 		int ch = *sp;
-		if (ch == '{' && name < sp && sp[-1] == '^')
+		if (ch == '^' && sp < name + len && sp[1] == '{')
 			break;
 	}
-	if (sp <= name)
+
+	if (sp == name + len)
 		return -1;
 
-	sp++; /* beginning of type name, or closing brace for empty */
-	if (starts_with(sp, "commit}"))
+	sp += 2; /* beginning of type name, or closing brace for empty */
+
+	if (skip_prefix(sp, "commit}", &end))
 		expected_type = OBJ_COMMIT;
-	else if (starts_with(sp, "tag}"))
+	else if (skip_prefix(sp, "tag}", &end))
 		expected_type = OBJ_TAG;
-	else if (starts_with(sp, "tree}"))
+	else if (skip_prefix(sp, "tree}", &end))
 		expected_type = OBJ_TREE;
-	else if (starts_with(sp, "blob}"))
+	else if (skip_prefix(sp, "blob}", &end))
 		expected_type = OBJ_BLOB;
-	else if (starts_with(sp, "object}"))
+	else if (skip_prefix(sp, "object}", &end))
 		expected_type = OBJ_ANY;
-	else if (sp[0] == '}')
+	else if (sp[0] == '}') {
 		expected_type = OBJ_NONE;
-	else if (sp[0] == '/')
+		end = sp + 1;
+	} else if (sp[0] == '/') {
 		expected_type = OBJ_COMMIT;
-	else
+		end = name + len;
+	} else
+		return -1;
+
+	if (end != name + len)
 		return -1;
 
 	lookup_flags &= ~GET_OID_DISAMBIGUATORS;
diff --git a/t/t3104-ls-tree-braces.sh b/t/t3104-ls-tree-braces.sh
new file mode 100755
index 0000000000..adeed5bb49
--- /dev/null
+++ b/t/t3104-ls-tree-braces.sh
@@ -0,0 +1,75 @@
+#!/bin/sh
+
+test_description='ls-tree with folders with brackets'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir -p "newdir/{{curly}}" &&
+	mkdir -p "newdir/^{tree}" &&
+	touch "newdir/{{curly}}/one" &&
+	touch "newdir/^{tree}/two" &&
+	git add "newdir/{{curly}}/one" &&
+	git add "newdir/^{tree}/two" &&
+	git commit -m "Test message: search me"
+'
+
+test_expect_success 'ls-tree with curly brace folder' '
+	cat >expect <<-EOF &&
+	100644 blob $EMPTY_BLOB	one
+	EOF
+	git ls-tree -r "HEAD:newdir/{{curly}}" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-tree with type restriction and curly brace folder' '
+	cat >expect <<-EOF &&
+	100644 blob $EMPTY_BLOB	one
+	EOF
+	git ls-tree "HEAD^{tree}:newdir/{{curly}}" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-tree with type restriction and folder named ^{tree}' '
+	cat >expect <<-EOF &&
+	100644 blob $EMPTY_BLOB	two
+	EOF
+	git ls-tree "HEAD^{tree}:newdir/^{tree}" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-tree with unknown type restriction' '
+	(git ls-tree HEAD^{foobar} >actual || true) &&
+	test_must_be_empty actual
+'
+
+test_output () {
+	sed -e "s/ $OID_REGEX	/ X	/" <actual >check
+	test_cmp expect check
+}
+
+test_expect_success 'ls-tree with regex' '
+	cat >expect <<-EOF &&
+	040000 tree X	newdir
+	EOF
+	git ls-tree "HEAD^{/message}" >actual &&
+	test_output
+'
+
+test_expect_success 'ls-tree with regex with a colon' '
+	cat >expect <<-EOF &&
+	040000 tree X	newdir
+	EOF
+	git ls-tree "HEAD^{/message: search}" >actual &&
+	test_output
+'
+
+test_expect_success 'ls-tree with regex and curly brace folder' '
+	cat >expect <<-EOF &&
+	100644 blob $EMPTY_BLOB	one
+	EOF
+	git ls-tree "HEAD^{/message: search}:newdir/{{curly}}" >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.19.1

