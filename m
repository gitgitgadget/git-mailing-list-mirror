Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04CFC33C9A
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 14:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B647207FD
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 14:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="xsJJ5Ev2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgAEOBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jan 2020 09:01:03 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41017 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgAEOBC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jan 2020 09:01:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id bd4so20816090plb.8
        for <git@vger.kernel.org>; Sun, 05 Jan 2020 06:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D38Z9zRPbCbW2eb/nPjSwRtQAVoQOfED+/wPdX5q5Wg=;
        b=xsJJ5Ev26YxasGWO6dBZ7bkYvJi4erHWuQz8Z9YfixQ/fpifI10ciP++GGvgwxAKJk
         MEy6loHgfxLWfogTuHOaSX+v43NVK5NFIxtq74z+PA+2KvuWGY1VKy1EDZEYnK6VEWUR
         dGU42jwT7egNBCA4cOShLL1GKRN3hG3i6s62R+Iy1ZWAU0SQ3J+zZ3MSx5N0NTK+eaKA
         bV3jr9RmOW9uKda3JAcH2y0nyfk9fAY17+QMGCsW29exoFF8VkDNQWXCFxJ3Ob9P04k0
         PxmDtytxRWd8LaRSu2erfohWUCXntfNURTUWv7xMCwms1KxAN0QRqeqFVDGDk059Eq/O
         FBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D38Z9zRPbCbW2eb/nPjSwRtQAVoQOfED+/wPdX5q5Wg=;
        b=U1rV794h/+i50uMWVqozx/FDMWYqRaYa97bwgpHOKh0k9lUsvp181M7wEGyPHAZdh5
         PxecyH3NnWlQpmNst+wT4mbRsugaY1yt4Y51v0GBe8b9Lvtgu+TaHdSs238VuKxeLk49
         lAYEC/JbrwQw/xMhakmOPe1muGDDRNfARNDq/N0SvgJVz/KU7ZFycRz4QQiChgClVmNA
         XvTdN0pw/EFswqkG3BgdOuOapc+68O7W2D/UCQXoX9HvOdssbsRV7ognJRSpgovZKSAK
         mvAtihlXhLT0briKG8O/tfECrA8KmcTg+5G4C7rlnOtAgxzQ4I8JmxDZy+ntMpw+E44X
         kV9Q==
X-Gm-Message-State: APjAAAV2AKzTLTFuiPfsn0iAOOrvjetnrlJj1MUYXh7+JvWVREhyntKh
        pzRPv+8H6RVKeUkUuzUDHj0NU0JSXZA=
X-Google-Smtp-Source: APXvYqwUwzTfX0921FpEIaHQ8VQUMX0IuieKAff41e78/3CUHfiPMhJVpCt9Tx83ca+mTKmYdoe8Jw==
X-Received: by 2002:a17:90a:e389:: with SMTP id b9mr37424576pjz.7.1578232861906;
        Sun, 05 Jan 2020 06:01:01 -0800 (PST)
Received: from localhost ([202.62.47.81])
        by smtp.gmail.com with ESMTPSA id m6sm20911693pjv.23.2020.01.05.06.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 06:01:01 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH 1/1] editorconfig: indent text files with tabs
Date:   Sun,  5 Jan 2020 14:00:55 +0000
Message-Id: <20200105140055.19679-2-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200105140055.19679-1-hji@dyntopia.com>
References: <20200105140055.19679-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, the .editorconfig did not specify an indentation style for
text files.  However, a quick look for indentation-like spacing suggest
that tabs are more common for documentation:

$ git grep -Pe '^ {4}' -- '*.txt' |wc -l
2683
$ git grep -Pe '^\t' -- '*.txt' |wc -l
14011

Note that there are a lot of files that indent list continuations (and
other things) with a single space -- if the first search was made
without the fixed quantifier the result would look very different.
However, the result does correspond with my anecdotal experience when
editing git documentation.

This commit adds *.txt to .editorconfig as an extension that should be
indented with tabs.

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 .editorconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.editorconfig b/.editorconfig
index 42cdc4bbfb..f9d819623d 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -4,7 +4,7 @@ insert_final_newline = true
 
 # The settings for C (*.c and *.h) files are mirrored in .clang-format.  Keep
 # them in sync.
-[*.{c,h,sh,perl,pl,pm}]
+[*.{c,h,sh,perl,pl,pm,txt}]
 indent_style = tab
 tab_width = 8
 
-- 
2.20.1

