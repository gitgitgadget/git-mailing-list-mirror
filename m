Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3007C433FE
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 17:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356568AbiASR6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 12:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356548AbiASR6r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 12:58:47 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2670C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 09:58:46 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id e9-20020a05600c4e4900b0034d23cae3f0so7203090wmq.2
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 09:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=H0+Xnp9s85u0AWe6t7v1RiHo3tLbXSWuZ6eDF1L6H/I=;
        b=oH5d0WmRtvqDtWCrj+0EfrVaz+XTo1ubw583e0k0CPC8zU8KDe8dK9KTl0nlqexOoF
         qUWTyjK5umRnoGFSCC1bMILQlWvSF/CbvCyGAHUr84ucuvQWuZboWi8lOm21fr4Qpm0d
         7KgW3lJjtbtNTFGfT9ND207mAO3DedH/uMQP5X0Id0/AeTKnzSFoqu46A9x8z0BGXEut
         XLyM9jklNHTl6y6jVmTd0B4o/EgYASTnR3YKQJJpkKVv9F+Giqi+IfxtHKcDRnrZ1lMY
         /i/MuGMgCfbAokBHIj4T5qNmJcdnkOcXbjDV0ZauX/Wm4d5diE/4zB0aLaR5gUqKCdj5
         fbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=H0+Xnp9s85u0AWe6t7v1RiHo3tLbXSWuZ6eDF1L6H/I=;
        b=qfqUMb6w7Lk/hiYW1r5ZRW/ffoOv42byz56F3HZKa4sDn9eBv5haleyP8VB5DNthgk
         lyGHaO3qS2MoUFSuIwSKY+6/x0dLHQnbb06taqfq1UDFF0c8HxVYYKFAHlyCV3gM8pVi
         KoJ6qeIjmYJQkXqiCqsP14fM786aRg6IhVm4APQIt7ctfszpEN4p7tjkCzJuXcIVkE1+
         hNiZc//V+lywShfqrpu6WB9OvQvMc4eiJT87eXr1//UTWcsmJIXBuWO6bcxEL9cOYM+o
         otgf2UaXgRb4eomPAWul4icbwhc1KX6uc7ff2IWf6yYlwBkt1RMFJjQLHKlnzrqAMCrB
         Bkdw==
X-Gm-Message-State: AOAM532TiEqlAhbYlALFl+WBM8Q+Bv0E4MRyhRyVeHDy7dWsUZp2Un0t
        swvh/aKgVLOMnNojU/m9GmNaU7tMVbc=
X-Google-Smtp-Source: ABdhPJxwlyPp8j0kfgYs/44jRVi6kyUOBAe8ChuetLhQ6iPgYKQchc43ZOJKaL4/XJJz8LUEtZ0MFA==
X-Received: by 2002:a05:6000:1709:: with SMTP id n9mr4538727wrc.10.1642615125158;
        Wed, 19 Jan 2022 09:58:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l19sm275002wmq.7.2022.01.19.09.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 09:58:44 -0800 (PST)
Message-Id: <ea7408c36e515440771851c3581d7a9e3c6e4c8f.1642615122.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1191.git.git.1642615122.gitgitgadget@gmail.com>
References: <pull.1191.git.git.1642615122.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Jan 2022 17:58:41 +0000
Subject: [PATCH 1/2] strvec.c: add a strvec_split_delim()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

This is just string_list_split() copy/pasted with the "push" part
adjusted. The next commit will call this function to parse a line of
command arguments.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 strvec.c | 23 +++++++++++++++++++++++
 strvec.h |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/strvec.c b/strvec.c
index 61a76ce6cb9..7dca04bf7a5 100644
--- a/strvec.c
+++ b/strvec.c
@@ -85,6 +85,29 @@ void strvec_split(struct strvec *array, const char *to_split)
 	}
 }
 
+size_t strvec_split_delim(struct strvec *array, const char *string,
+			  int delim, int maxsplit)
+{
+	size_t count = 0;
+	const char *p = string, *end;
+
+	for (;;) {
+		count++;
+		if (maxsplit >= 0 && count > maxsplit) {
+			strvec_push(array, p);
+			return count;
+		}
+		end = strchr(p, delim);
+		if (end) {
+			strvec_push_nodup(array, xmemdupz(p, end - p));
+			p = end + 1;
+		} else {
+			strvec_push(array, p);
+			return count;
+		}
+	}
+}
+
 void strvec_clear(struct strvec *array)
 {
 	if (array->v != empty_strvec) {
diff --git a/strvec.h b/strvec.h
index 9f55c8766ba..c474918b91a 100644
--- a/strvec.h
+++ b/strvec.h
@@ -73,6 +73,14 @@ void strvec_pop(struct strvec *);
 /* Splits by whitespace; does not handle quoted arguments! */
 void strvec_split(struct strvec *, const char *);
 
+/**
+ * strvec_split_delim() is a split function that behaves more like its
+ * string_list_split() cousin than the whitespace-splitting
+ * strvec_split().
+ */
+size_t strvec_split_delim(struct strvec *array, const char *string,
+			  int delim, int maxsplit);
+
 /**
  * Free all memory associated with the array and return it to the
  * initial, empty state.
-- 
gitgitgadget

