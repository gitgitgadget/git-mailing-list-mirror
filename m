Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56C11F403
	for <e@80x24.org>; Wed,  6 Jun 2018 16:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933562AbeFFQup (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 12:50:45 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40732 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933540AbeFFQuh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 12:50:37 -0400
Received: by mail-lf0-f66.google.com with SMTP id q11-v6so10160949lfc.7
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WD4sRbQbinWKhP9ZQefGGRE3/S6IsiSX0UgIqEtSn5M=;
        b=VQ6QDHMCdV24LFr3f4o2+a56GUhPjvYe/M4zo2ZbceDp4eKEga1RmdU3oHh6o13Ula
         DqnA72NPg+e3Ot51sdhOmfeTrrDve/ECc72PYBvvk1rRxf6MU+EeDQ6CQUtUMsOZ8Q5J
         syU8csZVyGZfFiXKic7eWiDAQuyk5x/P5qUsQMAjsbt+NAXZqU5zJ8VUnF0kT34xjGJv
         UpzPhv8ev0R4H+IUr1CYfFPltzB2zJ/qRDSzJ9BRPLn7XVi/qMIHwJ1MK0f+rgnHM68z
         Xb35NroO1A1bj1uA800d0sGK5pYl7tDO0bnPdhd0fYqP5anDCL0rKfBIeGD0G8c7DWck
         wdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WD4sRbQbinWKhP9ZQefGGRE3/S6IsiSX0UgIqEtSn5M=;
        b=rs+fLOlhNhPV1400579Hf79iINvVRIGmYRd2+05UeAc88SFcOjPuUvoI/JSRZ8cWdc
         Gw9PWr1XfTRXk3f4lFqmq0dy4kI5WVRT9yxKIGpYQYoxX1em3mR5JBtXkQ3HYpg2oCv9
         /QYmHhJQsaaogW/juX9dfrdTcSaMHEeQAZBp49lOyPW7PIlqvvwWDD89Lqdc+5HH8Dtj
         t+WdYMO6kRZ8U17KUWOXaEA/kRKp5kfHzpg/+cI2UrBibEgm+LxgbHHJb6xmNFZJzR8z
         l+ricKyDEsoZ4FoFeeBPO7x8E5zX5z2ITnQnc4380OwihYmOTUkpYFXOCFeZ462LCiU7
         OCFA==
X-Gm-Message-State: APt69E0iKaD2fpL9sni3CCImKKoQflIFumAUwaVJ9zV7HygfQdd9nR6N
        xipVhcj8eajVR0Gw8214GkE=
X-Google-Smtp-Source: ADUXVKLRqSCoUc/8mWGtwuuX1C0CRekCjQhhKxhdkZ3b89fhOwzD11K1NDS/u1BKNEAqYSSSm/A1+g==
X-Received: by 2002:a19:f24e:: with SMTP id d14-v6mr2487009lfk.18.1528303836170;
        Wed, 06 Jun 2018 09:50:36 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y6-v6sm909489ljc.67.2018.06.06.09.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 09:50:35 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 03/23] unpack-trees: don't shadow global var the_index
Date:   Wed,  6 Jun 2018 18:49:56 +0200
Message-Id: <20180606165016.3285-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606165016.3285-1-pclouds@gmail.com>
References: <20180606073933.14755-1-pclouds@gmail.com>
 <20180606165016.3285-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function mark_new_skip_worktree() has an argument named the_index
which is also the name of a global variable. While they have different
types (the global the_index is not a pointer) mistakes can easily
happen and it's also confusing for readers. Rename the function
argument to something other than the_index.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 5d06aa9c98..45fcda3169 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1231,7 +1231,7 @@ static int clear_ce_flags(struct cache_entry **cache, int nr,
  * Set/Clear CE_NEW_SKIP_WORKTREE according to $GIT_DIR/info/sparse-checkout
  */
 static void mark_new_skip_worktree(struct exclude_list *el,
-				   struct index_state *the_index,
+				   struct index_state *istate,
 				   int select_flag, int skip_wt_flag)
 {
 	int i;
@@ -1240,8 +1240,8 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 	 * 1. Pretend the narrowest worktree: only unmerged entries
 	 * are checked out
 	 */
-	for (i = 0; i < the_index->cache_nr; i++) {
-		struct cache_entry *ce = the_index->cache[i];
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
 
 		if (select_flag && !(ce->ce_flags & select_flag))
 			continue;
@@ -1256,8 +1256,7 @@ static void mark_new_skip_worktree(struct exclude_list *el,
 	 * 2. Widen worktree according to sparse-checkout file.
 	 * Matched entries will have skip_wt_flag cleared (i.e. "in")
 	 */
-	clear_ce_flags(the_index->cache, the_index->cache_nr,
-		       select_flag, skip_wt_flag, el);
+	clear_ce_flags(istate->cache, istate->cache_nr, select_flag, skip_wt_flag, el);
 }
 
 static int verify_absent(const struct cache_entry *,
-- 
2.18.0.rc0.333.g22e6ee6cdf

