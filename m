Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72070C433E0
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB792388B
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbhAIWnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 17:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbhAIWnY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 17:43:24 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FBAC061786
        for <git@vger.kernel.org>; Sat,  9 Jan 2021 14:42:44 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id q4so7547801plr.7
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 14:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N6jYHYt3fnDjj3C4gnvdRcXf9fA7FlMIz3mhEpbzUEE=;
        b=fOp4Wkiwxqzwao8Y2EAl+DaupL3tVfav8fTKEfK9o/UYrqsnIUKnonI1L9ycxLf0zn
         ++13D6Jdam0McI0Vh1yXrWsZdtpFlHtaC3NgMgOwRJ8lVxersm5PjFGpPyWpfRIEalhW
         +6HaLbCKIVMUn9QMhqWokEQKKTNohJr5be9ukz7S1V/hb4hZm2OwXLO6AJ9B3fUAkfZs
         smism1A7v9hUyKdgXnlpgW9oOcY132FdyEGLQv0Yv2ke84v8+JWCXpzUBg4iXe09XPXj
         hnECdyDly2pBzW/Ea26wL6QZ//MfoUuUiAzdVLbPXWjC3rmbMFGgtofJjEjW2uAptbcG
         k7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N6jYHYt3fnDjj3C4gnvdRcXf9fA7FlMIz3mhEpbzUEE=;
        b=Xna5dC9q0BAE++IXWHZ0K4K0iMlKRhGbKKyH9hN7DIlfWbLUcf+iwaHEhdIkNk2IEV
         IuKPwZTskh9pByYMuWUwiVT4eMtgmuNXv7D1vrpVgmQMQ9xfP6iyCYMAbvvwSlkMAIWv
         UkKIEL3U9Xpy79lIatHvlKZQR6TSvUgdnlt1+w1/EL0vt/9SufPAgv5nocVBkLwKV+qz
         StbIGDOVstE0Y77vLNUKznoHs1kk5selWCUp4KWPycaMD14UhFpRF2IklkLpErGBYDVX
         5tGqmx5RLnb+1AZ6cXIDVrrJMMG5MYWvyLwUINvBnF9BAfcoc0zORt+AKngwliI8Zl78
         JbdQ==
X-Gm-Message-State: AOAM531Y7G2XcsUGTX1O/vtFIOu/tWCmkdsyBDCo+XZiVTm6NUdyM0vC
        mt+I51re2X+hqE7EsaWgld0=
X-Google-Smtp-Source: ABdhPJxFny0sk1ARuGlr7NNrVlG2Db1UNmfMbLHqqCEd2drMtHhpHcOuv1H1nHoI+VBTN8pdxRb35Q==
X-Received: by 2002:a17:902:9a90:b029:da:ba07:efdc with SMTP id w16-20020a1709029a90b02900daba07efdcmr10132683plp.1.1610232163885;
        Sat, 09 Jan 2021 14:42:43 -0800 (PST)
Received: from mailhub.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id cu4sm9868013pjb.18.2021.01.09.14.42.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jan 2021 14:42:43 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Seth House <seth@eseth.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: [PATCH v2] fixup! mergetool: add automerge configuration
Date:   Sat,  9 Jan 2021 14:42:36 -0800
Message-Id: <20210109224236.50363-1-davvid@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1.6.g3f22546b2b.dirty
In-Reply-To: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net>
References: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"\r\?" in sed is not portable to macOS and possibly others.
"\r" is not valid on Linux with POSIXLY_CORRECT.

Replace "\r" with a substituted variable that contains "\r".
Replace "\?" with "\{0,1\}".

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
This is based on top of fc/mergetool-automerge and can be squashed in
(with the addition of my sign-off) if desired.

Changes since last time:
- printf '\r' instead of printf '\x0d'
- The commit message now mentions POSIXLY_CORRECT.

 git-mergetool.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index a44afd3822..9029a79431 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -243,9 +243,16 @@ auto_merge () {
 	git merge-file --diff3 --marker-size=7 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
 	if test -s "$DIFF3"
 	then
-		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"
-		sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$DIFF3" >"$LOCAL"
-		sed -e '/^<<<<<<< /,/^=======\r\?$/d' -e '/^>>>>>>> /d' "$DIFF3" >"$REMOTE"
+		cr=$(printf '\r')
+		sed -e '/^<<<<<<< /,/^||||||| /d' \
+			-e "/^=======$cr\{0,1\}$/,/^>>>>>>> /d" \
+			"$DIFF3" >"$BASE"
+		sed -e '/^||||||| /,/^>>>>>>> /d' \
+			-e '/^<<<<<<< /d' \
+			"$DIFF3" >"$LOCAL"
+		sed -e "/^<<<<<<< /,/^=======$cr\{0,1\}$/d" \
+			-e '/^>>>>>>> /d' \
+			"$DIFF3" >"$REMOTE"
 	fi
 	rm -- "$DIFF3"
 }
-- 
2.30.0.rc1.6.g3f22546b2b.dirty

