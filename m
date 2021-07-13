Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D39C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 07:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625E361040
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 07:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhGMHni (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 03:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbhGMHnh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 03:43:37 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0546FC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 00:40:47 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q4so28520073ljp.13
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 00:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOGUw7XlBMi/9UCK5fQy/PQ+Y/ydwk6YeikV+qLSDI0=;
        b=KQvHrgclvftVnvc3UL5iDMLR3Ng37t56EGHVmRorfImXZe/nCFNK919klq4s2kybV7
         E1DxXMj2z2Vaf+iOR9m6g+wZ9mLiLAhWFZi1a0yDDv5jQVkqgBxLEE6WaClAy3MuU+ZB
         3YoxDOzXEhRUIz2QcGFo0zNi1fFZtt7+e87/cN8nauntdEuFRvvNssOEX54N2EO0udjU
         BW9hDEwtrcm8phoUnK+0NBnK6zoKDBdac3LmxEvrnrX1GWVhNV8Gg8IFFBUjKb3rRT5S
         gu8U6YSWBf3MV+9fT9Uz4dSdmBvwsTTwuEN7ci8cwh4N4TvuxA0O0X9TTu7lHrkeZJyT
         Kgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOGUw7XlBMi/9UCK5fQy/PQ+Y/ydwk6YeikV+qLSDI0=;
        b=hsd05xHUHVwQrG54DDiF+1wV3oR+Xf5Z5cV4mnBvrZ9H0nEs45t8trom+UeEc/utby
         G3F/5mtw0RL8Lk96MH+zAA76hnt59jTcsMA9/burJBdAGz7aXlWs8ydkjJBe91uxxL5t
         GFMvCFmHiHL+wiR3dR3q7qZXMSVaSxbB4nO3omBDVKc2Y4JsIrG3i5N0ero+MsnAVEEl
         Cz1pLZXR8n9IZJWQ7ssOfKtWE71hXu+fX9I7ksJTdd9s7zo99bKqKijWGfgFeBw4B1Qu
         gZVM6Z0Klh2KzwJAQSmkLd9SU4jam1CN53RgOeLye07C9crajYX/l2OFh0/rt0B7AwZx
         1aoQ==
X-Gm-Message-State: AOAM532AdgfoutGZZukkTj1A05PwBDU8bcODm5RBr3kkGYzgN8w2YqYR
        MDze58mDEKW2yeStpSZni58A2SyhKtU=
X-Google-Smtp-Source: ABdhPJzSF8Z+g0EtUtjsH+a/b9+BB5dhAAFVr5g0+1AKs0IDtgcSYBcjuey4+kMnudpGTKpyzVxc8g==
X-Received: by 2002:a2e:8750:: with SMTP id q16mr2995604ljj.92.1626162044954;
        Tue, 13 Jul 2021 00:40:44 -0700 (PDT)
Received: from localhost.localdomain (213-65-66-12-no600.tbcn.telia.com. [213.65.66.12])
        by smtp.gmail.com with ESMTPSA id a13sm416850lfl.206.2021.07.13.00.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 00:40:44 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2] load_ref_decorations(): fix decoration with tags
Date:   Tue, 13 Jul 2021 09:40:18 +0200
Message-Id: <20210713074018.232372-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576
In-Reply-To: <YOzY+qNFM2GsgKMO@coredump.intra.peff.net>
References: <YOzY+qNFM2GsgKMO@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 88473c8bae ("load_ref_decorations(): avoid parsing non-tag
objects", 2021-06-22) introduced a shortcut to `add_ref_decoration()`:
Rather than calling `parse_object()`, we go for `oid_object_info()` and
then `lookup_object_by_type()` using the type just discovered. As
detailed in the commit message, this provides a significant time saving.

Unfortunately, it also changes the behavior: We lose all annotated tags
from the decoration.

The reason this happens is in the loop where we try to peel the tags, we
won't necessarily have parsed that first object. If we haven't, its
`tag` will be NULL, so nothing will be displayed, and its `tagged` will
also be NULL, so we won't peel any further.

Make sure to parse the tag object at the top of the peeling loop. This
effectively restores the pre-88473c8bae parsing -- but only of tags,
allowing us to keep most of the possible speedup from 88473c8bae. Jeff
King reports:

  On my big ~220k ref test case (where it's mostly non-tags), the
  timings [using "git log -1 --decorate"] are:

    - before either patch: 2.945s
    - with my broken patch: 0.707s
    - with [this patch]: 0.788s

Note how this commit could have been done as an optimization before
88473c8bae: When our peeling hits a non-tag, we won't parse that tagged
object only to immediately end the loop.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 On Tue, 13 Jul 2021 at 02:06, Jeff King <peff@peff.net> wrote:
 >
 > Your fix is _almost_ there.

 It's very kind of you to put it like that. I've picked up your
 suggestions and have tried to summarize my understanding of the issue
 and the fix in the commit message.

 > That's the minimum needed to unbreak things. I think we could do even
 > better, though. There is no need for us to parse a commit object pointed
 > to by a tag here. We should only be parsing tags we see (whether at the
 > top-level or recursively).

 Maybe you wrote this before circling back and actually writing that
 "even better" thing? Because it seems to me like that's what you did.
 Maybe I'm still missing something.

 Thank you for your insightful and helpful comments.

 log-tree.c     | 4 ++--
 t/t4202-log.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 4f69ed176d..6dc4412268 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -174,11 +174,11 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 
 	add_name_decoration(deco_type, refname, obj);
 	while (obj->type == OBJ_TAG) {
+		if (!obj->parsed)
+			parse_object(the_repository, &obj->oid);
 		obj = ((struct tag *)obj)->tagged;
 		if (!obj)
 			break;
-		if (!obj->parsed)
-			parse_object(the_repository, &obj->oid);
 		add_name_decoration(DECORATION_REF_TAG, refname, obj);
 	}
 	return 0;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 350cfa3593..536b1eef42 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1905,6 +1905,15 @@ test_expect_success '--exclude-promisor-objects does not BUG-crash' '
 	test_must_fail git log --exclude-promisor-objects source-a
 '
 
+test_expect_success 'log --decorate includes lightweight and annotated tags' '
+	cat >expect <<-\EOF &&
+	three HEAD -> source-b, tag: three, tag: source-tag
+	one tag: one
+	EOF
+	git log --format="%s %D" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log --end-of-options' '
        git update-ref refs/heads/--source HEAD &&
        git log --end-of-options --source >actual &&
-- 
2.32.0.402.g57bb445576

