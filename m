Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62673211B4
	for <e@80x24.org>; Sat, 15 Dec 2018 00:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbeLOAAT (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:00:19 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:35048 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbeLOAAS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:00:18 -0500
Received: by mail-qt1-f202.google.com with SMTP id p24so7354150qtl.2
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D7bzh1aKLksuqkZbb2ZIJMb4fJiu9WV17rk2PPP784U=;
        b=HGs5n3t7FKQdIY0P7Jc1VoaNw0LlKXEC9HpIIb5Z/tAwSpsIUriqTlQYVPhCpndBCg
         DZ8cvsgVcKzVTsvsSmPNcdqr+fHEFJMFMIv0nECfSn/majEayNu0KYuNwHWhUbTj36YL
         A0oQvvY7ouqOLNgZaxh1W+mOqdXYX6kp9ypgbm2K47p13zias6rcYRVXweStiWsYSHFe
         yzNRcO2TBdsYFWMCKTREixX+oYL7iluuO1vta95xYmcS3KFERsgwXk9l9SMEeRTm1zbk
         FNmnegpwuJfAqNSjP2CB/DHw7O0h8sIuwXLDdCP1SbmgD4u1cbBglxkgIVByuX4shWUy
         NDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D7bzh1aKLksuqkZbb2ZIJMb4fJiu9WV17rk2PPP784U=;
        b=sNwlYFmsSjbkP9ABlPZe0JPOicP/kBilx6phy7m9u9IEfzDtGVMhZOd4WS5TcspNK/
         i60T9La8+fUeO9pOanUhZ0JMlZLOuYAnFZZPHK9nx56W3LF722z/Rs4Ng+6ywrfh7brl
         kp+qkIw5cI1p2FnoOpSHVY7YOfy1DpLszi4zxpoQuxXuuaRyDzj8xThRVW9KLOVWXpG9
         ZrM+GoiM3574BdNKBW52BAOVMZYJFQoo4bbQO/Kr860i154PKanGuXvYUzJdj8V8mis3
         hmSg5nuLF7IuYKToQX8U1AzJ72h8v0w91tgNIOiPghev1NVQShU7fgpjqEc9H+u6iJGi
         URQQ==
X-Gm-Message-State: AA+aEWZW8BjUXnURr58w3ai7fb4e5WAV0nJKTXcEmdMOoDxjkNyKmYFW
        O5bMIGpYG84Pkk5PfvHy1FuC/LnRNXR8
X-Google-Smtp-Source: AFSGD/U6Zf0IL4ssqEJcuy3w6DOn3gHnU3aqhofKMLxI74v1jAN0FswEtIRhPpb62EktE1ffhoGQFF4vz9cU
X-Received: by 2002:ac8:7244:: with SMTP id l4mr4928966qtp.21.1544832014248;
 Fri, 14 Dec 2018 16:00:14 -0800 (PST)
Date:   Fri, 14 Dec 2018 15:59:44 -0800
In-Reply-To: <20181214235945.41191-1-sbeller@google.com>
Message-Id: <20181214235945.41191-4-sbeller@google.com>
Mime-Version: 1.0
References: <xmqqefas8ss4.fsf@gitster-ct.c.googlers.com> <20181214235945.41191-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 3/4] submodule--helper: fix BUG message in ensure_core_worktree
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

74d4731da1 (submodule--helper: replace connect-gitdir-workingtree by
ensure-core-worktree, 2018-08-13) missed to update the BUG message.
Fix it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d38113a31a..31ac30cf2f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2045,7 +2045,7 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 	struct repository subrepo;
 
 	if (argc != 2)
-		BUG("submodule--helper connect-gitdir-workingtree <name> <path>");
+		BUG("submodule--helper ensure-core-worktree <path>");
 
 	path = argv[1];
 
-- 
2.20.0.405.gbc1bbc6f85-goog

