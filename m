Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BD9C2D0CE
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 15:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED4320748
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 15:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPtSCtQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfL2Ptz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 10:49:55 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32793 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfL2Ptz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 10:49:55 -0500
Received: by mail-ed1-f66.google.com with SMTP id r21so30177464edq.0
        for <git@vger.kernel.org>; Sun, 29 Dec 2019 07:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VBZWsDn4xn7LEsmnM9xarC6jwQZRkfZuuYa6ILSiOc0=;
        b=ZPtSCtQAmIs2EGQyZB7xXgjDFNtYklQyjo44JdESJwXQHGldY0WmhGC8W/Tpaq0qTR
         ulw/jSDUiLKix6uJOyrdBbHJM56PcxGtM6lGyIEZtE/FmcNKhSjSC/+GQBO0mD+0U3cI
         uYNDs+Dbz4MdPrR/FbA9niI8TT4QQo/RYnb0IDlXEWSNNPQrCJ9sudjrPpIROQ+U0k4I
         R5TRWeXdWuGzw9hdx07uPykkS4F7dq+aenvlH5l4MKHORxw7MY+PPdeGZR+AfuxOx+WN
         Eja21x5Mggvwn1uU6qA4mFo1CzUkX7WB45qY6DASl+xgDhUFCBPvtOfTsodgHQ1eopKb
         3r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VBZWsDn4xn7LEsmnM9xarC6jwQZRkfZuuYa6ILSiOc0=;
        b=oBD8AHxh3fagmTKPSFANS58Rpo0TmxnXwtzL/AgRl0CHaQ45gwNp3D+m4xu84w49/c
         jnwlPoQ0T4V5BA8hBeXH1xhTiOlfjykRoSUR/3lyg4Y1Zh/efkG0kca6bhImP+XxRVsD
         /IeQ1sciIub/Chm9kgRDfFMGLKtj9flWDwVYEPVWv0f5wnMAjCdYvf4o4SWXBp9rSrcq
         2Pyd/4+xpGvBMJsg+ni2hN4mOdOftjAipVe7ZEB8nLeMMTI8nN/s4XS9RjiJ5NjO0f8g
         LfE1GZojC4RYEFV1YAn2bpv1mg3PYUH+mDi8fC6jPvYfuFkL3sauQmHve7wkFTnpuVKe
         5FIA==
X-Gm-Message-State: APjAAAWGV3ssSgooNsXepXtgy9Mhv5YqrWrCErZIYODOqujWOMA5+UU6
        OB9iKLLofqZSCFxiVTJXNC5uzy5d
X-Google-Smtp-Source: APXvYqwNemGuyu6N8gebbnxa0geUzUkNRgb8ZRdDZwnMncNn7YSE8SyRxj0DuOQ/lcYGNVklq/Nadg==
X-Received: by 2002:a17:906:504d:: with SMTP id e13mr66583040ejk.103.1577634592892;
        Sun, 29 Dec 2019 07:49:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e1sm5004790edn.86.2019.12.29.07.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Dec 2019 07:49:52 -0800 (PST)
Message-Id: <547b3087ac2e8e05af86b4b9972cef8c20da1cdf.1577634590.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.git.git.1577634590.gitgitgadget@gmail.com>
References: <pull.684.git.git.1577634590.gitgitgadget@gmail.com>
From:   "Jack Bates via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Dec 2019 15:49:50 +0000
Subject: [PATCH 1/1] diff-highlight: highlight range-diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jack Bates <jack@nottheoilrig.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jack Bates <jack@nottheoilrig.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jack Bates <jack@nottheoilrig.com>

Piping `git range-diff` through diff-highlight currently has no effect,
for two reasons:

  1. There are ANSI escapes before and after the `@@` hunk headers (when
     color is enabled) which diff-highlight fails to match. One solution
     is to match both escapes (`/^$COLOR*\@\@$COLOR* /`). This patch
     drops the trailing space from the existing pattern instead.

  2. Unlike `git log`, `git range-diff` diffs are indented, which
     diff-highlight also fails to match. This patch allows hunk headers
     preceded by any amount of whitespace, and then skips past that
     indentation when parsing subsequent lines, by reusing the machinery
     that handles the --graph output.

Signed-off-by: Jack Bates <jack@nottheoilrig.com>
---
 contrib/diff-highlight/DiffHighlight.pm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
index e2589922a6..74f53e53c9 100644
--- a/contrib/diff-highlight/DiffHighlight.pm
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -90,7 +90,8 @@ sub handle_line {
 
 	if (!$in_hunk) {
 		$line_cb->($orig);
-		$in_hunk = /^$COLOR*\@\@ /;
+		$in_hunk = /^( *)$COLOR*\@\@/;
+		$graph_indent = length($1);
 	}
 	elsif (/^$COLOR*-/) {
 		push @removed, $orig;
-- 
gitgitgadget
