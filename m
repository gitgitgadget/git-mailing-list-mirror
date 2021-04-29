Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A84C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 02:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FEE26143D
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 02:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhD2CgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 22:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbhD2CgA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 22:36:00 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9450CC06138B
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 19:35:11 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id t14so1810484qvl.10
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 19:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ntxK8i/7YjRo91thgPUV9qt+1Gfd0jvhXinOlF4JTbE=;
        b=3E4sGB2JRIGHUw7aBLhce+YD9qYnsmZYnd2MTrGXqmtcF4RkK0FzU+Fs7QeTFSKbHo
         ugoHIYOGtaYdFet0oYmRh9f79OMzHY02T8I/Yf0FnJ3YOrq5/UjvfIkKg01dPBsafxmm
         DG0TkuRS+QM1DlKQ/AZOdIC3MnGEw3cWwzffHVJk8k3ujWaG+l4VlwAPMj/iSunN2cTy
         feCdyQ12NK46NE1fkc/trTTa68T9G5pZRDq7ZNUvEY6o1AMOLCHzoZs7Yi56P+7fe9uw
         Uq1IJDuMHWy4qHWAtwi9Xbut2wlMFtlqLP3x3uwgQZprApZ5kXdcr7/hMM4SDd+oEsCm
         XfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ntxK8i/7YjRo91thgPUV9qt+1Gfd0jvhXinOlF4JTbE=;
        b=XICOmjRnfWmiScNceb1Vgop4cxrTOurQz3zQxGcJy7FmGZhDgHQjeEeTru3rB5ZgJl
         mY49ZBhRUlDXhEEyeCjj+xEQtGCpII7jbJtvWTqgBAQ6NSCBIT+IurCnodOrCcl+R1aZ
         nUPwdZAUfE3UHZWHsfRgcNaK/OH1LZUq7l8jP4I7HeeHVkhswhvJBOjDdhSgayenz9y5
         rJbSWJwoaRJwjv3lMNo98e7voDkbe5bg4EAdco8oM3x1U3iFb1yvJcBmesbZvtLK9NrW
         geJVBVXlnCuGX+Kjeg0Cd1E3p3MHeVpY7eGIWsNx5KaltOK37wpVLfHRGPr6m4Dn6DwX
         otiQ==
X-Gm-Message-State: AOAM532Ru7EwVmcn6N3wCfpXI03iH+7LA6cs0BUpMqADFeRCQUiQo0bh
        q+GBCbpixw8fndgi3x3AMg/dgwwrChsxEPxN
X-Google-Smtp-Source: ABdhPJyt9OJfIwptVi0RjVEqeBpMW7Z9JXUe+er9GRjlVj/CMMqNZ5OK2JCuyMmTwSLB4x3GUhADJw==
X-Received: by 2002:ad4:4f11:: with SMTP id fb17mr248061qvb.18.1619663710585;
        Wed, 28 Apr 2021 19:35:10 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id w5sm1265732qto.97.2021.04.28.19.35.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 19:35:09 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     ross@skydio.com, abe@skydio.com, brian.kubisiak@skydio.com,
        Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V3] git-apply: adjust messages to account for --3way changes
Date:   Wed, 28 Apr 2021 19:35:03 -0700
Message-Id: <20210429023503.29631-1-jerry@skydio.com>
X-Mailer: git-send-email 2.31.1.367.g30381d2e76.dirty
In-Reply-To: <20210427194005.14318-1-jerry@skydio.com>
References: <20210427194005.14318-1-jerry@skydio.com>
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

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
V2->V3 
- Changed "modify prints" to "adjust messages"

 apply.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 5957430433..0ddde5e8a8 100644
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
-- 
2.29.0

