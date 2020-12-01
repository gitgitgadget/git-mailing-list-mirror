Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBD0C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 294EA20657
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYOVugDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgLAJ7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 04:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgLAJ7J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 04:59:09 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69349C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 01:58:29 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so1663707wrw.10
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 01:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fxWSFL2TeoyQrYeJ85d37d1Q9Eg/aMMFCk0E1qGBCpc=;
        b=QYOVugDg1aLp6HJu60Z52oFpDRqebYNXYRYH7cDI7Luwv55vGk+b64aEM1+XqN6WCm
         WQaW1wOrnj7V8oiJOSqtVYyVF5MF7ZKT//cD0O/MrGtleJ2oQnQeq0HeMMQjR2A9mgU7
         t9BgDhE0K6fLV9tzjT/uXCh6ZuQNDXB6vYy2/4h8Klphttb2KQJ0c8S947fvDW2MRTtY
         vCHNyFX9dRBN1ZIpT61UinY2wTBugXv/jdm2wlrs8iNrADLyuvevizFwJ6nvJsrwAVvD
         xMs3s+mhl7VQiImGWdTidXrU9JG8qV7XWudrn+aNRGq0xlCcF3KFgdca5npGllx371A0
         6RVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fxWSFL2TeoyQrYeJ85d37d1Q9Eg/aMMFCk0E1qGBCpc=;
        b=HTbWI/jvf01pzk5+e7Bgsg4farZPXNxioDnp/V655lIxSulPR14Sc+Dx1GZGvWIzHr
         vRMk2j+VXFLrGQRcoJCafFRbMTJoswO47ShDXWGnZ8MpvI1qoQiAsWGMluWGQi5zLTaU
         +c5rqEhxJM6Hwy0rm6AZMXybV7y18cydl8H2FsOPLKCE6PxGjxaCmuPrQ7y/pbqLHZTd
         KD3eHoi9ZvmMQ7uH/0jbbcMT6rJVSar5uHAH/4M88CzD2KRtYqdFIvW0mqIWLZTeMS2t
         05bDomPk0exx4Id1+J9hL72Gx/PX+eZUFCKqtb+v+OPyoKB4LtowcgXbfABnUPpjUlqf
         Ymdw==
X-Gm-Message-State: AOAM530i+1qJl4pV2cBGC/ID7rvHdKpg5yaba8sPcybUUPcNldyQiJxK
        eR/QziL09Jx1RF/vDywNBio5d6X4akc2zA==
X-Google-Smtp-Source: ABdhPJzgOJuT51Gy9VKhBBVxowWcQ+Cef3c3PtUVRIOr9nU8UR+PRvKUouiMdkXxTUKY/sL1TknrwA==
X-Received: by 2002:a5d:634b:: with SMTP id b11mr2828948wrw.97.1606816707821;
        Tue, 01 Dec 2020 01:58:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4sm2410985wru.12.2020.12.01.01.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 01:58:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] MaintNotes: use https:// instead of git:// when possible
Date:   Tue,  1 Dec 2020 10:58:15 +0100
Message-Id: <20201201095815.12850-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201201094623.4290-1-avarab@gmail.com>
References: <20201201094623.4290-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change advertised git:// links to https://. These all work as
arguments to "git clone", but in addition they also have friendly web
interfaces.

This leaves just git://ozlabs.org/~paulus/gitk as the only git://
URL. As far as I can tell there's no web interface for it. There is
e.g. https://git.ozlabs.org/?p=ppp.git which is a frontend for
git://git.ozlabs.org/~paulus/ppp.git, but even though cloning the repo
at git://git.ozlabs.org/~paulus/gitk.git works (not the "git"
subdomain) there's no corresponding web UI at
https://git.ozlabs.org/?p=gitk.git

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
Not on top of the last patch I sent (in In-Reply-To), but it
auto-merges.

 MaintNotes | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MaintNotes b/MaintNotes
index 0dc03080de..b52b164e2d 100644
--- a/MaintNotes
+++ b/MaintNotes
@@ -132,15 +132,15 @@ leaking out before we're ready to make public announcements.
 
 My public git.git repositories are (mirrored) at:
 
-  git://git.kernel.org/pub/scm/git/git.git/
+  https://git.kernel.org/pub/scm/git/git.git/
   https://kernel.googlesource.com/pub/scm/git/git
-  git://repo.or.cz/alt-git.git/
+  https://repo.or.cz/alt-git.git/
   https://github.com/git/git/
 
 This one shows not just the main integration branches, but also
 individual topics broken out:
 
-  git://github.com/gitster/git/
+  https://github.com/gitster/git/
 
 A few web interfaces are found at:
 
@@ -151,8 +151,8 @@ A few web interfaces are found at:
 Preformatted documentation from the tip of the "master" branch can be
 found in:
 
-  git://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
-  git://repo.or.cz/git-{htmldocs,manpages}.git/
+  https://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
+  https://repo.or.cz/git-{htmldocs,manpages}.git/
   https://github.com/gitster/git-{htmldocs,manpages}.git/
 
 The manual pages formatted in HTML for the tip of 'master' can be
-- 
2.29.2.222.g5d2a92d10f8

