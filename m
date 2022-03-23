Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B15C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 03:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241712AbiCWDt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 23:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241699AbiCWDth (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 23:49:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DA463CB
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 20:48:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w4so296974wrg.12
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 20:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pwJGEcR/LmoT+2dbqkAMVTDVyOzTw+4s3NCKE1qfXmY=;
        b=mgqWddfHFh+V8iRNOq6WFoNsmaiJkgFAhE8ScC3sQ13UoLpVgeydqVnSkSx+6tichM
         zr2KfdAMRKbp7Hh5LGZBBzLrRMRZ03n31Cm0b7seUJ8Mha4wRTeSc/i8Mu522FygLCHj
         SOI7B0SE+9lVmVRvXLHADt88pbW3NN7SH3kE/NggzAsbVRsKixiZBC+ccU7vwUm75X2i
         arA5VQLV4jFEIwAFyNCyEImD+9wRewnwrwjeFomltvHPjG9V7SIcXUzIiz2e396sRO91
         Ct1prZVOAdeoI/NoNttcab55R0qEBUkowU7EYhiYQCD23/VVmTT8fUIY9RU7NV4viXMy
         Vw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pwJGEcR/LmoT+2dbqkAMVTDVyOzTw+4s3NCKE1qfXmY=;
        b=lkCGaWd2QpCYmHJHY0JRrROFKhqwPpZkmbCSx1gz0KtvDRJncXSnJgOCjgZWTdIbpz
         90MnKCg180j3G+VZnMlTYVaXXCu8/GqVjRcbvCWFRlrCJKNZXLwwf7yQjzjkEYuFP3J0
         bqwwQLgKVKGEeHVgz8i63I5IyVc7s2Aq3QXqDBklPa77nGRWL9aEpf5PnklMM8oEUTbr
         mKiG/r1jCq1ZE7lRug9IacJ81Tmu612EnkrhTdXZovv/PDKrSoL6pJTC59bIfeQspZ0b
         XYM7ErotkUWhZc5SlYxl9EE/s3P5HLg2kwbdSS9or46pomflQ+4pY2BnU+52nsFDrrsZ
         Qxow==
X-Gm-Message-State: AOAM532O+ptixQo8IlD5/mly3QoU1xmqFGggeSbTwWgWkgDI7u3Sm6N2
        Mr0+EHpG0+pVUlB9YNaZoMHTCMncSrbheA==
X-Google-Smtp-Source: ABdhPJyNJv3HgdyIPjhi2sCIY9Mw8Xnm5cYPvIMTrWaIDjqZ7657LWATMK/D7lJnR5571kFN4NBNcA==
X-Received: by 2002:a05:6000:2cd:b0:204:1bf4:e4f8 with SMTP id o13-20020a05600002cd00b002041bf4e4f8mr8513819wry.682.1648007285135;
        Tue, 22 Mar 2022 20:48:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c511000b0038c6d836935sm3028830wms.16.2022.03.22.20.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 20:48:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 6/7] update-index: rename "buf" to "line"
Date:   Wed, 23 Mar 2022 04:47:35 +0100
Message-Id: <RFC-patch-6.7-4fad333e9a1-20220323T033928Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1428.g1c1a0152d61
In-Reply-To: <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
References: <CANQDOde2OG8fVSM1hQE3FBmzWy5FkgQCWAUYhFztB8UGFyJELg@mail.gmail.com> <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This variable renaming makes a subsequent more meaningful change
smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/update-index.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 1884124224c..af02ff39756 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1194,15 +1194,15 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	}
 
 	if (read_from_stdin) {
-		struct strbuf buf = STRBUF_INIT;
+		struct strbuf line = STRBUF_INIT;
 		struct strbuf unquoted = STRBUF_INIT;
 
 		setup_work_tree();
-		while (getline_fn(&buf, stdin) != EOF)
-			line_from_stdin(&buf, &unquoted, prefix, prefix_length,
+		while (getline_fn(&line, stdin) != EOF)
+			line_from_stdin(&line, &unquoted, prefix, prefix_length,
 					nul_term_line, set_executable_bit, 0);
 		strbuf_release(&unquoted);
-		strbuf_release(&buf);
+		strbuf_release(&line);
 	}
 
 	if (split_index > 0) {
-- 
2.35.1.1428.g1c1a0152d61

