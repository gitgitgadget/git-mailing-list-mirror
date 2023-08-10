Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD239C04A94
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjHJVRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjHJVRE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:17:04 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7852737
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:17:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe8242fc4dso4862955e9.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702220; x=1692307020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X27AHtAaaLMRBge6NBtgXIT5pSQ1Or9c6MvqCht4s4Y=;
        b=jOhsOkyS+8Smy/l9Py6fsMt2XNWvIY/ycmvWrn2ZW85JgJ/RTOx5wRAGB0Kjpgh1t4
         grAfLKYrxMH9ReyJetEvT5IE6YL8+oYGU99zVAgHcvEZTI3TNkWWnfdtIf/NlKrRfJSJ
         CULeO9WDTEbeyivrVj2aVDwEn7nfbGtx1+J7aPrh+03u4AgYaw8IodSXrJduSKJ4hHir
         WSSgKm0QWqx7fs3zZkCne/fE9pfAUTH0G8hw8V0cgXD773WEJCxhMxT5cV2rcztW/41v
         38UcxEYLmIrA9gULTxIHeiHhXreq9PLa1WOLOAg3WN/MAykERH0IAfnoEYhQOZAgZJfH
         zKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702220; x=1692307020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X27AHtAaaLMRBge6NBtgXIT5pSQ1Or9c6MvqCht4s4Y=;
        b=ZPdyTmJvEucAYa0aUjN6F/UwDvFVnS4074IgAPAw94poSwCRIMYsl4A5JZ8GSsNGwU
         lZ73sHrLxybbiPGRsgvccGJBGgUitZFfr4qLxN/Z2sItEQhEzg0rGxpt3xLaMmnrXbiR
         2WI+qY67HfSAGFx6yRDpUwDg3EUJF8pMkkZqzc5VFdNOAvlMx+rJ4rhQW0JG8TZ18ikn
         XTfP/bRABx/kvFPN5BX4IgvLSxjUhmX5Gh56xrCK8XraVzVuxy68C7SVlyx6WxFCU6ZO
         nXsAr+sEoLiqgWYn3AdWuJD/NCEqodY8anFYTfkBcpiy6Vxui5S2/rv/cQ2nrWbJfgZq
         PyVw==
X-Gm-Message-State: AOJu0YzOin2MIExnFpPBFH2CMc8lxE+f1EFLn4rllhx1LdG+sqs907le
        XdCbwPnwVH4Tu6KCwcsd1ltFUOiO4kAZ5w==
X-Google-Smtp-Source: AGHT+IFxdgiQhpWnAMR+2sHCQcZtYsyE7Bw7CTnz5DROr+I/p7OljoxOMiqTlpVz+aPL9mnRlnUjnA==
X-Received: by 2002:a05:600c:2909:b0:3fe:2b8c:9f00 with SMTP id i9-20020a05600c290900b003fe2b8c9f00mr61823wmd.24.1691702220306;
        Thu, 10 Aug 2023 14:17:00 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c229300b003fe24da493dsm3169864wmf.41.2023.08.10.14.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:16:59 -0700 (PDT)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v3 1/7] pretty-formats: define "literal formatting code"
Date:   Thu, 10 Aug 2023 22:16:13 +0100
Message-ID: <20230810211619.19055-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.0-rc1
In-Reply-To: <20230715160730.4046-1-andy.koppe@gmail.com>
References: <20230715160730.4046-1-andy.koppe@gmail.com>
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
2.42.0-rc1

