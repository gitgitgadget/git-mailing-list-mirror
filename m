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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63326C4361B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A47364F53
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhCQU5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhCQU45 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:56:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B93C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j7so3251789wrd.1
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lT8hXgZ5oebKH8BXVU3lNXvwD2G+uha/MKyygB+peL8=;
        b=M5UTNWNkO2xEqZx0wRK5H64kDDLQr1AOj349lyHXa0YLEOg0HMx0NDKbgTs7Tzwyfi
         yEQKiyiz7BxxbyNYCau6qzwCqywUP5iZChKKQZGRdtWSCqA8O5VEc2QxrBzejTL70cOP
         Lh8/UJWtRjp7qrhxFFXnljSI9wWeMILoZA2e3ZY2I8mNPFfzHsC4arizrNeYhei2QgJb
         jZy0kii6tEHtfWLijAZisw3X6Fpi/Yv8DdrhNoBsKB2XdwCPEMS1BdT5BPuUgFuj6u3k
         dBn59vW5eFICzE3Psbmewc7k86Bxw6oq4yYOhQr+wWPOhPS4MqEiWdD1asGcmsYrbsHe
         53XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lT8hXgZ5oebKH8BXVU3lNXvwD2G+uha/MKyygB+peL8=;
        b=rQWKz/8wgRZZ3FtVl7It8W+O6yFMh39cgyTXC6rYfko+bSyhD1fEFSlOnQ0dLekZV2
         VJhS7aXRq/RS7MWbhAsp+L/x0nyl88WyE+kwlZaAWNX1b5rTol7UmY/ysWKN+o+7dPSG
         uuvCO+tfuYSlsQWv+nd5RqnfuvsShLI2wbYsi3Aa4hO6Y9Nmnh4C3o0i5aEfCZpKA4UJ
         hGIfDEClhIe8HGH6Raxk2nrTGXPNocuXRLywsOrKPnGymn7fby3EbIXYpxVklX0PPerD
         RUnaa++dks+AddLa6t0+imMrmiji+312khH6HKkzO+Rvl+UUYQ1RjMymS5mMvnVmjz3F
         UYhw==
X-Gm-Message-State: AOAM533+dLlU2fMfNhfry3i2CTS9uKCJS7pW30SNIwz2L0VMpfW+OCM2
        QRCzaze7yARhyn9mGN8cL7vESqCnl9Y=
X-Google-Smtp-Source: ABdhPJxMeyAkX+GM1Od8fk+0JT+bCU3sn2/gPgsug++RQUiN1+rTMuvsb+02Q40EJhmaDV6XDz5+fg==
X-Received: by 2002:a5d:61c9:: with SMTP id q9mr6078520wrv.219.1616014615515;
        Wed, 17 Mar 2021 13:56:55 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-299-135.w86-199.abo.wanadoo.fr. [86.199.82.135])
        by smtp.googlemail.com with ESMTPSA id g5sm158452wrq.30.2021.03.17.13.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:56:55 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 15/15] sequencer: use the "octopus" merge strategy without forking
Date:   Wed, 17 Mar 2021 21:49:39 +0100
Message-Id: <20210317204939.17890-16-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317204939.17890-1-alban.gruin@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches the sequencer to invoke the "octopus" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index ec8e9bda22..683ebfc8e2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2054,6 +2054,9 @@ static int do_pick_commit(struct repository *r,
 		if (!strcmp(opts->strategy, "resolve")) {
 			repo_read_index(r);
 			res |= merge_strategies_resolve(r, common, oid_to_hex(&head), remotes);
+		} else if (!strcmp(opts->strategy, "octopus")) {
+			repo_read_index(r);
+			res |= merge_strategies_octopus(r, common, oid_to_hex(&head), remotes);
 		} else {
 			res |= try_merge_command(r, opts->strategy,
 						 opts->xopts_nr, (const char **)opts->xopts,
-- 
2.31.0

