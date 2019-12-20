Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E0FC2D0C8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BDD206D3
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKEREr/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLTRJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:09:53 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36879 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfLTRJx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 12:09:53 -0500
Received: by mail-ed1-f66.google.com with SMTP id cy15so8948721edb.4
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 09:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3muzs1s8jPipA1T8GQk7Xh/VUjMuS5qZYkTINqYuvjk=;
        b=TKEREr/i6PY0Bb2s6ZsMzIUq7GDxNevRsFKK1zeNSdXGOEeisFiFTHoiQJd1DR4VyB
         brCauJaGRCjhA2ZrEDlRhoC9wUMJdmgA3d/p+4ztwbQzo4ydolapNhfSrvm6/rsAjDJv
         aJ30XmCYR178NeMWWa+vtZf0HuVIiYdKuIFWPYo/7AKVpjbRWep9WfOGH3FDEcsbpmxy
         ovRqTQ/4gkHyfysr8dqX1FwIxCYE5izbQz/pH/HpSvsdj+z0MR4pjHfC3dWto7Q2x3L1
         vwcGpEPPVp13e+B4D2lyoYt3CEwCYkNsBsRZZD+HO/zFmCFM+HKwDB2r35cvR0oW4x2d
         KmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3muzs1s8jPipA1T8GQk7Xh/VUjMuS5qZYkTINqYuvjk=;
        b=f4/gxnI/MY/pOeUbU+HDHgbV0pchNdBl4PBTddFRl3DJtlg8A5Phg3xOMEBwLvwlks
         8yuBNssJuyBD+SJjjzeujIyHq1tgeNtBgX/5lcvirHawgo7PwaBjFjGPCGl9rWopB2cA
         PJQOHpJFhTCrqOVcTkbhEsOwXNJ04fQjDdG1fmgRo46oK4D25VVYUInbi5J9n5kiJBGe
         +1l6WLBMtqPphlrsC8TaE2Rs7hOUdRknJKoCzQWYj6fZIuHIqIlO5XMtDj1mxKw1fPnH
         CwerHp/w0GvB/3dju3MXrVTvORIzyCz8JEVFjG3yn5mOoE3wGLobN2JpYPCyv12yH6yv
         vLvA==
X-Gm-Message-State: APjAAAUf7bwYiKIGVqVMI9tK/COSDe8UBNh/CyOLJo9a68iyso0wG0jp
        QPOrKR3ljmLVmqp2VuiV/wioGjCZ
X-Google-Smtp-Source: APXvYqytqjjP+eaXv5DH94Yb3AzbFAfhKws6XQsEgOngdBa1UHeD0WYCJoVBzMtMWzC0ouMtYO/jQw==
X-Received: by 2002:a05:6402:64a:: with SMTP id u10mr17444994edx.147.1576861791249;
        Fri, 20 Dec 2019 09:09:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6sm990777edi.68.2019.12.20.09.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 09:09:50 -0800 (PST)
Message-Id: <47ea99fb30190b96b05f90735335424f7a37a95e.1576861788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 17:09:35 +0000
Subject: [PATCH 02/15] t3406: simplify an already simple test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When the merge backend was re-implemented on top of the interactive
backend, the output of rebase --merge changed a little.  This change
allowed this test to be simplified, though it wasn't noticed until now.
Simplify the testcase a little.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3406-rebase-message.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index b393e1e9fe..0c2c569f95 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -18,11 +18,8 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'rebase -m' '
-	git rebase -m master >report &&
-	>expect &&
-	sed -n -e "/^Already applied: /p" \
-		-e "/^Committed: /p" report >actual &&
-	test_cmp expect actual
+	git rebase -m master >actual &&
+	test_must_be_empty actual
 '
 
 test_expect_success 'rebase against master twice' '
-- 
gitgitgadget

