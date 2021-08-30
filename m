Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DD8C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 10:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDECB610FA
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 10:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbhH3KsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 06:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbhH3KsS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 06:48:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A518C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 03:47:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so9099584wms.4
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 03:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tb3K0B9fXmpdmer/jL6HhNEuTtLZWweNmunar3TfWPk=;
        b=C73ybQbd7vRlwXwe1tqXDWfc5hJdMDTR+JCZCC1faQGhiOFIaUpdUMePvh/foIhA7o
         +Uef50qn4Vm8C5bmEXDlVeJJm9825ZHvnXwaTV5t9yr1SQdULsfQF6zRERytEOtBZyLe
         iTqOUTUjR/YqZptDaeIpNId9TozROUBrI8HTQxrybj8poIx7hxoqdCW6RNpKpvybISMX
         VZa2dk+RcX96N2pf2ssLhBEdmmxyfn0nAj1ib5WQOCVq8UgQK2/c0p/D9zPuwN2hwlsQ
         4bhtkM9CdX8t+T1i5nF0oS9+iPk5CB5el+jfXmQw6jbo7uhQGMuy39//ZWwsBUImq9Yb
         xkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tb3K0B9fXmpdmer/jL6HhNEuTtLZWweNmunar3TfWPk=;
        b=kEKzthAG11z9r0azA1m7fk/BXOXgCuIuw7Orj8ro1ynnGnvsA3K3M0N/gjKPk3JlwK
         ItwOKUajgEYIZNbulJL8aZAb7C4sMWWGZVxkjWg5hmESyMjX879aLBOYzrMc7Oaq9/wR
         c9pmvQFp12fuGN13tgSBdYXBjRWCg0k2ZK4BpRi8/t6ew+oDQ7ReG2b1x/oI+EHPPJbr
         4vzo+fI85FjetU5f+b96gxUcR1cAxc0AWcnSJMy7Ays5zM4S0WeVPXu8Mno52twRm7XY
         wl66SUg1rmwgBGYEHw3oGuKxfv9DNSiYm1j0+yprZ6j8Ph0WeTSD+6T6I02zW7eCdFIG
         nN8Q==
X-Gm-Message-State: AOAM533wZ30Tdz4wb4RK3nI8xzQSVBSj6zDQN8yhGkKIUJgMwsgD+Z9L
        qP1592Jvy2AAkO95tJoo1xYSHjgDpHGe/mWS
X-Google-Smtp-Source: ABdhPJxgYKrvmc6cSDwZl30e4FdW5B9CPKuKzbaA+X9HJn7zDq21G/yZf+Jg9P3Qp5aEQseZiuwvZQ==
X-Received: by 2002:a7b:c048:: with SMTP id u8mr21592183wmc.113.1630320443397;
        Mon, 30 Aug 2021 03:47:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13sm15509057wrf.55.2021.08.30.03.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 03:47:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 2/2] notes: don't indent empty lines
Date:   Mon, 30 Aug 2021 12:47:14 +0200
Message-Id: <RFC-patch-v2-2.2-4b546b83fd7-20210830T103913Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.737.g0eefde7d76
In-Reply-To: <RFC-cover-v2-0.2-00000000000-20210830T103913Z-avarab@gmail.com>
References: <20210830072118.91921-1-sunshine@sunshineco.com> <RFC-cover-v2-0.2-00000000000-20210830T103913Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

Like other Git commands, `git notes` takes care to call `stripspace` on
the user-supplied note content, thereby ensuring that it has no trailing
whitespace, among other cleanups. However, when notes are inserted into
a patch via `git format-patch --notes`, all lines of the note are
indented unconditionally, including empty lines, which leaves trailing
whitespace on lines which previously were empty, thus negating the
normalization done earlier. Fix this shortcoming.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 notes.c          |  2 +-
 t/t3301-notes.sh | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/notes.c b/notes.c
index f87dac40684..25e0a598996 100644
--- a/notes.c
+++ b/notes.c
@@ -1295,7 +1295,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	for (msg_p = msg; msg_p < msg + msglen; msg_p += linelen + 1) {
 		linelen = strchrnul(msg_p, '\n') - msg_p;
 
-		if (!raw)
+		if (!raw && linelen)
 			strbuf_addstr(sb, "    ");
 		strbuf_add(sb, msg_p, linelen);
 		strbuf_addch(sb, '\n');
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index d742be88402..74e5bfbc863 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -326,7 +326,7 @@ test_expect_success 'show -m notes' '
 
 		Notes:
 		${indent}spam
-		${indent}
+
 		${indent}foo
 		${indent}bar
 		${indent}baz
@@ -849,7 +849,7 @@ test_expect_success 'append to note from other note with "git notes append -C"'
 
 		Notes:
 		${indent}yet another note
-		${indent}
+
 		${indent}yet another note
 	EOF
 	note=$(git notes list HEAD^) &&
@@ -887,7 +887,7 @@ test_expect_success 'append to note from other note with "git notes append -c"'
 
 		Notes:
 		${indent}other note
-		${indent}
+
 		${indent}yet another note
 	EOF
 	note=$(git notes list HEAD) &&
@@ -928,7 +928,7 @@ test_expect_success 'copy note with "git notes copy" with default' '
 
 		Notes:
 		${indent}other note
-		${indent}
+
 		${indent}yet another note
 	EOF
 	git notes copy HEAD^ &&
@@ -950,7 +950,7 @@ test_expect_success 'prevent overwrite with "git notes copy"' '
 
 		Notes:
 		${indent}other note
-		${indent}
+
 		${indent}yet another note
 	EOF
 	git log -1 >actual &&
@@ -991,7 +991,7 @@ test_expect_success 'allow overwrite with "git notes copy -f" with default' '
 
 		Notes:
 		${indent}yet another note
-		${indent}
+
 		${indent}yet another note
 	EOF
 	git notes copy -f HEAD~2 &&
@@ -1020,7 +1020,7 @@ test_expect_success 'git notes copy --stdin' '
 
 		Notes:
 		${indent}yet another note
-		${indent}
+
 		${indent}yet another note
 
 		commit $parent
@@ -1031,7 +1031,7 @@ test_expect_success 'git notes copy --stdin' '
 
 		Notes:
 		${indent}other note
-		${indent}
+
 		${indent}yet another note
 	EOF
 	from=$(git rev-parse HEAD~3) &&
@@ -1092,7 +1092,7 @@ test_expect_success 'git notes copy --for-rewrite (enabled)' '
 
 		Notes:
 		${indent}yet another note
-		${indent}
+
 		${indent}yet another note
 
 		commit $parent
@@ -1103,7 +1103,7 @@ test_expect_success 'git notes copy --for-rewrite (enabled)' '
 
 		Notes:
 		${indent}other note
-		${indent}
+
 		${indent}yet another note
 	EOF
 	test_config notes.rewriteMode overwrite &&
@@ -1174,7 +1174,7 @@ test_expect_success 'git notes copy --for-rewrite (append)' '
 
 		Notes:
 		${indent}a fresh note
-		${indent}
+
 		${indent}another fresh note
 	EOF
 	git notes add -f -m"another fresh note" HEAD^ &&
@@ -1199,11 +1199,11 @@ test_expect_success 'git notes copy --for-rewrite (append two to one)' '
 
 		Notes:
 		${indent}a fresh note
-		${indent}
+
 		${indent}another fresh note
-		${indent}
+
 		${indent}append 1
-		${indent}
+
 		${indent}append 2
 	EOF
 	git notes add -f -m"append 1" HEAD^ &&
-- 
2.33.0.737.g0eefde7d76

