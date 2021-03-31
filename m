Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C31C433ED
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 275BE6101E
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhCaTKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbhCaTJx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:09:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E62DC061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:09:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x7so20713366wrw.10
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=izlfikeTUxr9Jkoa3DD/0HWJy/aPE3X1uWVO1FZ1YoQ=;
        b=IhA7F7xkQcfxnaa+VuRaEjXHDTTk7lLU/skvd2POO74PnurcyfN8s7UNuowQotrj85
         2s4WivxJpgstsZlEbi7cGQd3K/wQvnulF3z54L2jRHVDWf6bUqhyuoyMGdaxtIqFXtiC
         c9dOfvoct5gi3pnbZy+Qe/T4IUySRQrYcBUib8DobG26R0Imb+Q+OypDGZfqkDnYl2d6
         JQ0B9NnMdFThOwkXiLhpaKpw+NU53BLtR/ZoqMueJ80xw2fUYQZEjkqe3asC7YM/PHCy
         7zY9I4UV8H/yYCX6ynmxJgrvja9g5olL8BmJgOEZbKYhIHbcBdE5+YNB4f8dglGz2qud
         2Azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=izlfikeTUxr9Jkoa3DD/0HWJy/aPE3X1uWVO1FZ1YoQ=;
        b=TCP/I9bxwUS0gX9tG1ZRZUiVMLJN1DDCTWvLWyduNtfG5StywClsVIxHp8j+f1ezTC
         Wk1DHSbWFekG+sD0BFuIFy4sbiYByrYLXsgv1laBKYB96PN55rsrZgVoyWUa4WlX/1Ml
         xZ039+5DI8Jj7U5EahzGgiWC05PUYC+ym9vGEj9x85UuAJVXfIV+2PhgwKrGSAUH6R17
         dZazD/YTYuQw/yiEHzIN+gd0ZyjpoDuquOR6wcomo0hS0m1/urPOnS4B/zbVDd80BR4r
         Tm59Py4FwJVepvPOCnRUR+qV1iyO21wa9rDj3dVI7GSfqBLIZpP2q3HSVcV5rfInuVS/
         NrSQ==
X-Gm-Message-State: AOAM532M0aTWIyxZYHzZpnlv3nT2LtbVJc8hZxL+3uvblZNkRM60oYRI
        eJoqiklaI3voEBsos968Jih0Ya25D8OWfg==
X-Google-Smtp-Source: ABdhPJzihmhz4uQQIqGhMRd6yh5pXP/4lBTfYDuGNJ10Mup3IH/Tc49ZXKMfZ/NNXyg/kPDyOGGppA==
X-Received: by 2002:a5d:5083:: with SMTP id a3mr5437891wrt.38.1617217790464;
        Wed, 31 Mar 2021 12:09:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm6019268wrx.83.2021.03.31.12.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:09:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 01/18] cache.h: add a comment to object_type()
Date:   Wed, 31 Mar 2021 21:09:29 +0200
Message-Id: <patch-01.19-a74e02ff0ba-20210331T190531Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
References: <87o8fcqrg8.fsf@evledraar.gmail.com> <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a comment to the object_type() function to explain what it
returns, and what the "mode" is in the "else" case.

The object_type() function dates back to 4d1012c3709 (Fix rev-list
when showing objects involving submodules, 2007-11-11). It's not
immediately obvious to someone looking at its history and how it's
come to be used.

Despite what Linus noted in 4d1012c3709 (Fix rev-list when showing
objects involving submodules, 2007-11-11) about wanting to move away
from users of object_type() relying on S_ISLNK(mode) being true here
we do currently rely on that. If this is changed to a condition to
only return OBJ_BLOB on S_ISREG(mode) then t4008, t4023 and t7415 will
have failing tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 57f2285bba9..41e99bd9c63 100644
--- a/cache.h
+++ b/cache.h
@@ -451,11 +451,16 @@ enum object_type {
 	OBJ_MAX
 };
 
+/*
+ * object_type() returns an object of a type that'll appear in a tree,
+ * so no OBJ_TAG is possible. This is mostly (and dates back to)
+ * consumers of the tree-walk.h API's "mode" field.
+ */
 static inline enum object_type object_type(unsigned int mode)
 {
 	return S_ISDIR(mode) ? OBJ_TREE :
 		S_ISGITLINK(mode) ? OBJ_COMMIT :
-		OBJ_BLOB;
+		OBJ_BLOB; /* S_ISREG(mode) || S_ISLNK(mode) */
 }
 
 /* Double-check local_repo_env below if you add to this list. */
-- 
2.31.1.474.g72d45d12706

