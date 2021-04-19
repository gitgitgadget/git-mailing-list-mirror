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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC22AC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BC261157
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhDSKyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbhDSKxl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CDFC061761
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m9so20750055wrx.3
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1yBKFOdcU2Ihnf+bWAJn2pIcKIYMfcV4oCmsLTWM44o=;
        b=QvEPMo5qmLWAnBPKtWs+FkufhM8MlbESOKJeqBb9m6BcduYZz5DbWjx1qW4cTX8gjL
         XkfNNAJVmzxi3v6iKjW4wxr8S+grp0toUz3vXVbllcwgjJZ9kQIAaSvPealyIps/cVu/
         cIhEYUumrKlt9yf6NbRTI3/rzIt9kCdne4HAY5LErAY6IlnfsO4Ff93736K7t0Ge7zZY
         tiFNBWB3nX8fdUNPBX9wRNEUbHv5EZuGgU/RHszhjIt8fcmX271gap+3+/Vx+qtfHCtT
         hr0Zs+WwR4Ur0GG3/lOadwyzG91/Y+4PyhFPLIFSW8ia6PYRkPso57OWslwNHP7kfhma
         iCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1yBKFOdcU2Ihnf+bWAJn2pIcKIYMfcV4oCmsLTWM44o=;
        b=a+KragHt6kVb5VM+rtcaNEGoEJHc45z9CDRiTIs21vKf4B1FgX0Idei4eX43G7cu0G
         Qx9bFsA3vxDcVhvau1M0r9/FgKfX/lIiIO1qLznM9lThuOIy77ScjjQ6+fWwYeOV64d0
         cU5LWB1ZJor4n2TB9EIXEPRxJux1vauUpQM0y4DO1SpahJqAxse5zU+OBc75foLQ/BXX
         yJ2jO6aaTLDNJ5WekJi9cwhmDVJS6fHWYjPPmLuVAPavckUWLP0LHkXFrcERB3igbxy7
         e+dV3YIzAAZKNk9bGBqE/IiLfF1gZNIxe5Kwd2J+ZtdCg8Yv4OBQJ4EpNwi+cM7ehtSo
         sQPg==
X-Gm-Message-State: AOAM530/uAPkTdItDd0lnvcEfIDMlDKOX2AcsvDcIhOWbo2cgHtPjqDw
        9QA7gOZ+YfFz8DEsH8lgpX2pu5ePUxA=
X-Google-Smtp-Source: ABdhPJyyNzb/Mwc8wKjzbHf/w/RSA+LHOsZQQ7R8DZe5m1Lj406h9KDrqG3RDQtZ8qkGl1Feb5TbGw==
X-Received: by 2002:adf:8046:: with SMTP id 64mr13600979wrk.176.1618829590213;
        Mon, 19 Apr 2021 03:53:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u11sm13874547wrt.72.2021.04.19.03.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:09 -0700 (PDT)
Message-Id: <3d3b733c31273a004e80d5cbab8f746a2010e9ea.1618829583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:52:55 +0000
Subject: [PATCH 10/18] test-lib: provide test prereq REFFILES
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

REFFILES can be used to mark tests that are specific to the packed/loose ref
storage format and its limitations. Marking such tests is a preparation for
introducing the reftable storage backend.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/test-lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index d3f6af6a6545..ea7397c633db 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1481,6 +1481,8 @@ parisc* | hppa*)
 	;;
 esac
 
+test_set_prereq REFFILES
+
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
-- 
gitgitgadget

