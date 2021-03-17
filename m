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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A25FC432C3
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6363564F41
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbhCQU5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbhCQU4x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:56:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3333BC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 12so2263869wmf.5
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9nBhdMnMx90NS2yCmFKdRq6fJkj+C8f4Hncb2AOPyb4=;
        b=gIL8nBw88virZU+uoquqb78JdWMLzBvcQYHiFTouh/h5uZXt/+hOYYNut8vAGzGuuo
         +7m+43RRwwfD96BBsf4ESKIk+zfTDKJ1RwPnkfvH85ip5hHnQO5pGDqm+fyCIlVTg5a3
         x/vttCBv+2jh/Q2OGGRqnVy8MpFjyqNOIiN7CORNydOTzwwVl/M4j7i0e4yywrZpv+/3
         K2DCCvvRWC0BCQ2TaIHg34obvovsoQR+B5CP+soCRWKkJTFcGdruo85qZ02wthgF5Rvt
         ll0Q05LbGem0gv338tcu2s3MqvOqbnFmzyPOvt2cr9qxVIDM39lz4MLRiIKVwrChaGoD
         AF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9nBhdMnMx90NS2yCmFKdRq6fJkj+C8f4Hncb2AOPyb4=;
        b=YR8lU/G2iLRfLEo7QjPewWRCihJOlDEeYalMN7z7I2fzHEs7H2Ox5GjBnwyexEFnMh
         CspryLTXe7wsgDPK98/7/g3A7Zc7F97MT61DnSA2InKxekfw94YSjkJ98Dk3rDPtamba
         jIA0tuNy4Un9c6UqAFNhg2pQn5XIWBLtz11V8zmA0uKilFTuUi+C+kD+HfvcfqdFUVXl
         an1CZpfhiilVpWLzaCihkawoBWEccG7oLnIeN+JqoNpI6db9G9YEIu1ZU4Z5YQN1LrUn
         u8Zn8uniUguNUq3BkO5hZtJH9L/jrIiassgnSt1aPkaZbdeZ2K56ZVlDtmW3OXL8FZ3e
         9VYw==
X-Gm-Message-State: AOAM530s59+dBafzRT0ESlkv/CHNmz4FGjwmedTYf7Blk4eAZTJfifpQ
        D1IHPMJ2ufymbgKGt19yPZ5ocFnNAjA=
X-Google-Smtp-Source: ABdhPJzWhh1kDsk6gqvjKXK7N9g5anoCgEiGLUPM17rbJUiS3gSvAfMluDkk83cR6DNBiAWrbXiCoQ==
X-Received: by 2002:a7b:cd8f:: with SMTP id y15mr555561wmj.185.1616014612048;
        Wed, 17 Mar 2021 13:56:52 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-299-135.w86-199.abo.wanadoo.fr. [86.199.82.135])
        by smtp.googlemail.com with ESMTPSA id g5sm158452wrq.30.2021.03.17.13.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:56:51 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 12/15] merge: use the "resolve" strategy without forking
Date:   Wed, 17 Mar 2021 21:49:36 +0100
Message-Id: <20210317204939.17890-13-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317204939.17890-1-alban.gruin@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches `git merge' to invoke the "resolve" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index eb00b273e6..87921497a2 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -43,6 +43,7 @@
 #include "commit-reach.h"
 #include "wt-status.h"
 #include "commit-graph.h"
+#include "merge-strategies.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -755,6 +756,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 			die(_("unable to write %s"), get_index_file());
 		return clean ? 0 : 1;
+	} else if (!strcmp(strategy, "resolve")) {
+		return merge_strategies_resolve(the_repository, common,
+						head_arg, remoteheads);
 	} else {
 		return try_merge_command(the_repository,
 					 strategy, xopts_nr, xopts,
-- 
2.31.0

