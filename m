Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09C7420373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753855AbdCMVnz (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:43:55 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36490 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753538AbdCMVnv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:43:51 -0400
Received: by mail-pg0-f41.google.com with SMTP id g2so53435116pge.3
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 14:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zVtiPlfz2PYr108JLVUFCeMJc96vEyF5l/CuVwngjSs=;
        b=odAaANTn2BQMewhChpYrkCAu0Fo95JMZW9DK3JSif9jFz4bSde5JVJ2HSRp3e65pdX
         yqrPxx2k/DL6Nvv8kYXIigzRG6YXSboZ0eam1siyeTFndhgVf9KABmoQw4wP9UfiicVk
         xWPICUbHZC7XRcKA0oVm4MrqBppi8CuHZlh/Hj6jzHoZ+hN7QEk+oD0xDDnr3a4k8HOs
         drhemIIlFcwqP+vPd3z+mgfFIy+43uooBWfWbh9LIa4G9pW+sB/M/81QVmSurxsXm8yQ
         tAHrfNu1WnUvShBJvyFBdlf8sJjh1kaQMXx02fv3QwQ9Gmj0n8ru+fu8DzyVMEAsYoUn
         fyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zVtiPlfz2PYr108JLVUFCeMJc96vEyF5l/CuVwngjSs=;
        b=Pd8pqEl4VGr2WjZv9fNRGcvJgZezxNA+1O94OSxEYPucYeuipVNi2Y+ApLQgM2vSZi
         t5Dz9K7wpWhySX7ncl0RAHAjLY/z38geHtbbd0INzkg930oTT9qI/rKzH+5WzQfgCg9c
         GVKZIT2rkPilTJQuW42E07GInLfkkIZdkRioWcfd2hzcxWHrdt6xklw+LDg/hs6l40E3
         5alkmwdEqFk+uB50J04f5W49bDEzyZ/xXZjrvWlzebNj+Clagt4Ah4gFhDH0z897n1V6
         yZjhp1PMT5n3gd3n02GnoUvNBvnuyCc750Dr0Y5zNY4mZXWPwFRsuZjU8FbTxG4u73bm
         E/8g==
X-Gm-Message-State: AMke39mQkOFQb0i1O9aVSGfU184MRXPFLApII6GLtgKHR2mLOhddDJRc2rmzI7OWHVj98/Ey
X-Received: by 10.98.220.65 with SMTP id t62mr41214588pfg.0.1489441430037;
        Mon, 13 Mar 2017 14:43:50 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm34525937pgj.59.2017.03.13.14.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 14:43:48 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v3 03/10] submodule sync: use submodule--helper is-active
Date:   Mon, 13 Mar 2017 14:43:34 -0700
Message-Id: <20170313214341.172676-4-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170313214341.172676-1-bmwill@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ab233712d..e2d08595f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1111,7 +1111,7 @@ cmd_sync()
 			;;
 		esac
 
-		if git config "submodule.$name.url" >/dev/null 2>/dev/null
+		if git submodule--helper is-active "$sm_path"
 		then
 			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 			say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
-- 
2.12.0.246.ga2ecc84866-goog

