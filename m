Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CD8C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 19:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3551B60ED6
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 19:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbhHETsq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 15:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236704AbhHETsq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 15:48:46 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2F6C061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 12:48:30 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id z6-20020a0568302906b02904f268d34f86so6022671otu.2
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=em8T61NA2LKtI0wWKXlROOwVSCcUWG76m0Z7iL53H4w=;
        b=iQCE51s3p+WooSNfa1d6eceYRyGzVmW+5ktBVM0kqwNmyCb31YQA71hgEaQ/53Orcn
         RSiIvbwmsCFwVi6j2fQ6cpoUohMfvI/GVHaZm5O6HvQq7IBIARKTdPDWiHzUaltt/+U7
         ECBUqRTX0qTGeYtX3QF9DReJwLQp4rRDYtLAaq7ji15x1dHQeajxu8a48y7pukWMBFT2
         tZURGNQg0BALvMlujqwwoAg9IVDFSOG8oEkP2rNtyW7CfxaL8y7X4FwnXrwnB+zldo9W
         XwFRdZjlPdOGoABGL565s2I0Er+37a2atMzm95Ng+QvrGuBZFzAVyDomji8+2yDyHPWQ
         UBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=em8T61NA2LKtI0wWKXlROOwVSCcUWG76m0Z7iL53H4w=;
        b=pCDo9pyRGaisBVgF+hyWhJBRMy8tuZ0HeleQf9kO7Vr/zDSkZGVjkkcKv3btU5F6zq
         G/SLvJwDjogvYLpobWQNn+BqABNEkV2nK/N4ZuyhVBDz/12LgbKUns2P/BzLRVdpJjax
         cndrsEH4R2if7tkG+nr/RF+JbVBxN3sshxMukTGr0t2G+Jg/NxTP5s+IgVs7Qmz+8//k
         d2Ewb13PZByt+9Mwmp/GWvVh2nuMxIrbmWttlpQRVlaUpDE2hLavm5J+ybpj7n2/VIVH
         7c6cmajMrfaD2Hhy5aapevBNh/YPy/EEfzWLPP5z3iTRKF6ko+I/5V72BGye8gsZF8M7
         Tqeg==
X-Gm-Message-State: AOAM530xNoAgPpCKLTgcmqz/HeN5UGLkO7Ow8lNEDcHQT9QAJo8TOmj6
        V7/Ui3Umkd/8t0JjEE87nI3hGOR9BQUPhg==
X-Google-Smtp-Source: ABdhPJwjikrWK6I9fYXdAGdsrfZGvPuhXcH4gyqo3Ouf42ZWqRqficyCXc6ygVQG3h3ASB8iYWyUbA==
X-Received: by 2002:a05:6830:1305:: with SMTP id p5mr5104873otq.353.1628192909973;
        Thu, 05 Aug 2021 12:48:29 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id i18sm1253805oik.3.2021.08.05.12.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 12:48:29 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>
Subject: [PATCH] test: fix for COLUMNS and bash 5
Date:   Thu,  5 Aug 2021 14:48:25 -0500
Message-Id: <20210805194825.1796765-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.40.gb9b36f9b52
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since c49a177bec (test-lib.sh: set COLUMNS=80 for --verbose
repeatability, 2021-06-29) multiple tests have been failing when using
bash 5 because checkwinsize is enabled by default, therefore COLUMNS is
reset using TIOCGWINSZ even for non-interactive shells.

It's debatable whether or not bash should even be doing that, but for
now we can avoid this undesirable behavior by disabling this option.

Reported-by: Fabian Stelzer <fabian.stelzer@campoint.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/test-lib.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index db61081d6b..a2b7dfecee 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -419,6 +419,12 @@ COLUMNS=80
 export LANG LC_ALL PAGER TZ COLUMNS
 EDITOR=:
 
+# Since bash 5.0, checkwinsize is enabled by default which does update the
+# COLUMNS variable every time a command completes, even for non-interactive
+# shells.
+# Disable that since we are aiming for reproducibility.
+test -n "$BASH_VERSION" && shopt -u checkwinsize 2>/dev/null
+
 # A call to "unset" with no arguments causes at least Solaris 10
 # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
 # deriving from the command substitution clustered with the other
-- 
2.32.0.40.gb9b36f9b52

