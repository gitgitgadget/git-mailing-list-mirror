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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5D9C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 21:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B77722D08
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 21:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbhASVaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 16:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbhASV27 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 16:28:59 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C090C061757
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 13:28:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id c12so2603803wrc.7
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 13:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zYcTW5pLZ9kEy6pRjCU3OU9CXNLu5+2s7QayXEttCdw=;
        b=aZ8onbjvowccMoBs4C8SeJ/gaOfljfKAtsOza5utNnZQkMQpgnU35eklV1S8vmQKWE
         Hem6oJ15L5a0YGIBLybYhh8jXyl/pDEG/o0O6vyxHUf4v/YUqy2QwjzBE/WvPinYzxAZ
         +/X8v5mfnq0oCuU6pvIVIkcGw7QsrIQ+7DmzO5pFL6xlqnGNft2ImRIScSaClVCG8WJE
         8rAcpG6pW/lnHi5yoA61drIMteyE8TBxUzfS+rd3JpZhAe+FdVzMamKHBy02LXsssP4I
         /ni34VE8ciFPJnTNEmToWgpxxZGcuiq4datpgb2JVT3hCvoZ6SRy+5nEr+FE8QoVMfm9
         m1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zYcTW5pLZ9kEy6pRjCU3OU9CXNLu5+2s7QayXEttCdw=;
        b=CfTCNS3Jt8D/4Imabs3mMtzcaoZDSN0yljj4qQmL3R/NQgAHJWcjXRvpK3HOxKsR3M
         EezGiceajQWzgK9/tXH32ws46+1VKHAaLzbwXcKL8mxALGhNvC6QOfH1xm15NTCeYW6g
         LUkgb1H3P2I45dvT9Qs2XcBMU1d/BWy8ysJLzqyZSq7arhHg0B/YGI3/S63/a9x6/3rj
         RoBiuMSwq3aFqbLq+OTlTlOD9dBhI0DOTHVm/8bHeAiNq63E0PaNtutGI4d4Hn4tn0gc
         BurkWo2/JI+VmZJ0MvSN1zI6Zm2NLtofnzSH35SlqEAvZJMKgSR9iY70NvlGgFx/uf6s
         +0kA==
X-Gm-Message-State: AOAM533xS0seAUqsiv1nqYcxLHUNUecXhOWCNXH4Ee8fkO42r2iRrv1I
        IDbxl5e+5cZ2pqTmO5Ecm418OIB7B3E=
X-Google-Smtp-Source: ABdhPJzXNHtOR/NesJMw5G0yXwf6CI5bNiJtVLLPchposzt5Q30wS5CSYbkJgwXBVzjRcI7HELp+dA==
X-Received: by 2002:adf:ba8b:: with SMTP id p11mr6133432wrg.328.1611091697711;
        Tue, 19 Jan 2021 13:28:17 -0800 (PST)
Received: from localhost.localdomain ([212.86.35.161])
        by smtp.gmail.com with ESMTPSA id r2sm39448819wrn.83.2021.01.19.13.28.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 13:28:16 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v3 3/7] worktree: teach worktree_lock_reason() to gently handle main worktree
Date:   Tue, 19 Jan 2021 22:27:35 +0100
Message-Id: <20210119212739.77882-4-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.421.g32f838e276
In-Reply-To: <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

worktree_lock_reason() aborts with an assertion failure when called on
the main worktree since locking the main worktree is nonsensical. Not
only is this behavior undocumented, thus callers might not even be aware
that the call could potentially crash the program, but it also forces
clients to be extra careful:

    if (!is_main_worktree(wt) && worktree_locked_reason(...))
        ...

Since we know that locking makes no sense in the context of the main
worktree, we can simply return false for the main worktree, thus making
client code less complex by eliminating the need for the callers to have
inside knowledge about the implementation:

    if (worktree_lock_reason(...))
        ...

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 builtin/worktree.c | 2 +-
 worktree.c         | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index dd886d5029..df90a5acca 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -604,7 +604,7 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 			strbuf_addstr(&sb, "(error)");
 	}
 
-	if (!is_main_worktree(wt) && worktree_lock_reason(wt))
+	if (worktree_lock_reason(wt))
 		strbuf_addstr(&sb, " locked");
 
 	printf("%s\n", sb.buf);
diff --git a/worktree.c b/worktree.c
index fb3e286996..e00858540e 100644
--- a/worktree.c
+++ b/worktree.c
@@ -225,7 +225,8 @@ int is_main_worktree(const struct worktree *wt)
 
 const char *worktree_lock_reason(struct worktree *wt)
 {
-	assert(!is_main_worktree(wt));
+	if (is_main_worktree(wt))
+		return NULL;
 
 	if (!wt->lock_reason_valid) {
 		struct strbuf path = STRBUF_INIT;
-- 
2.30.0.421.g32f838e276

