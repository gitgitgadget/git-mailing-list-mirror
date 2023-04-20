Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FABC77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 07:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjDTHq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 03:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjDTHq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 03:46:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E764215
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 00:46:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b5c48ea09so667789b3a.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 00:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681976815; x=1684568815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwK+2OtvyfsBFs+fYfUATsHibGl1B1RrUQDaMA5PEoQ=;
        b=PD7ldUZmukjJCrmauVtt6RDoi/pUco/DcNq0bStX6b50F7kYAZvfMDpylW+crWay/e
         nPzAweefAiDa0jn4KA3hfn1bM/NAjj3N4oRKq63UnoeuS4lm4Iy+z+aBFHNk4tADU5qk
         57R8hwIYedzQPSM9dJvvvq3HPs1cdZamolHn1roFWGhC+lQxRp4ZaN4UbuzGQJ6AAeFd
         cvdbGIzeNPR6pS8hQ4lSrqfuuDANNX1Q6DMNMQifmC044wSrUKPOpP95IPcHQYH9W8o7
         7hEmgKuR/4Ie0aJcQQ3zNGEDq11zgudwDe0hOL8xP9IK07N/k9AbWUOMcUP1fWX30z8U
         xReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681976815; x=1684568815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwK+2OtvyfsBFs+fYfUATsHibGl1B1RrUQDaMA5PEoQ=;
        b=Pd9j8cFdYt+6PijwXDCvoOGw4MsEOqbLYksKESeLxubcJnW5c73VYXUEPzt5utepKx
         7wNDXW5pzjUCoZpyQVKFBVe9+YrfIU6TwJT5ak7p4itVM5BMJlIEw9nbyb1EsdxdpEzL
         hM3gyIONaznfiVgQKjEuXZasff527iTFkOjMY2W3UIF2sCJgTCOtv1U8F6R/k6nRWfrT
         EPAaSpqz32CPt4xW1Rpuy+JMPDt9piAu/OjfybYlJY5qx27VTVebkKAbYZK/+fCrCkTQ
         9g2nsMx51K+YwbMdp4GF0Db3E202ryZjy1Fbo/EGuWi9uudQLfN6dPQU8D//mu00he0Y
         6gag==
X-Gm-Message-State: AAQBX9cLXkOzFG5yKwhGXEOqJAEzZKipWfvVejDvmC2oipg2W5DMUMBW
        ijJbxh8V/ijgVSkm8VoKzyZbZThqItJ96Q==
X-Google-Smtp-Source: AKy350YplbgvY5nKh0+wrsCdDdry635+LsevcnceqpO9Vu45x1HRVouSHvuLe21RdJbULTTYAfDVDA==
X-Received: by 2002:a05:6a00:2406:b0:63b:88f0:15eb with SMTP id z6-20020a056a00240600b0063b88f015ebmr353132pfh.12.1681976814907;
        Thu, 20 Apr 2023 00:46:54 -0700 (PDT)
Received: from chatoyancy.. (fpa0565fa6.aicf508.ap.nuro.jp. [160.86.95.166])
        by smtp.gmail.com with ESMTPSA id h133-20020a62838b000000b0063b8a30b571sm642353pfe.9.2023.04.20.00.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:46:54 -0700 (PDT)
From:   Koichi Murase <myoga.murase@gmail.com>
To:     git@vger.kernel.org
Cc:     Justin Donnelly <justinrdonnelly@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Edwin Kofler <edwin@kofler.dev>,
        Koichi Murase <myoga.murase@gmail.com>
Subject: [PATCH 2/2] completion: suppress unwanted unescaping of `read`
Date:   Thu, 20 Apr 2023 16:46:16 +0900
Message-Id: <20230420074616.1642742-2-myoga.murase@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230420074616.1642742-1-myoga.murase@gmail.com>
References: <20230420074616.1642742-1-myoga.murase@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Edwin Kofler <edwin@kofler.dev>

The function `__git_eread`, that reads the first line from the file,
calls the `read` builtin without passing the flag option `-r`.  When
the `read` builtin is called without the flag `-r`, it processes the
backslash escaping in the text that it reads.  We usually do not want
to process backslashes of the input but want to read the raw contents.

To make it read the first line as is, pass the flag `-r` to the `read`
builtin in the function `__git_eread`.

Signed-off-by: Edwin Kofler <edwin@kofler.dev>
Signed-off-by: Koichi Murase <myoga.murase@gmail.com>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 9c10690a22..49dd69bb84 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -298,7 +298,7 @@ __git_ps1_colorize_gitstring ()
 # variable, in that order.
 __git_eread ()
 {
-	test -r "$1" && IFS=$'\r\n' read "$2" <"$1"
+	test -r "$1" && IFS=$'\r\n' read -r "$2" <"$1"
 }
 
 # see if a cherry-pick or revert is in progress, if the user has committed a
-- 
2.39.0

