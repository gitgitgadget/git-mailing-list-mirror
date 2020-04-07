Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2000CC2BB85
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AAF20747
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeDzmeiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgDGOL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:11:58 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:44438 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgDGOLz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:11:55 -0400
Received: by mail-wr1-f47.google.com with SMTP id c15so4028530wro.11
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=2nxyKFeh6cWpo5OMHd6lY+gkXo6+Ra4s/rpxFaKmcj4=;
        b=AeDzmeiv+tzZsWvX5Z3qDZIhTPFzlPYfqhn4M8xnYMKWRP/+yk08FZJ9S8gW7k+tng
         WUGLrQcWF8gOd2kyeQmMz/SG63DCGXEHI5yng9yOd0LYf2Xj2ITLyrXsWxPyYQUlZGxh
         lo96CW356R4OCiBmHzJL6hxZBnUCLX1dinWNJMtrZ9XRZUiHWzuw3sox14Ek1j2yJWf2
         q/0f3Ov35boVK+mFwFA8DM1WUM4KvCHOHa5TrUB0KPjS8xFEHoagCKQdZvaRykD0pVdg
         Vr/tWKJLqzP0QsVhdmw7AxdELVpgCf7vaB0iro+znMdpu29I7sxkcaBZeGDw64UTdQhb
         sfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=2nxyKFeh6cWpo5OMHd6lY+gkXo6+Ra4s/rpxFaKmcj4=;
        b=RqPdnPuSM3sPjLmGo7uJRCjduy2OWNgZ6nYSFjhjjd1k146tfTAJ0f48D8IpR2zWQg
         pP5SjcF8ZP/wSWYbFIxJjI9yDuza7Lz8Fc9Znqu568J2y/8GP/Rf5EaiZnnMeuAZvLec
         YZ4FLIpUS5+x9e0gjuCzjSHq6+FFH15J3CQlr7gNyny8TnZ27VvOd5o/ClM8uoDl8M/8
         ERWTimnJOTHeCRwwujDkfKTjvQ/F3OyaiDS1Yf6w7fSGnM9TyeWNoJ5KrYqT/A/dxbyZ
         bp9OouAeDwtJjmm1lfvDE5kLdhoQGOA7HRhfZDF1PIEyeMlzRWGzgix12GRhGXhaKPVj
         AKMQ==
X-Gm-Message-State: AGi0PuZSx5Dat0S4S1wFKIImwZpaEfF2KZF5e6MNDyuUov6C8Ien8YG3
        QZR07X34QUgUo6CSYewG+8FR22qU
X-Google-Smtp-Source: APiQypJUgvUDqH4atobXV+zvtvu4z4+LfsWlRRO6EDupuIBsrxXAkP9qXsDntbwKuK5P90jsr528Qg==
X-Received: by 2002:adf:ee8d:: with SMTP id b13mr3151982wro.251.1586268714033;
        Tue, 07 Apr 2020 07:11:54 -0700 (PDT)
Received: from localhost.localdomain (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id v16sm2492693wml.30.2020.04.07.07.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:11:53 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 5/6] Revert "sequencer: allow callers of read_author_script() to ignore fields"
Date:   Tue,  7 Apr 2020 15:11:24 +0100
Message-Id: <20200407141125.30872-6-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407141125.30872-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This reverts commit c068bcc59b4f16322a77b6a47b53d44b05c51fec.

This functionality is no longer used as since the last commit we always
want all of the fields returned.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 56f6e49289..17c7b18245 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -825,19 +825,9 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 		error(_("missing 'GIT_AUTHOR_DATE'"));
 	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
 		goto finish;
-
-	if (name)
-		*name = kv.items[name_i].util;
-	else
-		free(kv.items[name_i].util);
-	if (email)
-		*email = kv.items[email_i].util;
-	else
-		free(kv.items[email_i].util);
-	if (date)
-		*date = kv.items[date_i].util;
-	else
-		free(kv.items[date_i].util);
+	*name = kv.items[name_i].util;
+	*email = kv.items[email_i].util;
+	*date = kv.items[date_i].util;
 	retval = 0;
 finish:
 	string_list_clear(&kv, !!retval);
-- 
2.26.0

