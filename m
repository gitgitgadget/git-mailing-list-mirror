Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6101C77B60
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjDAIse (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjDAIrr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:47 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91D424404
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:10 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id bj20so18419484oib.3
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzqmybBX95MVdFpAJq2z+6HnpV5kueywFAb0W9v8gq8=;
        b=MceHyc6Q2JZ5h07vCquJyyZt6dfXndwyRbczFb685sbuFnK6PfL9t6IBT4cvXpFxFb
         Q9CZK6Ta8O+ovC8Yn5jfQD7/MVSKHTc5ukXNd/bzr7e+n4iCthf16nVTpV8Av1O9fnTe
         Vs4OT2Lcj6mq7ewpjqY44mlO2rbwW7Ad7fV/88YjzvoOG7Jlj27GVQo7ocBF4iLX4KV8
         WRZE59whm89T+CgvpBQCOagTjaqWwXu0RnYnrnIrxhoXHHY5k8IHfgRKirdA04119WUf
         HeFdCoJJWi3juaR/3RbajhIskb67YFgSAGEhVEMV4bHH9iXnlZt/+qL1Bv4q3Km2Uqim
         Do0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzqmybBX95MVdFpAJq2z+6HnpV5kueywFAb0W9v8gq8=;
        b=bFbHGp4sAiIi6exteC9vFxBXZInqhCLCYf1bWwXI6S8hiqe1KlX+VY2w/piBxS8BrL
         BXO8G3Q8WTIHo6U6gBxtKCpdgAAkNf64kyb4ER3bPCQBzMRdFxgUe522szy0QZztMEbL
         lIdM7WMFJ7V9psclXHyDEgBQRvvbawEbVXE/j3caTNtWrQvuCE2Ui6gr2+91IQfbRdaO
         rMrZWsfJOAAtJ3ckqg+SFxHw1WWFVc6Y+iISC79lKo9t1A6sUJ7rfCLpthScOXy3b+xh
         lss5TvZSTcDgEgeMXQNv8vq10vG9fXTCAl2F1kDq6OUHbqtPGhvtangAGjmlZ6w4N6Q5
         5gpw==
X-Gm-Message-State: AAQBX9fX3Sj9ZOG4yvGNiy25QLXhDrYJHzGMIJxtNJhK7d4ZKP0NdNTS
        0LNQutnDHZ3Sc+dOZjjYDQ/GEi9RC+U=
X-Google-Smtp-Source: AKy350akdwiGQS+vnTidftNvFlqI/DU7hmCXlEgKkmanmTmONWYI05UOT/QeRQLlg8GlQyDVDpxNzw==
X-Received: by 2002:a05:6808:2b0e:b0:389:15a5:179e with SMTP id fe14-20020a0568082b0e00b0038915a5179emr9476165oib.20.1680338830198;
        Sat, 01 Apr 2023 01:47:10 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id u13-20020a056808150d00b0038413a012dasm1855392oiw.4.2023.04.01.01.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:09 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 31/49] completion: bash: change suffix check in __gitcomp
Date:   Sat,  1 Apr 2023 02:46:08 -0600
Message-Id: <20230401084626.304356-32-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't match the prefix, we shouldn't match the suffix either.

There are no functional changes since all the callers that add a suffix
add an =, and if $cur_ ended with that suffix, we would return
immediately.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 502a1657a1..63a3235544 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -357,8 +357,8 @@ __gitcomp ()
 			fi
 			break
 		fi
-		c="$c${4-}"
 		if [[ $c == "$cur_"* ]]; then
+			c="$c${4-}"
 			case $c in
 			*=|*.) ;;
 			*) c="$c " ;;
-- 
2.33.0

