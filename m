Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCA3C77B7E
	for <git@archiver.kernel.org>; Mon, 29 May 2023 13:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjE2N2H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 May 2023 09:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjE2N2F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2023 09:28:05 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86C9C7
        for <git@vger.kernel.org>; Mon, 29 May 2023 06:28:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b02fcde49aso10295205ad.0
        for <git@vger.kernel.org>; Mon, 29 May 2023 06:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685366884; x=1687958884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mubWnN3sandBf6cI+N7rTMp+BP2xGdut9ig9hf9bzvc=;
        b=Oe1PXn+eZLWnZmgkc2aEZeXkZZRlFeFU8tkPnQqjRr9sFhEeLQ7iekpYs28a+TKBw+
         QyRqbaHRUfSIQJJuFYl9AKMg/2U6FfdUgFQS9NXhAVTv4th+qepqivDdSSeWPDAzazDH
         I0WLXcIID4yiG17FDW7TnccwbnEvR+TVfNB07lA4kVaxOs/Vy3tLlLcF6UDxy/2Mkrxy
         Of8fF0BjSrqvFIr790HmRE17YIUeeYL+kgnEqjaqjFCOh/GQXkouCGRJ4WwL6YvC/C4n
         fM56khxwRg7ZooMIB4mFDCxrzYJ1Kh2p90ciDVAWe4k3QherQ+YAC1ANihh0QCkbxjIu
         e17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685366884; x=1687958884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mubWnN3sandBf6cI+N7rTMp+BP2xGdut9ig9hf9bzvc=;
        b=i5zpJU2ZALuxfyYg021otW3eDIQ/tM7qVfF88CARtGt9lX+tFEFcasMEwcmyFjHKBn
         +E8lTcJ+shTwJKXzKXPNCmN/lbeppTiwYX8JDJJnRBdrlsCfADQkchESUo6Cc78gFQ2/
         fuG0ZpF7E2U3Fj4WBcu4Rwz+fCNpjI3rwIqGoIVDTWLCLsy8m650TEjQnoUDQQXGBzWH
         1g1aE5V9DdL/kRjl7BVqtk0FBbj9tfrUv+5b+5kbnsJFwIitc/jNt2pVLTo0BMWuVCLI
         zqNOePXBCovqt+CFPisaEJ+e0vtBWv6lS4IPRB1U7HEivD6qD1XhwYYq8+Nm9NE1s2yh
         dx7Q==
X-Gm-Message-State: AC+VfDyjekULxt1YQTwx3OligiHX8loO6aN1RRJAY7WXXZqyAVm6K28b
        g1mzUJk/GYXgkirpEJQk83K2YLIb8OeCg7Mr
X-Google-Smtp-Source: ACHHUZ5qcF/VDeJvy20LfcCLrG7UEenRTsLN2pCnx5emlaee7ODBdu1MnZvMrg+sPTRTB1j1Q7iNlg==
X-Received: by 2002:a17:902:bd82:b0:1b0:3cda:6392 with SMTP id q2-20020a170902bd8200b001b03cda6392mr3572501pls.13.1685366883894;
        Mon, 29 May 2023 06:28:03 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.48])
        by smtp.gmail.com with ESMTPSA id p23-20020a170902a41700b001aaecc0b6ffsm8214628plq.160.2023.05.29.06.28.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 May 2023 06:28:03 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     tenglong.tl@alibaba-inc.com, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v1 1/1] surround %s with quotes when failed to lookup commit
Date:   Mon, 29 May 2023 21:27:56 +0800
Message-ID: <1f7c62a8870433792076fae30d6c4dc4b61a00d8.1685366301.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.41.0.rc2
In-Reply-To: <cover.1685366301.git.dyroneteng@gmail.com>
References: <cover.1685366301.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

The output maybe become confused to recognize if the user
accidentally mistook an extra opening space, like:

   $git commit --fixup=" 6d6360b67e99c2fd82d64619c971fdede98ee74b"
   fatal: could not lookup commit  6d6360b67e99c2fd82d64619c971fdede98ee74b

and it will be better if we surround the %s specifier with single quotes.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/commit.c     | 6 +++---
 builtin/merge-tree.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e67c4be2..9ab57ea1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -763,7 +763,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			struct commit *c;
 			c = lookup_commit_reference_by_name(squash_message);
 			if (!c)
-				die(_("could not lookup commit %s"), squash_message);
+				die(_("could not lookup commit '%s'"), squash_message);
 			ctx.output_encoding = get_commit_output_encoding();
 			repo_format_commit_message(the_repository, c,
 						   "squash! %s\n\n", &sb,
@@ -798,7 +798,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		char *fmt;
 		commit = lookup_commit_reference_by_name(fixup_commit);
 		if (!commit)
-			die(_("could not lookup commit %s"), fixup_commit);
+			die(_("could not lookup commit '%s'"), fixup_commit);
 		ctx.output_encoding = get_commit_output_encoding();
 		fmt = xstrfmt("%s! %%s\n\n", fixup_prefix);
 		repo_format_commit_message(the_repository, commit, fmt, &sb,
@@ -1189,7 +1189,7 @@ static const char *read_commit_message(const char *name)
 
 	commit = lookup_commit_reference_by_name(name);
 	if (!commit)
-		die(_("could not lookup commit %s"), name);
+		die(_("could not lookup commit '%s'"), name);
 	out_enc = get_commit_output_encoding();
 	return repo_logmsg_reencode(the_repository, commit, NULL, out_enc);
 }
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index b8f8a8b5..4325897a 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -448,7 +448,7 @@ static int real_merge(struct merge_tree_options *o,
 
 		base_commit = lookup_commit_reference_by_name(merge_base);
 		if (!base_commit)
-			die(_("could not lookup commit %s"), merge_base);
+			die(_("could not lookup commit '%s'"), merge_base);
 
 		opt.ancestor = merge_base;
 		base_tree = repo_get_commit_tree(the_repository, base_commit);
-- 
2.41.0.rc2

