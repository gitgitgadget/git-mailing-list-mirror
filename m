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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EDEC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6044A613B1
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbhHXVx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbhHXVxd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:53:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41C5C0613D9
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:52:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso2857267wmb.2
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NfMdKaRTjEVUpxzZnXjRs054AukpwAC0Z5SwjTLMFZc=;
        b=O11HuEymHPhs9SfCLRLC/iqwyOSm68RZ69Mm6Cnx4fiIvyh7OFORt8odQDUWIZxryY
         5Nqmd7P1PjJgoVjCOWobxrd6WU6ZN5Rqen6My+fxMrW++diM5pUhLhhFENiHne0Z4VPq
         /TfYlRqnbvMe36Huc/o5gEp3bJTRjl0FEM4dWHWQ0L+QKqiYhLPyJPqPCrPeHCF8yEBX
         DjYpdhHD1UG2vAWDEnG/PNKbkAbdsFaUzq3f6GyyIhiswaMzq146mZJifF1Yx31q1RSM
         VzPp0BO63BwDWhcUtW30iQiaOiGFR45O+ZMpKsxl8gmmIRo+nNkJxGYaJdcqhlW4yskx
         vcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NfMdKaRTjEVUpxzZnXjRs054AukpwAC0Z5SwjTLMFZc=;
        b=YqiBRs3Fl+K0fbGbAj67iOqrNAm+2WOReAPg6D6e1TNDvSdU8NdbCTF8YysJ6abSIF
         IXbnDhpEM46ED87yv7KRD/ysrs6d/CYN2UHh6XyjvFXX6SUZRrRckbn+w8igjbRtjwvJ
         pjsfpTRmXLsZR4bhbCDdX1GNNCipBWt/FkM60OUGxCV3kMvm3dlnqQTcaRWrkw4S05Vc
         lL5LqCKhzpSAay9ZXT3aVB1CjAycB3byB99YpH8damP2UurS8JaHnakjLYUqm4hdIPwm
         NOQERjH+BFRkb8g9THNXNMjk2o/ldK12gj9R9dAa3IT7dco68pPknVvRekz/jaP4q5yd
         gf2Q==
X-Gm-Message-State: AOAM533Z5nLmS5KGRp19qxOw+wn0Rz7HLrzJx0007/AUKe7npIEqsB9S
        frD6m0WzjkMFytTenRYb3WZe60yZFOE=
X-Google-Smtp-Source: ABdhPJwBwop58PIv8xPipbsed34y0pFOqyhvOY3Yp+gRaDeZyWjPQ2NGUoqWvGZr6/sbPdsNW57z/A==
X-Received: by 2002:a7b:c30f:: with SMTP id k15mr6048010wmj.128.1629841967614;
        Tue, 24 Aug 2021 14:52:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a77sm3619117wmd.31.2021.08.24.14.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:52:47 -0700 (PDT)
Message-Id: <c5ae705648c39b87208b67ad1def749f5058e977.1629841966.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
        <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:52:40 +0000
Subject: [PATCH v2 1/6] diff: ignore sparse paths in diffstat
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

