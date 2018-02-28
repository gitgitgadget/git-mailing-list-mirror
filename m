Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D71C71F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965046AbeB1XYw (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:24:52 -0500
Received: from mail-vk0-f74.google.com ([209.85.213.74]:46988 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964929AbeB1XYq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:46 -0500
Received: by mail-vk0-f74.google.com with SMTP id l205so2339648vke.13
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=dk3XLsU/3A9otihg7TMpPIOGp9WFGy5OGS2gyzYTVzo=;
        b=MH26bPbbcOb8cKt9qpW4ASctWqeVC9kFFsXrA13lHntuKdKwKj8g9NPjogIbjbqbqT
         RLN9/Fysq1DwzyyLA99lt/DhVW49oLXIZZZWsbIU0D4lAJUvqOP6+r9iCV/zBumBBFgq
         XqAMAm9xBro+2NuYTdkaIoPPKFq0fPzroLEpWMF5Myqr6y1ORKg48EeQkPhK9jdEHDe8
         KJ369fHj8wQ/YtpKLS01xfvtC+LKVEcgLaRJXkwTBXwG6uRAtJI0CZusmubToU1ISsjr
         fPg2DwTw9udGN56ZR0JL6vquvjttmHhuk8yB0Hjddb26xSLisI3muY92sh1ruvK64Tx6
         +dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=dk3XLsU/3A9otihg7TMpPIOGp9WFGy5OGS2gyzYTVzo=;
        b=UEhBzL4jGbsCPLzx4yLJyi5jkCDfqn0OGfRkyj8vfG5GJ99H3kgbw0XWZu0QW9fPZL
         PK8Uz+B4iRXWEq0XAELa5ospMovV5BTqNVqdslWDPG1Ti7sNE8pyIGq5AVrGJalHz+Qk
         VE9SAme9MGh2dxffMmAB66XSXJu1pNvhmd1UmKMX0YqIJgcxGPmUyZS288zyN48A3m/H
         9LBGP5L+zO0FGcDQUZOTkirn9Upm1xwpjFoeHBYsxKxzecR5LUzVj5r5l5T42IAP4UhA
         WJFdyVzaKLNMH4gGbRTw4FhIox1x7zUYKL+Cd8DtwxxBfXW7aXckaXeue/J7nj1C2RMG
         014Q==
X-Gm-Message-State: APf1xPCsT5SGfwK/r+4mAxdtGkRsIn9OW0AzR+2jUjMR3GIyJ+aakQfK
        GwdvmArYBXhJEHoAQ+MtCHbLvLq8xx+ay4mgVx1DeIpqV3rAkniFRTim4/+ux9DZo/7rgvUI5jf
        EkzxXUJjMDy2pVKfw+kS9TpdfVxJB0B6GW7fmx78NVh3WJUX6kpr3WZz3ig==
X-Google-Smtp-Source: AG47ELs380evHjj1NjkmIYGthpU60baP9aSWzrzJlZ0HirW8/M9JL75eNykG4R8ww+kPehrY9tfR1uRffBw=
MIME-Version: 1.0
X-Received: by 10.31.214.2 with SMTP id n2mr9450910vkg.10.1519860286196; Wed,
 28 Feb 2018 15:24:46 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:50 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-34-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 33/35] http: eliminate "# service" line when using protocol v2
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an http info/refs request is made, requesting that protocol v2 be
used, don't send a "# service" line since this line is not part of the
v2 spec.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 http-backend.c | 8 ++++++--
 remote-curl.c  | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index f3dc218b2..5d241e910 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -10,6 +10,7 @@
 #include "url.h"
 #include "argv-array.h"
 #include "packfile.h"
+#include "protocol.h"
 
 static const char content_type[] = "Content-Type";
 static const char content_length[] = "Content-Length";
@@ -466,8 +467,11 @@ static void get_info_refs(struct strbuf *hdr, char *arg)
 		hdr_str(hdr, content_type, buf.buf);
 		end_headers(hdr);
 
-		packet_write_fmt(1, "# service=git-%s\n", svc->name);
-		packet_flush(1);
+
+		if (determine_protocol_version_server() != protocol_v2) {
+			packet_write_fmt(1, "# service=git-%s\n", svc->name);
+			packet_flush(1);
+		}
 
 		argv[0] = svc->name;
 		run_service(argv, 0);
diff --git a/remote-curl.c b/remote-curl.c
index b4e9db85b..66a53f74b 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -396,6 +396,9 @@ static struct discovery *discover_refs(const char *service, int for_push)
 			;
 
 		last->proto_git = 1;
+	} else if (maybe_smart &&
+		   last->len > 5 && starts_with(last->buf + 4, "version 2")) {
+		last->proto_git = 1;
 	}
 
 	if (last->proto_git)
-- 
2.16.2.395.g2e18187dfd-goog

