Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B56DC433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC5EA2075A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIqILqYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390960AbgE0ReN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 13:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390950AbgE0ReL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 13:34:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6E1C03E97D
        for <git@vger.kernel.org>; Wed, 27 May 2020 10:34:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u12so243130wmd.3
        for <git@vger.kernel.org>; Wed, 27 May 2020 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=qd715dbSdeLFKR+JaxIImHifxTxyuvLTQs+JKbIOhEo=;
        b=nIqILqYWOSRrc31LTP28UYGQ6zAVIhXKynViV4slyzzrA6ufsFNjrHhij0hQ1Azh24
         K4usraKRnHsP/AI6eeGIwum3qnx+6m50g1UA1kY+HVINLNS0q4GGjx0hH7ynXrBgpudq
         LGqEDn7SZt3xh2rr3yKqN9Q/Y6Xzj/YEU6wWljd8Hvi6oNEiHPptrztG8u5yGzRw5zF1
         XfNVZgwzx9zu3JbL3geuE3V9oLtiO2eMNRjhxUOodXZAxTHgb+vNK3TncBMhiGcCIHoY
         Xg20IajARCL6TEHISDeKO5yKY6uJaZjgk00DpVjdjEUfz+YHmNIZbktSfdA8Jhhj7//b
         sAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=qd715dbSdeLFKR+JaxIImHifxTxyuvLTQs+JKbIOhEo=;
        b=L4L+xNMTOzgZGtL0dS9E/rSWZYIXttjxMbJ2ygXxjLfzJZIwdAL5pIJNTKI5sjyAVV
         pYNhWe090wsb/shCLDmKSOu2oyVQWg7xgWwNYV1g7N533O/LFXUQVVMfcp0mIG/9O5fz
         8XEQ0ztF4FL+x+c+NFSSoWnHd2XAIxFFVxEU0G6gW9QuITwDDKo8jLU3iQlBsB/kPugN
         /Gn0TTy0NN+JLOT0taaC2nJvt98Wqkxly+fZPlLQIzHsBIZNximwuwIfW/ZAhcEWCnEt
         Px5OV5Abhfsc0zVtCqNEeGSHL10sCG6iSGiRQLUB0+v7UTzPzBnBuwbkWe+dxrjI5nJy
         WxIQ==
X-Gm-Message-State: AOAM531PA6y0SHxiekVJaZ7s0nZBFuCgItKbOyUHdcGYo+dagErBfrxy
        D9nLPanjt4R+/E9NVLHd1WzG3PV6
X-Google-Smtp-Source: ABdhPJz+XJwysRgMFyDmxEumdjBkdUwSJHWibxixZ/oDPPyqyV2T2kMmTuDjkSFPNMWkZFdLevMSmg==
X-Received: by 2002:a1c:790f:: with SMTP id l15mr5214653wme.161.1590600850153;
        Wed, 27 May 2020 10:34:10 -0700 (PDT)
Received: from localhost.localdomain (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id h196sm3524807wme.22.2020.05.27.10.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 10:34:09 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v4 3/5] sequencer: rename amend_author to author_to_free
Date:   Wed, 27 May 2020 18:33:54 +0100
Message-Id: <20200527173356.47364-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527173356.47364-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200527173356.47364-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>

The purpose of amend_author was to free() the malloc()'d string
obtained from get_author() when amending a commit. But we can
also use the variable to free() the author at our convenience.
Rename it to convey this meaning.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 sequencer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8826c6325b..44e0b45e53 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1335,7 +1335,7 @@ static int try_to_commit(struct repository *r,
 	struct commit_extra_header *extra = NULL;
 	struct strbuf err = STRBUF_INIT;
 	struct strbuf commit_msg = STRBUF_INIT;
-	char *amend_author = NULL;
+	char *author_to_free = NULL;
 	const char *hook_commit = NULL;
 	enum commit_msg_cleanup_mode cleanup;
 	int res = 0;
@@ -1357,7 +1357,7 @@ static int try_to_commit(struct repository *r,
 			strbuf_addstr(msg, orig_message);
 			hook_commit = "HEAD";
 		}
-		author = amend_author = get_author(message);
+		author = author_to_free = get_author(message);
 		unuse_commit_buffer(current_head, message);
 		if (!author) {
 			res = error(_("unable to parse commit author"));
@@ -1473,7 +1473,7 @@ static int try_to_commit(struct repository *r,
 	free_commit_extra_headers(extra);
 	strbuf_release(&err);
 	strbuf_release(&commit_msg);
-	free(amend_author);
+	free(author_to_free);
 
 	return res;
 }
-- 
2.26.2

