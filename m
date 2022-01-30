Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D09C433EF
	for <git@archiver.kernel.org>; Sun, 30 Jan 2022 09:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354470AbiA3JoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Jan 2022 04:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiA3JoC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jan 2022 04:44:02 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D2AC061714
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 01:44:02 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id g20so9374593pgn.10
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 01:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J3R9WCikRe7oSner8Lb1YABJfOvIqJVE0rRbEFRMFS4=;
        b=XgzBruiO8fkxWGIX21T8NXyJjbSKAOa+8klh6D5G1qWmXdxhErCPidvu2iDbkIh2oR
         j3lmUIlC27AIpjTtzw3ZaYRybXWmyZGxsC0udFjD1epWiLrNwDBnniC2eOuFrBdtuzb3
         YTuPBO4FxZ58YTis/M8En8g8pmWYSrznUVPyPFY+Jxjgh6dlkARdMTgyKT0XSYgF7fJa
         SYc/cw9KKxIhCrEvw2Q8n6MmTGpFTbwtg1A7jY/Hij7dpB7bXrvuIPrttb0Nz66CKDgY
         XwPsRCMjz4DOr9rG5BrooVjFMoNy0EqUu2OWsCpSDYcy6YITZjkD4y41N1l3hNMGNRYs
         xNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J3R9WCikRe7oSner8Lb1YABJfOvIqJVE0rRbEFRMFS4=;
        b=h0Yo1grqUhXbxhXcCQlq1mR5t2xKPltrJaYJjmcTvuKG27garHhp0FD/pu+48zgErb
         +1lK+LmqKdPenjRvjH7IP/w4RxD0KqsHe7EHIw/F3PVNOKd3BoY4JD8oPsafOzSLrxPK
         Zf41ZrXmNLcu3W2fIgvKwHCLfFhlxhd99kjYfCZMP7rMZGxA7KxqrJOzJpTcvm/TycZr
         RD2MyP46p8CQRBxZiiAc3+lOC0vdzBeQbA8TuMNiHFB5KE8JTMn8XGVenFr+I2+JxnHf
         SGCni17U/BQbudQtdXSK6LJbTt0/kLt7jKTmNFuuv1lx8L6/uJC852d8Xfr8g84IMEQI
         cwIQ==
X-Gm-Message-State: AOAM532cejrhXYxKKWY3sjdltdznp0MVdqsw/OMJXYelA65VpMcaNGUi
        NGnkN9n49Qdxu4QhyN2or7GgT3Jv96k=
X-Google-Smtp-Source: ABdhPJyq/qi7qN0xcFFdDpBwDxPHVXW0x5GKarsI/tZ2LPe2pnHvfZE5zsVeUhO9WrXZSVtrQl92Wg==
X-Received: by 2002:a05:6a00:1a53:: with SMTP id h19mr15568439pfv.65.1643535842287;
        Sun, 30 Jan 2022 01:44:02 -0800 (PST)
Received: from ffyuanda.localdomain ([101.206.226.106])
        by smtp.gmail.com with ESMTPSA id il4sm8067888pjb.25.2022.01.30.01.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 01:44:01 -0800 (PST)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Subject: [PATCH v2 0/2] t/lib-read-tree-m-3way: modernize a test script
Date:   Sun, 30 Jan 2022 17:43:55 +0800
Message-Id: <20220130094357.515335-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modernized the test script t/lib-read-tree-m-3way.

Comparing to v1:
1. Kept the test title's double quotes if the title needs to 
    be interpolated.
    e.g. in the following block

    -	test_expect_success \
    -	    "adding test file $p and Z/$p" \
    -	    'git update-index --add $p &&
    -	    git update-index --add Z/$p'
    +	test_expect_success "adding test file $p and Z/$p" '
    +	    git update-index --add $p &&
    +	    git update-index --add Z/$p
    +    '

    where the title "adding test file $p and Z/$p" is kept
    to use double quotes, since the "$p" needs to be interpolated.

2. Added a commit to replace spaces with tabs.

Shaoxuan Yuan (2):
  t/lib-read-tree-m-3way: replace double quotes with single quotes
  t/lib-read-tree-m-3way: replace spaces with tabs

 t/lib-read-tree-m-3way.sh | 168 +++++++++++++++++++-------------------
 1 file changed, 84 insertions(+), 84 deletions(-)

Range-diff against v1:
1:  0069b1f385 = 1:  0069b1f385 t/lib-read-tree-m-3way: replace double quotes with single quotes
-:  ---------- > 2:  92e2e6294b t/lib-read-tree-m-3way: replace spaces with tabs
-- 
2.35.0
