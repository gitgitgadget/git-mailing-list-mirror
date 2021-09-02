Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC759C43214
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FCA260FDA
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346077AbhIBQC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346074AbhIBQCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 12:02:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9472BC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 09:01:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b10so3812485wru.0
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 09:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PlY8tfqzNoNZPApKXO/wLV251WT7R8KTVw5X+1l2V9Y=;
        b=XQkK+jfiEDHuk3VudNN3pOODUR1EH17po5SFmmJHgSyjAPL0h7ciH5jq3FnpIsOe+g
         AoiVBs4evfdurXTQwR3eIMaYhAaugW3BpTpv1BtUuFnUrtLg/RLdX5T6QsBtH9clZUYp
         yLR6pVVxWvH0Lqqn/L33saKnKIUxLjNDE7whaidrExArLzkdOjOKMYyN30DFzNQ0jmhk
         ELjVxE76zU/y1E3jWqIrXUGTp3ytWIxFVFDTsD1KbUylMYqgtC3d3Ozlbto1GmSIuPfq
         dPhWP4dnCwr+2w5ppJpK9o2DcYyD1Chn326dFHvai1bK0SPwXHAYayvQWZUxqLngNTdv
         MO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PlY8tfqzNoNZPApKXO/wLV251WT7R8KTVw5X+1l2V9Y=;
        b=Ok6ByUz60qF2cnkk6k+U4btyuCikHK8uosxnRm786wtuwDf3M26JMy7w726nQlfqjj
         Pj+fBUFAWGVexwDjXa+CRNXq0EvVzR5sqHvG++chW9wvbvQyRoTjOElMmd4Qb9N4Rc97
         09CvISinMDheNG7blAgByQ+NK6qOV0nKiHRK5tplj8kjU9lo8FaR8LqnHqzOMdneZaLH
         703at+97GGAeGVxYxuYBkNWrGAFJWrjTURvVR1orwxgZLiIg8xr1KyvWr2E3s7JwZhDr
         6tQIl+fTrKrGirlRWOeBqj73Gc1JUDxdtbDcwoMrFFZ9czJrP81Kc1dptOrVlTWjN9xF
         KZTQ==
X-Gm-Message-State: AOAM5309Tmta9JT1b2lftb4D9Wk6w3iqtH6A087vilZv2P4vPbstRT4O
        d+SCsA8YS+Y2q1+VAzRrOOebtxLh2CQHRA==
X-Google-Smtp-Source: ABdhPJzVv8yXuHoqjAKtSiDWSjcmnRigDd3AjCNU2YZYMMpnoLzL4hJw3Ea3MlwkOvQjvRPg4cnz9Q==
X-Received: by 2002:adf:c149:: with SMTP id w9mr4631062wre.126.1630598484835;
        Thu, 02 Sep 2021 09:01:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u26sm2403215wrd.32.2021.09.02.09.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:01:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/9] git-sh-setup: remove unused git_pager() function
Date:   Thu,  2 Sep 2021 18:01:10 +0200
Message-Id: <patch-3.9-73e540896fc-20210902T155758Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.814.gb82868f05f3
In-Reply-To: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the git_editor() function last referenced by non-test code code
in 49eb8d39c78 (Remove contrib/examples/*, 2018-03-25).

We can also remove the test for this added in 995bc22d7f8 (pager: move
pager-specific setup into the build, 2016-08-04), the test that
actually matters is the one added in e54c1f2d253 (pager: set LV=-c
alongside LESS=FRSX, 2014-01-06) just above the removed test.

I.e. we don't care if the "LESS" and "LV" variables are set by
git-sh-setup anymore, no built-in uses them, we do care that pager.c
sets them, which we still test for.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-sh-setup.sh  | 16 ----------------
 t/t7006-pager.sh | 13 -------------
 2 files changed, 29 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index cfedda79471..d4e8225affa 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -106,22 +106,6 @@ $LONG_USAGE")"
 	esac
 fi
 
-git_pager() {
-	if test -t 1
-	then
-		GIT_PAGER=$(git var GIT_PAGER)
-	else
-		GIT_PAGER=cat
-	fi
-	for vardef in @@PAGER_ENV@@
-	do
-		var=${vardef%%=*}
-		eval ": \"\${$vardef}\" && export $var"
-	done
-
-	eval "$GIT_PAGER" '"$@"'
-}
-
 sane_grep () {
 	GREP_OPTIONS= LC_ALL=C grep @@SANE_TEXT_GREP@@ "$@"
 }
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 0e7cf75435e..08f712a4497 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -49,19 +49,6 @@ test_expect_success TTY 'LESS and LV envvars are set for pagination' '
 	grep ^LV= pager-env.out
 '
 
-test_expect_success !MINGW,TTY 'LESS and LV envvars set by git-sh-setup' '
-	(
-		sane_unset LESS LV &&
-		PAGER="env >pager-env.out; wc" &&
-		export PAGER &&
-		PATH="$(git --exec-path):$PATH" &&
-		export PATH &&
-		test_terminal sh -c ". git-sh-setup && git_pager"
-	) &&
-	grep ^LESS= pager-env.out &&
-	grep ^LV= pager-env.out
-'
-
 test_expect_success TTY 'some commands do not use a pager' '
 	rm -f paginated.out &&
 	test_terminal git rev-list HEAD &&
-- 
2.33.0.814.gb82868f05f3

