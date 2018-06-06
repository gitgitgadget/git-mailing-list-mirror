Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D94701F403
	for <e@80x24.org>; Wed,  6 Jun 2018 05:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeFFFCb (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 01:02:31 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42276 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932090AbeFFFC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 01:02:28 -0400
Received: by mail-lf0-f65.google.com with SMTP id v135-v6so7023843lfa.9
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 22:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WD4sRbQbinWKhP9ZQefGGRE3/S6IsiSX0UgIqEtSn5M=;
        b=DbB0lNb1wlQVb7MiABmRXXEKJgxzT+F5onDAaVBCGJUVTFZiBSGRQ+Q0b8Je9gTHf4
         8gAK3/LgdMcxoXHYL0+LGrxcNGoX+C43VLKqtIoo9zzdl8Q2SvOjoF1Ldi8XFRimNNYN
         2UpxInd6DzcbvfK9tIggdJpipZ2BFMCoQZa/Zf+OnwJKadoT4gekvi7DOs2wmlb/ZuYN
         3HvLU270wchjGCJLUv9SnWoa4NY8+RSMzFqvIaFTeArwdJKPIhuwLb07by1Ekq+zccYp
         nnCpv7Flwbox61LY66C5Upv0BoTGmN3JUUqnrVLU+oZp8Og9OuHWiZ/aWAVSoQoR9OGf
         fOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WD4sRbQbinWKhP9ZQefGGRE3/S6IsiSX0UgIqEtSn5M=;
        b=OQbKs15ZVDBvl7fPxi+l+hwktImi6oiYbQAD1jaizved8MAsV1MQ7gVy17r4BdwIrP
         gtOfPKAIVk0hhRTU6fsagBLsjG5sMVa3Pzb4Z2pqVwh0ozvmDnBd6OEpwkt92ezShv3t
         rYzurvkBWguDg6cBkbrqcjHUuz+cpeljejwKTH4U8Rg6mKIabweRtSnbNGFmMXoBmQ66
         ERCSZ75e9W1hlwHzkE+7Vh/ipNl0533JmHVyfpJbGo3zfoPU1z9fZbk5HyFBFV7GK+kU
         FJ02MCzt5lTQs3y2xMzM63iNd+00+v2SItYkRSSmZ13ulmmorqPT5fvHfLY/qL26PAne
         z5HA==
X-Gm-Message-State: APt69E2DjXwnHIRt4ZhpMpGHXhhwo24FMD93VrCkvT7iF9hd3+grcCDq
        EBClQoucOXeE6xE+mzUQeSU=
X-Google-Smtp-Source: ADUXVKLLygyM10UHAuiDgBIovCegT6ZPCT3e5laC9+Y28Q0Mi6ayvkEa/aScMir4QfPkV1n4vxfwCQ==
X-Received: by 2002:a19:ee06:: with SMTP id g6-v6mr818376lfb.77.1528261346771;
        Tue, 05 Jun 2018 22:02:26 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4125798lji.4.2018.06.05.22.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 22:02:26 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 3/5] unpack-trees: don't shadow global var the_index
Date:   Wed,  6 Jun 2018 07:02:05 +0200
Message-Id: <20180606050207.13556-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606050207.13556-1-pclouds@gmail.com>
References: <20180605154334.22613-1-pclouds@gmail.com>
 <20180606050207.13556-1-pclouds@gmail.com>
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

