Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600B0C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 19:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354486AbiE0T40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 15:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiE0T4X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 15:56:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6944656E
        for <git@vger.kernel.org>; Fri, 27 May 2022 12:56:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h11so3489382wrb.0
        for <git@vger.kernel.org>; Fri, 27 May 2022 12:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FDZp3fOc3LrdgTOKImHjjFn6J4UWMtAmT18X4SkeIFE=;
        b=lBAEUjTDJWlWTDfJsyerdjhx+Izmb4whcAxLq6ypJDufx7mW/yo4/suSlh43R6E8Ed
         I3HVpl1IMSEKT69VNpKBjMziGMvk0us6LXbPphaNAVV8lp9bGgp/ArJpeBBEQntwYKDF
         OTTfrnk960TcxGivGGBq4wcFnPEV/ZTanOYqlNHYq0DySeD9SVyEO15C7CIi2esoFWb/
         sQsFxqN/OcCDhNz0NquelPFLfweCkcYYiIq1s5b+Czin94uMyLkB6ISh2EAqn3R6pm+V
         pszFd8XSEiHlWLboWEFI02jxHXjfxDUHeadjWzv3cOavlYlSNigl1pI2LkfygjFht69J
         J+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FDZp3fOc3LrdgTOKImHjjFn6J4UWMtAmT18X4SkeIFE=;
        b=BYUAziIYjLl5lPr7FoCOYn8p4NrYJ5SwqoZP9/T3Y4hjeDpyKyaFgrIB+FaEUbG3ui
         1jAybWd36ORLh4sce+ZRtIAbk2wjsEznXfyhLbs1vwBleOusXx64C/9d1F7bOhUBuf+z
         gYeH76YkJ+VrKryZ88C+6n1Z/tTmtSb8pYJaC08HIMTpBvGS13+NMfFr6xYb0l8RzEUx
         69jXhD0Y6L/5PVtFOnD4zpRZ893X4/oDJolGjk0DkluyHOzDWqchwTFM+gERG7AekehJ
         3TUMqbL9rAfI/BqjRjep0zmnVXkLAXdpNvxqIHWhEu9KAfv5HxLfnfJ0vYgl4NmcBuhm
         4wUQ==
X-Gm-Message-State: AOAM5315fRihb6EvsQ0iltJ++DYk0R0yEg/6xauUuKA8PKeOGuN6S1+5
        uk0tOxouCbYAbKXeC1630fM=
X-Google-Smtp-Source: ABdhPJxmgCa13Bf9bWFOxBTU0/KQJ2ApuJhVbOHB/t/ytyCjfQE/Gy5qpDYL3UgErlSNW5hEmK8bJA==
X-Received: by 2002:a05:6000:2c8:b0:210:ddd:170c with SMTP id o8-20020a05600002c800b002100ddd170cmr7157336wry.338.1653681380473;
        Fri, 27 May 2022 12:56:20 -0700 (PDT)
Received: from jonathan-ubuntu.univ-lyon1.fr (123.79.195.77.rev.sfr.net. [77.195.79.123])
        by smtp.gmail.com with ESMTPSA id 129-20020a1c0287000000b0039748be12dbsm3041350wmc.47.2022.05.27.12.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 12:56:20 -0700 (PDT)
From:   Jonathan Bressat <git.jonathan.bressat@gmail.com>
To:     git.jonathan.bressat@gmail.com
Cc:     Matthieu.Moy@univ-lyon1.fr, cogoni.guillaume@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, guillaume.cogoni@gmail.com,
        jonathan.bressat@etu.univ-lyon1.fr
Subject: [PATCH v2 1/4] t6436: tests how merge behave when there is untracked file with the same content
Date:   Fri, 27 May 2022 21:55:42 +0200
Message-Id: <20220527195545.33984-2-git.jonathan.bressat@gmail.com>
X-Mailer: git-send-email 2.35.1.10.g88248585b1.dirty
In-Reply-To: <20220527195545.33984-1-git.jonathan.bressat@gmail.com>
References: <CANteD_zD9ViBi5woHycU_CR1rJcv7YjKDFDiKTA8de04yrTs5Q@mail.gmail.com>
 <20220527195545.33984-1-git.jonathan.bressat@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

add test to show explicitly that merge doesn't overwrite untracked files
or unstaged even when they have the same content than files int the
merged commit

Signed-off-by: Jonathan Bressat <git.jonathan.bressat@gmail.com>
Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
---
 t/t6436-merge-overwrite.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t6436-merge-overwrite.sh b/t/t6436-merge-overwrite.sh
index c0b7bd7c3f..bb323b1ee3 100755
--- a/t/t6436-merge-overwrite.sh
+++ b/t/t6436-merge-overwrite.sh
@@ -204,4 +204,38 @@ test_expect_success 'will not clobber WT/index when merging into unborn' '
 	grep bar untracked-file
 '
 
+test_expect_success 'create branch A' '
+	git reset --hard c0 &&
+	git checkout -b A
+'
+
+test_expect_success 'fastforward will not overwrite untracked file with the same content' '
+	test_when_finished "git branch -D B && git reset --hard c0 && git clean --force" &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" &&
+	git checkout A &&
+	echo content >file &&
+	test_must_fail git merge B
+'
+
+test_expect_success 'will not overwrite untracked file with the same content' '
+	test_when_finished "git branch -D B && git reset --hard c0 && git clean --force" &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" fileB "content" &&
+	git checkout A &&
+	test_commit --no-tag "exA" fileA "content" &&
+	echo content >file &&
+	test_must_fail git merge B
+'
+
+test_expect_success 'will not overwrite unstaged file with the same content' '
+	test_when_finished "git branch -D B && git reset --hard c0 && git clean --force" &&
+	test_commit --no-tag "unstaged" file "other" &&
+	git checkout -b B &&
+	test_commit --no-tag "staged" file "content" &&
+	git checkout A &&
+	echo content >file &&
+	test_must_fail git merge B
+'
+
 test_done
-- 
2.35.1.10.g88248585b1.dirty

