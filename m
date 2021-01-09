Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A618C433E0
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 21:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D38D423AC0
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 21:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbhAIVuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 16:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbhAIVuK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 16:50:10 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AE7C061786
        for <git@vger.kernel.org>; Sat,  9 Jan 2021 13:49:30 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id i5so10032447pgo.1
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 13:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jAzQeuEFTSkVytbHSVBsnk2Jo+p50kgLRP3weGObTR0=;
        b=U3/M+4yWIeYK4jFbZ7lp44srCNNhKId7Yj10F19EUjUtdZg8NGrgMV8Zu+vtY+af5i
         h5QTwi+h4MB7udcrxURkjcFlUgeAFFqVsrKj2OSa5xPT2Iw02AAdrFCL+A7ksX05sFr1
         4JYEnN5gkhEvTgOR1ms6IbI/rbNdwd4Lf+hoa5NFnQNDsbSTLHNWcqYs2iCFSDZax2UN
         E7ubGxJY1jlgnJHqEuTQilbtB+JFPa+EI7bBt58i5zfu/vok57PnQeZebDGgo9wd3gwA
         CDn38cMROCdpuKF7ia8qfO2GcbPodOytHo4TDaW0Nf/EvRLv7qo6cByRA+UURrTKn4ps
         RirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jAzQeuEFTSkVytbHSVBsnk2Jo+p50kgLRP3weGObTR0=;
        b=KwlnMjJOYO7gRpjBpSGFlgviM3jfD8priHTIji9LfLIygffoh7FsstR9XARnat6YdX
         9TtlXhahEPmmQLpm0jvC9N9A20n281XJu5+dgklZUohhoCm40ePisVoXF9X3ObAdN9tt
         bOp8DBDpvuEJ5Hs+CjmT1MqjN6HQzNsur+lDLx1C6HYlzTqx8clPNhmzWRCRmJYmeRYH
         0LN00dZVHD9hJt29Sv21ea7Hk8/xTKDzMZ4sisfqhG24zkwgmBZzLi3vxGpw//uF3ihr
         IVTUR8P7xNckOtofg8Eq10ksTWx8BFnD5sEpxRO9iYIX0Nxx83tYfgAc5PnxkxZo3WvQ
         qrCA==
X-Gm-Message-State: AOAM532wGCX3MXOMokslJvGFfm39/1SklvbIe78V8Wu6LAtunn18Gvnn
        F+iYMiQBgaqafZ1vszuhPVQ=
X-Google-Smtp-Source: ABdhPJzaklG5m7bI2CiUcS7WIbk7y2NmNn6cedqb6fnwdpWJzjInw773Jdsphrp5PMKrp9i3slB5GA==
X-Received: by 2002:aa7:9a86:0:b029:1a6:d998:922a with SMTP id w6-20020aa79a860000b02901a6d998922amr9891827pfi.80.1610228969740;
        Sat, 09 Jan 2021 13:49:29 -0800 (PST)
Received: from mailhub.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id fs12sm9230326pjb.49.2021.01.09.13.49.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jan 2021 13:49:29 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Seth House <seth@eseth.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] fixup! mergetool: add automerge configuration
Date:   Sat,  9 Jan 2021 13:49:22 -0800
Message-Id: <20210109214922.33972-1-davvid@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1.6.g2bc636d1d6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The use of "\r\?" in sed is not portable to macOS and possibly
other unix flavors.

Replace "\r" with a substituted variable that contains "\r".
Replace "\?" with "\{0,1\}".

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This is based on top of fc/mergetool-automerge and can be squashed in
(with the addition of my sign-off) if desired.

Let me know if you'd prefer a separate patch. I figured we'd want
a squash to preserve bisectability.

 git-mergetool.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index a44afd3822..12c3e83aa7 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -243,9 +243,16 @@ auto_merge () {
 	git merge-file --diff3 --marker-size=7 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
 	if test -s "$DIFF3"
 	then
-		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"
-		sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$DIFF3" >"$LOCAL"
-		sed -e '/^<<<<<<< /,/^=======\r\?$/d' -e '/^>>>>>>> /d' "$DIFF3" >"$REMOTE"
+		cr=$(printf '\x0d')
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
2.30.0.rc1.6.g2bc636d1d6

