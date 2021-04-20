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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC19C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04206613C8
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhDTMaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhDTMaN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:30:13 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6502C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:29:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id j7so7926050eds.8
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rSnJ5K6t9GRhQKzFOFxYtGUEG/j2Gs2sjWuKeNM4gwg=;
        b=TZLqlQVDAs8Xv1bBgkJ+ryivIF1Cfwgh/goCWzn4ETN0WeOrlTRG/3EDS0VagM5v1a
         YFwpoAJ+9QVUySCG2zoAhALyEPF5r683Fs0GuAE1G4nZ7C/d82qKPyFPxuqzdWwFMbhP
         VtVhuh86UalSUc/Z+KYVvJZe/fuDVH1waaX1ZOrPKxeQE5aZa0vokoxPoooR21fgPW+d
         ph2IuQv0FESCyRwouj1x0YsFJlCjwgYhWaT7kNMMtBlGlt8j7W48gnyu4e53AFfIk66h
         pszT8yx3hTJ4nculTdpYvrzNedkCkkzuPvcuseBGcPkbqn2To5WUwaxLgVtJkqja69CA
         WhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rSnJ5K6t9GRhQKzFOFxYtGUEG/j2Gs2sjWuKeNM4gwg=;
        b=a5Hi1iKKaQLHg8Kb9wEEDCrRFyla5JLYIKehGS4XYRtOT95eT9sOelzL3k5NpoujwX
         djb65XopzH0RZ/tKGRsS0CtXl6O5fYtymscVz0FDq/LT2LyzlFLY03OMg8xScdzT8T2D
         Bzp8S0c80HPlftiZwYSBzz99aFIWtiPUiOXOlGM2RC3qPz24H58bWiuFCa+GoptPFBB+
         MLod81HvzkIjgMbOSYb+qFrL8qTjMbG4G7o0Aup35kydM5ntihmZjEDmdGp9zsLAFre3
         8X1JEaZ2NNpdmifQmvf61vBCcYA449X+P8M1FOoOSHPFhXWDiaETztcDdQs9Es+S7iGe
         g8/g==
X-Gm-Message-State: AOAM533xkQfIkTQA7EZA3jKmlJzQoCLbcIqwBO6EnrNIufZwDDAQpweN
        jHyVSjoiqHflGxFJUncNdSlM6NEw2co8ew==
X-Google-Smtp-Source: ABdhPJzTex474+wj1B24BM/i2ZMoW7TLxdEPlXbO0UCN/wmm+E+QHQi7me5AtPDs/78PdTxie3buxQ==
X-Received: by 2002:a05:6402:350f:: with SMTP id b15mr31758296edd.6.1618921780431;
        Tue, 20 Apr 2021 05:29:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f1sm10898031edz.60.2021.04.20.05.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:29:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] test-lib-functions: remove last two parameter count assertions
Date:   Tue, 20 Apr 2021 14:29:30 +0200
Message-Id: <patch-3.3-8fd51861b5-20210420T122706Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.gf6bad1b9ba1
In-Reply-To: <cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com> <cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a couple of parameter count assertions where, unlike the
preceding commit's migration to 'test -$x "$@"', we'll now silently do
the "wrong" thing if given too many parameters. The benefit is less
verbose trace output, as noted in the preceding commit.

In the case of "test_file_size", the "test-tool" we're invoking is
happy to accept N parameters (it'll print out all N sizes). Let's just
use "$@" in that case anyway. There's only a few callers, and
eventually those should probably be moved to use the test-tool
directly.

That only leaves test_line_count, I suppose I could leave that one
alone, but since it's the only common function left that does this
assertion let's remove it for the brevity of the -x output and
consistency with other functions.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index f8f5bf9de1..e128b341ff 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -827,10 +827,7 @@ test_path_is_missing () {
 # output through when the number of lines is wrong.
 
 test_line_count () {
-	if test $# != 3
-	then
-		BUG "not 3 parameters to test_line_count"
-	elif ! test $(wc -l <"$3") "$1" "$2"
+	if ! test $(wc -l <"$3") "$1" "$2"
 	then
 		echo "test_line_count: line count for $3 !$1 $2"
 		cat "$3"
@@ -839,8 +836,7 @@ test_line_count () {
 }
 
 test_file_size () {
-	test "$#" -ne 1 && BUG "1 param"
-	test-tool path-utils file-size "$1"
+	test-tool path-utils file-size "$@"
 }
 
 # Returns success if a comma separated string of keywords ($1) contains a
-- 
2.31.1.723.gf6bad1b9ba1

