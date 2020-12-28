Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A1CC433E6
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 19:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5764322B2E
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 19:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgL1TXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 14:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbgL1TXr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 14:23:47 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAC3C061793
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 11:23:07 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id s2so12457010oij.2
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 11:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2O7fFwYzEC1uSzQvZ1Psa44We64HejPxHuCubWzgGvo=;
        b=FfYhMQ0PucAJEEXjgYBhz8WqxtieAh1OPhmiSQ6gikHP6ykKDCMu9BRzMwV5Ba2TWh
         mL6xqcAOUSrHaNDSMhR9dqEIen61uvWMeDllLpfGqq8wKHIG8+Qz0N2jdgpcV9pRSHA0
         2QiVVPW1JoJWLjJ/NjRBFY3ZM41sXs44dh3pO+pVQ5qqognxSdM5s3jPJYERy6MNzI03
         J/PHSFcSPdTNkhklho2DtCQxIcnjDlbPJ08sizNeaGOQjVn/rPl0JcKR3KnGmlM8THud
         f4bJy4JS+U2Hn/oZJR64RjKAqsk2NzRwXtef0qgOY+Z4sdwG3D6cEBu3SvQE8PRI3pyg
         iEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2O7fFwYzEC1uSzQvZ1Psa44We64HejPxHuCubWzgGvo=;
        b=iVoluqaLit4c1BFr9OKYFmqO8/XbynBDDGhm5ZtSWxm2awhbKfaxskAY4DIc9BWF/z
         QdQG6PCJkyJr4AoknFJPi614bViLY9kTXd0XuXhs2L9azGyXr+F8CaEHgDDdxkgoUUxi
         x6w0DqMO8SQ/ueieAhvbD96ub+A4LothLfkhQhtiADsgkGfUFItGyTsQwyeaZI+Ea+eP
         Up3v46swosdWpJDzFl/HO8AhmE+4mW8owXz5GOZwNoYWvMB/9FOJsUCpN8fr5pBhf0OV
         Q84efkGr3y1deboeWvEdXWqv9JqSAmGrcV0mP55bqLXv9E+eBRF/qsj7TkpfC3w9lcvU
         ffaw==
X-Gm-Message-State: AOAM532iAiDIqICYfB+4IQEHdMQEECj9ZYUMxvZECZyca90Du+fCF4No
        zFqQr2nq5+H9Hxp0Xlbk+l7X895nC9mZ6g==
X-Google-Smtp-Source: ABdhPJwUu/LIflWN4+QE3e4JgCmgofWDvtZXUfxhcYAiu7m/jR8ErcCWmhXhQpk7UMIEaanQBJexmA==
X-Received: by 2002:aca:4c90:: with SMTP id z138mr268093oia.142.1609183386210;
        Mon, 28 Dec 2020 11:23:06 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 69sm8321384otc.76.2020.12.28.11.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 11:23:05 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] test: completion: add tests for __git_complete
Date:   Mon, 28 Dec 2020 13:23:01 -0600
Message-Id: <20201228192302.80467-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20201228192302.80467-1-felipe.contreras@gmail.com>
References: <20201228192302.80467-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a1c4f1f6d4..2e59fe4de0 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2380,4 +2380,11 @@ test_expect_success 'sourcing the completion script clears cached --options' '
 	verbose test -z "$__gitcomp_builtin_notes_edit"
 '
 
+test_expect_success '__git_complete' '
+	__git_complete foo __git_main &&
+	test "$(type -t __git_wrap__git_main)" == function &&
+	__git_complete gf _git_fetch &&
+	test "$(type -t __git_wrap_git_fetch)" == function
+'
+
 test_done
-- 
2.30.0.rc2

