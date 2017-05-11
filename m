Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 359F6201A0
	for <e@80x24.org>; Thu, 11 May 2017 22:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbdEKWEe (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 18:04:34 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33655 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbdEKWEd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 18:04:33 -0400
Received: by mail-pf0-f182.google.com with SMTP id e193so20110758pfh.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 15:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YOssSe2TqteaSiCciHQKaOj26HgRqfmkLUmxg0q503I=;
        b=p5C+ZoGWboSa5wDkJ5o29rbTASD1AkPowS2nLnI2L12PiNW/KNkXDgAO097JSHqxnH
         D7CZB+ozoQIvsK+amk65/yIViiExIRpALks8RF5LBOO6PrP1AwYRk6Xa6Wg1JkDV/dGF
         S6owjaGAJWLVDHVt0TBVS1hgNUZ0Va7YwD57aEHo+5LBB3zupiIsgNLcD78u5nugEFld
         cwx5VPAIEXJRsaCBK//c5m7nslvGmiYkxk0zwc+DkxSEn4XCwQWCgDHPz3EsdRbkNvGz
         z8HUIS9pfrPDtOVTyJ1skYPg94JX/vVw9bllTBOTpjVytwSIG9jjaWdA84Sz6GlHmHz8
         Wo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YOssSe2TqteaSiCciHQKaOj26HgRqfmkLUmxg0q503I=;
        b=hTjNS+A1i0UuA0mwdriqfWVkW1ZhvXxHKN8ScWXdlDB9OHEKvfFP5AlBsxZrgi12rQ
         j0tJb4V5Pmz2vPL7TFu59gznC8JFNeyyfRpaGpXz9bWkvsfqAdm7jZryrdhLgwN6Fm43
         5nAYB96TazvLwcQvlXCPdgmaQ9Op15iJK5FqqJ7zdUyHCO7eI2rR3V4i03ldVU35l26r
         +cv5aJCGnG0Yyl5Du5B4LaX2c/bPKkqqPbHRLpJsmpsZIeljd8+6KCi2E5lG7vQHtOA5
         1kzHJE8wgdlUEtIrPqLQssciBAL90NwZUm/2w8yMZfu8YlU7aVDtxWOlTrCii8utZdR+
         8Z3w==
X-Gm-Message-State: AODbwcAgWNXAssi2zNxEGqhxl9cJarmPHxV+zDwFBhAl1FB0eJykcvI/
        EE5Ld2e2HfQUl3D0
X-Received: by 10.99.156.2 with SMTP id f2mr714553pge.65.1494540273159;
        Thu, 11 May 2017 15:04:33 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s68sm1873335pgc.5.2017.05.11.15.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 May 2017 15:04:32 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, j6t@kdbg.org,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 1/6] pathspec: provide a more descriptive die message
Date:   Thu, 11 May 2017 15:04:22 -0700
Message-Id: <20170511220427.192627-2-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
In-Reply-To: <20170511220427.192627-1-bmwill@google.com>
References: <20170509191805.176266-1-bmwill@google.com>
 <20170511220427.192627-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current message displayed upon an internal error in
'init_pathspec_item()' isn't very descriptive and doesn't provide much
context to where the error occurred.  Update the error message to
provide more context to where the error occured.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index 50f76fff4..904cfb739 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -555,7 +555,7 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 		 * would trigger that.
 		 */
 		die_inside_submodule_path(item);
-		die ("BUG: item->nowildcard_len > item->len || item->prefix > item->len)");
+		die ("BUG: error initializing pathspec_item");
 	}
 }
 
-- 
2.13.0.rc2.291.g57267f2277-goog

