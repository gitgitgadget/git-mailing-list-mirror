Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A98C636C9
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC8666115C
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbhGQPo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 11:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbhGQPov (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 11:44:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32923C061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:54 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n4so7592401wms.1
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6nmzd1WY5d008MKBiZdP3xj2FvDspd9va7AIkNv7CdQ=;
        b=sF8BMJeExnLLLD5dTomTyIrYsFrnyDbsvKNwsuOn3fQWfvfyLae5pJbindXKrJcSg5
         x7NIlpQ8Fcyy0LRxZphkHP4G+PY5hDfui8qqnNNPB2gzrXq1js0McXk/XGwQlKtpIQ9K
         8NHAmkSOWQDNjll1jBOX8CKqoCwXMjehQV7vlVQNRpLmXFAZejtLIsV3kIj+/+jP0gxx
         HdLYQAmvoGig7AZms4oNOY7ULKC+0pQqRyK/kqcelscFVAKyxhFG3H3TRopinBs+cbpO
         wWzkYBD55eWtq5G26fJFVpCAPO/lHaCVsbnCRwc+8kv6/hyxu+/3aFX6I/ktt2EOSNbE
         OenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6nmzd1WY5d008MKBiZdP3xj2FvDspd9va7AIkNv7CdQ=;
        b=mmp+L+KuwWBDDm0kaCUtc6jVL/MkaOjpMrjlZXfUgA7bnRq7VIOatRfFBTD7M4ZunN
         YkOm9FB2/cyQ2YOkrJkvNI/i+1uMbZ2MEsfIoVG9kQWYgEmXTxFG6BZ4vUIKTupTqjR1
         Ry2si/QwFtZLDYyBvTY8yVMgecM06m7jEFtpktgAiM9QnAyCcAnfPwl+l5JywZTN1F8+
         cPKB/65iqllwOOf2/tiq7DzvhNdG7fXIKVaqDr9nz062ajxAwwX/ownMx+QKtgnl5ab+
         rHY1FjCE9p0zGWORIU9jm/igXA0RlvHiFFvxRToiS8oBhhizlxp7m427lExis3djy0kp
         CLKg==
X-Gm-Message-State: AOAM532im/RiY7cN3CBP1Q9T055P12V5K6N702VtO4T4uQ/Ch4WJCxFc
        Umkysbqj/g/HZvJDpwchQBqyNnBco/E=
X-Google-Smtp-Source: ABdhPJw33BD0z9jJF8HAu7FybAVlGt0yZtxEvqCqcbSplae+72ZI1iUjIO6pIw8zs9IMzAyyQGcdwA==
X-Received: by 2002:a05:600c:3786:: with SMTP id o6mr22976781wmr.155.1626536512806;
        Sat, 17 Jul 2021 08:41:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm10934450wmc.42.2021.07.17.08.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 08:41:52 -0700 (PDT)
Message-Id: <3d9ff69198e5a604b124bf861df4d6ecf6eb661e.1626536508.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Jul 2021 15:41:43 +0000
Subject: [PATCH 5/9] pull: ensure --rebase overrides ability to ff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Now that the handling of fast-forward-only in combination with rebases
has been moved before the merge-vs-rebase logic, we have an unnecessary
special fast-forward case left within the rebase logic.  Actually, more
than unnecessary, it's actually a violation of the rules.  As per
https://lore.kernel.org/git/xmqqwnpqot4m.fsf@gitster.g/, --rebase is
supposed to override all ff flags other than an explicit --ff-only.
Ensure that it does so by removing the fast-forward special case that
exists within the rebase logic.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/pull.c  | 8 +-------
 t/t5520-pull.sh | 6 +++---
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 5c9cbea37c9..5ba376a7487 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1070,13 +1070,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
 
-		if (can_ff) {
-			/* we can fast-forward this without invoking rebase */
-			opt_ff = "--ff-only";
-			ret = run_merge();
-		} else {
-			ret = run_rebase(&newbase, &upstream);
-		}
+		ret = run_rebase(&newbase, &upstream);
 
 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index e2c0c510222..4b50488141f 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -295,7 +295,7 @@ test_expect_success '--rebase (merge) fast forward' '
 	# The above only validates the result.  Did we actually bypass rebase?
 	git reflog -1 >reflog.actual &&
 	sed "s/^[0-9a-f][0-9a-f]*/OBJID/" reflog.actual >reflog.fuzzy &&
-	echo "OBJID HEAD@{0}: pull --rebase . ff: Fast-forward" >reflog.expected &&
+	echo "OBJID HEAD@{0}: pull --rebase . ff (finish): returning to refs/heads/to-rebase" >reflog.expected &&
 	test_cmp reflog.expected reflog.fuzzy
 '
 
@@ -307,8 +307,8 @@ test_expect_success '--rebase (am) fast forward' '
 
 	# The above only validates the result.  Did we actually bypass rebase?
 	git reflog -1 >reflog.actual &&
-	sed "s/^[0-9a-f][0-9a-f]*/OBJID/" reflog.actual >reflog.fuzzy &&
-	echo "OBJID HEAD@{0}: pull --rebase . ff: Fast-forward" >reflog.expected &&
+	sed -e "s/^[0-9a-f][0-9a-f]*/OBJID/" -e "s/[0-9a-f][0-9a-f]*$/OBJID/" reflog.actual >reflog.fuzzy &&
+	echo "OBJID HEAD@{0}: rebase finished: refs/heads/to-rebase onto OBJID" >reflog.expected &&
 	test_cmp reflog.expected reflog.fuzzy
 '
 
-- 
gitgitgadget

