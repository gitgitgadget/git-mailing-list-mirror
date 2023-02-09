Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AEDC636D3
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 00:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjBIACa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 19:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjBIACY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 19:02:24 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DF01F5ED
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 16:02:22 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k15-20020a5b0a0f000000b007eba3f8e3baso357092ybq.4
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 16:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xcCDJ/9InDiBfm3IVYXcLEw2c7g9o9VhW+yu1jBDgF0=;
        b=OVjPnV6zYLq0lYV86uuzkaNDCLIDK0OWSwJHmoahYzZ9dqygsVBxMlAhPnwKnXx5Z3
         HcfFjEbEZSIOkeAEXnl+MeVelcPXptw495baipMRJgTd4FBFR5PCUGc3tyH+9wPdcMLO
         u34TBJcYN5ETyYKXMp6HKSxj8RfAH6jYDBUeQV7u/XfGlBZHffs+Fd8fd8FcfCIVrju6
         EilsDd0JO8coKhlttoLJEApfiC9hGLEI19tyGm+kcRcCfUjuy1OyVE1PRodNdjLf44m8
         jH/FVuZe5WXOuWTVkFdms9MsZU4uOBzectIlnnkijrQABKHxOOIg4S5fwms8xZzVzlvs
         +WLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcCDJ/9InDiBfm3IVYXcLEw2c7g9o9VhW+yu1jBDgF0=;
        b=JNtrUzkYOlCn6QY5hHUA/lzx6cqxoXJ56h6ceUcihDHeLaS5tSv/kaplKmglRKA/aE
         N8Rxe4Def3E3qCgI6bdxFtC4ieuPUhCYDI0zrf5F3bKoCTtpsroNdSvL8A5xjvgkgaE+
         taFlzgKimd3/bn8LEAPH0Nq2zGG5HWzcSwZ/2FSPmxrTG6LX9hGJdnXCOkAS+xqpe2Ny
         oYlbzdtzIPi15b+EcZ4fNUg312PxYk3YWDZU7MD1vAuwooGDUiWCz8ajwY4hThflrQfQ
         hyM7h1efIQ26bzi63amHyi1T8nxCfNO+FSdSBJa3cm+dwbn+lsx8PY9dpWtX2BELEs3h
         mrxg==
X-Gm-Message-State: AO0yUKVh9lYlH+9usnsT4A+HQouYJyTKynb/a910L24j64/1+IB4EhTF
        yZaeOjzJ4rwash0wyIoQ3LN0p46NbWlpAhzvSy0p1nWk7boz7ARsRsw2twseaeRT7K/eE8lxa28
        ZMYeq/1iJxkKsQyUlK0pc1EmTOCeBlQRhJIDWSQIS/NmDDDL7dbyT9Fx33cJy00WXPg==
X-Google-Smtp-Source: AK7set/Njgs64aVhm84fyLt/0hRNVlt7FWE7Joqw3o6duoVYMfJBMvPsVTymu5yp1T7LQ/PiM3ANS7hF6NIlm40=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6902:2c6:b0:801:f3b:524f with SMTP
 id w6-20020a05690202c600b008010f3b524fmr984657ybh.167.1675900942060; Wed, 08
 Feb 2023 16:02:22 -0800 (PST)
Date:   Thu,  9 Feb 2023 00:02:09 +0000
In-Reply-To: <20230207181706.363453-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230207181706.363453-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230209000212.1892457-4-calvinwan@google.com>
Subject: [PATCH v8 3/6] submodule: move status parsing into function
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A future patch requires the ability to parse the output of git
status --porcelain=2. Move parsing code from is_submodule_modified to
parse_status_porcelain.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 submodule.c | 74 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/submodule.c b/submodule.c
index faf37c1101..768d4b4cd7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1870,6 +1870,45 @@ int fetch_submodules(struct repository *r,
 	return spf.result;
 }
 
+static int parse_status_porcelain(char *str, size_t len,
+				  unsigned *dirty_submodule,
+				  int ignore_untracked)
+{
+	/* regular untracked files */
+	if (str[0] == '?')
+		*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+
+	if (str[0] == 'u' ||
+	    str[0] == '1' ||
+	    str[0] == '2') {
+		/* T = line type, XY = status, SSSS = submodule state */
+		if (len < strlen("T XY SSSS"))
+			BUG("invalid status --porcelain=2 line %s",
+			    str);
+
+		if (str[5] == 'S' && str[8] == 'U')
+			/* nested untracked file */
+			*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+
+		if (str[0] == 'u' ||
+		    str[0] == '2' ||
+		    memcmp(str + 5, "S..U", 4))
+			/* other change */
+			*dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+	}
+
+	if ((*dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
+	    ((*dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
+	     ignore_untracked)) {
+		/*
+		* We're not interested in any further information from
+		* the child any more, neither output nor its exit code.
+		*/
+		return 1;
+	}
+	return 0;
+}
+
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1909,39 +1948,10 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 		char *str = buf.buf;
 		const size_t len = buf.len;
 
-		/* regular untracked files */
-		if (str[0] == '?')
-			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-
-		if (str[0] == 'u' ||
-		    str[0] == '1' ||
-		    str[0] == '2') {
-			/* T = line type, XY = status, SSSS = submodule state */
-			if (len < strlen("T XY SSSS"))
-				BUG("invalid status --porcelain=2 line %s",
-				    str);
-
-			if (str[5] == 'S' && str[8] == 'U')
-				/* nested untracked file */
-				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-
-			if (str[0] == 'u' ||
-			    str[0] == '2' ||
-			    memcmp(str + 5, "S..U", 4))
-				/* other change */
-				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
-		}
-
-		if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
-		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
-		     ignore_untracked)) {
-			/*
-			 * We're not interested in any further information from
-			 * the child any more, neither output nor its exit code.
-			 */
-			ignore_cp_exit_code = 1;
+		ignore_cp_exit_code = parse_status_porcelain(str, len, &dirty_submodule,
+							     ignore_untracked);
+		if (ignore_cp_exit_code)
 			break;
-		}
 	}
 	fclose(fp);
 
-- 
2.39.1.519.gcb327c4b5f-goog

