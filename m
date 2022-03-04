Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112BCC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 13:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbiCDNiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 08:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239725AbiCDNh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 08:37:58 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC751B84D5
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 05:37:11 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a8so17536426ejc.8
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 05:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GPEZOxdOUscwIoyXSkbxLRVSOtDoiLIGmhnGD/WEIms=;
        b=HRM64H6FtrKe6nlLCeTtxGbbxiDmOHzfqY0jt22Nzp6JM0paTUQM2j1wKA8WSfxMxm
         DJka5svp37lUGIZve7k0wuoJIPPKNGalLzkr6L1G7JswGoBhnxD3tPERAfgiCkDG8N9h
         +xg9Co9Phf2WDNsJ4NvA7zcRHEwnm6selajj1OVSg8eZRRFoVUnvQyGuAalGuwH679QH
         Rgi3pWpWunE8vqa/UU3mmh1gqjIskYjx00PiXNNCFGEaltYfmXvTBvmFmNFK+0eactAM
         tSiVxki4B5MZLCL4XyJAJL0kmy7QQ4y29d3aX7r78ZRjJap4E+o8GQ4Fyo07H9rEHuZ0
         y7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GPEZOxdOUscwIoyXSkbxLRVSOtDoiLIGmhnGD/WEIms=;
        b=5hBE+GPaOeC+TpFKYxW4YOFZl1G1BISrSQX0gqg4sq72gAZgBWUgNnPfDmFzsBpIIB
         ggLBTc17JyaankOh2xT9pO+avplKKH56oyiyT5p+GSvexqvmyAL+LWKNyPpJGPxsJdEv
         v1ZZJqAjTYnNG/YhakbHBq4z0veM3eBYcbPpFmgdAZba7Jt3TxrWWLMYoTkfzv7SCk2p
         GZL5VHZFxXOWQi8DvD7wanRQXyMBCn4D6Hn8qPudJ2xingsafLsnALArpslKpDxFQaRZ
         ZQ/oSHB83Z9NYcb058XV7W2FBkrS28/CWXHF0+Ck4Z8/nV/9K7VCrkNfREu5vA2P7RP9
         VJnw==
X-Gm-Message-State: AOAM5310OXGZl8tRNC+0rwnoXabHOqZRUNEeYR5jSQk6V/PsRFtAFbGP
        NqnXPR8qsSsIpDvNStTJ92/WTqqeUqQ=
X-Google-Smtp-Source: ABdhPJw9LDlGjDictjhzGyDic07P6P7FrXvZyo6i4AWGlGsWizn3AHgg4MSJ95GOBJOVdEWXAA4Zbw==
X-Received: by 2002:a17:907:2d90:b0:6d8:9fc9:ac36 with SMTP id gt16-20020a1709072d9000b006d89fc9ac36mr11528741ejc.28.1646401029167;
        Fri, 04 Mar 2022 05:37:09 -0800 (PST)
Received: from fedora35.example.com ([151.27.250.17])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b006ce04bb8668sm1771107ejh.184.2022.03.04.05.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 05:37:08 -0800 (PST)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH v3] test-lib.sh: Use GLIBC_TUNABLES instead of MALLOC_CHECK_ on glibc >= 2.34
Date:   Fri,  4 Mar 2022 13:37:02 +0000
Message-Id: <20220304133702.26706-1-gitter.spiros@gmail.com>
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
This is the third version of the patch.

Compared to the second version[1], the code is further simplified,
eliminating a case statement and modifying a string statement.

[1] https://www.spinics.net/lists/git/msg433917.html

 t/test-lib.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9af5fb7674..4d10646015 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -550,9 +550,25 @@ else
 	setup_malloc_check () {
 		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
 		export MALLOC_CHECK_ MALLOC_PERTURB_
+		if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
+		_GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
+		expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null
+		then
+			g=
+			LD_PRELOAD="libc_malloc_debug.so.0"
+			for t in \
+				glibc.malloc.check=1 \
+				glibc.malloc.perturb=165
+			do
+				g="${g#:}:$t"
+			done
+			GLIBC_TUNABLES=$g
+			export LD_PRELOAD GLIBC_TUNABLES
+		fi
 	}
 	teardown_malloc_check () {
 		unset MALLOC_CHECK_ MALLOC_PERTURB_
+		unset LD_PRELOAD GLIBC_TUNABLES
 	}
 fi

--
2.35.1

