Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3C1C208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeHHR6s (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:58:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45880 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbeHHR6r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:58:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id s16-v6so1454210edq.12
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=quPVf8eBVzcZxz8ex5NJeP51z5cR0PcYn2Z1GwULhcw=;
        b=WDxuekuKECM3ThfwZFuP6eKd6FdoG6xfvVOwhEbvuY/T3D4L32Q+daWE1RyZtTK/wS
         F6X8q95kpR+5OHdaL0H/rzhHUuhqlghaVFGNb+TOeHO+0kcTQyqA+y1XXXsS5SHQXUUx
         TT7c8twqQzot96YuycC5RAgP1RFG84mkryda9cswkZvuZdP76y7H132gnPZ5cO6eZwG9
         m9eYdQjKKVOhZMDWwFHc9PuNPKh4VkwRkWWLry/dHnqEvGHM9A9CwdH2b4VA4FN8O/Cg
         hgAStvvBQy7YVuccnyzLMasykvbsnTQVfsRdRUZISh3Bn2639FeDJHMa0sZl+NB6+IX/
         rtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=quPVf8eBVzcZxz8ex5NJeP51z5cR0PcYn2Z1GwULhcw=;
        b=JoVWJISN4tOWrblZM1kFA6uZksuVssrLAmN9YwaKDhIzUbqPSOdX9F28E7OeUh4hyW
         hKr+e8LrzjiMyh+xUiBolELPgLZVb7pbAS9RiKVz4mdIDala/LxEfPp2LV6kI9Z7TmuM
         mIfrez8iuyJDL8SsVIIXae9qYjdM1gvp/dTnFbD/O735mb2pW3CAQOksQmMrkKdjwVy+
         JivaRfdxIDWT3Ds7TKaAs4GHXykXsur+P2S/kLylMM5tlvVxs0L6ST/V2PzDKk3DftLz
         0hDNiA/9q4f5sY9PfqiG0/DqHQXaj5R5kxS2OQkazr4CoqFmrpuMorFDK8nYKjIdRFzx
         KrUg==
X-Gm-Message-State: AOUpUlEdLVLy3QpelNnPlnHZ/C68t7spu1yDgqysLIKdAKhjAk9whJ3F
        JJ76KJd3wgKH2aaNSHi4VP/RZtJ9
X-Google-Smtp-Source: AA+uWPwy2xAjHG8dhokw1V4xe2mXNft0VvbcT6YfXre0KctCBgUP2oYL9XXhBD7LDSmH9BKZrrpuTg==
X-Received: by 2002:a50:a93c:: with SMTP id l57-v6mr3722432edc.229.1533742714234;
        Wed, 08 Aug 2018 08:38:34 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1904876edo.39.2018.08.08.08.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:38:33 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 5/6] builtin rebase: use no-op editor when interactive is "implied"
Date:   Wed,  8 Aug 2018 21:21:34 +0545
Message-Id: <20180808153635.19944-6-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808153635.19944-1-predatoramigo@gmail.com>
References: <20180808153635.19944-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some options are only handled by the git-rebase--interactive backend,
even if run non-interactively. For this awkward situation (run
non-interactively, but use the interactive backend), the shell scripted
version of `git rebase` introduced the concept of an "implied
interactive rebase". All it does is to replace the editor by a dummy one
(`:` is the Unix command that takes arbitrary command-line parameters,
ignores them and simply exits with success).

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 04974dff6e..fb8ab5a177 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -383,6 +383,13 @@ static int run_specific_rebase(struct rebase_options *opts)
 	add_var(&script_snippet, "git_format_patch_opt",
 		opts->git_format_patch_opt.buf);
 
+	if (is_interactive(opts) &&
+	    !(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
+		strbuf_addstr(&script_snippet,
+			      "GIT_EDITOR=:; export GIT_EDITOR; ");
+		opts->autosquash = 0;
+	}
+
 	switch (opts->type) {
 	case REBASE_AM:
 		backend = "git-rebase--am";
-- 
2.18.0

