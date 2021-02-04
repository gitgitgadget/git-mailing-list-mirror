Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B27AC433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D99664F76
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbhBDUO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 15:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240012AbhBDUIk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 15:08:40 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425BEC06178B
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 12:08:00 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a1so5050575wrq.6
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 12:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ChGRXI1L+NFDyLh0BtuB3FtiEzfJAQX5KmaKrBGGQ1Q=;
        b=p1VaMxgZuXEiLjiIbLLL1vyHuU2CZRvv9XEHVlcgTL0gYAvlRtiDdJShvreUJmAq28
         ww0loexdnTS3tZzCbSo219AmWvQn3ip9XxPtMHFOLAs1nlhFE4U7y52+A1TWeorlGDfX
         cj6HWTgz5EisY52qlDy5lx41bDBlKeCZN4eV91iqOon0b1gG+B9UGjtO1jd+LlT8ZYwL
         uKDXaUVbCrAPjgcCPsK/B17PY8j095OyvP50zRa9/3ehZp3VTHBZrUB2qeeUF68Pb2PN
         qshnTkzgVwqiZWNw7d9H0ky/O0Zpkg9g/SGjNilNGDp2yzNzQ380etzlGW9uN3I0PJ+m
         HTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ChGRXI1L+NFDyLh0BtuB3FtiEzfJAQX5KmaKrBGGQ1Q=;
        b=MnHZRx1RfeA18EMWHhQAF9s0OimAKYPbxH0xDq0RZXrU3oY+YnvX6tzeYWNZAA7CgX
         HSfhqIiEswdziT3uwIOHQqlG1vpy47nvSWCTC5XQyHtudBGO1ObOrHLxkjvr/DvYfD7t
         kO7xgAGR6W+jh2P7v4d3RQzQilZPgYyNXZ6xgKauqc5thd4SFIczE27zhrqY9O4erE1t
         fRj/w1mifb1P9es/pwB75eBZbvCz/1R6pnmhCQXcMyGpZfbUK8XWiHQ43B1BREHWIm1Y
         wCVyTUka4GMbBXAbn4o2m21BbGOlDA8iACLANFvwX9UXItcDIXv7TCM3Y457Xpimu+mZ
         AD9Q==
X-Gm-Message-State: AOAM530Ll+eMEAMNLkeizW3vMxgD/tBu2ngo+SZtxuBN6wANMpBmZo43
        CXNinGHHRriYbOjukCYKEBOozv5CoIw=
X-Google-Smtp-Source: ABdhPJx0DRG5teri0d/WwOyluJQuc76CeNYs7iglGQElZ2+k4IDFioVaNliL/SeqHsyhwM7Nsodzjw==
X-Received: by 2002:a5d:453b:: with SMTP id j27mr1166484wra.92.1612469278806;
        Thu, 04 Feb 2021 12:07:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o83sm1396537wme.37.2021.02.04.12.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:07:58 -0800 (PST)
Message-Id: <d6c582c25df0ff57072c4170203b77a6334d006a.1612469275.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.869.git.1612469275.gitgitgadget@gmail.com>
References: <pull.869.git.1612469275.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 20:07:51 +0000
Subject: [PATCH 3/6] range-diff: simplify code spawning `git log`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Previously, we waited for the child process to be finished in every
failing code path as well as at the end of the function
`show_range_diff()`.

However, we do not need to wait that long. Directly after reading the
output of the child process, we can wrap up the child process.

This also has the advantage that we don't do a bunch of unnecessary work
in case `finish_command()` returns with an error anyway.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 6707b728a07f..3919d56e3716 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -80,6 +80,8 @@ static int read_patches(const char *range, struct string_list *list,
 		finish_command(&cp);
 		return -1;
 	}
+	if (finish_command(&cp))
+		return -1;
 
 	line = contents.buf;
 	size = contents.len;
@@ -101,7 +103,6 @@ static int read_patches(const char *range, struct string_list *list,
 				string_list_clear(list, 1);
 				strbuf_release(&buf);
 				strbuf_release(&contents);
-				finish_command(&cp);
 				return -1;
 			}
 			util->matching = -1;
@@ -117,7 +118,6 @@ static int read_patches(const char *range, struct string_list *list,
 			string_list_clear(list, 1);
 			strbuf_release(&buf);
 			strbuf_release(&contents);
-			finish_command(&cp);
 			return -1;
 		}
 
@@ -227,9 +227,6 @@ static int read_patches(const char *range, struct string_list *list,
 	strbuf_release(&buf);
 	free(current_filename);
 
-	if (finish_command(&cp))
-		return -1;
-
 	return 0;
 }
 
-- 
gitgitgadget

