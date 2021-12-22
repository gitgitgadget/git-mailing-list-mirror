Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C929C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 00:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhLVALx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 19:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238309AbhLVALu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 19:11:50 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4D6C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 16:11:50 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id e10-20020a17090301ca00b001491f26bcd4so55106plh.23
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 16:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wX1jQrxCOlbCTcPN51LfEt4goIZ/oVCB2kXtWmDLtFY=;
        b=C77It54n62Ek9DuMt/Bu0UMZCNAy0izoZdtDhbNAk4yy4ToQpJ/fMiBoeAO1m1QvS3
         upR9MSbP2Jwc2q2YStSbEIstUl+2CbORbWeu4wnLsMYyaY6IdhQ8z/sbW2RG9skbPALD
         iZXes7AQQmLhlC3NyMRoF4ZzId5eKjhEWYfW2PwUTshtV1mHUGvRD8k7RZMAOEaN9LsP
         Z5idBTOkrVsFnJmF1umy4ajcnr3+5EwAEKbmrQW1CAeHvezSfBow+MHsYnsRY7yk5EPk
         2ATZ1nwrbtVgcK1LVNabG+J5bhNwfJiB3IfYDl6tHwOVn9oKUyDZ/fz6duqVHDX/QEHR
         MsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wX1jQrxCOlbCTcPN51LfEt4goIZ/oVCB2kXtWmDLtFY=;
        b=BuG8gdTX+C1r67SSk3R1ObBSV4KE1B/cDg0r7GfRuPyA+tn7cDZ5KjXl6dNL1iiHt6
         hTver/EJpqis1IhjLBlS+Wft84q1XEa+vFSqtoWslSWJMj7MX69l4nBw3Fd9QuvO4q91
         bFzBmrojJjB5p7LW3w1Tm1zCMUuzP4rc1GLKIwfYOIa42RCXpzfZqgT4hBfptyPeDHab
         qMxDDuIwJxRHpxTGWQdxFSpvuHHYYr+0LQo2tJwGU0pxLPURJi86r2ZOzI6K9SKY5X6l
         Z1lbKssPFaQiZs1f9oJW4cLpoTwBoSngUEDY4B4F6RJFQdwOc7ClU8t7HYrqH+ejr2uO
         Cfdg==
X-Gm-Message-State: AOAM532bkpeIGdfXQIVH0NQhOCxJ2jhQHXlSfL3+Pb4MWjMoiN9ljdLg
        jvFWh0OmMPcHz7qyGdAP6z7xSj+uxSu7HaDGc2HItmSeLAwEytetk0qCZOGcPAE7mvoL2FuY0py
        SbZqYPOzdREh7L+Q1gc2nwUouaAn5a4cPBgobmd3UiemSQuA2yu7hwEKu9y3ofZE=
X-Google-Smtp-Source: ABdhPJzjSeOvaVx8zqQ6RFsjTmItkOIiZ8+qALQRvSWp6KDesx+LtMwafD0+T65mLJtq3DIJnTaOXwW/+46X5A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:c215:b0:148:af14:6e96 with SMTP
 id 21-20020a170902c21500b00148af146e96mr491053pll.80.1640131909965; Tue, 21
 Dec 2021 16:11:49 -0800 (PST)
Date:   Tue, 21 Dec 2021 16:11:32 -0800
In-Reply-To: <20211222001134.28933-1-chooglen@google.com>
Message-Id: <20211222001134.28933-2-chooglen@google.com>
Mime-Version: 1.0
References: <20211217000235.68996-1-chooglen@google.com> <20211222001134.28933-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v3 1/3] builtin/fetch: use goto cleanup in cmd_fetch()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace an early return with 'goto cleanup' in cmd_fetch() so that the
string_list is always cleared.

The string_list_clear() call is purely cleanup; the string_list was not
reused.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/fetch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f7abbc31ff..eab73d7417 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2076,7 +2076,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			gtransport->smart_options->acked_commits = &acked_commits;
 		} else {
 			warning(_("Protocol does not support --negotiate-only, exiting."));
-			return 1;
+			result = 1;
+			goto cleanup;
 		}
 		if (server_options.nr)
 			gtransport->server_options = &server_options;
@@ -2132,8 +2133,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		strvec_clear(&options);
 	}
 
-	string_list_clear(&list, 0);
-
 	prepare_repo_settings(the_repository);
 	if (fetch_write_commit_graph > 0 ||
 	    (fetch_write_commit_graph < 0 &&
@@ -2151,5 +2150,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (enable_auto_gc)
 		run_auto_maintenance(verbosity < 0);
 
+ cleanup:
+	string_list_clear(&list, 0);
 	return result;
 }
-- 
2.33.GIT

