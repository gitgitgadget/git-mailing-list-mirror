Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964AEC47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 736AF60231
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhEaRlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhEaRkt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:49 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25AAC008748
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h3so6583072wmq.3
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=b+qLtstTj22m8Lgd9DWDzpEO1IsaLvL+juvOzT1uGec=;
        b=NdRS2GyXhCgk6vcJEJcGReUrKzQEtuKwuk59Es3c4DPb7WZt940URthIGAnC8TjdI3
         gj4lZDBg5IsD1exQYmE9PuIzPkTfBg61S2KbyNPO4+VE6xYBJRK/Y+uinuCSuQ5olo1F
         yTgroV1e/xE6tVCJYMJeQtVEi0mUqUMbRHOYHME+TDasPF8r2beVemQlS5Js4mmVaOKr
         9xaFJ6A3/5SL5fSJlPZQtaQ4X0MQ7NbvbjbuhuqGqVuLQk5PoVeNrvMJCyR3OUJmGeJE
         jUFFoyFFjSh2Nw957v079JjilGSVBJm6LoZvWlLl/OVsVbXRtUfkGv3nVxHs0pmUZF6h
         qL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=b+qLtstTj22m8Lgd9DWDzpEO1IsaLvL+juvOzT1uGec=;
        b=c5BZbK8oqToWZu9jOkDVsNMutz8pwYWh14gCoDeJozYJeQddz2pnhpFohnkpjTWv3V
         9LZp6RyMVzvWpiEkbUZrPdN8EAWtxaHuIoWY6pvDu6Q7SQeH0tnGzTvZFF9+RT6lWlPh
         3cQq2PFGjAIuiANFehU2PYNG+6OdOoyb/cDqbTzcbC2HZ8c/fuUqUTS3KiKJe1w1wvXn
         4TZkilBzRKMCAKlBw6laeY7sEnJC9SARKY5BZCDUbdkS7mpGGSFPUynA0Yd60jlcOVSr
         FCCGgYIMv4qX3+p/yeO0BYuyAhsUVsv8wvrO5+u9Cg4WxnHYyYk5AAKhJl9PtJX3HEdS
         PXvg==
X-Gm-Message-State: AOAM531l6HrLxv8fvw6HLC69aAwL1GPdAiqPXVY2jaC0q1Q99eGM62zB
        r8cgqsRjoskJ0dk6U02PYdo1TjX6ugg=
X-Google-Smtp-Source: ABdhPJzxrMycqpXkaK9Qh8D9GwhO67uytkDnnZ5j2HLN6OUrUBLRN1SYKg6Xzvd6OMuAet5G3rauRw==
X-Received: by 2002:a1c:b78b:: with SMTP id h133mr21036204wmf.103.1622480203645;
        Mon, 31 May 2021 09:56:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm267041wrm.78.2021.05.31.09.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:43 -0700 (PDT)
Message-Id: <852bc0f3055d07c0462ea6f02642a57f4a91e447.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:23 +0000
Subject: [PATCH v3 08/22] t1301: fix typo in error message
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1301-shared-repo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index ac947bff9fcf..84bf1970d8bf 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -124,7 +124,7 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
 		: happy
 		;;
 	*)
-		echo Ooops, .git/logs/refs/heads/main is not 0662 [$actual]
+		echo Ooops, .git/logs/refs/heads/main is not 066x [$actual]
 		false
 		;;
 	esac
-- 
gitgitgadget

