Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC2AC76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjDAIqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDAIqg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:46:36 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AE7EFAE
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:36 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id r17-20020a05683002f100b006a131458abfso10559547ote.2
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v95+I5JULBbOj8wfzqVH7loGQ+8IyMbpP0Y/C5uKICs=;
        b=LvtDf1MxbuTpeP8X/lgEK4szWMgK2dGHVowEEoZJMo1jr1Ka3VL6nQikgS6LzKJcXG
         53dVVkFcvanIwiuF3tvWn/2PwPCjMsIu6tqtiQhwvY5hNPe8Oc/pHPgGH37u7jLyvKvN
         zs54efmDwsB9sDUfW9RvlaOjEf3YaYlSW1StFIsv3z8vpwUb7oGl/FBTBeEtv+0+VkGc
         w02p3YbyZtahJqa4O1VopZ0EgfFAZD0FRyDvzxTFHCYQDqI/xYdtWH47Nt3KYHELwwMq
         bjv9ln8Q3a5dDYaknrlSkb6lVfyCxWocODympeA2MXVN4QYgYUA0zSzWkjJNNnJSx2dV
         3o2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v95+I5JULBbOj8wfzqVH7loGQ+8IyMbpP0Y/C5uKICs=;
        b=pmAZItFPqLFwb45C7qF4WZJt47lh38skuNwmMIcpowayXaem3W0Hy/ESEj9XS0SxKU
         c5u3iWJLtRYj2YO1gMCi8Bd+dFCvvQsCsS0KQg4gx19izC/A5T7qFoJBL7mV+IvefbAb
         aoWQQ5sZjgmGci7Jwzqd2iaJYg2GUWqNI77smBLkp6fZKwFG1n9i9cKns15BQG5WPIYi
         ku9TWf8XlfeHgIYPHsOgdZrkQvvQIPEgVwy6rYL8hJjV8tIAiWWqPx1+k0Y93aE7phUT
         vrXbmJrviv+raBjL4+PdnEGPsuiC6Rpp1s6TnNSMGSB+j0AJE9ZL0YX4n8DZel+NuzJ/
         369g==
X-Gm-Message-State: AAQBX9eDViQ9ahtO3210VTGR3wu0cexYZoiz6zylN5iKpjRQhIE8Enz/
        pX84xPK/4HFml9+gD+xRJCHVflFEXdE=
X-Google-Smtp-Source: AKy350auMr+JWEom2uS9nijqAdAX6qq7w1ouPGRqkhSQTGYUJYoZ/xK2vIhvsKaVlT9bA5NBhPA/GQ==
X-Received: by 2002:a9d:6c04:0:b0:6a1:20da:8cee with SMTP id f4-20020a9d6c04000000b006a120da8ceemr12479508otq.31.1680338795055;
        Sat, 01 Apr 2023 01:46:35 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id m15-20020a9d6acf000000b0069f0794861asm2021877otq.63.2023.04.01.01.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:34 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 05/49] completion: zsh: add higher-priority location
Date:   Sat,  1 Apr 2023 02:45:42 -0600
Message-Id: <20230401084626.304356-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
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
index c7bc6a8f8e..5f2c63236d 100644
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
2.33.0

