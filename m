Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URI_HEX shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF30F1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 23:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942222AbdAIXQ6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 18:16:58 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36441 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942181AbdAIXQz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 18:16:55 -0500
Received: by mail-pf0-f173.google.com with SMTP id 189so22700387pfu.3
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 15:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=afAnAlx9dnRl6g4Vmi8pFuI20iNH1lestZ0r11ntA9I=;
        b=SEQjDm6JuNCfkm5klkBkyPRhGxMEhgO9by177Nep3bbFP5LT2fnv106o8A5D9g6r1c
         J3WPCOfZhyYoZ1iWeqnVOCLC6GHD2FZDUn+w+Od+HhZYh3dPZSWfe+W5urFYqEQpDx5V
         pFWY0Bkp2AGfOAR6W0ntgioPmuwYFnPUtleZWgv54ubgQTHRbdYYM/Agw+wfn12unLkI
         6qyp04IqZdfnB09FqLR3cHnRzFavj2EYxB5xdiB82xvghWr1KhQS5WcCcfiFK30Wy21d
         YBznLWGQNE3uqyUC/zVnAGjrsorRci7iREr3Zhy7RKEAMTiW+UQsrsgQ5jfhma5NIWGN
         N57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=afAnAlx9dnRl6g4Vmi8pFuI20iNH1lestZ0r11ntA9I=;
        b=ZS8/qyYG6KICgGhDbkL68im2hLO+anKGDrLkBTOzYRNmCDYYAWM1UNFqvfzdNO9QiJ
         /ZfYN3aIdIWa5AveKQE0MuidEgEBqUHc6ufyK+SrnS/Uq9lShnp3dt4DPaWtiX9EczaS
         XIqTfMKzuLpMP7nj8k8C1kiMqlQ/P2vWKIUGeqPOofqeeoDeXQ7XsLfcDnuWM/yq9zMx
         j0a64BgdyOeQP1ZCc0kqFVonL5PTqb56XILVO/bMUiCOPL/uFfO3YLFuZFwekQmSjoMX
         mYS4bFFGm//6kZr4jARZz2WSTTRiKqlx5dsH7rpYifaXZ8IT4efOYObmMFm2ijAWeQw4
         AQ6A==
X-Gm-Message-State: AIkVDXJi1mZ/3+qy0h2YUSlEjkH+WY7Y4luAWLWiiw93EoxTZcmID3pM/hZaruntVgNUxRrB
X-Received: by 10.84.176.131 with SMTP id v3mr316994plb.20.1484003814451;
        Mon, 09 Jan 2017 15:16:54 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1e2:be00:4066:92e5])
        by smtp.gmail.com with ESMTPSA id u3sm20365pfk.3.2017.01.09.15.16.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 15:16:53 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv8] pathspec: give better message for submodule related pathspec error
Date:   Mon,  9 Jan 2017 15:16:50 -0800
Message-Id: <20170109231650.9043-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.g7c4be45.dirty
In-Reply-To: <CAGZ79kZVKFvijfwEfmiaahz2VYgaa=m2m-ty2tbOXh2toO_muQ@mail.gmail.com>
References: <CAGZ79kZVKFvijfwEfmiaahz2VYgaa=m2m-ty2tbOXh2toO_muQ@mail.gmail.com>
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

  This comes as a single patch again, replacing sb/pathspec-errors.
  It goes directly on top of bw/pathspec-cleanup.

  v8:
  cleaned white spaces in commit message
  removed TEST_CREATE_SUBMODULE=yes
  : > instead of touch.

  v7:
  do not rely on "test_commit -C" being there, nor the infrastructure
  to request a "good" submodule upstream. Just create a submodule outselves
  to test in.

  Thanks,
  Stefan

 pathspec.c                       | 35 +++++++++++++++++++++++++++++++++--
 t/t6134-pathspec-in-submodule.sh | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100755 t/t6134-pathspec-in-submodule.sh

diff --git a/pathspec.c b/pathspec.c
index ff2509ddd1..7ababb3159 100644
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
index 0000000000..fd401ca605
--- /dev/null
+++ b/t/t6134-pathspec-in-submodule.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description='test case exclude pathspec'
+
+. ./test-lib.sh
+
+test_expect_success 'setup a submodule' '
+	test_create_repo pretzel &&
+	: >pretzel/a &&
+	git -C pretzel add a &&
+	git -C pretzel commit -m "add a file" -- a &&
+	git submodule add ./pretzel sub &&
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
2.11.0.rc2.30.g7c4be45.dirty

