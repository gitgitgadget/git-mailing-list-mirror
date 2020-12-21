Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFE5C433E9
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6CD22D08
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgLUSO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgLUSO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:14:26 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBC3C061257
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:13:45 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id r4so11813848wmh.5
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sM1FQYn9ZCHW63glRKKrZmgg1T4w3QgJT/lJfIjbIeQ=;
        b=F+MY4tb8S5KRwRXyilGvuRldSvGORY9rasRfWnBiBgk2yr8YhaKAepbBIGfDssxzRQ
         5tityGcRD4jnBvK0iKxSZ8ZEl2R7RaOvVtAaU4nhGJUsgYQhXZyLokbtQEMFqOq+kRUf
         a/UWVarCgElQKj3KCwp/SOHaydq8/EFFt+WE9NtEnyPs5xh1zB+dpCyyd3XZMJfeXHjs
         i8RKUX2Tvxsxk75YZWzHq/ssDAfKaCfL6i7BKZxrKKqaZLKazLVp0H8H/TcVyfNRmvYQ
         TMMdeUrepw6h0UbHCf15l95TsAJZxYyZ94mjLd7VeZdx8mYiukoA+GsjM7t0BUg+MrDM
         Nglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sM1FQYn9ZCHW63glRKKrZmgg1T4w3QgJT/lJfIjbIeQ=;
        b=KDAAPxtDSP9IOBrRKsn9NtcUvPYtYzMsE4+3Yml2fktneXirUS1fsS0kwdDS8JpDIH
         uOzNtpG7eK8TsVjzghvZrxGE8IEVG5W7vDSAfCIbV+GtxMLNYpH619d1Op69JSDXjwUY
         PPOqmojD/jfL+aFuv7Urb4tSLiIq0hihcXi9G+ejbzx74sHjMBaDEwXBEo7C2VLVXW8c
         gm6CHrSS/9xPY1tsqRph2akuv68a+qack0pJpUmD7ecZjQCOayvaZY0iZXJyu8IdiJ+2
         VpCxR/GVWu4zOb0RkJGaLhPLFEOiPoFnJgcPmrxeDLUo+pMtGAc9T5u1XPdyJlNgFlTz
         myBQ==
X-Gm-Message-State: AOAM533uURutJvj/AZRL5xiFY0adf8kWMaCeY5kv4S/KOm3g0WP9K4K6
        ucAAVS8Z8iyvVF8YAw3iNxZDlfzhjl7kmQ==
X-Google-Smtp-Source: ABdhPJxE8sKNYRltwfBfFxBg3JzkOYQTwvkX+ICPKf1EDK/PZK7Xp+xJKOc0lbx2/+stBXyQc2YuSw==
X-Received: by 2002:a1c:43c6:: with SMTP id q189mr17673493wma.7.1608568167432;
        Mon, 21 Dec 2020 08:29:27 -0800 (PST)
Received: from localhost.localdomain ([81.0.34.85])
        by smtp.gmail.com with ESMTPSA id w18sm28523532wrn.2.2020.12.21.08.29.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 08:29:26 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 0/7] Finish converting git bisect to C part 3
Date:   Mon, 21 Dec 2020 17:27:36 +0100
Message-Id: <20201221162743.96056-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches correspond to a third part of patch series 
of Outreachy project "Finish converting `git bisect` from shell to C" 
started by Pranit Bauva and Tanushree Tumane
(https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
continued by me.

This third part is formed by reimplementations of some `git bisect` 
subcommands and removal of some temporary subcommands.

These patch series emails were generated from:
https://gitlab.com/mirucam/git/commits/git-bisect-work-part3.

General changes
---------------
* Rebase on master branch: 6d3ef5b467 (Git 2.30-rc1, 2020-12-18).
* Change argv_array structs to strvec.

Specific changes
----------------

[1/7] bisect--helper: reimplement `bisect_log` shell function in C
* Add `|| exit` to bisect_log call in shell script.
---

[2/7] bisect--helper: reimplement `bisect_replay` shell function in C
* Add `|| exit` to bisect_replay call in shell script.
---

[6/7] bisect--helper: reimplement `bisect_skip` shell function in C
* Add `|| exit` to bisect_skip call in shell script.
---

Pranit Bauva (7):
  bisect--helper: reimplement `bisect_log` shell function in C
  bisect--helper: reimplement `bisect_replay` shell function in C
  bisect--helper: retire `--bisect-write` subcommand
  bisect--helper: use `res` instead of return in BISECT_RESET case
    option
  bisect--helper: retire `--bisect-auto-next` subcommand
  bisect--helper: reimplement `bisect_skip` shell function in C
  bisect--helper: retire `--check-and-set-terms` subcommand

 builtin/bisect--helper.c | 223 +++++++++++++++++++++++++++++++++------
 git-bisect.sh            |  58 +---------
 2 files changed, 195 insertions(+), 86 deletions(-)

-- 
2.29.2

