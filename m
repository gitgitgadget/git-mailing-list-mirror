Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8662E20437
	for <e@80x24.org>; Tue, 31 Oct 2017 18:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753811AbdJaSTg (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 14:19:36 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:56350 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932386AbdJaSTW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 14:19:22 -0400
Received: by mail-pg0-f65.google.com with SMTP id m18so15356207pgd.13
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 11:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wwwELU8JyDTOI9Tt2lWVpgKiZmuaZ6YEoYRqxPHRNU4=;
        b=Tk0zaEyge2LfdBs0HuczkHp+X/5I4M0CcR69W2isprGEFxtMFQmbZQ3RpIhuingtu4
         RLT/Lp5xsEvGQ6Zf6hNOWQCYEr9sGze7q1LCn26pkj3ggFCaXvwQ76tQ3ma0q/Vgi3Id
         r2MjUPqP4JPMvsNc4KMByaP4Ake86RFurirs391yfaeMcztXMPT7g5LQ177SKd9irpsj
         Sz5uTnWF2D8xUOeVoV8PBlfoQAbdZVgxGoNOXzU/KIKH4V4x1RpHmMRaUBxF4yIpOkje
         AOUUK0tbrAsLY+Rv5IhjCbZMvk5+Sp1tiRwNvGZ2aoGrReD2+ZlA3+sZXFL7gPHlr61i
         vvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wwwELU8JyDTOI9Tt2lWVpgKiZmuaZ6YEoYRqxPHRNU4=;
        b=gRxoKcq3BRTFgAHm0Rn33J/i5niOnIW/o+dX+MYjGgB2f1wwnh2lgjHcI3E5ev0mpH
         PRHzuWF6iS6h6qfbhcuD2y0tG2rQKpWSurBPonPqwGC3JVsZ1Nwtw8ifs4KCyVnKIH+u
         cR7O4a9KAwmyNjAKDFCghBP3F/FiN2nAFAae7WiLQgkPwoeKGOj94OjdXIimcLL2BvZQ
         nO8pbnsUmSMERz/NWg/EFuvFPdPR0yBV7XKySNg75Alrhoi5pGHRIs6NH1uQQwbiZMNr
         WOyt7V9UV/JdtGKHGwjqaDdGW3J/8rIvQdPcPD0TO+DbLwzHitykDT004s27F5iG/6bO
         Y+rA==
X-Gm-Message-State: AMCzsaUf0He72csHnlwgYVnX5NoQK0ZclEqCs+PqkQ/rRA9h+4P84fQn
        zOwcb0CTXIJ9uMK9fyuIfrke3aWwYQI=
X-Google-Smtp-Source: ABhQp+S88pdFG3pPmEwDNttNOmFFAthSooI+eFXqD7RXOrpE/y+Zbcx9qnj1fcgO4dUS9OzPbrlv7A==
X-Received: by 10.101.64.133 with SMTP id t5mr2537313pgp.299.1509473960501;
        Tue, 31 Oct 2017 11:19:20 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id a78sm4308985pfl.122.2017.10.31.11.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Oct 2017 11:19:19 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 3/8] diff: add flag to indicate textconv was set via cmdline
Date:   Tue, 31 Oct 2017 11:19:06 -0700
Message-Id: <20171031181911.42687-4-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6-goog
In-Reply-To: <20171031181911.42687-1-bmwill@google.com>
References: <20171030194646.27473-1-bmwill@google.com>
 <20171031181911.42687-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-show is unique in that it wants to use textconv by default except
for when it is showing blobs.  When asked to show a blob, show doesn't
want to use textconv unless the user explicitly requested that it be
used by providing the command line flag '--textconv'.

Currently this is done by using a parallel set of 'touched' flags which
get set every time a particular flag is set or cleared.  In a future
patch we want to eliminate this parallel set of flags so instead of
relying on if the textconv flag has been touched, add a new flag
'TEXTCONV_SET_VIA_CMDLINE' which is only set if textconv is set to true
via the command line.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/log.c | 2 +-
 diff.c        | 5 +++--
 diff.h        | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index dc28d43eb..82131751d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -485,7 +485,7 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 	unsigned long size;
 
 	fflush(rev->diffopt.file);
-	if (!DIFF_OPT_TOUCHED(&rev->diffopt, ALLOW_TEXTCONV) ||
+	if (!DIFF_OPT_TST(&rev->diffopt, TEXTCONV_SET_VIA_CMDLINE) ||
 	    !DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
 		return stream_blob_to_fd(1, oid, NULL, 0);
 
diff --git a/diff.c b/diff.c
index 3ad9c9b31..11fccbd10 100644
--- a/diff.c
+++ b/diff.c
@@ -4762,9 +4762,10 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_OPT_SET(options, ALLOW_EXTERNAL);
 	else if (!strcmp(arg, "--no-ext-diff"))
 		DIFF_OPT_CLR(options, ALLOW_EXTERNAL);
-	else if (!strcmp(arg, "--textconv"))
+	else if (!strcmp(arg, "--textconv")) {
 		DIFF_OPT_SET(options, ALLOW_TEXTCONV);
-	else if (!strcmp(arg, "--no-textconv"))
+		DIFF_OPT_SET(options, TEXTCONV_SET_VIA_CMDLINE);
+	} else if (!strcmp(arg, "--no-textconv"))
 		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
 	else if (!strcmp(arg, "--ignore-submodules")) {
 		DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
diff --git a/diff.h b/diff.h
index e512cf44d..d077d3c10 100644
--- a/diff.h
+++ b/diff.h
@@ -83,6 +83,7 @@ struct diff_flags {
 	unsigned DIRSTAT_CUMULATIVE:1;
 	unsigned DIRSTAT_BY_FILE:1;
 	unsigned ALLOW_TEXTCONV:1;
+	unsigned TEXTCONV_SET_VIA_CMDLINE:1;
 	unsigned DIFF_FROM_CONTENTS:1;
 	unsigned DIRTY_SUBMODULES:1;
 	unsigned IGNORE_UNTRACKED_IN_SUBMODULES:1;
-- 
2.15.0.403.gc27cc4dac6-goog

