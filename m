Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB6BC43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345976AbiFJCC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345975AbiFJCCa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:02:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB0CBCEA3
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:02:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so447273wmq.0
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QUWD5pzv1klZUb2fHnjW/w1WlwBT7PTobBqrUZ3Y7tE=;
        b=dQ/Rm7zHSXsEMFc1d7h3nqqxxboKHF/7h5BYIKxu2TBVfL1m78PhsZYS7hUC6avAPG
         35yGpINj0Y8E2t2QpYcm6wIR9SRsxyiZQEjAF9jBKP3fl2VAkFfdcBA9ODzttAojHzNQ
         Eq4jSO54k2e57FoLH99QzYekVlC4JU37Uw3gRYcEZnlF0EA7ckVUrVUguHtb6WtXHMln
         D/6XJ4wYE/jN5N7cdhWoXbuaJfQTvws7R+yDou4+zTDekmyAW5ZhwWOjS05Y/ZdvgNHB
         Y+4L7Hbj8yid/IUNvjls14zX3eA0TtIR0dI+RnwnRHofa1n7+QY42kkZBmQTQeAU3c1N
         F9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QUWD5pzv1klZUb2fHnjW/w1WlwBT7PTobBqrUZ3Y7tE=;
        b=y9go/WWXwh2tMhSq8Sr1SKbhpAnJnqv6AzLKWDBePeN8lRf9ziEdWuKO38ueGnc0lN
         xHPq56of7iJSUTERU1281VoB3aC4PYpl2j7gkUdLUoGFwAp5WY7Aoqp0wjgl90Vthgh0
         KyoV1SeQp89Iz6IagShm2vaQe8hg9b4GSnHC9o+ZzsL2YzMm5twDSMmDSsCrqF0SgyiK
         Sc/7FIfz21r3jBzCyxM8isZLKXAEInncU9y7g3+tmK72UcC4ITcnsKG47DR75zz4JVcq
         FJSspK8NW1WETZuQXCIhxGzO7OQoUhNlEIBm/D8I0q1S4UAZMYJLNakHCx4/uZ+BkcDk
         yA0w==
X-Gm-Message-State: AOAM531LG2U8t5z11HIXsg1Q50m23iCBrtf4TsG9zVuiJK5cPw2jH8ow
        qFadxRt9iyHXYtd0cyvZ1HTHBCUI18XoLQ==
X-Google-Smtp-Source: ABdhPJxZUuiZgps8s6im+AeDK605+AJtpdIGQdsb7b0CEkBbENAHEXAWiXzQc2JWNLeoLFqdJNt+4g==
X-Received: by 2002:a05:600c:4f4e:b0:39c:1bbb:734f with SMTP id m14-20020a05600c4f4e00b0039c1bbb734fmr6241809wmq.116.1654826522910;
        Thu, 09 Jun 2022 19:02:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:02:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 17/20] git-submodule.sh: use "$quiet", not "$GIT_QUIET"
Date:   Fri, 10 Jun 2022 04:01:29 +0200
Message-Id: <RFC-patch-17.20-59a72296967-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the use of the "$GIT_QUIET" variable in favor of our own
"$quiet", ever since b3c5f5cb048 (submodule: move core cmd_update()
logic to C, 2022-03-15) we have not used the "say" function in
git-sh-setup.sh, which is the only thing that's affected by using
"GIT_QUIET".

We still want to support --quiet for our own use though, but let's use
our own variable for that.

This change could have come before the preceding commits which removed
cmd_*() functions from this file, but that would have been a much more
verbose change. Since we were removing most of the uses of
"$GIT_QUIET" this change comes after those.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index e245b7fbaca..cad9948c047 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -30,6 +30,7 @@ GIT_PROTOCOL_FROM_USER=0
 export GIT_PROTOCOL_FROM_USER
 
 command=
+quiet=
 cached=
 
 while test $# != 0 && test -z "$command"
@@ -39,7 +40,7 @@ do
 		command=$1
 		;;
 	-q|--quiet)
-		GIT_QUIET=1
+		quiet=1
 		;;
 	--cached)
 		cached=1
@@ -80,10 +81,10 @@ absorbgitdirs)
 	;;
 update)
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
-		${GIT_QUIET:+--quiet} ${wt_prefix:+--prefix "$wt_prefix"} "$@"
+		${quiet:+--quiet} ${wt_prefix:+--prefix "$wt_prefix"} "$@"
 	;;
 add | foreach | init | deinit | set-branch | set-url | status | summary | sync)
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
-		${GIT_QUIET:+--quiet} ${cached:+--cached} "$@"
+		${quiet:+--quiet} ${cached:+--cached} "$@"
 	;;
 esac
-- 
2.36.1.1178.gb5b1747c546

