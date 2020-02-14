Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB17C352A3
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC1B20848
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ktMQoQWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgBNBx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:53:58 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:36319 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgBNBx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 20:53:58 -0500
Received: by mail-pl1-f202.google.com with SMTP id bg1so4254424plb.3
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 17:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cX0wSw+SUUTI4SBcSf/co+qSodXsGSCbZOly9kNlUfg=;
        b=ktMQoQWf2j8O/iVPyzTDyZXeDCIPrntyjqomR8YG/0o40Rrb8ZDeIgvFzJwZV4vbBB
         vwQwwJGBrzipndOzhd4bcon9Xw8ONPmiXY6Ms861RXFGkTigZLEVXP8y1ntRxWndhd1t
         TkvcfY18Fus3Jl4wJjYF5Vg/EgEViDAZXmOeebsHEmsHEhN6rrfyZqVkc9RJoHSSvCb1
         WnWFWFBS7Nv0WcEiB1FuPVUw9VSI87Yd97I0uLy9rb53Z2ppKtRXcx5W9jPK9bHxW5kr
         2K69+7DFSekF1/Kl93x3G9A9ZrosZtnfDapk3v5qTVMHpYVwZraZkLMHxs82ES1ycp71
         x5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cX0wSw+SUUTI4SBcSf/co+qSodXsGSCbZOly9kNlUfg=;
        b=lRfe3IZBQNq2O1RA19yK6A8Nrt5sTYyh5derOkv0pkofhA/uUY1EgZwKGD5VVV24N4
         FPKagc3sUw1JoIjYGJxWG+JIMphabrN0RXK0+CkCpWXT6bggaNTLUobJKoIW+1rFt+SB
         5BDKlu2CgLUY/oyoovdEfRsG0UcErCQLTJnsRMJczIL7t2M7qcwZWnlgUytt9YHtFiyr
         Cb2QivcfsfXzAqiJJ1kMVn8VVYIAzeSuYITdHdm6L9qWB26fGYaaTChzGb2m3/4ojorC
         xkP7RU+yilT48/JT07iqAUcK3LhZ/2ZqNFlfBNhZ59UDjjNP/oi1gfVLz6x/y8VnXHao
         g7iw==
X-Gm-Message-State: APjAAAX5IHJ3mQIzvUWF6IHbNfX5To+OWA8SbCLQLZy8qYH2GmKFyxjS
        KkbXOomTys+0cvq4vY4sa8Z7Bs4dmLlZbJLQzWIC0H8De4Y6kj/QQeQy73Cxr+8q7lJ7eyzPM8m
        ch5gQ+MZd1SSIfKbO5j44lIPhLvbrTSYCFuqFHTQED04YiJ0WtTJezUEz8lb+2cwYvJ1AC58OTA
        ==
X-Google-Smtp-Source: APXvYqx90i9mgYEZAFqIonWjINlOwDX/N+ImjhGZhAqIyK/h7Qa/4C/EukzY03ZU0AY+X1NNRf7HVojaWMjr848tp+E=
X-Received: by 2002:a63:3e8f:: with SMTP id l137mr871749pga.360.1581645236297;
 Thu, 13 Feb 2020 17:53:56 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:53:30 -0800
In-Reply-To: <20200214015343.201946-1-emilyshaffer@google.com>
Message-Id: <20200214015343.201946-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200214015343.201946-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 02/15] help: add shell-path to --build-options
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It may be useful to know which shell Git was built to try to point to,
in the event that shell-based Git commands are failing. $SHELL_PATH is
set during the build and used to launch the manpage viewer, as well as
by git-compat-util.h, and it's used during tests. 'git version
--build-options' is encouraged for use in bug reports, so it makes sense
to include this information there.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 help.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/help.c b/help.c
index a21487db77..190722fb0a 100644
--- a/help.c
+++ b/help.c
@@ -654,6 +654,7 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 			printf("no commit associated with this build\n");
 		printf("sizeof-long: %d\n", (int)sizeof(long));
 		printf("sizeof-size_t: %d\n", (int)sizeof(size_t));
+		printf("shell-path: %s\n", SHELL_PATH);
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
 	}
 	return 0;
-- 
2.25.0.265.gbab2e86ba0-goog

