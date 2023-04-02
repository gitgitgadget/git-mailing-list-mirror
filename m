Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B59C76196
	for <git@archiver.kernel.org>; Sun,  2 Apr 2023 13:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjDBNGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Apr 2023 09:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDBNGL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2023 09:06:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA5B1993
        for <git@vger.kernel.org>; Sun,  2 Apr 2023 06:06:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x15so24812049pjk.2
        for <git@vger.kernel.org>; Sun, 02 Apr 2023 06:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680440769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7cqA6YsMGEWDyNDXBpfSMlxsc93nJ3VFBy8MfeYsmb8=;
        b=pvZ7E/oMSzxGAvwrGn3CL5yat2pHYJQXQNFUqDxY5PqGZKZ0Gmav2tE2xpjcWNAKF+
         kPZTY9H25q+Wt95bevh3dnePYu5Yf9ZGwoTRyidEWalpAyGSWU4ImZQYKj8LcpBX+PNY
         m7zQHrVlwX0CmBQeVIpW1Goq2UMUOml0XlpJ0nI++gO+4U/Kl0KSSaM027k/JzSujOZX
         qGzzOauJmbUQrcBWWQ/I7Hi1oZ4ljlauoh4NEGggB9z2hHi9bsVqmtdeFOArbsYBKzGY
         9OEr1cKHskjZ+aNCvs6yMhUjNBdJ7fR+Dk7Kg7a8dac1gNA4S8iN6G5O6bwwEJaA6Y45
         BHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680440769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7cqA6YsMGEWDyNDXBpfSMlxsc93nJ3VFBy8MfeYsmb8=;
        b=HCLJE378btVO+VnZ0/Dn/bG4XfrxAOqpHs9g9xjJrNK1jshMSI4fytFByLKqjQcnHD
         gjnksvyVe9I5zTygXCWG97/16FxnZdOqqUsWAAhHQvgTxV1wmC1nEw2QXIlxyN5vScMd
         3JxKAQRWYA+CQdWkv6jTU2D3RahsHN6coUBtxK01qIepmtovUXfltKo6zkylF9UHQsrK
         uJ5JQg1a32JFyPH2qm27Ou1k4JsSxjxvOFXhu7yi1FRYHBtFpjUw9IVlh1mmxQYQQFHg
         q+MLB+utaDeLY/NsA1fPpE0jk8uI8F1EHgL8uM2uO/Y10nDYBbRN4s67pOHsMFXv1p6k
         Iy5w==
X-Gm-Message-State: AO0yUKWCVpL4JiCtCpeux+zl+lI1OyPxfSmKUWW8RPooELEQ2yHj7JL1
        kRpkaBA3j6sESFawRTMWqfYgWvy9zlg=
X-Google-Smtp-Source: AK7set/QQyvFSq8ofA3WU7bIkVoEo94JBhQxims20UlbsGfcGKb61130Ccfday/9WZCOKNnHpNCxnw==
X-Received: by 2002:a05:6a20:8b14:b0:da:c40:8d8 with SMTP id l20-20020a056a208b1400b000da0c4008d8mr30753834pzh.4.1680440768691;
        Sun, 02 Apr 2023 06:06:08 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id r14-20020a632b0e000000b005030a00085asm4508864pgr.46.2023.04.02.06.06.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Apr 2023 06:06:04 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Bruno Albuquerque <bga@google.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH] object-info: init request_info before reading arg
Date:   Sun,  2 Apr 2023 21:05:57 +0800
Message-Id: <20230402130557.17662-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When retrieving object info via capability "object-info", we store the
command args into a requested_info variable, but forget to initialize
it. Initialize the variable before use to prevent unexpected output.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 protocol-caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/protocol-caps.c b/protocol-caps.c
index 874bc815b4..94c51862c5 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -79,7 +79,7 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 
 int cap_object_info(struct repository *r, struct packet_reader *request)
 {
-	struct requested_info info;
+	struct requested_info info = { 0 };
 	struct packet_writer writer;
 	struct string_list oid_str_list = STRING_LIST_INIT_DUP;
 
-- 
2.39.1.418.g7876265d61

