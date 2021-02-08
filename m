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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B453C433E6
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5199E60238
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbhBHTcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbhBHT3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 14:29:46 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54860C061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 11:29:01 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id z21so10908458pgj.4
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 11:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rt4afAtaxFRLPpXhpWoKhUlkyWUlBWhHTjP7qHVJ68M=;
        b=QECsCHK8i4hayddU45ncE90o90g4H8dFhmpVD0nXbLbL8Si2Uew1N4r4k9Wag6nW+x
         6a80PmSYcsPIIfEqSzVBxIX3ANyL22dNuCl5wtYHzos0LZHcCFgkYKz9PbqXDHxHnL7C
         vjrLzStpgg3jfLspwY1U6He+/RgzqlWVahaMEvdM+UNhU6f9Fkx5NryAuUntzGP3gmjr
         xyTx6MeotsdjO6La1enFTEriZ/fz/MpcClli4BQKw69FNwDsuRbc3i2+X8nIQ26p89HI
         JbN+rJYC4GwnjyZaWcE6ZaCF1eRjV1IRVZfjldfIyNQj4TR5swmDKcekLxYpBOQCFUmg
         nUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rt4afAtaxFRLPpXhpWoKhUlkyWUlBWhHTjP7qHVJ68M=;
        b=bk5u+q5g5q8K3f1efZno9fXHKF0tNR3qk0BPUBAt4EJvZogRMvgKB7dnTWMpcHe+XN
         AX8j3oC+/J9b0jF1DmmVLV8VbUVMovaH/NXIXLrPjxNCbMKelbpxFgx306vry+auJyeg
         I9UG7CQP6r2iPP9vT306aLoFupkzbDN+sR9KTXFV1D5rE6dW8zk7hw0t2F0SlUS6RI8h
         rxodB/XIZisHsf2l9hrqbZt+/qRz//rKgHjvLB3oSIHiuMNiZuaEr+uz5uCbBY6NYxoY
         8eBDQikDkT80EAh+vVyP44RqgMRWdZD4xIRVMFOoySSdDGZ84NLFiSO4ki8oziz/sCCT
         YtTw==
X-Gm-Message-State: AOAM531pcJv+VAzqNwSxXyTvCZlJGaqoMOrE0gCikDOYYOXHCcQYnWUR
        UpEQBDEzdz/u13+hh8UBWS3yin39gQpw6w==
X-Google-Smtp-Source: ABdhPJyFoXbkMO+tA3JccPflkU6wUUiEGIAwhtYPcoeP2gEeYCG4IBAZMOxuLsj8TGEqsCdPZOQmjw==
X-Received: by 2002:a65:43c4:: with SMTP id n4mr2715528pgp.278.1612812540707;
        Mon, 08 Feb 2021 11:29:00 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:91c3:5a1c:9f2d:b1e6])
        by smtp.googlemail.com with ESMTPSA id a141sm19765444pfa.189.2021.02.08.11.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:29:00 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 08/11] t/t3437: simplify and document the test helpers
Date:   Tue,  9 Feb 2021 00:55:28 +0530
Message-Id: <20210208192528.21399-9-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's simplify the test_commit_message() helper function and add
comments to the function.

This patch also document the working of 'fixup -C' with "amend!" in the
test-description.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t3437-rebase-fixup-options.sh | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 180fc50248..cc0ae9411a 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -9,7 +9,9 @@ This test checks the "fixup [-C|-c]" command of rebase interactive.
 In addition to amending the contents of the commit, "fixup -C"
 replaces the original commit message with the message of the fixup
 commit. "fixup -c" also replaces the original message, but opens the
-editor to allow the user to edit the message before committing.
+editor to allow the user to edit the message before committing. Similar
+to the "fixup" command that works with "fixup!", "fixup -C" works with
+"amend!" upon --autosquash.
 '
 
 . ./test-lib.sh
@@ -18,17 +20,19 @@ editor to allow the user to edit the message before committing.
 
 EMPTY=""
 
+# test_commit_message <rev> -m <msg>
+# test_commit_message <rev> <path>
+# Verify that the commit message of <rev> matches
+# <msg> or the content of <path>.
 test_commit_message () {
-	rev="$1" && # commit or tag we want to test
-	file="$2" && # test against the content of a file
-	git show --no-patch --pretty=format:%B "$rev" >actual-message &&
-	if test "$2" = -m
-	then
-		str="$3" && # test against a string
-		printf "%s\n" "$str" >tmp-expected-message &&
-		file="tmp-expected-message"
-	fi
-	test_cmp "$file" actual-message
+	git show --no-patch --pretty=format:%B "$1" >actual &&
+	case "$2" in
+	-m)
+		echo "$3" >expect &&
+		test_cmp expect actual ;;
+	*)
+		test_cmp "$2" actual ;;
+	esac
 }
 
 get_author () {
-- 
2.29.0.rc1

