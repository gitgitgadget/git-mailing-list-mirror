Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4818E1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 02:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387686AbeHPF00 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 01:26:26 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:46386 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeHPF00 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 01:26:26 -0400
Received: by mail-vk0-f74.google.com with SMTP id h81-v6so843970vke.13
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 19:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=JkatnKAZ/LecQk7nPFZXnqJiOgYmZRw3qBinuT4Rqa8=;
        b=YEZVlPDsz2BJZSoN4zLb2UlvU86LoycdvDZHjfupOEZvBmUze+448uKGZkF7rvhxcS
         TXZlmNOD9H4mLvC/VQ+pIgavbiqQQ1V+KqVZKAIhJo41fWGO3kVXbdHEVt+SHpnN5B/n
         3LKZiYWUmsy54ahfOa4ZcgYjt87D06CQ1QPgMLgH1f1my5wZrG0xSax6pT+WZzVqibfP
         7KU5R4WuOEwqAHY3y6/7UezBZNw2ncufSJBoPNsk89QpgcyTgBf4vYoUoWJQr2A3m92c
         XimrnW9nJTkcCJlgHXj1pmTSSP25IG4bJ/FcH1SkjlBBGZhyZv3iNsjGm2F+cI2Y2/gX
         UTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=JkatnKAZ/LecQk7nPFZXnqJiOgYmZRw3qBinuT4Rqa8=;
        b=goHXn+hKuUeNficmIVqxneSJQjc/rmZIHsxirYSl4fugbo3ULptgJkKhb62sfcaGNA
         qu/ga5SOhSywdARmFTIH6sDO7w4Iq/LbNgmHJ3ufMtUdieKD5INzoicoMMvoYOTMkYoj
         LKI5NpQM2vpA67ZvinrI1YnMsMrS4eyFjVGa41I06z1qx1YlUc+6L1aXSzL1v47WjG7Q
         sNLOoJd/3f0ASeg+0oPHvrU5MfyR+l3LoLVlK6HwUl9Gy9KEH6TpxLRxK5xnsCsjFcJX
         PtMDq6I4yPAYrnvb80CvLoAHRr+iU4vEZ4R/s4qsCFqSr9+5ortaq8/YvDznti73nrZf
         RZgA==
X-Gm-Message-State: AOUpUlGLV8PQUGTtu3Fb4gTN5Lw+EIBEcYdFNTIerzivgyLRduCEeFve
        IPBIvaN5NyGWhK1n+P++HlZ3Ka0HQnOhUZhNpR2h14Suok7Of8DRk24hCkw40eWi85A2Aer5yG8
        PrOeCjNEEfv+rVtXzR3SRzx05WMY9i0i+cOkFTN8/qpL70akzkezOJ75I9cAv
X-Google-Smtp-Source: AA+uWPy28EZb2KgwKT9gHEZbpkiNJZvapc+acp0VquyXDKFjYJ+jhFizTkAV6K2ZMiDinFQ2horxEJ79R+4y
MIME-Version: 1.0
X-Received: by 2002:a1f:7d07:: with SMTP id y7-v6mr15396687vkc.45.1534386678583;
 Wed, 15 Aug 2018 19:31:18 -0700 (PDT)
Date:   Wed, 15 Aug 2018 19:30:56 -0700
In-Reply-To: <20180816023100.161626-1-sbeller@google.com>
Message-Id: <20180816023100.161626-4-sbeller@google.com>
References: <20180816023100.161626-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.265.g16de1b435c9.dirty
Subject: [PATCH 3/7] submodule: is_submodule_active to differentiate between
 new and old mode
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The change a086f921a72 (submodule: decouple url and submodule interest,
2017-03-17) enables us to do more than originally thought.
As the url setting was used both to actually set the url where to
obtain the submodule from, as well as used as a boolean flag later
to see if it was active, we would need to keep the url around.

Now that submodules can be activated using the submodule.[<name>.]active
setting, we could remove the url if the submodule is activated via that
setting.

In preparation to do so, pave the way by providing an easy way to see
if a submodule is considered active via the new .active setting or via
the old .url setting.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 5 +----
 submodule.h | 6 ++++++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/submodule.c b/submodule.c
index 6e14547e9e0..d56350ed094 100644
--- a/submodule.c
+++ b/submodule.c
@@ -221,9 +221,6 @@ int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 	return 0;
 }
 
-/*
- * Determine if a submodule has been initialized at a given 'path'
- */
 int is_submodule_active(struct repository *repo, const char *path)
 {
 	int ret = 0;
@@ -267,7 +264,7 @@ int is_submodule_active(struct repository *repo, const char *path)
 
 	/* fallback to checking if the URL is set */
 	key = xstrfmt("submodule.%s.url", module->name);
-	ret = !repo_config_get_string(repo, key, &value);
+	ret = !repo_config_get_string(repo, key, &value) ? 2 : 0;
 
 	free(value);
 	free(key);
diff --git a/submodule.h b/submodule.h
index 4644683e6cb..bfc070e4629 100644
--- a/submodule.h
+++ b/submodule.h
@@ -45,6 +45,12 @@ extern int git_default_submodule_config(const char *var, const char *value, void
 struct option;
 int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 						     const char *arg, int unset);
+/*
+ * Determine if a submodule has been initialized at a given 'path'.
+ * Returns 1 if it is considered active via the submodule.[<name>.]active
+ * setting, or return 2 if it is active via the older submodule.url setting.
+ */
+#define SUBMODULE_ACTIVE_VIA_URL 2
 extern int is_submodule_active(struct repository *repo, const char *path);
 /*
  * Determine if a submodule has been populated at a given 'path' by checking if
-- 
2.18.0.265.g16de1b435c9.dirty

