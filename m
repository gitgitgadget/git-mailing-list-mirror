Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AAEC12002
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 18:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169DE61164
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 18:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353515AbhGSRbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 13:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380073AbhGSR1g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 13:27:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6006C0617AA
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 10:52:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f17so23146038wrt.6
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 11:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+LQv9W/8FyW4BLvhS//TTXSTF5vhzAh80O5f8juX6TU=;
        b=U2dE9T6heeARFGBebVXIrwRAh7r8kEUp38rDGUXAwTJ1QPCQKisny4Ns7qqlBTYenU
         u6hvf3tcJZyi8fp0RBxX+sWV1zP4U1N9X/pgCcsAWQIzVVhbI4TbzKR/kRfcTYA8sPzj
         gdnthQFWfHHWa6DxpTJXb/WMrqUrPmUGG4ps48RZaDL7Rax3Ty//k+ynlxqp1bFYRWOc
         g6+u6h59ly6jwI3W9PO8GAot2ceE/Ptd1LBS0TL/A6MUnmryprm1OIsaPkNGuBStbJLw
         vOIo0RyJEmYJPxmiKPARpp5OXieG5Yl2KCvEt8EaqhcszLwz2GVwWYIwLCiSo1z4drEP
         0A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+LQv9W/8FyW4BLvhS//TTXSTF5vhzAh80O5f8juX6TU=;
        b=qLi/FNXZZVwlovtSR4C3iTUH+iYIjcGEvwN8xcmI0nG3Q61/MZ+oQLHOxAF/n3SZ2G
         dmQQqY8eLKuNeKb1scYNJ39HzlWYB6tLtaWPQtK7Rjkf0ViNdAGyDaNHZSMy0AHNnVmn
         dY31Jafz6bfsQBhDLZYWU3DpjhjBEmUhdjMUsWfpy6qa7EetV98v+Uxf+StXwtWLFE26
         vEHxjC3oQA1JfIUYupY4yjqjFMtF1fOJUELEhAvLT9SoCDBfQ7fP4yJyQIqsQXxIWTtn
         +HmpcGRAr5T/d2wBqMlsUcCwn9dnclEs3c9ERx4uvJbkvJwoSldCEBwoGjy/fFCTINtA
         jn+A==
X-Gm-Message-State: AOAM533niNLoE2D+YEKvH7no7KpAionaMYj6wmAWD266bTz8SuGZyfi+
        994Tx/114ox85WyOBGIe3XIFvAveGP8=
X-Google-Smtp-Source: ABdhPJx568p0XO/MKLo3FRl4WZsEAjbQhbhAy8kv3VSaRh/tpIFV0+1I1f3ekG9u/rkoDBOJIOhwQw==
X-Received: by 2002:a5d:6a4d:: with SMTP id t13mr31037554wrw.412.1626718052191;
        Mon, 19 Jul 2021 11:07:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7sm17600423wmq.33.2021.07.19.11.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 11:07:31 -0700 (PDT)
Message-Id: <61a5c3718dfbba7aae6aee75b3030d7d744d2664.1626718050.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 18:07:25 +0000
Subject: [PATCH 1/6] t6050: use git-update-ref rather than filesystem access
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t6050-replace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index e33d512ec11..2500acc2ef8 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -132,7 +132,7 @@ tagger T A Gger <> 0 +0000
 EOF
 
 test_expect_success 'tag replaced commit' '
-     git mktag <tag.sig >.git/refs/tags/mytag
+     git update-ref refs/tags/mytag $(git mktag <tag.sig)
 '
 
 test_expect_success '"git fsck" works' '
-- 
gitgitgadget

