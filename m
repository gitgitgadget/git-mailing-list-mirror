Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36B2320281
	for <e@80x24.org>; Wed, 24 May 2017 05:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969164AbdEXFQw (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:16:52 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33648 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969157AbdEXFQt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:49 -0400
Received: by mail-oi0-f68.google.com with SMTP id h4so31066966oib.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KcfzzN6kVtv6EWYJd5uhRPHKcSdMZbjmilJeznV+0GY=;
        b=Z/x+akajgaOHMX77iw+S8hvaOO8aZ+rHwLMjlNVrCaGDB7HVE8wiZbYEjYu9Fs3cGS
         PpuZcMkX6Z4gtVbwuEZqmQqLwc11NDinG+gWOhbkUGp0Fu+DCAGzuitp/sMKaokONK8x
         M5ou+62DlMQ7DZj/lLsCRFJPZE/ULdcF4e/0n2NrvRHLy6jVMfQYbunesWIiKN70vmr0
         ZAI0+uCQMtd5wrg5RK5AbekoEhteUE8WX4yrRo3aDdJIrW1SDmZlNbZTp43daKUPne2y
         7mj6eeB7Fs6aANrYSrAhsXSgAq3yTBggZWCTylwr4MqzVMWgXmbph3W1vZS2iSUa9BSc
         ICcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KcfzzN6kVtv6EWYJd5uhRPHKcSdMZbjmilJeznV+0GY=;
        b=e0Gw5OtU9p1CYy1fCyPt9ry+5ZV6FqIkWQ6qAEMKJhTE2RhwTqSsgzc9WCD6a8Z7Y1
         jqEzAJt335w/ME+TLeyUpJSxG748JnPGqi5i9YVhm5MsRv326O16nsM6o9MEBFi6bvzW
         9YNFPsY2UlYAWBPIkS9rj8Sg9JpFUuk8mSup+9EGjkNaCFL27sezQgfZxSdn9mWz7L5d
         11KwRvQjM5MBSPi+vTM6kFa8KVqupjZwLLy8j4l/yC9bJeSZzknf8ynwTliMOZVbPCMZ
         RsOP+4wmyVU/hfNwo3HyRMhGq2eETgka7MefZdqD8WzhD8j3Sxwp9eaKop2wkyt8Krhx
         jAQg==
X-Gm-Message-State: AODbwcDtmIqoUe15Wj4PA1EiIsXnUecXsNTxKAL72IG3t7z7FW9E75W2
        t+Dx38uEhCkHHg==
X-Received: by 10.202.214.18 with SMTP id n18mr17061046oig.27.1495603003596;
        Tue, 23 May 2017 22:16:43 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:42 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 19/29] blame: wrap blame_sort and compare_blame_final
Date:   Wed, 24 May 2017 00:15:27 -0500
Message-Id: <20170524051537.29978-20-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
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
index d05907b..61fd5b4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -328,12 +328,6 @@ static int compare_blame_suspect(const void *p1, const void *p2)
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
@@ -396,6 +390,12 @@ struct blame_scoreboard {
 	void *found_guilty_entry_data;
 };
 
+static void blame_sort_final(struct blame_scoreboard *sb)
+{
+	sb->ent = llist_mergesort(sb->ent, get_next_blame, set_next_blame,
+				  compare_blame_final);
+}
+
 static void sanity_check_refcnt(struct blame_scoreboard *);
 
 /*
@@ -1378,7 +1378,8 @@ static int num_scapegoats(struct rev_info *revs, struct commit *commit, int reve
  */
 static void distribute_blame(struct blame_scoreboard *sb, struct blame_entry *blamed)
 {
-	blamed = blame_sort(blamed, compare_blame_suspect);
+	blamed = llist_mergesort(blamed, get_next_blame, set_next_blame,
+				 compare_blame_suspect);
 	while (blamed)
 	{
 		struct blame_origin *porigin = blamed->suspect;
@@ -2922,7 +2923,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	if (incremental)
 		return 0;
 
-	sb.ent = blame_sort(sb.ent, compare_blame_final);
+	blame_sort_final(&sb);
 
 	blame_coalesce(&sb);
 
-- 
2.9.3

