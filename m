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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774FEC4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B3D613A9
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhFAOvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 10:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbhFAOvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 10:51:16 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAF5C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 07:49:35 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t9so7132801pgn.4
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 07:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NV+2ysL/Y8XB8fi8dXMysJyk+65DT4KqR7AvvDv2Lqo=;
        b=lHcLFx94pNMwQVkx1TnitXLerd0mWcrGHUwhCjTvkOP7fdP/kNdaFWchZyNR9HI6i0
         KbYuDKJJQI2OwXNmOnvFI+ZSA2v/n+9z3927At7+Q2vHZqtaBN9dAfyHKgjETvA7V07R
         GLSfFmlh1ObuEzT5ZyK1YQ2YqkbsxBFmT57sHiu9uY6BhVtKtID2dpM06U3O2NCkW9Ho
         GybD4GANZLIAGuxKldisNycnIhz3TSQ+pLBU5lGXlnDtzYCGO1jdKHY5thjHBVX9FjlQ
         Aa3SJBMf0LvMOv3g6pVzTaGEks5hjKoFucdLi6KR6/IcYh7zTTm7DdbCrtZGhtS6JsJh
         G1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NV+2ysL/Y8XB8fi8dXMysJyk+65DT4KqR7AvvDv2Lqo=;
        b=l3u9aoO3KUivMi0Iczjc9NksuXN45mJo6Rt6h2ZMmPLoC4CVIavX/lsy41NeL4r3Pm
         k0lYh3PGL/FAVTzo3Wp91HHWItbIPJUmnjZPHKe+UvRLrGkdeCfICswWcRSaRCMmftf9
         jkm5jYQy9KSRqNWe+QKVYsHHWDIOIRMc48Hsv73Hyy0CEK7ohIpPexcwiYXsbNR45Qrx
         NR6w/okcwYc2VrEIPG5STRYVtUbZa8uBCn+1Ba12d2GBqwZ4/4rlj59jcZ7E6juJ9SXa
         JUZDM1EVUyNmYWnFI0xOlcQ8upePFV6vZ4FdDX7Zd3uz+yCEsHIENdvsS5Zr1lg3Le7c
         mG1A==
X-Gm-Message-State: AOAM533JabB55udqtlYlpb5DEHRwJB2o5gLrXIrOyVIWn8h+PRPqaDRv
        uFDGiomFYQP/gclV1uQnOOU=
X-Google-Smtp-Source: ABdhPJwj2bTs5jBkLlMNMs2MS1BgNCvKMJ17D8vFM6igmxa5P+Ma9Otb5N2ZT+FcqcdNj1mtpP5X1g==
X-Received: by 2002:a63:150d:: with SMTP id v13mr16765688pgl.304.1622558975110;
        Tue, 01 Jun 2021 07:49:35 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id f2sm14174507pgl.67.2021.06.01.07.49.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 07:49:34 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>, Jeff King <peff@peff.net>
Subject: [PATCH 1/2] t6020: fix bash incompatible issue
Date:   Tue,  1 Jun 2021 22:49:00 +0800
Message-Id: <20210601144901.31375-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <CANYiYbEXiaJ-iN+wLijoKGB_ebEF3eDK8BBwtYz0unE0mKtR8w@mail.gmail.com>
References: <CANYiYbEXiaJ-iN+wLijoKGB_ebEF3eDK8BBwtYz0unE0mKtR8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Ævar reported that the function `make_user_friendly_and_stable_output()`
failed on a i386 box (gcc45) in the gcc farm boxes with error:

    sed: couldn't re-allocate memory

It turns out that older versions of bash (4.3) or dash (0.5.7) cannot
evaluate expression like `${A%${A#???????}}` used to get the leading 7
characters of variable A.

Replace the complex expressions so that t6020 works on older version of
bash or dash.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t6020-bundle-misc.sh | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 881f72fd44..c6a8ea7f76 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -77,7 +77,8 @@ test_commit_setvar () {
 		git ${indir:+ -C "$indir"} commit $signoff -m "$1" &&
 		oid=$(git ${indir:+ -C "$indir"} rev-parse HEAD)
 	fi &&
-	eval $var=$oid
+	suffix=${oid#???????} &&
+	eval $var=${oid%$suffix}
 }
 
 # Format the output of git commands to make a user-friendly and stable
@@ -85,25 +86,25 @@ test_commit_setvar () {
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
+		-e "s/$A[0-9a-f]*/<COMMIT-A>/g" \
+		-e "s/$B[0-9a-f]*/<COMMIT-B>/g" \
+		-e "s/$C[0-9a-f]*/<COMMIT-C>/g" \
+		-e "s/$D[0-9a-f]*/<COMMIT-D>/g" \
+		-e "s/$E[0-9a-f]*/<COMMIT-E>/g" \
+		-e "s/$F[0-9a-f]*/<COMMIT-F>/g" \
+		-e "s/$G[0-9a-f]*/<COMMIT-G>/g" \
+		-e "s/$H[0-9a-f]*/<COMMIT-H>/g" \
+		-e "s/$I[0-9a-f]*/<COMMIT-I>/g" \
+		-e "s/$J[0-9a-f]*/<COMMIT-J>/g" \
+		-e "s/$K[0-9a-f]*/<COMMIT-K>/g" \
+		-e "s/$L[0-9a-f]*/<COMMIT-L>/g" \
+		-e "s/$M[0-9a-f]*/<COMMIT-M>/g" \
+		-e "s/$N[0-9a-f]*/<COMMIT-N>/g" \
+		-e "s/$O[0-9a-f]*/<COMMIT-O>/g" \
+		-e "s/$P[0-9a-f]*/<COMMIT-P>/g" \
+		-e "s/$TAG1[0-9a-f]*/<TAG-1>/g" \
+		-e "s/$TAG2[0-9a-f]*/<TAG-2>/g" \
+		-e "s/$TAG3[0-9a-f]*/<TAG-3>/g" \
 		-e "s/ *\$//"
 }
 
-- 
2.32.0.rc0

