Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD36C19F2D
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 02:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiHGCt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 22:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiHGCtu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 22:49:50 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580C3DFE8
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 19:49:49 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id j66-20020a9d17c8000000b00636b0377a8cso3445801otj.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 19:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=fCHO+YYKyK7p8kSg0ydH+bvhfPeKz0frpk01Zxo95+4=;
        b=BL9uVntPq4dzwz8zTvWZ04zU+PynuMJIxe+JhUSIoMZE2YM+ssOZEoNpzec3YfQaS3
         ibw7k1+uC2zXS1+M4Jq+ALRpgUNEQbLxOeOhLKqZ4P32w8y4tsqtYX34Ga8bUJGNpFAN
         E0o5fV4T+qB/PN816cYbj0xG1dFNua2iexOSgqTCqJd+ZxzqFmbYPDQLfBE7s3gYnoYn
         H5gBjGf5A8v1ds852IYU4hpgV5CnW6PkOVn9ZuBS3h3DbrfFoL6DNq3xaENZQnEEA5/r
         bQnCvD/6YiUjuV3T36VXBE2asIvty6A7LC491z3HVIxcWyD9yYR+XUmwxwncV0h96j8I
         Ck6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fCHO+YYKyK7p8kSg0ydH+bvhfPeKz0frpk01Zxo95+4=;
        b=uJii5YLv0GCI8H03bCs0g71aLsS9P7Y4Zqe5BrioP99LjGmIuTeWQVDWEZv56SnHL8
         sQQQZrd9aUttRpxe8KZmswpfNNKKxOAtCRP4JQU8HksrD4vI6ygY1rrA3tc+xJl9oRsv
         G5vJ+WLyAUNXc7rVbYC6yd5ET+qhEDY52swEGGhN175RVQ3NeZbenyAHjVEiVZnL/idk
         HOnJvf55qGeTuQuaOxAhpK4G8LJ5Cuh2OoWTNMFR1IW/eGevMC5t5xv4oeekM+PI7Vi2
         L5siG6H4oCYH0+CqslEquVnft/X6mmVr9gM5l9bb8fKV00grzc141EYGFRs/XMlKDG9B
         zHrg==
X-Gm-Message-State: ACgBeo17Wdg+NMq0m7SKcTEhi6Ap2iIjdfyDTIBZLKyx9DUehCl039+H
        4El7inzjviqV/iuu3LkVKU6+Y1gFRWE=
X-Google-Smtp-Source: AA6agR7bdZJRXNan+TwShmGgBTKD7HqI0hcfrF4jq0qvnHR93wQR3dy2qpKpl9AWXuN8gemGnTJD4Q==
X-Received: by 2002:a9d:6e84:0:b0:61c:af4f:7fa2 with SMTP id a4-20020a9d6e84000000b0061caf4f7fa2mr5132481otr.314.1659840588448;
        Sat, 06 Aug 2022 19:49:48 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:afaf:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id 9-20020a9d0009000000b0061cd208fadesm1485306ota.71.2022.08.06.19.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 19:49:48 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/9] mergetools: vimdiff: make vimdiff3 actually work
Date:   Sat,  6 Aug 2022 21:49:36 -0500
Message-Id: <20220807024941.222018-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1.378.g3f95da6bac
In-Reply-To: <20220807024941.222018-1-felipe.contreras@gmail.com>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When vimdiff3 was added in 7c147b77d3 (mergetools: add vimdiff3 mode,
2014-04-20), the description made clear the intention:

    It's similar to the default, except that the other windows are
    hidden.  This ensures that removed/added colors are still visible on
    the main merge window, but the other windows not visible.

However, in 0041797449 (vimdiff: new implementation with layout support,
2022-03-30) this was broken by generating a command that never creates
windows, and therefore vim never shows the diff.

In order to show the diff, the windows need to be created first, and
then when they are hidden the diff remains (if hidenoff isn't set).

The layout support implementation broke the whole purpose of vimdiff3,
and simply shows MERGED, which is no different from simply opening the
file with vim.

Setting the `hidden` option makes it work as intended.

Suggested-by: Fernando Ramos <greenfoo@u92.eu>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 103729b6a6..20c61b040b 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -325,7 +325,7 @@ gen_cmd () {
 	if ! echo "$LAYOUT" | grep ",\|/" >/dev/null
 	then
 		buf=$(get_buf "$LAYOUT")
-		FINAL_CMD="-c \"echo | ${buf}b | bufdo diffthis\" -c \"tabfirst\""
+		FINAL_CMD="-c \"echo | set hidden | ${buf}b | bufdo diffthis\" -c \"tabfirst\""
 		return
 	fi
 
@@ -560,7 +560,7 @@ run_unit_tests () {
 	EXPECTED_CMD_01="-c \"echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_02="-c \"echo | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_03="-c \"echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_04="-c \"echo | 4b | bufdo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_04="-c \"echo | set hidden | 4b | bufdo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_05="-c \"echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_06="-c \"echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
 	EXPECTED_CMD_07="-c \"echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-- 
2.37.1.378.g3f95da6bac

