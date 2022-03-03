Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E8FC433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 09:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiCCJHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 04:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiCCJHj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 04:07:39 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144DB177757
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 01:06:54 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u10so5082849wra.9
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 01:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M8cNtToYBvXp3USoJ7DoBE4Q5QaKZUsmmPZAzTnljf0=;
        b=Hzh+BlYUMOTPcBOF3sh8Eg282dmyZ4N1O10XuT8kzbrqJ6Tsah8yxU4d9qzQfzw+C+
         asbWHTzz4zSKddfW0MsBBL9zN/Lre6ZwroFPh6Z4I3YDTHuY0eJODXg366h4INXPmL58
         EbhiVz+HEHp1e9NmIIH4UBUhva5sNpHJTR2GqCt9IUX78GU6nHn83xRgjQ3dibbW5cqX
         VJ3mkyPsxoDz3iAeNphHG57YaWhsJ1SzMNFhzC86kJNfvKxQxhPqdjGIMMenZEyyZzxt
         kZd1ynILxqrPri2gnAKK+PxhP/aZ1dh/67a8yB3z83BrO1Q5ajNJ1qj+3vooXQ/6QRTh
         kqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M8cNtToYBvXp3USoJ7DoBE4Q5QaKZUsmmPZAzTnljf0=;
        b=KhVEs7qViXGYnTqvCesKFGTdMk0KC3coZXC3iPlGD2MmxUY10Tdebe0yZJ97/J0uuc
         zwUkesA0TF1fTbjFqLo0Z0/wDw6P+VQAPFcAfnwcFK1MXp5sLW4NAngiqoXgNPUS6EG9
         DUWVVLs2n2NMb+LUBV3Nd0p2/+6n4MRKJJOrwKpICoWcgkaujnirNWAwA5WpQpQnIYgY
         dVXKROCmGokR0U2TUn/sKb/0g9gzCTEOLbrmyar77pDdFTGt6Zbx4q4zmbilA2MNstdF
         v0UFJn+PCeXYXM9GyXzaVlLpOi8DukEDv2pngmQZWmAPRzkhjgfayW2bxyjCiz2k9vc3
         YLFQ==
X-Gm-Message-State: AOAM532POVzvRfVgUhKGpmhJk0oZriTgpIRFjqidW3MtV2VXIhDKDQs9
        +sC57xwpwiR7VGJpm1pftow2tjyul4k=
X-Google-Smtp-Source: ABdhPJwpTnFZ4hp+4/WTTIBIreQ3dteOU7DDAYo9ryzyqDQwS+PX/XVACf+xihsBq7xl+xxRIRgbTQ==
X-Received: by 2002:a5d:4dca:0:b0:1f0:2543:e10e with SMTP id f10-20020a5d4dca000000b001f02543e10emr5851347wru.60.1646298412155;
        Thu, 03 Mar 2022 01:06:52 -0800 (PST)
Received: from fedora35.example.com ([151.27.250.17])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d6043000000b001f0247bbdf7sm1419496wrt.64.2022.03.03.01.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 01:06:51 -0800 (PST)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH v2] test-lib.sh: Use GLIBC_TUNABLES instead of MALLOC_CHECK_ on glibc >= 2.34
Date:   Thu,  3 Mar 2022 09:06:40 +0000
Message-Id: <20220303090640.190307-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In glibc >= 2.34 MALLOC_CHECK_ and MALLOC_PERTURB_ environment
variables have been replaced by GLIBC_TUNABLES.  Also the new
glibc requires that you preload a library called libc_malloc_debug.so
to get these features.

Using the ordinary glibc system variable detect if this is glibc >= 2.34 and
use GLIBC_TUNABLES and the new library.

This patch was inspired by a Richard W.M. Jones ndbkit patch

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
This is the second version of the patch.

Compared to the first version, the code has been simplified, based on Junio's
indications, introducing some redundancy in the setting of the glibc variables
covered by the patch
(https://lore.kernel.org/all/20220228160827.465488-1-gitter.spiros@gmail.com/)
 t/test-lib.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9af5fb7674..b545013a14 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -548,11 +548,32 @@ then
 	}
 else
 	setup_malloc_check () {
+		if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
+		_GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
+		expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null
+		then
+			USE_GLIBC_TUNABLES=YesPlease
+		fi
 		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
 		export MALLOC_CHECK_ MALLOC_PERTURB_
+		case "$USE_GLIBC_TUNABLES" in
+		YesPlease)
+			g=
+			LD_PRELOAD="libc_malloc_debug.so.0"
+			for t in \
+				glibc.malloc.check=1 \
+				glibc.malloc.perturb=165
+			do
+				g="${g##:}:$t"
+			done
+			GLIBC_TUNABLES=$g
+			export LD_PRELOAD GLIBC_TUNABLES
+			;;
+		esac
 	}
 	teardown_malloc_check () {
 		unset MALLOC_CHECK_ MALLOC_PERTURB_
+		unset LD_PRELOAD GLIBC_TUNABLES
 	}
 fi
 
-- 
2.35.1

