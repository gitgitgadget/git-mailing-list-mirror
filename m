Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96023C433F7
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 16:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E852074F
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 16:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/jj9guR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbgG0QZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbgG0QZx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 12:25:53 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01776C0619D2
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 09:25:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k8so5057288wma.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 09:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dqiBREn1JkCHHo274rBaLgYRiUYsSP4+AcndhNbv6/c=;
        b=r/jj9guRLO9KUgXnIMK5BVSascXNXM4kxi4PBVjfuQqmX2PssN+l9W+yWium030CiG
         yDpuN4/7czIkfWupgAaQqn6VNICMBk2jrGcKBt27h8McNfjJukcUFdtBmMKkPYAo1acZ
         eiFD+3BG7EGMagpHWOqU40c1VRXv5i3tjfOQfizryVIXsUBsFOFg54lVnPjEgDvq6VGk
         ttZW47AbBE3q6vazFOrF+dNNJG7G7QdnmyO/EPlLo8Ac0zrdtq/7DW+09zn+J1pWH09I
         elz76KPSBTpaSMHA2lNrS+qxKduFtU4dtm6mNc+qj9QTXUc6PP+MFKgjR6SLYDVSUAB+
         4T/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dqiBREn1JkCHHo274rBaLgYRiUYsSP4+AcndhNbv6/c=;
        b=BInavTp7H9CTkYH65HVpdnDaRki1J8WcO9k/bXQ20hqgFWWaJD3v2Rqz+bqecc6WKQ
         daSYG2SyEbMmVkMuzcwTepnPXvdgeGn+k+n7s9S9EZyMTrEwQ44h3bjHl0QlwUJo7gfk
         p5MYcWcEbC3C1DPRXAykyn/2sSkKxV6/8onmiHWcMU86O0bD2yRDuXq++nX2MtAF8FYZ
         wqFZpYhIVE8N87NUTsfNVeZiTuMBP0lOhjyY/K7yx+hN1fkAhzMSOIWBPS5P4wDFN8SW
         YyACWm2257xHbN/AvaGGJjNjc8ZFQK9UK0Up/TDzkaaSQCfy5C5YBhqJBLqdtKQt+enI
         wP4g==
X-Gm-Message-State: AOAM532QKkHF4YkBR2nZep/c1nUOVIbiXvbFxdNwbqdU+2FD7h69Kxxp
        E5iU2SpyzU35KPj9vocium5gve3Y
X-Google-Smtp-Source: ABdhPJwC9PQ65rnUQnSlVU8aYYxfAlDGJm68zyli8ZZ5eDNyNfDbXLSmbMVLVOydw/EqvtF4WTAkKA==
X-Received: by 2002:a7b:c747:: with SMTP id w7mr103372wmk.136.1595867151630;
        Mon, 27 Jul 2020 09:25:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6sm12278152wrp.92.2020.07.27.09.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 09:25:51 -0700 (PDT)
Message-Id: <358d34df0769eff54bc293f473d6e4dedd912563.1595867147.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.673.v4.git.1595867147.gitgitgadget@gmail.com>
References: <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
        <pull.673.v4.git.1595867147.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jul 2020 16:25:47 +0000
Subject: [PATCH v4 3/3] Make HEAD a PSEUDOREF rather than PER_WORKTREE.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This is consistent with the definition of REF_TYPE_PSEUDOREF
(uppercase in the root ref namespace).

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index d676acb1f4..5cd71f711f 100644
--- a/refs.c
+++ b/refs.c
@@ -708,10 +708,9 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 
 static int is_per_worktree_ref(const char *refname)
 {
-	return !strcmp(refname, "HEAD") ||
-		starts_with(refname, "refs/worktree/") ||
-		starts_with(refname, "refs/bisect/") ||
-		starts_with(refname, "refs/rewritten/");
+	return starts_with(refname, "refs/worktree/") ||
+	       starts_with(refname, "refs/bisect/") ||
+	       starts_with(refname, "refs/rewritten/");
 }
 
 static int is_pseudoref_syntax(const char *refname)
-- 
gitgitgadget
