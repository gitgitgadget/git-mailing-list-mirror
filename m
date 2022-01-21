Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBE5C433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 10:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379984AbiAUKVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 05:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379982AbiAUKVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 05:21:16 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BE4C06173F
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 02:21:16 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id v74so5216916pfc.1
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 02:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w36VNoOx6Fg9COEBCsrPLGgWqk/JZDfRGtdHi6ZY3t4=;
        b=h2AScE0HD6+zuYdfAm/auPvSr3yJknDM2BI5fH65/n+NiLK/Dwa206uj48nQGHq6nA
         ejNpLqwVmSoXxHJjXGB/fxkoBAA8ie3NOZuRQJWXvrgt4TAeCm6dojUe3XIgdRaR769h
         J5PON771UuQ4Yt2vCJr+gGzG9woj4oyxLw2Cc6tm9BOPfGlcD1aqU1/M4dNu7ORGa+od
         5toLuXxm/TeTY6pdDdagMc9NezS1nr78p/U3GRMwAL8W++E8dniLGCquloiKqqR8BAqU
         ZJTTRQ49Y9ZuMt8bdq7nj17DT+IDs2onKi+gn/lNdgXY1eleCTcubSPn/E+ax576mk5y
         nodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w36VNoOx6Fg9COEBCsrPLGgWqk/JZDfRGtdHi6ZY3t4=;
        b=Vk2tMTk3v+1uMjD0CVqGQ1dgD6+vqPLZvwL2HIB3HIovIQfDRr4uDcaMMZqVienc3h
         P85/OWId+JqMVI5Tddqxu0EQmxMGL657ogB1VHOGymrYbYjkN9NM1Y9gZfZxJhPL4Eok
         kRGhZxKQt8CgZQ5WB6SPmhSR5SnsvaITCFwFl5TO+SwqQeE+puJ25Q+QiKPemsPEvPyP
         N2h36ZB7bKkIZ3Rc99/UNxykmIGnSxeMNasdL2IUxEr1K5ZMuTCJ5j9ZnkslKkOnQfmZ
         QopxIvyfSFRvyrNEn/mzkX0F/pUteJC28FOlIUS+yQsr2hvjRhD5gqsJUwvpMCPhb0uO
         SgMQ==
X-Gm-Message-State: AOAM5321BQreA6b+Z9L2I5rnUsPi1sGIhwuTXyEyCTFEJWvtQwnIkiOl
        ++kNplrTKUlOA3+i4vGXankGgPMHKkg=
X-Google-Smtp-Source: ABdhPJz2bZlgurx0KoZWOxV1HekRzQzPzsFhs1yXFyaZ13bcrVUXcV5O5PRg29tXtFgPRLdTZhSiQQ==
X-Received: by 2002:a63:7d0e:: with SMTP id y14mr2473175pgc.356.1642760476092;
        Fri, 21 Jan 2022 02:21:16 -0800 (PST)
Received: from ffyuanda.localdomain ([112.195.146.215])
        by smtp.gmail.com with ESMTPSA id t17sm6750168pfg.207.2022.01.21.02.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 02:21:15 -0800 (PST)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [GSoC] [PATCH 1/1] t0001: replace "test [-d|-f]" with test_path_is_* functions
Date:   Fri, 21 Jan 2022 18:21:09 +0800
Message-Id: <20220121102109.433457-2-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121102109.433457-1-shaoxuan.yuan02@gmail.com>
References: <20220121102109.433457-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 t/t0001-init.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 3235ab4d53..c72a28d3a5 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -6,7 +6,7 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_config () {
-	if test -d "$1" && test -f "$1/config" && test -d "$1/refs"
+	if test_path_is_dir "$1" && test_path_is_file "$1/config" && test_path_is_dir "$1/refs"
 	then
 		: happy
 	else
-- 
2.25.1

