Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D10C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6159620855
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4zeg+sX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKUAqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:46:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40518 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfKUAqF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:46:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id r4so692072pfl.7
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=soyiRzXyDUGnwCMGzq8hCNBD6ofmVvMZ6yxcpywmkWQ=;
        b=D4zeg+sXNFdNeL/sG8oZLt+ccJ3RJ0tkO03NAd9alc8PJpVgzc84oA4rgnyJ9D7cMH
         fwy66kJ7/uspGWYTJqyTHIZMY9Y8DIl9qWe0VPnqFNSmAaIgSLabb5B4k7ai4uhCtE70
         5nywwAy37XpKgBjnAVz/wPgaEZyiTPm05wKmasfo4mKSi3RIN1HBAdWWG9KjETqORTcL
         SUu1TMd8PM9I1YvyEDnhgp2bGY8yGt39me/5hvc4BCvMsJWy1BdYNMyZHlrGQjYB4eWQ
         QS7TG9P/HipbojHjG1C1DVv3Z6dIfvb+1OAJ8tZcYBh+gT3sS/9b00QDdxKZtsJN58o0
         4p0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=soyiRzXyDUGnwCMGzq8hCNBD6ofmVvMZ6yxcpywmkWQ=;
        b=UuPNQAgokIxbk8T9gVmUIMMYrHimb6SfJj+2HvE2F7unqOasAeNUtoGZ8NJYlCK1go
         LGOLfw7OyKn7BWqGRXu/wYT87OgnL9UudzXoQE57d07dmqbb5IAhqI2HUoxhm/DAveqC
         4LSOg3hxwrcni3tAhwZgxVib7/LBRWqh6w253HNOzWlRdPn02WbYfwa34OlF6SdF2sYc
         3y/3OKStE3WnAcm+E0dpgxJkHyoZpy1PepTqoxmE94jBPSe77XHoOwzAYMUtSeX4yAcL
         hZZXuevVopd5gXirURGarRh5lSCD7N77x/gvxv6CiCwG7UgFxpLuYCU0qwMezOm4m2eO
         45eA==
X-Gm-Message-State: APjAAAWPV2rglJIpAeBs9zEkmfAiB1wO+rRbbu9G8VWY0NqTVFs51c9X
        Yp2DxYknNYf2CrdjvGVmw5iBuPwZ
X-Google-Smtp-Source: APXvYqziU2RvBUnAmprFgYXikbWqNLvJ1yupIyBSryGtA1//hkEyq2ec6jRjpAUBvoWPwESjfSc/6A==
X-Received: by 2002:a63:e03:: with SMTP id d3mr6199892pgl.395.1574297162823;
        Wed, 20 Nov 2019 16:46:02 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id b1sm420225pjw.19.2019.11.20.16.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:46:02 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:46:00 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 06/21] t3600: stop losing return codes of git commands
Message-ID: <e0152ff3c1935969a97bc5bdb9831a277bc8f95d.1574296987.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
 <cover.1574296987.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574296987.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a command is in a non-assignment command substitution, the return
code will be lost in favour of the surrounding command's. As a result,
if a git command fails, we won't know about it. Rewrite instances of
this so that git commands are either run in an assignment-only command
substitution so that their return codes aren't lost.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3600-rm.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index f6e659b7e9..0c3bf10edd 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -304,7 +304,8 @@ EOF
 
 test_expect_success 'rm removes empty submodules from work tree' '
 	mkdir submod &&
-	git update-index --add --cacheinfo 160000 $(git rev-parse HEAD) submod &&
+	hash=$(git rev-parse HEAD) &&
+	git update-index --add --cacheinfo 160000 "$hash" submod &&
 	git config -f .gitmodules submodule.sub.url ./. &&
 	git config -f .gitmodules submodule.sub.path submod &&
 	git submodule init &&
@@ -623,7 +624,8 @@ test_expect_success 'setup subsubmodule' '
 	git submodule update &&
 	(
 		cd submod &&
-		git update-index --add --cacheinfo 160000 $(git rev-parse HEAD) subsubmod &&
+		hash=$(git rev-parse HEAD) &&
+		git update-index --add --cacheinfo 160000 "$hash" subsubmod &&
 		git config -f .gitmodules submodule.sub.url ../. &&
 		git config -f .gitmodules submodule.sub.path subsubmod &&
 		git submodule init &&
-- 
2.24.0.450.g7a9a4598a9

