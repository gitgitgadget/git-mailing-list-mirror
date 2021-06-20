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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA25C49361
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 20:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E1D6117A
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 20:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFTUFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 16:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhFTUFi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 16:05:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2DCC061756
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 13:03:25 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id my49so25013877ejc.7
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 13:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TVQKpEy7YU/crI5VPBIQ+jzXBNzXHAO7dKtUvqrXmfI=;
        b=MZ4/F6Ut6IUpkT9vBodREAz9IbqiRRoRt/3bu1stY98oGVH9/LCWjhvNWBsBoecnlf
         p8wCobBrLZVRr3YAUgP0u8kTsr7ZRcOPnySTDL33+DL4ZLM4vISp9lqC0IJTba1fcljv
         4BXCbQZsFvTnDnuncYoD4YhwVVd8+PBQq7breQ1bsKCmCt4fINQtqnHMxwDtSTVAUd/Y
         ptrr6fcw/6ZW6ifBPCK+RUpF0Yr3Cme9fDxQOC4mS7AsxKtZ3bJ9c+WyDtmBSQQTWgzs
         e+DtDN3qTQ81KC08pW1HYKD4g6TEK6QMtTxqifgzBUh2RFQyfrWt2ZUYTeJDaaPtPCVH
         xwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TVQKpEy7YU/crI5VPBIQ+jzXBNzXHAO7dKtUvqrXmfI=;
        b=bTH7gxI7fPMiX6IPUFPUxtC4lwAdX4nFtubSxxaisIcUeDSbiIId9sItjEBcpLHWEl
         Cm7qQLIOSuWDXY9XREPqPQNT9HlzNl5fCThKVc9oJa3niAcbVE92X8W8StDC6yhPbZXu
         0KIxH49lULrNXlhQl90hUmrwlZFsE/Xz89pLHRW7eS40H1rcbkhEThodFLWz0G9LXe5j
         eB9F2Ig6rvbriScO81ctso75eSq9lIPK++LxdbgZA6Hh+TU98xPzMSysNkKv0WSwCMy2
         iMI9Ueh0vTz5DtazqDA/wF9PQ803G42g2ywsUIvFCFfGGaW7sRRRce1y35GQ4Kl1nWkw
         87Mw==
X-Gm-Message-State: AOAM531m2PGdOQmjTFF5iI2u6WAAV4vDwTViGZ1LumGdy4Z7w4rGLFhR
        JxaDX6K9D+0pPvt8nRi/kKGOldYbHR0=
X-Google-Smtp-Source: ABdhPJy/TjtDDMoV03IA39rdTReoNFN+EswF7r3VfiCfjDVeCgHa50btzqKY4seAHbNFBmCCsCNHrw==
X-Received: by 2002:a17:906:e88:: with SMTP id p8mr21108783ejf.105.1624219402910;
        Sun, 20 Jun 2021 13:03:22 -0700 (PDT)
Received: from localhost.localdomain (94-21-23-215.pool.digikabel.hu. [94.21.23.215])
        by smtp.gmail.com with ESMTPSA id cw10sm3893904ejb.62.2021.06.20.13.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 13:03:22 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 6/7] [RFC] entry: don't show "Filtering content: ... done." line in case of errors
Date:   Sun, 20 Jun 2021 22:03:02 +0200
Message-Id: <20210620200303.2328957-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.32.0.289.g44fbea0957
In-Reply-To: <20210620200303.2328957-1-szeder.dev@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test 'missing file in delayed checkout' in 't0021-conversion.sh'
fails when run with GIT_TEST_CHECK_PROGRESS=1, because the final value
of the "Filtering content" progress counter doesn't match the expected
total, triggering BUG().  This is not caused by a bug in how we count
progress, but because the test involves a purposefully buggy filter
process that doesn't process any paths, so the progress counter
doesn't have a chance to reach the expected total.

Arguably, it is wrong to show "done" at the end of the progress
line when not all work was done.

So let's check whether there were any errors while processing or that
there are still unprocessed paths at the end (which a few lines later
will in fact be considered as error) and don't show the final "done"
line, i.e. don't call stop_progress(), if there were any.  And if we
don't call stop_progress(), then we won't verify that the progress
counter matches the expected total, won't trigger BUG() on mismatch,
and t0021 will succeed even with GIT_TEST_CHECK_PROGRESS=1.

After this change the test suite passes with
GIT_TEST_CHECK_PROGRESS=1.

RFC!!  Alas, not calling stop_progress() on error has drawbacks:

  - All memory allocated for the progress bar is leaked.
  - This progress line remains "active", in the sense that if we were
    to start a new progress later in the same git process, then with
    GIT_TEST_CHECK_PROGRESS it would trigger the other BUG() catching
    nested/overlapping progresses.

Do we care?!  TBH I don't :)
Anyway, if we do, then we might need some sort of an abort_progress()
function...

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 entry.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/entry.c b/entry.c
index bc4b8fcc98..38baefe22a 100644
--- a/entry.c
+++ b/entry.c
@@ -232,7 +232,8 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
 		}
 		string_list_remove_empty_items(&dco->filters, 0);
 	}
-	stop_progress(&progress);
+	if (!errs && !dco->paths.nr)
+		stop_progress(&progress);
 	string_list_clear(&dco->filters, 0);
 
 	/* At this point we should not have any delayed paths anymore. */
-- 
2.32.0.289.g44fbea0957

