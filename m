Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F9FC433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 03:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F8A610CF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 03:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhKJDzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 22:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhKJDzB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 22:55:01 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5D8C061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 19:52:14 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u18so1523280wrg.5
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 19:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJvK8x53WK5s0YILHoDYX4AoVucefiHxXBFPQSTn6VI=;
        b=A/n0ni+givAlICISC+3C+xnOJ/GmggIeLpjP7DnVwblbtPQldYX4gaybEN7RjIYPhS
         uc2jSXJN5mFyBRfaU6HH+0fYYsXhTKNJ85iQQvLygYRRH85fBTRz9Y3zHsaQFbxx15Lf
         Ty9MJNBPBz0xkFIUkeHhwBwGV6ITh3O6hAoXvZ17p5UG88NV/pO8GB3Qs4SMtxF8YbdD
         huM/VBLYjtef8B6lGhK7aPOxcT3k6FIX6v8n1fUWaveo2yLyEPkLkyL8yOKf0DRwwzZT
         XMxeCn+/TsGI+xKu6eCeXUYUl+4P7qf9t6yr59FnV+MkESA3h7AYq0Emla3hJPfZPVyV
         4HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJvK8x53WK5s0YILHoDYX4AoVucefiHxXBFPQSTn6VI=;
        b=C2ji7AvtUc7jKA23MIsA8nTCPdUKkOI+ZaD/W8wsfb+Qq+QRxeAMAsW1xlUk0c4Pam
         IjvSIePk57VVigbEyRYb+Dju2XRlvTiZqTqisEp9etjvik6dyQO2HPEwtTbfz+n2++Ux
         PRvC3twscLEC9uVG/o4EHQlP+B0YCYP1mGQ/5XPQOHUCYkrSpRS5Z37VQL2VSYfkgeTj
         YBSQ/sBFE+nir7w4RPmREgsM4Tn5XkjjLtn9W8MhfAU/UEONTYQKYut5sG2I7t2wKCci
         JTGGIClgQ7Xx/u9DVDljYNxW8HEHEemLBpK7B6aOzsf+ajZu4Qmb1iXr699S6mRFvJAu
         DspQ==
X-Gm-Message-State: AOAM531o2goDy8gGhLq2Yc8sTJq2WonF2hkKulfO0zgYIm/OWEPx57zl
        zBwtBUPkL5CNX8Znm1pqC1K9K3wVgrUX9A==
X-Google-Smtp-Source: ABdhPJz8q0cDLPSRVJ/ojStOhNS/uBz2TbBk812+ZG8rD8eEWENvup/g1XK6323u9xAWNhzMsrjWog==
X-Received: by 2002:adf:e482:: with SMTP id i2mr15674194wrm.284.1636516332787;
        Tue, 09 Nov 2021 19:52:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 4sm29513104wrz.90.2021.11.09.19.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 19:52:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] maintenance tests: fix systemd v2.34.0-rc* test regression
Date:   Wed, 10 Nov 2021 04:52:10 +0100
Message-Id: <patch-v2-1.1-44f0cafa16e-20211110T035103Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.791.gdbfcf909579
In-Reply-To: <patch-1.1-90172a8ddcc-20211102T142351Z-avarab@gmail.com>
References: <patch-1.1-90172a8ddcc-20211102T142351Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix tests added in b681b191f92 (maintenance: add support for systemd
timers on Linux, 2021-09-04) to run successfully on systems where
systemd-analyze is installed, but on which there's a discrepancy
between a FILE argument of "/lib/systemd/system/basic.target" and
"systemd/user/git-maintenance@.service" succeeding.

There was an attempt to work around previous breakage in these tests
in 670e5973992 (maintenance: fix test t7900-maintenance.sh,
2021-09-27), as noted in my [1] that commit is wrong about its
assumption that we can use "/lib/systemd/system/basic.target" as a
canary.argument.

To fix this let's adjust this test to test what it really should be
testing: If we've got systemd-analyze reporting anything useful, we
should use it to check the syntax of our just-generated
"systemd/user/git-maintenance@.service" file.

Even on systems where this previously succeeded we weren't effectively
doing that, because "systemd-analyze" will pass various syntax errors
by and exit with a status code of 0, e.g. if the "[Unit]" section is
replaced with a nonsensical "[HlaghUnfUnf]" section.

To do that ignore whatever exit code we get from "systemd-analyze
verify", and filter its stderr output to extract the sorts of lines it
emits on note syntax warnings and errors. We need to filter out
"Failed to load", which would be emitted e.g. on the
gcc135.fsffrance.org test box[1].

We also need to pipe this output to FD's 5 & 6, to avoid mixing up the
trace output with our own output under "-x".

1. https://lore.kernel.org/git/211026.8635oo11jk.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This test is still broken in rc2, this patch fixes it. The only update
is a commit message grammar fix pointed out by Eric Sunshine, thanks!

Range-diff against v1:
1:  90172a8ddcc ! 1:  44f0cafa16e maintenance tests: fix systemd v2.34.0-rc* test regression
    @@ Commit message
         maintenance tests: fix systemd v2.34.0-rc* test regression
     
         Fix tests added in b681b191f92 (maintenance: add support for systemd
    -    timers on Linux, 2021-09-04) to run successfully no systems where
    +    timers on Linux, 2021-09-04) to run successfully on systems where
         systemd-analyze is installed, but on which there's a discrepancy
         between a FILE argument of "/lib/systemd/system/basic.target" and
         "systemd/user/git-maintenance@.service" succeeding.
    @@ Commit message
     
         To do that ignore whatever exit code we get from "systemd-analyze
         verify", and filter its stderr output to extract the sorts of lines it
    -    emits no note syntax warnings and errors. We need to filter out
    +    emits on note syntax warnings and errors. We need to filter out
         "Failed to load", which would be emitted e.g. on the
         gcc135.fsffrance.org test box[1].
     

 t/t7900-maintenance.sh | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 74aa6384755..5fe2ea03c1d 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -20,15 +20,16 @@ test_xmllint () {
 	fi
 }
 
-test_lazy_prereq SYSTEMD_ANALYZE '
-	systemd-analyze verify /lib/systemd/system/basic.target
-'
-
 test_systemd_analyze_verify () {
-	if test_have_prereq SYSTEMD_ANALYZE
-	then
-		systemd-analyze verify "$@"
-	fi
+	# Ignoring any errors from systemd-analyze is intentional
+	systemd-analyze verify "$@" >systemd.out 2>systemd.err;
+
+	cat systemd.out >&5 &&
+	sed -n \
+		-e '/^Failed to load/d' \
+		-e '/git-maintenance@i*\.service:/x' \
+		<systemd.err >&6 &&
+	rm systemd.out systemd.err
 }
 
 test_expect_success 'help text' '
@@ -697,7 +698,11 @@ test_expect_success 'start and stop Linux/systemd maintenance' '
 	# start registers the repo
 	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
 
-	test_systemd_analyze_verify "systemd/user/git-maintenance@.service" &&
+	# If we have a systemd-analyze on the system we can verify the
+	# generated file.
+	test_systemd_analyze_verify "systemd/user/git-maintenance@.service" 5>out 6>err &&
+	test_must_be_empty out &&
+	test_must_be_empty err &&
 
 	printf -- "--user enable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
 	test_cmp expect args &&
-- 
2.34.0.rc2.791.gdbfcf909579

