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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B0FC43461
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58B9C61244
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbhDLLJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239953AbhDLLJb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:09:31 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D10CC06174A
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j5so11512177wrn.4
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vHYA0D1toPavqtolWM0ZcBl7gQYmkYwp53GiQbfFnq8=;
        b=NVSrIkZttkD4wXu81po+9/Ahkb2eVCIPLaE0c08nhPo5f91kFGSp/ofxiPkF1ZMEA0
         KbLq4Nqm8HvlhxZE6QP5iiB55fVJyoF5rVNWmYHbEmUgT2lwt45kef6Si6VNi2klH+lh
         xGvRBLSFsuzG9RQAB4ExHhjJmLteONCoYvedFXRzP9TrwI0mbOyZMp+mytYRIrQf/OUI
         na7tWupCHPe3BC5Wqe5EubPHwpBVUmyK+QUBxKQ2r0ZjbJr+dL7spNijbZniA42uwtbg
         vtWdR8zZQvOpznsCbftgtrw/DTrfEGoaGx9fpy9nRgxnfqrdlI2RcZ1NXLs9BkcT6Px8
         WVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vHYA0D1toPavqtolWM0ZcBl7gQYmkYwp53GiQbfFnq8=;
        b=mmfyasVgzvXZoYQJJMjYaUCs4dS0NMmU9WRN0mAPK3tNw6u74oM7t2oQF4JlRs4nBG
         LQ5fKMqcUd699+ZIIJeNro+EdGpmxBJLhz7y0HyDBn9M+teE4RrcfBDT9KE7/I4iNX8Q
         kVGSywSf4HUMBe5RA33lO0OmY8MaLP533Pi5yZAudK0N0zLYf8IyOL8gnSOhN2m4YPYg
         GUHILZRcFTLcIVw2rUSe8U2THmScKvGJdOArKb2cXqWh9gOSQDgs9evYaHEf3aPMmPCP
         n2h1/EewWxp7OL2BjIpV6eLJxkacGYcd8YArzETpLjEtAiQurLSn9oBq8qyrwWd6Q+3F
         rVkw==
X-Gm-Message-State: AOAM531W9Qd5ZCRDbxgShGydYowq+utUcEdDAwfGEag0bhpbrvCMv0rp
        WhqHDCT50TLGMGZWeENMlwnriqkV7wYDbw==
X-Google-Smtp-Source: ABdhPJwFo0D83XuYbxp4dZVBE6KGI/wCLEomcaTSJr5B47rFU0n/DGp79UpTibzpoiavGhHNYGADQg==
X-Received: by 2002:a05:6000:22d:: with SMTP id l13mr21586712wrz.26.1618225752141;
        Mon, 12 Apr 2021 04:09:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm18158744wrh.91.2021.04.12.04.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:09:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/16] test-lib: bring $remove_trash out of retirement
Date:   Mon, 12 Apr 2021 13:08:51 +0200
Message-Id: <patch-02.16-44223ae777e-20210412T110456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no point in creating a repository or directory only to decide
right afterwards that we're skipping all the tests.

So let's partially revert 06478dab4c (test-lib: retire $remove_trash
variable, 2017-04-23) and move the decision about whether to skip all
tests earlier.

I tested this with --debug, see 4d0912a206 (test-lib.sh: do not barf
under --debug at the end of the test, 2017-04-24) for a bug we don't
want to re-introduce.

While I'm at it let's move the HOME assignment to just before
test_create_repo, it could be lower, but it seems better to set it
before calling anything in test-lib-functions.sh

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index d3f6af6a654..a8869eee58f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1167,7 +1167,7 @@ test_done () {
 			esac
 		fi
 
-		if test -z "$debug"
+		if test -z "$debug" && test -n "$remove_trash"
 		then
 			test -d "$TRASH_DIRECTORY" ||
 			error "Tests passed but trash directory already removed before test cleanup; aborting"
@@ -1332,6 +1332,21 @@ then
 	exit 1
 fi
 
+# Are we running this test at all?
+this_test=${0##*/}
+this_test=${this_test%%-*}
+if match_pattern_list "$this_test" $GIT_SKIP_TESTS
+then
+	say_color info >&3 "skipping test $this_test altogether"
+	skip_all="skip all tests in $this_test"
+	test_done
+fi
+
+# Last-minute variable setup
+HOME="$TRASH_DIRECTORY"
+GNUPGHOME="$HOME/gnupg-home-not-used"
+export HOME GNUPGHOME
+
 # Test repository
 rm -fr "$TRASH_DIRECTORY" || {
 	GIT_EXIT_OK=t
@@ -1339,10 +1354,7 @@ rm -fr "$TRASH_DIRECTORY" || {
 	exit 1
 }
 
-HOME="$TRASH_DIRECTORY"
-GNUPGHOME="$HOME/gnupg-home-not-used"
-export HOME GNUPGHOME
-
+remove_trash=t
 if test -z "$TEST_NO_CREATE_REPO"
 then
 	test_create_repo "$TRASH_DIRECTORY"
@@ -1354,15 +1366,6 @@ fi
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$TRASH_DIRECTORY" || exit 1
 
-this_test=${0##*/}
-this_test=${this_test%%-*}
-if match_pattern_list "$this_test" $GIT_SKIP_TESTS
-then
-	say_color info >&3 "skipping test $this_test altogether"
-	skip_all="skip all tests in $this_test"
-	test_done
-fi
-
 if test -n "$write_junit_xml"
 then
 	junit_xml_dir="$TEST_OUTPUT_DIRECTORY/out"
-- 
2.31.1.634.gb41287a30b0

