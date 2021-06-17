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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C18DC48BE8
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 03:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72AFC613D5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 03:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhFQDQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 23:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhFQDQg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 23:16:36 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4C0C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 20:14:28 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g22so3775370pgk.1
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 20:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FlJcgv9vd+KkuVgjlWGWuUDwKc38k0xgmgcwJvTyQvY=;
        b=apQ4amoDY4eAJ7alERQnJcg0vafa3BRBNXdETs01pTX77Blxkct7RLRFfvuYeSFxQY
         zq8wck+KUzaJjBeITsbOfjUQf91Ymx/pjXifm+gxz6baOzkY0eJQPU/X9taOmYLbzKGn
         FeAIMYfKwbWFFFMDBhmAlIq8siwv6cbDKMQTkRX6kmh4pKJxYI7/5laA/XjpkJDJ0uFp
         YpMkkXxdg8lSv21iWs8rAkXqmIzIiqMN1//4uJARvvbg0+niQKXGgiZGDrdNMfZG6LOO
         5hdtSo/Uyl8vGsFo7CzbctVfILcBKzAXpC6Of+0bNk0DmOLL1XnKtd7/mcTF9iDkaxH+
         nx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FlJcgv9vd+KkuVgjlWGWuUDwKc38k0xgmgcwJvTyQvY=;
        b=d2N/pk65gf0GOkDu+3pzUeCkcQdg3vYPSKga0Q+DnKJqmmxIjMXqeKVxbHNUHTygFL
         R1mnjF+BDhtlOeZiXi/aKSTLcR9YW3wMYFcnx0uWVK9zwdb2DmSc9FTRot4pz+Z9GJzk
         BnYkMivxLcKxN+6gpT++7v6DXBoEz8Mc5WWSipwV4JG0bxCZIHjdh0rNMbsaNWhDk7kQ
         NqNN85TLsAHkcW/8o9VvVp+d0634mpVCDvpdqVa95/1OO7XeR1bUW5FHOE17U1eUaQbY
         FASQcnRq2NzCn6l5IVGAbI0WDRGZhRXKkJ8qHhCbeWLn7teSOY8mEpk4SgKz7NAxF2MA
         e3vQ==
X-Gm-Message-State: AOAM533T0AMFHGvTRl4qHRxHaVMUw3dyeGaXE1XmfHkJIhMCrJAnX0yl
        Rt5DxSZJGVUiLo2Kpmpi01SxVYVKm7tClA==
X-Google-Smtp-Source: ABdhPJyAU1o3IvE7TUZGOAZdWW/hdinjOJsCPQVNP9PwBGze9rgFyDYkSl91Qa65WxOgcvAqNM+WUA==
X-Received: by 2002:a62:1942:0:b029:2e9:debd:d8b1 with SMTP id 63-20020a6219420000b02902e9debdd8b1mr3172238pfz.9.1623899668016;
        Wed, 16 Jun 2021 20:14:28 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.151])
        by smtp.gmail.com with ESMTPSA id g18sm3344513pfi.199.2021.06.16.20.14.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jun 2021 20:14:27 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3] t6020: fix incompatible parameter expansion
Date:   Thu, 17 Jun 2021 11:14:11 +0800
Message-Id: <20210617031411.80684-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc0.27.g7b1e85181b
In-Reply-To: <CANYiYbHA+obZPPNw3Oc0h5BbtdVyqpxOK-u3dxDB-sQbdcY0yQ@mail.gmail.com>
References: <CANYiYbHA+obZPPNw3Oc0h5BbtdVyqpxOK-u3dxDB-sQbdcY0yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar reported that the function `make_user_friendly_and_stable_output()`
failed on a i386 box (gcc45) in the gcc farm boxes with error:

    sed: couldn't re-allocate memory

It turns out that older versions of bash (4.3) or dash (0.5.7) cannot
evaluate expression like `${A%${A#???????}}` used to get the leading 7
characters of variable A.

Replace the incompatible parameter expansion so that t6020 works on
older version of bash or dash.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t6020-bundle-misc.sh | 50 ++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 881f72fd44..3140ca4fdc 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -80,30 +80,42 @@ test_commit_setvar () {
 	eval $var=$oid
 }
 
