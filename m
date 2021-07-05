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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E07C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A216613AB
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhGEMfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhGEMfk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:40 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0781C061762
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:33:03 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 11so20617505oid.3
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YZ8FV/qzry/cy4/rRk6XfI2LNVE7d1NAm0BhI6ZtR9A=;
        b=Mhfyjni1o6eY8r6rOcuO55gJp3eDHvdihgAA4bdf1L0gARIGV0gwkjBMj3qVPCQHps
         5WHw70om4YDSxzASwoJBVtlkUksr82H91Km85XEMN+VQgrt8gonoFjxe/ixR9/7lHB/k
         HPMtIFRrfLinow7U7OPseC8cmQvaw2ftM73/FtMu6gopiFg0a+EO75PUp3+IA0UQYvgn
         op4YiM0OTSNwp07zxLW/Hw3thgd3vxokojwuENzNZV1zliN3hoCmbEuGlr/mqPmX2Oop
         tmu1JuXemYg1Atcy6TKqLY5IkIQj3Rpq1GWKkGGaNszdjq4a+n9jAf1X6LpFNqbs4D11
         BpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YZ8FV/qzry/cy4/rRk6XfI2LNVE7d1NAm0BhI6ZtR9A=;
        b=LNnlf6AeEQV7CNm8CWgM4gNToAETyizAN0MkdEkkUv8fbcJH3KU1edw/+NH0ANnK8u
         IHaSfzZUXjAyrHGM9K/FkVZSK8gJj/jEMe3/wbM8tyZo5gl/SWe3tsTkTz1yihhZkxUa
         UYIz8fjJtVUcdaNb2hm6+msAZE5sHe2WWVljp45Qsgp3R75BYRRJoaMCx9l5UwepHdLt
         blNJMVmEjMrfOYQ6MSafL6Ali42Vy9MKhJEKdHfE5c4tn+u6zZXYVppszcDJ6iH1Vp2d
         L6eC+y4JXFF1sqX8c5gQFeByuBz7K9UVKKefH8G0cptCIGq4TjSReI0u9gMcNPMEJoWu
         Z5DA==
X-Gm-Message-State: AOAM531CVbUo/NeUZ38yqsSG0VxcxucP49Aen/XYH46RANnS0GEtR/WX
        KP8wPbkFifUZiKEXDrmUfXwVtNjZQrtQMw==
X-Google-Smtp-Source: ABdhPJyPfPtzKazaxqccr9qUE+C7eRryDi/Ssw+nB0nUB+uF8+cHAu5WY6xl4tnOG1LF0HKbKqOq2A==
X-Received: by 2002:aca:31ca:: with SMTP id x193mr2632568oix.84.1625488382909;
        Mon, 05 Jul 2021 05:33:02 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id i133sm2692786oia.2.2021.07.05.05.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:33:02 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 30/35] pull: add diverging advice on fast-forward mode
Date:   Mon,  5 Jul 2021 07:32:04 -0500
Message-Id: <20210705123209.1808663-31-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index cbc102ee45..f4f822700a 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1118,8 +1118,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (!mode && opt_verbosity >= 0)
 			show_advice_pull_non_ff();
 
-		if (mode == PULL_MODE_FAST_FORWARD)
+		if (mode == PULL_MODE_FAST_FORWARD) {
+			diverging_advice();
 			die(_("The pull was not fast-forward, either merge or rebase.\n"));
+		}
 	}
 
 	if (opt_rebase >= REBASE_TRUE) {
-- 
2.32.0.36.g70aac2b1aa

