Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28351207B3
	for <e@80x24.org>; Fri,  5 May 2017 19:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755970AbdEETys (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 15:54:48 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34751 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755597AbdEETx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 15:53:59 -0400
Received: by mail-pf0-f177.google.com with SMTP id e64so7113877pfd.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 12:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5ndEUZ6RzDEVnDVzYBpJ7KivvG1Ri717H6F/QBnw1FU=;
        b=nEd84lR1XO3vUjOPqqax9HKxM8oCo8UI0ntW3Ul2Ucd1JcuTe41eh2sSBQcrGzSSgS
         yvOK509AR4Ebg47I4F8v1oPF6xh2gAtB5JOGgBflzLdQuAxZtDPClHDtigtCgiVV/g7x
         IDtMY6rv7YI6UvfW2R1tNImDSzW8kHtFJl7BTSkEgylaw1NvBZdckO9XtbtmnzHCuKnq
         uA4+aHakytWWJBHMCTpBsNxX+t6iGDKpNNLLx6cdkwlkt8jDAwEQTffCvVdPy6vYlsQT
         1IglAvS8V2GpZiF9myJAMpbvb+opYNGEFoyc8re3L1SA6xXqmkK2oXfmoebfmHUTSwxZ
         qOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5ndEUZ6RzDEVnDVzYBpJ7KivvG1Ri717H6F/QBnw1FU=;
        b=HXHg+/9lEc3Wy3dfOZf+mJC7YaxZPTmoE5D9MYi/unKWM6gFwA3QnIOcX/tWvWdT49
         Tout3BLBsR1wfI25UvZrICbe+ZUAMsCl4bIdUSddXkokCI1dEksw/NO8bGGNVAz3eCPu
         vbqEUAliR+ML/bwl6NFfy57mwe8WaUX2kNCEuIQUuFSLn5Ykx1Zhpy6zY4DrSJFFaHLJ
         X0L1sscPU18iu86AUaz8ecGsBFjtoO8ltgBCCsArxxLIB7CKDxppH7NRv62MPJs2l+q6
         U7NWcy3r4vWka4BllemFE3K1g/0FRFS/CmwM1wbABqBRBT0ImMsNgJR/9z8LzqBsK/GR
         smTg==
X-Gm-Message-State: AN3rC/7dXscS42IqhISxVbv2tTpnw+XB2ZTbzRaH0htlfV9/wWanrmLj
        OYK4NS0AcoLXEADg
X-Received: by 10.99.63.132 with SMTP id m126mr5267939pga.166.1494014038379;
        Fri, 05 May 2017 12:53:58 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id r86sm12395967pfb.24.2017.05.05.12.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 12:53:57 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 09/14] dir: convert prep_exclude to take an index
Date:   Fri,  5 May 2017 12:53:29 -0700
Message-Id: <20170505195334.121856-10-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170505195334.121856-1-bmwill@google.com>
References: <20170505195334.121856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 dir.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index b86d02ff9..50b5e720e 100644
--- a/dir.c
+++ b/dir.c
@@ -1046,7 +1046,9 @@ static struct exclude *last_exclude_matching_from_lists(struct dir_struct *dir,
  * Loads the per-directory exclude list for the substring of base
  * which has a char length of baselen.
  */
-static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
+static void prep_exclude(struct dir_struct *dir,
+			 struct index_state *istate,
+			 const char *base, int baselen)
 {
 	struct exclude_list_group *group;
 	struct exclude_list *el;
@@ -1125,7 +1127,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 			int dt = DT_DIR;
 			dir->basebuf.buf[stk->baselen - 1] = 0;
 			dir->exclude = last_exclude_matching_from_lists(dir,
-									&the_index,
+									istate,
 				dir->basebuf.buf, stk->baselen - 1,
 				dir->basebuf.buf + current, &dt);
 			dir->basebuf.buf[stk->baselen - 1] = '/';
@@ -1167,7 +1169,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 			strbuf_addbuf(&sb, &dir->basebuf);
 			strbuf_addstr(&sb, dir->exclude_per_dir);
 			el->src = strbuf_detach(&sb, NULL);
-			add_excludes(el->src, el->src, stk->baselen, el, &the_index,
+			add_excludes(el->src, el->src, stk->baselen, el, istate,
 				     untracked ? &sha1_stat : NULL);
 		}
 		/*
@@ -1209,7 +1211,7 @@ struct exclude *last_exclude_matching(struct dir_struct *dir,
 	const char *basename = strrchr(pathname, '/');
 	basename = (basename) ? basename+1 : pathname;
 
-	prep_exclude(dir, pathname, basename-pathname);
+	prep_exclude(dir, &the_index, pathname, basename-pathname);
 
 	if (dir->exclude)
 		return dir->exclude;
@@ -1695,10 +1697,10 @@ static int valid_cached_dir(struct dir_struct *dir,
 	 */
 	if (path->len && path->buf[path->len - 1] != '/') {
 		strbuf_addch(path, '/');
-		prep_exclude(dir, path->buf, path->len);
+		prep_exclude(dir, &the_index, path->buf, path->len);
 		strbuf_setlen(path, path->len - 1);
 	} else
-		prep_exclude(dir, path->buf, path->len);
+		prep_exclude(dir, &the_index, path->buf, path->len);
 
 	/* hopefully prep_exclude() haven't invalidated this entry... */
 	return untracked->valid;
-- 
2.13.0.rc1.294.g07d810a77f-goog

