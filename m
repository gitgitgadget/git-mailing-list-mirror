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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98A2C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 19:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9785361103
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 19:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhHBTBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 15:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhHBTBn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 15:01:43 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1C4C061764
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 12:01:33 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id m12so8757799qvt.1
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 12:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5v9i8w99O3J4xy+XDTPHFHRGMz/eNCxKF16mn/hAHw=;
        b=XGIlo/cXBeOOsNduDhOJT+xzhX88q7BFR6O1uL6gUB+irZijybtk8sgiiGrH2lMGDR
         GgSSmRb5Y92TEd25fJ5R3rfLO36eDNqk3EaCDSRZU6uUxKTB2jfe/i8UvGGBw/gxoH8h
         TW5YrqesHJaHwBoJokqnMofvLu+w72CPDxIS0kyLrunZEZ/QP03311ZgpoYAVOEhJXfk
         ZnH/9uaEljzXbvayAZR3gZzIqYayd2mUS0yq3cQn2UG6vGjH2Ey0jKxBaKPKXiAP1mp9
         RfjVkhhDxwsxJVWUai2wQKJbGdnM6WUUaJnJSGTeeHhQdf6cR9Y7+L/WOIOh8Cv+3IPL
         NNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5v9i8w99O3J4xy+XDTPHFHRGMz/eNCxKF16mn/hAHw=;
        b=nUtc1MlXKOmAPdZzdL3ppjgm5vpGBkdzS2er1WTKCRG2SINw7aXXszO8FNVzJdEVy0
         6uyQ+IECsoij0aNu6PLl77xGG5C/5M203pnhQCkSuMcD3Bp4mLpq8ThOKAlsBxM9FchH
         q0AMfl0qqVboQU10RZYXrawftDuXUlIGu7sFys77/YElTpEy8MYFfqQov1J6qRY5qUpW
         oDH+upjDb+WV171Um4hKrwX2lMRhFKNdwf99PJWJbBrHZvIoFlC9rxXT4pYNPN+ZLEju
         8WJ8SiiyUxtKy1I/RBFSbdMkDycA5/85gXaPihIe6VlgVv2IROY3WNNt9TSNY/QIJEJZ
         s5Qw==
X-Gm-Message-State: AOAM5303iMbKv2fOleyVS8p9SFs/L0AlVEa35prQh4RnPTbWPB4Tdrle
        6/9q9BjaC32j35VJ8Si1gExqHZCiZ70=
X-Google-Smtp-Source: ABdhPJzBRxngiEBKuYafAG+HyQRkyj+zSO0s0drzYtq5BECfTmdB3z+BjJy7PmlZqa1BeNPGy9YO2g==
X-Received: by 2002:a0c:e310:: with SMTP id s16mr17852655qvl.10.1627930892665;
        Mon, 02 Aug 2021 12:01:32 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id b21sm4949885qtb.58.2021.08.02.12.01.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Aug 2021 12:01:32 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/3] fixup! Provide zlib's uncompress2 from compat/zlib-compat.c
Date:   Mon,  2 Aug 2021 12:00:52 -0700
Message-Id: <20210802190054.58282-2-carenas@gmail.com>
X-Mailer: git-send-email 2.32.0.826.g286871f41a
In-Reply-To: <20210802190054.58282-1-carenas@gmail.com>
References: <20210802190054.58282-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

124b6e20ef (Provide zlib's uncompress2 from compat/zlib-compat.c,
2021-07-20) adds a compatibility replacement function for uncompress2
that could be used for building with zlib < 1.2.9, but adds it to libgit.

this could result in link failures depending on the library order used
by the link command as shown in (from the 32bit linux CI task for the seen
branch):

  reftable/libreftable.a(block.o): In function `block_reader_init':
  /__w/git/git/reftable/block.c:222: undefined reference to `uncompress2'
  collect2: error: ld returned 1 exit status
  Makefile:2649: recipe for target 'git-daemon' failed

add it instead to the libreftable library that is also the current user.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 94ba729376..d1c2a8acc1 100644
--- a/Makefile
+++ b/Makefile
@@ -1760,7 +1760,7 @@ endif
 
 ifdef NO_UNCOMPRESS2
 	BASIC_CFLAGS += -DNO_UNCOMPRESS2
-	LIB_OBJS += compat/zlib-uncompress2.o
+	REFTABLE_OBJS += compat/zlib-uncompress2.o
 endif
 
 ifdef NO_POSIX_GOODIES
-- 
2.32.0.826.g286871f41a

