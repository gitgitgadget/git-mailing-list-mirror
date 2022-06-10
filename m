Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAA1C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346001AbiFJCCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345837AbiFJCCR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:02:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B43DB5798
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:01:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z17so8392099wmi.1
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eAqVcp4UhXa/A07iwHrW4M56pNyB8B/KKMISTrT3Njc=;
        b=Ex8LFSk5J2SqOpLUvV9Empct14zjGiMdni+H5nwgepKakO6xU9f1MG5L1FQtXmrHB/
         JOqR//uJy5oq3cypim7d7UzXeE2f2atG/ORiEQAy+1Ihaxz8Ab8Uya4LzU/v8GLlHefT
         dTD71/O7TcAVVQTzejyQbgr/KZno0QxS+IU5RkgfvSukiN2yQdRhi4jE82FnEaoN3cqf
         FU/Pi2HuChRtdFqJ5Yc42RcwP7048x/FZxvdFCfXsdtsVlUuIXPzNsv0g6wizos59XvS
         ouro83kKWk2+Ud/TfGW8u3z60F5xXiq/rnIPHl5T4ajnyZQfETastyP0DZBRFxDLYju1
         tJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eAqVcp4UhXa/A07iwHrW4M56pNyB8B/KKMISTrT3Njc=;
        b=eeSYvgHYQ2tVztbWHKRCGxit1MSuEvGo9LcW4TvoaVgP4os6l9lWu3jQ8+4r3uLuOz
         ZvXvDca6HufZ2iE3QMGXasfYcge27Fv+p7Wpa2pU6jYhxNdhORnnJfvTtnGWwSjU7yZ6
         1ropUK5z8wgzX9RA7E6HTWyHZv199688AkUYfhx/SAovXvgh1PBlnpNWY55BrafU1xii
         PParDk+TQSPSU/kseSFVOqO2cfGKP4yF0ukcy2i0xoeB+xHDZ9CT4/rsm5XYOv1AquQy
         qBgCi8oXdhX+hy8eKb4fU5GLKo2xpAlxyU32mDv1LzrGlflQ59WLM6sZa5j68Eiam234
         G6Qw==
X-Gm-Message-State: AOAM53152kvdd9vnvDNV86/cSURFKZ1/9BYWcJMfZqHQHNiniBoTpodu
        re1cX2YvLNhrHqGDHgwr2jLPIgTGw1Wwxw==
X-Google-Smtp-Source: ABdhPJzIXJ5DiZoAEDe+Fl5euAuo0o8HWpldL4gR8bSm8pQrSr7JaKBmrB8eq95C6LvAUT5M6mSKpQ==
X-Received: by 2002:a7b:c404:0:b0:39c:4389:5834 with SMTP id k4-20020a7bc404000000b0039c43895834mr6320944wmi.70.1654826516696;
        Thu, 09 Jun 2022 19:01:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:01:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 11/20] git-submodule.sh: dispatch "foreach" to helper
Date:   Fri, 10 Jun 2022 04:01:23 +0200
Message-Id: <RFC-patch-11.20-625320e13b9-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dispatch the "git submodule foreach" command directly to "git
submodule--helper foreach". This case requires the addition of the
PARSE_OPT_STOP_AT_NON_OPTION flag, since the shellscript was
unconditionally adding "--" to the "git submodule--helper"
command-line.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c |  3 ++-
 git-submodule.sh            | 37 +++----------------------------------
 2 files changed, 5 insertions(+), 35 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3173295ed8e..459260efc65 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -449,7 +449,8 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, module_foreach_options,
-			     git_submodule_helper_usage, 0);
+			     git_submodule_helper_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
 		return 1;
diff --git a/git-submodule.sh b/git-submodule.sh
index 61e4f17b805..de6c71d6bd5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -47,37 +47,6 @@ jobs=
 recommend_shallow=
 filter=
 
-
-# Execute an arbitrary command sequence in each checked out
-# submodule
-#
-# $@ = command to execute
-#
-cmd_foreach()
-{
-	# parse $args after "submodule ... foreach".
-	while test $# -ne 0
-	do
-		case "$1" in
-		-q|--quiet)
-			GIT_QUIET=1
-			;;
-		--recursive)
-			recursive=1
-			;;
-		-*)
-			usage
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
-}
-
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
@@ -262,10 +231,10 @@ case "$command" in
 absorbgitdirs)
 	git submodule--helper "$command" --prefix "$wt_prefix" "$@"
 	;;
-foreach | update)
-	"cmd_$command" "$@"
+update)
+	cmd_update "$@"
 	;;
-add | init | deinit | set-branch | set-url | status | summary | sync)
+add | foreach | init | deinit | set-branch | set-url | status | summary | sync)
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper "$command" \
 		${GIT_QUIET:+--quiet} ${cached:+--cached} "$@"
 	;;
-- 
2.36.1.1178.gb5b1747c546

