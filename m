Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23702C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 03:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0610C6138F
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 03:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbhI2DVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 23:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243803AbhI2DVd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 23:21:33 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3886C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 20:19:52 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id b16so1054224qtt.7
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 20:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=11CR5UYRWRWc3bPRbplr+0scAh0ANI0GdLzwxqemGBM=;
        b=ErlMODII5omiyDPCdS6PxSz2/trZy/RtzBtNA5BABMc3sJA2nhDOzVDwIYGZNNbxwZ
         SOfteexwS5BUxq7LNp6+JVV0sXU2/zr+sAhxHiEzH81C79jed0Kf0JYasEYSyWaeBPox
         J1voOsOVAXi98oTDGvxFl6Dleu8KCG9+4bsM4CTv6sVUdYq8FnfEmv47R5Yc/gI1Zqmv
         gVq0E7TRmY0KgVimT3pWyk+ctdKuNIOsy/iPf9WR+INnObykniWolgsreTqI/6OT4Q8D
         J/FjqglW0r0PG1Y9o1xyP8b6or2zjXUSiTD47ye0VxP8O5dS+jB8KS52CWEXUjhsT3OU
         OC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11CR5UYRWRWc3bPRbplr+0scAh0ANI0GdLzwxqemGBM=;
        b=vhhuaF+kaoPUQOR+MbOp7BSynF37TBklz7tdC4V1Rl95T9rPxfl7mA+/nWyyITloAk
         ArRqWYHEZPaeP1bI9sQ0444sovXEqLd5hxM6LQcl3M5HZudfNIFAD7l7Oin6Nt57GoMB
         wBDMCWmvHRELTxjNbqO/bGTDjp2o1y0o2bUw9/DHq6sYMMUbuwDTTCcbiFkRyrrmxOVg
         OxY6FbKyNNo6a+LS2VjN/r2QGw+/g4j1t7jo9VkvZ/vQ/EIbgeuc4lth409z+XIpv2Wg
         u1MlSd+YnjFPZbngydhJre08YKk9ceWrcntX9VrTMN/PE2sw36PBAt9W2NbJR5GJVRg0
         ZgKA==
X-Gm-Message-State: AOAM533TDTFfCEk0nKamTEy0abYtJy+oz4uaNaoi6rmbFqg0iRUT7hXI
        /XNVQeau5kViNYpmTwM1BU7L6gKKn211Og==
X-Google-Smtp-Source: ABdhPJw/b8/RRUq9Kx3OEJ/wPOlYBrfmT6c6cPFte9cJAK+Uz+Og9sxBbOI+ZJkuFIDwny/qzkk9BA==
X-Received: by 2002:a05:622a:1350:: with SMTP id w16mr9575611qtk.354.1632885591594;
        Tue, 28 Sep 2021 20:19:51 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id h2sm801350qkk.10.2021.09.28.20.19.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 20:19:51 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, gitster@pobox.com, avarab@gmail.com,
        jonathantanmy@google.com, ramsay@ramsayjones.plus.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v5 0/3] js/win-lazyload-buildfix
Date:   Tue, 28 Sep 2021 20:19:37 -0700
Message-Id: <20210929031940.97092-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20210929004832.96304-1-carenas@gmail.com>
References: <20210929004832.96304-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a reroll of v3, merged in seen at 906546091d (Merge branch
'js/win-lazyload-buildfix' into jch, 2021-09-28) and that provides a
buildfix for a non standard setup found and provided by Hannes, plus
cleanup for confusing issues reported by Ævar and Jonathan Tan due
to the original implementation of cb/pedantic-build-for-developers
now in master.

v5
- remove unnecessary export of a make variable as suggested by Ramsay

v4
- add a third patch based on feedback from cb/pedantic-build-for-developers
  in master and including suggestions by Ævar on a similar patch posted as
  part of a different series.

v3
- fixup to patch1 to help usability and typo fixes from Eric and Junio.

v2
- add a second patch to avoid CI build issues caused by the first and retire
  now obsoleted -Wno-incompatible-pointer-types.

v1
- first patch with a build fix when -Wno-incompatible-pointer-types (included
  with 6a8cbc41ba (developer: enable pedantic by default, 2021-09-03)) was
  not in effect.

Carlo Marcelo Arenas Belón (2):
  lazyload.h: use an even more generic function pointer than FARPROC
  Makefile: restrict -Wpedantic and -Wno-pedantic-ms-format better

Johannes Sixt (1):
  lazyload.h: fix warnings about mismatching function pointer types

 compat/win32/lazyload.h | 14 +++++++++-----
 config.mak.dev          |  8 ++++++--
 config.mak.uname        |  6 +++++-
 3 files changed, 20 insertions(+), 8 deletions(-)

Range-diff against v4:
1:  d2c470f9bc = 1:  d2c470f9bc lazyload.h: fix warnings about mismatching function pointer types
2:  2d84c4ed57 = 2:  2d84c4ed57 lazyload.h: use an even more generic function pointer than FARPROC
3:  a731848d01 ! 3:  0d4f097db9 Makefile: restrict -Wpedantic and -Wno-pedantic-ms-format better
    @@ config.mak.uname: ifeq ($(uname_S),NONSTOP_KERNEL)
      	pathsep = ;
      	HAVE_ALLOCA_H = YesPlease
      	NO_PREAD = YesPlease
    -@@ config.mak.uname: ifeq ($(uname_S),QNX)
    - 	NO_STRLCPY = YesPlease
    - endif
    - 
    -+export uname_S
    -+
    - vcxproj:
    - 	# Require clean work tree
    - 	git update-index -q --refresh && \
-- 
2.33.0.955.gee03ddbf0e

