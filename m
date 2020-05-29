Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0B8C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9AFD207BC
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rfQGgiWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgE2Wae (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 18:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbgE2Wae (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 18:30:34 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81E3C08C5C9
        for <git@vger.kernel.org>; Fri, 29 May 2020 15:30:32 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id p7so3068178qkf.21
        for <git@vger.kernel.org>; Fri, 29 May 2020 15:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=F6251SzSw+rgrnELuVLDTRIs3IvJP+BbDVHu+vBtevk=;
        b=rfQGgiWX5ZzfV0S/LuIae2YzP4xVz59hgmJn0I/3NRGTNAKwUrUhA91OkgIWpOd0TP
         Ra6qoTS1KzhBGGK6q38Ea25e1Ruh6PTZTEL4RJ6e9MOy6kSrEjHysUI+bRx1a4EWAgES
         xSM/2ekhqNMMa7Yth8JY9oAKgXQUAmpBcj0+CKhk1G+GGjSRZjD0mj0a4+nkazrlOjEm
         mTlZ7sfTcFDPnls6PGoENrSCj66U2bNd0brx7H9TWRqzbj9tfnKcDWJQaHPfUkrN2X1i
         SG/rFl2WMNIs+vOGzmDKztBVbCGz1l1AifZwObOVy/3g744tfEU33jls0Sr2yePLWVGO
         Lhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F6251SzSw+rgrnELuVLDTRIs3IvJP+BbDVHu+vBtevk=;
        b=rs8J3F6H6pAN5xwh/P4Q+YRUkAQ04Oxi4iWmgDw1vu+jjzrKxLbv1UV3sKNqxAuRmK
         qsyY85inENj1Xmz6f6GTJMsLCooGuflRLCycEbl/j9hnoSFpW5k9YN+NF1PUDcNib2xt
         wd0DnsA9TqO9UGh15Y7eSIo3PCLwQCPLli5W3QDFYbj7xd3UxCj6wMG4OQf1q5BlZb5L
         jj0LUDVLtDHOwmAYgiTghwFz+TNLOXeADg6A25/AL+jg1RJAyIrpidUAkgn6DLigUD7Y
         TwYfWHIpZa2+tMuHwu5RuZCF6A8yAFzvomTB9shkgWq0RDPv1YYk6seZ7rgVWYB7MCqD
         c1uw==
X-Gm-Message-State: AOAM53306hq8BWlmCovadAE+KJj6IKgYKh83oIsd64v7CqPHWnOOOoZG
        IJgqcigczueMEBqx9svBghn2zrDoOkQP3B9mEPuYzdVcxMajZj+FnxfCEHDCUeD+N8a1ESZA98Z
        y2nFAYTKJJbB+VWZPwZLeQn3J4djO+deTwZtRCDhFwloALR+sKz+p7dB3Uyuv4vcb9+MGpQNqkf
        n2
X-Google-Smtp-Source: ABdhPJwDC8J+PeMepCNhungRtakbQZwK4i6fKyA6zGtoXbjXuZ1N70oQwDqXAkyhFWpGdreRRob1j6jyusXlKCinAS3H
X-Received: by 2002:a0c:a284:: with SMTP id g4mr10392154qva.243.1590791431847;
 Fri, 29 May 2020 15:30:31 -0700 (PDT)
Date:   Fri, 29 May 2020 15:30:13 -0700
In-Reply-To: <cover.1590789428.git.jonathantanmy@google.com>
Message-Id: <4d17d560b87746acfd62ff785cc22c09600d4e65.1590789428.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1590789428.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH 1/8] http: use --stdin when getting dumb HTTP pack
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When Git fetches a pack using dumb HTTP, it reuses the server's name for
the packfile (which incorporates a hash), which is different from the
behavior of fetch-pack and receive-pack.

A subsequent patch will allow downloading packs over HTTP(S) as part of
a fetch. These downloads will not necessarily be from a Git repository,
and thus may not have a hash as part of its name.

Thus, teach http to pass --stdin to index-pack, so that we have no
reliance on the server's name for the packfile.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 http.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/http.c b/http.c
index 4882c9f5b2..130e9d6259 100644
--- a/http.c
+++ b/http.c
@@ -2276,9 +2276,9 @@ int finish_http_pack_request(struct http_pack_request *preq)
 {
 	struct packed_git **lst;
 	struct packed_git *p = preq->target;
-	char *tmp_idx;
-	size_t len;
 	struct child_process ip = CHILD_PROCESS_INIT;
+	int tmpfile_fd;
+	int ret = 0;
 
 	close_pack_index(p);
 
@@ -2290,35 +2290,24 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		lst = &((*lst)->next);
 	*lst = (*lst)->next;
 
-	if (!strip_suffix(preq->tmpfile.buf, ".pack.temp", &len))
-		BUG("pack tmpfile does not end in .pack.temp?");
-	tmp_idx = xstrfmt("%.*s.idx.temp", (int)len, preq->tmpfile.buf);
+	tmpfile_fd = xopen(preq->tmpfile.buf, O_RDONLY);
 
 	argv_array_push(&ip.args, "index-pack");
-	argv_array_pushl(&ip.args, "-o", tmp_idx, NULL);
-	argv_array_push(&ip.args, preq->tmpfile.buf);
+	argv_array_push(&ip.args, "--stdin");
 	ip.git_cmd = 1;
-	ip.no_stdin = 1;
+	ip.in = tmpfile_fd;
 	ip.no_stdout = 1;
 
 	if (run_command(&ip)) {
-		unlink(preq->tmpfile.buf);
-		unlink(tmp_idx);
-		free(tmp_idx);
-		return -1;
-	}
-
-	unlink(sha1_pack_index_name(p->hash));
-
-	if (finalize_object_file(preq->tmpfile.buf, sha1_pack_name(p->hash))
-	 || finalize_object_file(tmp_idx, sha1_pack_index_name(p->hash))) {
-		free(tmp_idx);
-		return -1;
+		ret = -1;
+		goto cleanup;
 	}
 
 	install_packed_git(the_repository, p);
-	free(tmp_idx);
-	return 0;
+cleanup:
+	close(tmpfile_fd);
+	unlink(preq->tmpfile.buf);
+	return ret;
 }
 
 struct http_pack_request *new_http_pack_request(
-- 
2.27.0.rc0.183.gde8f92d652-goog

