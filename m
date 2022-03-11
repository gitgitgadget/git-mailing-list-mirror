Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A4CC433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiCKWoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiCKWn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 17:43:58 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5512405A5
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:19:28 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 19so5894994wmy.3
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+euCH8Zxv4U7O04h65hJ5UKgd0xdIRUROQj9frPMn/U=;
        b=AkNkGjB8insPp1VtyYFFOIrv2g7Mo0ZNsTsfoFUeJraRk4nYBqm+K5fEUyNjiPdZrk
         hrKdWwfbSRyyEJYddQYLgLendwBNwez8hC3C7ZNgbt3AyKhpgR9WrnFQ9SnHr21s8bT+
         v+IYhh/lfL6q7iUENFeVJwoOPP0fjoPYQ3ZavoMEQLNerS2KajWEpsggVNOIx4irfwwn
         qgY7uw54gAfgNUxTmIFlvh26umA0+IW61AtgNIBdT/fvdWCiaQrcz5kDzvlTDUyMH/eD
         HGIpKlSfAni7OsUVWAZe5OcftdNKpwCoQhbIMke7dAe7YJlblRQcwJf6QNZmwc3xmlN4
         RcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+euCH8Zxv4U7O04h65hJ5UKgd0xdIRUROQj9frPMn/U=;
        b=zgeTozB/01pgup6rhoX2EPuTM0zJHW7v28pn3s5fBHyALQdApB5xR0agTtydnHl8VB
         23n/Mp6of4QMtQ92l4Qqq1IW3Zv3Mljm97b+Yjjl2KNhRGENn+OnCA9IhyWRlteklhqk
         T82Vxoxcf72SrvgU2oQcbgGOFS30km/eYFAJcVX4gF61hosG1XM3deJ9l7c7XIU3pvJB
         KNzae8c+bj10gAQJrogrD1OvE2F6f4rsdGEU70wMCYfkgqGtp3RJvnGEg82h5HebA9mh
         UzRyfLskQNuglHnZk/nnM7uybg5MVLGZ3+1Ze7jdSuyeY0J/90z3ilO6M23Spe5uwTFo
         tMZw==
X-Gm-Message-State: AOAM533YGIrVc1nTxzb5u4hi0eY+K8mGpCo8eWpzOwpqozbCTQUIgTIt
        hS2e0Ab6FSNjqrwlJb6Xt52/XgNHVw4=
X-Google-Smtp-Source: ABdhPJz7aqU/eydwGhaeZnc+pX0Jl+Eow+dQkqnzi3Gq+K1vssuLM8krk5iv/Pxh3kByU9Ay2CKWfQ==
X-Received: by 2002:a1c:f718:0:b0:380:ed20:6557 with SMTP id v24-20020a1cf718000000b00380ed206557mr17599701wmh.53.1647033308329;
        Fri, 11 Mar 2022 13:15:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m189-20020a1c26c6000000b00389f8158b76sm923666wmm.48.2022.03.11.13.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:15:08 -0800 (PST)
Message-Id: <84df95be620c76afed73d1679722459e2ff32018.1647033303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 21:14:52 +0000
Subject: [PATCH 05/16] fsmonitor--daemon: refactor cookie handling for
 readability
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

fixup! fsmonitor--daemon: use a cookie file to sync with file system

Use implicit definitions for FCIR_ enum values.

Remove const from cookie->name.

Reverse if then and else branches around open() to ease readability.

Document that we don't care about errors from close() and unlink().

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsmonitor--daemon.c | 53 +++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 97ca2a356e5..02a99ce98a2 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -109,14 +109,14 @@ static int do_as_client__status(void)
 
 enum fsmonitor_cookie_item_result {
 	FCIR_ERROR = -1, /* could not create cookie file ? */
-	FCIR_INIT = 0,
+	FCIR_INIT,
 	FCIR_SEEN,
 	FCIR_ABORT,
 };
 
 struct fsmonitor_cookie_item {
 	struct hashmap_entry entry;
-	const char *name;
+	char *name;
 	enum fsmonitor_cookie_item_result result;
 };
 
@@ -166,37 +166,44 @@ static enum fsmonitor_cookie_item_result with_lock__wait_for_cookie(
 	 * that the listener thread has seen it.
 	 */
 	fd = open(cookie_pathname.buf, O_WRONLY | O_CREAT | O_EXCL, 0600);
-	if (fd >= 0) {
-		close(fd);
-		unlink(cookie_pathname.buf);
-
-		/*
-		 * Technically, this is an infinite wait (well, unless another
-		 * thread sends us an abort).  I'd like to change this to
-		 * use `pthread_cond_timedwait()` and return an error/timeout
-		 * and let the caller do the trivial response thing, but we
-		 * don't have that routine in our thread-utils.
-		 *
-		 * After extensive beta testing I'm not really worried about
-		 * this.  Also note that the above open() and unlink() calls
-		 * will cause at least two FS events on that path, so the odds
-		 * of getting stuck are pretty slim.
-		 */
-		while (cookie->result == FCIR_INIT)
-			pthread_cond_wait(&state->cookies_cond,
-					  &state->main_lock);
-	} else {
+	if (fd < 0) {
 		error_errno(_("could not create fsmonitor cookie '%s'"),
 			    cookie->name);
 
 		cookie->result = FCIR_ERROR;
+		goto done;
 	}
 
+	/*
+	 * Technically, close() and unlink() can fail, but we don't
+	 * care here.  We only created the file to trigger a watch
+	 * event from the FS to know that when we're up to date.
+	 */
+	close(fd);
+	unlink(cookie_pathname.buf);
+
+	/*
+	 * Technically, this is an infinite wait (well, unless another
+	 * thread sends us an abort).  I'd like to change this to
+	 * use `pthread_cond_timedwait()` and return an error/timeout
+	 * and let the caller do the trivial response thing, but we
+	 * don't have that routine in our thread-utils.
+	 *
+	 * After extensive beta testing I'm not really worried about
+	 * this.  Also note that the above open() and unlink() calls
+	 * will cause at least two FS events on that path, so the odds
+	 * of getting stuck are pretty slim.
+	 */
+	while (cookie->result == FCIR_INIT)
+		pthread_cond_wait(&state->cookies_cond,
+				  &state->main_lock);
+
+done:
 	hashmap_remove(&state->cookies, &cookie->entry, NULL);
 
 	result = cookie->result;
 
-	free((char*)cookie->name);
+	free(cookie->name);
 	free(cookie);
 	strbuf_release(&cookie_pathname);
 
-- 
gitgitgadget

