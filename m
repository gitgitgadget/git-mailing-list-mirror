Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA8AC77B61
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 13:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbjDGN5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 09:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237677AbjDGN4u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 09:56:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC07FAF12
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 06:56:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i8-20020a05600c354800b003ee93d2c914so620109wmq.2
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 06:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680875766;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R6E9cXjPfTU5Tm5zfhuGzAip1uwar8L3I8bMLROwFtw=;
        b=HRa15vZbgBbtKvM2Si/Qj9mckpIS7nBquxokr2z0cu4oiZi30br2YWho1oVvkHYii5
         Imm+H9m5qnx6SM2FPWtRJbKPK9J0wszRt1nettl4dFoGDFgpNHtKiul0Hl18UxCAPTEu
         ZhAtsonVix2aKr8dnno7Nv3HTJPod9MS2d9sVklwjwmXdd3SKghqIcMMYgo+MicKSfvx
         AKkz9m8+KEVyIjQyLk3I6UlKgrQ2rVANiijdNvYpUAHg6Ihs6w1EoNAqvPjxp9ezhUUQ
         g+kIdHDyef0ZKhWNYOYg8kGtb38Eds14I84je1aMjW+zTlIH2HicqonlAS9vybZ8fSiZ
         tFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680875766;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6E9cXjPfTU5Tm5zfhuGzAip1uwar8L3I8bMLROwFtw=;
        b=iiA01Crwg8evENRe8xYQGqHnjeHvE8BYKFMDzOnSI7fdgqryr6gOhNHrSEWwDiAIMx
         K1eKGklLeGUMo3N32u1I+bEBM20bI4A8hmxoaO2S95XixOFQBfLrizoviM736Qximw4I
         2ZiSrbJXirmLbAMuwXTKUGvkFsORAyWNfDVp4507VEjcSfYlUIwzl1UEn4d7VHLwrIla
         RWP0G/YxDn2cAbWeSX7QrtDEHsUXgp/JI0XY8QnIYL5A8diR7UCJurLioe+cKV+VJLDj
         wcZo+rUV8Fa29mEJ4DefizFt+/mEiI2PegB4q8NS3duH/YjskF+P5DDKd6Q97oWl07pu
         YCcA==
X-Gm-Message-State: AAQBX9dzP/5Wo4mZIFlEoQ++u2O1ou0Cx7XUOZpmUKx1xchZqq7mseaC
        igfrNfKJlUGLT8QuNRghp5a01jGQLUg=
X-Google-Smtp-Source: AKy350Zyt2zatxuDBoFnQYl2lT49M4r8BHVrThPdaSKllSw6QR0QVfxEU0Pe4abhaaLZSMmUAHtqjw==
X-Received: by 2002:a05:600c:ac3:b0:3ee:1084:aa79 with SMTP id c3-20020a05600c0ac300b003ee1084aa79mr1211266wmr.20.1680875766218;
        Fri, 07 Apr 2023 06:56:06 -0700 (PDT)
Received: from localhost.localdomain ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id p15-20020a1c740f000000b003edc11c2ecbsm4742003wmc.4.2023.04.07.06.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 06:56:05 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 5/5] rebase: remove a couple of redundant strategy tests
Date:   Fri,  7 Apr 2023 14:55:35 +0100
Message-Id: <2d1d3281102f824b3eeb491ddc7e92239aee539f.1680875701.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.0.670.g64ef305212.dirty
In-Reply-To: <cover.1680875701.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk> <cover.1680875701.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Remove a test in t3402 that has been redundant ever since 80ff47957b
(rebase: remember strategy and strategy options, 2011-02-06).  That
commit added a new test, the first part of which (as noted in the old
commit message) duplicated an existing test.

Also remove a test t3418 that has been redundant since the merge backend
was removed in 68aa495b59 (rebase: implement --merge via the interactive
machinery, 2018-12-11), since it now tests the same code paths as the
preceding test.

Helped-by: Elijah Newren <newren@gmail.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3402-rebase-merge.sh    | 21 ---------------------
 t/t3418-rebase-continue.sh | 32 --------------------------------
 2 files changed, 53 deletions(-)

diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 7e46f4ca85..79b0640c00 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -131,27 +131,6 @@ test_expect_success 'picking rebase' '
 	esac
 '
 
-test_expect_success 'rebase -s funny -Xopt' '
-	test_when_finished "rm -fr test-bin funny.was.run" &&
-	mkdir test-bin &&
-	cat >test-bin/git-merge-funny <<-EOF &&
-	#!$SHELL_PATH
-	case "\$1" in --opt) ;; *) exit 2 ;; esac
-	shift &&
-	>funny.was.run &&
-	exec git merge-recursive "\$@"
-	EOF
-	chmod +x test-bin/git-merge-funny &&
-	git reset --hard &&
-	git checkout -b test-funny main^ &&
-	test_commit funny &&
-	(
-		PATH=./test-bin:$PATH &&
-		git rebase -s funny -Xopt main
-	) &&
-	test -f funny.was.run
-'
-
 test_expect_success 'rebase --skip works with two conflicts in a row' '
 	git checkout second-side  &&
 	tr "[A-Z]" "[a-z]" <newfile >tmp &&
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 42c3954125..2d0789e554 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -97,38 +97,6 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	test_cmp expect actual
 '
 
-test_expect_success 'rebase -i --continue handles merge strategy and options' '
-	rm -fr .git/rebase-* &&
-	git reset --hard commit-new-file-F2-on-topic-branch &&
-	test_commit "commit-new-file-F3-on-topic-branch-for-dash-i" F3 32 &&
-	test_when_finished "rm -fr test-bin funny.was.run funny.args" &&
-	mkdir test-bin &&
-	cat >test-bin/git-merge-funny <<-EOF &&
-	#!$SHELL_PATH
-	echo "\$@" >>funny.args
-	case "\$1" in --opt) ;; *) exit 2 ;; esac
-	case "\$2" in --foo) ;; *) exit 2 ;; esac
-	case "\$4" in --) ;; *) exit 2 ;; esac
-	shift 2 &&
-	>funny.was.run &&
-	exec git merge-recursive "\$@"
-	EOF
-	chmod +x test-bin/git-merge-funny &&
-	(
-		PATH=./test-bin:$PATH &&
-		test_must_fail git rebase -i -s funny -Xopt -Xfoo main topic
-	) &&
-	test -f funny.was.run &&
-	rm funny.was.run &&
-	echo "Resolved" >F2 &&
-	git add F2 &&
-	(
-		PATH=./test-bin:$PATH &&
-		git rebase --continue
-	) &&
-	test -f funny.was.run
-'
-
 test_expect_success 'rebase -r passes merge strategy options correctly' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&
-- 
2.40.0.670.g64ef305212.dirty

