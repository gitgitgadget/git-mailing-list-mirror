Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAFAC433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 01:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E7060ED7
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 01:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbhJKBoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 21:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbhJKBoF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 21:44:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4C5C061570
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 18:42:05 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g25so4200358wrb.2
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 18:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WB6+7FTJDt+28KTGYbKRJaELxdSorvQ3Kdy1hit8+CQ=;
        b=R0wn562HGZ1gENRxRw3k9oc6tb7sx1FVJ6H+rDIHQqtb6t1+PE0XftE7erRBCG4HaU
         DZ3hLvtYsGaMjipnTFzMkITKtmDBsPSuWLctP8TLPo4QLPf7oAVRDlP5MC9XwZGunh2S
         r515DWWEK6WxpGc0HnvXb7tqkBS4lL5CXVuuArONO7elFqQcyw6WFeAGSj6KjsK9OfOr
         C0qFMOVvLZ8YJLBZAOQ5HWebGmAJtiN6jBQTATf4hhWG8Pf7woBdAPPlqWZ7NCO/akeB
         3RChNRNjAnJnThveJgUd9I6CkbeVIv8SXZlJq3ty0sIpES9EEILSaZG3w/dWC3cT2+49
         QDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WB6+7FTJDt+28KTGYbKRJaELxdSorvQ3Kdy1hit8+CQ=;
        b=XjPJ02tUj3J6MShckZsQC609/Bd9gqHVCk4+cUmx1LqWQzRdG3SyGyYVGeqFo8X1bW
         +hydy2x2+iabZFgk3/k/59YGFzSoPPwodgiBR4oBCtlO2VStgXrC+HrkGBK/TBM9W3Zq
         Foh2+HyXax9YOBrRFuu0ULQR5ZnvzZ1QUINOs175yHMAIdyKJIgAjIorPEtPqMlTcOLq
         1DmNr3/WxQOMjNjvWF521DvGO1Ju40e/srUWSZVF9ZobtvYcrYgyYDt6YOmffEtAw2+M
         fKjak8HG6iS6VS+8gRnXsFHzLdMJm6TqW0CP/djaXuuzaGG3FSUeSWkk2JFyNW3F1a4L
         glTQ==
X-Gm-Message-State: AOAM531140QvqofL3m5HWDFNIhtIDYyUdNHdyanC41mZM9sWoimNlRDG
        OjZ/jODO1JNJOhDCqvsjHUYsXdL6YASqyg==
X-Google-Smtp-Source: ABdhPJzRSaYwA3G3iAVXKmreZkP1hoZHbalsmpnWY+LphzrUXzczl0tw1TiFGtIUxTF3JisoUcVeZg==
X-Received: by 2002:a05:6000:2a1:: with SMTP id l1mr21594009wry.87.1633916523866;
        Sun, 10 Oct 2021 18:42:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o6sm371428wms.3.2021.10.10.18.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 18:42:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] test-lib.sh: try to re-chmod & retry on failed trash removal
Date:   Mon, 11 Oct 2021 03:41:59 +0200
Message-Id: <patch-v2-1.1-9cfc0621067-20211011T014059Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1505.g38ce83107ad
In-Reply-To: <patch-1.1-d7e88a77fef-20211009T133043Z-avarab@gmail.com>
References: <patch-1.1-d7e88a77fef-20211009T133043Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Try to re-chmod the trash directory on startup if we fail to "rm -rf"
it. This fixes problems where the test leaves the trash directory
behind in a bad permission state for whatever reason.

This fixes an interaction between [1] where t0004-unwritable.sh was
made to use "test_when_finished" for cleanup, and [2] which added the
"--immediate" mode. If a test in this file failed when running with
"--immediate" we wouldn't run the "test_when_finished" block, which
re-chmods the ".git/objects" directory (see [1]).

This can be demonstrated as e.g. (output snipped for less verbosity):

    $ ./t0004-unwritable.sh --run=3 --immediate
    ok 1 # skip setup (--run)
    ok 2 # skip write-tree should notice unwritable repository (--run)
    not ok 3 - commit should notice unwritable repository
    [...]
    $ ./t0004-unwritable.sh --run=3 --immediate
    rm: cannot remove '[...]/trash directory.t0004-unwritable/.git/objects/info': Permission denied
    FATAL: Cannot prepare test area
    [...]

Instead of some version of reverting [1] let's make the test-lib.sh
resilient to this edge-case, it will happen due to [1], but also
e.g. if the relevant "test-lib.sh" process is kill -9'd during the
test run. We should try harder to recover in this case. If we fail to
remove the test directory let's retry after (re-)chmod-ing it.

This doesn't need to be guarded by something that's equivalent to
"POSIXPERM" since if we don't support "chmod" we were about to fail
anyway.

Let's also discard any error output from (a possibly nonexisting)
"chmod", we'll fail on the subsequent "rm -rf" anyway, likewise for
the first "rm -rf" invocation, we don't want to get the "cannot
remove" output if we can get around it with the "chmod", but we do
want any error output from the second "rm -rf", in case that doesn't
fix the issue.

The lack of &&-chaining between the "chmod" and "rm -rf" is
intentional, if we fail the first "rm -rf", can't chmod, but then
succeed the second time around that's what we were hoping for. We just
want to nuke the directory, not carry forward every possible error
code or error message.

1. dbda967684d (t0004 (unwritable files): simplify error handling,
   2010-09-06)
2. b586744a864 (test: skip clean-up when running under --immediate
   mode, 2011-06-27)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
