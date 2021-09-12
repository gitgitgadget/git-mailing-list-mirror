Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD084C433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 20:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B292261050
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 20:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhILUag (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 16:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbhILUa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 16:30:29 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE66C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 13:29:15 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id p2so11429129oif.1
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 13:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4XFtO4rfgFN8kQALf8OlEda79nvLwivi0RNh2hAVi54=;
        b=TjV+crRSDw8ndDI5moOoGHHetIIyutSk4MshZmBdIyhxXdZB9Nghb1yo+4cuKPiyk0
         8Orkz9MD9FL7/aPGKCNFQTiF60508V25S3i5FPdjY3cxczH0PxDf78YPi2o6lBaArk1N
         2XER+6CpimCizpUjJ9gs9FAJdUbZWc3IqXQ+/o1EBELoadSlrfWKOHx0r6ZnNgaBomoe
         9hH361qrqtML41HGKgUqasL7SDxpLQKEWR6FVoy+1X47o9ihZAlGKP1ad9i1no8xCxBx
         8mM32o6wZQufOmATOjTOsvyHjmQWUCrVZ0m1/iUUqXZGodte+tWUiIurhR/eV619xdSo
         unBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4XFtO4rfgFN8kQALf8OlEda79nvLwivi0RNh2hAVi54=;
        b=1OOytm/nYD8J1D/vpLu8n859cTsqRzwLjQ0Mccj5iMkF6iVEmhfSyzAVosPmZuN8sp
         J9oBEvtOguRYDv8VHVH/iZh39jEMeZCSG5o/MhC+Iylx477xjAQR7DJvnao8ZY3FwZKv
         E6438yDSy0iYpN6u0joKt20JRZiH5GUbNWcCLjLL7dWMQrOTu9kUcKaNdMLhNE/qkc0G
         JMwHDwWnJE/UqQzLEatzvChMcOaJNLhktVVhF8/66oRtT8YBLMqsIa3wDK4xxrSBQS4k
         JfrfRuXJUxzHhRGAyCVbaw9G0eXIa74fMmNUp4Tioun/cOdfDDeEmZwYdVBoP9R7m+Qx
         LMiA==
X-Gm-Message-State: AOAM5331QylqJ9gagU+E7lyQCBhn+3PQKPm6WSReQjMfFKptbESyR8Qc
        1PELuSLC7QcoAKPlq9DBcShOPU+SKSE=
X-Google-Smtp-Source: ABdhPJwazgCH6xZPVPPdwlBzfz04neEPl6XQOKsJmnhVcGSZvDZI8mOG230bi0ur4g+A+35JgKVEQg==
X-Received: by 2002:aca:1717:: with SMTP id j23mr5465633oii.43.1631478554237;
        Sun, 12 Sep 2021 13:29:14 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id w9sm1345162oti.35.2021.09.12.13.29.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Sep 2021 13:29:13 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     lehmacdj@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 3/3] git-compat-util: include declaration for unix sockets
Date:   Sun, 12 Sep 2021 13:28:30 -0700
Message-Id: <20210912202830.25720-4-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210912202830.25720-1-carenas@gmail.com>
References: <20210912202830.25720-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Available since Windows 10 release 1803, therefore only added if
not using NO_UNIX_SOCKETS (which is not the current default).

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 git-compat-util.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index b46605300a..6a420d104c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -160,6 +160,9 @@
 # endif
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
+#ifndef NO_UNIX_SOCKETS
+#include <afunix.h>
+#endif
 #include <windows.h>
 #define GIT_WINDOWS_NATIVE
 #endif
-- 
2.33.0.481.g26d3bed244

