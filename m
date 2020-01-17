Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4851C33CB3
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 15:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB19E2073A
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 15:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZpZOQk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgAQPbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:31:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53164 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgAQPbs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 10:31:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so7866650wmc.2
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 07:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HBZHumwHt+Y6QwIB5QMM6mYnLZ9laHU4OJUy6qrcDoI=;
        b=HZpZOQk9CMVD1BOR9f5wfMhh7nbhpE0pjUBkILv5lOEdRsvQhSl0YB/6+ngmJ0O6+v
         8RW0U2RHpHuN73hXPO8rmwWiN2w/koJS0LiFUn85mYQy+NGQwKxCnuZ+hdOA2GvnpvRu
         5KE+E0F5kjFtvk5npCphHcT7AojSM8DEggh3iSf1wDDkUK6VRLQzx54FpYBqRQ1cpAgo
         +UApJKUUteR5u+K98Y8DgCtuwOrWx20RrWfjIGZiuukX7VjYmo2SFB8OtQvzduEiYt6i
         n7b2CLaDdVCDRbNGkXoBnZvDrV+Pn6CJPSJKbaAdA/g/OVKQa1ICtEmkstpOiZA8r1Vt
         iGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HBZHumwHt+Y6QwIB5QMM6mYnLZ9laHU4OJUy6qrcDoI=;
        b=uAp+uto4wDk4Qk+0xlaf3as8KQWU2rT7/a0hlmXPHgPyHBfmfCU2TxQ6/EyS9epcOC
         3Ld9rszl+XIzypZx+PxO95ud8Qvh/LSdmDjWfPXGMjySdc1dmKL7f0x/py1TT1QVHYhX
         PgiM3Yk8PqxqdMId9jIbZST4zVOxA8QZaaGxGBsFpUg/fZOtHYcfd0t/3VuBNIPrljH3
         3T5ueJy+s3B6VTvgwT7De2y5gHMYAE+lZWnxdtzRU7Vs8YqQZKeZ7Cv2OUfWzej0WRm/
         S750s0tBdf3iMDv8rLhHnmFS91/kOwSXfqF0IvTy9Flmys6wtqbKTyrVm26WzFk2HG15
         Az6Q==
X-Gm-Message-State: APjAAAUIr01XaeIL75HIWX9oQG5BViFbkLDF1ZZhV7S9obvizzvn9IQV
        cVoAvhgmJUqtljgmNQ5JQpunFdVG
X-Google-Smtp-Source: APXvYqzrtbbDNNXhHAVhqidOYNW+di9XsZeBKXa9Rpufq56JpmtkloTG5uIU7OFkZCU6ZyQZY56isA==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr5327171wmg.92.1579275106208;
        Fri, 17 Jan 2020 07:31:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm34380740wrm.65.2020.01.17.07.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 07:31:45 -0800 (PST)
Message-Id: <97b8a7641d1ae76b9b4766a8f96c77af1aff55f5.1579275102.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
References: <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
        <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 15:31:41 +0000
Subject: [PATCH v3 3/4] config: clarify meaning of command line scoping
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

CONFIG_SCOPE_CMDLINE is generally used in the code to refer to config
values passed in via the -c option.  Options passed in using this
mechanism share similar scoping characteristics with the --file and
--blob options of the 'config' command, namely that they are only in use
for that single invocation of git, and that they supersede the normal
system/global/local hierarchy.  This patch introduces
CONFIG_SCOPE_COMMAND to reflect this new idea, which also makes
CONFIG_SCOPE_CMDLINE redundant.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 config.c               | 2 +-
 config.h               | 2 +-
 t/helper/test-config.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 447a013a15..f319a3d6a0 100644
--- a/config.c
+++ b/config.c
@@ -1737,7 +1737,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 		free(path);
 	}
 
-	current_parsing_scope = CONFIG_SCOPE_CMDLINE;
+	current_parsing_scope = CONFIG_SCOPE_COMMAND;
 	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
 		die(_("unable to parse command-line config"));
 
diff --git a/config.h b/config.h
index 284d92fb0e..f383a71404 100644
--- a/config.h
+++ b/config.h
@@ -300,7 +300,7 @@ enum config_scope {
 	CONFIG_SCOPE_GLOBAL,
 	CONFIG_SCOPE_LOCAL,
 	CONFIG_SCOPE_WORKTREE,
-	CONFIG_SCOPE_CMDLINE,
+	CONFIG_SCOPE_COMMAND,
 };
 
 enum config_scope current_config_scope(void);
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 6695e463eb..78bbb9eb98 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -48,8 +48,8 @@ static const char *scope_name(enum config_scope scope)
 		return "repo";
 	case CONFIG_SCOPE_WORKTREE:
 		return "worktree";
-	case CONFIG_SCOPE_CMDLINE:
-		return "cmdline";
+	case CONFIG_SCOPE_COMMAND:
+		return "command";
 	default:
 		return "unknown";
 	}
-- 
gitgitgadget

