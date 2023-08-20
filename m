Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573A8EE49A4
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 08:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjHTI75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 04:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHTI7z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 04:59:55 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA457EB
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:54:55 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so35895541fa.1
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 01:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692521694; x=1693126494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBMBVz9B3urlga6E/UoMxF9IsOvCHCm5LUq29VAOYco=;
        b=Iy8LhJEJeufrFw8MDhnNJwXZ5NdgVrPoyc8UXPdC1oqiNgrwancWvKbko5vt4i08ou
         PVUka08wDK5WXLdVBxRjebJNpFqfXu6d+eyJzoW+6ZrKdS+/6rMiRK5JaKn9e7l8cRxk
         0FiP74E3Gnd4wwUxMtxzSIzpwEt70a0DAlE4f650vN61xbpLVTrel+aomU3JI7WZcP6e
         ecgkx44mHrF0SoDmGZJ6ZiPM/zTrx01PJoYyN9Lo1B3BSkRFRZM/oD8Ion6tvYaVnR5k
         JTffa1flYYUGdZD9C5YVjtTFXOyJAZjtARO5QzaMi1OJSErTpvp96Y0bk/Ff41DTtIv5
         FuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692521694; x=1693126494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBMBVz9B3urlga6E/UoMxF9IsOvCHCm5LUq29VAOYco=;
        b=Q5PQ9uHBhA7i7Jc1xlk9FTqUQxUuInUI4A9/N3bWBBN7fZaP8EQfEM/e4y0BeO3f/z
         x9sJDnK0+2s+hP1vqkakXItF826E2tB9Ks4bv7+pLcy3b/8qoMhSDc/NRqKKoBsQN8vb
         3/iubMeEVvr08ObAhmQwOqSvmxfCqPfVXxql5PkFR5yA0Qzne60dDNNKziNTj2+jRhCX
         7XiZZvDlq0v73aEcwbMy+OlCaJjh9JCn1gQl64gjzezJYNJYboO6CLY0vgHYvXv1m3OD
         vKBALYcnuVWrN+xkaL32zkRooTm1gVCCwj6LwF1JgHsRRN9HUfZ20RpkwEB9MLb16HkS
         DdIw==
X-Gm-Message-State: AOJu0YxjiMBs8rH9NA+Ve09NaF3wNSzG0nbZstdTcCn8gDGEVPbbBTQR
        ujWKv8ZwvrTp5SX9odGDYhMAf2T12G9uO6FZ
X-Google-Smtp-Source: AGHT+IGFxU7Y7hZanoVhc8iH4jMPWHka4JXmTMfHaf1PCFx25OhmZUDhvGXmMyKKNO2zph5FOk3gQA==
X-Received: by 2002:a2e:8295:0:b0:2bb:aaec:abad with SMTP id y21-20020a2e8295000000b002bbaaecabadmr2579804ljg.30.1692521693592;
        Sun, 20 Aug 2023 01:54:53 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id y15-20020adff6cf000000b0031759e6b43fsm8652539wrp.39.2023.08.20.01.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 01:54:53 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, glencbz@gmail.com, phillip.wood123@gmail.com,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v4 1/8] pretty-formats: define "literal formatting code"
Date:   Sun, 20 Aug 2023 09:53:29 +0100
Message-ID: <20230820085336.8615-2-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230820085336.8615-1-andy.koppe@gmail.com>
References: <20230810211619.19055-1-andy.koppe@gmail.com>
 <20230820085336.8615-1-andy.koppe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

The description for a %(trailer) option already uses this term without
having a definition anywhere in the document, and we are about to add
another one in %(decorate) that uses it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/pretty-formats.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 3b71334459..5e1432951b 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -122,7 +122,9 @@ The placeholders are:
 - Placeholders that expand to a single literal character:
 '%n':: newline
 '%%':: a raw '%'
-'%x00':: print a byte from a hex code
+'%x00':: '%x' followed by two hexadecimal digits is replaced with a
+	 byte with the hexadecimal digits' value (we will call this
+	 "literal formatting code" in the rest of this document).
 
 - Placeholders that affect formatting of later placeholders:
 '%Cred':: switch color to red
-- 
2.42.0-rc2

