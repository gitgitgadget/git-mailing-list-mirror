Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C9DC433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 09:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiJCJYq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 05:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJCJYl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 05:24:41 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E212EE57
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 02:24:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a10so3428210wrm.12
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 02:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=dswAMgWhqYsuEbcTZ5mOnDiuCxTI1DELqUr66Dek5CQ=;
        b=oreqqrvtW/NMCpsl5vSsvAhafTlS4WOcoYEW4zIvg7IjuXwJLDKrUpo2f2jzq3yLFn
         ojHxUT5ejU5BJ9aSWUZ108rA4BxhWLFxwKj7RxmBe75ESwYH5eyXTsXRKBFnC4NXlI6J
         w3FTLZgEpLVCnqtKzzG+kuWDdN2Fx4riX3TNjDjqw1D1IPBTArShU5eLY05RRFR8z+j3
         87ciwAARx264+9wgJYklTxfxjVt7+aPcnXjPFpmftuIZD8gVvpVyFPXfvPIn/PPSicIk
         ugFqUz1UTX5+B50jBACvOYMLCgf55oEnLhnK/dN7E/nv5sMOq1HKMhcr3aiOF2V4iwEN
         +g9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=dswAMgWhqYsuEbcTZ5mOnDiuCxTI1DELqUr66Dek5CQ=;
        b=gO5tFpF0W59C4jE0Yt0yiP/gRett0FaNbhITMW77NxoM9NYo2k4LTDdOdpy7FTun3H
         VrtYulA7NFQQ1agJM9/9Tbrztg4lH1Lu1Esx5Vq7Yyp7XxHPcoR9L8SCjxvjJL6N/BS2
         d/Hp5H1W6upiUZbp4cLldNHB0oVCpsgXSULwVs1S1yDYAbuvpSYEMiXh9ZuMvZrAuf9B
         R+PWZDL3swBD+c71IHJGJrRoocGAmdcvN4bv4Sygnq/dIRlJZp1tjbuTE8P6pPJ2lzRP
         2QP1xEB8flRxELyEGiuTYuhnsrJjMCqxEgaw5MyihkvmplRg8v9ndMzBgbc4AAdArDN2
         augw==
X-Gm-Message-State: ACrzQf3nL7iYXDOdJQSyLwpk7Lnbj3p4tudLDc+72E1aXef8SuKn82z+
        IEs8aAR2VybOWhXjYWNk1DDASPBV+T0=
X-Google-Smtp-Source: AMsMyM4A6SEk8WnWkQUrf13qNnc+dk5jFdvPavfbelSsOKjesMRAU5WzkEIS0Qo9zVPyfQ0hsQxoCQ==
X-Received: by 2002:adf:e10a:0:b0:22e:3e36:d7ab with SMTP id t10-20020adfe10a000000b0022e3e36d7abmr2037088wrz.232.1664789076140;
        Mon, 03 Oct 2022 02:24:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v19-20020a7bcb53000000b003b4a68645e9sm15708314wmj.34.2022.10.03.02.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 02:24:35 -0700 (PDT)
Message-Id: <pull.1371.git.1664789075343.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Oct 2022 09:24:35 +0000
Subject: [PATCH] ssh signing: return an error when signature cannot be read
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the signature file cannot be read we print an error message but do
not return an error to the caller. In practice it seems unlikely that
the file would be unreadable if the call to ssh-keygen succeeds. If we
cannot read the file it may be missing so ignore any errors from
unlink() when we try to remove it.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    ssh signing: return an error when signature cannot be read
    
    This patch is based on maint. In the longer term the code could be
    simplified by using pipes rather than tempfiles as we do for gpg.
    ssh-keygen has supported reading the data to be signed from stdin and
    writing the signature to stdout since it introduced signing.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1371%2Fphillipwood%2Fssh-signing-return-error-on-missing-signature-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1371/phillipwood/ssh-signing-return-error-on-missing-signature-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1371

 gpg-interface.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 947b58ad4da..d352bc286b6 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1043,9 +1043,11 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 	strbuf_addbuf(&ssh_signature_filename, &buffer_file->filename);
 	strbuf_addstr(&ssh_signature_filename, ".sig");
 	if (strbuf_read_file(signature, ssh_signature_filename.buf, 0) < 0) {
-		error_errno(
+		ret = error_errno(
 			_("failed reading ssh signing data buffer from '%s'"),
 			ssh_signature_filename.buf);
+		unlink(ssh_signature_filename.buf);
+		goto out;
 	}
 	unlink_or_warn(ssh_signature_filename.buf);
 

base-commit: a0feb8611d4c0b2b5d954efe4e98207f62223436
-- 
gitgitgadget
