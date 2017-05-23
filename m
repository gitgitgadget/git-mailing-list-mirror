Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6963220281
	for <e@80x24.org>; Tue, 23 May 2017 19:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764904AbdEWTcK (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:32:10 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33655 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764886AbdEWTcI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:32:08 -0400
Received: by mail-qk0-f194.google.com with SMTP id o85so24050305qkh.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=YOq8W4k/LmFDsjele7XvWL6haDRCfY5e3vWtVtml0bU=;
        b=nxcDVbdxfQDcLmXi0AX+Ud4v+h7lFdPR0SjkZGOlQMqq2inShwkpLoE8D4oiTnqPXy
         tT1PvNzRsztrnL+zMoOIj1YTUrHoCThwzYIa8k8hujSFbdKLLW0SDyv/H5fEDqw8hVE4
         a3g7iMStU0S346k83MboA9a0Nptbph3VK5mfqJM4WspZuslzr3SXpdOzTxdtL5iBWrIN
         zertxPYiADWn8nwEVA58I6HpMABXulvE8wmgoK/cldO5fwAiX4O6nydLhoeLAGluxEl+
         FnfCtylMQxQt7eUNTOBeyE1B9r03RypWUB2QNpyex9ll3fafBb3LO+790f+7kqRGmnbA
         3C/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=YOq8W4k/LmFDsjele7XvWL6haDRCfY5e3vWtVtml0bU=;
        b=tvZALxy8ac9VUko6Yd0I+wXfookR3ZxGG/OuRwGAdFfUMl0r+lKyZICgaZ/I8pUMBL
         BDiU7YMm8Zpg/YwF/gyb9yjBSyN9Y5IjAM8eiP+g+7VWhq69UFEL0mXp/O/x5SxwGwdV
         0PpkNfGHuJQ0w6NA5EK+s86WYe22kgcz9dyz92EUJiWAbgmCl5kHbFTPmHBERumD0BH5
         kfIIiZyYvXaf1a2vzAwh/L0JShKsPXz7+tP44WEUrmNzkCa6sZliNPJCRm9IzftC7tuT
         ADtbIISDroRSwzRy4MtG9u+67ebWS/lJ188NHWhq85oAQDF4O/UT7XVr6bMhUAG+mPtv
         2QNQ==
X-Gm-Message-State: AODbwcAGRZXuvOfHLzxTOp/WwyvhpPL+GTdjWqSqvF844jTv28yBo05h
        fUKXbvaBLLcfmkUXTDI=
X-Received: by 10.55.69.72 with SMTP id s69mr25237977qka.175.1495567927304;
        Tue, 23 May 2017 12:32:07 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id f94sm1058506qtb.16.2017.05.23.12.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 12:32:06 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v6 3/6] dir: recurse into untracked dirs for ignored files
Date:   Tue, 23 May 2017 06:09:34 -0400
Message-Id: <20170523100937.8752-4-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523100937.8752-1-sxlijin@gmail.com>
References: <20170523100937.8752-1-sxlijin@gmail.com>
In-Reply-To: <20170523091829.1746-1-sxlijin@gmail.com>
References: <20170523091829.1746-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We consider directories containing only untracked and ignored files to
be themselves untracked, which in the usual case means we don't have to
search these directories. This is problematic when we want to collect
ignored files with DIR_SHOW_IGNORED_TOO, though, so we teach
read_directory_recursive() to recurse into untracked directories to find
the ignored files they contain when DIR_SHOW_IGNORED_TOO is set. This
has the side effect of also collecting all untracked files in untracked
directories as well.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 dir.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index f451bfa48..68cf6e47c 100644
--- a/dir.c
+++ b/dir.c
@@ -1784,7 +1784,10 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			dir_state = state;
 
 		/* recurse into subdir if instructed by treat_path */
-		if (state == path_recurse) {
+		if ((state == path_recurse) ||
+			((state == path_untracked) &&
+			 (dir->flags & DIR_SHOW_IGNORED_TOO) &&
+			 (get_dtype(cdir.de, path.buf, path.len) == DT_DIR))) {
 			struct untracked_cache_dir *ud;
 			ud = lookup_untracked(dir->untracked, untracked,
 					      path.buf + baselen,
-- 
2.13.0

