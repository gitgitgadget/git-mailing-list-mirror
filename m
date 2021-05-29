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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8475C4708F
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD61F613EB
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhE2HrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhE2Hq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:46:58 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB604C061761
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:18 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id c3so6678041oic.8
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e5UyDEfEXKS6rS5B3ctgkhPMZlfEi3/toztq9EPJRPE=;
        b=Bvp/iv79qCU62xlGDJj4N5K+ufWYufxKsVfOlEUJE6Lw3XgeCrhAB6PNlEEcHMyQg1
         PsRn/o9gH8jyvbPrQX6cAWQ77CFUNmTev5h6NPBAMrwoRhpS1oN+ERrE3YZ0z1KKrM86
         1Jaf79Hh+h2nLqtK1lDn4QRtf8OZKdf++x8eC0IkpqFh4dYIMrV7F8mGizyAjttZ6QYg
         ZvDgy3mD1kfkUd+xmbdoPc3lVSoEZunfh4Td5Wu3OeXQJ2nsbx3Zz75/fnnBC47ixNJN
         8VuVvtkyOsarYmnbbb26bX7WDevPWQvwrta0q8JRgng9kh+RD5yUHNRzmzQRfwKOuuM4
         s26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e5UyDEfEXKS6rS5B3ctgkhPMZlfEi3/toztq9EPJRPE=;
        b=tRluXUrd0sUaPYuG6PvNyqHLSpe7GiQbA7lCZfjFPqBaKjGIy5G/rgiKbCou48/JtO
         +FFYsLiAWI7F7hCxkbRHgX0/SsLTmdZm08JDmPg0bYGcn05yvBdT9Tdjeppq+MijUl3y
         zETmtAqkCD1OuKNo/A8CpRNDhDPgCDsX4XsLESfr/eOxBpRPV9qQErMeObKli+JbCIe/
         93xbPC0hK1U0eiF0atF2CI6u49zoN0gMmJH2T+GLdMF+d+/3bXjZZb/piB91c1aAFSLc
         E9D4zho+XDCxwocEYvxu/Y8cpu2pzBUJVut8VBd0+QYNdVuO6rCNUFgEWW8KQ+JwOUak
         vvqw==
X-Gm-Message-State: AOAM531aZnwugGesfLlLWuMVH3bvm6nLw7GxbhTY1LRcfUvuhMKlJoAm
        if9hC8IP265Z2Wln3/o9bNgIlAVw4ZdT/Q==
X-Google-Smtp-Source: ABdhPJz5TyQSQwIY+fm8BDkKMfic1xhVxHb5EBjBoXMhOE0eeqQ78D5MvlAMoPHgMSHoUP6xnqz/JQ==
X-Received: by 2002:a05:6808:d:: with SMTP id u13mr8343088oic.103.1622274317962;
        Sat, 29 May 2021 00:45:17 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id i26sm1636539oos.21.2021.05.29.00.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:45:17 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 12/15] push: remove trivial function
Date:   Sat, 29 May 2021 02:44:55 -0500
Message-Id: <20210529074458.1916817-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's a single line that is used in a single place, and the variable has
the same name as the function.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 468ccc1067..c220f70795 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -202,15 +202,10 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
 	return branch->merge[0]->src;
 }
 
-static int is_workflow_triangular(struct remote *remote)
-{
-	return remote != remote_get(NULL);
-}
-
 static void setup_default_push_refspecs(struct remote *remote)
 {
 	struct branch *branch;
-	int triangular = is_workflow_triangular(remote);
+	int triangular = remote != remote_get(NULL);
 	const char *dst;
 
 	switch (push_default) {
-- 
2.32.0.rc0

