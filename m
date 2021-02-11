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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A6DC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7B364E57
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhBKTuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 14:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhBKTs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 14:48:58 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A22C061756
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:32 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id q20so4351783pfu.8
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=l6ktkneQ9gqnysnae9q5dUuZ67jn2ChwM6a/SbFPy4o=;
        b=dhuMB8uzUSYQ14Sd4mUY+7gnSckoPhGwgagDUT7xuW4SAOkgNf/4iG/tjS7U60ZrVn
         QwYjO8QSGstgz85Czx0dtGbDl5kfZpcm9BSj6GDb4btOTUAeZ4KidS5YMxcVIm/sHUKl
         vmj4zZ5EQVEEFeOjqoZuuhJrkRKmm7eREWPAcyQc1XltgjkJ+T4tdBH1FbPMEB4t4SnC
         x0Nr/by4A70Eh1NAjTqxrW1E2blLK1Xl4uYVHVbUPs7l6MFwards+/r+XtRKK8eKPO21
         reDUnAMB1HAWD6jBkzcZlQIxuDKU7YBKwKLcscTlyKxVTRJGjEvgKZqzrRO2O1PezIoc
         rxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l6ktkneQ9gqnysnae9q5dUuZ67jn2ChwM6a/SbFPy4o=;
        b=QRrOrB8wLv0Hff9ygVQEFCyp1WaNKhZPXi0f9xcPkhsF1/slpmCkCWsQ0bEVCFudVz
         aS/OKWwDL2A74J6BCJtjulOAJOPckEkESG9I1tAS4/0zmiJxTAn8pYiHB/o4OiLV5KeI
         0lE73qX5EeyK2A9yZBb5K/3xGhqFjjOo+d79roPMz/g4aerG3C4DbLydOTlA7m4NthvR
         F/frYBSgYc6n2LCwOB8SsNNHfgenyshK+rFRlHYFWzT3rEnVcSIh46Q3O2kjOOpvgrVC
         9qj0lXnwBhHNlMF+fB8EG66ILS31pFsfS8fR8Vt9ZPHYwqUUyJoiFbJ6mR3IWSnZPxOf
         5gLw==
X-Gm-Message-State: AOAM533pkVgwA18p9tHHHxIz+EmhTQuHTf4ZUWu5MjHkycT2gTAmAtjG
        qcKi/zWJc5swJFAQ66vM7GMU1wiYT2UsvA==
X-Google-Smtp-Source: ABdhPJz0cTYJwNVl7ZSIkC7ubOo8PokLS6oV7rHUltqSjXsve1hpC3LEZ3/DI1vgTN1jT9E3/AV7rA==
X-Received: by 2002:a63:4f1f:: with SMTP id d31mr9927159pgb.104.1613072852156;
        Thu, 11 Feb 2021 11:47:32 -0800 (PST)
Received: from localhost.localdomain ([47.8.36.172])
        by smtp.gmail.com with ESMTPSA id a141sm6524778pfa.189.2021.02.11.11.47.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:47:31 -0800 (PST)
From:   Shubham Verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 09/10] t7001: use here-docs instead of echo
Date:   Fri, 12 Feb 2021 01:17:03 +0530
Message-Id: <20210211194704.28913-10-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211194704.28913-1-shubhunic@gmail.com>
References: <20210211194704.28913-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change from old style to current style by taking advantage of
here-docs instead of echo commands.

Signed-off-by: Shubham Verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 93d6767951..36a274e96d 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -228,7 +228,10 @@ test_expect_success 'git mv to move multiple sources into a directory' '
 	git add dir/?.txt &&
 	git mv dir/a.txt dir/b.txt other &&
 	git ls-files >actual &&
-	{ echo other/a.txt; echo other/b.txt; } >expect &&
+	cat >expect <<-\EOF &&
+	other/a.txt
+	other/b.txt
+	EOF
 	test_cmp expect actual
 '
 
-- 
2.25.1

