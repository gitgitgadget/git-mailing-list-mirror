Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E4EC33CB7
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 03:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E23420702
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 03:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwrGAz9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgA2Ded (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 22:34:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35803 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgA2Dec (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 22:34:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so18487088wro.2
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 19:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=13JBMANrVvsUvLa1uIVccacj+7/EIVrG8sPbbX6oAeA=;
        b=cwrGAz9Ac+9DO+1iZUtJDHuB9Wv0BobMG11hIfjgFjZndwBqnk9+V51w02m33CSd3J
         08fI97YU7VWgoHCy5WlTI56fZ+RgQNUaw/Ex6fPOpfSB2ehqbfsiEDwIXjIzlp4LbAjo
         E3HbXd7ubPd/+1MP/LQHumJffOqI+VMfjirfFKtAUjFFYV2Bt3Ffrkd9SbOnM0whMdrC
         A/A6R0BRVY9zNoxGWE7qW0/98c46LgzZEoDaSaqdSCvi38HJewMEoCZTrKHYpWl59T5z
         afWDu1NoHnQom28X8WmYDl0tCiy7G8/Kqnq+i1+ibtJ/LS6B16MW1PJdbHCDLstQc2gp
         ULQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=13JBMANrVvsUvLa1uIVccacj+7/EIVrG8sPbbX6oAeA=;
        b=D3n9n+QE+GNxSW2mljtvhEsN6jE6jCZkRBxbwaNWTPYibISkUG3ewxwaThUyxZPH/q
         2DYyVBOGVO6rrrSr55I32fMBpvOg5kz5FW72VvQkc6V0ZTeeoTGj8eu6LdCCYXwjCkbJ
         qg4hgzK+ASlvXZes1lFG1Z/wNe1qxa8ASl3G8g3qxmqGOjNjcwuDBnRoVmcYpSTkU90t
         JZV1cJ3hwozV5aCjBp4axctLne9qYRhEHHQgVgDyoxVojmk3TUOiO1Qbts/4gQZ9ZHrR
         FkSsH/g3SM0fGZZoXoyZPEKpN27JeV7Ls3aBKJFOVXKlGvNOY8SlHbp2mtgoHbJwqEZa
         b6oA==
X-Gm-Message-State: APjAAAXWcYK1hunDSSHS72pU4U+NAnlK7N8sYWzIghZatxmWPjj74ozH
        A8JpjZz/GpT3sgTeZ5gfYppmhQMO
X-Google-Smtp-Source: APXvYqza9LKJm5MPd781aDR0dVEEAe1PklBXHGpIgoBgsnz7QtMvqY/JcapLR0aH0pxOYWRxz4HUHw==
X-Received: by 2002:a5d:53d1:: with SMTP id a17mr30661469wrw.327.1580268870867;
        Tue, 28 Jan 2020 19:34:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v22sm632131wml.11.2020.01.28.19.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 19:34:30 -0800 (PST)
Message-Id: <936ce91c628d018791e7cd74ad60d74ea3f5491e.1580268865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
References: <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
        <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jan 2020 03:34:24 +0000
Subject: [PATCH v6 5/6] config: clarify meaning of command line scoping
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 9c6ae7a8a7..56c1f6dfb6 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -48,8 +48,8 @@ static const char *scope_name(enum config_scope scope)
 		return "local";
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

