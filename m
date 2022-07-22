Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F859C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 23:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiGVX3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 19:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiGVX3F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 19:29:05 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D3189663
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 16:29:04 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id e16so4733692qka.5
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 16:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j1PMUcRbh1bOYeHHzJ0w27ek980Hz7XLkEwL82JGjt4=;
        b=CJGbkIGXk4gyl6nbkeG5Ejn8rPD7+c19wpgRrK3LsXTg06s9YYcIIj1BvhqLnhA6Cu
         GI/ybXf18FUD2RxN5kJYJ4fOMHA83maQGl30zdBrp7qEFBwOkl3hdKqFD5nIztzjQxls
         MzK3ST3DUB8tFW/CsUIoQRb6T55SHXuTHqyBmD1pJk+ZBM24zmqoLl7TwkmY6au3y5TA
         ZGink++D2+XhD+K9JEmijY66JRUrD1wQX8Cv5CMPenF16hHfQbpDnO7TyH1FAFCi0p2D
         VKUYp+lNNphXFzMlWUnYJmx5hgxZL/91OU+mGYSMyj+XPwTgb/hbyElzlSUJ/WH1ocjo
         IE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j1PMUcRbh1bOYeHHzJ0w27ek980Hz7XLkEwL82JGjt4=;
        b=gYeVDBKLKYrnQLBe5C9moMj59F1a3265T3hR/EfWHviX/GellnK6xqMiCWIoEE3qLw
         O2h97vb27BiHjj/34i5P8qID+3OxEZ0xBLCkqUoF7mMo6H6MY+llWuqZL/7XDOdCPN+I
         v9cnjriHkwCPVhnA7j43OJxvFVV04pu8HDFcWHwKiNiRTV26e9x0sL1vdrplBFo/KDUJ
         H5D6ZOOi5OtNbfq0vl/SHFu0jxcmfTmlg2y4mq23HmpEKzPAzBjmRdbDmeUesqv8EuJF
         OPA8pib5QHVANgUuHrvUeDXcOR2ENKaX/Fnum6eXSRfENQXFYNkkQbvuKQgPOjHNjidv
         KHyA==
X-Gm-Message-State: AJIora9SbjIWNOmyDOtuj8EbSoEatqsPFMxf4jqCM+25a4t9MmtjwgFC
        HfJAn6rRhLBo6vIZHvbkF/8MJqCQ2vzG5Q==
X-Google-Smtp-Source: AGRyM1tQk6DjpCykirm6mAW4L169aao33r6UxA/ubYcqIEnN1QwsC9uk9m3DdWYRZSSc5P67QF4XVQ==
X-Received: by 2002:a37:c407:0:b0:6b5:f51f:e0b3 with SMTP id d7-20020a37c407000000b006b5f51fe0b3mr1797320qki.619.1658532543936;
        Fri, 22 Jul 2022 16:29:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ew5-20020a05622a514500b0031ecb90454fsm3682605qtb.70.2022.07.22.16.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 16:29:03 -0700 (PDT)
Date:   Fri, 22 Jul 2022 19:29:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH 1/2] t1006: extract --batch-command inputs to variables
Message-ID: <7c1ad1f02285841d287445abe2ba9b4cb3d8a456.1658532524.git.me@ttaylorr.com>
References: <cover.1658532524.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1658532524.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A future commit will want to ensure that various `--batch`-related
options produce the same output whether their input is newline
terminated, or NUL terminated (and a to-be-implemented `-z` option
exists).

To prepare for this, extract the given input(s) into separate variables
to that their LF characters can easily be converted into NUL bytes when
testing the new `-z` mode.

This is consistent with other tests in t1006 (which these days is no
longer a shining example of our CodingGuidelines).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t1006-cat-file.sh | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index dadf3b1458..01c0535765 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -418,6 +418,12 @@ test_expect_success "--batch-check with multiple sha1s gives correct format" '
     "$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
 '
 
+batch_command_multiple_info="info $hello_sha1
+info $tree_sha1
+info $commit_sha1
+info $tag_sha1
+info deadbeef"
+
 test_expect_success '--batch-command with multiple info calls gives correct format' '
 	cat >expect <<-EOF &&
 	$hello_sha1 blob $hello_size
@@ -427,17 +433,18 @@ test_expect_success '--batch-command with multiple info calls gives correct form
 	deadbeef missing
 	EOF
 
-	git cat-file --batch-command --buffer >actual <<-EOF &&
-	info $hello_sha1
-	info $tree_sha1
-	info $commit_sha1
-	info $tag_sha1
-	info deadbeef
-	EOF
+	echo "$batch_command_multiple_info" >in &&
+	git cat-file --batch-command --buffer <in >actual &&
 
 	test_cmp expect actual
 '
 
+batch_command_multiple_contents="contents $hello_sha1
+contents $commit_sha1
+contents $tag_sha1
+contents deadbeef
+flush"
+
 test_expect_success '--batch-command with multiple command calls gives correct format' '
 	remove_timestamp >expect <<-EOF &&
 	$hello_sha1 blob $hello_size
@@ -449,13 +456,8 @@ test_expect_success '--batch-command with multiple command calls gives correct f
 	deadbeef missing
 	EOF
 
-	git cat-file --batch-command --buffer >actual_raw <<-EOF &&
-	contents $hello_sha1
-	contents $commit_sha1
-	contents $tag_sha1
-	contents deadbeef
-	flush
-	EOF
+	echo "$batch_command_multiple_contents" >in &&
+	git cat-file --batch-command --buffer <in >actual_raw &&
 
 	remove_timestamp <actual_raw >actual &&
 	test_cmp expect actual
-- 
2.37.0.1.g1379af2e9d

