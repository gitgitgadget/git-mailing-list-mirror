Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90507C2B9F7
	for <git@archiver.kernel.org>; Mon, 24 May 2021 23:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE086140F
	for <git@archiver.kernel.org>; Mon, 24 May 2021 23:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhEXXQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 19:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhEXXQD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 19:16:03 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938A8C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 16:14:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z137-20020a1c7e8f0000b02901774f2a7dc4so734351wmc.0
        for <git@vger.kernel.org>; Mon, 24 May 2021 16:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pvr29xZy/wopOBh/uPBx5T9D681PLAvF8bg2klAGx1Q=;
        b=au0TnZCVROdSxb3qzjQ3OyYlMLDiT7U9fffJH5xwnXVgbMi3cFyu8qVJI3ay10huej
         uRzNEcgthW/PK+0BoGc4txhFpLqUdrqA9JM1z2+Lh7rUDmuLS0D0eeC+AFooQAXJYJVI
         2v8TNjv4pUlah0E9j20DpoijxVs241y+8ZetthxFpooUEy49kcugZ2q0e49M4S+tVJRO
         8hl/vxMzpBq2gbvtBDopaW4LzvFoCajS3dafIZHlELfwLaHHNQshjwD7ijlje9az5xTQ
         DvNE7iD0WoZ8t6EBvBEH0KijrYMc4HOS8X5JZBU58ggIoB3IC6dkREHpTND6zmqA+W2+
         dviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pvr29xZy/wopOBh/uPBx5T9D681PLAvF8bg2klAGx1Q=;
        b=PzOSpo8mARW9LKBOQt2Sh6YdF8XkPbU3Z6KmHQGaPaLtAscjB/w2HRZKfiOl/EiWlG
         /gWy8cTcKZPR+F+tbyujvZ9e5icjNa4og4FqqsWQQhYAO8jJ8eyz3cON28nxRvvCdja6
         Sbu1MNDUVT2ZHa6YMxiCDfw+zu6PFj+gE5nP22AwzRbf841Ip8wCn64Z4RroBPPBqfOP
         DNG3NhHENr4A2ETct31shC8Ebxrli+CtbvZCKNpn+h2FVSd6fycxZ0YyDRyMG808MPvb
         /52/vWtamg84gEgqSOhX6/7RCXUT5MUONHrHZcDOqhujC7DS7aZdzCI6sWfmVrkjlURK
         Finw==
X-Gm-Message-State: AOAM5331M4w8FAejtEdzOl5e239TUSdt2XXBYeN5ILVTbLVoXzHwCe4A
        ze3x/9ZnIyhiVTgkluAc/ehrzgb92zxCsA==
X-Google-Smtp-Source: ABdhPJxoXEB+1l7YFJj3Qh731CgckoEo7xIFSsMUqt6l51SOE2yQHoBhAoo4j8Fo32fYxXUIk0KNhQ==
X-Received: by 2002:a05:600c:4f48:: with SMTP id m8mr1056521wmq.169.1621898071004;
        Mon, 24 May 2021 16:14:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v12sm14067264wrv.76.2021.05.24.16.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 16:14:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] send-email: pre-release fixes for v2.32.0
Date:   Tue, 25 May 2021 01:14:23 +0200
Message-Id: <cover-0.2-00000000000-20210524T231047Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.388.g81c17cd8439
In-Reply-To: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>
References: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 1/2 here fixes a bug I introduced with an error message going
missing.

The 2/2 hopefully replaces
<bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>[1], but I have not
tested it on Windows. I think improving the error message is better
strategy here than working around the current Git.pm abs_path()
behavior.

This has a trivial conflict with my outstanding [2] series which is
easily solved, we just need to take the side introduced in this topic
(i.e. abs_path isn't needed anymore).

Also, I said I'd CC Robert Foss in [3] but didn't, finally doing that
here.

1. http://lore.kernel.org/git/bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org
2. https://lore.kernel.org/git/cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com
3. http://lore.kernel.org/git/87im37ojrn.fsf@evledraar.gmail.com

Ævar Arnfjörð Bjarmason (2):
  send-email: fix missing error message regression
  send-email: don't needlessly abs_path() the core.hooksPath

 git-send-email.perl   | 12 +++++++++++-
 perl/Git.pm           |  3 +--
 t/t9001-send-email.sh | 25 ++++++++++++++++++++++---
 3 files changed, 34 insertions(+), 6 deletions(-)

-- 
2.32.0.rc1.385.g9db524b96f7

