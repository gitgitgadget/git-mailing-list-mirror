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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595FEC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FBB261B62
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhHPJUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 05:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbhHPJUS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 05:20:18 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B010C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:19:47 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id l36-20020a0568302b24b0290517526ce5e3so12690088otv.11
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7jXTxoocXxqEq7GOIGSVO1s2DULJZUQNkvkwgftjHu4=;
        b=ryDVF6Wg2HJIdrJbuxbzrpY1vrrLM+rwBu/gcUQ4ewT3M2yBMkXmeqGisKMVj6A/GH
         qohqYD7e3NzKQ+pk7BhPEPgA5f0UN0UnvyLXuCVoaJcqlenBvZHPy6WK2ezfISiaPFlE
         YDeYMB29jYvTvzhmzHAlgvXi7YeOGWNxU9AnEe73I7SC4+y2cVsXF4F+ORU6c5ltUrFY
         rs83z6KbbGRdTEI3LPsmktHXKCsxwilTSGNIkQVjANHBt3zz/uJ9cmBi6EPmX/B4IbQ1
         N3Bpj7IRpZl5APRHtcFAfpKm7rqdA4v89cNn+997YSaL5StSU7kMMI4Z/sVZG2F3LIM+
         xfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7jXTxoocXxqEq7GOIGSVO1s2DULJZUQNkvkwgftjHu4=;
        b=OPIfm0Yh06k5hUbPojcc3fNkYu69d+kbDlD4qf607VIhfDFn5cQ+p7LaieVDNDePj8
         SIooe0Fibpnvom/D5XwcwLqMgdOosmqRforgrNMdo5piVQ07DnLB7R0kZ3NeDjF71Zbv
         x6k832Hkrd0TzemhrIanGebpD8x387KBBN7aYUP4lIRH2E4+QmfO7xIB8sdTxWjNrheP
         8OjrIjeZ9voxXNTvzYyKCd5ZIlf03ClObF2XrpjIDpCV3wBQCo3fjlnW9tTyP94lR0YY
         k1LrupZ44fJY5Jqy5c4zwsXkpT8VOKIa4QQWhIsPDGCbWBZp2IVls1ZNpC0k+FiEZNS+
         MBFA==
X-Gm-Message-State: AOAM531SRHOE3AVUVxJ2Unjc+cX/BYSxZkpemvAmFpisxjvTwCrcU+kT
        MzLhLfgg/qNBW7Gjz7FLZOUgPyZuS3M=
X-Google-Smtp-Source: ABdhPJw8QFwtzWr9GyqZpr4Dswx9X04pXlivCSYH3H8ufFqQf6wLwMXJMr/vOBljBFy5erNVCE3COw==
X-Received: by 2002:a05:6830:411a:: with SMTP id w26mr7568013ott.127.1629105586376;
        Mon, 16 Aug 2021 02:19:46 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id d11sm1846671ooh.8.2021.08.16.02.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 02:19:45 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: fix __git_cmd_idx regression for zsh
Date:   Mon, 16 Aug 2021 04:19:35 -0500
Message-Id: <20210816091935.548555-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.48.g096519100f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit 59d85a2a05 (git-completion.bash: use $__git_cmd_idx in more
places, 2021-04-22) caused a regression when using __git_complete and a
command relies on __git_cmd_idx. This was fixed in cea232194d
(completion: bash: fix late declaration of __git_cmd_idx, 2021-06-18)
but only for bash.

We need the function wrapper (__git_func_wrap in bash and _git in zsh)
to define __git_cmd_idx.

Otherwise the equivalent of __git_complete in zsh fails:

  compdef _git ga=git_add
  ga <tab>
  ga __git_find_on_cmdline:[:14: unknown condition: -lt

Reported-by: Harrison McCullough <mccullough.harrison@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

I had already sent the correct fix [1], but Junio decided to pick
somebody else's patch, therefore the regression is still present for
zsh.

[1] https://lore.kernel.org/git/20210618185832.700477-1-felipe.contreras@gmail.com/

 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index cac6f61881..a1f2d27817 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -271,7 +271,7 @@ __git_zsh_main ()
 _git ()
 {
 	local _ret=1
-	local cur cword prev
+	local cur cword prev __git_cmd_idx=0
 
 	cur=${words[CURRENT]}
 	prev=${words[CURRENT-1]}
-- 
2.32.0.48.g096519100f

