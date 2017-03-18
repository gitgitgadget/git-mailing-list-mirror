Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AF3120323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbdCRKMg (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:12:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34114 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbdCRKM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:12:29 -0400
Received: by mail-pf0-f193.google.com with SMTP id o126so11305901pfb.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zYFx18RAUpJAtwU1/z648Siq8YdEKQbbYaGQ4UWkbXI=;
        b=I6JvP4z2vAE+Xlvc1cu9Ep0fThKEXnguTSKQpsfs5SKwsOeUcLQc7rjlmDGN63JxWc
         +7rTTvYJ8qAo8LQjPF21tJ6bsEaQuXvp5YaoRBHyRu2uxzjArs28ax9X/WYRALBOOuel
         RLnnLmIBmvGXR9FtCJW85ao+jIH32tcSvIbRtvuIyZzHiyFM3wDJIZAs/P0OF6FM6Yw5
         zEZOexMSGbKfS7qKAdTiSPY8vuPPYNMHQRSrW1L/5J3qffIK5Oby1nvVbF2+M/VgiTtW
         S2dkkJV2XrYI5IC/rkgmf0ECmN/ywyd3aAl9LIfGD/bI3TPvqLT/OGm91UjRmW0lC42Y
         TBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zYFx18RAUpJAtwU1/z648Siq8YdEKQbbYaGQ4UWkbXI=;
        b=Qsd6fiMrYb5geLccI57hYZXxCxPUhyzDbg1Uh80/iRB1T/tnQiMubrM4a9N9qrGZhq
         LNPE3sr18wFmG7TmyU3LRVYe9yUAYBntsWcTQiR+n85aAOiZ3KjmWptsj1Sq3suWzZNX
         XMpLkbn39MSWsnKJLtYQ2fjIC5elArKYDX0xRb7aaLRwFffGMqlGoEos8mRyYX/1e8aV
         ZO3fKwyzlKtLAJieWdKj7FiIdRvQlW7Vje3TjZTIhjNKBpT5XPmY0R4CttxVE9wcuQJ6
         tI0C9KfyGxmVCh6lhyqPOznSe5KgNsxXtB2SO3JIgyEs7XtPCk+Fo9VINSeackwNtKBW
         EYXw==
X-Gm-Message-State: AFeK/H290cFpe3K1gsfmIlbIW0om98kKzJYg91KkO6yRzBhEMu+aT1oKijS9odD1atgCDg==
X-Received: by 10.99.112.77 with SMTP id a13mr11285811pgn.7.1489831926690;
        Sat, 18 Mar 2017 03:12:06 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id 73sm21851001pfj.31.2017.03.18.03.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 03:12:06 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 17:12:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 01/12] revision.h: new flag in struct rev_info wrt. worktree-related refs
Date:   Sat, 18 Mar 2017 17:11:42 +0700
Message-Id: <20170318101153.6901-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318101153.6901-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
 <20170318101153.6901-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The revision walker can walk through per-worktree refs like HEAD or
SHA-1 references in the index. These currently are from the current
worktree only. This new flag is added to change rev-list behavior in
this regard:

When single_worktree is set, only current worktree is considered. When
it is not set (which is the default), all worktrees are considered.

The default is chosen so because the two big components that rev-list
works with are object database (entirely shared between worktrees) and
refs (mostly shared). It makes sense that default behavior goes per-repo
too instead of per-worktree.

The flag will eventually be exposed as a rev-list argument with
documents. For now it stays internal until the new behavior is fully
implemented.
---
 revision.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.h b/revision.h
index 9fac1a607d..c851b94ad8 100644
--- a/revision.h
+++ b/revision.h
@@ -88,6 +88,7 @@ struct rev_info {
 			topo_order:1,
 			simplify_merges:1,
 			simplify_by_decoration:1,
+			single_worktree:1,
 			tag_objects:1,
 			tree_objects:1,
 			blob_objects:1,
-- 
2.11.0.157.gd943d85

