Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9FFEE4996
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 18:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjHTSz5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Aug 2023 14:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjHTSz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2023 14:55:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E31E2
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 11:50:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fee87dd2a4so8626305e9.3
        for <git@vger.kernel.org>; Sun, 20 Aug 2023 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692557453; x=1693162253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBMBVz9B3urlga6E/UoMxF9IsOvCHCm5LUq29VAOYco=;
        b=SA/TaXUZE2TOeEBCGWSnn1NLG2ebCuhMaYGyBNe/zJZnOCEAlDTvy03XcUkIdn0Ng2
         rmgM4a9SAR9ysEKWQMHgrgxuhu78Spwn/bxat5jzk76ftc/C1vRqFqj0ItG8+94RUl3e
         ZCNrV6Aqe1mtUcLWt1rb/doMojriutwkzyM+XHkAU59vBofRICQIL0X9S4g6RhthIkkb
         GpRCugRPSWaS6oOD2gxlPhTxvDS7pagoC4Ixpb+9+NKW/gwKX6ymBXQrPk5rpxhIJ+qS
         3k20TXTo3F3j3LHuz8e2hTkq95d0fWAyoSCziuv1JpAyvGPxza2bAoX1UtBrH4JYCFjY
         /UCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692557453; x=1693162253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBMBVz9B3urlga6E/UoMxF9IsOvCHCm5LUq29VAOYco=;
        b=A8KVOD53BGHGXw+8G1s+OoXQqckfSERkfhRSET+oW2FxKYpG1453MBHhkH9RKDPWB+
         wq12kyOAvdI2b15U3OLWFam5+B0SP9ZjA+b5HbgPDYE3NanQtcelXXxC8S/hJl6VI4Ao
         Y4Ipqd2KTCREbPz7Bog/SW5qlH0aUykybXBsYH2bCiLI/pPeLEOe8UdUUDllJ0ezRW5F
         ALNV/LgB8fj62VE0o/DTcP7dHlGBlAOOGGxQpAqrFeTVF1m1hy0sHHf9kq7Sh3VNlGVk
         dglxp/yWZAZGgjU2jqmwmbWnpwsxc9Hhs9uB4uNXEueTy8HAuUkhfGzfY4ONLyplouAH
         5cuw==
X-Gm-Message-State: AOJu0YwfY6lWRkBauym8FcPdC2wGS6aqEBLvWohW0waDBI94HgaAbnro
        6N+8X/hFqvcaU/XxZ0NFM6FT+oSUnWVCjEkZ
X-Google-Smtp-Source: AGHT+IEOMw7AhYIsYw97JQe091LOY1zSj+LGvHxDmGL297PMmCHvq0ZEQWaaZBu5msJmwzUxfJ9q1g==
X-Received: by 2002:a7b:c7c3:0:b0:3f9:b748:ff37 with SMTP id z3-20020a7bc7c3000000b003f9b748ff37mr3648313wmk.20.1692557452785;
        Sun, 20 Aug 2023 11:50:52 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c021a00b003fa95f328afsm13603604wmi.29.2023.08.20.11.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 11:50:52 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, glencbz@gmail.com, phillip.wood123@gmail.com,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v5 1/8] pretty-formats: define "literal formatting code"
Date:   Sun, 20 Aug 2023 19:50:02 +0100
Message-ID: <20230820185009.20095-2-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230820185009.20095-1-andy.koppe@gmail.com>
References: <20230820085336.8615-1-andy.koppe@gmail.com>
 <20230820185009.20095-1-andy.koppe@gmail.com>
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

