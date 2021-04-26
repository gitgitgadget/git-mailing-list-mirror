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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F400C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EBAF61158
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhDZQSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbhDZQSb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:18:31 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468D3C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:17:50 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id e89-20020a9d01e20000b0290294134181aeso26807963ote.5
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NkCy8Zj7/tFE0ohbC712KF8zRYjbl34aNl+fKWbx5iY=;
        b=DGQ4Aysa6pbxdmj0ou5P2r6TjRjJS/EOOvVGI4OUfJNXA6kwqXixAue8Q3YaxCfxs6
         vpi5cIdtUDoQMnOC4oZ+4rsE+UMwYb25qSUweNvbuLJpu1zHXJ6CSpHZHEOxf5Pz1/Ix
         AC2+kaOhoB0pQvpb2Dc0bSIjCVKbwJbwETxE5GXWu0sM/mkQLHrY/Iwa3PJVkFyAN9a9
         T3EcMsNT0sZcVLv6qiDnaSEUc1Koz2PavZCGBlYlDKJTF6mjlMAH6E00ge34r4rRvBbu
         skndNcuolP4z6+uWsVgtnDME5SuX71PhnGnzJUYqssLyF0DVgUdsDL3348Kwy1Teo47c
         Z1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NkCy8Zj7/tFE0ohbC712KF8zRYjbl34aNl+fKWbx5iY=;
        b=HbYL4TDYxqlrMFMMSRooAvSyUNDJe+ZeFXfRirHbU1Hhtg+A2GPBgq15pj+cKbNOVH
         zcljj0+uS9Jn6NzBbNYM5bNu7cyyeZy/fetLI50YN4lrSnovf7HvFUfQpaFH6hZmHhTV
         +nW5OeOHKsuqi4FGOrybfcsll/HWFFyLBC0qNm4LVLKnl02trQoghQSjKIrBNwn0kKKh
         hbnBJCnv9TyQr1Vw4zuY85Eywn+sn8SiOoM5qUCGchNwicz852yXSnN1HgwABfqrrhW/
         KJc6/+uVM0RL3YEoJ/qFbKACTIJ6zXzkl/L7PhMvFOOrkLbQA4hmgShc6le+JtbGXuRN
         luGw==
X-Gm-Message-State: AOAM533J+G9mZN+WlQT6pSY1V8my+zWNjC31yTgEoDIuudcDqwbNq8wG
        qUcWS2hB6WlKVQ7kg9sBLvX1HtTFIZf2WQ==
X-Google-Smtp-Source: ABdhPJya9mZcJc7pgz5EJh1bAvPEP/xZymRCqfILzTsHclSQjtx7A2vPf3qABRq/al7znDFi1hVR+Q==
X-Received: by 2002:a9d:2608:: with SMTP id a8mr15599145otb.136.1619453869501;
        Mon, 26 Apr 2021 09:17:49 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id c65sm3123034oia.47.2021.04.26.09.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:17:49 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 20/43] completion: factor out check in __gitcomp
Date:   Mon, 26 Apr 2021 11:14:35 -0500
Message-Id: <20210426161458.49860-21-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This way we can reorganize the rest of the function.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 ++++--
 contrib/completion/git-completion.zsh  | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e05588e109..0d00bfe83b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -330,9 +330,11 @@ __gitcomp ()
 {
 	local cur_="${3-$cur}"
 
+	if [[ "$cur_" == *= ]]; then
+		return
+	fi
+
 	case "$cur_" in
-	*=)
-		;;
 	--no-*)
 		local c i=0 IFS=$' \t\n'
 		for c in $1; do
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index d754086877..090c644b71 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -55,9 +55,9 @@ __gitcomp ()
 
 	local cur_="${3-$cur}"
 
+	[[ "$cur_" == *= ]] && return
+
 	case "$cur_" in
-	*=)
-		;;
 	--no-*)
 		local c IFS=$' \t\n'
 		local -a array
-- 
2.31.0

