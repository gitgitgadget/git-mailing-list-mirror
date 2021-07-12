Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BABC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 22:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 546ED60240
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 22:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhGLWp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 18:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhGLWp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 18:45:28 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5270C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 15:42:37 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 141so10285495ljj.2
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 15:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OXmTgnmYuE4kCosly1x62GMUZbSjOwOhz9IDTw6f4mo=;
        b=JGz7v/7J9WMdHNsU9svHdnBgJTngMo1gxca4gYiqtzsMvOKrVvi08dwKqx+F6cHLii
         10COctmJupjwJi+IEIGTwta0bj/P4rrQhdkMD8KCsQSBJst7j5cgr06CajyoRhIPJDZc
         yuKnGBI+751c6WWRVblPEtyDEDJBNpq5P1HfIgExtQEejzemw+T2Sov+9kXHLZhOJ41e
         2C90asplDRuEpUfJwfl6onwarqlMqw4hpQPXTObNYINpc9TDbaWkqFrlhLGP3DPJd5i8
         B/DbH72jyd/wd2/fTzqWwWVFuZKQx0a+2bZIvn18+bR482hQ7rV09u/MBJSfrNEJ+52K
         Blsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OXmTgnmYuE4kCosly1x62GMUZbSjOwOhz9IDTw6f4mo=;
        b=MPo/qGyS0BNGw6a0gKMAWfzQxI/U3QdwQuYbe87L2ymKlPGdBAogybkVSg7gFs0vgJ
         5PK15j9nFKXylE0xjGlPqKz3mjBotxL9xEkZ8zEUI6lnfvco33ZF5MVaWlbIc+DjZ86k
         nm8q+PH1G8TZbw88a1AoG259mdsJ4wcn9xjBhhGkcmSfGFQ1F1payu44dLYUm5qwT9Kc
         gxGVYJLzJlcvr08zoD/RpSkkBEaAMHpJ3qTuFOkGizhqAjMbC8iCNBqPtL49C0npbyp5
         TJwj35BhxbLh+oO1o7UGCuwwn0jKEtzSp2tRHNCGovN0zU5weYVzxs6efahu1QwK9SDD
         E3zA==
X-Gm-Message-State: AOAM530u2bgHTjqXLQOH4Yvw3u2ru62yedTn0JCKdh75HpSQOH5vtClc
        yi6T/Im/qsLT7zHzXWsRB4jPi21QlRY=
X-Google-Smtp-Source: ABdhPJx8D4AdLltArwcDC4mf8r9u53k8O4aVRNGu1GTf1hET/uJxeUIv+YjWVbFf2G1Ze45fdUNcbQ==
X-Received: by 2002:a2e:b8c9:: with SMTP id s9mr1263689ljp.147.1626129756004;
        Mon, 12 Jul 2021 15:42:36 -0700 (PDT)
Received: from localhost.localdomain (213-65-66-12-no600.tbcn.telia.com. [213.65.66.12])
        by smtp.gmail.com with ESMTPSA id i13sm1306108lfj.248.2021.07.12.15.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 15:42:35 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v1] load_ref_decorations(): fix decoration with tags
Date:   Tue, 13 Jul 2021 00:41:52 +0200
Message-Id: <20210712224152.2698500-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.32.0.100.g73bb85aa45
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 88473c8bae ("load_ref_decorations(): avoid parsing non-tag
objects", 2021-06-22) introduced a shortcut to `add_ref_decoration()`:
Rather than calling `parse_object()` directly, call `oid_object_info()`
and then either return early or go on to call `lookup_object_by_type()`
using the type just discovered. As detailed in the commit message, this
provides a significant time saving.

Unfortunately, it also changes the behavior. As an example, on git.git,

  git log --oneline --decorate origin/master | grep '(.*tag:.*)'

returns zero hits after 88473c8bae. Before it, we have around 800 hits.
What happens is, all annotated tags are lost from the decoration.

Let's do a partial revert of 88473c8bae: Keep doing that early
`oid_object_info()`, but after that, go on with the full
`parse_object()`. This restores the pre-88473c8bae behavior. We clearly
have lacking test coverage here, so make sure to add a test. Without
this fix to log-tree.c, the git-log invocation in this new test does
pick up the lightweight tags involved, but misses out on the annotated
tag.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Cc-ing Peff, the author of 88473c8bae, and Taylor, who made a comment
 regarding the peeling of tags [1], which might be related.

 I'm genuinely unconvinced that my proposed fix is the best possible one.
 Or maybe trying a more surgical fix around annotated tags misses a
 whole bunch of *other* special cases and we really should go for the
 full `parse_object()` to cover all possibilities.

 In my brief testing (time git log -1 --decorate on git.git), the time
 savings from 88473c8bae seem to be gone. So maybe this should be a full
 revert, rather than a partial one. (Plus the test.) Let's hope that
 won't be necessary.

 Also, I'm not sure whether the test really needs to worry about the
 order of the decorations suddenly changing -- maybe it's supposed to be
 stable.

 [1] https://lore.kernel.org/git/YNKgkGkPiMgNubNE@nand.local/

 log-tree.c     |  6 ++----
 t/t4202-log.sh | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 4f69ed176d..0b638d2e3c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -134,7 +134,6 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 			      int flags, void *cb_data)
 {
 	struct object *obj;
-	enum object_type objtype;
 	enum decoration_type deco_type = DECORATION_NONE;
 	struct decoration_filter *filter = (struct decoration_filter *)cb_data;
 
@@ -156,10 +155,9 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 		return 0;
 	}
 
-	objtype = oid_object_info(the_repository, oid, NULL);
-	if (objtype < 0)
+	if (oid_object_info(the_repository, oid, NULL) < 0)
 		return 0;
-	obj = lookup_object_by_type(the_repository, oid, objtype);
+	obj = parse_object(the_repository, oid);
 
 	if (starts_with(refname, "refs/heads/"))
 		deco_type = DECORATION_REF_LOCAL;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 350cfa3593..3aa5451913 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1905,6 +1905,20 @@ test_expect_success '--exclude-promisor-objects does not BUG-crash' '
 	test_must_fail git log --exclude-promisor-objects source-a
 '
 
+test_expect_success 'log --decorate includes, e.g., all kinds of tags' '
+	git log --oneline --decorate >log &&
+	test_line_count = 2 log &&
+	grep "^1ac6c77 (tag: one) one$" log &&
+	grep HEAD log | sed -e "s/^.*(\(.*\)).*$/\1/" -e "s/, /\n/g" |
+		sort >actual &&
+	cat >expect <<-\EOF &&
+		HEAD -> source-b
+		tag: source-tag
+		tag: three
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'log --end-of-options' '
        git update-ref refs/heads/--source HEAD &&
        git log --end-of-options --source >actual &&
-- 
2.32.0.402.g57bb445576

