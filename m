Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0324A20D1B
	for <e@80x24.org>; Tue, 20 Jun 2017 19:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbdFTTU0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:20:26 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33300 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdFTTUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:20:25 -0400
Received: by mail-pf0-f179.google.com with SMTP id 83so73770361pfr.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/ibPi3xck5U4Gn+z+zk/BfG3/veSN9XvN66F/JCpwJ8=;
        b=i084YUgVXQfIpRvez6waq0J2vaEUGinSYakLteoHOyUWlfMzz8irpwusuF/p/Tt8u2
         ptxl80xRkegZ6pPQHNW+aY40QS+hX3QNfTK04Pfnu7O2HEI85V9fnUT4zfDadDXKAOBi
         zzOcXPKwRwh3li4MlHiDso1UF2W5zquVj9mODMt5y2J4pAGtog/1968xe8VbCBzmLDOS
         j5UrjiOJrOSR07Ozmm2Kk47UvZGvxypR5jeyBm5htTHskEYINfeMZtLXg3NOB76cgBsu
         b/OImFYenVLlef5s4DgGrAyA4zcJeesNXQ+y8azQNX6ApfFMyrlyYYvRBxyBZavTc67e
         R7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/ibPi3xck5U4Gn+z+zk/BfG3/veSN9XvN66F/JCpwJ8=;
        b=aZ2wXxkSaQGMRWfskvG0oIeu7JiU0uaTyTrpgOSsUcNpsf2RP9CfafQ435+jfVpyhn
         SZAkVqLD/A7QTdGmpGK+94rujcMH+J2/1EKPsyB8mkBaChK6xJ5v+bM8lAG5EV/nz4tR
         oLPfXiP6mjUiTjjrQ0EtMYFKzsh4tkCEyUub9TI1xvbC7NwZDHw5GTquqj6c7uYHGLga
         KShUEf2HHsP412ZQHbMJwoMZaXGfrHMSQFl/ECxbVJqoa3jPnx8OM4pvJbgjNDQwC/pd
         Fvcrpd0+TX+EOlFq66nQgc3SFZci+nWYiZK2Vfs96/yCnTH1OEtH2H7McSwEDNabX3YT
         pVqg==
X-Gm-Message-State: AKS2vOwqhS1ymrTdsjjRV7G8nOjd2FoW9nFexBETAYNaXrs5D+CjgcHc
        5IBxhzFssDcEI4FUhkFEXg==
X-Received: by 10.84.135.129 with SMTP id 1mr37196982plj.12.1497986423984;
        Tue, 20 Jun 2017 12:20:23 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t6sm18680500pgs.33.2017.06.20.12.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 12:20:22 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 08/20] path: always pass in commondir to update_common_dir
Date:   Tue, 20 Jun 2017 12:19:39 -0700
Message-Id: <20170620191951.84791-9-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <20170620191951.84791-1-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
 <20170620191951.84791-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of passing in 'NULL' and having 'update_common_dir()' query for
the commondir, have the callers of 'update_common_dir()' be responsible
for providing the commondir.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 path.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/path.c b/path.c
index 41c861c96..2434921d8 100644
--- a/path.c
+++ b/path.c
@@ -345,8 +345,6 @@ static void update_common_dir(struct strbuf *buf, int git_dir_len,
 {
 	char *base = buf->buf + git_dir_len;
 	init_common_trie();
-	if (!common_dir)
-		common_dir = get_git_common_dir();
 	if (trie_find(&common_trie, base, check_common, NULL) > 0)
 		replace_dir(buf, git_dir_len, common_dir);
 }
@@ -387,7 +385,7 @@ static void adjust_git_path(struct strbuf *buf, int git_dir_len)
 	else if (git_hooks_path && dir_prefix(base, "hooks"))
 		replace_dir(buf, git_dir_len + 5, git_hooks_path);
 	else if (the_repository->different_commondir)
-		update_common_dir(buf, git_dir_len, NULL);
+		update_common_dir(buf, git_dir_len, get_git_common_dir());
 }
 
 static void do_git_path(const struct worktree *wt, struct strbuf *buf,
-- 
2.13.1.611.g7e3b11ae1-goog

