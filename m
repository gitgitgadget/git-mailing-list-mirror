Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17E7C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A87D61073
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbhKLVwA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbhKLVv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:51:59 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D61C061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:08 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u1so17837841wru.13
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xbHVa/MhvYy1JHal39Ydph1ktO0y2K5JNGESoKix88o=;
        b=FSYc/8WJOSdTWrRash3OM1aCtA73oczk8cu2yhUixfGaHMkunvft8KNmum1TABz7EX
         lyKOY+Jnc4ylRh2rJVJ6v2ziEPq3ZuGxNXaauOXUtmxWt+slZhbHvlKXKxRx213gkz5N
         T6vn23jKEdrE4YZtiu74CUfJsc7Pm7QXrIuTISSdygEpAZ9SA+d8rYzMAQlTknUh3nMS
         26Qf5LYBUmlh/OeO569/lmVsBkZSjpwYMQKETH9XPJpba4qXFPDjU93ganNj+05pUtkB
         /3Y7bbDhA46SO3pOz4PycsK9fZPNCgoV/cECkIRHJYsfPCw2sKfpVWFTvrdFs1gyBEHQ
         5iAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xbHVa/MhvYy1JHal39Ydph1ktO0y2K5JNGESoKix88o=;
        b=aGyBuMk97z5vfy6oZjAbSUii05mFZ4Z7ADJVTXdM66kJsCk2LUOOmigIBuB5Oq8NCH
         F8Qu3x8OjaZYAM6v9sukf8468mP1m6wUl3hhFC5zQyH2Q2xXUV4b69+DeiOMci6QlWAb
         d69kXgDVvULD547Ef35uxP6mzSXFhHmkGSW761qWL4LN0eMqy0VByLbZJhscn/mLyqFa
         SvyG1s7nReGWjwZ2mVdQ7XbEoRHXdRVBEeY7mrMG81Ql1marHxyLk+PIW50WMURZoncY
         AEcsyA9kQWEiMxnDY48MMGZyKGebRUKr71Iktlk3cJAOM10VbB0dIHUJZ55S1PoLTSCo
         sPPA==
X-Gm-Message-State: AOAM530/FJW9McMdfUpknFs+5jk3df21DjHciAI70Jsqd7Pa5ESz+5Tc
        g89M1McWFGS+h7KpoiRoqz/ixb8n/5spSQ==
X-Google-Smtp-Source: ABdhPJx6/o76WlGHmO0YIfrbWPTHf8pZeECx+X6WjbWhD9693ltA4Lvi5yTaPeec2V3uZsHAzN61aA==
X-Received: by 2002:a05:6000:1010:: with SMTP id a16mr22122358wrx.155.1636753746552;
        Fri, 12 Nov 2021 13:49:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm14117189wmc.43.2021.11.12.13.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:49:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/18] Makefile: don't invoke msgfmt with --statistics
Date:   Fri, 12 Nov 2021 22:48:45 +0100
Message-Id: <patch-v2-01.18-75ebf7b04e5-20211112T214150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com> <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
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
index d56c0e4aadc..11da97de233 100644
--- a/Makefile
+++ b/Makefile
@@ -1870,7 +1870,7 @@ ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 endif
 
 ifndef NO_MSGFMT_EXTENDED_OPTIONS
-	MSGFMT += --check --statistics
+	MSGFMT += --check
 endif
 
 ifdef HAVE_CLOCK_GETTIME
-- 
2.34.0.rc2.795.g926201d1cc8

