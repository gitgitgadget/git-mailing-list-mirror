Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F3BE20188
	for <e@80x24.org>; Sun, 14 May 2017 03:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758888AbdENDQw (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:16:52 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34013 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758802AbdENDQb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:31 -0400
Received: by mail-oi0-f68.google.com with SMTP id w10so14326045oif.1
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CRSxebPLcQmKceTkrsvUDvZlw93yTRUrNKrUaKDXaxo=;
        b=RShSPIFEMpPwXxR2ea22Tin0y1jMEq9HXlZ0toLpa1m3mjzD25Jw0nGuptqP3VZ1tj
         /1AOdI6UqB0AU1rEAU0J2RuwU8f7nwgXYYeWID3Z3J2p9vAQfSkh5F50s78T6v702GId
         HheVzu9pSO2aUNr9Rbdmiuogalmff+zuCI6O+ggbulfmDSYvPc9raON5kbFxEsgGmNFT
         xc5xGdYd+tT5lSHpv7v2nKWZl3pkK7vQq1Ag3gwTSm89ekis287vCaz9oKKCYs75OGcp
         cv9Sqv+WTNc1pnVw9Ut7WOyC8W5lTBhmqLQ6ATBiCknESPDpoS5B0EVjQ76SN2C6sUlx
         JVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CRSxebPLcQmKceTkrsvUDvZlw93yTRUrNKrUaKDXaxo=;
        b=FFNwuiATp+WcBmNv21MShlQ0IYHa3N+NsVfyXDwOktQM6gMoJ0KeEeETyZMCguXYQg
         yquv8i0XC21v5dHruoHtsQv+SWu4Tj1D/oOvXtIutK1Frm+RhjBMqlAwgZSXh8Ee/86D
         +P0KpjPVPa7m1sxFj/rkkvfJv/CHwIdEYzxnUQFzUk1svI1bOU+F+m1plN1Xc21uSa1a
         cF+Rpv+SebaqZq9TXwGZGUpDH61wr/0Ed57A+BdyWO2xNhQC4ohS2qSaKuM5mB9kxpCs
         Vl4c+fwdeTUUwX8FBvzqOU2v25kEcjEAZc0ekbkj6w9IcglWclFYSbJwUpNHLOGfJP9b
         ZtLA==
X-Gm-Message-State: AODbwcDlLK7H0EDWiJh366Ciq2cTdyF7VMQOy4p+BsOO4MsO6UK0hh9L
        y+nV+a9HiE6BtQ==
X-Received: by 10.157.4.238 with SMTP id 101mr6195881otm.53.1494731785242;
        Sat, 13 May 2017 20:16:25 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:24 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 15/22] blame: wrap blame_sort and compare_blame_final
Date:   Sat, 13 May 2017 22:15:06 -0500
Message-Id: <20170514031513.9042-16-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new method's interface is marginally cleaner than blame_sort, and
will avoid the need to expose the compare_blame_final method.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index a40f743..94c9ded 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -249,12 +249,6 @@ static int compare_blame_suspect(const void *p1, const void *p2)
 	return s1->s_lno > s2->s_lno ? 1 : -1;
 }
 
-static struct blame_entry *blame_sort(struct blame_entry *head,
-				      int (*compare_fn)(const void *, const void *))
-{
-	return llist_mergesort (head, get_next_blame, set_next_blame, compare_fn);
-}
-
 static int compare_commits_by_reverse_commit_date(const void *a,
 						  const void *b,
 						  void *c)
@@ -262,6 +256,12 @@ static int compare_commits_by_reverse_commit_date(const void *a,
 	return -compare_commits_by_commit_date(a, b, c);
 }
 
+static void blame_sort_final(struct blame_scoreboard *sb)
+{
+	sb->ent = llist_mergesort(sb->ent, get_next_blame, set_next_blame,
+				  compare_blame_final);
+}
+
 static void sanity_check_refcnt(struct blame_scoreboard *);
 
 /*
@@ -1244,7 +1244,8 @@ static int num_scapegoats(struct rev_info *revs, struct commit *commit, int reve
  */
 static void distribute_blame(struct blame_scoreboard *sb, struct blame_entry *blamed)
 {
-	blamed = blame_sort(blamed, compare_blame_suspect);
+	blamed = llist_mergesort(blamed, get_next_blame, set_next_blame,
+				 compare_blame_suspect);
 	while (blamed)
 	{
 		struct blame_origin *porigin = blamed->suspect;
@@ -2788,7 +2789,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	if (incremental)
 		return 0;
 
-	sb.ent = blame_sort(sb.ent, compare_blame_final);
+	blame_sort_final(&sb);
 
 	coalesce(&sb);
 
-- 
2.9.3

