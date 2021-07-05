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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F4AC07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEAF3613AE
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhGEMfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhGEMfB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:01 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17069C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:24 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id l17-20020a9d6a910000b029048a51f0bc3cso6382707otq.13
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9rZxuGcpANLu5SXyZ7fh9Ix7OzVFixoHZdlj8FpJAw=;
        b=taMEJwIJn1ggudMRObk4/UqnP1kNp5K5u0qkNmN2yJRaZX/5RhYDALSTYfAtddbQ2a
         ZYKGwfaXxGZtjem2qjTcLbOO8JSxqiE3tF0lT4joBsYJCPHRMfQx3oTtI6VKYiVdmvku
         KTVD9VmkR1U8BkZnT7XOIukCSR4Mot7MWFCF+VIKxEFvOem7ZnGVM5CQxJcG1dObwrd1
         6JqElo0FofgrCZr6yPBO3bv6upgrbdPJM7Y8QlKvq79pGncZOQrABsthShJNIj3elTwg
         PNnMkHRIETlLfUnW2QJ1nNcPgnEv7nL4YbjZxkUSvElwIrnNGh7zzuDM7CdH2AuPy3QM
         KZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9rZxuGcpANLu5SXyZ7fh9Ix7OzVFixoHZdlj8FpJAw=;
        b=HyA1Z00k3orn/7F5/rjeul1smjfcNIXovjAuPrwmUICcovd+333/aabKgpsYt9QZvX
         +cqcGerOe10eDwTi1M2rx0dknntrq+WUVGX8AE3FYVkVYGpApDEDcH1We5PB5QKcKQQZ
         dVl64MY6QzxE8lU5yHNTB1AWPjJv+5Lr9hyUL66LeXAcxAXCIj5H//+bXT/02VFLBAHi
         sO8CLoc1K5IDtcNkx6YmHEnR+UC4sYa3uOevJRIRZupqOUVdhyFim5foPDEj4y2POUD9
         /U4rEOWAH0U0euKlBDZMOnEF4iu5thg0FFqbcY+YHjztnlz+yx1oeLT8Gv6P7UHvZm9g
         Hgiw==
X-Gm-Message-State: AOAM531E/gZiHASbDbw8SrSx3vbzHEzzxLnKuSbaXwyWj23BgENzTKpf
        SVSz0r85EILvRoaMliivn2oJoHmOq6A3bQ==
X-Google-Smtp-Source: ABdhPJwdEF3TaVJfGXmdVzH7hd6WuIZcUEg6L1rSTxeDfIP2uIymGnKPNq8JnWgW2WvBr7yzPECa4g==
X-Received: by 2002:a9d:5c7:: with SMTP id 65mr10721871otd.360.1625488343214;
        Mon, 05 Jul 2021 05:32:23 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id x5sm2586418oto.63.2021.07.05.05.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:22 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 07/35] fast-forward: add help about merge vs. rebase
Date:   Mon,  5 Jul 2021 07:31:41 -0500
Message-Id: <20210705123209.1808663-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-fast-forward.txt | 48 ++++++++++++++++++++++++++++++
 advice.c                           |  4 ++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-fast-forward.txt b/Documentation/git-fast-forward.txt
index b7322c437e..a73834e0f9 100644
--- a/Documentation/git-fast-forward.txt
+++ b/Documentation/git-fast-forward.txt
@@ -47,6 +47,54 @@ synchronize the two branches.
 
 THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOUR MAY CHANGE.
 
+MERGE OR REBASE
+---------------
+
+The decision to whether merge or rebase depends on the situation, and the
+project. Traditionally git has prefered merge over rebase, but that creates a
+new commit, and that's frowned up on some projects, so you can't just simply
+choose to merge blindly.
+
+------------
+    D---C---B---A origin/master
+	 \
+	  X---Y master
+------------
+
+The nature of distributed version control systems make this divergence
+unavoidable. You must decide how to synchronize this divergence.
+
+If you choose to merge, the two heads (master and origin/master) will be joined
+together in a new commit:
+
+------------
+	  origin/master
+		|
+		v
+    D---C---B---A---M master
+	 \	   /
+	  X---Y---+
+------------
+
+This new commit is called a merge commit and has two parents (A and Y).
+
+Rebasing on the other hand rewrites the history:
+
+------------
+	  origin/master
+		|
+		v
+    D---C---B---A---X'---Y' master
+------------
+
+The commits that diverged (X and Y) are rewritten as if they were created on top
+of the new base (A). This creates a linear history, which is cleaner, but some
+people prefer to preserve the original hsitory.
+
+In both cases it's likely you would have to resolve conflicts, the difference is
+that in a merge you would have to do it all at once in one commit, while with a
+rebase you would have to do it on every rewritten commit.
+
 SEE ALSO
 --------
 linkgit:git-merge[1], linkgit:git-rebase[1]
diff --git a/advice.c b/advice.c
index 60de7fbc4e..7f422b05d3 100644
--- a/advice.c
+++ b/advice.c
@@ -337,5 +337,7 @@ void diverging_advice(void)
 		"\n"
 		"or:\n"
 		"\n"
-		"\tgit rebase\n"));
+		"\tgit rebase\n"
+		"\n"
+		"For more information check \"git help fast-forward\".\n"));
 }
-- 
2.32.0.36.g70aac2b1aa

