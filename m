Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E874C07E96
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43E461370
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbhGNBPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 21:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbhGNBP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 21:15:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201FCC0613EE
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 18:12:38 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f9so976810wrq.11
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 18:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yswUMfAdcCqkC8/ZeXJJ8vmYfGhjiT0JHF0RGqJmC/Y=;
        b=eRyLkYMTHLyk0o99KB/+i9tkzuijTio81XGCVgn2RyYt47l2P2iExWxeyvea5qMV79
         HCgNwx1LTx6hzB7+YUnEXCRuTNiiQEPyWibGStpgNBQMthKZN27ozPopP7rFFFMc3Lml
         OeHT7haJNe5DqLQE4td9Vjv/GGi6gYqstG5wZnQNDbR/xFMyIfseWNOP7JHEl9bUIeQV
         NstWZHF9Hw7EsEiaP36y2R52SKkbeK+KQMozRMtCUxQ7xlNJVnMDELMpPo40HMhtfXlR
         kq5/CVL7pCcw0qLGCdtow7R+JyXGXEBCSWFwTBx9Olsp30Q7GSKL9az3+w/YqOIZZGLv
         vfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yswUMfAdcCqkC8/ZeXJJ8vmYfGhjiT0JHF0RGqJmC/Y=;
        b=qO8TzRKQyciLzLLWEyuxzcB5FYIRvQHhN2mIvp3xgwZZu/2PhrCVu2KpcSycPo85ba
         mFwmimRWduF+OcDSCQ9KWCdptGDBbZ8CaQHAJLXJI9ECg19XdM2y9YnmVavtED1aIFxa
         jnK8mb3DR0jiu9x+WVONGyEEmgMtqAeu5Zcv18mEKYuPBKwcZXZ6V/MwG97fVT+EzGs4
         ZEoNVhgWCXcakkk7TXiu/JxbX//efibWr+momShZb6xoB7qjExfNs4MQMyC8rwqkSIds
         KfaLUZ8Q/YspGzKsmh5f7duUO/5HNW80OnJpdea6R5eldoXDM7z4j6/kqOXtaKF01ixT
         Pj9g==
X-Gm-Message-State: AOAM533bBqeuLkH9XOVqFDm7WNzawUDVBWT9dEkkvIMARM7czW4hkyD6
        jQfnrLv9ODeekwMIIrWx8XRP7MAwj4o=
X-Google-Smtp-Source: ABdhPJxGNMvQsPffxoOvBs/z/NkNRFzw6jeEyATPhIH3T9TSG/Aas03EtzqfcP/kYNjt6H5KP/4MYg==
X-Received: by 2002:a5d:4b46:: with SMTP id w6mr9432534wrs.352.1626225156773;
        Tue, 13 Jul 2021 18:12:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10sm514148wrm.12.2021.07.13.18.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 18:12:36 -0700 (PDT)
Message-Id: <6f5767607cd2ed9d7d9f45e6dc60b07b29d70236.1626225154.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
        <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 01:12:32 +0000
Subject: [PATCH v2 3/4] doc: document the special handling of -l0
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As noted in commit 89973554b52c (diffcore-rename: make diff-tree -l0
mean -l<large>, 2017-11-29), -l0 has had a magical special "large"
historical value associated with it.  Document this value, particularly
since it is not large enough for some uses -- see commit 9f7e4bfa3b6d
(diff: remove silent clamp of renameLimit, 2017-11-13).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/diff-options.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 11e08c3fd36..ba40ac66cc9 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -594,6 +594,9 @@ of a delete/create pair.
 	exhaustive portion of rename/copy detection from running if
 	the number of rename/copy targets exceeds the specified
 	number.  Defaults to diff.renameLimit.
++
+Note that for backward compatibility reasons, a value of 0 is treated
+the same as if a large value was passed (currently, 32767).
 
 ifndef::git-format-patch[]
 --diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]::
-- 
gitgitgadget

