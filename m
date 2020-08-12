Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5714EC433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 357F320838
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSqHmyrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHLT15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLT14 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 15:27:56 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6ACC061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 12:27:56 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u20so1534834pfn.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 12:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+43AKhSetU4Vypt4DeZDZpS6+RsvVHmgvJZtbi/Z+/M=;
        b=uSqHmyrvizW45HdhiAU1Kmj5yumIh1ua+7qKzSy00+E0WuJ0blcrXIajbGVhEMNOZx
         0XI02XRFnt+qfXfz4LExIzq4Z41Bc9VFxC+A58aoGNH5H1/W35fm338tZ+yp1eaczRK+
         BgKEgUrUR9Ij3KlXqCB/d5CpHhABru0+jq67X/8Hzudm7fIEyzYcVt2OnAHgKs5zy00F
         wLc8RHUpLoN3yPV5sOAoIJAz3WwbHcRSgUzI5IA5Cr5bDe75g7gJY2K/+dbJD/J9vztf
         zJ9kHGNY/rLCEVEux3iwul45FrHDycU3q8hCiXI3FjFyHKkDfIUSTc0PF5okw/SpH08k
         ySLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+43AKhSetU4Vypt4DeZDZpS6+RsvVHmgvJZtbi/Z+/M=;
        b=uXXKED1IAHf8jg98pHgSNd2vRPIpdAul5NZ0kNTvSbxr9VLfKbJDp3p+Wr2emBenvY
         UIZ4PZvUPx+/Y7rmQ2jSBT8OAoGDi53gX24ABWsp6V9N7kBSS57hovrbpUbQIerEptgW
         YXZxchKaBc1mpMtsu4rZeAL2EjrGpw0uCWqD+litYUygXTh6E+mwfr5xrek6RVDH+ZmF
         z5yV4RJxfoPxwAidqOujy9wTJGPfxqlzKlFxyYVjVytmZnrVLT7oHojh/JdmlJqMhpmF
         xre9OIxUQTAx9SEojrEr2veDlN9cx6mHqgfKp+t4Y9722aj6x/Fzl6GSu10ZD5WG1nQF
         jTNA==
X-Gm-Message-State: AOAM532YCcrVzIYBdhpUgtRnuk/MY0kpw4JgSDK9K8AYHN5tLQ3Ba+4Q
        tLhcu0SHzlaTYcXH2DzepYg=
X-Google-Smtp-Source: ABdhPJzF1LgEFKM0INU58ov2r0utj00XmYHg5juV6Uhu4jd5bP37YzFDi5tcd5eo7UUDP9JrJuKmHg==
X-Received: by 2002:a65:6212:: with SMTP id d18mr550787pgv.402.1597260476031;
        Wed, 12 Aug 2020 12:27:56 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.132])
        by smtp.gmail.com with ESMTPSA id f3sm3463334pfj.206.2020.08.12.12.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 12:27:55 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     shouryashukla.oo@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 1/4] t7401: modernize style
Date:   Thu, 13 Aug 2020 00:57:34 +0530
Message-Id: <20200812192737.13971-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812192737.13971-1-shouryashukla.oo@gmail.com>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
 <20200812192737.13971-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests in 't7401-submodule-summary.sh' were written a long time ago
and has a violation with respect to our CodingGuidelines which is,
incorrect spacing in usages of the redirection operator.
Using a Git command in the upstream of a pipe might result in us
losing its exit code. So, convert such usages so that they write to
a file and read from them.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Helped-by: Denton Liu <liu.denton@gmail.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7401-submodule-summary.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 9bc841d085..8ee78bcb69 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -16,12 +16,13 @@ add_file () {
 	owd=$(pwd)
 	cd "$sm"
 	for name; do
-		echo "$name" > "$name" &&
+		echo "$name" >"$name" &&
 		git add "$name" &&
 		test_tick &&
 		git commit -m "Add $name"
 	done >/dev/null
-	git rev-parse --verify HEAD | cut -c1-7
+	git rev-parse --verify HEAD >out &&
+	cut -c1-7 out
 	cd "$owd"
 }
 commit_file () {
@@ -125,7 +126,8 @@ commit_file sm1 &&
 head3=$(
 	cd sm1 &&
 	git reset --hard HEAD~2 >/dev/null &&
-	git rev-parse --verify HEAD | cut -c1-7
+	git rev-parse --verify HEAD >out &&
+	cut -c1-7 out
 )
 
 test_expect_success 'modified submodule(backward)' "
-- 
2.28.0