+get_abbrev_oid () {
+	oid=$1 &&
+	suffix=${oid#???????} &&
+	oid=${oid%$suffix} &&
+	if test -n "$oid"
+	then
+		echo "$oid"
+	else
+		echo "undefined-oid"
+	fi
+}
+
 # Format the output of git commands to make a user-friendly and stable
 # text.  We can easily prepare the expect text without having to worry
 # about future changes of the commit ID and spaces of the output.
 make_user_friendly_and_stable_output () {
 	sed \
-		-e "s/${A%${A#???????}}[0-9a-f]*/<COMMIT-A>/g" \
-		-e "s/${B%${B#???????}}[0-9a-f]*/<COMMIT-B>/g" \
-		-e "s/${C%${C#???????}}[0-9a-f]*/<COMMIT-C>/g" \
-		-e "s/${D%${D#???????}}[0-9a-f]*/<COMMIT-D>/g" \
-		-e "s/${E%${E#???????}}[0-9a-f]*/<COMMIT-E>/g" \
-		-e "s/${F%${F#???????}}[0-9a-f]*/<COMMIT-F>/g" \
-		-e "s/${G%${G#???????}}[0-9a-f]*/<COMMIT-G>/g" \
-		-e "s/${H%${H#???????}}[0-9a-f]*/<COMMIT-H>/g" \
-		-e "s/${I%${I#???????}}[0-9a-f]*/<COMMIT-I>/g" \
-		-e "s/${J%${J#???????}}[0-9a-f]*/<COMMIT-J>/g" \
-		-e "s/${K%${K#???????}}[0-9a-f]*/<COMMIT-K>/g" \
-		-e "s/${L%${L#???????}}[0-9a-f]*/<COMMIT-L>/g" \
-		-e "s/${M%${M#???????}}[0-9a-f]*/<COMMIT-M>/g" \
-		-e "s/${N%${N#???????}}[0-9a-f]*/<COMMIT-N>/g" \
-		-e "s/${O%${O#???????}}[0-9a-f]*/<COMMIT-O>/g" \
-		-e "s/${P%${P#???????}}[0-9a-f]*/<COMMIT-P>/g" \
-		-e "s/${TAG1%${TAG1#???????}}[0-9a-f]*/<TAG-1>/g" \
-		-e "s/${TAG2%${TAG2#???????}}[0-9a-f]*/<TAG-2>/g" \
-		-e "s/${TAG3%${TAG3#???????}}[0-9a-f]*/<TAG-3>/g" \
+		-e "s/$(get_abbrev_oid $A)[0-9a-f]*/<COMMIT-A>/g" \
+		-e "s/$(get_abbrev_oid $B)[0-9a-f]*/<COMMIT-B>/g" \
+		-e "s/$(get_abbrev_oid $C)[0-9a-f]*/<COMMIT-C>/g" \
+		-e "s/$(get_abbrev_oid $D)[0-9a-f]*/<COMMIT-D>/g" \
+		-e "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" \
+		-e "s/$(get_abbrev_oid $F)[0-9a-f]*/<COMMIT-F>/g" \
+		-e "s/$(get_abbrev_oid $G)[0-9a-f]*/<COMMIT-G>/g" \
+		-e "s/$(get_abbrev_oid $H)[0-9a-f]*/<COMMIT-H>/g" \
+		-e "s/$(get_abbrev_oid $I)[0-9a-f]*/<COMMIT-I>/g" \
+		-e "s/$(get_abbrev_oid $J)[0-9a-f]*/<COMMIT-J>/g" \
+		-e "s/$(get_abbrev_oid $K)[0-9a-f]*/<COMMIT-K>/g" \
+		-e "s/$(get_abbrev_oid $L)[0-9a-f]*/<COMMIT-L>/g" \
+		-e "s/$(get_abbrev_oid $M)[0-9a-f]*/<COMMIT-M>/g" \
+		-e "s/$(get_abbrev_oid $N)[0-9a-f]*/<COMMIT-N>/g" \
+		-e "s/$(get_abbrev_oid $O)[0-9a-f]*/<COMMIT-O>/g" \
+		-e "s/$(get_abbrev_oid $P)[0-9a-f]*/<COMMIT-P>/g" \
+		-e "s/$(get_abbrev_oid $TAG1)[0-9a-f]*/<TAG-1>/g" \
+		-e "s/$(get_abbrev_oid $TAG2)[0-9a-f]*/<TAG-2>/g" \
+		-e "s/$(get_abbrev_oid $TAG3)[0-9a-f]*/<TAG-3>/g" \
 		-e "s/ *\$//"
 }
 
-- 
2.32.0.rc0.27.g7b1e85181b

