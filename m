Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8CFC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 00:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiEXAX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 20:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiEXAXR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 20:23:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A9E91544
        for <git@vger.kernel.org>; Mon, 23 May 2022 17:23:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id p10so4857834wrg.12
        for <git@vger.kernel.org>; Mon, 23 May 2022 17:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eQdJCtDFR9doZyW52z0K1w/pSMu2CHvIZxY29p/x23k=;
        b=XHVWAf5Z681kOAwaSIl1x3FZk2/oYu76pfmdafmFS1LP/tLHheAmipB88QanqeL96M
         3armT0DyOOuOT2cqCmVmixiEKEcyJE5/rG5nEcm82MUCGXPDW8Qj9H9MiEoUwjUbY6Mv
         MgdCU0wk1yjyvZHdYefJhrv5Ejs3D78v/HAOGISXR+RfBn+fsYnjeNfHdklIrQ0DkfMZ
         9hYVryzxjnXyy77SB7X0ZSYJ1t1J2p76dNhMly4rMWKZ3OAxC7sodJZMJoUN62bjdgUB
         F9DtJpAKFIXAhCUA+bHF8oEOTHZOJfqlWXsf55wGslWjzbI8PmypucaYJ3pE4LrDbwFO
         aw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eQdJCtDFR9doZyW52z0K1w/pSMu2CHvIZxY29p/x23k=;
        b=8PfZrpTk2yMnCuof56a1FQPgQjYLLACrv23SPTVElvIdsQoRjUFKOIZnStzVitKK/W
         b5Bm8ViKut1EsFaynkGDXw6/ZrGlLAOAaZtVLfKnWKRL/x8O3duCV2IuBwJ839GhTJU+
         qR5Lp4DcEbu3i2lztvA45cgXrgzgdWDDNz99JZG8urkf7JehkG7n4hmO1bb5N7iGX7FS
         q19aZWHdfCvI8yYvAGxOzGyk7/a7Nczo0b3/GrRJIlkLYikR8sFd5z0xaL4a9cLVxl4b
         sL4/xOw+NM2vMhsOvC6g0jpGeAcYAJ/eVWuOEM5y7fM5SDsCZusdMXT5lm5Sbk7ZYjq5
         OQ/w==
X-Gm-Message-State: AOAM530WXE7yQfwoHu447quYcf3CUdamedAK22aKr+25dsjm3L/jPxG3
        okqCvPdrq7JKnWb08COGWyqEEVHlE+0=
X-Google-Smtp-Source: ABdhPJwSXvfQouG2Frx9ewGflcZ96yNu5UGdRyvunzrqKxo47QNwcqptoRqkd8x5U72akT/BepiOiw==
X-Received: by 2002:a5d:4b81:0:b0:20e:5a3a:e8ed with SMTP id b1-20020a5d4b81000000b0020e5a3ae8edmr20419156wrt.413.1653351791640;
        Mon, 23 May 2022 17:23:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p13-20020adfba8d000000b0020cdcb0efa2sm11464287wrg.34.2022.05.23.17.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 17:23:11 -0700 (PDT)
Message-Id: <365889ee96e37dc9dcbe60d98880eb256dae90ee.1653351786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 May 2022 00:23:06 +0000
Subject: [PATCH 4/4] dir.c: avoid "exceeds maximum object size" error with GCC
 v12.x
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

Technically, the pointer difference `end - start` _could_ be negative,
and when cast to an (unsigned) `size_t` that would cause problems. In
this instance, the symptom is:

dir.c: In function 'git_url_basename':
dir.c:3087:13: error: 'memchr' specified bound [9223372036854775808, 0]
       exceeds maximum object size 9223372036854775807
       [-Werror=stringop-overread]
    CC ewah/bitmap.o
 3087 |         if (memchr(start, '/', end - start) == NULL
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

While it is a bit far-fetched to think that `end` (which is defined as
`repo + strlen(repo)`) and `start` (which starts at `repo` and never
steps beyond the NUL terminator) could result in such a negative
difference, GCC has no way of knowing that.

See also https://gcc.gnu.org/bugzilla//show_bug.cgi?id=85783.

Let's just add a safety check, primarily for GCC's benefit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 dir.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/dir.c b/dir.c
index 5aa6fbad0b7..ea78f606230 100644
--- a/dir.c
+++ b/dir.c
@@ -3076,6 +3076,15 @@ char *git_url_basename(const char *repo, int is_bundle, int is_bare)
 			end--;
 	}
 
+	/*
+	 * It should not be possible to overflow `ptrdiff_t` by passing in an
+	 * insanely long URL, but GCC does not know that and will complain
+	 * without this check.
+	 */
+	if (end - start < 0)
+		die(_("No directory name could be guessed.\n"
+		      "Please specify a directory on the command line"));
+
 	/*
 	 * Strip trailing port number if we've got only a
 	 * hostname (that is, there is no dir separator but a
-- 
gitgitgadget
