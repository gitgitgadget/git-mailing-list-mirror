Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B9A20899
	for <e@80x24.org>; Wed, 23 Aug 2017 12:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754010AbdHWMhc (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 08:37:32 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37410 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbdHWMha (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 08:37:30 -0400
Received: by mail-pf0-f195.google.com with SMTP id r62so1344792pfj.4
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 05:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KUTAfKqG7HMAGHQS4/iRBUZ3yL7bCmzGtY7jMdFT184=;
        b=ec7ydhZeoOeJGYaXqToAKvBh+pt25NeUQifEl01GCs7zp7gRQnc96jhA6+tBQZASjv
         w0irVivj4wI0Ymu/k1Ek+NiWqFUkCpeXFUGwugkxLx4uAHk+t4ellqNUC8TZVPebjP1D
         is4+Q8oqhg4951G8Zx3TC6jHNcW7rxPthlxNYmrJ70VAU8z67yrHPgE+3Toq5U3iqGWo
         1Co2d/06NZkBsP2EeJJ1Y2HuYACQIjHw0J+aC6zIwqclqduStJMRYZDfR4yk1rSCx9yx
         XXp4mqytjzGHYwHR2FoxS1FHt7rS4JwECr/tDcm+GswiRBj4ow/j4L2Q28Op5i/66rnc
         4AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KUTAfKqG7HMAGHQS4/iRBUZ3yL7bCmzGtY7jMdFT184=;
        b=t+UDn33VL9symxpTHreyZ9NmC48QxVh2rrqHQo4FZeoVpBXjTq9Fn07PImbbSVzvMi
         UfJKYFZ/3BoQnuCQkH8gTuxjbs4Nlh5P/AXs5PYNdnCgXOQhwDowl4XjDQruajg6I6+g
         Gb+UBKnmPOnUyHMcv5EdOInXHaslF4JzG9eADs9jDpRQXdCh/wPoek4DSMk7f9VygHfQ
         j9jScU8tpFh9/sw3WHYnSK2+79iIuQDnINB6r+cCZLlbfqdbsQ2+4An9kHaCk/Yi33AO
         UqpAj+RxNxK7riC4/eIYJQxDV5gO/ZAXH5Wee03kdtQTX/yIZTUeDMHkltrKF7BP9p0U
         X2kA==
X-Gm-Message-State: AHYfb5jSrR4PNgwP9+ITCiInG3pYGqLvrdhD3t5JwtIx+mvHRHlYevM4
        koMYVRD+D3lDfwKr
X-Received: by 10.84.130.76 with SMTP id 70mr2983418plc.138.1503491849655;
        Wed, 23 Aug 2017 05:37:29 -0700 (PDT)
Received: from ash ([115.72.183.215])
        by smtp.gmail.com with ESMTPSA id a86sm3223466pfe.181.2017.08.23.05.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Aug 2017 05:37:28 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 23 Aug 2017 19:37:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 01/16] revision.h: new flag in struct rev_info wrt. worktree-related refs
Date:   Wed, 23 Aug 2017 19:36:49 +0700
Message-Id: <20170823123704.16518-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170823123704.16518-1-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.h b/revision.h
index bc18487d6f..3a3d3e2cf8 100644
--- a/revision.h
+++ b/revision.h
@@ -96,6 +96,7 @@ struct rev_info {
 			topo_order:1,
 			simplify_merges:1,
 			simplify_by_decoration:1,
+			single_worktree:1,
 			tag_objects:1,
 			tree_objects:1,
 			blob_objects:1,
-- 
2.11.0.157.gd943d85

