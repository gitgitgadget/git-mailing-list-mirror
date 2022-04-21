Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD7BC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 22:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392149AbiDUW6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 18:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392106AbiDUW6P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 18:58:15 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD612019F
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 15:55:24 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id f22so4357244qtp.13
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 15:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=29vfOIcXEvf68HMyaC+1o5NdZbUI1VDbMX8HBnRcyOc=;
        b=cUFkR3H/joVS2E1lKCLx3fh6qk662agf6YJgcbRWV+Y14EYWpcfu/0H4NSeSFW5wiK
         c4dqstCFmbPD1yPlU1CbRMVYrujvPx3czuOzZNZ8RgguGY8iZ8u4skqBCxanGQFqxW4g
         Luzf3LYf8kc8Hl57Mq+yNQCHp5qb7aWdN2WOM53jgpkYOOYrL19DfA4E26WcwYhK6zch
         RBxlH8YUvoW2bJQz4OBASkTQKi+J75aiUfVFdyvFX3v+9+cz41bbFpDk+43vdXuZwvN0
         0yxCCgnVx7s4ySPc58SH05qPjoirlB1NQRG0RH8Xngy4/mQ4wSwn8ScWNZWiidU0CnYD
         XLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=29vfOIcXEvf68HMyaC+1o5NdZbUI1VDbMX8HBnRcyOc=;
        b=bbWYwOo5fCE0XWLnBa0jMBeaQCwZ+TqrJmHmnOTMG6LSOFqpKeEvSER1ucwHnI5qbc
         v9ZtkLzOD8e9g2bDENxtxqwwPG/YN/6YWM3eHZrwnx0N0vwPjFikHaaQXU091qaA2gjH
         zH3jVFjezt2FzDj5OSCPvrP125R36PqreXLLAIW9tw4P9zQ7d0xzqqTPYXyM4DqX7Jbd
         zIpoZatKHw8dMst9risaEudyAzxVroAbxFxb810yEwrCuFZnUCMDKtj+69PSFTdhEh51
         BqG5xjf9uipNodj7B85mgOdrUQbQGy5GXf/RrTZOatWAnPYrRwBhP9MYyfCA+3a51+b0
         Zjsg==
X-Gm-Message-State: AOAM530VpET44mKrAGp+W3IjUqHTwdRNwmN/kNkqMGEW+zlE0LIgXYNL
        9rEtaGcEkme4+Wn4HD7srZ9HZ/bMKHI=
X-Google-Smtp-Source: ABdhPJxfFRKwweXv5+/Nk4G3dn3IXiQnNtTTzdGQdSf25bI0/0jBFkBEL2+bL0roAFq+lRmQx9dWsg==
X-Received: by 2002:ac8:5c13:0:b0:2f3:4277:bff1 with SMTP id i19-20020ac85c13000000b002f34277bff1mr1279673qti.154.1650581723591;
        Thu, 21 Apr 2022 15:55:23 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id v14-20020a05622a144e00b002f1f32f86a6sm255802qtx.5.2022.04.21.15.55.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 15:55:23 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sunshine@sunshineco.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] ci: make perforce installation optional in macOS
Date:   Thu, 21 Apr 2022 15:55:15 -0700
Message-Id: <20220421225515.6316-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.266.g59f845bde02
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using brew to install perforce has several documented[1,2,3,4] edge
cases that make it fail periodically, so if problems were found while
installing it, just continue without it.

This means that until the problem is solved all perforce tests will be
skipped in macOS, but they are still most likely covered by the other
unaffected runs and will be covered again once the issue solves itself.

1 0eb3671ed96 (ci(osx): use new location of the `perforce` cask, 2019-10-23)
2 5ed9fc3fc86 (ci: prevent `perforce` from being quarantined, 2020-02-27)
3 3831132ace6 (ci/install-depends: attempt to fix "brew cask" stuff, 2021-01-14)
4 https://lore.kernel.org/git/cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com/
---
This is based on master and can merge upwards except with seen where it
conflicts with the recently added ab/ci-osx-loosen-package-requirement
which it is meant to replace.

A successful sample run when merged with master available in :

  https://github.com/carenas/git/actions/runs/2204519374

 ci/install-dependencies.sh | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
wi
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index dbcebad2fb2..53da1afd9f3 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -43,7 +43,7 @@ macos-latest)
 		git -C "$cask_repo" pull --no-stat --ff-only &&
 		brew install --cask --no-quarantine perforce
 	} ||
-	brew install homebrew/cask/perforce
+	brew install homebrew/cask/perforce || true
 
 	if test -n "$CC_PACKAGE"
 	then
-- 
2.36.0.266.g59f845bde02

