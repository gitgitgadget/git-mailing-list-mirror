Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD78C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 01:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E486260FEA
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 01:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbhD0BOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 21:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhD0BOA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 21:14:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D2FC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 18:13:18 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v20so2655337plo.10
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 18:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5NBXZT/JVogkGpF9twhERAr2t29fMMsX358CFnLgduQ=;
        b=j2aZIpFSJURjNuwAbP9bzkE9WFNGZLJG7Lj97o8m+jDB1rJD+fD/t//GBFhfKs6PYL
         xlFP0KW6pCyvDd9dKl9nSAq6YHdfoQX8XQ11gRrEE4jaTssFMuW3iKRMN5ytjQaUqVhV
         ASNYndcYqYbFNYkz1GwVOGJq5zELgRJ4T4ObolutPPFBk4ef2KYqkAi96MYOF7xQFp3F
         CcniPeMLfEl0nfel7h2wyAgm+CoaEMiLQ/rI75kVaIoUwoXY7JwqVza06A8c/9070YAp
         FHvwlvZQVAcqbo5uvGHzQL8ePwW+fr8vyzeDWX8d8w/DsK+Ni0tqmHMJLvtljc1Ypq1X
         gt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5NBXZT/JVogkGpF9twhERAr2t29fMMsX358CFnLgduQ=;
        b=XHTBwmCjPM0G2dzbNHzU5pZ+bo2oWYKn5znKDL8T8Q7S2KOHebQ8AwnPDrJO1w5k8v
         ++Mo7hpy3Wg6DQKIohRMCzOLzDWpeCyQ/iFYq6OLD1kvrAxqensZann0J1LVj2vFjXO/
         b07ZcdXs+w+apLNs70+OlpwroouZjYv9Skszp4f/5vVV9+lPq/+aXA1HfutigDkjBQaF
         DKm8r4ZhnMmchI7YLDry6uGWUwuyF3bV8QX2GUpu9IWM7HOz6CJkFSNorsO+hIpzIIjb
         99Zp9tqk31kAywxZB6fdrsA7EpbkIWoXbdfiOW/ZzDnUIQT3Qk77bva/iaLKzWlcfIIK
         D8Ww==
X-Gm-Message-State: AOAM533wUkLX292RDLqDaQ2s//8hCnojZfCUE7i78GkafejF6onPyvYQ
        6tdC0D63W//MUxEN1qCkPbbwZ0+Rxh90QnMi
X-Google-Smtp-Source: ABdhPJzhXpk6fU2APVeHRuOSC+CcGhJ3i3s3pXiAGt7KA5u320ORyvDVPweTTl10xEOFWN05FCHLLw==
X-Received: by 2002:a17:90b:1d92:: with SMTP id pf18mr24709176pjb.71.1619485997741;
        Mon, 26 Apr 2021 18:13:17 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id d12sm703766pjj.50.2021.04.26.18.13.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Apr 2021 18:13:17 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     ross@skydio.com, abe@skydio.com, brian.kubisiak@skydio.com,
        Jerry Zhang <jerry@skydio.com>
Subject: [PATCH] git-apply: modify prints to account for --3way changes
Date:   Mon, 26 Apr 2021 18:13:14 -0700
Message-Id: <20210427011314.28156-1-jerry@skydio.com>
X-Mailer: git-send-email 2.31.1.335.g42ef272d81
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git apply" specifically calls out when it
is falling back to 3way merge application.
Since the order changed to preferring 3way
and falling back to direct application,
continue that behavior by printing whenever
3way fails and git has to fall back.

Add a --quiet flag to "git apply" so the user
can turn down the verbosity.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
 apply.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 8532b48e4f..2abf2e8a61 100644
--- a/apply.c
+++ b/apply.c
@@ -3572,7 +3572,7 @@ static int try_threeway(struct apply_state *state,
 		 read_blob_object(&buf, &pre_oid, patch->old_mode))
 		return error(_("repository lacks the necessary blob to perform 3-way merge."));
 
-	if (state->apply_verbosity > verbosity_silent)
+	if (state->apply_verbosity > verbosity_silent && patch->direct_to_threeway)
 		fprintf(stderr, _("Performing three-way merge...\n"));
 
 	img = strbuf_detach(&buf, &len);
@@ -3639,6 +3639,10 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 		return -1;
 
 	if (!state->threeway || try_threeway(state, &image, patch, st, ce) < 0) {
+		if (state->apply_verbosity > verbosity_silent &&
+		    state->threeway && !patch->direct_to_threeway)
+			fprintf(stderr, _("Falling back to direct application...\n"));
+
 		/* Note: with --reject, apply_fragments() returns 0 */
 		if (patch->direct_to_threeway || apply_fragments(state, &image, patch) < 0)
 			return -1;
@@ -5050,6 +5054,8 @@ int apply_parse_options(int argc, const char **argv,
 		OPT_BOOL(0, "allow-overlap", &state->allow_overlap,
 			N_("allow overlapping hunks")),
 		OPT__VERBOSE(&state->apply_verbosity, N_("be verbose")),
+		OPT_SET_INT('q', "quiet", &state->apply_verbosity,
+			N_("be quiet"), -1),
 		OPT_BIT(0, "inaccurate-eof", options,
 			N_("tolerate incorrectly detected missing new-line at the end of file"),
 			APPLY_OPT_INACCURATE_EOF),
-- 
2.29.0

