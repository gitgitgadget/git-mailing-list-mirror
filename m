Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E44FC43460
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 19:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6815361404
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 19:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238737AbhD0TlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 15:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbhD0Tk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 15:40:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D67C06175F
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 12:40:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id lr7so13350025pjb.2
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 12:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RS+T9Ti3oNpgl+9G7z4k34L94VSH75MU3b62Uox7hbk=;
        b=y/xHHXvGKFvn76WGMjeSconuetbX10731j0Wa8tSOLHzLEfsr3D6nW1nFuocSwuClZ
         HRIKESpdvNwJ0Xk3jm9uvfglanz0FnCWbhRh2hDQaXOU4VNuzdCWS6OHI7fDDIwQf+16
         sxk3N0PyT8c6qZ923faDt2bj1tkjS+ShyuAHbkABmCy2f1oekOaHe9orCch+De/UU6jT
         z6XYfQfO5D7vhYV08T0Sbe8t6F3BSEDl4ZHg8SwxpN/KYFMyrHp8e/EeWhRh0GSFDLfR
         BS67E0kpSKvZkCZekUAmlg8yEXAQ7ZvyuGVOmmqMqEQLBPIAReAKz/pirSkmPtR1x3t7
         4doA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RS+T9Ti3oNpgl+9G7z4k34L94VSH75MU3b62Uox7hbk=;
        b=X5jsxT4ix7wAiBUyzdiiFq1XVvO9j6k3hiPDIvZNRaq4HHu1TfgEybdw0EEsJD6hyV
         Cvp416leDrlgv4AqeOsIRZZIvuA/HRKoKEeAxKGgFEYl4U+kkFNS4K5/lBwYCoaE/Xt/
         hDO1W0eZmG+VJpNyBcgUuXHB/6RgpKT9xWmipqPgyFQ5GJcqg1XHOS2pIdQBWP2JKIkE
         +uVs/VPrwFBDBXQRsOajtbVHN2BwmryGAp9Kg7EJLDu19mGvmi2NMukUdT5DYTqpZ/iL
         ttkxgfexZ/lshrvsp2zS4AY9PBTfEoR8At+nn37yJMLuGHqOO4nQ2ss7twXqEFfMq9T6
         aJJg==
X-Gm-Message-State: AOAM532lh/MK+H0Yv1J/rU9jthtKrYZQkfGNojasCgAx7glzPNzLYFcV
        6isUiQ+TmmyGxtQckiDyuE2/aUSCd4FTERU5
X-Google-Smtp-Source: ABdhPJyp/dm6j5OXfSWvt+CuqvoURFfn4+Qs/YPJe1UTvsCuOaRoaTJUK9VK2vdixrRk3ODRhnUeyw==
X-Received: by 2002:a17:902:ec8d:b029:ec:f9e1:7b70 with SMTP id x13-20020a170902ec8db02900ecf9e17b70mr18540904plg.79.1619552413613;
        Tue, 27 Apr 2021 12:40:13 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id s70sm3386124pfs.148.2021.04.27.12.40.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Apr 2021 12:40:12 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     ross@skydio.com, abe@skydio.com, brian.kubisiak@skydio.com,
        Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V2] git-apply: modify prints to account for --3way changes
Date:   Tue, 27 Apr 2021 12:40:05 -0700
Message-Id: <20210427194005.14318-1-jerry@skydio.com>
X-Mailer: git-send-email 2.31.1.367.g30381d2e76
In-Reply-To: <20210427011314.28156-1-jerry@skydio.com>
References: <20210427011314.28156-1-jerry@skydio.com>
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
V1 -> V2:
- Moved --quiet flag to separate patch

 apply.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index a36d4002ca..7aa49e2048 100644
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

