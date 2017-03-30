Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 733A21FAFB
	for <e@80x24.org>; Thu, 30 Mar 2017 11:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932858AbdC3Lhs (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 07:37:48 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34642 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932268AbdC3Lhq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 07:37:46 -0400
Received: by mail-pg0-f67.google.com with SMTP id o123so9389256pga.1
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 04:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OEiULgxBp98qQ6kkBx4RnZvNKY10lh8VNSGATkw/b9A=;
        b=tjtlxptiiaWJgGxTBLeATu32YPaGdfC+8JZ4oJHyHyWwlOxUUjLr+Vc6IF6MJ7sSNo
         YSjTnkShdiZk8h71vpmx0QxwOqP5sa7OPjZp+NS5mkiyaE/PUo2xVH8W8+sAGF5dS63t
         82OHzMbWOpswOcTTiJ6OIAf6H5QGogZ/86pkNYmlR36aVtI/A1obTo/vNd2fHmQS8GGI
         L2acfteGsq3mTy1cSbewoXPAew0krrJ9ue2ZizSIMw+1Sr740F0o64ZuVDQjuLmQLUMh
         F9zvX/p0XQC3tlgX/PAiHji/gAMPlAXHZFK3fOzaXhNX1WgguTIHqhsUKq6VNJtA0Dbn
         c3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OEiULgxBp98qQ6kkBx4RnZvNKY10lh8VNSGATkw/b9A=;
        b=Tr6Jai2n767N56FJqGhFcz1JYtBojq2jJL8P8clST+x2+HSeq58ghqGutF8gbJ091Y
         LDfYqmq2el0lVEzrGIqQwYOp5sSpYuoYp0VkRExRa7rmOPdc5f5oeXkmrZt63lPceJpZ
         GsbEXwaXumPhew8AsRf92ElHvdJOPs3dVx6432LMU8uP+ebjvXPq+Nh1R3Wyb5o/0Ucz
         FXSgq6EJoGFmz6DmYpJWWGj3wZJIuUgsQt8E8PkeMw5NeoeQOgPyTnAamr5VDL1usL5K
         Ob//aF22Jj7Mt5qAnahemFuFSmIBjbOwnVPr4DGN8x7E98W2lJrI/bznujExY+RLlDnw
         mORA==
X-Gm-Message-State: AFeK/H3wbZaDJ4iDh8BglUKjaRpo1FgJnKqVMSwyKSTkpdgxdxbOJD1WZ6ezfZFzgKTPvg==
X-Received: by 10.99.95.77 with SMTP id t74mr5659194pgb.203.1490873865576;
        Thu, 30 Mar 2017 04:37:45 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id 80sm4102815pfy.67.2017.03.30.04.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Mar 2017 04:37:44 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 30 Mar 2017 18:37:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     tboegi@web.de, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/2] config: resolve symlinks in conditional include's patterns
Date:   Thu, 30 Mar 2017 18:37:23 +0700
Message-Id: <20170330113723.20474-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170330113723.20474-1-pclouds@gmail.com>
References: <20170325130549.GA20618@ash>
 <20170330113723.20474-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$GIT_DIR returned by get_git_dir() is normalized, with all symlinks
resolved (see setup_work_tree function). In order to match paths (or
patterns) against $GIT_DIR char-by-char, they have to be normalized
too. There is a note in config.txt about this, that the user need to
resolve symlinks by themselves if needed.

The problem is, we allow certain path expansion, '~/' and './', for
convenience and can't ask the user to resolve symlinks in these
expansions. Make sure the expanded paths have all symlinks resolved.

PS. The strbuf_realpath(&text, get_git_dir(), 1) is still needed because
get_git_dir() may return relative path.

Noticed-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index f036c721e6..d5ba848b65 100644
--- a/config.c
+++ b/config.c
@@ -177,7 +177,7 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
 	char *expanded;
 	int prefix = 0;
 
-	expanded = expand_user_path(pat->buf, 0);
+	expanded = expand_user_path(pat->buf, 1);
 	if (expanded) {
 		strbuf_reset(pat);
 		strbuf_addstr(pat, expanded);
@@ -191,7 +191,7 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
 			return error(_("relative config include "
 				       "conditionals must come from files"));
 
-		strbuf_add_absolute_path(&path, cf->path);
+		strbuf_realpath(&path, cf->path, 1);
 		slash = find_last_dir_sep(path.buf);
 		if (!slash)
 			die("BUG: how is this possible?");
@@ -213,7 +213,7 @@ static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
 	struct strbuf pattern = STRBUF_INIT;
 	int ret = 0, prefix;
 
-	strbuf_add_absolute_path(&text, get_git_dir());
+	strbuf_realpath(&text, get_git_dir(), 1);
 	strbuf_add(&pattern, cond, cond_len);
 	prefix = prepare_include_condition_pattern(&pattern);
 
-- 
2.11.0.157.gd943d85

