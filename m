Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBD2C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 16:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbiB1QJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 11:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbiB1QJY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 11:09:24 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DD83EA9E
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:08:40 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id lw4so25730318ejb.12
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 08:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4XPJgUzhJnFn2xssXnfA70o4872bTpFrxoFe5AQrZpk=;
        b=b0oE7r2VYVz/S1KEChG19u4GtRaM33+hRlakswDpPpLNPLWuAzRH8Wgai/aT6cun4R
         zG1NDXJqR/CmMb3hvlmm/coHUZNU2W57UP6WYd2re8EyjV3ndzMmansgUUgAvWqjFhBo
         ci7iVXn+shxqNZI6DH5uxezHn902nR7KfRoGsXTxQn+dG2qps4SvEhHOigw51NQmY96C
         DgBqjeOU2BSwvWY0k0+PzZCqoVtZuIsIcWN723Ka6b6MwJxHkd32eWH4dwaQZQXhZ1OA
         xglmSBzXBR6pZ19oxfq1Xdtkr/auAnwu5OCabtQZm+6ZgkY8x7uhKZC5yoFR/0a9xNQt
         pAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4XPJgUzhJnFn2xssXnfA70o4872bTpFrxoFe5AQrZpk=;
        b=OVq5Qcky/7TVrW9pw/AFe/YtfsOlEx7f/u2SvupRArubnm2x7rjHuymsmf0VDev7kM
         5ufKFzl6jXjHf6runCTaizcoBdLkH3JKOZ/YxKbPy7z5jgFlITAIx30PIGft4rBls330
         2sfO+R0pW7TOpD6B5a77w97yPFP66pbdBa4o+YPvVhHoorsd6NrhYmmMe4cWR2+1/Bov
         ThFhI17j/QHRpvJR97zhSRBkpxaUhJVx0cXo+E4RUOJBY4pbdAoSAnJWS9lnwFpcxPLl
         9goY5rpmsQ1ac49tNzh0E19nVcXNmadGejbWMLfn+kNY1H5o1hgtYmLVpo11K1Ct3pb6
         RMhQ==
X-Gm-Message-State: AOAM533idISV/7yT++cc21gJboy0IZeIacpTjk3MKOyG5cIweaSmtsan
        iKbqu0A/QdodGw6WM2yz6h1+CFYBnKY=
X-Google-Smtp-Source: ABdhPJx+dq9wgSBibyY/F4MHO+AHqrUhF+8M8yyPUUVVg2n8rkoUq7Y6TkAmMawYp1bsZeIpl8SQRw==
X-Received: by 2002:a17:906:9c12:b0:6cf:b429:b645 with SMTP id ff18-20020a1709069c1200b006cfb429b645mr16321959ejc.386.1646064518515;
        Mon, 28 Feb 2022 08:08:38 -0800 (PST)
Received: from fedora35.example.com ([151.27.147.41])
        by smtp.gmail.com with ESMTPSA id iy20-20020a170907819400b006d5c6bd4eccsm4457957ejc.162.2022.02.28.08.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 08:08:37 -0800 (PST)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] test-lib.sh: Use GLIBC_TUNABLES instead of MALLOC_CHECK_ on glibc >= 2.34
Date:   Mon, 28 Feb 2022 16:08:27 +0000
Message-Id: <20220228160827.465488-1-gitter.spiros@gmail.com>
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

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/test-lib.sh | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index e4716b0b86..136614ac8c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -517,12 +517,27 @@ then
 		: nothing
 	}
 else
+	if type -p getconf >/dev/null 2>&1; then
+		_GLIBC_VERSION="$(getconf GNU_LIBC_VERSION 2>/dev/null | awk '{ print $2 }')"
+		if [ -n "$_GLIBC_VERSION" -a $(expr "$_GLIBC_VERSION" \>= "2.34") ]; then
+			_HAVE_GLIBC_234="yes"
+		fi
+	fi
 	setup_malloc_check () {
-		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
-		export MALLOC_CHECK_ MALLOC_PERTURB_
+			if test "x$_HAVE_GLIBC_234" = xyes ; then
+				LD_PRELOAD="libc_malloc_debug.so.0" GLIBC_TUNABLES="glibc.malloc.check=1:glibc.malloc.perturb=165"
+				export LD_PRELOAD GLIBC_TUNABLES
+			else
+				MALLOC_CHECK_=3	MALLOC_PERTURB_=165
+				export MALLOC_CHECK_ MALLOC_PERTURB_
+			fi
 	}
 	teardown_malloc_check () {
-		unset MALLOC_CHECK_ MALLOC_PERTURB_
+			if test "x$_HAVE_GLIBC_234" = xyes ; then
+				unset LD_PRELOAD GLIBC_TUNABLES
+			else
+				unset MALLOC_CHECK_ MALLOC_PERTURB_
+			fi
 	}
 fi
 
-- 
2.35.1

