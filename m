Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89D061F90A
	for <e@80x24.org>; Fri, 13 Jul 2018 05:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeGMGGA (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 02:06:00 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36951 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbeGMGGA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 02:06:00 -0400
Received: by mail-io0-f195.google.com with SMTP id z19-v6so30331025ioh.4
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 22:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5nI1AQweIV8WquiBZI6Wt8CoHk1R/tV/a9mmOM9Yrxo=;
        b=Tye3VFEcS+MImamHV5X//mdwU3Xy+DBqnLULut3GV/h4Pa9puQo1V4aeXG2sfFtckz
         lw0DnkNbkV6+5h3AB99a1IpViFboJ0F0ZQSlRQ8JHcjhgJQaCW+yquXiCTp1nBcGQykJ
         GMUQVhSoD/Qb1xNDAsFuUg5+kIAlnOJtVCBmwDL08kjFEGlty1WHMDFh6W2uWTs6Ta4B
         DMr5tmyX3jB7P9+TvN1DxG/KioJrXjmk+Na+nvgp5jJ92NbwaQRm75VgHfNcQFD4YKPQ
         YBSDwSDgFLuFXiX1ktz3RHCTPWMCOrHMBKrm0MbxuYFSgYfGEQLzDcGnrdFhSgg86esS
         QBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=5nI1AQweIV8WquiBZI6Wt8CoHk1R/tV/a9mmOM9Yrxo=;
        b=np4LoGM8Yz0tAvGLxKa92I9omRXPF05NSFwgQQC2mwrG6swFV5mg2g9QkKISZXBKs9
         4ihI66dJvCdNVIET+GH/OeclgSzM4NqKy1P5NyctoH2RG6lHX/BctmgHmqyV3d2GltcW
         3uBj3bDzhmTNg9MS6vUg5mm/wFL9hyK+Ug4M2Db22tizz++RmSkj1C6GyL69vCVwOaaO
         +oJRKZ7jJdC8k8eoUPewlJSJEpS5+16jboosaknrlrJ633DzVJMZ0PNcW7q2ivBUAcu1
         nWQp3Myyer/CEyXKdDjMFqYb+GfEfSaeRG0oNWqFvjFdKA2i4UUtfw928DVRCzY7wgqO
         TJkg==
X-Gm-Message-State: APt69E0QQ1kkj+zR5+kxFUlnclyykyIO+XdDxspR8dqiybwkYYHaIz3w
        L+QuKIY+9jHrC+/uCQFc84svCA==
X-Google-Smtp-Source: AAOMgpcvjuGVze0tAcobKovi0onSIXws+FmIOUNx1Bq6eKqmekRNUg9cXUZjUGFVBNFSqWPSfoJk1A==
X-Received: by 2002:a6b:a04f:: with SMTP id j76-v6mr29651240ioe.25.1531461178004;
        Thu, 12 Jul 2018 22:52:58 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id m10-v6sm3138036ioj.22.2018.07.12.22.52.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 22:52:57 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/4] t6046/t9833: fix use of "VAR=VAL cmd" with a shell function
Date:   Fri, 13 Jul 2018 01:52:02 -0400
Message-Id: <20180713055205.32351-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e
In-Reply-To: <20180713055205.32351-1-sunshine@sunshineco.com>
References: <20180713055205.32351-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unlike "FOO=bar cmd" one-shot environment variable assignments
which exist only for the invocation of 'cmd', those assigned by
"FOO=bar shell_func" exist within the running shell and continue to
do so until the process exits (or are explicitly unset). It is
unlikely that this behavior was intended by the test author.

In these particular tests, the "FOO=bar shell_func" invocations are
already in subshells, so the assignments don't last too long, don't
appear to harm subsequent commands in the same subshells, and don't
affect other tests in the same scripts, however, the usage is
nevertheless misleading and poor practice, so fix the tests to assign
and export the environment variables in the usual fashion.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t6046-merge-skip-unneeded-updates.sh | 4 +++-
 t/t9833-errors.sh                      | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t6046-merge-skip-unneeded-updates.sh b/t/t6046-merge-skip-unneeded-updates.sh
index fcefffcaec..38e24f787c 100755
--- a/t/t6046-merge-skip-unneeded-updates.sh
+++ b/t/t6046-merge-skip-unneeded-updates.sh
@@ -366,7 +366,9 @@ test_expect_success '2c-check: Modify b & add c VS rename b->c' '
 
 		git checkout A^0 &&
 
-		GIT_MERGE_VERBOSITY=3 test_must_fail git merge -s recursive B^0 >out 2>err &&
+		GIT_MERGE_VERBOSITY=3 &&
+		export GIT_MERGE_VERBOSITY &&
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
 
 		test_i18ngrep "CONFLICT (rename/add): Rename b->c" out &&
 		test_i18ngrep ! "Skipped c" out &&
diff --git a/t/t9833-errors.sh b/t/t9833-errors.sh
index 9ba892de7a..277d347012 100755
--- a/t/t9833-errors.sh
+++ b/t/t9833-errors.sh
@@ -26,7 +26,9 @@ test_expect_success 'error handling' '
 	) &&
 	p4 passwd -P newpassword &&
 	(
-		P4PASSWD=badpassword test_must_fail git p4 clone //depot/foo 2>errmsg &&
+		P4PASSWD=badpassword &&
+		export P4PASSWD &&
+		test_must_fail git p4 clone //depot/foo 2>errmsg &&
 		grep -q "failure accessing depot.*P4PASSWD" errmsg
 	)
 '
-- 
2.18.0.233.g985f88cf7e

