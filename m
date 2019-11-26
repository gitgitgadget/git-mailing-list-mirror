Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6243C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6262075C
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwUGTWHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfKZBSE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:04 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40459 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZBSE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:04 -0500
Received: by mail-pl1-f193.google.com with SMTP id f9so7346345plr.7
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/2KT3kKWIIcN5EEEvD1lTeDl+prBaH3cSls3K6bAnXc=;
        b=lwUGTWHxMYLfdq5Ap70vDbyvyx684Knfm2dl08UNYjAVhHFI0886wzHanISrW1W+1z
         7bTvfmI8+Y6bkpGjPXZVYs2+2CaI7nfMb/EvztuTXTHp62XjIbm5SI2BFljgL9Aj2YFX
         SsevAdk+Xg6T91DDXmLQwIa478ZJpI68iVf1xtN8oopLRKk0/xjHJexcE5IkBVLucRRc
         zr6mzYSq8Je2IguRI4noHw7atVVvxS89oLzRlpko4lSQpTtO32kR6TTtj0TEALUz3baI
         EtW50zPGE99787No42QJ4qf6+i6elfO6I1VeMHpOYFmhK0BxRYe5eANVNG7Y2XNCFEMC
         zVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/2KT3kKWIIcN5EEEvD1lTeDl+prBaH3cSls3K6bAnXc=;
        b=hRwx0saNWD5Rdjm+WCteMo5t3ck4rIiUpGTSR/an6z/HDBa/sMcsEp6KqvHDEg+Pow
         +C0is2tWSbrBb1Z4gm9XTffZo3vt04UqLrvjNXV4TeRbkBGFGuSrL/Eyc9LCzbocpRuE
         3yEawamZXxKNkfIzAK4BJG2SL8SQ7UCVs5PbjONTGH/LG1pJJvWxaal6nLmZp8b1iL2u
         yEhUPoiB5bUxDRHQpUhKUGIEh/F4EKbIGPUmvFpy/9iyiH1fYw+G4uW7hfQk5iPaBJ7r
         q5SMCBGgaCPucjNZywUliJGs2AOKL9i8KOgJe700nScn41L2mNvbNogqfEohcTCZ3zbf
         hDxA==
X-Gm-Message-State: APjAAAUFNrdSJtLJw/VhcVrLQpOa4QdgeCFdEAJxG0PJo6Cw07U/vhAW
        I0l/7JfSiINsbku6WA1wAvwIalUf
X-Google-Smtp-Source: APXvYqwxO+afe3nfs55lDLAhYZI3UODWGqQNwEdGYlDISDxEaBYcUZ/0eGpKJdnUJTYcS70rBUn7Aw==
X-Received: by 2002:a17:902:6ac9:: with SMTP id i9mr31862894plt.218.1574731083208;
        Mon, 25 Nov 2019 17:18:03 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id x2sm9369828pge.76.2019.11.25.17.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:02 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:18:01 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 07/27] t3600: stop losing return codes of git commands
Message-ID: <a8aeca67956f503829ac1f16072782ae5a906dd8.1574731022.git.liu.denton@gmail.com>
References: <cover.1574449072.git.liu.denton@gmail.com>
 <cover.1574731022.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574731022.git.liu.denton@gmail.com>
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
2.24.0.504.g3cd56eb17d

