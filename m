Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2512AC433DB
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7582222F
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbhAANIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jan 2021 08:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbhAANId (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jan 2021 08:08:33 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B737BC061786
        for <git@vger.kernel.org>; Fri,  1 Jan 2021 05:07:16 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q18so22009503wrn.1
        for <git@vger.kernel.org>; Fri, 01 Jan 2021 05:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d/eVKI2EvujR9IBy/Q2jjjGpNfInUroCVP4n4Dr1IoQ=;
        b=J1/j/w6oJNiIJD0LRhbH/89xseDvQ5GTo/otN7Wqch1o/QwjtSxN21gMxWRwj0Cc8l
         yehzfnKiDZbtagMuO1QZEtD0EiJF8EigIKs76Whfpcu9f7tvwnAGeYyN4VzcDPveTVIU
         V9ZbwHil1eR2I7yJbsat/p9dg9/zlJIRBYQZMhWhNG7QpkFQGc3epph3n/8vO/e/AKJb
         9SoF9zHMehje19qoi3qd+rWjFrxwbXykolzJB8dtk2l95mjkCbC4d7NLbkGYyGlwT1JV
         s39/QQOkfDrSHHl7E2Y1JOl3sBW0Eu7nExlZgp/ZQMdvzOBJoIsBLaVcu936yAHT9C0+
         eNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d/eVKI2EvujR9IBy/Q2jjjGpNfInUroCVP4n4Dr1IoQ=;
        b=p84SsidmyzpwTByM9NuSRZrceUE/moCkTeUaS5UyTzPE7+JFlCYzaAK5VbqLm/Z7Ar
         7CNwjsE/Y5o3BE0ThoEe1FeuEoHwQsY8Ez8ArQwCHpJRsWisJ2VAh2Xqpd4Lfeta14v7
         xvYvwSyUrwu+l6W3gCTaXhuZ31WFE3sMVq3rTaZnsGS4/37zoYmp3/eLHXe7ztl+6Le2
         +QFd3QUeUAR8DXzxf8hiuQ3ifauQUygcnkzPONtyH8EFyNGX0SxmxFCh3Fgl1RlC+geL
         AXXAW+EN/eGh6kjQWqaZspDl32EoZhcDtM40K2VoBHwpUi08bry0NpMeNI+Xu8ZklKJo
         /LLw==
X-Gm-Message-State: AOAM531lcito6kBKf3DZWM9epJth3ANpkM2pcy4pdTt6JdedR1Kg+QLN
        nfciII150vP2uLfrz2iZCjrFd6g1kIs=
X-Google-Smtp-Source: ABdhPJw1sWeyC47Z6b0kvXsnIIgxx4Ebg57rEXac7MuysSqaNrR3pxMm91PGgZDjH6MCSMin7X/D+g==
X-Received: by 2002:a5d:4242:: with SMTP id s2mr68265774wrr.187.1609506435342;
        Fri, 01 Jan 2021 05:07:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i18sm75231420wrp.74.2021.01.01.05.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 05:07:14 -0800 (PST)
Message-Id: <e99b8bddb3ab30e3db3e1738cf9ef23787394512.1609506428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.1609506428.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 13:07:02 +0000
Subject: [PATCH 06/12] update-index: use index->cache_nr over active_nr
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 0616c786410..f1657a66496 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -346,7 +346,7 @@ static int process_directory(const char *path, int len, struct stat *st)
 
 	/* Inexact match: is there perhaps a subdirectory match? */
 	pos = -pos-1;
-	while (pos < active_nr) {
+	while (pos < istate->cache_nr) {
 		const struct cache_entry *ce = istate->cache[pos++];
 
 		if (strncmp(ce->name, path, len))
@@ -638,7 +638,7 @@ static int unresolve_one(const char *path)
 	if (0 <= pos) {
 		/* already merged */
 		pos = unmerge_cache_entry_at(pos);
-		if (pos < active_nr) {
+		if (pos < istate->cache_nr) {
 			const struct cache_entry *ce = istate->cache[pos];
 			if (ce_stage(ce) &&
 			    ce_namelen(ce) == namelen &&
@@ -652,7 +652,7 @@ static int unresolve_one(const char *path)
 		 * want to do anything in the former case.
 		 */
 		pos = -pos-1;
-		if (pos < active_nr) {
+		if (pos < istate->cache_nr) {
 			const struct cache_entry *ce = istate->cache[pos];
 			if (ce_namelen(ce) == namelen &&
 			    !memcmp(ce->name, path, namelen)) {
@@ -748,7 +748,7 @@ static int do_reupdate(int ac, const char **av,
 		 */
 		has_head = 0;
  redo:
-	for (pos = 0; pos < active_nr; pos++) {
+	for (pos = 0; pos < istate->cache_nr; pos++) {
 		const struct cache_entry *ce = istate->cache[pos];
 		struct cache_entry *old = NULL;
 		int save_nr;
@@ -766,14 +766,14 @@ static int do_reupdate(int ac, const char **av,
 		}
 		/* Be careful.  The working tree may not have the
 		 * path anymore, in which case, under 'allow_remove',
-		 * or worse yet 'allow_replace', active_nr may decrease.
+		 * or worse yet 'allow_replace', istate->cache_nr may decrease.
 		 */
-		save_nr = active_nr;
+		save_nr = istate->cache_nr;
 		path = xstrdup(ce->name);
 		update_one(path);
 		free(path);
 		discard_cache_entry(old);
-		if (save_nr != active_nr)
+		if (save_nr != istate->cache_nr)
 			goto redo;
 	}
 	clear_pathspec(&pathspec);
-- 
gitgitgadget

