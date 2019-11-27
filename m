Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC78EC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EE02082D
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqu7+fS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfK0TxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:53:23 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37072 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfK0TxV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:53:21 -0500
Received: by mail-pj1-f67.google.com with SMTP id bb19so6999085pjb.4
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/2KT3kKWIIcN5EEEvD1lTeDl+prBaH3cSls3K6bAnXc=;
        b=cqu7+fS4yikeY645gXSbHy87iCBV6Dl+U8OELlOyy6/EAREZ2QCcUhdd6d9mmdURMm
         Mab4N7TgjxR6a1Rh3PHOPUZH1jAhH9FZVgGygGoHLMvNQJkW6Qa/Uh7STHwsh0YiXol2
         qAEVWITnd09H4Bmu0Npxsi5AlZJ9GzPH0EXXhBJ3762tQARTbMJQhmXWBXKAasMQnJTR
         VkPH0jlwU07WP6xTffONsvDPPlrNxuTVeASKK4Fqti089iWp7Y8Ufkbqc0Yh+WfPBv7T
         TJptY498OU/CS6uJBAz5EYNpyN6QvW4xDNdlWr0W8zoHKdcKt+s/oP7PpGJKL3tTeqkI
         Pw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/2KT3kKWIIcN5EEEvD1lTeDl+prBaH3cSls3K6bAnXc=;
        b=kq3WPNTb+EqtJN/dDqK5MScRO2bEcRGePV/TbFdgtUOFsbodAucKmshtJdTdXwRaCG
         fybIHn9icLbnY3z4vWQgFRWC6ZB5z53hiONt40eFHHR9QctRvn4ZW3oZ6ZksryQfBztZ
         HqIEY9fp1xCVNvPfglt8gn42A4t0j3+x8BBfn7p2sg7VOj8N6CUFN7x+AhyGeUJtBAnL
         q50lpktPlCvrYZmdMmkSaCHSw9aUC+wTWfKcX4FWcgrdiMjyXtPL9TBCCDuNQAWuoJCM
         qhIU8qKfIop6AJIQJKjSntyicczpfAXd3NJE1oFcaY2RfCMU06YOZkx6qyYVcWHxGr9a
         mGRg==
X-Gm-Message-State: APjAAAWQ56P6jfaWG1/GVb7AN0YkEYSp9Fl6ojMUDE2P6P1u8t3dUaYw
        Qp0w9PRKejhRcCpXRDyvuM6p0t8U
X-Google-Smtp-Source: APXvYqxs6ib+woWrF6+oN+jbWwy8xqlNTbBMsqQmk8TJwQNseG6ZsL+f4ACIfkcRwCRAyIPFAKnPBA==
X-Received: by 2002:a17:902:8e87:: with SMTP id bg7mr6002146plb.134.1574884400565;
        Wed, 27 Nov 2019 11:53:20 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id s7sm2312703pfe.22.2019.11.27.11.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:53:19 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:18 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 07/26] t3600: stop losing return codes of git commands
Message-ID: <a8aeca67956f503829ac1f16072782ae5a906dd8.1574884302.git.liu.denton@gmail.com>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574884302.git.liu.denton@gmail.com>
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

