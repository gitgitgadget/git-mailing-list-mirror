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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC5CC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5678161249
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbhDLLJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240014AbhDLLJk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:09:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0FAC06138E
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c15so3526032wro.13
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9yRM16telXossWOvLEumw2ekaxhD50TlwIrN6qhLl0s=;
        b=mPw0NJ3qdYOEJl+Y1Z+tZMBlcdFD45hVZJLi/O0FnDUa2EQAXXmN2guVZpB6+U5Ow0
         /A7l6qvJ3KbEoXKndRe7ZFEhsabCL3qSQJNKo8CHR9vLE47iSSzbJ84kHtG8cVZmdWfp
         i22IDWI4aXJPGNe6rP+xFGQ9YDVpfXjAO1JQE31HbFEz0Ul1LqxV5hWIqWhBD2cr+8RZ
         TnTFgL8C414oe9pjwZ31Rg6l8LddPTEiBiiUnm9bMpkhCI1fuNnnfKEsEA4PZXpH9/LC
         dW0U093pUKUJqdknFzseqYO8EWj0eb/oiAkAG8b+zU+/wWgYPgxP4NQSwMvzIzawPKCM
         WOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9yRM16telXossWOvLEumw2ekaxhD50TlwIrN6qhLl0s=;
        b=um8pCGG8VKcxiyDp+ulq5HEd3t1JwJ1rzusn78dYorplpSh8/DCnDxac7eewP0C1U7
         YCi+5CCJkcj2Si33yBCXBNsWQ3hHSdsyNRW0Hs+YxiF0NL8H6aZoK6H/q1RpvRqZMASb
         Q0xvu+MCi0KIh7LfbIZihv73D7a/P5jeJL/EZ2DUm907RWPLlZUUTMnWgq1pJ1ze1+/Q
         lxOoJ66KXyQ5pt7XwoSf39N2flvL9XezsLwckXAb+6eO9y2n+btvYJ4bE0jFeAY9/Q/+
         QiVCO306S0AD9eTuTL15ESEBIGlmwZO6oYqYEAEH/fq0/DCiXITo9wO8xiYPAmIEEX9s
         iGzw==
X-Gm-Message-State: AOAM532Heaj+czjEmTTYB+sdlLwOpcTwawC/oF7pZYgUpJubsPHpz1Yy
        7WU659s7ehKZIQ8oT0yWhO4C9tspsJq8YA==
X-Google-Smtp-Source: ABdhPJzQQh45fhP4PCHiUfpbDfWn3lLoew3vyrdQKl3zKaVJ3Fh20W5/1YmNm+x/cngdzVDzw/ULRA==
X-Received: by 2002:a5d:4691:: with SMTP id u17mr12673201wrq.22.1618225760650;
        Mon, 12 Apr 2021 04:09:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm18158744wrh.91.2021.04.12.04.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:09:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/16] test-lib-functions: normalize test_path_is_missing() debugging
Date:   Mon, 12 Apr 2021 13:09:02 +0200
Message-Id: <patch-13.16-0813aa8e34e-20210412T110456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the test_path_is_missing() to be consistent with related
functions. Since 2caf20c52b7 (test-lib: user-friendly alternatives to
test [-d|-f|-e], 2010-08-10) we've been ls -ld-ing the bad path and
echo-ing $* if it exists. Let's just say that it exists instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1258329fdd8..2518a9b8274 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -811,12 +811,7 @@ test_path_is_missing () {
 	test "$#" -ne 1 && BUG "1 param"
 	if test -e "$1"
 	then
-		echo "Path exists:"
-		ls -ld "$1"
-		if test $# -ge 1
-		then
-			echo "$*"
-		fi
+		echo "Path $1 exists!"
 		false
 	fi
 }
-- 
2.31.1.634.gb41287a30b0