Range-diff against v1:
1:  d7e88a77fef ! 1:  9cfc0621067 test-lib.sh: try to re-chmod & retry on failed trash removal
    @@ Metadata
      ## Commit message ##
         test-lib.sh: try to re-chmod & retry on failed trash removal
     
    -    This fixes a regression in [1] where t0004-unwritable.sh was made to
    -    use "test_when_finished" for cleanup, we wouldn't re-chmod the
    -    ".git/objects" on failure, leading to a persistent error when running
    -    the test.
    +    Try to re-chmod the trash directory on startup if we fail to "rm -rf"
    +    it. This fixes problems where the test leaves the trash directory
    +    behind in a bad permission state for whatever reason.
    +
    +    This fixes an interaction between [1] where t0004-unwritable.sh was
    +    made to use "test_when_finished" for cleanup, and [2] which added the
    +    "--immediate" mode. If a test in this file failed when running with
    +    "--immediate" we wouldn't run the "test_when_finished" block, which
    +    re-chmods the ".git/objects" directory (see [1]).
     
         This can be demonstrated as e.g. (output snipped for less verbosity):
     
    @@ Commit message
             FATAL: Cannot prepare test area
             [...]
     
    -    I.e. if any of its tests failed, and the tests were being run under
    -    "--debug"[2] or "--immediate"[3] (which was introduced after [1]) we
    -    wouldn't re-chmod the object directory. We'd then fail on the next run
    -    since the test setup couldn't remove the trash files.
    -
         Instead of some version of reverting [1] let's make the test-lib.sh
         resilient to this edge-case, it will happen due to [1], but also
         e.g. if the relevant "test-lib.sh" process is kill -9'd during the
    @@ Commit message
     
         This doesn't need to be guarded by something that's equivalent to
         "POSIXPERM" since if we don't support "chmod" we were about to fail
    -    anyway. Let's also discard any error output from (a possibly
    -    nonexisting) "chmod", we'll fail on the subsequent "rm -rf"
         anyway.
     
    +    Let's also discard any error output from (a possibly nonexisting)
    +    "chmod", we'll fail on the subsequent "rm -rf" anyway, likewise for
    +    the first "rm -rf" invocation, we don't want to get the "cannot
    +    remove" output if we can get around it with the "chmod", but we do
    +    want any error output from the second "rm -rf", in case that doesn't
    +    fix the issue.
    +
         The lack of &&-chaining between the "chmod" and "rm -rf" is
         intentional, if we fail the first "rm -rf", can't chmod, but then
         succeed the second time around that's what we were hoping for. We just
    @@ Commit message
     
         1. dbda967684d (t0004 (unwritable files): simplify error handling,
            2010-09-06)
    -    2. 5a4a088add3 (test-lib: do not remove trash_directory if called with
    -       --debug, 2008-08-21)
    -    3. b586744a864 (test: skip clean-up when running under --immediate
    +    2. b586744a864 (test: skip clean-up when running under --immediate
            mode, 2011-06-27)
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/test-lib.sh ##
    -@@ t/test-lib.sh: test_done () {
    - 			error "Tests passed but trash directory already removed before test cleanup; aborting"
    - 
    - 			cd "$TRASH_DIRECTORY/.." &&
    --			rm -fr "$TRASH_DIRECTORY" || {
    -+			remove_trash_directory "$TRASH_DIRECTORY" || {
    - 				# try again in a bit
    - 				sleep 5;
    --				rm -fr "$TRASH_DIRECTORY"
    -+				remove_trash_directory "$TRASH_DIRECTORY"
    - 			} ||
    - 			error "Tests passed but test cleanup failed; aborting"
    - 		fi
    -@@ t/test-lib.sh: then
    - 	exit 1
    - fi
    +@@ t/test-lib.sh: HOME="$TRASH_DIRECTORY"
    + GNUPGHOME="$HOME/gnupg-home-not-used"
    + export HOME GNUPGHOME USER_HOME
      
    -+# Try really hard to clean up our mess
    ++# "rm -rf" existing trash directory, even if a previous run left it
    ++# with bad permissions.
     +remove_trash_directory() {
     +	dir="$1"
    -+	if ! rm -rf "$dir"
    ++	if ! rm -rf "$dir" 2>/dev/null
     +	then
    -+		say_color info >&3 "Failed to remove trash directory, trying to re-chmod it first..."
    -+		chmod -R u+w "$dir" 2>/dev/null
    ++		chmod -R u+wx "$dir"
     +		rm -rf "$dir"
     +	fi
     +	! test -d "$dir"
     +}
     +
    - # Are we running this test at all?
    - remove_trash=
    - this_test=${0##*/}
    -@@ t/test-lib.sh: GNUPGHOME="$HOME/gnupg-home-not-used"
    - export HOME GNUPGHOME USER_HOME
    - 
      # Test repository
     -rm -fr "$TRASH_DIRECTORY" || {
     +remove_trash_directory "$TRASH_DIRECTORY" || {

 t/test-lib.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index aa1ad8180ed..ff6d3c79362 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1387,8 +1387,20 @@ HOME="$TRASH_DIRECTORY"
 GNUPGHOME="$HOME/gnupg-home-not-used"
 export HOME GNUPGHOME USER_HOME
 
+# "rm -rf" existing trash directory, even if a previous run left it
+# with bad permissions.
+remove_trash_directory() {
+	dir="$1"
+	if ! rm -rf "$dir" 2>/dev/null
+	then
+		chmod -R u+wx "$dir"
+		rm -rf "$dir"
+	fi
+	! test -d "$dir"
+}
+
 # Test repository
-rm -fr "$TRASH_DIRECTORY" || {
+remove_trash_directory "$TRASH_DIRECTORY" || {
 	GIT_EXIT_OK=t
 	echo >&5 "FATAL: Cannot prepare test area"
 	exit 1
-- 
2.33.0.1505.g38ce83107ad

