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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BA9C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE17F207FD
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRtV2PTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKZBRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:17:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43845 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZBRw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:17:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id q16so3155338plr.10
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zgQrv7WEr9BNerWgrMuku+xWg7Wefls9OMP9Y4CHDT8=;
        b=YRtV2PTCfo9uWdYJaueHkH5yZHG58spkj0N09UsjFHhlmluCtN5XsiRUxi+wOz72xK
         T5Bd/yT7JowYJwolDr3NOf5E8NA8fYlwhJlW492K//G3AfPTjkQ61Hz7siADlZwC8XWa
         4cn/eD9ILpJeIdwh4anoX7lPqRlLl2xkDbqMglPE+WssMCHT+zZxJFqo7SXvmMG8SGQ+
         OVu0cA2w7tKsWC4/N/aVXcwqG10pnZAMcSYYMkWYStXSjGm7q15cryEkL6Sz3ejPtYkk
         Tq2d4eAGzn2LU7FIbss/2F1ddTNtK3ErG7PjMIr2HbiiScUlDY8D6orUnkRYB1kysaiD
         QtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zgQrv7WEr9BNerWgrMuku+xWg7Wefls9OMP9Y4CHDT8=;
        b=VSNTq5fiFPkmjFV1U4qwVKQ2loGm8nejB8hybfcwnd/HzaocQA5wwDq5+WQx7lroD/
         EQwcXe3pcW4KM7AF1SxZjboh8bTIkHjLl4c0sulh/YOn69ShplxchDlxy8L3fKsRB/Lh
         Su9r8w8VljWN8Ywx0VBS/L7K8uOLD8jIF/9K6/pDf6cXonqG+xLgsEVK3qrwmn2lHdmt
         jTRCpsF6ckvaIufq+WKsssNGFnisHI5s7GG65H5h+hut7TiIl+xEY3R1G5Rs/Fv/iFzG
         sdw5nGJeawWTDSv7BmpUj6WVk/rs7oEtRIhWWXtwkN0RquDHMRRi0eGRds72UeIGVs+F
         V8zw==
X-Gm-Message-State: APjAAAUf3lNvjrGppEDgy+Q0L/HhgdKT82Nr/KhBf8lghlWL739N1X9V
        ltKiBLu7Msnsy9IfeQo9DLRqiDyX
X-Google-Smtp-Source: APXvYqxjVjhgBEiEECq14SU51fkcH7+sD+WTP9nNC53opONHwI2i8mYKh1/GKe9JtoFj2BPa6BgahA==
X-Received: by 2002:a17:902:126:: with SMTP id 35mr32374732plb.105.1574731071013;
        Mon, 25 Nov 2019 17:17:51 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id hi2sm563629pjb.22.2019.11.25.17.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:17:50 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:17:48 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 02/27] apply-one-time-sed.sh: modernize style
Message-ID: <86f625c65e00b24d1de183c3a993e6acb7c8325e.1574731022.git.liu.denton@gmail.com>
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

Convert `[ ... ]` to use `test` and test for the existence of a regular
file (`-f`) instead of any file (`-e`).

Move the `then`s onto their own lines so that it conforms with the
general test style.

Instead of redirecting input into sed, allow it to open its own input.

Use `cmp -s` instead of `diff` since we only care about whether the two
files are equal and `diff` is overkill for this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/lib-httpd/apply-one-time-sed.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/lib-httpd/apply-one-time-sed.sh b/t/lib-httpd/apply-one-time-sed.sh
index fcef728925..bf7689d020 100644
--- a/t/lib-httpd/apply-one-time-sed.sh
+++ b/t/lib-httpd/apply-one-time-sed.sh
@@ -7,11 +7,13 @@
 #
 # This can be used to simulate the effects of the repository changing in
 # between HTTP request-response pairs.
-if [ -e one-time-sed ]; then
+if test -f one-time-sed
+then
 	"$GIT_EXEC_PATH/git-http-backend" >out
-	sed "$(cat one-time-sed)" <out >out_modified
+	sed "$(cat one-time-sed)" out >out_modified
 
-	if diff out out_modified >/dev/null; then
+	if cmp -s out out_modified
+	then
 		cat out
 	else
 		cat out_modified
-- 
2.24.0.504.g3cd56eb17d

