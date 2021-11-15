Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C9CC433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F32E2610A8
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352057AbhKOXU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352953AbhKOXSb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:18:31 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30341C03E039
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:44 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso893009wme.3
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YHG8vHfXJq7DpnVgTeZ86bMfzgET1R6lxHitw0NLfj0=;
        b=kMq7HK9fDDZ3I9dl6MGl5sGuC1SOmEIqjx42BsP0STd53Y5XvrKIseeD/hie99VR03
         Az/uj0/6Rq04OfBkcSgZzuwWeWjPByiYJ/OJIrn+605gFveoVf6xG/cBorm5bHv+BT0g
         5brECJjrGouvdywimXrSwOMmw2US5qnZjCdgxW4/z4Wpa3DjkQ+wMtOtYdXd/ErTm/Zc
         OLNr64QuQwuzJhd+uSui3xMVikyE3VTbRQ+/g6tvQwyQSOrHS1PSw/bT9eiMpVPLxBNf
         Gp6DvYWsNKUlxSsvp+/KMBtzUxLffz/kwg+5b450UtKzCIpFXEpTxBflaM4WxNu2HM7T
         jn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YHG8vHfXJq7DpnVgTeZ86bMfzgET1R6lxHitw0NLfj0=;
        b=5C+pcvfYih4ExB1qJ47lPw2rTxS1MeRqzDSleRX+lJtMy0gFVJJvwd1gTHz3wHmBP9
         cMaCkA496/BCwxcG6ap5HPiWxhjfZHfHA4xR1EhquGcC4KzhR4uG6K2ihiG4i06tszmq
         4b5VPXrXvDF5iEt4PzCdS4Lwxp5+ECroxCQMl5CVO6i3cr0MnmNwcZPOi4PFdPhoT8WJ
         iLse9+/1sqMCEoWvXGQW21oZG7GNyTOeliLeVLSxqozBH+gCXS19QMsNaHBEQa6H9sU8
         PgJUCjzi3OExLvqx6+uAkDjfn28hEYiSGcka0cw08mUsxeGrq93b64Y0MzN3RukGj4Ew
         ujfw==
X-Gm-Message-State: AOAM532pMc+XPlVQoBRy2g4MgCPim6LVKOHe3pMyaR0PHT8/SBYc90wO
        Xs2BtA+tNPyImBZhE9ESQCxiyYhA5aKzeQ==
X-Google-Smtp-Source: ABdhPJy9x5kg95J3lQn01Fe+k7kC729AFRsz7rbKZ9Cpk9Dr/8sP6SUiUtu+SgfD9vxsXtrMorf5QA==
X-Received: by 2002:a1c:4306:: with SMTP id q6mr2100515wma.29.1637014722616;
        Mon, 15 Nov 2021 14:18:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 12/21] pack-objects: use BUG(...) not die("BUG: ...")
Date:   Mon, 15 Nov 2021 23:18:22 +0100
Message-Id: <RFC-patch-12.21-2507ea71700-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change this code added in da93d12b004 (pack-objects: be incredibly
anal about stdio semantics, 2006-04-02) to use BUG() instead.

See 1a07e59c3e2 (Update messages in preparation for i18n, 2018-07-21)
for when the "BUG: " prefix was added, and [1] for background on the
Solaris behavior that prompted the exhaustive error checking in this
fgets() loop.

1. https://lore.kernel.org/git/824.1144007555@lotus.CS.Berkeley.EDU/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1a3dd445f83..0b1f82cd3ad 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3397,7 +3397,7 @@ static void read_object_list_from_stdin(void)
 			if (feof(stdin))
 				break;
 			if (!ferror(stdin))
-				die("BUG: fgets returned NULL, not EOF, not error!");
+				BUG("fgets returned NULL, not EOF, not error!");
 			if (errno != EINTR)
 				die_errno("fgets");
 			clearerr(stdin);
-- 
2.34.0.rc2.809.g11e21d44b24

