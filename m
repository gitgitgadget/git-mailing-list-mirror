Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1796C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710D422D49
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgLUSLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgLUSLT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:11:19 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424ABC0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:10:39 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id x16so14697129ejj.7
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cAXip+sVDPuQwqmm2d5Ra7BHOOby8RQkWsnWSW1kVKE=;
        b=Nsutx+oLpenmJ2aXS7cWknHE134P2713YxlYoBGF7aNwwt6c0Cn+dyPwcBo4bJkf10
         6H3TxSiJAUUkfCLEqb1uk2hxP7U98zicvNnxX4qY7MTPz4odxkfyhvovCrfbiQql2Ksr
         xYYZuv0GA03LkqTw+OXRO9DG8gF71goA3ychgpWyY3cEgYqSD4zx4GiDFshcuJjEzHmY
         5U3d679v3V42o4qP5x49J/qw6xKMJb1SLAc/gMeuXOiWV5SQh4JSxHJtdHGAmJygGm5k
         VVBC5U0Z0VapcK0gVAAh1Xg+/XN8XEOJt1r7/U9lAbNJn0J3cgx4VhI3Yp0jYMSOZ/GV
         Yu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cAXip+sVDPuQwqmm2d5Ra7BHOOby8RQkWsnWSW1kVKE=;
        b=W8TnUzOqNh1OXbBTKbOLhTeYuCVH9v255YWEd5nNC4st/hBLRVSvsyRMizkcpPdBDV
         9ynInz7sZFP3E8nxSnkkxasktqKrmQEv8DsRN1UUDCkzdlZ3icA4i0ZmpTxEAUNGFNVy
         MplT1wMT5TDbdYFtHqSucg6uVtMZNexN3Q3lzlsNCVIVMRlhrfLOMRIdJN28msb5k+K6
         0L0DNuJgHfeogI+0UVckKIWbxIXkelM4/oGpMeHRJ9EDHm1qh6XrI6uqQ+H3BKmPj430
         mlGLPXGLkVsMW5kXfwP+SKD25jocIEvM455AaAj9dwnitWUjhJj/s8p3QpOpozIZ/lj/
         T9nA==
X-Gm-Message-State: AOAM5308b7x5qI92EApvBNXCnNxugoSXWxx3KMdObU3SlDeKbFpH4aLz
        +DHaHYIr+Rac1cTKInfW2Sk99tvFI3c=
X-Google-Smtp-Source: ABdhPJwgs1RQCLV+jllFSNAFOPoHLOvb2wWaoSRTBh9K+3MQpE+cFRl3Qp/i7eMPAd73fIHrZYl2KQ==
X-Received: by 2002:a19:c3cb:: with SMTP id t194mr6450061lff.599.1608564053184;
        Mon, 21 Dec 2020 07:20:53 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm2220085ljj.67.2020.12.21.07.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:20:52 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v3 17/32] diff-merges: fix -m to properly override -c/--cc
Date:   Mon, 21 Dec 2020 18:19:45 +0300
Message-Id: <20201221152000.13134-18-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201221152000.13134-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201221152000.13134-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Logically, -m, -c, --cc specify 3 different formats for representing
merge commits, yet -m doesn't in fact override -c or --cc, that makes
no sense.

Fix -m to properly override -c/--cc, and change the tests accordingly.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c           | 1 +
 t/t4013-diff-various.sh | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 225edd293b43..047bf81e6777 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -33,6 +33,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 	const char *arg = argv[0];
 
 	if (!strcmp(arg, "-m")) {
+		suppress(revs);
 		/*
 		 * To "diff-index", "-m" means "match missing", and to the "log"
 		 * family of commands, it means "show full diff for merges". Set
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 64d9fce44614..8d8178a8a616 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -329,8 +329,8 @@ log --first-parent --diff-merges=off -p master
 log -p --first-parent master
 log -m -p --first-parent master
 log -m -p master
-:failure log --cc -m -p master
-:failure log -c -m -p master
+log --cc -m -p master
+log -c -m -p master
 log -SF master
 log -S F master
 log -SF -p master
-- 
2.25.1

