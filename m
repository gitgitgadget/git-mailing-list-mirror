Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB22C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053F861152
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbhJFKEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbhJFKEa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 06:04:30 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD04EC061767
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 03:02:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v17so7062026wrv.9
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 03:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZaO+6tYsyXr0rPsymK/LfIGmJktU70aUyeLXVLwjuxk=;
        b=j8KZzYC3Bh9rAQSOr4rVcGonVnsH3umzBoPUXwrbt0BL6l7cgwy2tTPhQOgPv7/cdu
         LZnxs4SnQSTpuWvaH368j2H6dNrtbSAdMcFD+ZPEf+z6rh98diJcvKSa54Jy1sCDYhjB
         gDO1Z+7oDtNpLi1cp1Y65r2hbHwcuKRkqYYZfIkpZlPRDEdlMCZA/1cJn8wy/ViCjQtx
         b5bfpIfXI0Nio4EiUXpSiTy4I0T60/ZQ0TLRbInfCSOEs2Ig+0cMuVeEPgOBESulvpOC
         Guaqp0DQpPeqHNqAgQv44RkxC9PS9u0ocvTbjFo8LRYaovRrk5kEE5lhhVo/ACRt25p5
         PAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZaO+6tYsyXr0rPsymK/LfIGmJktU70aUyeLXVLwjuxk=;
        b=x0dBzeeHeuqz0T5q416dgvMO/VP4rpft3pS2Mh9n22k2K3UEdmKPQCwe2Cykxye21N
         KxdcvUAMOGs4jy7NW/ffK5rXIlY7VtMm2NSVQqzbbw3y5NaVgSRhMt3F9ysuCuLjV7Dc
         Z1PERD+IhqXAG9fo/EmMd6yQi+cvFu2ZI8rUvATf53REyvRqKl4I3BSogXkWUIF1dvvB
         Sn4WMWVYlUsQH+uNuCqZy1iCIWZAV+1nyVmqMpm7Jleby5+L6Ee7G4uU534mavRce8sm
         WzE0WmpvPr9+uTr6l7Uke4m9Tp1Dg3bu5Dda5+9JNrGaav7EFu6rrXmbENljNo3PrVE4
         y4NA==
X-Gm-Message-State: AOAM532sNrGgyp/HLXGdX0ZEOArEr5BpUkqbo7Pan04hs64j1ehPXsYN
        F5UyFHWkb60l5STiF8RN5fDZuIO+yOngLg==
X-Google-Smtp-Source: ABdhPJw4wh6Q0pgkOVw/JPa8/nH9AoSDcWhfDfQ7IU3esS1JVxUOIhz087wdlpgInMojZrQ7Gt3HUQ==
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr8828975wma.26.1633514552124;
        Wed, 06 Oct 2021 03:02:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h18sm5515279wmq.23.2021.10.06.03.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 03:02:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/7] tests: fix test-oid-array leak, test in SANITIZE=leak
Date:   Wed,  6 Oct 2021 12:02:22 +0200
Message-Id: <patch-4.7-4aa2a70c67e-20211006T095426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a trivial memory leak present ever since 38d905bf585 (sha1-array:
add test-sha1-array and basic tests, 2014-10-01), now that that's
fixed we can test this under GIT_TEST_PASSING_SANITIZE_LEAK=true.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-oid-array.c | 4 ++++
 t/t0064-oid-array.sh      | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/t/helper/test-oid-array.c b/t/helper/test-oid-array.c
index b16cd0b11b1..d1324d086a2 100644
--- a/t/helper/test-oid-array.c
+++ b/t/helper/test-oid-array.c
@@ -35,5 +35,9 @@ int cmd__oid_array(int argc, const char **argv)
 		else
 			die("unknown command: %s", line.buf);
 	}
+
+	strbuf_release(&line);
+	oid_array_clear(&array);
+
 	return 0;
 }
diff --git a/t/t0064-oid-array.sh b/t/t0064-oid-array.sh
index 2e5438ccdac..88c89e8f48a 100755
--- a/t/t0064-oid-array.sh
+++ b/t/t0064-oid-array.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='basic tests for the oid array implementation'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 echoid () {
-- 
2.33.0.1441.gbbcdb4c3c66

