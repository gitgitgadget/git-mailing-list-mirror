Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91EFD1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 19:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbeJXD3P (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 23:29:15 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38986 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbeJXD3P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 23:29:15 -0400
Received: by mail-vk1-f196.google.com with SMTP id y69so621707vkd.6
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 12:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MHcaqR+ft/9mL3nDuUgXmOvhGxQB759K4PLzts0umBI=;
        b=DUWwLKd8Az7e3rARppjSFhX4dTmck6IDsfErpLMW7bpw/m0RU8l+YNwMU5CBHtLoRI
         n5iimBCRVEOGlP+bNz+ykamJvWihM0acK8BAVjP+kG1Q00JkJBuPLMTatPpPHrdpe5D7
         YlGDkQaWRzpViX1CmT10V1CaVaXZGnevpOSmkE0E6bz/re5pk17lyM3nZyD5TKrHPh3/
         w/Hnqt1b3mWfVfranCtHzH3bx6urnvy6bBYt4rbynobV6hby/yoz3IvQzd+VK0iOUxB+
         /QmX7dY0i7haP2AmOyNY/ekJaKjXooNSaqTPfYtv0ytJelmPIzT5enhAZubZip72zIAM
         CmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MHcaqR+ft/9mL3nDuUgXmOvhGxQB759K4PLzts0umBI=;
        b=MnT7YEuljWtI4NbicUuk5bqSDplIbmImr20IWcXl3X3Qd9f0dQYOOLhgqy/omZ/Dfp
         q6ESbkqxnf/YiqSZk4sfyXxf3gaqlEkLjfCFpWOhDJfrksvAIEPjBMIa9bHbF3063WOD
         1vwYvlQi70RbRJIQHsuqS5Mz1BHkPV0YunjtP805RoNKio3FAEpM30qGHgaMF7JN+923
         VjC9b+YX8BSS3kBWF9zHzL+dMsJyaa0kStWG/HYuwUuuRZgqOUM9hdqRALLrhmf5eVlW
         Htnj5Zhgky9JzRhV78VNiioTHZL+Dft/TWPkWOKUmp4TsdQu3P2WZRojhXjrQUFiA4Ff
         QbCQ==
X-Gm-Message-State: AGRZ1gKLX0R/Iz+iVImkjx7OwmPsv8jF2Tx9jkLqX1ZXTmwsNZtH2QeO
        pqTGvpXQaPCJF/9BM9vJXiHCy3mLHJY=
X-Google-Smtp-Source: AJdET5c+V6B3WjUkE/HkqM65kYw5HjOUMAvywX0Xl2yIOSCO1eVK5mL+sJZqP5pLFj4er4oopCW18g==
X-Received: by 2002:a1f:d803:: with SMTP id p3mr1503975vkg.9.1540321474203;
        Tue, 23 Oct 2018 12:04:34 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id e79sm473284vsd.1.2018.10.23.12.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:04:33 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, peartben@gmail.com,
        peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v4 1/3] reset: don't compute unstaged changes after reset when --quiet
Date:   Tue, 23 Oct 2018 15:04:21 -0400
Message-Id: <20181023190423.5772-2-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20181023190423.5772-1-peartben@gmail.com>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181023190423.5772-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

When git reset is run with the --quiet flag, don't bother finding any
additional unstaged changes as they won't be output anyway.  This speeds up
the git reset command by avoiding having to lstat() every file looking for
changes that aren't going to be reported anyway.

The savings can be significant.  In a repo on Windows with 200K files
"git reset" drops from 7.16 seconds to 0.32 seconds for a savings of 96%.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 builtin/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 11cd0dcb8c..04f0d9b4f5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -375,7 +375,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
 			if (read_from_tree(&pathspec, &oid, intent_to_add))
 				return 1;
-			if (get_git_work_tree())
+			if (!quiet && get_git_work_tree())
 				refresh_index(&the_index, flags, NULL, NULL,
 					      _("Unstaged changes after reset:"));
 		} else {
-- 
2.18.0.windows.1

