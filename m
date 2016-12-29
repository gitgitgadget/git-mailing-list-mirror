Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,URI_HEX shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CC351FCA5
	for <e@80x24.org>; Thu, 29 Dec 2016 19:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753075AbcL2T3O (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 14:29:14 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34973 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753054AbcL2T3N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 14:29:13 -0500
Received: by mail-pg0-f54.google.com with SMTP id i5so104506276pgh.2
        for <git@vger.kernel.org>; Thu, 29 Dec 2016 11:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+8BOyw02khynpTZKJFSQ1dVzkWNaiz/qcMflWY9c89k=;
        b=QmqGinJF3fiA3WJpn7JDheSTobJW6VQGBV2oFcD+OLjTaXzdD8uIxIHIaiIoh7GwoK
         TAPR77rhQ8V0dlhZRb/BhwNbGPEG54x44FaTyEtR/I5auC+1UyEAaUVArGFm6yzZFdCp
         SlSqrpJSiJKeX0vK0bl9U7id0n/XKXsTK3x5tYYUQI244dL8vgwrlyV4uiuNw1A7BevZ
         S4pk6HbHy5hjkyBRLLJCdFdUngoxtS5dNHfb39rZiqGwGtcNH8ipWWKPbESsAj9/trOw
         yYZfUWM3OKaUnKD0yJJFzHR31f2aWeTPKC1ScBb4FjLcV0mqGSeQEM7ZI+5BomQ3Mph2
         S+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+8BOyw02khynpTZKJFSQ1dVzkWNaiz/qcMflWY9c89k=;
        b=AF9CoF2Fepc/ZSJlJGanbqlqFS/2gV64+tNeZO0BBNXUWLoEdL2UFVa5p+8XKSGxMo
         TJKQ8m1KRuLsHLcM0D4Y/XqWToHZjKZQbndmTeVa57aVG0YFuBd94Y0JlWGCfZiXmD+a
         RM0dJImkOvUlzGTTYzB3siAqAcibUe1AkHjyn0l2ui58IBTOP9FAzQLJdn4DxDJdzIOi
         ZPjVU6ZGQPCKbKXF+CU8b7aKyQVZlBEQu/0uLCrHLMduXnO04x+HEL0zyDf0xi5TIRtm
         T+7X040Txvq3te4ZF9f/X65mUtsuNSR7ut6l1cQo/6DIBwk7KhFB18kcFcBUZCMQMGTH
         GJXw==
X-Gm-Message-State: AIkVDXIEsSuolCUG8iyx3oGBqkBi3+AvcO0qq7igg/MgHIS7RpVg399+UzydUbbFm0nlfnjU
X-Received: by 10.84.191.131 with SMTP id a3mr90077541pld.62.1483039752440;
        Thu, 29 Dec 2016 11:29:12 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:a8f2:a269:38d5:58bc])
        by smtp.gmail.com with ESMTPSA id p127sm105234020pfg.24.2016.12.29.11.29.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Dec 2016 11:29:11 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] pathspec: give better message for submodule related pathspec error
Date:   Thu, 29 Dec 2016 11:29:08 -0800
Message-Id: <20161229192908.32633-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.259.ga95e92af08.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Every once in a while someone complains to the mailing list to have
run into this weird assertion[1].

The usual response from the mailing list is link to old discussions[2],
and acknowledging the problem stating it is known.

For now just improve the user visible error message.

[1] https://www.google.com/search?q=item-%3Enowildcard_len
[2] http://git.661346.n2.nabble.com/assert-failed-in-submodule-edge-case-td7628687.html
    https://www.spinics.net/lists/git/msg249473.html

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 * a more defensive check and message
 * with tests!
 
 pathspec.c                       | 19 +++++++++++++++++--
 t/t6134-pathspec-in-submodule.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 2 deletions(-)
 create mode 100755 t/t6134-pathspec-in-submodule.sh

diff --git a/pathspec.c b/pathspec.c
index 22ca74a126..b446d79615 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -313,8 +313,23 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	}
 
 	/* sanity checks, pathspec matchers assume these are sane */
-	assert(item->nowildcard_len <= item->len &&
-	       item->prefix         <= item->len);
+	if (item->nowildcard_len > item->len ||
+	    item->prefix         > item->len) {
+		/* Historically this always was a submodule issue */
+		for (i = 0; i < active_nr; i++) {
+			struct cache_entry *ce = active_cache[i];
+			int ce_len = ce_namelen(ce);
+			int len = ce_len < item->len ? ce_len : item->len;
+			if (!S_ISGITLINK(ce->ce_mode))
+				continue;
+			if (!memcmp(ce->name, item->match, len))
+				die (_("Pathspec '%s' is in submodule '%.*s'"),
+					item->original, ce_len, ce->name);
+		}
+		/* The error is a new unknown bug */
+		die ("BUG: item->nowildcard_len > item->len || item->prefix > item->len)");
+	}
+
 	return magic;
 }
 
diff --git a/t/t6134-pathspec-in-submodule.sh b/t/t6134-pathspec-in-submodule.sh
new file mode 100755
index 0000000000..e62dbb7327
--- /dev/null
+++ b/t/t6134-pathspec-in-submodule.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+test_description='test case exclude pathspec'
+
+. ./test-lib.sh
+
+test_expect_success 'setup a submodule' '
+	test_commit 1 &&
+	git submodule add ./ sub &&
+	git commit -a -m "add submodule" &&
+	git submodule deinit --all
+'
+
+cat <<EOF >expect
+fatal: Pathspec 'sub/a' is in submodule 'sub'
+EOF
+
+test_expect_success 'error message for path inside submodule' '
+	echo a >sub/a &&
+	test_must_fail git add sub/a 2>actual &&
+	test_cmp expect actual
+'
+
+cat <<EOF >expect
+fatal: Pathspec '.' is in submodule 'sub'
+EOF
+
+test_expect_success 'error message for path inside submodule from within submodule' '
+	test_must_fail git -C sub add . 2>actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.11.0.259.ga95e92af08.dirty

