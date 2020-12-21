Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1600AC4332E
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1BC523123
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgLUSql (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgLUSql (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:46:41 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9585CC0611C5
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:45:53 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id g20so14885386ejb.1
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gsqo+O6UqNMmgnY88RZSDSouWNehD1MhUQs+KubNeD0=;
        b=mz7UazsGp88JfBs9ZH3HNLX7FO6jE4yS1gPOUGCMUipqi47J34Vi7KUMulA1n8qbz+
         KvZHv50RFEtItHQJAHHPPAR4PStHXcU+jkihypLnA8kemUT0/DAonSvjyw4eWOffJ3aV
         oelrUM7ZzMre0h71JEUmnoOs4XT2F1IId0jh3cR3J5aZE2chfFytooEOaC8bSOaWFrJk
         fZcnJiqlW1WqCsftU3NMOCEFrmrpoS67h9QBalvlsDou7Lg3ofy2CPSaT3e1fhq5lNy6
         r15iOeG92DfjTGAwFcLU70Kw0N/oYO8razxUEre8VH+VZhULKjsGDuVn++s0gpAj9CHo
         MHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gsqo+O6UqNMmgnY88RZSDSouWNehD1MhUQs+KubNeD0=;
        b=A7GnjNk5ET4X6h7eUxB5FxP8lfFVjF+J5DDZ+z70kXxAa/knWs4onFtzg/UYHQBn2C
         Pcec3mCpMfxkNeYwxMPNJL93wXByDsYGUFV6zB5Zs/2fPYju/phR1kgj1yzuFwuRk+gS
         xTTBULSRBj96IrNP73pGOoaQJ852/bnvCawtDLUOm7+z2Vt0GnNglHOtHdjoc3zFkMPj
         C79bboElDmkHr61v9sBlCzKfCCMh9BpwjAgxCqsMX5Tuw2dN729bohoPFHdrQ1TBa//B
         UUtuFqYBrsvtTTubZ3fpXO2yGMvUqpOf2c7G8BBXIuOQ31mTfxr5Z/aIWbY1FlJx4S2v
         C/Ew==
X-Gm-Message-State: AOAM530plQ+dXMNLRnsCX1+s6HKEc7cM+w/Wr7aggD7967ZMuK5OrSwQ
        iocZFPMN9cMNzILzbA19BZfowEKLrGM=
X-Google-Smtp-Source: ABdhPJw/hMODxdLOvv+l6qu0Cv/neCKi2Qsep+j9oTmODYmkEJNgxFgcp5ymS16/ZAqSnggbkigCfw==
X-Received: by 2002:a2e:9f01:: with SMTP id u1mr7329892ljk.386.1608564035314;
        Mon, 21 Dec 2020 07:20:35 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:34 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 02/32] revision: factor out setup of diff-merge related settings
Date:   Mon, 21 Dec 2020 18:19:30 +0300
Message-Id: <20201221152000.13134-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move all the setting code related to diffing merges into new
setup_diff_merge_revs() function.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 revision.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index 8b17cfd754fe..d818e0b18bbc 100644
--- a/revision.c
+++ b/revision.c
@@ -2192,6 +2192,16 @@ static int parse_diff_merge_opts(struct rev_info *revs, const char **argv)
 	return argcount;
 }
 
+static void setup_diff_merges_revs(struct rev_info *revs)
+{
+	if (revs->combine_merges && revs->ignore_merges < 0)
+		revs->ignore_merges = 0;
+	if (revs->ignore_merges < 0)
+		revs->ignore_merges = 1;
+	if (revs->combined_all_paths && !revs->combine_merges)
+		die("--combined-all-paths makes no sense without -c or --cc");
+}
+
 static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
 			       int *unkc, const char **unkv,
 			       const struct setup_revision_opt* opt)
@@ -2886,12 +2896,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			copy_pathspec(&revs->diffopt.pathspec,
 				      &revs->prune_data);
 	}
-	if (revs->combine_merges && revs->ignore_merges < 0)
-		revs->ignore_merges = 0;
-	if (revs->ignore_merges < 0)
-		revs->ignore_merges = 1;
-	if (revs->combined_all_paths && !revs->combine_merges)
-		die("--combined-all-paths makes no sense without -c or --cc");
+
+	setup_diff_merges_revs(revs);
 
 	revs->diffopt.abbrev = revs->abbrev;
 
-- 
2.25.1

