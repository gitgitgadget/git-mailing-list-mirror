Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4A6B20A1E
	for <e@80x24.org>; Sun, 23 Dec 2018 23:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbeLWXhp (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Dec 2018 18:37:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38622 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeLWXhp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Dec 2018 18:37:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so4935286plb.5
        for <git@vger.kernel.org>; Sun, 23 Dec 2018 15:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gW3WRnHnznxkSUO/5SwoVuAVcv0jZtAWW4s72qzvM4E=;
        b=HTQr2kx9boS0ykuRmVS/NsrZQ8RpH9FsgoVYgQLDwbNxC46xdSe8MygWL7oKhR4sHA
         XdY7shL/TNXVUnGtCav3mwTn5RMsQcvNiM4KUV3mKy86Hud2tBbUDU94mBo+UQlS514R
         xZ5KaYUeOXE7DZodlDazH+Ot9sE8e18widQWzkBisBaVdhhQd6LacL6/oW9uHIxXWbjY
         CwYU8Pxm5HBmQs+za22pqdDjq8xSyVu6qcdD48EBsXHlm8ogdD8qtDGxRj3FmwhTEaNo
         R5L3kFp90LAhacz3EdLk4ejMd3xVMbD0d0AtLNoByYXKDzb+lmMxJ0RVhG3e+8vrIvRK
         Lw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gW3WRnHnznxkSUO/5SwoVuAVcv0jZtAWW4s72qzvM4E=;
        b=hrhk74cJVh2Lkv4kU4pQqVshe4Xb4w+BNBe9/+iF40VkcV7T0fz7QCW8K4hEAM5kyk
         Ge98oCBTSQdfWh691Z9Wcq+verRc2hKA8Tk4w0zFITtieBIhh837wDucIUUa1YvsA2cL
         im01owb7h/JoNx7bNf3DEc+elJk+En5+sBAQR6DeuVKLaoZU4I4rmmSj555iz9ePe5Ty
         cYzPNEKfvZ6L5wBcN7+muum1tL+pJ/1DJcILlMI72OeUpIUPkdYnHBra1Wd6dONAWORN
         VfnFR6luwVbsh/Bf1+c2h9HFOOCbU2DteacYtf1N1UsmIUqxxD2H4zo32xwbG8lcMFES
         j74w==
X-Gm-Message-State: AJcUukdjgEJJJ5fAYVTlBYy69DzTLpizyn8iIQrZyNV+SRJpmE0dRxGy
        32UEI1I84hEtoCQ8NpHhFKzy95gJ
X-Google-Smtp-Source: ALg8bN57lFxbOQzWkvSQ50SB2wd3EWlqiQGB+YQkuOv6DKyZXY4Jnt2T32tD+fxa5XA26qFBS+HDKg==
X-Received: by 2002:a17:902:2aaa:: with SMTP id j39mr11272474plb.335.1545608264268;
        Sun, 23 Dec 2018 15:37:44 -0800 (PST)
Received: from stanhu-geo-primary.c.gitlab-internal-153318.internal (99.88.197.35.bc.googleusercontent.com. [35.197.88.99])
        by smtp.gmail.com with ESMTPSA id f67sm41659601pfc.141.2018.12.23.15.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Dec 2018 15:37:43 -0800 (PST)
From:   Stan Hu <stanhu@gmail.com>
To:     git@vger.kernel.org, stanhu@gmail.com
Subject: [PATCH] sha1-name.c: Fix handling of revisions that contain paths with brackets
Date:   Sun, 23 Dec 2018 23:37:36 +0000
Message-Id: <20181223233736.10306-1-stanhu@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181223232716.6339-1-stanhu@gmail.com>
References: <20181223232716.6339-1-stanhu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, calling ls-tree with a revision such as
`master^{tree}:foo/{{path}}` would show the root tree instead of the
correct tree pointed by foo/{{path}}. If a colon is present in the revision
name, peel_onion() should assume that the presence of a bracket
at the end of the string belongs to the filename.

Signed-off-by: Stan Hu <stanhu@gmail.com>
---
 sha1-name.c               | 14 +++++++++++++-
 t/t3104-ls-tree-braces.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 t/t3104-ls-tree-braces.sh

diff --git a/sha1-name.c b/sha1-name.c
index faa60f69e3..69ecf0a26c 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1001,9 +1001,21 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 	 * "ref^{commit}".  "commit^{tree}" could be used to find the
 	 * top-level tree of the given commit.
 	 */
-	if (len < 4 || name[len-1] != '}')
+	if (len < 4)
 		return -1;
 
+	/* Check for names in ref:path format in case the path includes
+	 * brackets (e.g. ref^{type}:foo/{{bar}}).
+	 */
+	for (sp = name; sp < name + len; sp++) {
+		if (*sp == ':')
+			return -1;
+	}
+
+	if (sp == name && name[len-1] != '}') {
+		return -1;
+	}
+
 	for (sp = name + len - 1; name <= sp; sp--) {
 		int ch = *sp;
 		if (ch == '{' && name < sp && sp[-1] == '^')
diff --git a/t/t3104-ls-tree-braces.sh b/t/t3104-ls-tree-braces.sh
new file mode 100644
index 0000000000..3ead86c4fe
--- /dev/null
+++ b/t/t3104-ls-tree-braces.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='ls-tree with a folder with braces'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir -p "newdir/{{curly}}" &&
+	touch "newdir/{{curly}}/one" &&
+	git add "newdir/{{curly}}/one" &&
+	git commit -m test
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
+test_done
-- 
2.19.0

