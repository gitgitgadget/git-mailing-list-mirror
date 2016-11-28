Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77FD11FC96
	for <e@80x24.org>; Mon, 28 Nov 2016 09:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932526AbcK1Jod (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 04:44:33 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36322 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932517AbcK1Joc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 04:44:32 -0500
Received: by mail-pg0-f65.google.com with SMTP id x23so12690335pgx.3
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 01:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/24yWqDh1GeyYbXAAh70i94/+PaCAwZjgn9ZEsNxQG4=;
        b=ygYyh10Y5VU3F4dQk6X66aUzZ7mHffLI3CGcFdJQ6jkyt4CWjvuJYJzZgYjNkZuQst
         osbogGZwSFLsGRbOuRMgQstHDwZ72RIbMvbM6Gy79Z1CvITdr9jSiXly3t/BXGD5qOhP
         0UOMU6TBZJeDsIWh9SjTISDKdV6WbUaRJ3/5lG0ErQCIx8xukK6UFrNnGac3fhxqLgGT
         f5ezAmcKE7WLrPNb9hTCwYa84jBDGpqdU58cbIMu6in5YatvKVM7FbAIGMCo+S/b76lM
         b4PzYnMDoVElAw+ziRok9zIHXIYS9UQvhfNGHK4Vs+K60MojMQTVpaYarKFP2wccpYVU
         jWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/24yWqDh1GeyYbXAAh70i94/+PaCAwZjgn9ZEsNxQG4=;
        b=V4Cz/ZO0vNmUle2osPaAfR1/V9kPfe8/nBH+Wvj71yxEfJMYxL2DF2LPA2EegtCR1f
         DTeRFhOLbP0tUTdywExeWmg2+uo85P2FExXsCLW4aghbRoFT5OMCPDXkLnKI/GAnrH5I
         0d0Mj4eWMrFbvSvAu8LSzoWGz2F40voIKLihSkpJtfEiPm1MDRswpWM9FD4W+TMcaNDh
         BeC9C2/C4YMyGE6LMLTlkMVZtrY0lwkVOk6vzyTdm+UtT0R9alSIxru46634UAx++Gva
         1GN8cofJeI7MJjOJhTE4g/veCssDX/cqViYpYsmhrAyZglZmwu919APQUjNM6kbrULuf
         XSUg==
X-Gm-Message-State: AKaTC02j3L13pyDYTFKT3SCfBSq0iLsy+Dz7jLosUhddrR/whPbGFpbxp5Rd6bLSsV018w==
X-Received: by 10.84.173.195 with SMTP id p61mr47800426plb.68.1480326271545;
        Mon, 28 Nov 2016 01:44:31 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id g27sm59600613pfk.58.2016.11.28.01.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 01:44:30 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 28 Nov 2016 16:44:26 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 10/11] worktree move: refuse to move worktrees with submodules
Date:   Mon, 28 Nov 2016 16:43:18 +0700
Message-Id: <20161128094319.16176-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161128094319.16176-1-pclouds@gmail.com>
References: <20161112022337.13317-1-pclouds@gmail.com>
 <20161128094319.16176-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Submodules contains .git files with relative paths. After a worktree
move, these files need to be updated or they may point to nowhere.

This is a bandage patch to make sure "worktree move" don't break
people's worktrees by accident. When .git file update code is in
place, this validate_no_submodules() could be removed.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index f732a74..e36e4dc 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -525,6 +525,27 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 	return ret;
 }
 
+static void validate_no_submodules(const struct worktree *wt)
+{
+	struct index_state istate = {0};
+	int i, found_submodules = 0;
+
+	if (read_index_from(&istate, worktree_git_path(wt, "index")) > 0) {
+		for (i = 0; i < istate.cache_nr; i++) {
+			struct cache_entry *ce = istate.cache[i];
+
+			if (S_ISGITLINK(ce->ce_mode)) {
+				found_submodules = 1;
+				break;
+			}
+		}
+	}
+	discard_index(&istate);
+
+	if (found_submodules)
+		die(_("This working tree contains submodules and cannot be moved yet"));
+}
+
 static int move_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -565,6 +586,8 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	if (validate_worktree(wt, 0))
 		return -1;
 
+	validate_no_submodules(wt);
+
 	if (is_directory(dst.buf)) {
 		const char *sep = find_last_dir_sep(wt->path);
 
-- 
2.8.2.524.g6ff3d78

