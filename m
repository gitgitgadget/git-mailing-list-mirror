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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C4FC4338F
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 03:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08BD160FD8
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 03:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhHHDmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 23:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhHHDmm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 23:42:42 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D00FC061760
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 20:42:24 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id t68so14639318qkf.8
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 20:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GwL+rAjPgJyEXD1AwZCjdppkaitfOhHjUClkn98680c=;
        b=Z9rf/MglpJI4wjoKxpiB2d8wrf9jaP6J/CKq5ZiWZ7JEaBw1o3tgBzr0kW/Z5e1jNO
         SOMkbcqJCPVgYg1KQITLm4Ap+WQUMem4rKbmm0pUROfmOef/F9zk2MStY6TAjtzl0Pua
         sCg3GC5AsQlnky2dYwLjj301FTDFs6M/i0YEteTNYHsGwzn020jJaR5xUk+P3yJ/itvc
         H6adkW9opGIxPwmbTJeGIa68qTIIdr2VQ/NPgK6ZFWKJbjN+/2HSAbNbhqgYr091lv5o
         StiWQo3BkT165dD+ACzoFd+rOIS4meayk97tMuoQavZjM7BfhaLYcQ3kMr7pdqPSMoRV
         ujhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GwL+rAjPgJyEXD1AwZCjdppkaitfOhHjUClkn98680c=;
        b=ZRfuXw5fLiYhZ9NlDfDCG3n5FG9apDcyd1UfCBd3IHEr04MGKEsQWO6uqzSqcwYiwE
         wocUz8lZBuOEcxYBL5Em3ugaX48Ul/hQ5qOYXtmuRbKCUaaXjVULwHrJOnMieeZ8+L2g
         9nEBsnjeqb3cL+ldbYWAylOWbBciz6r+vNFGqkJ0l03Us5JoN0UO7gZEp9+FBgT+7OF2
         QmROZRoub/o3fPEhAzG5NQ8LFGQTY+HjyfgBl5NbRP9mutuYLA3TEqK21j/E9pGk6U/s
         oUb+eeBtScsKTjh0w428pmRMHzJe61jDsKj1iQBXpgKs091jdkHID0ge+We/II6S/LhB
         JgOA==
X-Gm-Message-State: AOAM530hRR2HZgVupPSQELwiu6pzhyqP3fqGicYpjtvvjkf2nvMygkPW
        XUYfpsc43HTEywqnu7yZTi5UsT1U8+8=
X-Google-Smtp-Source: ABdhPJyDYhY8z18KTEDrWGLb8SOJ9qVZVJNf04vxXNtkipjhu+hlVVolhnym+eKlspnYk9E+zzgE6Q==
X-Received: by 2002:ae9:e008:: with SMTP id m8mr17509616qkk.374.1628394143315;
        Sat, 07 Aug 2021 20:42:23 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id h207sm4937599qke.66.2021.08.07.20.42.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Aug 2021 20:42:22 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     liu.denton@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] builtin/merge: avoid -Wformat-extra-args from ancient Xcode
Date:   Sat,  7 Aug 2021 20:38:34 -0700
Message-Id: <20210808033834.74470-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.373.gc715f1a457
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

d540b70c85 (merge: cleanup messages like commit, 2019-04-17) adds
a way to change part of the helper text using a single call to
strbuf_add_commented_addf but with two formats with varying number
of parameters.

this trigger a warning in old versions of Xcode (ex 8.0), so use
instead two independent calls with a matching number of parameters

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/merge.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index eddb8ae70d..9f160f7eb9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -861,9 +861,11 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 			strbuf_commented_addf(&msg, "\n");
 		}
 		strbuf_commented_addf(&msg, _(merge_editor_comment));
-		strbuf_commented_addf(&msg, _(cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS ?
-			scissors_editor_comment :
-			no_scissors_editor_comment), comment_line_char);
+		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
+			strbuf_commented_addf(&msg, _(scissors_editor_comment));
+		else
+			strbuf_commented_addf(&msg,
+				_(no_scissors_editor_comment), comment_line_char);
 	}
 	if (signoff)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
-- 
2.33.0.rc1.373.gc715f1a457

