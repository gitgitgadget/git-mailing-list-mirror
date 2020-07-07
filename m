Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6020FC433E2
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA8620771
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXX4V3SA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgGGOWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgGGOVl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:21:41 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93047C08C5E2
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:21:41 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so46739609wmf.5
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HqVPjNg3vkBTOEoNshJvUP0rlaSfyT6Kcy03vy/Udho=;
        b=cXX4V3SAxze4NwsdBejmrOc0fMyudxNefP+hK90mQ+ra2n0gQ9yeh5AXMw4maCTQLS
         5G1M9aCujJ+ydKt7A0H1MOWmfslJ9gqDZM3bCa/oZzf5CZMur7BrI4eqJL1pJepy4AB+
         t4t9Q9YTLZMlUEu0M+fl9bWSw0gUPVC+F6wvU2WBtY5yAXoD+mFz9vf5UdQx5XFouWKm
         AoHqruzvVLJ//dfD/Jn7oRUkbEFzATMQdddsAHUiclFnsP/EOsP/ZTC51lBkYxBWEs5+
         ZP6mYbK9H5iXsE4dycv0ZGIQGy2jj03Vl8b5iSlDAeYsiVH5sebdbMC44W9vOAfNXW3p
         T7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HqVPjNg3vkBTOEoNshJvUP0rlaSfyT6Kcy03vy/Udho=;
        b=HAl7sOFjmBQ3ROoxlAs5icrJj8JzGxrbqgiM1FxIBmEs9uL5B0pM9MZY7/Kf1oySGV
         dWjHyAke0En4T4+ahAcpZ72Nhc9/DY7ehyLZ4bCng/4u3lgSmzd6SGeQUF5KFyR5wU6a
         2cYPSS/3Zbyb/nIgHmpuGJd3WRlD98fFueHGhFb7m7r6xa5slQLqIkxxU2wLPddp/TGA
         82uboQTVNhtNIzRob9qcSO494oCnEa3gUzz3Pv4KYrwVUKWXRLlfKlFk5hbRhq7vmc7/
         tb4eglCfGSeZ5qOwHZ8QiF1VHOhpwa7kPuHYKS1GOWZzLeOe+7sSoiKl2gPs0EZX6Jwq
         1Y6w==
X-Gm-Message-State: AOAM530gUqg4E56LRSdpkZ7ux8dWBnJgLo+H60tl+RnHeENCfAMfm8gn
        wuCqvH1ZMWPCtCRnuZnz2IRCRxtD
X-Google-Smtp-Source: ABdhPJw0eFzU+O9Q4U1RruhoW0DK4IVQf36GQNL+GJKRxcn8gj/U+yVrdKiBBQIlm0BByxGy4z6ILQ==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr4363503wmh.134.1594131700168;
        Tue, 07 Jul 2020 07:21:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g145sm1676344wmg.23.2020.07.07.07.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:21:39 -0700 (PDT)
Message-Id: <e13d351e9ff19695b2ff638af01fdb4527fb7a6d.1594131695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 14:21:18 +0000
Subject: [PATCH 04/21] gc: drop the_repository in log location
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The report_last_gc_error() method use git_pathdup() which implicitly
uses the_repository. Replace this with strbuf_repo_path() to get a
path buffer we control that uses a given repository pointer.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 888b6444d6..58a00be5af 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -462,28 +462,30 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
  * gc should not proceed due to an error in the last run. Prints a
  * message and returns -1 if an error occurred while reading gc.log
  */
-static int report_last_gc_error(void)
+static int report_last_gc_error(struct repository *r)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int ret = 0;
 	ssize_t len;
 	struct stat st;
-	char *gc_log_path = git_pathdup("gc.log");
+	struct strbuf gc_log_path = STRBUF_INIT;
 
-	if (stat(gc_log_path, &st)) {
+	strbuf_repo_git_path(&gc_log_path, r, "gc.log");
+
+	if (stat(gc_log_path.buf, &st)) {
 		if (errno == ENOENT)
 			goto done;
 
-		ret = error_errno(_("cannot stat '%s'"), gc_log_path);
+		ret = error_errno(_("cannot stat '%s'"), gc_log_path.buf);
 		goto done;
 	}
 
 	if (st.st_mtime < gc_log_expire_time)
 		goto done;
 
-	len = strbuf_read_file(&sb, gc_log_path, 0);
+	len = strbuf_read_file(&sb, gc_log_path.buf, 0);
 	if (len < 0)
-		ret = error_errno(_("cannot read '%s'"), gc_log_path);
+		ret = error_errno(_("cannot read '%s'"), gc_log_path.buf);
 	else if (len > 0) {
 		/*
 		 * A previous gc failed.  Report the error, and don't
@@ -496,12 +498,12 @@ static int report_last_gc_error(void)
 			       "Automatic cleanup will not be performed "
 			       "until the file is removed.\n\n"
 			       "%s"),
-			    gc_log_path, sb.buf);
+			    gc_log_path.buf, sb.buf);
 		ret = 1;
 	}
 	strbuf_release(&sb);
 done:
-	free(gc_log_path);
+	strbuf_release(&gc_log_path);
 	return ret;
 }
 
@@ -602,7 +604,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
 		}
 		if (detach_auto) {
-			int ret = report_last_gc_error();
+			int ret = report_last_gc_error(r);
 			if (ret < 0)
 				/* an I/O error occurred, already reported */
 				exit(128);
-- 
gitgitgadget

