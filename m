Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BAFC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0638661153
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351424AbhIHLZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 07:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbhIHLZM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 07:25:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F0BC061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 04:24:05 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so1041670wme.0
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 04:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NfMdKaRTjEVUpxzZnXjRs054AukpwAC0Z5SwjTLMFZc=;
        b=qFSB1RyLxqqlNoymy+Jx061B6bOpTmRY5U5Fx2YhwrUvOJm3ZGSbHU7Ncy1Vq+L1Kc
         9kN4H3Kxylbwc29AnrSULPsw4CZU0SIGj8R/qMqnZplQWWCt26IFHVNYj0mATZtmYQ9+
         7Cv/uvsjKT+2y528FOFvT7DShB1JftZEkK1aCM3/gjf5Rr0B123YtrO9wx3+Qrh/Mu2T
         IGJt0Ee7PeL5BOK4Mgid+bh5Fe1XsfGs9dhoWrk2xnj/PXlvI3Pq0aBgW6OT7qc+43e/
         9etcIu1Z5aj4hFeGZaVktd/W28uecZWS76lI2gY+L6fsBlwCPja32u/+o/UGPNst5bVx
         QC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NfMdKaRTjEVUpxzZnXjRs054AukpwAC0Z5SwjTLMFZc=;
        b=n1e0mLSL+P8ZsEwTyIFJELJ4L2jknbvoF8an1OvCSVsLnY/jjqmcWTWDz4bEzZbn9p
         oKKhFLIn5EHiVPFYkvy8ij9Ait7R3oQJS8Gyto2y47qUiHt8g3umJYveGLFs6PEqwBgv
         JDS3WrK7w4TWI+Bt5jWd52S4pXhgpH7lKXGJN73E+AhXFKBIWzKtltk6tSaXz7aUXGzH
         ULHX80qvr/x78mw94JqPywai5qGnhzZlS37tFDWFVqL0nC/Qkt30iXce5UWwyN6GEV/p
         HgsUjGch5BRgXgylp1SLfQeLW7R8IDlzo7VRj5p7UhZb1AUzm3+0pTIcH2jaK70HXacC
         kBvA==
X-Gm-Message-State: AOAM532BRpyhgr67Uc702zQw0HtEdlV+4k5jAdFW+uyV+VmM01O8KuzF
        qxcNLTTBUgP63iHZD49kSPWAnn9YYNg=
X-Google-Smtp-Source: ABdhPJxJyHxC8mUfKFmATB8CPPbpIAc9uxZ3B8HEvQJBwabAutTyd0FQIZ0xBwzGKlKKhEgIE7sy3g==
X-Received: by 2002:a05:600c:364f:: with SMTP id y15mr3030645wmq.193.1631100243726;
        Wed, 08 Sep 2021 04:24:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm1860451wro.83.2021.09.08.04.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 04:24:03 -0700 (PDT)
Message-Id: <a6963182fe086eeec2c4e7ee3870eee1bd1d88d8.1631100241.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.v3.git.1631100241.gitgitgadget@gmail.com>
References: <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
        <pull.1019.v3.git.1631100241.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 11:23:56 +0000
Subject: [PATCH v3 1/6] diff: ignore sparse paths in diffstat
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com, gitster@pobox.com,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The diff_populate_filespec() method is used to describe the diff after a
merge operation is complete. In order to avoid expanding a sparse index,
the reuse_worktree_file() needs to be adapted to ignore files that are
outside of the sparse-checkout cone. The file names and OIDs used for
this check come from the merged tree in the case of the ORT strategy,
not the index, hence the ability to look into these paths without having
already expanded the index.

The work done by reuse_worktree_file() is only an optimization, and
requires the file being on disk for it to be of any value. Thus, it is
safe to exit the method early if we do not expect the file on disk.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 diff.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/diff.c b/diff.c
index a8113f17070..c8f530ffdbe 100644
--- a/diff.c
+++ b/diff.c
@@ -26,6 +26,7 @@
 #include "parse-options.h"
 #include "help.h"
 #include "promisor-remote.h"
+#include "dir.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -3907,6 +3908,13 @@ static int reuse_worktree_file(struct index_state *istate,
 	if (!want_file && would_convert_to_git(istate, name))
 		return 0;
 
+	/*
+	 * If this path does not match our sparse-checkout definition,
+	 * then the file will not be in the working directory.
+	 */
+	if (!path_in_sparse_checkout(name, istate))
+		return 0;
+
 	len = strlen(name);
 	pos = index_name_pos(istate, name, len);
 	if (pos < 0)
-- 
gitgitgadget

