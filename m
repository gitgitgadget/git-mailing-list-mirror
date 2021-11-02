Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ABAC433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05977610E5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhKBO1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 10:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhKBO1i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 10:27:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDAEC061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 07:25:03 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so2225847wmd.1
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7t/iz3uArw75hSJ48dkYXu6tkOpANhyAiCrlLZH6q9k=;
        b=m3ZA+r2E7dHzOHuRcD0Az/QDS9rpg1WZV7L7hnbf0l10rlFYQkoOedRgg0y4LTrXbC
         BAFXogqsonRauB6jFEKu8gTigopFn7F/oDTSSX0j/Z9ndcU1/2/hs9MUYtobHSo730Aj
         7D8GR61ZEGY8XePcOT/juW6nDxo+NoF79TGktIrRSubjKgGcXXsgTtPxBsi0KqNK3xf0
         6lBbzY9SPS/BCvwNLBIVoj6JL5exNlGbRdCTZDiqDl0OwsFfdwkXUIPKl4jnSr0mxe7F
         WqmebfBMbm7vKwyhyn91VTkQFhlY34dame9O1mcZaYsROzQYs9EK072TAp6HX66qKPcI
         1N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7t/iz3uArw75hSJ48dkYXu6tkOpANhyAiCrlLZH6q9k=;
        b=hwp0ZUuFByJ9VTv3gBc1nEZqKB2L6vZeDOj/D/5B8UgHezI+QwKhJUG7TfQ0h7m81f
         9PSGkXm7nncftD6Df9nLq9nX9oiH3Iqr0p316UFHP5GpFER57nHIT/o+cfUq/Ccm4m7R
         wgSlpz7U4XWMK1qQpdcmFerhs5i8OIHWohZfoIzep4Ad/eSkBWVy983Gg68r7PuuEzWd
         IOzyXB9lzDHSQBsYgK9C2VBGevdw1QhhyZ77CdtNn8qnn0rTG/Vz0Wo+frwo239La2Eg
         pm/NyKb/zKi1jQ31h+m7T5rAM7tTzampdS9+dxINOg2H322OtiTj7LdqEf1nfq8NUZJy
         hBBA==
X-Gm-Message-State: AOAM533R0QKZFzoRd+BQo+zXHq3t6WPDe+jS0e7b6vYXzAggrCZJYGMr
        bDZGX+SbSc416U6bvQMaLfL76yeokdzAbg==
X-Google-Smtp-Source: ABdhPJy3qfU4FfbUwIPvEvb4zKrllO3BE71ykbGK4FCUXT/gsrtIyNUq3lcBV+MlaIVBR1gkoz5IIA==
X-Received: by 2002:a1c:2057:: with SMTP id g84mr7266485wmg.137.1635863102078;
        Tue, 02 Nov 2021 07:25:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j12sm2266711wmq.37.2021.11.02.07.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 07:25:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] maintenance tests: fix systemd v2.34.0-rc* test regression
Date:   Tue,  2 Nov 2021 15:24:59 +0100
Message-Id: <patch-1.1-90172a8ddcc-20211102T142351Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <211026.8635oo11jk.gmgdl@evledraar.gmail.com>
References: <211026.8635oo11jk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix tests added in b681b191f92 (maintenance: add support for systemd
timers on Linux, 2021-09-04) to run successfully no systems where
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
emits no note syntax warnings and errors. We need to filter out
"Failed to load", which would be emitted e.g. on the
gcc135.fsffrance.org test box[1].

We also need to pipe this output to FD's 5 & 6, to avoid mixing up the
trace output with our own output under "-x".

1. https://lore.kernel.org/git/211026.8635oo11jk.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Junio: I think you'll want this in v2.34.0 per the report in
<211026.8635oo11jk.gmgdl@evledraar.gmail.com>.

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
2.33.1.1570.g069344fdd45

