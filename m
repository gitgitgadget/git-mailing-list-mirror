Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358A2C433FE
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 13:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiCDNMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 08:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiCDNMX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 08:12:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E271AA074
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 05:11:34 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j26so2274247wrb.1
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 05:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=EjX+jn1l1pdirTUkQ+a4XwOKdnO74LpiX3BzJx8D/Hk=;
        b=Wg7ll3JhBjefsM2z/flXYDvOYBIogHrPTFA/oMvNSnMxkI4A24f+IQeaaNMQd4TyNc
         O+xc76LKJAbXo9OdZoZdCd5bQQ9Cz25EUssUG95kLMs8l+fiOSMjxzGjkyZWGu1utSKu
         B6Knt38wXty5sxOP+Ug/ZCy5LQhO1TIJ6ClP3rvUCkJCQ9Kjo9ELA/tL+7jN9Fs/57Xg
         TPscekrkubSefrJjbdAgxjUCbOV9bN9tt7ik4skNkAISodjN+QJ/8cYI4IVXscL0wvCL
         J7Q7hK6Q1oQhMmCru+nRtG+qxsCWXDRgzrvO39nO1HVhzRe/zaevT56dyb19HQYOwUH5
         eAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=EjX+jn1l1pdirTUkQ+a4XwOKdnO74LpiX3BzJx8D/Hk=;
        b=FYUw6VZI9OYkXXXdXG8EDwErwS3IkL9iCPvv+fWit1C5hiASBkMED2iClwsHQ6iARV
         TAS4v2+2VU2Ud1Ric19/xd1C0yr8wSPh+A9DR5pqrCtBSnOuGcO7q09j0KBAUP8i3ThG
         +wYMgpgFEwykZJOjfWdqWzKEKe/4LbAdfFdYJQYdLp9I3/dKvh6m3KU/fXqKRqzl302W
         cKvQo16d2yYtqEQO4EogJva8Rky1KLk4LPUbi6seyuiU2UICIOa6GtjD1I4nAaOBh2VU
         xU7slAprgjC7vU6CY4JqOblr+R8r5CXyRy08Ku7v9Ctr6g5cfZz2XDX7xMpOXGgRw824
         pEKA==
X-Gm-Message-State: AOAM530Fw4PhuGdFlp0DXcRVkfis7UsntKj1Jz5KBPmIMQe+6kDt8+IL
        PXprmJ19pd1ysL5JH0XMHUgGUCB9KPM=
X-Google-Smtp-Source: ABdhPJzHKMZJbKbxo22xZ3Asni5KX8etbRYW7fNyTlyr68/72acGuChpLmHBDdOIur+UTs5WHb/58w==
X-Received: by 2002:adf:fb47:0:b0:1ed:9f2c:492e with SMTP id c7-20020adffb47000000b001ed9f2c492emr30179423wrs.196.1646399493337;
        Fri, 04 Mar 2022 05:11:33 -0800 (PST)
Received: from localhost.localdomain (230.2.7.51.dyn.plus.net. [51.7.2.230])
        by smtp.gmail.com with ESMTPSA id c4-20020adffb04000000b001f0494de239sm4634042wrr.21.2022.03.04.05.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 05:11:33 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     carenas@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 3/4] terminal: work around macos poll() bug
Date:   Fri,  4 Mar 2022 13:11:25 +0000
Message-Id: <20220304131126.8293-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304131126.8293-1-phillip.wood123@gmail.com>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

On macos the builtin "add -p" does not handle keys that generate
escape sequences because poll() does not work with terminals
there. Switch to using select() on non-windows platforms to work
around this.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 compat/terminal.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 249836e78f..5d516ff546 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -82,6 +82,32 @@ static int enable_non_canonical(unsigned flags)
 	return disable_bits(flags, ICANON | ECHO);
 }
 
+/*
+ * On macos it is not possible to use poll() with a terminal so use select
+ * instead.
+ */
+#include <sys/select.h>
+static int getchar_with_timeout(int timeout)
+{
+	struct timeval tv, *tvp = NULL;
+	fd_set readfds;
+	int res;
+
+	if (timeout >= 0) {
+		tv.tv_sec = timeout / 1000;
+		tv.tv_usec = (timeout % 1000) * 1000;
+		tvp = &tv;
+	}
+
+	FD_ZERO(&readfds);
+	FD_SET(0, &readfds);
+	res = select(1, &readfds, NULL, NULL, tvp);
+	if (res < 0)
+		return EOF;
+
+	return getchar();
+}
+
 #elif defined(GIT_WINDOWS_NATIVE)
 
 #define INPUT_PATH "CONIN$"
@@ -247,6 +273,16 @@ static int mingw_getchar(void)
 }
 #define getchar mingw_getchar
 
+static int getchar_with_timeout(int timeout)
+{
+	struct pollfd pfd = { .fd = 0, .events = POLLIN };
+
+	if (poll(&pfd, 1, timeout) < 1)
+		return EOF;
+
+	return getchar();
+}
+
 #endif
 
 #ifndef FORCE_TEXT
@@ -397,12 +433,7 @@ int read_key_without_echo(struct strbuf *buf)
 		 * half a second when we know that the sequence is complete.
 		 */
 		while (!is_known_escape_sequence(buf->buf)) {
-			struct pollfd pfd = { .fd = 0, .events = POLLIN };
-
-			if (poll(&pfd, 1, 500) < 1)
-				break;
-
-			ch = getchar();
+			ch = getchar_with_timeout(500);
 			if (ch == EOF)
 				return 0;
 			strbuf_addch(buf, ch);
-- 
2.35.1

