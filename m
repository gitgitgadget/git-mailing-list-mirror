Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F37ECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiH3JcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiH3JcB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:01 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D144DA8CC7
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:50 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so15325746fac.12
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=EheOYH28O9kKS+GU70JdwiWyRhwJ0YnbKCuQsA0xq34=;
        b=RVt+n/JXxgh5c3u1M2DUkICl4Y3TlOaNWrSgAmR7V0mDmkrq1L7VEY9ghcw+YlqvGk
         LCx4bTbFYGgFA/opUbWwXhS89kJn+jEshUYoP2edcMaK6bve9eCxG4Fu4Gsq2kjfQtwR
         WtXPdbbBpxwSY2i7BeAn16qAUopvDRgVWEONzlpK5bgRkitgayNjYmi3gtxIsxKqGy+c
         Ju77XiA2L+E2QQAYw5t3GT3iBNta9+1gkW+Cjm3sxxpcdS5mWAwqD1edKEqXWtFxRaD7
         4DLR+87i2qyzBUBdpzADlYIXu4/nyV7LRpOH1cPCYRrUGUBuum8AoCEzsknBtfBWPDbo
         kX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=EheOYH28O9kKS+GU70JdwiWyRhwJ0YnbKCuQsA0xq34=;
        b=5EUFkXAhC8nhXSwDJQxn8B2jN4m19hYyP77kxeLWcNRPF79KDVArpWjLVaZd2tUPhX
         eZVcmKzLtvw+xPqfHigXmgJ7g5GEyaYD2s+nQ1rGmz7KTCxzIerHhw8RPS+oXOOhZxLl
         jFirjDYmhnnox5FILNM52jf5GJH1q1R2KDZEDXZl9TjANXvlKalqk+WhL2DmwWm08WW2
         GDF/bPsyww585oL+WOQomhUZqaYUQz5wb+lZnUgVWXJFOp2pnvRf45bhO6DzgQwuh7Tj
         utd9zZhdBgY1UAsewvLUMlFdTDT2xVvhQ5DRheRf1cEUfgou9OkKZ2e4QgkXMiVyFiYH
         7qfw==
X-Gm-Message-State: ACgBeo0ZVh1iKzN7Q3Z88UCelLadFwhWoyAI5VTSbReC0O4vok3fWMQa
        jUEMhh6BA5/9Yz0xVVLzDbMD9Oexhns=
X-Google-Smtp-Source: AA6agR6FIEETOSlbTn5DI4EkLkVsfCXZquUuWaY0YI64+oqIquoj0Ab4oKWIWYMKaFkMl26C3x3Liw==
X-Received: by 2002:a05:6870:b405:b0:10d:7e26:8e8c with SMTP id x5-20020a056870b40500b0010d7e268e8cmr9540752oap.78.1661851909075;
        Tue, 30 Aug 2022 02:31:49 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id f11-20020a9d6c0b000000b0061c9ccb051bsm7048408otq.37.2022.08.30.02.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:31:48 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/51] completion: zsh: add higher-priority location
Date:   Tue, 30 Aug 2022 04:30:52 -0500
Message-Id: <20220830093138.1581538-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

bash-completion looks in /usr/local/share first, we should too.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index a1f2d27817..535cf03176 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -35,6 +35,7 @@ if [ -z "$script" ]; then
 	locations=(
 		"$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
 		"$HOME/.local/share/bash-completion/completions/git"
+		'/usr/local/share/bash-completion/completions/git'
 		"$bash_completion/git"
 		'/etc/bash_completion.d/git' # old debian
 		)
-- 
2.37.2.351.g9bf691b78c.dirty

