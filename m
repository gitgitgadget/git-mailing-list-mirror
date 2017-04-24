Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371D51FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 10:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1168329AbdDXKBy (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 06:01:54 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35907 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168314AbdDXKBn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 06:01:43 -0400
Received: by mail-io0-f195.google.com with SMTP id x86so47692134ioe.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 03:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nQvkyRWM7WynVayE1QNFV2THnSlP6LBbNoIXP5r3SI0=;
        b=Zo/nYV1Nv8buO1NSNw/AmnmlX2jqL4MprvA64O9gcdyZL27poCbZjGQTq9Ajnbbxjm
         cyLJHFVwONhlq0dQieiZCcn1h/u7NN/RgIylVQYrJLHGwwwDj064leiOz7VV/Lk9jJc8
         4DsgvOz+HD8LA/YBMW58jEmChNMMXbfmpNJR+fKGXUjdskjm38hXozdl2Q35IK1+x4Pq
         iqP0pXbnHqlGOrPYpQgMsky0ewbJqSDrPzqfatZzhFNX6+0Ly+ZQ9vIt88KTKmpHmzEM
         zJFhrwol4Xf+fKaPhyMvbwnlx/5ULCXjJwh8NvvRBHMyZYrW6schdOUIGMQq17NduZ+P
         MgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nQvkyRWM7WynVayE1QNFV2THnSlP6LBbNoIXP5r3SI0=;
        b=XRlKhEenM2k33IYQbqEU1a9lqgMl5uj7F1+YGp5/qol3MBW3ACTvgefNuqT6XsxF6B
         VHjeDFYMg2NBliOU/5NZknkODeTQ4cM4yO8VjRZsqwYVMS/m8aayHBbvXnVebZuHpRqT
         xK9O1ss5DnNHEZllawBq/70iBtisJnMxSahSh4GSjrbECSmVj9MMnQRJpOYOB1OGDhR6
         z+A4MabKON00YUWQMfGaw6Y7sr4C3UqVeCx+pTIXcWkn9a1dtoQW2KX0QfuFP7ex1M+5
         N09xFGAqkRkNCmprubdDjY6QYNRVj22kmUQ8j1X7I49lwV03Eb05BjthJ3g/WOCOii68
         ttLA==
X-Gm-Message-State: AN3rC/6RgauMC3Z4HrdaGs151ka/o19ZHpq+4F9YiqFKyjIdcSu/17zH
        cj1bYPHKRd5S6Zk6
X-Received: by 10.98.24.213 with SMTP id 204mr23354541pfy.237.1493028102858;
        Mon, 24 Apr 2017 03:01:42 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id w5sm17977390pfd.23.2017.04.24.03.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 03:01:42 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Apr 2017 17:01:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 1/6] environment.c: fix potential segfault by get_git_common_dir()
Date:   Mon, 24 Apr 2017 17:01:19 +0700
Message-Id: <20170424100124.24637-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170424100124.24637-1-pclouds@gmail.com>
References: <20170404102123.25315-1-pclouds@gmail.com>
 <20170424100124.24637-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

setup_git_env() must be called before this function to initialize
git_common_dir so that it returns a non NULL string. And it must return
a non NULL string or segfault can happen because all callers expect so.

It does not do so explicitly though and depends on get_git_dir() being
called first (which will guarantee setup_git_env()). Avoid this
dependency and call setup_git_env() by itself.

test-ref-store.c will hit this problem because it's very lightweight,
just enough initialization to exercise refs code, and get_git_dir() will
never be called until get_worktrees() is, which uses get_git_common_dir
and hits a segfault.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 environment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/environment.c b/environment.c
index 42dc3106d2..2986ee7200 100644
--- a/environment.c
+++ b/environment.c
@@ -214,6 +214,8 @@ const char *get_git_dir(void)
 
 const char *get_git_common_dir(void)
 {
+	if (!git_dir)
+		setup_git_env();
 	return git_common_dir;
 }
 
-- 
2.11.0.157.gd943d85

