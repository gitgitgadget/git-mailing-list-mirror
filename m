Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D99C64E7B
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0FB20825
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLTFtz7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgKLWoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbgKLWoL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:11 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB501C0617A6
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:10 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id w24so6880087wmi.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WSPqSkdDsNmXaz47u8r75k87qKiI3R4QYnp3tYQyjxk=;
        b=TLTFtz7InxqBo3Lv48IefKo9mS9YHIlXWkofq4Fe8Fwy1JKQvlp651EpsmLBqBgnmc
         47hoJQnq5Kw/c/Ejs0zuxB7XSbvp8jR0gW7Di3SYHb841Ubaibq4JjlTCrkUMD14Y5d9
         iOh9qLXYhyBynCa05FLlKaCsrW9KLkWsnm4exqzYzi12EBGmfuhAsW6OZNDNCvsIX8fY
         61VCQToaLmzdEmfE7kSDnvNc5+0hAUq2VF6KHDYjWdvXx7+6PrtXOWJu/c9r6fiHqso3
         3GQyYkmQh+uqWfg/VHXDsS4lo36RVYXYsmjLOds37ULYjHLmR7qZquFRWW6zX5RZnuR1
         b93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WSPqSkdDsNmXaz47u8r75k87qKiI3R4QYnp3tYQyjxk=;
        b=S/cXtGoeiED4/gLytdGUJquurLdx0SbZfqUJN1/T9F5x0DRh7kfF9XRavu/CtUERLa
         KsnxdjpkNmeXPRQnahJO/Kh6sYUJSez5eIHQSN9+FYkZxEImZTWsEu7PdK3jjVWHngk8
         /vcn9ZOHDi2vQaUVJugQ27MFfiIxfAQjjrMiszIelccliornKutehdm3v9WdAL0czyGS
         QlEUtC9BEbSsAoN9U2Cj2L+haAEH5HJiGjHLXNLX45UzSXqcNIIw/vgj/ScpiUO6ZJRp
         9S56wYgfpbF2U7jQV0SMl9c2G3397sZS5jmVIeCY1mJNa0w+mXjJUJKsBcLt4vl/M3vh
         rBPA==
X-Gm-Message-State: AOAM5326Wp1miJU/L1wzsm0nguhvWX8jDy4k8VTRlxX46JONdUsnZOb3
        xK56s+vRvQxLAcFxF8r6pY0wflES6xY=
X-Google-Smtp-Source: ABdhPJxvSWXjFC2VljHhttq+o6szxfZyJT4TJAIZPXhmIZuHIfeWYcWT6OjMt4deSfecelcVwYiwBg==
X-Received: by 2002:a1c:4888:: with SMTP id v130mr76363wma.84.1605221049487;
        Thu, 12 Nov 2020 14:44:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm9042885wrv.57.2020.11.12.14.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:09 -0800 (PST)
Message-Id: <40cdd5db8cdbd2aa188d8656965eb1401e50a8bf.1605221039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:41 +0000
Subject: [PATCH 11/28] t5503: prepare aligned comment for replacing `master`
 with `main`
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

In an upcoming commit, we will use `main` as the default branch name in
t5503 instead of `master`. This will require extra padding in ASCII-art
commit graphs, which we hereby add preemptively.

By doing this preemptively rather than after the commit applying the
search-and-replace, it is more obvious that we caught all aligned
comments that are affected by the latter commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5503-tagfollow.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 6041a4dd32..6dafbe4543 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -11,7 +11,7 @@ test_description='test automatic tag following'
 #   L - A ------ O ------ B
 #    \   \                 \
 #     \   C - origin/cat    \
-#      origin/master         master
+#      origin/master           master
 
 test_expect_success setup '
 	test_tick &&
-- 
gitgitgadget

