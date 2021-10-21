Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9911BC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 15:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 814626120C
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 15:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhJUQAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhJUP77 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 11:59:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F4CC061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 08:57:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r7so219575wrc.10
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ytZQPlO9P1pFh9RzehhhYtcwvaGxiRmuht7ENhk+OkA=;
        b=WErQ8H7SkuCUeWmOFmvL7ifnlY8iJGIfLf/DU9RyxY1bbd+yM5LPBsPWcrTYWD1NM2
         3cCQR1dHICc4oyvlMXprVJU6kO5sc0KftnnN7BBlPnZw9/I8JAPpjYjiEDocQw1nil8C
         5yQiEOBTrLzqaeGpvExLrqiOKdNbenpx6yvJFLcwSbTlFuU2AK2+vsFEofwC69NRBRqf
         xVdQR2DtlNSETGS2suzjjCXtJxRamsEnYl2nRtrbyaPNUDqwlpIvGiIfCw+2D3Av3Ac4
         IFVTin58XvQ52KiP85u2Ak1eIxNbKuS/Ys9/EV2cMJEKBMQZGOJC4yX1DCfJkPY6NPh0
         QZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ytZQPlO9P1pFh9RzehhhYtcwvaGxiRmuht7ENhk+OkA=;
        b=4TkPyOk+d1Uuun0hVrOpwmGQdNfIZcba6fs+FMG5by2mWyREhNdJwncO9mR0rY1eQD
         lu/ZnwBv/bXBzFvJh19dgCnwWhS+8hOkAkoy2k6Boj94BqnXvpHnkNKLWOL0rcp7TMBq
         09eRqw6BrpdVw7tJ/Z72Wl28CTnRxMiSmbJLxjoK+iAPVTOA5djJF9UO6/tQ4bhILEC2
         GjDN/WilX6vDB/H4fWZCw6bwgmUIyaTgtKJnoasM/FYi9GcAEE8jcx6mKkRRtNW5Rifo
         HlPRGXxPH4kxS1IwYnW5K8gMLffOpZr3R6XRdIUX6W1NzDuDriuNBTvHDJzpNyUjALF+
         fwhA==
X-Gm-Message-State: AOAM532RHswXhEyiBEh42RHvyRhTgFrYVgQweDQCYGAo9Vye76kgtuVl
        YRZ++EKtoEXdFITNcSNVUsMvrJivwSrjTw==
X-Google-Smtp-Source: ABdhPJzgN+UtVmhgzBEtlS93Z3NsiOjPQMdWFcqK4s2sbfyIvubFiKJKiTvc11+0GU/v73KlvNKxtA==
X-Received: by 2002:adf:f902:: with SMTP id b2mr8442063wrr.265.1634831861559;
        Thu, 21 Oct 2021 08:57:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm7082259wmp.1.2021.10.21.08.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:57:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] grep: use object_array_clear() in cmd_grep()
Date:   Thu, 21 Oct 2021 17:57:33 +0200
Message-Id: <patch-2.6-727fdb27a2a-20211021T155529Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Free the "struct object_array" before exiting. This makes grep tests
(e.g.  "t7815-grep-binary.sh") a bit happer under SANITIZE=leak.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index fd184c182a3..555b2ab6008 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1196,6 +1196,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		run_pager(&opt, prefix);
 	clear_pathspec(&pathspec);
 	free_grep_patterns(&opt);
+	object_array_clear(&list);
 	free_repos();
 	return !hit;
 }
-- 
2.33.1.1494.g88b39a443e1

