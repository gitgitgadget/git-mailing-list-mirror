Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E81E743FF
	for <git@archiver.kernel.org>; Fri, 29 Sep 2023 21:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjI2VVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Sep 2023 17:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjI2VVF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2023 17:21:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158B21AE
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 14:21:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d86766bba9fso18340722276.1
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 14:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696022463; x=1696627263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kckG2mDj4W61beRJrtNjk81pTQaRrpVtXZrSgI57tD0=;
        b=aOrx9q+v4LLjyoK04/tQ2O2wNxCfG3i/UyMoMpB0trAGrLDraL8PXvSvw2EY2IZiQN
         CuIdofBWUv7nd6nTM8c30RO5j55pJFS7ICXMeKJkepkI/g3Y9sPqPvNvIq2nvQ7xN7VI
         4VfSxfjT+q9nxYqVbWaI4scYSL61h401QBcZJF702JW+9GohkhBjsf3lVNd19gIs3gJ1
         pLEszAVrSr4Kk+D4MaEqsRV8loQ8r2F3Afz8KTaqF8CIR1kT6KKb5F65h1dJe91NAdhB
         oYuWc8nCUdVPLu8YgtHXZ6ZVJas75ZWdgU3g01/e48b3qJ0BFxtxVjO9V8hoSK10vOvK
         SiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696022463; x=1696627263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kckG2mDj4W61beRJrtNjk81pTQaRrpVtXZrSgI57tD0=;
        b=hwDz3mIkvp01au5SnjrWeFoLFWFVk+GT0XcJpaI7MP54M9hnMws97LYy3X1xOebn3v
         c/1sdyUzXZIagFzxziPUOUVI76V6Xal5DQnQMel11B8v2wNiaSF+0P4nVruCG/5nRD+n
         uwI6G2QDqBAefGCO2PQSk01CWMKSUjcVsLf8JfpUT07uFLzQBTdhXwm+8p2K2vKVzfZh
         gKHXXcrMnNk4HOXO1UyzlqitwmkT4VAQ0mbmOyL2TgmFAzx+P/7yJFxUOY1g0UpqjnR/
         W2seV2A2wO6RY9/gEG6Pl/1gQG4k+6ffIs8/hPS1jGxSbgHTbkgyo+1ltywPcQzPRpwB
         O0JQ==
X-Gm-Message-State: AOJu0Yw06Yz1MIoR8UMyCMwIuKKMAmvgQ7J5fB4fSsX35kAF1EzkMqGp
        C3looeMQxmdKf8KAAoS7h8CGk/2yKdhKlEdOZ/jZUliDG0AGtl+z0KDiKA0YTxjy/npMHb8np0J
        tH66hiugpEFKUBE5lin+VxK3S2N1C7LzEZLbNb5wBNwQJ9Y7lX5yHEEDNl0eOn71U+QpVvGQu+F
        eA
X-Google-Smtp-Source: AGHT+IF7lVWJwyUXsNqxAovppY3HdVfg5vQ05xDN7ON4srTYW5e9mpUSicUeWL9PiclG6CIjG0ZfukGioWCJmBbjckQa
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:b708:8deb:d032:67cf])
 (user=jonathantanmy job=sendgmr) by 2002:a25:dd8:0:b0:d86:5500:7dba with SMTP
 id 207-20020a250dd8000000b00d8655007dbamr83203ybn.13.1696022463250; Fri, 29
 Sep 2023 14:21:03 -0700 (PDT)
Date:   Fri, 29 Sep 2023 14:20:50 -0700
In-Reply-To: <cover.1696021277.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com> <cover.1696021277.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <e4c20a81f93e2a4e2ad65920920ead690b162e25.1696021277.git.jonathantanmy@google.com>
Subject: [PATCH v4 3/4] config: correct bad boolean env value error message
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Calvin Wan <calvinwan@google.com>

An incorrectly defined boolean environment value would result in the
following error message:

bad boolean config value '%s' for '%s'

This is a misnomer since environment value != config value. Instead of
calling git_config_bool() to parse the environment value, mimic the
functionality inside of git_config_bool() but with the correct error
message.

Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 3846a37be9..7dde0aaa02 100644
--- a/config.c
+++ b/config.c
@@ -2133,7 +2133,14 @@ void git_global_config(char **user_out, char **xdg_out)
 int git_env_bool(const char *k, int def)
 {
 	const char *v = getenv(k);
-	return v ? git_config_bool(k, v) : def;
+	int val;
+	if (!v)
+		return def;
+	val = git_parse_maybe_bool(v);
+	if (val < 0)
+		die(_("bad boolean environment value '%s' for '%s'"),
+		    v, k);
+	return val;
 }
 
 /*
-- 
2.42.0.582.g8ccd20d70d-goog

