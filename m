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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BF2C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 18:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C6564D9A
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 18:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhA2SWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 13:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbhA2SWo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 13:22:44 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94EAC061756
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 10:22:01 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id s15so5685793plr.9
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 10:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVwqRHiCPVOdFvi8BGeDd6ox9vceEwe8HnBQfQjgJgU=;
        b=iBCDVmzRhN1t5lDHF/IaxbNQ3IQPmKFm8kWqPYJ3U0QLHZpsLsBmTJbJzzQ3n0yk5t
         SdRKjhpUm9nN0mIEqQqnjiBz+8TbBfAjzDwlhWEuRhDM3oa4nLF1gsQj9r2OcRqstzax
         0RG0Lg/NK07lQckFvnJrdlzaF5DceUKvoM/+q/euL1DzSE0C/RdJ4h2eWmSpQh4z+4A4
         ju4FgVs1FlKQMtGK1HwfznS7kV03ZeGhB4Igr/KuGGEpJXgwyXSHFzu19Zrmi38QShK+
         sxfJyqA9pA5zUagX062bUlWkCTGsWSmFc8XePbBxTMinz2PTdIS0bqCCmZg7q/2E9fCd
         7R/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVwqRHiCPVOdFvi8BGeDd6ox9vceEwe8HnBQfQjgJgU=;
        b=EfP589b/1v4tjpCbKL00P/6hqp3fwyQUPSwX3qcRpr7QGDsPdH+ZufLK6q8NgBcGlI
         fqqEL5ZTsVQeevp/gmyJ7yxk+XgQk0uMyhOswVl8ZFBpqSnHahq74VmohIfv5Yp8J46B
         akS4R1V3b1rBQKQVB3dBkd+vyV+VdSLX0WiI2GTNxWaX+mXtlIEZm4webwr89OJOqTLm
         RhZEN+PWTti1fSStSU6VdJiqGP3X8GAdo6O9mrVl+jNpg2A6ZZSvqhaEKc/uY0Pi7s5/
         u6lguNB4rBJvGoP05bW9UAJx7brMu5ja336BpUw5AFE+grXdRq6LewYG2UUHebLa9kTH
         aEPA==
X-Gm-Message-State: AOAM532tIXiaievhVhggb3ps9i772386NwMxEnVuU/nxh0SC52pyObU6
        17IHONqfIui26RPs4J/80byU9Qx+CK0=
X-Google-Smtp-Source: ABdhPJwARJnhbVgS1CUJnLVSJqaQtPCVh+t/0HYiP+br/NhrnOYzQ/2VDKjvir7vFYoi9ORosGwNyQ==
X-Received: by 2002:a17:90b:ed5:: with SMTP id gz21mr5509375pjb.42.1611944521076;
        Fri, 29 Jan 2021 10:22:01 -0800 (PST)
Received: from localhost.localdomain ([2402:8100:396a:4597:fd76:2af1:5584:160e])
        by smtp.googlemail.com with ESMTPSA id x141sm9497834pfc.128.2021.01.29.10.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 10:22:00 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v4 1/9] rebase -i: only write fixup-message when it's needed
Date:   Fri, 29 Jan 2021 23:50:42 +0530
Message-Id: <20210129182050.26143-2-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210129182050.26143-1-charvi077@gmail.com>
References: <20210124170405.30583-1-charvi077@gmail.com>
 <20210129182050.26143-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The file "$GIT_DIR/rebase-merge/fixup-message" is only used for fixup
commands, there's no point in writing it for squash commands as it is
immediately deleted.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reviewed-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8909a46770..a59e0c84af 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1757,11 +1757,10 @@ static int update_squash_messages(struct repository *r,
 			return error(_("could not read HEAD's commit message"));
 
 		find_commit_subject(head_message, &body);
-		if (write_message(body, strlen(body),
-				  rebase_path_fixup_msg(), 0)) {
+		if (command == TODO_FIXUP && write_message(body, strlen(body),
+							rebase_path_fixup_msg(), 0) < 0) {
 			unuse_commit_buffer(head_commit, head_message);
-			return error(_("cannot write '%s'"),
-				     rebase_path_fixup_msg());
+			return error(_("cannot write '%s'"), rebase_path_fixup_msg());
 		}
 
 		strbuf_addf(&buf, "%c ", comment_line_char);
-- 
2.29.0.rc1

