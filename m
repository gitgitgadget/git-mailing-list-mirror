Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B740ECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiH3JfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiH3Jdo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:33:44 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1285E3422
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:53 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-11edd61a9edso9324700fac.5
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8ybJbGXWQyp92D7MkB9mePNrwxxbMoFh3jEqwBQ1s0M=;
        b=DLdtyOtdjOsCDgQYfRSklPSZKpz98EVzC/2jsNFv90Y5Tg08raktWMR+kUc1WpY35t
         qzCHlrhOvAnUSRLjuBwt1mNg6krwi6Uwani4IRBcuOyRiQRj5Isfryo+hHo8rpKezKqp
         re5q89zwnRJwEL8DKHUNP4x4boWgv5avRbptk9Nr/0uSQyLxq8Jq3a1Cy4jHypS4Jyj6
         hnlf47lYVpc1QqxPwYwW02B8klBXUciPmfv8BHwfZs/CSmcNYfBH6NrCVyaCIIeNVPPD
         0FL9kbd0I67bf/y9U03PL49YcDlfLWE1Hbd+Qhur+5KMryHfeez+6PP8Yjc8YU/uhn5Y
         WvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8ybJbGXWQyp92D7MkB9mePNrwxxbMoFh3jEqwBQ1s0M=;
        b=TAo8LI0qg/N63SNgGV23MUCfszEk423htyL088oaGJv+q/mNXKyM5wQFHuQ9YrogZ9
         fA6XWX3ZCBcb9SbuFrjtcKEUAWo3pSOELFe6tmcETBO4EnDGmB0OC0Uli8veSeef0rOJ
         ODgXqxs2OQZzEN0Wgj9sJL66nHFxxipkOX26i6+iWNcaTjSG4CHjmXde0ERepL4NQFbD
         B4IEsLffTsCvB+GrxyvHosyR6y3RQQHJd5G6l7tZoa+SQw4BvsPoVgt6dpc1QpABuuwv
         +VcmaNGsu9Vd4yaP3qZbTw+kDaBPUqbMTzDewYFJ1gfMYUlZEHwAdoR/7AIAJkQPu3Kq
         glNw==
X-Gm-Message-State: ACgBeo3X1NKCNIMMGVC4gKWAAV1jKA8+p9Xs1qOWzVlkVqz7tZY3CrT/
        IJF3X6PktAnROStPlIjT9OkdIPuV/WU=
X-Google-Smtp-Source: AA6agR7xv3EvURVjtgzIFV/ssKQttTc/37zEDIQWVvOtTWovswejjoURV8Tr2OeoDHVHofls74+z4g==
X-Received: by 2002:a05:6808:170b:b0:333:53cf:8022 with SMTP id bc11-20020a056808170b00b0033353cf8022mr9368495oib.28.1661851968724;
        Tue, 30 Aug 2022 02:32:48 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id a16-20020a0568300b9000b0063975d170a8sm5962378otv.7.2022.08.30.02.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:47 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 40/51] completion: zsh: shuffle __gitcomp* functions
Date:   Tue, 30 Aug 2022 04:31:27 -0500
Message-Id: <20220830093138.1581538-41-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 3619c93ea9..645b4bac31 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -88,11 +88,6 @@ __gitcomp_opts ()
 	compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
 }
 
-__gitcomp_direct ()
-{
-	__gitcomp_nl "$1" "" "" ""
-}
-
 __gitcomp_nl ()
 {
 	emulate -L zsh
@@ -107,6 +102,11 @@ __gitcomp_file ()
 	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
 }
 
+__gitcomp_direct ()
+{
+	__gitcomp_nl "$1" "" "" ""
+}
+
 __gitcomp_file_direct ()
 {
 	__gitcomp_file "$1" ""
-- 
2.37.2.351.g9bf691b78c.dirty

