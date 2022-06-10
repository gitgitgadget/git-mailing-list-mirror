Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F3EC43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346009AbiFJCCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345943AbiFJCCR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:02:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7F4BDA15
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:02:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so418081wms.5
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c07e5/LSFi4qo8tGTS5JLNXr3xBds4Onc4VXcs4bjKw=;
        b=eVCRFE9AJLzvfK/aLQOV3cWjVHxXs/bKNSVi5naDmU1DMsybRPDtFTXCK1fj5A/TK1
         QyWpCzm7jWOVqNvS2ZKzxCi4/cCBpbCTDd3RDHjA5Uot96OREx18Ueq/7dGNZumVfxS8
         5iBiz9Z8tx9+2cXNZq+pOfrtS5v7Q5zVnOPYVH8OidriB/6KlN+8ag/H+uGXNYr7nO1V
         2fEFmtpx/Gy434BIQpbVReyxZbjtIg1E7TOZuKzMcIIhLzhXC42693wMsUayewTYM0pl
         It9XhGT7zFjWtCq1dDhUsv7q0RW8VUTCgqrwmmyES7FVWMjUuqW3GBY+4H4CneZ/tu/C
         S5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c07e5/LSFi4qo8tGTS5JLNXr3xBds4Onc4VXcs4bjKw=;
        b=ZD3xOhzokZvZ97FAkCC7a8aj77ghUfD/BbMCO56CeP4D65G/YoA69+wOetYMQZ9XUt
         savHulZjMbQsdHLwXNBwIirWzR5MhCDD7dtB+9WlN5a8pRXgKcL+LvYDZC/B/17s7c0p
         Puoicozyxzr61HFXs8Ds1OUoSQoPK6yENIXRVHm7dJL6BHuSu36YBW2JqW8D1rKBjW0H
         4BHnH6e/u7DTa8MyhGZW86gcUx6JJbSQ8gDUIKL0PxFybIrrsHMbjXwfNDOmf4BybKe+
         cdy98NWp0yWLh5E5wTRF2Gs4gBxyr/90sJmyph1LF0ag6VL0vacaXe2h7b+CbuB0sEce
         chIQ==
X-Gm-Message-State: AOAM5307IDVaSm2LsxrMsfUV/MQe0dI7YTWQNpbnJikQ9PXUIPdJcM0T
        tIp4DUxzEtNSOGZVhEbRvS7pz2v0jtLuPA==
X-Google-Smtp-Source: ABdhPJz5BfhUAdOUPP3JcTAi8IAIH0EQnAITpuv0nuW+MFDtnVuMvwL6k/LxHqEFf10UnKQKHVwLHA==
X-Received: by 2002:a05:600c:214c:b0:39c:43b9:9d5f with SMTP id v12-20020a05600c214c00b0039c43b99d5fmr6080677wml.56.1654826523857;
        Thu, 09 Jun 2022 19:02:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:02:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 18/20] git-submodule.sh: simplify parsing loop
Date:   Fri, 10 Jun 2022 04:01:30 +0200
Message-Id: <RFC-patch-18.20-c5796878f0b-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify the parsing loop so that we don't try to find out the
"$command" when looping over arguments initially, we'll only look for
the --quiet and --cached options.

Then if we have no more arguments we default to "status", otherwise we
emit our usage info. Most importantly we don't need to give --cache to
only "status" and "summary", instead we trust that "submodule--helper"
is checking those arguments, if some subcommands don't them they can
emit their own errors.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index cad9948c047..0274b253297 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -29,50 +29,40 @@ cd_to_toplevel
 GIT_PROTOCOL_FROM_USER=0
 export GIT_PROTOCOL_FROM_USER
 
-command=
 quiet=
 cached=
 
-while test $# != 0 && test -z "$command"
+while test $# != 0
 do
 	case "$1" in
-	add | foreach | init | deinit | update | set-branch | set-url | status | summary | sync | absorbgitdirs)
-		command=$1
-		;;
 	-q|--quiet)
-		quiet=1
+		quiet=1 &&
+		shift
 		;;
 	--cached)
-		cached=1
-		;;
-	--)
-		break
-		;;
-	-*)
-		usage
+		cached=1 &&
+		shift
 		;;
 	*)
 		break
 		;;
 	esac
-	shift
 done
 
 # No command word defaults to "status"
-if test -z "$command"
+command=
+if test $# = 0
 then
-    if test $# = 0
-    then
 	command=status
-    else
-	usage
-    fi
-fi
-
-# "--cached" is accepted only by "status" and "summary"
-if test -n "$cached" && test "$command" != status && test "$command" != summary
-then
-	usage
+else
+	case "$1" in
+	add | foreach | init | deinit | update | set-branch | set-url | status | summary | sync | absorbgitdirs)
+		command=$1 &&
+		shift
+		;;
+	*)
+		usage
+	esac
 fi
 
 case "$command" in
@@ -83,7 +73,7 @@ update)
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
 		${quiet:+--quiet} ${wt_prefix:+--prefix "$wt_prefix"} "$@"
 	;;
-add | foreach | init | deinit | set-branch | set-url | status | summary | sync)
+*)
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
 		${quiet:+--quiet} ${cached:+--cached} "$@"
 	;;
-- 
2.36.1.1178.gb5b1747c546

