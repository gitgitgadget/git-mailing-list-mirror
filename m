Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0A6C35241
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 00:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C183214AF
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 00:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr5L1WR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgAXAVP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:21:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33688 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbgAXAVO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 19:21:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so36742wrq.0
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 16:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ksmdrg4a3go4/QbgWJ1+2IjATWUvrCDTye6IPw1qD4g=;
        b=mr5L1WR0c5hhrFBYbE5dwOlPWm0PsZkeJsEkxA76u1nxyulCxuRdzSRhGbfOvnng7W
         g3+Vmt802BZJxrRZMrB2zwHuQqs5qdx2v64kM2DS/xd0ksBEt9QATd6yuQdmSewcMldv
         qlobd/wl9YLaBWLTBl6oalJpd+aSxozRgdPj4UyEu6KdsMrQgERu+rxyvotq4svEWfzb
         X+9S1Z3cBY4LIhZpPnQMRJGy5KTMfmaXyD+OKvMibk2OM2aN9EtLzRhCJL3b5Ix84Bl4
         flKVK/GW6+dXUrjBe03+D5AcgJXj4Ni26BguvFxDiEHCEFyPgnpXXXzb2QQKP+L3+Ghc
         QaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ksmdrg4a3go4/QbgWJ1+2IjATWUvrCDTye6IPw1qD4g=;
        b=i7124yp4da2V2hL7hCMNzUaeRcBfXU+oaDC+Rorhcf0jMHSgbKCo9djCOGuunoSZn9
         7pWRKLseZ6ld42F5+E/fvR5naQh5dVioPuEHavSGIMmqZ8hpKQw49JvXVPZ+1lH22STW
         bi3UrRlHRWUdAf9CGu+rdJqEGKtH6Os6DvEqY7ku9lru4QUi90643M2VUw94KdIXWFLY
         uYcy0Zn6vv6rap4y3eaduKVE+ufWKtqrgKP9PioBewlQxQhUkoB47OJ9Z2JCcdt+wQHJ
         /0CDrGwH2F+aRwBv5PyH/JGEH+JzG6nGeG14QKfrYPH6Nla5ceHfZxXKyGwDSnT/536i
         ETZw==
X-Gm-Message-State: APjAAAXjTVgq8tg4WRDObPC+fCWXST0EgfLWuLzzqK5Kcm3Xm6BmMTuO
        Y8jObkw+u0CM1xTOIMOr3rHGNdh7
X-Google-Smtp-Source: APXvYqwFIhWD5SBt0Lqg7kd8nu2hF+CDDFqazrzzVq/mn6oMiBq2v6TtEBbQeqVpDH0zRvOSvkCWZA==
X-Received: by 2002:a5d:50ce:: with SMTP id f14mr789371wrt.254.1579825272484;
        Thu, 23 Jan 2020 16:21:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14sm5664026wrx.81.2020.01.23.16.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 16:21:12 -0800 (PST)
Message-Id: <7f00f8559d4e1c4d73bdff9136b03bdd8a53e9dd.1579825267.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
References: <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
        <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 00:21:05 +0000
Subject: [PATCH v4 5/6] config: clarify meaning of command line scoping
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
 t/t1308-config-set.sh  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

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
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 90196e2862..fba0abe429 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -265,7 +265,7 @@ test_expect_success 'iteration shows correct origins' '
 	value=from-cmdline
 	origin=command line
 	name=
-	scope=cmdline
+	scope=command
 	EOF
 	GIT_CONFIG_PARAMETERS=$cmdline_config test-tool config iterate >actual &&
 	test_cmp expect actual
-- 
gitgitgadget

