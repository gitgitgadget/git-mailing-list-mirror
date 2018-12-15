Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6D0A20A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbeLOAKb (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:10:31 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:39120 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbeLOAKb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:10:31 -0500
Received: by mail-yw1-f74.google.com with SMTP id v195so4313091ywc.6
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RS8nqdTcWQrvybApg60DULpMo6QPQB7tfPz5RUfnYdE=;
        b=MOdn3SNxNCYJbWWAdTzucWUu1XawyvX55lIxBXBIsH4hqTXzUuYHXmqmxw+dIKWvIu
         l6cwQnQXyQqeX5kqe57yFFkHFCzUz/5la1LCTb/canMLvIVmV8r9QDCKcBMUs1USTpiI
         i09hsgdSHtuGH3qZZlMedd/g+CgzT3M+gDl4717fo+86MK4ugLw0oKWKQC+D7ZDn1TVe
         Cs1vS1lohLfchNLeJjDYvHNPGgqenX01VHCi1z3QSoRcpPtIPKaXAiu8QJMoVtyzDY1a
         5uzfkGf7ufhh7FpWXelcZVD2VvzXqZjDAY+psd/L5oEEwdKZYCfGGnvkjp5CrdCFCad5
         YKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RS8nqdTcWQrvybApg60DULpMo6QPQB7tfPz5RUfnYdE=;
        b=HLJMGqivEH4+5ggGkfkQE0FexK7zc8SDe/pTjQwM1xD9Uc9B8b9fHE4GXuGuHHmNoM
         9+IQs4gAmp+uAssb4p1MFORAM46/3e/SLDeusHNIDWzeEOBR+Bd+2rumbERREgN+gB1K
         kxv8jYmtduz/ASEn7KV3K/mtbWJOLECn7ogWBvKxHRewf4hnhdgr9gEinAS+/UUg/jwl
         y8ZDy5vZPjQU0Ntg+FAMqw9r/pQKLSl1ponwPZJwu95rjaXJ0xRsRf1d/GVVqTHwxEwm
         bN5Z7UpUTybrSSnxQt89z1a/fIgFgyrAcXmv3Jo7mpJTnPZrMTwyZ2iSwkck5OT1k3D6
         2wRw==
X-Gm-Message-State: AA+aEWb3ZxI6j04+FSJIfl++1gTuQiN5HW78EKFoTADuXWeA0pObMUm6
        WgZtm8qZKQ7jTxbwUfEu1SEosGUuXOQ2FQtdVknXyhRBnh/m3uZjrexQjJ5jdVkw5cpzAYLojqf
        FPqtSJ3ShiSR+x0qEkLZKtj3bPqKUfy6I1eQQPMf5ldsMyaht8FVSOLT2S/jR
X-Google-Smtp-Source: AFSGD/WjXLlo8o1Enjh3MeL8rmRhohWCEkzidOs2feHFVB759ctpIwvmcucx3mHqAnJOWWDX4Pdd3ii8tgil
X-Received: by 2002:a25:804e:: with SMTP id a14mr2784282ybn.77.1544832630529;
 Fri, 14 Dec 2018 16:10:30 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:38 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-20-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 19/23] submodule: don't add submodule as odb for push
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In push_submodule(), because we do not actually need access to objects
in the submodule, do not invoke add_submodule_odb().
(for_each_remote_ref_submodule() does not require access to those
objects, and the actual push is done by spawning another process,
which handles object access by itself.)

This code of push_submodule() is exercised in t5531 and continues
to work, showing that the submodule odbc is not needed.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 4486ff664b..d9c06767a1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1023,9 +1023,6 @@ static int push_submodule(const char *path,
 			  const struct string_list *push_options,
 			  int dry_run)
 {
-	if (add_submodule_odb(path))
-		return 1;
-
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		argv_array_push(&cp.args, "push");
-- 
2.20.0.405.gbc1bbc6f85-goog

