Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D9971FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 18:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753632AbdFVSoU (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 14:44:20 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36669 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbdFVSoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 14:44:16 -0400
Received: by mail-pg0-f52.google.com with SMTP id u62so11319565pgb.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KH5Y4nb3p1uPeNchabTI0APys+uPP4uwf+ADgOm8y+U=;
        b=uA7B98Gl1r8s4geNj7fc8uzrE61w4hfldPv8XcaYUg7LzTtmVv6CWoO3yleeDHNmbG
         JyIjKQJ6wlYZM7D/Vruz5OAzh1Lwgd7gFwnXEveciHAm1iFrRIMDiowY3HKuirJ0F9Hf
         4bCNeQToteJ0LCWd7rOEfzb20PanBizcn6ibFo6J3JnaTSHgjOhfAHPRlt9u9y/rNyPm
         EdtjSzYk/YMLeeaBctXHKB6N71z3rd5jWMHD3t6qwLpNJbgxUebyy0hc7tIxQaTllwf2
         fPcSr+LnuzmwVcfXlxI+c4gCc9VuZpD7aeiIHRsgQ5BD3OO0IzwE8iX976W+R9B9SI/u
         H+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KH5Y4nb3p1uPeNchabTI0APys+uPP4uwf+ADgOm8y+U=;
        b=XzTuo7/zggLsLzSVx9TPNYNQVaReRf4kSTyVsl9CUTKbJlJwnwnIGBatNd9xdket1N
         nsNbaL8OVL5LTePNxGIgtI07oYE9x1IM4ZVQtyVFdzwXal/Yt6hd6O7SDBm8m0D1NoYT
         HZn9LaUkreAxhR8z+8Wf3VKaV+pBZWxKGph+CHpksIOwJOo7oOUPDtdPvGv0BarsulJ8
         /YMEkvVpBopWKOzFLucpQOMaCCO659Y6HbgadMGn44yaFldc6kf3SHFUclybWPQ2bqZQ
         7f7ZW44Gwv0rpatGGnrdH1NKdrHMziHuFmLTofrNyqC214av+86yg2WFq704eRzwUMVX
         dfKQ==
X-Gm-Message-State: AKS2vOxsNYNVDIIQG6ibGKwZRMB7fDZiqLtXvgAjcQTSQgBGx6DYJR4L
        tMck0mfqjekL188s6ty1zA==
X-Received: by 10.98.144.80 with SMTP id a77mr4060910pfe.148.1498157054514;
        Thu, 22 Jun 2017 11:44:14 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g78sm5222211pfb.122.2017.06.22.11.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 11:44:13 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 08/20] path: always pass in commondir to update_common_dir
Date:   Thu, 22 Jun 2017 11:43:36 -0700
Message-Id: <20170622184348.56497-9-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.704.gde00cce3c-goog
In-Reply-To: <20170622184348.56497-1-bmwill@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
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
2.13.1.704.gde00cce3c-goog

