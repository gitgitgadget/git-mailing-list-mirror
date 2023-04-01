Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC37C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjDAIr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjDAIrT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:19 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B838622E89
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:56 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id bj20so18419301oib.3
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUPD4wT3yVNFqeYKeak3J9i5PQROoZ1ZYgYzlhb+u2Y=;
        b=TBV24KxbjTQIzhk3F/2K52w+lomqIDc8eVGsV3ePAlIu1iLEiiGhwbKALrrEMAodd9
         oKDkaskdm9ddgMD+w+rJQq46b4y5qijibj47oKYOvrbYPxEoNfhx7gLx2Eu5Ku0mqc+A
         6UcC/580m0D7sxmykWRaxV6LndlgaW8e4ejCo+uSJCMU7M7jm5q0/CKYzwS1uGPh1nlm
         zPGqPf04z8bfBL7HkE/3kJNDY2TfAw3XpRG9/5cvTDYPD1Hl+Rq9lUTFc3nUjh6+NjKJ
         mb99Exvb5RjcdRQl9AUydHEN1x2qr1L67QdpaNXJVhjGszmGPOcOcL4G0wbZS9temtM4
         7WfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUPD4wT3yVNFqeYKeak3J9i5PQROoZ1ZYgYzlhb+u2Y=;
        b=K60etGIpA44TIC1DhYX9snOCr0eR/9DnKAo4OiGJe5QiFsnDxZWAPNbD9FU4ow5tNd
         bKGktXb05urXeEeYHJP9C+wW/AcTMco0ohXa6YhfjN7+Ybcghul72fFMJjNd8I0IvQ/+
         vUhEJ+vYC0Lv7WsASUt0YD78hyN/UxTNSPqEuy+A5DoyBLUcr3ObI008h4t/AVwIJFCD
         rVhC+Y/lrrQlea58PmPAGa+bne0UwBtDKGe2MdT0RBP3/5PIhuITN+oixEUvj5CoIqW/
         3Ut+dEW6hmnvy2yKVm3xulz1bdlaJexhPiuJj7LIcpyb1G9EYBYQ4EQ0BrEKWVT5tPNt
         8xSQ==
X-Gm-Message-State: AO0yUKWATNRKFkaq0+sgUo7Z3rl1YrzIgdse02cRgjy1QDbcQh6U/zRR
        NpNnZA4ERdCqzB3CRLBd2cwrTYk0tVE=
X-Google-Smtp-Source: AK7set+DnWsyCVznOeY6mEeb6XPM8tLi3bfAkI+40VIz3Ns+XTDi2o9r7WQ5XpuMpvzAatyMeay8mg==
X-Received: by 2002:aca:909:0:b0:384:102a:46cc with SMTP id 9-20020aca0909000000b00384102a46ccmr12462491oij.58.1680338815667;
        Sat, 01 Apr 2023 01:46:55 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id q189-20020acad9c6000000b0038756901d1esm1860195oig.35.2023.04.01.01.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:55 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 20/49] completion: zsh: expand --git-dir file argument
Date:   Sat,  1 Apr 2023 02:45:57 -0600
Message-Id: <20230401084626.304356-21-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 0619d05d34..b49bce51ac 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -240,7 +240,7 @@ __git_zsh_main ()
 		if (( $+opt_args[--bare] )); then
 			__git_dir='.'
 		else
-			__git_dir=${opt_args[--git-dir]}
+			__git_dir=${~opt_args[--git-dir]}
 		fi
 
 		(( $+opt_args[--help] )) && command='help'
-- 
2.33.0

