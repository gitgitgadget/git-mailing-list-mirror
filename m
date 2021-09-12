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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740D4C4332F
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 20:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5953861211
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 20:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbhILUae (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 16:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236286AbhILUa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 16:30:28 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFC4C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 13:29:14 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so10497428otf.6
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 13:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aeDMRtMsDtWW736od8ych7Fvbsc0M8sgzDcHOsO+UMU=;
        b=Ch+5SNU3DLr3FhN/KARPAC5SBBWIqoKIMkKusnlYcnxYoZ/KMvj8GlnfMdat44Tm9a
         lJVFHVAZxtcSc7WkADc1jJJ0hp/7XzPU0FQD/qO0XHJfQv5nxXO9wNpxztqJ65oDExy2
         IoXz/GQ8g4xx+KHGQr5zfISbEaUXWkdP99Y4oHgsCDx6k0iyvEWipFywOVgyJP56xDmi
         /CsWE2D26ZBGsEUPqU4cYGqWn3jRz3eKQT9DCkIwTOSydV/FgSlCG//nxF+nC56gKCEz
         tpqGtTYBCcYkAe02IgaI+n5J81SY3pFo42vK2FSgrG6DOqObwtdvUkHgkbwMbWgeq0/a
         +wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aeDMRtMsDtWW736od8ych7Fvbsc0M8sgzDcHOsO+UMU=;
        b=D58FkDeuHIsL7H4OfQoxcTU2zKgb+koudmg8QlX/jpSivuhFYSC6ojpI7tvxnfjwfD
         kctcPWksEP7CDFDKd1CKYFUb/MMuHcvpCm5MjYP/xTFkFmhtakWOzF0P5flYlF3LIBTT
         cJOSF+RYb4pzxQKDwihd95GeGjjFjPuWc0aIRJFfQFL5XEl+5l/EMouXci6yQivGxDo2
         zYSMcmwlIwYCV6Dq0ZVwtUOe+3/OQyhPQ3SeWr3z4J4b4dbVxu4wMJkBxZABjkesm9zM
         79CDc3deISYX5dDEA2k12ej8i0dJzxu2gFj4b8g5g8XGiBkgFJwAHtikjHVGW8OQ1cQO
         2Onw==
X-Gm-Message-State: AOAM532v6PKlvNmMtM8hl3fZ+vjLYrqi+1i23mm8bPwVlrY8G3I3pgg3
        IjiHqntjDOUKeGfUcYQkpu4VdxDOOVE=
X-Google-Smtp-Source: ABdhPJwWUWYsj9L7Vc43oo1B0wq29152duqy2UyaqllgBNGMuE8RSpGUGH7Xp5Ict/0ZJskhM0EPig==
X-Received: by 2002:a05:6830:187:: with SMTP id q7mr7415592ota.217.1631478553445;
        Sun, 12 Sep 2021 13:29:13 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id w9sm1345162oti.35.2021.09.12.13.29.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Sep 2021 13:29:13 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     lehmacdj@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/3] credential-cache: check for windows specific errors
Date:   Sun, 12 Sep 2021 13:28:29 -0700
Message-Id: <20210912202830.25720-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210912202830.25720-1-carenas@gmail.com>
References: <20210912202830.25720-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Connect and reset errors aren't what will be expected by POSIX but
are compatible with the ones used by WinSock.

Alternatively a translation layer for read could be added (similar
to the one provided by mingw-write()) to translate the odd EINVAL,
into a more reasonable EPIPE, but this is more localized and still
unlikely to cause confusion in other systems.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/credential-cache.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 76a6ba3722..b12a79ae01 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -28,7 +28,8 @@ static int send_request(const char *socket, const struct strbuf *out)
 		int r;
 
 		r = read_in_full(fd, in, sizeof(in));
-		if (r == 0 || (r < 0 && errno == ECONNRESET))
+		if (r == 0 ||
+			(r < 0 && (errno == ECONNRESET || errno == EINVAL)))
 			break;
 		if (r < 0)
 			die_errno("read error from cache daemon");
@@ -75,7 +76,7 @@ static void do_cache(const char *socket, const char *action, int timeout,
 	}
 
 	if (send_request(socket, &buf) < 0) {
-		if (errno != ENOENT && errno != ECONNREFUSED)
+		if (errno != ENOENT && errno != ECONNREFUSED && errno != ENETDOWN)
 			die_errno("unable to connect to cache daemon");
 		if (flags & FLAG_SPAWN) {
 			spawn_daemon(socket);
-- 
2.33.0.481.g26d3bed244

