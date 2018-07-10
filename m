Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A12A91F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 15:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934230AbeGJPmU (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 11:42:20 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:45196 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933737AbeGJPmT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 11:42:19 -0400
Received: by mail-yb0-f194.google.com with SMTP id h127-v6so8771694ybg.12
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 08:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ir2B4QpT8Krpq9075kFDnbzmcCkldu8PWQ7D9atUWe0=;
        b=OiYAJFmMfvVAsI+BrokAXuICNSGoDd+xEZaSfcO2axKWogt7AJtisuOSXhq3qLY/jB
         sJi5SMvQK/OEZcgyj5g+T2Dl3ZT2H2qkGNLx+On0Lxla57tmTsZXeghxLHnrOEaKaYJ5
         tiCr3IxLxmw6OO/nbYUvr4W12BUelARKT2lMbQqmy+54gBi0I/+U2Ha+UhBfQGRSec3G
         RqVZL1AxYqpjYXJ3n8eDLcUVKTqFkIbi9NkEoENNp2V5Z63fRf/x4a3jOsa9opN94ppd
         KOTaXiq3sEGr4aPc9amJhUM+pslxPBp3SXEaAs9ib1KzyNTQy/9kGXwAHyB+lLlSJTWJ
         zh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ir2B4QpT8Krpq9075kFDnbzmcCkldu8PWQ7D9atUWe0=;
        b=rp5PHuh3A5cTCpeH3UEQAyWOu6SzxnSyvNWaXtnc1VLgfRuGzq5RgNYBnmy47ebVhC
         wDhePD5fMO435n0ZJ2s3CMi75FRBbv+Bnoj2+ETRWCTGZ5xB0a0QTlSzcqoi8H+mbEZ4
         2kLKIWGfyYz1hTH4zMHPfRERLThXczcGTBtH9WiuI/AH2eF69aT9/tTz+Zha40xJ2zG1
         ZGn1gDmTf8ChvWa9uBHsV3wWJmnOv/2eIvQgsFtEg6KptXUVSx3fpsqv230zBI2cjMzA
         zIa0F7OJtp/Z/uo4kJsMgUtQXTLSEOOI+xrgQVgL/1HnwgSj1bB01EueNe0V0c24lcgA
         KTig==
X-Gm-Message-State: APt69E1GmLOlsv5D9M9S4KukW331VVqaRilzcwUBDVW336hyjvS6lJFR
        zCCV2Ou5Rf6SxVjWdaoxoqkJOUco
X-Google-Smtp-Source: AAOMgpf9oHRkII54NW8cwygxn21Eu5nbWQT6gW20e8FWkELsfIBZjHx7s+pHUD21xWSrWEaF6f3jhw==
X-Received: by 2002:a25:2102:: with SMTP id h2-v6mr9270047ybh.31.1531237339223;
        Tue, 10 Jul 2018 08:42:19 -0700 (PDT)
Received: from wchargin-t440s.attlocal.net ([2600:1700:a460:31e0:2181:1c0a:6178:b7a4])
        by smtp.gmail.com with ESMTPSA id b6-v6sm7656670ywb.29.2018.07.10.08.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 08:42:18 -0700 (PDT)
From:   William Chargin <wchargin@gmail.com>
To:     git@vger.kernel.org
Cc:     William Chargin <wchargin@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH] sha1-name.c: for ":/", find detached HEAD commits
Date:   Tue, 10 Jul 2018 08:41:06 -0700
Message-Id: <20180710154106.5356-1-wchargin@gmail.com>
X-Mailer: git-send-email 2.18.0.130.g61d0c9dcf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch broadens the set of commits matched by ":/" pathspecs to
include commits reachable from HEAD but not any named ref. This avoids
surprising behavior when working with a detached HEAD and trying to
refer to a commit that was recently created and only exists within the
detached state.

Signed-off-by: William Chargin <wchargin@gmail.com>
Based-on-patch-by: Jeff King <peff@peff.net>
---
 Documentation/revisions.txt   | 10 +++++-----
 sha1-name.c                   |  1 +
 t/t4208-log-magic-pathspec.sh | 14 ++++++++++++++
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 7d1bd4409..aa56907fd 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -181,11 +181,11 @@ existing tag object.
   the '<rev>' before '{caret}'.
 
 ':/<text>', e.g. ':/fix nasty bug'::
-  A colon, followed by a slash, followed by a text, names
-  a commit whose commit message matches the specified regular expression.
-  This name returns the youngest matching commit which is
-  reachable from any ref. The regular expression can match any part of the
-  commit message. To match messages starting with a string, one can use
+  A colon, followed by a slash, followed by a text, names a commit whose
+  commit message matches the specified regular expression. This name
+  returns the youngest matching commit which is reachable from any ref
+  or from HEAD. The regular expression can match any part of the commit
+  message. To match messages starting with a string, one can use
   e.g. ':/^foo'. The special sequence ':/!' is reserved for modifiers to what
   is matched. ':/!-foo' performs a negative match, while ':/!!foo' matches a
   literal '!' character, followed by 'foo'. Any other sequence beginning with
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
index 62f335b2d..41b9f3eba 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -25,6 +25,20 @@ test_expect_success '"git log :/a -- " should not be ambiguous' '
 	git log :/a --
 '
 
+test_expect_success '"git log :/detached -- " should find a commit only in HEAD' '
+	test_when_finished "git checkout master" &&
+	git checkout --detach &&
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
 test_expect_success '"git log -- :/a" should not be ambiguous' '
 	git log -- :/a
 '
-- 
2.18.0.130.g61d0c9dcf

