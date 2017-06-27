Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63C820401
	for <e@80x24.org>; Tue, 27 Jun 2017 21:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753794AbdF0VcI (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 17:32:08 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34604 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753583AbdF0VcH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 17:32:07 -0400
Received: by mail-pf0-f177.google.com with SMTP id s66so22612607pfs.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6JyF1o46DW7J2Gcu0RltmTSiEhnavFi0JkzBXFz/7/o=;
        b=F4Zx1VtfiEXHcMiL3gkt96YTD1CklwVQkna2d2k35PPeakWkKeaeSAkbzk25PN+OS5
         iia5xAllS/tZid4kRFGIjV0JwcwlHV3gluWrsb4lcOPBU3dPHumZSgdQvqWWbMT4IgLa
         Ouq3SFPwCl6LH5yXhJSJa/oQv+/wwgFjOETG93RhYpvrdR/4OGAROSnk5xy9319F8BY6
         n2sYdYXQCcEUwgwTiN1kcHx1wgJY48RGrFm6lQlOEflNp61M8ix9M2MVYtWKGoIb5JTo
         FGyWt/zeGq0w2rTdj9WjW7Gea0ZlkdREEU4F/N1PBRVANtKYSS2BtRzZrCTHVjC9AG3Q
         9bAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6JyF1o46DW7J2Gcu0RltmTSiEhnavFi0JkzBXFz/7/o=;
        b=MRJ/s1LFqO1EGuwqL/t33jpYFtgID0QVllCMjyirhAvH5JWGywzPXqHiWmp8DYFxBV
         vQf7M3uQVBU3b24QFPOgFxGF0Ak/qb5tYNmoY9dJ9fQgjMW2DOyuoy5LBbSjDFHNq+XG
         7vK9J3gXsCzkTUvNBOqzVp9yhgL4zv5ifrx+rFIe7fMrbj4BM1RE9AMWYCSPdENXgKtr
         LJ2z+YovqeUpOVWaymDK24zvnW9NDWdfeEg0k32wa9q872ndnhJBEbhE1SdpdaFGqg4L
         7BLrnrLv5pg9kzk5QQKk1GBiz9Bn0gPdO7PBOrEmMf+7gLW3wtD3COH4NaVNrUzFXJjz
         RfWg==
X-Gm-Message-State: AKS2vOzAGm4Z1iuWktWSw3dyx5Rw4HuRguCCnbZNbq7YH+1JgJdCxebA
        KH61XTZrCjHdrKHq
X-Received: by 10.98.15.220 with SMTP id 89mr7322684pfp.203.1498599122048;
        Tue, 27 Jun 2017 14:32:02 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ac62:ae13:b066:f242])
        by smtp.gmail.com with ESMTPSA id w190sm360078pgb.30.2017.06.27.14.32.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 14:32:01 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, philipoakley@iee.org
Subject: [PATCH] builtin/fetch cleanup: always set default value for submodule recursing
Date:   Tue, 27 Jun 2017 14:31:59 -0700
Message-Id: <20170627213159.3717-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.1.519.gc4803e3bc3
In-Reply-To: <CAGZ79kZUkQCEEcLUcg8tSr33Wng1Fq4_i4n80+Xr45y0mcvB6A@mail.gmail.com>
References: <CAGZ79kZUkQCEEcLUcg8tSr33Wng1Fq4_i4n80+Xr45y0mcvB6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The check for the default was introduced with 88a21979c5 (fetch/pull:
recurse into submodules when necessary, 2011-03-06), which replaced an
older construct (builtin/fetchs own implementation of the super-prefix)
introduced in be254a0ea9 (Add the 'fetch.recurseSubmodules' config setting,
2010-11-11) which made sense at the time as there was no default fetch
option for submodules at the time.

Set builtin/fetch.c#recurse_submodules_default to the same value as
submodule.c#config_fetch_recurse_submodules which is set via
set_config_fetch_recurse_submodules, such that the condition for checking
whether we have to set the default value becomes unnecessary.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This queues on top of origin/sb/pull-rebase-submodule,
and answers questions raised in the review of origin/sb/pull-rebase-submodule^.

I thought about just squashing these two patches, but they do different cleanups
so I am personally fine with having them both.

I may squash them if further review of that series
requires a resend of the whole series.

Thanks,
Stefan

 builtin/fetch.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3cca568173..7ea52b8b07 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -49,7 +49,7 @@ static struct transport *gtransport;
 static struct transport *gsecondary;
 static const char *submodule_prefix = "";
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
-static int recurse_submodules_default = RECURSE_SUBMODULES_DEFAULT;
+static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
 static int shown_url = 0;
 static int refmap_alloc, refmap_nr;
 static const char **refmap_array;
@@ -1336,8 +1336,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		deepen = 1;
 
 	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
-		if (recurse_submodules_default != RECURSE_SUBMODULES_DEFAULT)
-			set_config_fetch_recurse_submodules(recurse_submodules_default);
+		set_config_fetch_recurse_submodules(recurse_submodules_default);
 		gitmodules_config();
 		git_config(submodule_config, NULL);
 	}
-- 
2.13.1.519.gc4803e3bc3

