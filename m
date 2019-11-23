Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2805C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 20:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77289206D4
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 20:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocztfXI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKWUuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 15:50:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40834 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKWUuu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 15:50:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id y5so11531168wmi.5
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 12:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hHFvvbIn1O6VwxZ7J7VuwfsfwCwc0My19qUDxtb0A1A=;
        b=ocztfXI7FpwcUR7+AG/n11iMvVhWij2R+ItBkPZZvs8ct6/qA+gDcXEEX59wDU81kd
         G8auQbQhq7jbsblZa/oEMUUufr6I25o3DjOuZ8YlTBOYiOMkIIXtuqw4XViAuJUeJ6U2
         zs6txJr9pQIlxJF1EL/OX3gO488uWNzu3ujCXrZO9ZRXkJGejW6CEuVbzMEYXubmck9H
         F1MSPbgV3RwNEzy3h9i6d/hGH9kwXs8WGNdFt0bzTP9C57wt18ej2X6hAVp0VjWrL7/l
         35sp78u1MO7VzOjkFvGlFooBO5cMcMaJ3/aRZZF00XfCNHmJ6xh6zwZkJIwM2DWwwSzS
         q+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hHFvvbIn1O6VwxZ7J7VuwfsfwCwc0My19qUDxtb0A1A=;
        b=XzSb05ydhpBFEzUL/72lzAW1oKghMsJUd566C0w6mp9g03v5AfwZaOSpUDi8IDDgMQ
         TY5s7czRpMwFeZDg5D3TQIggMRgry6POZMypwVLcSM1xGd+7jPI136rEpA9V2yGqMphV
         mqoMWgM3BpvCfJfj0bgeRJBEAL4H6HNrocako5a1Q/ZSTFHbmfH5pFV5gkdc+Sh/0dYd
         anEtN8sg3N+JWRPXiVkkXYig9OEuEYoo7xo/TYj+EM8Oujp5oSOQuEG/TFIWGgPrjl0G
         xZ7m+bcuwbzGNQ+PWCIIBF8LNZWlWO3aCYTxR+aHZYfzlbwTEMMHhY6vx9ORAb3JlyiK
         goYA==
X-Gm-Message-State: APjAAAXaiQKshzIOGC7cZIu46/txPGp5CbJnEbpvGf+mSEH0Kd58hkdB
        6++ELKyxuz04NKdrFa9j7TUum3Sr
X-Google-Smtp-Source: APXvYqxaM29JGxJsFj0ELHOSfmxWdiq21DHhiHrQiI4Zaw0I6hpx2RuAbM/ZCUmoKRhg5d0SNuL1wQ==
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr1782738wmo.13.1574542248578;
        Sat, 23 Nov 2019 12:50:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u203sm3007117wme.34.2019.11.23.12.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 12:50:48 -0800 (PST)
Message-Id: <b7ba83969da8fd2db4e6074d5044938c05b992fd.1574542243.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.git.1574542242.gitgitgadget@gmail.com>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 20:50:40 +0000
Subject: [PATCH 6/8] git-svn: drop support for `--preserve-merges`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We already passed the `--rebase-merges` option to `git rebase` instead,
now we make this move permanent.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-svn.txt | 1 -
 git-svn.perl              | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 6624a14fbd..6cfd48c9d3 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -678,7 +678,6 @@ config key: svn.authorsProg
 --strategy=<strategy>::
 -p::
 --rebase-merges::
---preserve-merges (DEPRECATED)::
 	These are only used with the 'dcommit' and 'rebase' commands.
 +
 Passed directly to 'git rebase' when using 'dcommit' if a
diff --git a/git-svn.perl b/git-svn.perl
index 4aa208ff5f..f1fa1bc7f7 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -271,7 +271,6 @@ sub _req_svn {
 			  'fetch-all|all' => \$_fetch_all,
 			  'dry-run|n' => \$_dry_run,
 			  'rebase-merges|p' => \$_rebase_merges,
-			  'preserve-merges|p' => \$_rebase_merges,
 			  %fc_opts } ],
 	'commit-diff' => [ \&cmd_commit_diff,
 	                   'Commit a diff between two trees',
-- 
gitgitgadget

