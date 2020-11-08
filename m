Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB5DC5517A
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3485520657
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdLjFMeZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgKHVl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728970AbgKHVlh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:37 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833E0C0613D4
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:36 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id r17so2194902ljg.5
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0S/9aSkb4vHujavlerag9xYD5gdMVALanWm3rUMyrNY=;
        b=cdLjFMeZKooHvV0LrrGj20z6RZAJAmJJkVXYGjJ/32NfCoPVIQWnxk8mS5397AVyd5
         Eba57LcN5D43QQaB/VJl/B+eqftdncCRZEAPYYCrJGOQCBwufc2GrGS2pSjRX70oalXi
         CRVcX6yJ/0djtXXtMQJx6LGNc5JCcFVIgOcHvzqmrh9Z4r9AC0HR/guf1suwstCkoN9e
         AsfSc6+c0bapkwONoUKdt+Eye3K/TBNqZfOz/IuQGlGW0/Nrt33AtKYqDuH+wekAxgKY
         /vdrubc+4JS/hnl5V6WHmmPzHl1jKer6lnQkvNsO5gxJ6eL1q/lHKvR4K72Tan8WjLOe
         DHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0S/9aSkb4vHujavlerag9xYD5gdMVALanWm3rUMyrNY=;
        b=ZPRFCfUBOcH/vfcCVeN3yR4yMz53z/UtJ6InPL6NFafXXuLbyUs2A9pEvc6OlwZ6+N
         0ZLQD2yIw/9Of0M9pZ1sq61I0vRcjkM9KrobHJZjDp3KcaLx5tm4NRSsR50But588wCJ
         BDV8DMe+J7VyY1HWI0o5dpcqBTCixtTosgN0XoEoMyKzOaDv1Q8JwIY7iPUUHL10d1f6
         qdVAH6NfgeAXmGhCOelFkQiYWf62zBHciVY5XkegkRLqqEzT4HCYHe4IfALQuqhsxLwk
         DvGtX0fdeGaMMJ0zQ0ed/bhWfiDCX9U/o7kZ5SmgbLD+029OGLPE5cgqd1onKtJKwVXp
         oGsw==
X-Gm-Message-State: AOAM530riKHUgw5LiF9nuj0FriL7CL+nV0fLNnBzcEz6/tKsWesYOEbA
        ZWwvHmGywI5IBEw0WmDfd7s=
X-Google-Smtp-Source: ABdhPJwyMrzWKA5a0ojo654u4++sWLCfpN1lkjQp1HVj9WEUM7v5OJJ6oI09aiT4KkMMqOzp2T5vhw==
X-Received: by 2002:a2e:9092:: with SMTP id l18mr4580703ljg.6.1604871695087;
        Sun, 08 Nov 2020 13:41:35 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:34 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 16/27] diff-merges: fix -m to properly override -c/--cc
Date:   Mon,  9 Nov 2020 00:38:27 +0300
Message-Id: <20201108213838.4880-17-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Logically, -m, -c, --cc specify 3 different formats for representing
merge commits, yet -m doesn't in fact override -c or --cc, that makes
no sense.

Fix -m to properly override -c/--cc, and change the tests accordingly.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c           | 1 +
 t/t4013-diff-various.sh | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index a30c730a457f..f2b9ed789ca8 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -29,6 +29,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv) {
 	const char *arg = argv[0];
 
 	if (!strcmp(arg, "-m")) {
+		suppress(revs);
 		/*
 		 * To "diff-index", "-m" means "match missing", and to the "log"
 		 * family of commands, it means "show full diff for merges". Set
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 64d9fce44614..8d8178a8a616 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -329,8 +329,8 @@ log --first-parent --diff-merges=off -p master
 log -p --first-parent master
 log -m -p --first-parent master
 log -m -p master
-:failure log --cc -m -p master
-:failure log -c -m -p master
+log --cc -m -p master
+log -c -m -p master
 log -SF master
 log -S F master
 log -SF -p master
-- 
2.25.1

