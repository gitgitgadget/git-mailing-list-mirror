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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D156FC433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A495F64DDA
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhBOAzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhBOAzH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:55:07 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DCCC06121C
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:13 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v7so7116801wrr.12
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Q+mACrRlbw12OuTd/jwTS9XoD5EdWZy9We4ahUXRSI=;
        b=rjVjAeWnwevLqC9uh86xyCRdJGzvymyVXzLWZdv8SNHkQinfHrYhdSfhmNaS8DMToj
         m7sNgiIE+6MizJs3UGo+5sO9WvYBJ7TNWPZlSzstwWakW3KX+T6C9R/YkuW8ct7S8KQp
         X9hE993OkVkm3iA/wGf3NXc4Midt9O+o4uM4VOenxe6umcr/WiUMlndB6wtgUBd8IVyA
         E2aX9W67QQrPqKIlawn/pw0jy250u4+d8uGxOBjN91GJRMEhZqrZQizsywOu3a4RBNcS
         Xka60Ac6pngOu9rNvggsaMIPRN3sVAsiyqlzDZcPlEQcyKkI8v544mjVpCXZDFSajGl4
         0I9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Q+mACrRlbw12OuTd/jwTS9XoD5EdWZy9We4ahUXRSI=;
        b=KED/UuttxTm780mC9/OKzYFHHEN9/zmC4FdtXQqCry9xdIqDfd4odqNJHZxUwrjJVe
         m0LyBUcBo+D0cnKOQjRjJmuXww4SK/z+52j7eCJA3MvdQddmsxqzaGnzkFDDRIitA5q4
         Y4WVYyFQkt+/vCRZlM9W0Z1yP1e8qZlv5+4mYPACuI5/XUfhxYqzseCEWwgjIvs++M3K
         6anK4XtnB3FIrl+cEuqbBOaFBKe/n0309+LXiOXhc0BySeklVLDcBz6izGRzaBsPELrg
         CHoYE2N6lTmYtbPRy+XXLUGXv5PJL5oJOgVkX6oaLIJoHsufC6LW0W4Fw2Uy2NCyCBq0
         orkg==
X-Gm-Message-State: AOAM533aZ2M4zbUMwA8EhvCFHrF4ae1pWkRzfRz97AUGPKZuOxPJu0Po
        nmTMjpgOUW0dHfEgi2FoP489/DoxCJOBDQ==
X-Google-Smtp-Source: ABdhPJxqMCm0/D7BbjnnMzIrbb59IN1jOWaESfR6V/oqWhuqrCMnb0tncajAsybG/wjDkw42frKtqA==
X-Received: by 2002:adf:e585:: with SMTP id l5mr15792023wrm.85.1613350392064;
        Sun, 14 Feb 2021 16:53:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:53:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 16/20] userdiff tests: remove "funcname" from custom3 test
Date:   Mon, 15 Feb 2021 01:52:32 +0100
Message-Id: <20210215005236.11313-17-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can only have one "funcname" or "xfuncname", any later definition
overrides the earlier one, so this configuration wasn't doing
anything.

When this test was originally added in 3632cfc248 (Use compatibility
regex library for OSX/Darwin, 2008-09-07) we had no such definition of
two patters for this test. Back then this was setting the
"diff.java.funcname" configuration variable.

The stage for that second pattern being set got set later. In
45d9414fa5 (diff.*.xfuncname which uses "extended" regex's for hunk
header selection, 2008-09-18) the pattern got converted from
"funcname" to "xfuncname".

Soon after in b19d288b4d (t4018-diff-funcname: demonstrate end of line
funcname matching flaw, 2008-10-15) another test immediately preceding
this one got added, using "diff.java.funcname" for its configuration.

Then f792a0b88e (t4018 (funcname patterns): make configuration easier
to track, 2011-05-21) came along and codified this whole thing when
converting the two tests from "git config" to "test_config".

Since this was never the intent of the test let's just remove this,
the rationale in f792a0b88e for having some test for the clobbering
behavior makes sense, but I'll do that in another follow-up test, not
as a hard to read side-effect of this one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018/custom.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4018/custom.sh b/t/t4018/custom.sh
index cccf468c3a..81a68aa332 100755
--- a/t/t4018/custom.sh
+++ b/t/t4018/custom.sh
@@ -51,7 +51,6 @@ public class Beer
 EOF_TEST
 
 test_expect_success 'custom: setup alternation in pattern' '
-	git config diff.custom.funcname "Beer$" &&
 	git config diff.custom.xfuncname "^[ 	]*((public|static).*)$"
 '
 
@@ -133,6 +132,7 @@ test_diff_funcname 'custom: config precedence' \
 line
 EOF_HUNK
 line
+
 !negation
 
 ChangeMe
-- 
2.30.0.284.gd98b1dd5eaa7

