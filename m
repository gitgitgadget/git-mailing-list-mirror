Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913A7C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 09:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F30D60F49
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 09:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhGZJGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 05:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbhGZJGN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 05:06:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24748C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 02:46:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ch6so3137639pjb.5
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 02:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+VMaIZzuDE1xriVcQhmESLjtzFdGn2kdbazPAPr7/qg=;
        b=YsFLl1txGjt+ZgXtoE4gjsQq7IwwGEh1ntZyZDspV73bMAbSHVam9UmgcUQCeryGgP
         PyYNIWH1b/o1vmz/WWfWmSY1GdLsF05+uQ8KuzeaF0ykvZw7R2y6JJAIov+xfGlgpV0o
         CpgS00oWcDFf8XN4SE2sRl9wXA7ImOWNY444niLrUHEoZ3yT28IY7THEqtxdjCeIFr4c
         Z7ukRzs165Gw2CJEpM/Ia6f5D5WB3HrjUX6pmdjrHjJrBZYIHYrm77204pjy1tS9oE8v
         1XTe8ynoiejPxUVuZQTx0Dd+ScIlWXQwd9pzPeD7Ks7ysVbXu2Rnzjb1zKBCN6e8gc8v
         uM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VMaIZzuDE1xriVcQhmESLjtzFdGn2kdbazPAPr7/qg=;
        b=L/2/Gi6Mc+TXS6j1tK9UiY4H2AiwGMlMAIuhiQlN9VO0NwlyThRD07S0x90RxET58h
         eFmoD73pCcFYAx4Q7B1FIa93CdQ6mQ0lCzhdtQPovz733FQotGZY/KY23CWdd7VrPXVr
         sc3PTLrDQO17hfj78892OMVu1m489uwojpka/RFVmBA7HOq5SQaFXHuXRUnlrLqJYpqE
         DweUjM65AjbS7Mu4KByKJPJAEBLPHQ7jy2YIVds1cWmRGDEQcZlEN1FMQdJbNtcNJd4t
         nx4MygeuUrjbL8ozojyd/zaerUAqkBphN0M7smQ3YOKRT7tqjSoFIQU180eOJVYdr0Tf
         0qww==
X-Gm-Message-State: AOAM532CHsXDcFgkNj5qGYVNvRjdfZgZBuCo8D8w55+wUi6mSewkjaMi
        ZF5vuHW0+1UJfmxDwhwJxtqxdO9gc2X0JhrV
X-Google-Smtp-Source: ABdhPJxRoKGZePBo0Ed3KHtf5jG13AqwBTPxtHsJvz8D3vE28byavW44BU3Xi03aKzo5R2R/u9yD1g==
X-Received: by 2002:a17:902:bd02:b029:12b:1c90:eb65 with SMTP id p2-20020a170902bd02b029012b1c90eb65mr13854838pls.81.1627292800403;
        Mon, 26 Jul 2021 02:46:40 -0700 (PDT)
Received: from localhost.localdomain ([115.227.76.17])
        by smtp.gmail.com with ESMTPSA id g13sm42522319pfo.112.2021.07.26.02.46.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 02:46:39 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, avarab@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v3 0/3] packfile-uris: commit objects exclusio 
Date:   Mon, 26 Jul 2021 17:46:11 +0800
Message-Id: <cover.1627292424.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.443.g55c63af4c9.dirty
In-Reply-To: <cover.1621327467.git.dyroneteng@gmail.com>
References: <cover.1621327467.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v3:

* Ensure the forward compatibility of the old
  configuration (uploadpack.blobpackfileuri).
* Reimplementation of the commit object exclusion method (without rely
  on the "--in-commit-order" arg).
* Extend `show_object` function.
* Remove `exclude_until_next_commit` var in pack-objects.c (Concurrency
  issues).
* Restore the definition of want_object_in_pack method (problems caused
  by the new "type" parameter)

Teng Long (3):
  packfile-uris: support for excluding commit objects
  t5702: support for excluding commit objects
  packfile-uri.txt: support for excluding commit objects

 Documentation/technical/packfile-uri.txt |  20 +--
 builtin/describe.c                       |   4 +-
 builtin/pack-objects.c                   |  97 +++++++------
 builtin/rev-list.c                       |   2 +-
 fetch-pack.c                             |   6 +
 list-objects.c                           |  37 ++---
 list-objects.h                           |   2 +-
 object.c                                 |  15 +-
 object.h                                 |   4 +
 pack-bitmap.c                            |   8 +-
 reachable.c                              |   8 +-
 revision.c                               |  36 +++--
 revision.h                               |   4 +
 t/t5702-protocol-v2.sh                   | 166 ++++++++++++++++++-----
 upload-pack.c                            |   7 +
 15 files changed, 291 insertions(+), 125 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  91dce385f6 packfile-uris: support for excluding commit objects
-:  ---------- > 2:  92def8c72b t5702: support for excluding commit objects
-:  ---------- > 3:  01ab2cbb34 packfile-uri.txt: support for excluding commit objects
-- 
2.31.1.443.g55c63af4c9.dirty

