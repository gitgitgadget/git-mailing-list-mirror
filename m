Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85EDC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 08:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiGMIVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 04:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiGMIUy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 04:20:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F65925D
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 01:17:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v16so14349663wrd.13
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 01:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4Tw8JMS93seMMEXfT7K8viiPKPAk89Q55r71vg/UjR0=;
        b=Duw3qViC3y2gtzTsFeQJ2qeV5BsYupWeC3unWHQupMQ7TaCEk0bnUaH45tKIYHMwfM
         sde7O207GKKkM2W6iEp+vFw07TpXFQjHyuOqbiRozI7Pf/HDAUcAf6fAj5rEeW+HdxH1
         bFT0/2ys54Xr/HPLdkoTj9PPax5DQLcLdQ7FtZ3BaqUCkugc0AzhO1qiLIldMYuJ5+SH
         eryxfZ2i+QSbtiVrBIQcaK1XHlpio718JDXS+ZsoZ6ZOSS1pgMuGw8rfotYvdPzmd/pO
         sObgMiF+suyLY6C93wA9VCze9Ia2LOBNCS2gCbg7woj7Eabu0HnH/A+IllPCaMkqDfKf
         zG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4Tw8JMS93seMMEXfT7K8viiPKPAk89Q55r71vg/UjR0=;
        b=xpbHzOzrobmAcJEElM1GD4iTLb3mhxP2NE65AFb+6GNUoGWAUkailAOuIIL+v5tBM4
         pRuloFU0P/PL5Fp37g9ZKe0AlaOxWHJwgSq4cuXLvrm3C3v3LzzSE5V+FbaxXt5nHhiU
         wFnG7SoF6sFgDIFpsQJqLVubhy0e9/UCsC+VXLCmFee8q+ltM4EFw5iHkl/FaoKvlgfH
         SZuTiJsIDlYgtmpgnoYngwqKrK0gDCh5NNYq0aCvINSGeXNrdFVmgTWqaNLxidSIeY3X
         JTWJRzYFZ9OgDrgUn15+hRR/ve67A4HpvuBHdBjaXGjdRZWdS27vqLjc37TNs1Zt63yI
         WOhA==
X-Gm-Message-State: AJIora/00hZ35MT6yt9Ou4ru+6tDJtG9387kS7mwNYMehK7yjjLtub2J
        3oV6pYCGkQP+6efiGedHHnOt5JZJBvw=
X-Google-Smtp-Source: AGRyM1tW+wjD5PCn/KgnV2lX1bkRPK0TgVbwmByP/snNcnzWsXRRjN/kmtonh6HCbnS5+NUDgjQt5A==
X-Received: by 2002:adf:da45:0:b0:21d:8f3e:a3e0 with SMTP id r5-20020adfda45000000b0021d8f3ea3e0mr1978702wrl.310.1657700240612;
        Wed, 13 Jul 2022 01:17:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bd20-20020a05600c1f1400b0039747cf8354sm1334902wmb.39.2022.07.13.01.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:17:20 -0700 (PDT)
Message-Id: <3480381b8b99142bcc0213957a43d68a962c52d9.1657700238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1286.git.1657700238.gitgitgadget@gmail.com>
References: <pull.1286.git.1657700238.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Jul 2022 08:17:15 +0000
Subject: [PATCH 1/3] Allow debugging unsafe directories' ownership
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When Git refuses to use an existing repository because it is owned by
someone else than the current user, it can be a bit tricky on Windows to
figure out what is going on.

Let's help with that by offering some more information via the
environment variable `GIT_TEST_DEBUG_UNSAFE_DIRECTORIES`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/safe.txt |  6 ++++++
 compat/mingw.c                | 21 +++++++++++++++++++++
 setup.c                       | 14 ++++++++++++--
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index 74627c5e7c6..18fac9cb7f3 100644
--- a/Documentation/config/safe.txt
+++ b/Documentation/config/safe.txt
@@ -40,3 +40,9 @@ which id the original user has.
 If that is not what you would prefer and want git to only trust
 repositories that are owned by root instead, then you can remove
 the `SUDO_UID` variable from root's environment before invoking git.
++
+Due to the permission model on Windows where ACLs are used instead of
+Unix' simpler permission model, it can be a bit tricky to figure out why
+a directory is considered unsafe. To help with this, Git will provide
+more detailed information when the environment variable
+`GIT_TEST_DEBUG_UNSAFE_DIRECTORIES` is set to `true`.
diff --git a/compat/mingw.c b/compat/mingw.c
index 38ac35913df..912444fb3ab 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1,6 +1,7 @@
 #include "../git-compat-util.h"
 #include "win32.h"
 #include <aclapi.h>
+#include <sddl.h>
 #include <conio.h>
 #include <wchar.h>
 #include "../strbuf.h"
@@ -2676,6 +2677,26 @@ int is_path_owned_by_current_sid(const char *path)
 		    IsValidSid(current_user_sid) &&
 		    EqualSid(sid, current_user_sid))
 			result = 1;
+		else if (git_env_bool("GIT_TEST_DEBUG_UNSAFE_DIRECTORIES", 0)) {
+			LPSTR str1, str2, to_free1 = NULL, to_free2 = NULL;
+
+			if (ConvertSidToStringSidA(sid, &str1))
+				to_free1 = str1;
+			else
+				str1 = "(inconvertible)";
+
+			if (!current_user_sid)
+				str2 = "(none)";
+			else if (!IsValidSid(current_user_sid))
+				str2 = "(invalid)";
+			else if (ConvertSidToStringSidA(current_user_sid, &str2))
+				to_free2 = str2;
+			else
+				str2 = "(inconvertible)";
+			warning("'%s' is owned by:\n\t'%s'\nbut the current user is:\n\t'%s'", path, str1, str2);
+			LocalFree(to_free1);
+			LocalFree(to_free2);
+		}
 	}
 
 	/*
diff --git a/setup.c b/setup.c
index 9dcecda65b0..3ba42ffcb27 100644
--- a/setup.c
+++ b/setup.c
@@ -1353,13 +1353,23 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	case GIT_DIR_INVALID_OWNERSHIP:
 		if (!nongit_ok) {
 			struct strbuf quoted = STRBUF_INIT;
+			struct strbuf hint = STRBUF_INIT;
+
+#ifdef __MINGW32__
+			if (!git_env_bool("GIT_TEST_DEBUG_UNSAFE_DIRECTORIES", 0))
+				strbuf_addstr(&hint,
+					      _("\n\nSet the environment variable "
+						"GIT_TEST_DEBUG_UNSAFE_DIRECTORIES=true "
+						"and run\n"
+						"again for more information."));
+#endif
 
 			sq_quote_buf_pretty(&quoted, dir.buf);
 			die(_("detected dubious ownership in repository at '%s'\n"
 			      "To add an exception for this directory, call:\n"
 			      "\n"
-			      "\tgit config --global --add safe.directory %s"),
-			    dir.buf, quoted.buf);
+			      "\tgit config --global --add safe.directory %s%s"),
+			    dir.buf, quoted.buf, hint.buf);
 		}
 		*nongit_ok = 1;
 		break;
-- 
gitgitgadget

