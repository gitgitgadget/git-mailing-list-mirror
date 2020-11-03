Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F08C388F7
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 14:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FC1822264
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 14:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njQqOvum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgKCOFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 09:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729360AbgKCODU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 09:03:20 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F70C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 06:03:19 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s9so18676190wro.8
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 06:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=v4eVHh1ML6P1rBRa3iJ/5NANzb3USxPsvkh2inN3/Fg=;
        b=njQqOvumGyT+1ON+HBP+JMyY0fyYzQ974AN+bUY2JpkPsHb8NK2LTbLKQ0fZGLc5MP
         HPg1UUxGF9ZML60saJb4xPykqJbjwBhVTKJDLnoOT2UaU9BJdOfAsMoJ2aZe4ynpC5nS
         7qEktvnzUWfIoTA0IuYYkmR72n9iTNQIeOeWPzUzPrizP20CprHkCVjr1ic50tUqHGQk
         86iQdJcOegFVj0LrDZ0VqN1Cotw/72DrmpPzSgTw1maua/Ez92GaFST0QlyWAJxHWnZW
         cDp0zOdJap4RmlEzAyRkcqkyZ7hh1ctwujqhT8k6PMJb54ZL3yNI4kGYRqZLYovn2Huy
         D/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v4eVHh1ML6P1rBRa3iJ/5NANzb3USxPsvkh2inN3/Fg=;
        b=Gx6uq4R8UygQNZy6oqz6+QoAHWV+T8Np2Jt6/TUpgQEe9WbkJz8cR3yxcB+ClI1hZp
         TychM4iPTxouCB15fJuBXfY5bsjRFmYQrzKwRD49HvgyIZahbQFDPxDF9/moCAvpVGsU
         fz0o5lEm9DD3oQcqycZhPQ+urgcFLsfsyVh7Fu4k0OpYHqH9vn0GJBnWTmH6NXyUoVvC
         HvD6NGAM4tT9OQkWZOqioDTi+pZQTM86EaOLcDRvrYa1Ju8U1hCh20atHJAUykSNxSWI
         Vut5TVgQkhxX6zMq3ZbuYw9ja0br7VRQdkWqXdl5jFyIrKuiZ6XmvTBrWuM7N6+NGnJ7
         B3dQ==
X-Gm-Message-State: AOAM5339Fj4wI6ODh0lTF4T9xtjbJeD/Me4M8wCB3fZY1xj4GzQyd1XQ
        RTbVfkkH4CxwQxygQ3MAGBaJeLTBKVo=
X-Google-Smtp-Source: ABdhPJxJW1JWRLQ5X8GqkhN3NoOAKwgEGtWX/+BQvLLC1FfONpkTgQpw451foQc8BTO4rvUKGVfrsw==
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr28142178wrp.394.1604412198353;
        Tue, 03 Nov 2020 06:03:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm2834327wmj.2.2020.11.03.06.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 06:03:17 -0800 (PST)
Message-Id: <pull.776.git.1604412196.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Nov 2020 14:03:13 +0000
Subject: [PATCH 0/3] Maintenance IV: Platform-specific background maintenance
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on ds/maintenance-part-3.

After sitting with the background maintenance as it has been cooking, I
wanted to come back around and implement the background maintenance for
Windows. However, I noticed that there were some things bothering me with
background maintenance on my macOS machine. These are detailed in PATCH 2,
but the tl;dr is that 'cron' is not recommended by Apple and instead
'launchd' satisfies our needs.

This series implements the background scheduling so git maintenance
(start|stop) works on those platforms. I've been operating with these
schedules for a while now without the problems described in the patches.

There is a particularly annoying case about console windows popping up on
Windows, but PATCH 3 describes a plan to get around that.

Thanks, -Stolee

Derrick Stolee (3):
  maintenance: extract platform-specific scheduling
  maintenance: use launchctl on macOS
  maintenance: use Windows scheduled tasks

 builtin/gc.c           | 428 +++++++++++++++++++++++++++++++++++++++--
 t/t7900-maintenance.sh |  86 ++++++++-
 t/test-lib.sh          |   4 +
 3 files changed, 498 insertions(+), 20 deletions(-)


base-commit: 0016b618182f642771dc589cf0090289f9fe1b4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-776%2Fderrickstolee%2Fmaintenance%2FmacOS-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-776/derrickstolee/maintenance/macOS-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/776
-- 
gitgitgadget
