Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URI_HEX shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B72205C9
	for <e@80x24.org>; Thu,  5 Jan 2017 19:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763680AbdAETbE (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 14:31:04 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36104 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763464AbdAET3N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 14:29:13 -0500
Received: by mail-pf0-f181.google.com with SMTP id 189so89087795pfz.3
        for <git@vger.kernel.org>; Thu, 05 Jan 2017 11:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gLgoiNZ6wi8kFQbLsyMcTkJK98phUrO4iVBOJjHE1uc=;
        b=XL99+GGzztxzEcPua80FF1fW2AwZ0I6OHpc61QbfUD/QjJn2Mpqd4wz0u36p6114p7
         2KMmS2InXmVGhKZZDOaTL4pXBy4aNHsGV9gxUldy5oaQnU34TnTGw08Ysm8DSqENPw60
         YXiPun/cBRkUhu3tpGSjOwHQJIhN55oZRYnek7FPQv7WlQyf6tXZ0jFRuSdCr59Zxp+Q
         J8jNqOuUcP619IMUSo9pURy1j7Hk1zWrRbH2Cobj+QsMXUlwn4fZU8sK9vm6kIAyH+kk
         DeE2o5rMxYNPWx12vW0zKzuUwX9+qQRoiWU6PMePowHjYcIwGUMojdZn/I107ksdXhSm
         OX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLgoiNZ6wi8kFQbLsyMcTkJK98phUrO4iVBOJjHE1uc=;
        b=KOxKLfytJceSlq7tElK5C6CNY8fiUYr7ZWsloyqFlxgGF9XZVzhZnuL/6b86IBqdTs
         PJhYekSp/s9SBgdWkfhlw0kCztgwIhp5g1fXzgwYLgeKKGnsyOYWKRnTg30dA+TVBfIA
         S7tRI/X8T1dbCd2v6ACV5c4/HORUwJ4k4Bp3CWWVDMfE8jO8beko13AAZhFd+05KmlzJ
         TrWoc41Nbk8eSyJaG8vrZTgeitH+3voPYqvSGy5kuu3b4RzmnTbpwH8oOU/yXUty3LE+
         WFABvSt/U1DyRW1hmur9VAyw7IkVwzroiQwlS85ykK8wbA5J+mL/8ZF0pAIN/JmTOadK
         FYog==
X-Gm-Message-State: AIkVDXIheOhm531Yz9OMBlE/KbdRNNDZimLCHH4hwlKZNRzkS4b2mSinF3oCHkO0mGd6I3gc
X-Received: by 10.99.125.65 with SMTP id m1mr136831139pgn.159.1483644552621;
        Thu, 05 Jan 2017 11:29:12 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:d8d4:45f:826c:3a9f])
        by smtp.gmail.com with ESMTPSA id g85sm114776305pfe.38.2017.01.05.11.29.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 05 Jan 2017 11:29:12 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, peff@peff.net, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 2/2] pathspec: give better message for submodule related pathspec error
Date:   Thu,  5 Jan 2017 11:29:04 -0800
Message-Id: <20170105192904.1107-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.31.g919a8d0.dirty
In-Reply-To: <20170105192904.1107-1-sbeller@google.com>
References: <20170105192904.1107-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Every once in a while someone complains to the mailing list to have
run into this weird assertion[1]. The usual response from the mailing
list is link to old discussions[2], and acknowledging the problem
stating it is known.

This patch accomplishes two things:

  1. Switch assert() to die("BUG") to give a more readable message.

  2. Take one of the cases where we hit a BUG and turn it into a normal
     "there was something wrong with the input" message.

     This assertion triggered for cases where there wasn't a programming
     bug, but just bogus input. In particular, if the user asks for a
     pathspec that is inside a submodule, we shouldn't assert() or
     die("BUG"); we should tell the user their request is bogus.

     The only reason we did not check for it, is the expensive nature
     of such a check, so callers avoid setting the flag
     PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE. However when we die due
     to bogus input, the expense of CPU cycles spent outweighs the user
     wondering what went wrong, so run that check unconditionally before
     dying with a more generic error message.

Note: There is a case (e.g. "git -C submodule add .") in which we call
strip_submodule_slash_expensive, as git-add requests it via the flag
PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE, but the assert used to
trigger nevertheless, because the flag PATHSPEC_LITERAL was not set,
such that we executed

	if (item->nowildcard_len < prefixlen)
		item->nowildcard_len = prefixlen;

and prefixlen was not adapted (e.g. it was computed from "submodule/")
So in the die_inside_submodule_path function we also need handle paths,
that were stripped before, i.e. are the exact submodule path. This
is why the conditions in die_inside_submodule_path are slightly
different than in strip_submodule_slash_expensive.

[1] https://www.google.com/search?q=item-%3Enowildcard_len
[2] http://git.661346.n2.nabble.com/assert-failed-in-submodule-edge-case-td7628687.html
    https://www.spinics.net/lists/git/msg249473.html

Helped-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 pathspec.c                       | 35 +++++++++++++++++++++++++++++++++--
 t/t6134-pathspec-in-submodule.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 2 deletions(-)
 create mode 100755 t/t6134-pathspec-in-submodule.sh

diff --git a/pathspec.c b/pathspec.c
index d4efcf6662..42cd83c235 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -296,6 +296,27 @@ static void strip_submodule_slash_expensive(struct pathspec_item *item)
 	}
 }
 
+static void die_inside_submodule_path(struct pathspec_item *item)
+{
+	int i;
+
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		int ce_len = ce_namelen(ce);
+
+		if (!S_ISGITLINK(ce->ce_mode))
+			continue;
+
+		if (item->len < ce_len ||
+		    !(item->match[ce_len] == '/' || item->match[ce_len] == '\0') ||
+		    memcmp(ce->name, item->match, ce_len))
+			continue;
+
+		die(_("Pathspec '%s' is in submodule '%.*s'"),
+		    item->original, ce_len, ce->name);
+	}
+}
+
 /*
  * Perform the initialization of a pathspec_item based on a pathspec element.
  */
@@ -391,8 +412,18 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 	}
 
 	/* sanity checks, pathspec matchers assume these are sane */
-	assert(item->nowildcard_len <= item->len &&
-	       item->prefix         <= item->len);
+	if (item->nowildcard_len > item->len ||
+	    item->prefix         > item->len) {
+		/*
+		 * This case can be triggered by the user pointing us to a
+		 * pathspec inside a submodule, which is an input error.
+		 * Detect that here and complain, but fallback in the
+		 * non-submodule case to a BUG, as we have no idea what
+		 * would trigger that.
+		 */
+		die_inside_submodule_path(item);
+		die ("BUG: item->nowildcard_len > item->len || item->prefix > item->len)");
+	}
 }
 
 static int pathspec_item_cmp(const void *a_, const void *b_)
diff --git a/t/t6134-pathspec-in-submodule.sh b/t/t6134-pathspec-in-submodule.sh
new file mode 100755
index 0000000000..2900d8d06e
--- /dev/null
+++ b/t/t6134-pathspec-in-submodule.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+test_description='test case exclude pathspec'
+
+TEST_CREATE_SUBMODULE=yes
+. ./test-lib.sh
+
+test_expect_success 'setup a submodule' '
+	git submodule add ./pretzel.bare sub &&
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
2.11.0.31.g919a8d0.dirty

