Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A864C63777
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 00:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463E520809
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 00:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVzvDJ2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbgLAAzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 19:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgLAAzO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 19:55:14 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C0FC0613CF
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 16:54:33 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id f12so70586oto.10
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 16:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T9nVL/dorCCVkE+Ics2KeVkw7mgrd8hr0iScRJ1OoNA=;
        b=VVzvDJ2zI2B0puqMyhVkJMM3/V3xbkerusaTuS/oFy0qcthTOtrbeURCCu+GkVTyJP
         pgetjSyV0EhiCVIXp3dJk7wdAey90FAT1l1R5IucuKuhYSpZpG0XMP+OustAySraalCX
         0ywRPD9MlCLWcB13RV4yxcr85oCDs4TO2A9oWhC3tm+ziU/b5mmCD2xrnxd5sXtdlPjU
         QLu7UONEeu0apNcSzGMP1itgboTUK5jwtAcSp2kv+WoFKaWseqbqCXwKKCF3nPkiKM3H
         r6F5dSK4uZKSfDEBoePT+EK1TPrukYoMHLfxWB6p2mJ5Ey325UXwJfKh2p0GgARCg/Kc
         5VCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T9nVL/dorCCVkE+Ics2KeVkw7mgrd8hr0iScRJ1OoNA=;
        b=d6uno5x45YTbMkh8wknVkk18QScvu/TvJe6WsWNmu7i5BsXtBalTpN1O0/lLaXDlGF
         gjIQPRjBUl4VeUHISiE8m8UoMUV6ogAbHYwXBWhLg4SbFaulw2Wq5bw+UH0W6CpgrUgM
         D5WKpVGSDQA/xaEquoQQGPfb+iPkU7ulMyfq+YyJ2/6KwoeXgJ4eiKl7O7F1pulH82Mf
         J8Qu0YkkWiiUrjAUKCPegQipwLQivMYiBryp1v6t9vRIyWzzWTje6uO2cBSKrH2452xc
         KLxGXMTr0MOkFQdcDhSN3X7ZU/IR7ZHPsCS3sTxSnA89fRpHMVk1pHG201TNWj5GdpMW
         Q2Cg==
X-Gm-Message-State: AOAM531I+Dz7AdqtoPLc1eekPtpwcBAJXjiEI85EJY5Xdn7ioLDLZWt4
        QfSGJ1N5zuagyl+TKTRyFugGVQV1Qj1UPQ==
X-Google-Smtp-Source: ABdhPJyJzG+nJTFCYwjvortAV04r1MbGvKL8/1tXbcl6Ni5dKhFBU6nAU3cZ/BPyBePs0wBJsKEcAA==
X-Received: by 2002:a9d:24a6:: with SMTP id z35mr118399ota.61.1606784073121;
        Mon, 30 Nov 2020 16:54:33 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id i43sm9402ota.39.2020.11.30.16.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 16:54:32 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2] completion: zsh: fix file completion regression
Date:   Mon, 30 Nov 2020 18:54:31 -0600
Message-Id: <20201201005431.57963-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turns out we always need to set the ignored prefix (compset) to have
similar behavior as in default Bash.

The issue can be seen with:

  git show master:<tab>

Commit 94b2901cfe wrongly removed it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

This is a regression since the last big chunk of changes.

 contrib/completion/git-completion.zsh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index e0fda27f4c..6c56296997 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -116,6 +116,7 @@ __gitcomp_file ()
 {
 	emulate -L zsh
 
+	compset -P '*[=:]'
 	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
 }
 
-- 
2.29.2

