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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4BAC433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 20:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50EE64EE8
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 20:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhBES5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 13:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhBEPDP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 10:03:15 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C23C06174A
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:41:16 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s11so9515949edd.5
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l65d8udfkzCvo108kV8k2aW7CWwXTuaSE/34F4Un0S4=;
        b=MJFIx2jHRLBiqum/RzaL/MPl+32IAgYY3d8yvDbGvh5ufj/XZHB/5Z1oayFBhcwvIP
         rJ2Y536pHfXhvqKH050oD5cjHlbyau1yLVLyPkTbIv58zol7vpfKVD3LBVrP6uzAV6ME
         1jLPCAsKZHFWid447aZe1RDjzbRlbLm9e6d7r3mQJ1YrTef0pVltMHBhGmgf9FlGUMta
         wqAEI8vU7tizu4c6hqGDt8nQMyK2YeaXMhVXYijJq7QAIyhVX/q8oWrUXVM4SR4iqKZV
         /ppJn/I2UmTBjRfulwPHzXte976HgzzA0n3zaodv8OyqNXSn/hT20TItpX2YgPdXNQb3
         k+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l65d8udfkzCvo108kV8k2aW7CWwXTuaSE/34F4Un0S4=;
        b=PueKKi8HBJKdgVNB9EVrEa9mZT/2TqOeoV4YXRM/PNoSkN+K1OkozwggSD3EyIJf1C
         VxJOkuqly1OvMSw2+Kc3mwkyM+yqsiBXdrt/ky3oLVkhMqbSLX8HvE25z1zqPtNuo9bJ
         AyCa+uwrg3yK/191DNnhx+lw3OCqKCfoSoLkkXrHQ8VV2XO5sx+pfE57NzOqfmQuGSuI
         xkGFaVVLRPxepTq23fULzpsLjCj+4rZvMxd519p2vCcE5LyYfyMbmOhDu75p5F0SCcvA
         E+NO0Ux+PcXeEoj/R0OxrWzr/41Te0VGSmu/QgJsD/vT4I1t3VrT0ijSotavf8MSSkEO
         DeAw==
X-Gm-Message-State: AOAM533jPVWEp1Q1vPkQf3HR3Seq5hJpX/qZmqVpGB/DbkmSZIfWIGHT
        lCRG/2vUYSdoCFZt2f0lyF4O2ihQcVU=
X-Google-Smtp-Source: ABdhPJwwJ/rJdwIAiqgh6Ur2UVwfnVVRASGi1th9fEeRWZKLdJh+38Ej7XPzMjYQP4DiRMTDxwX3qQ==
X-Received: by 2002:adf:9523:: with SMTP id 32mr5571719wrs.361.1612536377431;
        Fri, 05 Feb 2021 06:46:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13sm9852514wmh.9.2021.02.05.06.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:46:16 -0800 (PST)
Message-Id: <a36631b663e2310f60c5477df5efeda9dccfcce9.1612536373.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.869.v2.git.1612536373.gitgitgadget@gmail.com>
References: <pull.869.git.1612469275.gitgitgadget@gmail.com>
        <pull.869.v2.git.1612536373.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:46:10 +0000
Subject: [PATCH v2 3/6] range-diff: simplify code spawning `git log`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index 8844359d416f..d0d941a25add 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -81,6 +81,8 @@ static int read_patches(const char *range, struct string_list *list,
 		finish_command(&cp);
 		return -1;
 	}
+	if (finish_command(&cp))
+		return -1;
 
 	line = contents.buf;
 	size = contents.len;
@@ -102,7 +104,6 @@ static int read_patches(const char *range, struct string_list *list,
 				string_list_clear(list, 1);
 				strbuf_release(&buf);
 				strbuf_release(&contents);
-				finish_command(&cp);
 				return -1;
 			}
 			util->matching = -1;
@@ -118,7 +119,6 @@ static int read_patches(const char *range, struct string_list *list,
 			string_list_clear(list, 1);
 			strbuf_release(&buf);
 			strbuf_release(&contents);
-			finish_command(&cp);
 			return -1;
 		}
 
@@ -228,9 +228,6 @@ static int read_patches(const char *range, struct string_list *list,
 	strbuf_release(&buf);
 	free(current_filename);
 
-	if (finish_command(&cp))
-		return -1;
-
 	return 0;
 }
 
-- 
gitgitgadget

