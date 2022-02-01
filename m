Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C22C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 20:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiBAUxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 15:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiBAUw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 15:52:57 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A035C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 12:52:57 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id f17so34395066wrx.1
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 12:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L2Y5RBSzDVYRBVznvSJy7RuLEypFz2mBTFI9HgnvMaQ=;
        b=kIHhARiuBUNGGgL5RGiyOZemMfaZRc6nUYObXPYPXmGXtc4O03RDG5VvZFi3gLQamz
         YT6JVMABlq3oB4TLzYvjE1U7Cwjy42Sjq4VUAgGoEBRtxgWfdwjX5gez0iEXtEgGWfIw
         YcNr7RsWy++qq/8uHEnLaFvmX/S9kD4OYyYhgRwUTsd/KCMRS3r3J91G9RapcNvjqE3t
         mpOCxrIpC2SdkbOPY6/4AP57M1D91d6BLc1fRw788gg4YXI67hnirK43s+fyVM8MJOTe
         3bl6SRc2eq4OrUQ3VEwqBpQg2POwkUb3gw99XRF7xqn9s3FB3XF5L4iStlb1kJ9FWFEn
         O8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L2Y5RBSzDVYRBVznvSJy7RuLEypFz2mBTFI9HgnvMaQ=;
        b=peo6u+6ziLMUJLLROH+k994aDuqByYyQxiySmdreBboYnGLdRGR1ZzRBxDB/Q2rmWw
         VYBnVSOEZKwYnUVxrNXERPsij1WWhub75bDTF8ZkeRTJc8PAoWtYVania2lUOrjabFcK
         r+6rzYeVug1Ykc0eW5shg9dh1jwdQEYYNnODGQ4nCm0OhOXwxStPIEfj7uxwrnojjh3l
         c/KGr5uhz/3HV8V6yVKH+EKHmQhtiG4xVRVAtZ7iy8hlCptASVMwslQcMYl4fIMeiYnk
         V6cEj/Cphh4fAd430FF7QJxQoI2jZrpLJxtlKa6FLgxLAbKKq7Jth0Y/TgAgobSjDaqf
         IOXw==
X-Gm-Message-State: AOAM531+Va1YUlgYPJIfIVVvbBF8odDs6F2Esa5vuIv1DNt923ICYUvS
        cg/cPqNMzkVf4TRqNk26haUF2C/6ZJmvmA==
X-Google-Smtp-Source: ABdhPJzXp41bOmV0zI4RstsPu4zS/GVkDrZhVmbKM4PAJuGbxqxq4nybMDtSJMYcDZWgpiMoW7iROg==
X-Received: by 2002:adf:e98c:: with SMTP id h12mr22653671wrm.427.1643748775329;
        Tue, 01 Feb 2022 12:52:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u7sm2867499wmc.11.2022.02.01.12.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 12:52:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] perl Git.pm: don't ignore signalled failure in _cmd_close()
Date:   Tue,  1 Feb 2022 21:52:52 +0100
Message-Id: <patch-1.1-86353c3b366-20220201T205218Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.913.g12b4baa2536
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix misbehavior in Git.pm that dates back to the very first version of
the library in git.git added in b1edc53d062 (Introduce Git.pm (v4),
2006-06-24). When we fail to execute a command we shouldn't ignore all
signals, those can happen e.g. if abort() is called, or if the command
segfaults.

Because of this we'd consider e.g. a command that died due to LSAN
exiting with abort() successful, as is the case with the tests listed
as running successfully with SANITIZE=leak in 9081a421a6d (checkout:
fix "branch info" memory leaks, 2021-11-16). We did run them
successfully, but only because we ignored these errors.

This was then made worse by the use of "abort_on_error=1" for LSAN
added in 85b81b35ff9 (test-lib: set LSAN_OPTIONS to abort by default,
2017-09-05). Doing that makes sense, but without providing that option
we'd have a "$? >> 8" of "23" on failure, with abort_on_error=1 we'll
get "0".

All of our tests pass even without the SIGPIPE exception being added
here, but as the code appears to have been trying to ignore it let's
keep ignoring it for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 perl/Git.pm                                 | 21 +++++++++++++++++++--
 t/t9102-git-svn-deep-rmdir.sh               |  1 -
 t/t9123-git-svn-rebuild-with-rewriteroot.sh |  1 -
 t/t9128-git-svn-cmd-branch.sh               |  1 -
 t/t9167-git-svn-cmd-branch-subproject.sh    |  1 -
 5 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 090a7df63fc..080cdc2a21d 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1686,6 +1686,16 @@ sub _setup_git_cmd_env {
 # by searching for it at proper places.
 sub _execv_git_cmd { exec('git', @_); }
 
+sub _is_sig {
+	my ($v, $n) = @_;
+
+	# We are avoiding a "use POSIX qw(SIGPIPE SIGABRT)" in the hot
+	# Git.pm codepath.
+	require POSIX;
+	no strict 'refs';
+	$v == *{"POSIX::$n"}->();
+}
+
 # Close pipe to a subprocess.
 sub _cmd_close {
 	my $ctx = shift @_;
@@ -1698,9 +1708,16 @@ sub _cmd_close {
 		} elsif ($? >> 8) {
 			# The caller should pepper this.
 			throw Git::Error::Command($ctx, $? >> 8);
+		} elsif ($? & 127 && _is_sig($? & 127, "SIGPIPE")) {
+			# we might e.g. closed a live stream; the command
+			# dying of SIGPIPE would drive us here.
+		} elsif ($? & 127 && _is_sig($? & 127, "SIGABRT")) {
+			die sprintf('BUG?: got SIGABRT ($? = %d, $? & 127 = %d) when closing pipe',
+				    $?, $? & 127);
+		} elsif ($? & 127) {
+			die sprintf('got signal ($? = %d, $? & 127 = %d) when closing pipe',
+				    $?, $? & 127);
 		}
-		# else we might e.g. closed a live stream; the command
-		# dying of SIGPIPE would drive us here.
 	}
 }
 
diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir.sh
index 7b2049caa0c..946ef85eb98 100755
--- a/t/t9102-git-svn-deep-rmdir.sh
+++ b/t/t9102-git-svn-deep-rmdir.sh
@@ -1,7 +1,6 @@
 #!/bin/sh
 test_description='git svn rmdir'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'initialize repo' '
diff --git a/t/t9123-git-svn-rebuild-with-rewriteroot.sh b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
index 3320b1f39cf..ead404589eb 100755
--- a/t/t9123-git-svn-rebuild-with-rewriteroot.sh
+++ b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
@@ -5,7 +5,6 @@
 
 test_description='git svn respects rewriteRoot during rebuild'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 mkdir import
diff --git a/t/t9128-git-svn-cmd-branch.sh b/t/t9128-git-svn-cmd-branch.sh
index 9871f5abc93..783e3ba0c53 100755
--- a/t/t9128-git-svn-cmd-branch.sh
+++ b/t/t9128-git-svn-cmd-branch.sh
@@ -5,7 +5,6 @@
 
 test_description='git svn partial-rebuild tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'initialize svnrepo' '
diff --git a/t/t9167-git-svn-cmd-branch-subproject.sh b/t/t9167-git-svn-cmd-branch-subproject.sh
index d9fd111c105..d8128430a8d 100755
--- a/t/t9167-git-svn-cmd-branch-subproject.sh
+++ b/t/t9167-git-svn-cmd-branch-subproject.sh
@@ -5,7 +5,6 @@
 
 test_description='git svn branch for subproject clones'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'initialize svnrepo' '
-- 
2.35.0.913.g12b4baa2536

