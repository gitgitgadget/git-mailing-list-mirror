Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A43C2D0D2
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D57206D7
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6YBzHia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfLXTzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:55:05 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33352 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfLXTzE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 14:55:04 -0500
Received: by mail-ed1-f66.google.com with SMTP id r21so18677076edq.0
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 11:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3muzs1s8jPipA1T8GQk7Xh/VUjMuS5qZYkTINqYuvjk=;
        b=h6YBzHiay+G+lJh2wVd0MYLm2NnyOgae1yj6c7/q1jLxZG/N5RNT1OkEoXIKIr+sxO
         atgTPDK9kH3WmH1oDTcWlNWe6EOqim8FMYx6N3fRUbh4O4lab6gh4rCvXSyb8NGmGweL
         05yLZEjCE0phfDd/UpALfRc46qvhiuGa1zpaRw2Iyq+TDHzktCv/Rp64QWsgO2GX9UT5
         /Pzsn9JMIrNizBiI4NW4W53b/1biTwsrcHm2OXJ6GUlMZTYnu0Vz6iNa8ouCOaJUEchZ
         5NtPsYOY/+BnM/cQPIVQ5GKk4sh9rvnd6lc6CnThyUnkn9ME7HYumONxieh/rU7asOUR
         X6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3muzs1s8jPipA1T8GQk7Xh/VUjMuS5qZYkTINqYuvjk=;
        b=WsGYl90DKEjFaElcU/JwZ07e+Y+OmBG3rVIjts9WhKWlQi98A1xa2l1QfN/ztuf17S
         Mq7RfdpLbIwSWjEDKz1mkEwiLnQAXo7rSsXCqXz7Vv+N8af+0ag3j/Zt67pPn/puYG6T
         S52dcnLJp6jnfgWgYgHZVgMgdgnTQstXwvVhdQkgfDRjE5mjX+RHSW/4urQXGJdFb3CP
         VWv6FN80JlgpZSBtgqm7HZz38xSmeFSWRbflYNTNyQO/2bCWTgl0BcIBnzVVFz9c+a3K
         4AU/ZhS81JwtT1lOKEp2U87zo2NRXo72LN5EZ3f3oLBVKNoXH1fg8IGka91tXY76YFdW
         0Zww==
X-Gm-Message-State: APjAAAVG4ZNsqJeVu5bMzKQ0LwkzfkZMNNb1AQsvMMdjcbcKDcM8sgTB
        FuhRALoqa2E7rIrxHVHH1HgWr3Wq
X-Google-Smtp-Source: APXvYqzDqln0PM3iKhkqUd6DzLYtCM6iV76C/J9iruL88RrsKNqDgH0s1fFmd6yrKQzGBTuqH2j70g==
X-Received: by 2002:a17:906:2e46:: with SMTP id r6mr39474337eji.310.1577217302667;
        Tue, 24 Dec 2019 11:55:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q13sm2790409edn.2.2019.12.24.11.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 11:55:02 -0800 (PST)
Message-Id: <bd3c5ec155325d78f89afcbe910810cc18c0aaeb.1577217299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
        <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Dec 2019 19:54:46 +0000
Subject: [PATCH v3 02/15] t3406: simplify an already simple test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
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

