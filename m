Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FE3C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306E76120A
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhKFVGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbhKFVGb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:06:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E77C079783
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:03:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c4so19507520wrd.9
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o36nbNnPjkn32bBYRlg1pFmUOwV32A/mUDPVyGayCBc=;
        b=jcuZW64OoYrVfaaCi+B9NQyZJ+PhLlhgL6xmr80xclXa+HsPrli5JU9zuhvfZ4rWi9
         43YGlyC0WoBGpETd/PhHAzqZ258nKe0hbbV4r+ds7YUIggwDQcZtkM4TQBYJ/roKEKNQ
         D4a+DC0aeq62vFvcq8aHuiCYhn5i9aT4a+0wW8Sh+elTbeXj4fW1F9SB0gaxfcDxLGXW
         0pLLAEKlg6WmINfH8C4y9Pb2CXVWx2RAD8mqnAzMyPoemXzkJpLWuXYbXZ4vn+M85s7A
         +ogV0wL+bCwjj+VpARSOugQeysfCT+kTjQuFvBl8SIJa3eBv8U8LDcarh0ZJ0IeaYw0s
         u/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o36nbNnPjkn32bBYRlg1pFmUOwV32A/mUDPVyGayCBc=;
        b=rUoQb9MSNEGEc8H2jPUCCQtb07j+Kt9SzUd3aoVjmCo60aCh6VEZdNpPLxUkISnitP
         zULkHOPfZXvbw7+i7ohn1sMYmTO7m+sPMS8CTK05RlE1jtnFnDYP2Xx60zM33+tN6/Jm
         ADD6K7a13hVbgM4AMfd1HRZ4aeS+nfNvN+JonmBL7Ri2Ss5+FKBArtxwTPuAB7wuUvN9
         7t4D5Pk/DuKV5n112FORTwO/LjZvnERUe8YHC5l0jOFnwh8kvEFJ7owI8ILvB1KYhL6o
         cAyHmSdBMzX5nubdUXV4HrtPN3zxISWHmc/JxCfNLQI9cjTFpVGtfgSSwDFmx1zpcR0Y
         y01w==
X-Gm-Message-State: AOAM53038yWhdqc310JCfq34id6NmYnfRNplYQ+LRn88e5SQJn/N5ByC
        pANDHrkepx5i2gZF8RQ/wdVs3EIVKE3W1g==
X-Google-Smtp-Source: ABdhPJxJUqhFVoHFXMclR2nR06ug3lbqjuUBwxKSLO/G74APo81IdZiIfYU54KEk+vMMpDb4QqqMDQ==
X-Received: by 2002:a05:6000:18a7:: with SMTP id b7mr30132071wri.308.1636232613227;
        Sat, 06 Nov 2021 14:03:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u16sm14108433wmc.21.2021.11.06.14.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:03:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 16/16] Makefile: don't invoke msgfmt with --statistics
Date:   Sat,  6 Nov 2021 22:03:17 +0100
Message-Id: <patch-16.16-7f1081651ed-20211106T205717Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the --statistics flag that I added in 5e9637c6297 (i18n: add
infrastructure for translating Git with gettext, 2011-11-18). Our
Makefile output is good about reducing verbosity by default, except in
this case:

    $ rm -rf po/build/locale/e*; time make -j $(nproc) all
        SUBDIR templates
        MKDIR -p po/build/locale/el/LC_MESSAGES
        MSGFMT po/build/locale/el/LC_MESSAGES/git.mo
        MKDIR -p po/build/locale/es/LC_MESSAGES
        MSGFMT po/build/locale/es/LC_MESSAGES/git.mo
    1038 translated messages, 3325 untranslated messages.
    5230 translated messages.

I didn't have any good reason for using --statistics at the time other
than ad-hoc eyeballing of the output. We don't need to spew out
exactly how many messages we've got translated every time. Now we'll
instead emit:

    $ rm -rf po/build/locale/e*; time make -j $(nproc) all
        SUBDIR templates
        MKDIR -p po/build/locale/el/LC_MESSAGES
        MSGFMT po/build/locale/el/LC_MESSAGES/git.mo
        MKDIR -p po/build/locale/es/LC_MESSAGES
        MSGFMT po/build/locale/es/LC_MESSAGES/git.mo

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 141a87371fe..51b9e4b6c84 100644
--- a/Makefile
+++ b/Makefile
@@ -1869,7 +1869,7 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 endif
 
 ifndef NO_MSGFMT_EXTENDED_OPTIONS
-	MSGFMT += --check --statistics
+	MSGFMT += --check
 endif
 
 ifdef HAVE_CLOCK_GETTIME
-- 
2.34.0.rc1.741.gab7bfd97031

