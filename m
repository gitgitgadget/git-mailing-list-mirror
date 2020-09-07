Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861CEC433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 15:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4663E217BA
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 15:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUEB+kXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbgIGPH0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730056AbgIGPEG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 11:04:06 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDEDC061573
        for <git@vger.kernel.org>; Mon,  7 Sep 2020 08:04:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so16183436wrv.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2020 08:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=e+vs/mZWaSzb7y+phDgQ8niC6aslfNUt86upjnV1LOw=;
        b=nUEB+kXNEv6K6seMiXx6djX6mvBA7pqIwdiyxUBza3mD6EF3CwyE869OpiEHljOQsl
         wKWT457DRoePhQ90TKtxjljWy1mE8shGx9t93ehWvqkrChND9uWieN63q2owA9YxeWtJ
         bJn8NsTNpkbfFu1mMPuLc1kMDAAuoTAMbTzBYynoXbfKQDm6KVe9IMfHu7Qh35M3H3ep
         eVHZsX/Wul/ZxZ+nK4Homx3Rn0X3HfBFuOrq/0tsUR8Y0RYjuGz2H5B+qJhH2A3suVI7
         szKS4PYy+3ulKFzQeObgauoAoah4f/yJ4piYfMYHI2ubPa+1qOvuhaa5U/SiK+JSGFWA
         9u0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e+vs/mZWaSzb7y+phDgQ8niC6aslfNUt86upjnV1LOw=;
        b=EmvxG9oynLdvfOUFy2Ed1x/td2bq9lXTS+b1u/M6YqANgp2kfRXxRoHQEwzKNoHCux
         QR+WMZ34WGBQOFBmkY+Pn4pqdap9INl4/sEJ37lwuY5CdzwQoUBgYwfuPoO0NoJSzoE6
         fRR39eF3GwrsQ9bWzzEK6KosNAa/xS8fES3DkgZy3ULbOcxgFxX8QH6CrI/5qfmKqZ5f
         g6LEy2YCYGMfPFOMS4rRo2pT1tphfi3GB80+72LqApbeDsTgtRuEdi3aJ7Utp5yJ1xa8
         OwYecGCTzTYdEb+vmnyvOg4YfwD+P1HRowVgCJZXoxZnrX7MlRI70Vvb6AMEB096vh0J
         BRoQ==
X-Gm-Message-State: AOAM533X/2eVuo00bVbdii7fCubrGTguGjyaWL5BfzkNVya+JtK+23IL
        hJOB2bAHZSWb5a2hYMret1125Wm2OC8=
X-Google-Smtp-Source: ABdhPJwRVnzmmmNJmWxWbIRfWva4Ief2fFOPnXs9bygRTsd3RAQyb02/H3e6isOxMWHbwDG9cg5gEw==
X-Received: by 2002:a5d:5111:: with SMTP id s17mr21888146wrt.70.1599491042573;
        Mon, 07 Sep 2020 08:04:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm29094631wrp.85.2020.09.07.08.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 08:04:02 -0700 (PDT)
Message-Id: <pull.729.git.1599491041170.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Sep 2020 15:04:00 +0000
Subject: [PATCH] add -p: fix memory leak
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

asan reports that the C version of `add -p` is not freeing all the
memory it allocates. Fix this by introducing a function to clear
`struct add_p_state` and use it instead of freeing individual members.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    add -p: fix memory leak
    
    It seems to be the season for add -p fixes. This patch fixes a memory
    leak in the C version found with asan.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-729%2Fphillipwood%2Fwip%2Fadd-p-fix-memory-leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-729/phillipwood/wip/add-p-fix-memory-leak-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/729

 add-patch.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 457b8c550e..2fcab983a6 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -266,6 +266,20 @@ struct add_p_state {
 	const char *revision;
 };
 
+static void add_p_state_clear(struct add_p_state *s)
+{
+	size_t i;
+
+	strbuf_release(&s->answer);
+	strbuf_release(&s->buf);
+	strbuf_release(&s->plain);
+	strbuf_release(&s->colored);
+	for (i = 0; i < s->file_diff_nr; i++)
+		free(s->file_diff[i].hunk);
+	free(s->file_diff);
+	clear_add_i_state(&s->s);
+}
+
 static void err(struct add_p_state *s, const char *fmt, ...)
 {
 	va_list args;
@@ -1690,9 +1704,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	     repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
 					  NULL, NULL, NULL) < 0) ||
 	    parse_diff(&s, ps) < 0) {
-		strbuf_release(&s.plain);
-		strbuf_release(&s.colored);
-		clear_add_i_state(&s.s);
+		add_p_state_clear(&s);
 		return -1;
 	}
 
@@ -1707,10 +1719,6 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	else if (binary_count == s.file_diff_nr)
 		fprintf(stderr, _("Only binary files changed.\n"));
 
-	strbuf_release(&s.answer);
-	strbuf_release(&s.buf);
-	strbuf_release(&s.plain);
-	strbuf_release(&s.colored);
-	clear_add_i_state(&s.s);
+	add_p_state_clear(&s);
 	return 0;
 }

base-commit: 3a238e539bcdfe3f9eb5010fd218640c1b499f7a
-- 
gitgitgadget
