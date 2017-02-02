Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 410FB1F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 08:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751172AbdBBIvM (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 03:51:12 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33187 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdBBIvL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 03:51:11 -0500
Received: by mail-pg0-f68.google.com with SMTP id 194so1266794pgd.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 00:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iKvF867xop52k2F/rU3yaJ+rmXj+EDQG12ZL3DExeY0=;
        b=u4k9josfdiSBs9w6oLnKjw+uvfO3DG2Nr7ZYSNzbPS/5R/wYLh4b+z2CuyYDZJ6cb1
         H6WCfKsXFCL2riQ3oCgVInJv8NDWkN9QVGnl9t0LV+7S2Nm/ILgqBAx84v2sXVxxER9a
         ti3Vep/V6CsBJYiCiJU/TeTqdOrmPL9GXOGAxo7xaZBKzoqTV9qq0ua6Wqb/pwseptG7
         I2738Lp1GOChSvdS0cN5rfdfoIviC9mdbfCxmseIoTSm+92pksYSw4liO/iB4yv4hUkX
         7xC+MGGWfoXlw1ThWQodBbG1vJNcIb9mn4h2IHGXyWqAjzDRjahBH1yN4GcdMCmWN+iC
         dJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iKvF867xop52k2F/rU3yaJ+rmXj+EDQG12ZL3DExeY0=;
        b=SrZ+TM/LTvMJGnvQgwpcGW18yFIlsSkHInvxJn59wA6gXGD+qcMsPb3BJrQqCyephI
         9DDG26ipRGw3r885UApb7tjYsqu0NZ/Qq5naBUb98ufFzFgHztdPIXrOk8BaadiZM/eT
         SXH9Voj+f6/GGEr2k1bGz50hqKXzIIHlluuBjzVSag+OkxlRqyTD1RMnOqZzmDRwUKgD
         6Wo+MuCpWltxB/ZCf/LJgfwNiMA2Gfn/LB1BXesWYUTTEbiS1953/re5pD7LFfFBtRIr
         gvQXCD0ZguWOwPWfT8Li/svCfytqonDT2GsPeZSrPE9JTaLrOYEYjtUj4pKN9CHE8HPa
         /o6A==
X-Gm-Message-State: AIkVDXKOIjF0wxicev/KR6ksgtHxVulDwppqBQr++1zEr3ZUzScpknRAQ30QjKHcVuOTzA==
X-Received: by 10.98.30.4 with SMTP id e4mr9098514pfe.19.1486025465528;
        Thu, 02 Feb 2017 00:51:05 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id s136sm56509362pgc.38.2017.02.02.00.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2017 00:51:04 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 02 Feb 2017 15:50:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/11] worktree move: refuse to move worktrees with submodules
Date:   Thu,  2 Feb 2017 15:50:06 +0700
Message-Id: <20170202085007.21418-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170202085007.21418-1-pclouds@gmail.com>
References: <20170202085007.21418-1-pclouds@gmail.com>
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
index 900b68bb5d..6c58d620ce 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -525,6 +525,27 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 	return ret;
 }
 
+static void validate_no_submodules(const struct worktree *wt)
+{
+	struct index_state istate = { NULL };
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
2.11.0.157.gd943d85

