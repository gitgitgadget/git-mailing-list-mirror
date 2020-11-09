Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E423DC56201
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 00:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4CC2065C
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 00:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUbWRlZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgKIAJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 19:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgKIAJc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 19:09:32 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D6FC0613D2
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 16:09:32 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id d12so5419623wrr.13
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 16:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y1oFvLY79Y+IPC1A0oWToPGsDkgwKy+ndXSoYdS6MDs=;
        b=hUbWRlZROsh45h2PiWLSTj4lIDDHqFTwfNgT6GZgo1VlrqS7IKK1G0kTLliGu6+3m9
         vzk6onAnMadCNgivD13TwGN5eTVP2SCSsNdOyxDjYlL+ccb60jt7pyh7wFmXQnqgkkon
         MrQ71XBmB7t365jfOOas8yxbDv4h89jNpHIma+GKY+nrkySFvMbx5cQa9xRkjqFb9sC+
         G0mKHQDRgntT+IyB1uTTbL62AXGfHvY+2+qdjTAjSEp4X8q20Hwxc9Zt5zKbBoPWCoY7
         YbCbJF/Y+ZJ0ekATXXwoBTwDj2DstYbuePyLX/Xi3rTlifHjPh9jWU8PfyOlMbrzXtRW
         0KMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y1oFvLY79Y+IPC1A0oWToPGsDkgwKy+ndXSoYdS6MDs=;
        b=D5Ckq2E7w0ONPxtVvSmKe/WbHX/kW5w28MPoTvzefbaqnVYOmNd+p+VwwMzUiw2V+c
         rrzVEOCJ41eoq8ifKjSIWoPnXfA0IdDoIog/OJHqGV+uUUkowCPh/dX9DdBshoFgIU50
         dxXmjr+fV8MLYWW7Z94dszc4euzM0qjZn1VtbbMzENbJND2138T3NHT7VfPAcfdYeZfx
         uIfqS6Ar8hKH/8GJ0k8cEc7LT69+q3eQz4ws5jan4iKyr7V5QL0FdCT4bhEvMp7jqD7O
         Qcndtux0dE+Ew9d8JfzfyDsKNPNe00NPmpNA26hV/OoLW6qLJPc3bNNnw4CZrD22/JuW
         dyig==
X-Gm-Message-State: AOAM532EJTyNH+G0jbpj21Ps+saL/xYiL5o7tPvbGVCk+bm4oIBJXoRB
        UYXbfAZaajEzk/Bv8S9WraFQKxUnVBo=
X-Google-Smtp-Source: ABdhPJxxK0O2VcSEleSlIMiZuCEK2kSXc+KgohkDsf86l4B35+6BC8bo58ZUh5Vj4Y4vWckdNHtS4A==
X-Received: by 2002:adf:cd81:: with SMTP id q1mr15707769wrj.410.1604880571077;
        Sun, 08 Nov 2020 16:09:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm968045wrv.77.2020.11.08.16.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 16:09:30 -0800 (PST)
Message-Id: <b9d7478ddd496e11d13d433c8ba1423f97881942.1604880566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.784.git.1604880565.gitgitgadget@gmail.com>
References: <pull.784.git.1604880565.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Nov 2020 00:09:24 +0000
Subject: [PATCH 5/6] t5570: remove trailing padding
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Two blocks in t5570 want to align the closing double quotes, padding
with spaces if needed. Since the maximum length of those lines is
defined by the branch name `master`, the upcoming rename to `main` would
unalign the quotes.

But then, it is unclear how those aligned closing quotes should help
readability anyway, so let's just remove that padding altogether.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5570-git-daemon.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 34487bbb8c..8f69a7854f 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -147,18 +147,18 @@ test_remote_error()
 }
 
 msg="access denied or repository not exported"
-test_expect_success 'clone non-existent' "test_remote_error    '$msg' clone nowhere.git    "
+test_expect_success 'clone non-existent' "test_remote_error    '$msg' clone nowhere.git"
 test_expect_success 'push disabled'      "test_remote_error    '$msg' push  repo.git master"
-test_expect_success 'read access denied' "test_remote_error -x '$msg' fetch repo.git       "
-test_expect_success 'not exported'       "test_remote_error -n '$msg' fetch repo.git       "
+test_expect_success 'read access denied' "test_remote_error -x '$msg' fetch repo.git"
+test_expect_success 'not exported'       "test_remote_error -n '$msg' fetch repo.git"
 
 stop_git_daemon
 start_git_daemon --informative-errors
 
-test_expect_success 'clone non-existent' "test_remote_error    'no such repository'      clone nowhere.git    "
+test_expect_success 'clone non-existent' "test_remote_error    'no such repository'      clone nowhere.git"
 test_expect_success 'push disabled'      "test_remote_error    'service not enabled'     push  repo.git master"
-test_expect_success 'read access denied' "test_remote_error -x 'no such repository'      fetch repo.git       "
-test_expect_success 'not exported'       "test_remote_error -n 'repository not exported' fetch repo.git       "
+test_expect_success 'read access denied' "test_remote_error -x 'no such repository'      fetch repo.git"
+test_expect_success 'not exported'       "test_remote_error -n 'repository not exported' fetch repo.git"
 
 stop_git_daemon
 start_git_daemon --interpolated-path="$GIT_DAEMON_DOCUMENT_ROOT_PATH/%H%D"
-- 
gitgitgadget

