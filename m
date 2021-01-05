Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB83C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184B322D5B
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbhAET0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbhAET0l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:26:41 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F77C06179E
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:24:50 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o19so1142119lfo.1
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yNQ63wqyU19asx04oRrhU7bk1AWqHAd66DS/wbSJuF0=;
        b=ErnpkDEPWqSjL6itGnpvxINFGfaNf6U/Z8I8ASJMZvc/1gN1Ii7usrLDDo2dw7ok66
         S5BO2FuFoiwQgfXVt4djXC5Q8Fg0XuI3Ipt7KU0AgzS2mXqGehreKi/Pgi4p0UPVw1jh
         k1l1diIqbxNanqINDTf4T4gpHTCRSI67u/emmr75Zq73p2+o9FcWqGPP5P/25+f/EUBP
         pyeFrMvKT7ruhVpGuT0CAPPY+nyl4z6uSpjd2iXLBXiMJsj4MEBacjke/d+ylhrk9gAH
         tCzQ0lBKR8FE7MsOa1fwkizVYdtSnptoL1W7xbzB3XAKjvOwVFqSNHMtCfuJJlwfQ/mL
         TbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNQ63wqyU19asx04oRrhU7bk1AWqHAd66DS/wbSJuF0=;
        b=spqDvFGekiJWLmPT/7K2jSzkGNoU/S7jHRE8efSx8/NGOcKCZ1FTw6XK3ymExZC+tR
         JbvRbiZyu5k/2JE9NjTFhgh5G2jg/w7Xm21SStNE+F+fi5CbS0EAxxqmVNYPgEAV8Wq5
         jtBQEB8mljrcXgYJTDDYZltGy+DXkBlLlEEGsoI5DUZMI9Je9uu/oJszJZzzFnwGDVIV
         s2xAcSNMW/ymyWdAPid/AXhVQJt2cB0dG3zQfu+F89auzKMswgm3Tm3bn8U5Nw2SORc+
         fTCyesS9QnzWj9Rt39g6D7Bvj1QHF6U6kNDCiEsWKfSYWVGksPGdMaxLSmkLVZwyCq8H
         Ofhg==
X-Gm-Message-State: AOAM5338TdTQOn2TdQXRkkNpU2zYtawbn8HsA3GdFRA7+qQTsrmXXZpA
        pxs48C15cuxg+4fPOMQGsEV3RmQGM5U=
X-Google-Smtp-Source: ABdhPJz9hCC2Qkz4fBlGI49w7oiC1mj4fK2OuqTuk/F5gPqgBxPitAWk/w/FJY0PQ7o77LRcTmcZow==
X-Received: by 2002:a19:5041:: with SMTP id z1mr370478lfj.77.1609874688395;
        Tue, 05 Jan 2021 11:24:48 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id h1sm9116lfc.121.2021.01.05.11.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:24:47 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 5/5] read-cache: try not to peek into `struct {lock_,temp}file`
Date:   Tue,  5 Jan 2021 20:23:50 +0100
Message-Id: <bb2327c7dca20fa563b18a9ec74180d7c595ca24.1609874026.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609874026.git.martin.agren@gmail.com>
References: <cover.1609874026.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to the previous commits, try to avoid peeking into the `struct
lock_file`. We also have some `struct tempfile`s -- let's avoid looking
into those as well.

Note that `do_write_index()` takes a tempfile and that when we call it,
we either have a tempfile which we can easily hand down, or we have a
lock file, from which we need to somehow obtain the internal tempfile.
So we need to leave that one instance of peeking-into. Nevertheless,
this commit leaves us not relying on exactly how the path of the
tempfile / lock file is stored internally.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 read-cache.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index ecf6f68994..29144cf879 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3014,10 +3014,10 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	if (ce_flush(&c, newfd, istate->oid.hash))
 		return -1;
 	if (close_tempfile_gently(tempfile)) {
-		error(_("could not close '%s'"), tempfile->filename.buf);
+		error(_("could not close '%s'"), get_tempfile_path(tempfile));
 		return -1;
 	}
-	if (stat(tempfile->filename.buf, &st))
+	if (stat(get_tempfile_path(tempfile), &st))
 		return -1;
 	istate->timestamp.sec = (unsigned int)st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
@@ -3058,10 +3058,10 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	 * that is associated with the given "istate".
 	 */
 	trace2_region_enter_printf("index", "do_write_index", the_repository,
-				   "%s", lock->tempfile->filename.buf);
+				   "%s", get_lock_file_path(lock));
 	ret = do_write_index(istate, lock->tempfile, 0);
 	trace2_region_leave_printf("index", "do_write_index", the_repository,
-				   "%s", lock->tempfile->filename.buf);
+				   "%s", get_lock_file_path(lock));
 
 	if (ret)
 		return ret;
@@ -3158,10 +3158,10 @@ static int write_shared_index(struct index_state *istate,
 	move_cache_to_base_index(istate);
 
 	trace2_region_enter_printf("index", "shared/do_write_index",
-				   the_repository, "%s", (*temp)->filename.buf);
+				   the_repository, "%s", get_tempfile_path(*temp));
 	ret = do_write_index(si->base, *temp, 1);
 	trace2_region_leave_printf("index", "shared/do_write_index",
-				   the_repository, "%s", (*temp)->filename.buf);
+				   the_repository, "%s", get_tempfile_path(*temp));
 
 	if (ret)
 		return ret;
-- 
2.30.0

