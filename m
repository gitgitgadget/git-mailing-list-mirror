Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E066DC433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDADC610E7
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 18:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhJTSmZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhJTSmY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 14:42:24 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A5CC06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:40:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v17so48690013wrv.9
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 11:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I57eDR0vh7itp2g+J8ZnlFkiookKOb82IZhHC0cAUf0=;
        b=ONccZcgx1K3Eo5rPsV+FDhNISzzOdghIW3oO5mnyCPz1BnDwoXJpoiLSjZsMtApShl
         Xj3DVEZXpFk9reLXp1pNGsJjco8RfSIRUOSgLmGixoZCfF1At3+U4fWEViDwBYo8PKSx
         a09kKkeDbb6XLRl433wrX3A7CxDfwEtXixpqCPGo9wq8x968bKPjV+ekYfnxiFen+3Qd
         jdptW8a+9YnyJAUhU53MdTH+0wPTyK4eI8nHlEE0LQ0dQnG+znAy4Q6kGGyZxtVLcLD8
         UAo3K87Dsb5tDZ4gW2d/zcG0h4fk11o3m/ASWgcYhaNFIIdaC7sgQcNxc5q8yDQZJmmH
         7zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I57eDR0vh7itp2g+J8ZnlFkiookKOb82IZhHC0cAUf0=;
        b=nqfftIz0VpaFCOa2/EV2oz/cQtZYjUxpMS8wSsp9J64xtCR/gxmKXuLYr8Vr5sy1Ki
         8sWhWi004G5VoqLbiXDmxao8D6uUWsOt6CJiP441KL6/njCGJ3ZdBDBsFVQJOlOqFiVJ
         hwZFXWDhgpTMsMd/M7la/Q8Hf3NyFxI0FMawlrtpWB9EgjMinSaacDrTk/FGHl2gEuee
         AQ4+HBYq0elyHnWt/JzXTh/KF6PupWj66LXKm6ezMXl2k+8Vy2/lsPM7T/P10rRHHD63
         dZ4Z08i9UZnOdqvdZZDdOGBlcOfvJzyrV8TuFQi8aFYTho3T2icLiYLzLUFqJAPQXo5h
         PnHQ==
X-Gm-Message-State: AOAM5331Ez0UBEMGhZb7R2ZMFP8Nxnvu7ujyIMQ1UJNbN8xByQtZ0lJc
        lCkk5p6GAHe7+uh4U5yx8A5ENPUrsvjifA==
X-Google-Smtp-Source: ABdhPJynzEXjEJocOIcwnIzsWrdoAQMy+0eyM6TBQsnF4jJyjJlhT1vSIgB2sOtQG9NpnNUnH1poTA==
X-Received: by 2002:a5d:5703:: with SMTP id a3mr129568wrv.372.1634755207319;
        Wed, 20 Oct 2021 11:40:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d8sm2813835wrv.80.2021.10.20.11.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:40:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/8] generate-cmdlist.sh: run "grep | sort", not "sort | grep"
Date:   Wed, 20 Oct 2021 20:39:56 +0200
Message-Id: <patch-5.8-f01c1fd8088-20211020T183533Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net> <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This doesn't matter for performance, but let's not include the empty
lines in our sorting. This makes the intent of the code clearer.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 generate-cmdlist.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 16043e38476..e517c33710a 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -18,8 +18,8 @@ category_list () {
 	command_list "$1" |
 	cut -c 40- |
 	tr ' ' '\012' |
-	LC_ALL=C sort -u |
-	grep -v '^$'
+	grep -v '^$' |
+	LC_ALL=C sort -u
 }
 
 get_synopsis () {
-- 
2.33.1.1338.g20da966911a

