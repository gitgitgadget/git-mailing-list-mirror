Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A92241F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 05:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeGLF5d (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 01:57:33 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:40960 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbeGLF5c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 01:57:32 -0400
Received: by mail-yb0-f194.google.com with SMTP id s8-v6so10976484ybe.8
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 22:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jn+qbMMWvh5FWmwS5sDh3HzvWEbVrcZWD0fplHZfzEU=;
        b=ahXYDljjV+2A1TYtDWyeyW2OutLo2fOt8M83A1N+iNigazrOY6+QdXIuwgdZCXkQSG
         pVgm6amq/yVFnhug3SR3cTi7/FSrsReeeCL/vH96KcXT5+5NmY8zpqhaFv7mEENScU7+
         E2SzxmxE8ccuRpsf8eW+HrURar3VfM8tvIveOCG5T1aSCcp3P4d3bzhB+JZLhBR2D9dO
         FBc1NqqlxFZyIm+oYzKmyS2iaeonXCOgo+De6VgfyNJxZM65kGUmhK5DBNNAVUO3ZQ6C
         ad5Zf4Lz7zl+5Gw3pESgLxu+FhwWWOxuIAGMlQopCwfD5ECehpXvTSjbXtmJ6eKp4GI+
         6i2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jn+qbMMWvh5FWmwS5sDh3HzvWEbVrcZWD0fplHZfzEU=;
        b=DNSNfZeH0eNhj18tBmwV5HmcIP4Dw1B1EHvwAfos9z0ZHegqkkN6oDXGtnWS5r0r9+
         t/vKo8aJVe3y/kIy0FBH1soyBCCM8LopS/EwettFHpSb1pEk5pyXhYGQEwiOGDgP1YeW
         aZYsCAJ+zfFdwFsq4MYF7WVMTZTzAuPRBCvjWssRNCO/cMyJgOcH0Lb+O1lZuaLZp7Sj
         pU3ErMNCBCKaUWGissSgT7Daex6/WOyUsV1nJkZkOveJzWxvDqELrKIglICF1yyR2xCe
         jLOPVgHpK8ex4NLSqIATuNZwiQut5ubB6VNqHSMUZVm39PIZscuKvBydf7s98qfZlhfF
         NqWA==
X-Gm-Message-State: AOUpUlGOOaE5kcsClkFACHQsSEuJcFeA65qZJeOu9Nc4+usyz++dh187
        hdaAI/Z4/p2Atk3HOtqQz1OaNDi+
X-Google-Smtp-Source: AAOMgpd/sfOvli9EQUiflEF7rgHVPDF/qt+PBgX1+Q/fDmGum2QzEoA+s+BlDNnelOc6ktYUoGxgvg==
X-Received: by 2002:a25:2f51:: with SMTP id v78-v6mr356202ybv.445.1531374575228;
        Wed, 11 Jul 2018 22:49:35 -0700 (PDT)
Received: from wchargin-t440s.attlocal.net ([2600:1700:a460:31e0:2181:1c0a:6178:b7a4])
        by smtp.gmail.com with ESMTPSA id u134-v6sm4451411ywg.22.2018.07.11.22.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 22:49:34 -0700 (PDT)
From:   William Chargin <wchargin@gmail.com>
To:     git@vger.kernel.org
Cc:     William Chargin <wchargin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2] sha1-name.c: for ":/", find detached HEAD commits
Date:   Wed, 11 Jul 2018 22:49:09 -0700
Message-Id: <20180712054909.29077-1-wchargin@gmail.com>
X-Mailer: git-send-email 2.18.0.130.g84cda7581
In-Reply-To: <CAFW+GMD62V=o4hoEYKVteBZHzqBtquzLzTv2WXiSPZf3ZhOpeg@mail.gmail.com>
References: <CAFW+GMD62V=o4hoEYKVteBZHzqBtquzLzTv2WXiSPZf3ZhOpeg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch broadens the set of commits matched by ":/" pathspecs to
include commits reachable from HEAD but not any named ref. This avoids
surprising behavior when working with a detached HEAD and trying to
refer to a commit that was recently created and only exists within the
detached state.

If multiple worktrees exist, only the current worktree's HEAD is
considered reachable. This is consistent with the existing behavior for
other per-worktree refs: e.g., bisect refs are considered reachable, but
only within the relevant worktree.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: William Chargin <wchargin@gmail.com>
Based-on-patch-by: Jeff King <peff@peff.net>
---
 Documentation/revisions.txt   |  2 +-
 sha1-name.c                   |  1 +
 t/t4208-log-magic-pathspec.sh | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 7d1bd4409..aa9579eba 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -184,7 +184,7 @@ existing tag object.
   A colon, followed by a slash, followed by a text, names
   a commit whose commit message matches the specified regular expression.
   This name returns the youngest matching commit which is
-  reachable from any ref. The regular expression can match any part of the
+  reachable from any ref, including HEAD. The regular expression can match any part of the
   commit message. To match messages starting with a string, one can use
   e.g. ':/^foo'. The special sequence ':/!' is reserved for modifiers to what
   is matched. ':/!-foo' performs a negative match, while ':/!!foo' matches a
diff --git a/sha1-name.c b/sha1-name.c
index 60d9ef3c7..641ca12f9 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1650,6 +1650,7 @@ static int get_oid_with_context_1(const char *name,
 			struct commit_list *list = NULL;
 
 			for_each_ref(handle_one_ref, &list);
+			head_ref(handle_one_ref, &list);
 			commit_list_sort_by_date(&list);
 			return get_oid_oneline(name + 2, oid, list);
 		}
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index 62f335b2d..4c8f3b8e1 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -25,6 +25,32 @@ test_expect_success '"git log :/a -- " should not be ambiguous' '
 	git log :/a --
 '
 
+test_expect_success '"git log :/detached -- " should find a commit only in HEAD' '
+	test_when_finished "git checkout master" &&
+	git checkout --detach &&
+	# Must manually call `test_tick` instead of using `test_commit`,
+	# because the latter additionally creates a tag, which would make
+	# the commit reachable not only via HEAD.
+	test_tick &&
+	git commit --allow-empty -m detached &&
+	test_tick &&
+	git commit --allow-empty -m something-else &&
+	git log :/detached --
+'
+
+test_expect_success '"git log :/detached -- " should not find an orphaned commit' '
+	test_must_fail git log :/detached --
+'
+
+test_expect_success '"git log :/detached -- " should find HEAD only of own worktree' '
+	git worktree add other-tree HEAD &&
+	git -C other-tree checkout --detach &&
+	test_tick &&
+	git -C other-tree commit --allow-empty -m other-detached &&
+	git -C other-tree log :/other-detached -- &&
+	test_must_fail git log :/other-detached --
+'
+
 test_expect_success '"git log -- :/a" should not be ambiguous' '
 	git log -- :/a
 '
-- 
2.18.0.130.g84cda7581

