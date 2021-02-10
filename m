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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B89BC433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 15:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6340E64E38
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 15:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhBJPRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 10:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhBJPRI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 10:17:08 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81637C061788
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 07:15:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u14so3030077wri.3
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 07:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=g7m92+GCXHJiK+lksql48sZo+vVyRBf8kQOdiNcmQuc=;
        b=XrtsesL6qq4OEEnimnW3PjuRhKI0s/dgsN5LhzbilbC8Sf1but11P8mNFzhFOpVssm
         f5hHX8SgjFx62wX2nZwScgtAgchBKgRri3M80yJ2ZRWNYwXOlHhnuw4qRfeLp4ARgmSG
         5WTd0LaodUuBGlWcT0hNi4EDyo3fOaXtS+PLz+j9OjGVN+jKBIJODaYhxxxsdV1k2aNy
         PkE/XYaImxsZJJMcozWAunBsitemcN+gFt5FZcq0IGv4ZzV48RAkt7nHob1zB7s/pNPw
         4G3xmyHlzIAC8bf+pvkX4RxZk8xwQCL0+kX4ElLcrhvCBQakVBNi00z+1kX4Mm24i4HX
         Nnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g7m92+GCXHJiK+lksql48sZo+vVyRBf8kQOdiNcmQuc=;
        b=cEuEOqVRZl0ToAGrQ3E9p8pdEXWPQDtGT5zmefkIg9HDCAhR93PXsgOeRgQq4gICcm
         GJLrdxlPLFYa/9fu8f5rYxwYNOG80Ir27C8NVZyKEi3tdp4O4F/4fd3iSOZXk7kSThjh
         0zjYztc20Ro6PhsrHtzI46VV3Z4HrywxI0CQWbWOU9WaDyivP++r7mew/Gz/lV3KruzL
         7MTMsfp9jI6vrhHHXmmmFMtXafDq97F0kDVS5tT0xuRLXkB8dk3GgOYTWt6cJU3LXFKK
         wO8UUWA0IhKjTL1O7PqEOq84qtf/d03MsknSw2FONhoEqa2QOmtwLtJcfuaw471rVdMT
         ZoHw==
X-Gm-Message-State: AOAM532nOM0K2A+jO413hq8+9d8q8w37cgtU6OSCv2euiZocclOkkIUz
        MlqzWNUrssg0ku35HJV4sRXJOtK5FcM=
X-Google-Smtp-Source: ABdhPJyEN0RYxz8YzU14kzg/ceYQ6OFGj8qhyc9jCQMoAjMakL86NufB37u1yrWGiyGt0DK/SQ3hAw==
X-Received: by 2002:adf:cd88:: with SMTP id q8mr3810282wrj.3.1612970150352;
        Wed, 10 Feb 2021 07:15:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm3592649wrn.60.2021.02.10.07.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 07:15:49 -0800 (PST)
Message-Id: <fc72d24a3358b1c5cc2753b5f07ac60174e6452b.1612970140.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
        <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Feb 2021 15:15:40 +0000
Subject: [PATCH v3 5/5] gitdiffcore doc: mention new preliminary step for
 rename detection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The last few patches have introduced a new preliminary step when rename
detection is on but both break detection and copy detection are off.
Document this new step.  While we're at it, add a testcase that checks
the new behavior as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/gitdiffcore.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index c970d9fe438a..36ebe364d874 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -168,6 +168,23 @@ a similarity score different from the default of 50% by giving a
 number after the "-M" or "-C" option (e.g. "-M8" to tell it to use
 8/10 = 80%).
 
+Note that when rename detection is on but both copy and break
+detection are off, rename detection adds a preliminary step that first
+checks if files are moved across directories while keeping their
+filename the same.  If there is a file added to a directory whose
+contents is sufficiently similar to a file with the same name that got
+deleted from a different directory, it will mark them as renames and
+exclude them from the later quadratic step (the one that pairwise
+compares all unmatched files to find the "best" matches, determined by
+the highest content similarity).  So, for example, if
+docs/extensions.txt and docs/config/extensions.txt have similar
+content, then they will be marked as a rename even if it turns out
+that docs/extensions.txt was more similar to src/extension-checks.c.
+At most, one comparison is done per file in this preliminary pass; so
+if there are several extensions.txt files throughout the directory
+hierarchy that were added and deleted, this preliminary step will be
+skipped for those files.
+
 Note.  When the "-C" option is used with `--find-copies-harder`
 option, 'git diff-{asterisk}' commands feed unmodified filepairs to
 diffcore mechanism as well as modified ones.  This lets the copy
-- 
gitgitgadget
