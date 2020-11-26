Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DB4C63697
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F92321D91
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 19:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGzyBsrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404504AbgKZTjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 14:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgKZTjs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 14:39:48 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87401C0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:39:46 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 64so3301185wra.11
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 11:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6HPcIfmpZ56BBfhqHAlvpEM2EQv3aLLGs9l35o6ja50=;
        b=BGzyBsrDFlmdoHM3qPEOt/YHTMuL8oWK7Bw4lv4rDSzAiE/foQ6/Z6UvJdDhH8xScX
         DsVNLtcsM8je+djQQmaA3eCF6mEtmiC5O46/VCELqop8OMRKQdR4BYcGXEw9nGIcMZsl
         LUm0wGMEwT0fHWbBgEu5YxbAXbUGAJgyWmcLDTunDi/HopgAKBH4qUNiME7fdtVGxk4h
         DQqnRB+ywB0FW7/85raih5W+Uhau7XqvO5R9NvfgHlREZTqx7gN8XW8MgF36959vYR5p
         iUXXTlRfg+Jj9xm5Zz+AG9z8WZYkvKI9YdXhXrvTwz/TkFsjp3MyeEhWBERc8eLFLZJf
         Pn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6HPcIfmpZ56BBfhqHAlvpEM2EQv3aLLGs9l35o6ja50=;
        b=iFJxt5CVSwslz+zvydytgwgLNVY7424nwGR2P+CFVo4j7UJoRSnd6FLZlq8APakvK3
         i/XJl76Kslvl+SDaryxVjohopRGW+n9NOEl+xfP9vseQnO1rp+F4v3BFxEmyhOYhJced
         gsAPe4uIXhHS5AEH3g+bzRGDvlJ2WWZj+aZ+p/BBbbArbRqjFONWWJw1rmI2inc+M+Jg
         R1XcIBACah6xywaLqXbGovrqILUyxeuN6k635nVloGjczDolYJPkEgWyorbOR/0LfoRO
         QDEx8/2SnfRUzGSrAIIFvBAWGnKaqUvIj5+emEd2Z6/r7PP+a6UTbIui/NE60vmGTj+5
         eeBQ==
X-Gm-Message-State: AOAM533icK8jJhfWcVZ51aHk07J+2P4cGdvux57bjm+4pEo2PkLHmIP0
        sxYuew35/vyC4JYrBsjysxBhCxng0jQ=
X-Google-Smtp-Source: ABdhPJwW01xvCxsbvJynKbKXZoQOnUtjcZoTuxjr0lf+DFhpuydrNgAjarMP9oZgdlFRGz80RFuYqg==
X-Received: by 2002:a5d:504f:: with SMTP id h15mr5689573wrt.402.1606419583573;
        Thu, 26 Nov 2020 11:39:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q12sm10291596wrx.86.2020.11.26.11.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 11:39:42 -0800 (PST)
Message-Id: <pull.924.git.git.1606419582190.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Nov 2020 19:39:41 +0000
Subject: [PATCH] init-db: init the_repository->hash_algo early from
 GIT_DEFAULT_HASH
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The reftable backend needs to know the hash algorithm for writing the
initialization hash table.

The initial reftable contains a symref HEAD => "main" (or "master"), which is
agnostic to the size of hash value, but this is an exceptional circumstance, and
the reftable library does not cater for this exception. It insists that all
tables in the stack have a consistent format ID for the hash algorithm.

Call set_repo_hash_algo directly after reading out GIT_DEFAULT_HASH.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    init-db: init the_repository->hash_algo early from GIT_DEFAULT_HASH
    
    The reftable backend needs to know the hash algorithm for writing the
    initialization hash table.
    
    The initial reftable contains a symref HEAD => "main" (or "master"),
    which is agnostic to the size of hash value, but this is an exceptional
    circumstance, and the reftable library does not cater for this
    exception. It insists that all tables in the stack have a consistent
    format ID for the hash algorithm.
    
    Call set_repo_hash_algo directly after reading out GIT_DEFAULT_HASH.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com [hanwen@google.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-924%2Fhanwen%2Fset-hash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-924/hanwen/set-hash-v1
Pull-Request: https://github.com/git/git/pull/924

 builtin/init-db.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 01bc648d41..5c8c67fec6 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -391,6 +391,7 @@ static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
 			die(_("unknown hash algorithm '%s'"), env);
 		repo_fmt->hash_algo = env_algo;
 	}
+	repo_set_hash_algo(the_repository, repo_fmt->hash_algo);
 }
 
 int init_db(const char *git_dir, const char *real_git_dir,

base-commit: faefdd61ec7c7f6f3c8c9907891465ac9a2a1475
-- 
gitgitgadget
