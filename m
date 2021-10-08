Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E16EC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D7E60FE8
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240880AbhJHTKF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240728AbhJHTJu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:09:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E57C061765
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:07:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m22so32769821wrb.0
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D9+X8GbF0VrvBnFc9IdkgfIzIMh0guKLqQ3NrLiZJoc=;
        b=kUIUXn5diKODTRZJOEZvrn3zMYILjRZjqOEMLMa2dvgDfW7AoMVfUX6yZyGoZR21Od
         T9H1NrywfAd9MQrCzeQijNCRWTTcXhgrLmONsKl49QqmVnnJ2X8EQ7th7EEdUbMOt4dD
         uTuVq4ddcNnO9cjMoVpvwYRr/ZN5bfwuISTAI/opT9IGVL01HIxCL628v2H4JGB4VZ8r
         DC/4/9xF+aAdsUmNbbf10/TspPGlJw+qUParvGZwG+3Kj2jvykhF38janqQjlhhgPkXO
         0mihhQimS4mMYVG97nf9Bc7SWDKccTxRzDLdtoFDEoqgZysPWIlMQs+ltboMBt91rYNZ
         cNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D9+X8GbF0VrvBnFc9IdkgfIzIMh0guKLqQ3NrLiZJoc=;
        b=JZwqiwn2IV7LCyzo8FPE++nhH86z+q8i8v9oxvhNTlLILoR0OlV7j8kfUV/Z4/SjLM
         +yz235iDWIWNU49u36RH1V9MacJwkwS9v7U9ZV+fW4HrnG5hN18I10JvVH/5r1rSODFi
         ZWRTawKwCBwv0hwJtBmljNR4K8STnvUEPOGIizkonhkr/IZlnSmFwNgtN2dZ4LDdqYwu
         titijS9CCX1Qer4XHZIk5ttrsuBpDMOkEi6yH4M5J9cuwEWXxNRqBnC8VRNLVRpdutYb
         D5J35JHMpOcq+MQh71OTffQQQlmTbplkPbAA4SuO6JM/67gfYJQK7t96sjyXgz1z/ANR
         8VHw==
X-Gm-Message-State: AOAM533dTWPgWj/noPQx7eMOG3YWOXttaUdKRXWTxZjAW/2IDmU0xJgQ
        Aclij7oFE/Z73X4dQ+WIM2nq9JrT8iMYoQ==
X-Google-Smtp-Source: ABdhPJwee8Q01e/8qqnIpc125gGJmIDDLzrEejXAtCrBTC9JVRfSupNuykTa1mJp/B2GxQy0B4cqWA==
X-Received: by 2002:a5d:6ad2:: with SMTP id u18mr6404075wrw.47.1633720072572;
        Fri, 08 Oct 2021 12:07:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x17sm169882wrc.51.2021.10.08.12.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:07:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/10] parse-options.h: make the "flags" in "struct option" an enum
Date:   Fri,  8 Oct 2021 21:07:41 +0200
Message-Id: <patch-v3-05.10-23e62d4139f-20211008T190536Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "flags" members of "struct option" to refer to their
corresponding "enum" defined earlier in the file.

The benefit of changing this to an enum isn't as great as with some
"enum parse_opt_type" as we'll always check this as a bitfield, so we
can't rely on the compiler checking "case" arms for us. But let's do
it for consistency with the rest of the file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index a1c7c86ad30..74b66ba6e93 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -134,7 +134,7 @@ struct option {
 	const char *argh;
 	const char *help;
 
-	int flags;
+	enum parse_opt_option_flags flags;
 	parse_opt_cb *callback;
 	intptr_t defval;
 	parse_opt_ll_cb *ll_callback;
-- 
2.33.0.1446.g6af949f83bd

