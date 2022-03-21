Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C40C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiCUXKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiCUXIj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:08:39 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC9D53725
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u16so21647934wru.4
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V6Fu5zoAqStBiNrOiH0t0MHXRWI/vlh3/Yf2Z58fgIE=;
        b=XVzLzgJNsnM32JzBiLABDNCZM9dWUMngSe0haXl3Q7NFT29yzekb/xLgRvuVHVsVVd
         Hip4fDj8ZRloR7ghxfFfRLEgU6Arq1yvD22ggyvc924OGkHp9Y/Elf5xZPjqWJZpppyF
         U/eYB2fGA0ceiAHFH3JnEsNrODkc6uJot5g3Z5aAdSy0rm5irvvAv8+IlzOQdYFxi0XV
         0XJdmHnB3jWz0h95tcpFr/8eGlZT307u1AKo0FfdLeCPF7Y8hmhb3S6qm7O6mQBuq6Wp
         qXUv/vNADjHtMQrYcoYf+Cirb3Nbfnmt6qeTHgmDZM0VXKkaKmbZbh3FIXM9qH5QVt2F
         71wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V6Fu5zoAqStBiNrOiH0t0MHXRWI/vlh3/Yf2Z58fgIE=;
        b=lPDXQ+O682VIxDhuihVqHsdaX4ZMIrdXwUWXjgbCEvvwujcXRVHtaoSgR6+Cw0q6O9
         6MJ4whDdNSQ7YijXm5Ojl6eVSTGx68kvxp9rrH6DR8aYliiq/iQPKoFtsRkiXoRWqEUf
         eIZX9GPucJxm+43X2B7WFRu+NsvKCDHeXTJkc1UEa50AfjK/9RjIakNIO7ZQKrNfpHwL
         VWlxeM3o1lU3s8qtRT31eY56OqhYSJ+CoIbXQqUyQF8G5gYU5F4UkmJOVUjgu4hwYJYJ
         7Sm9J5IAXD354Zia909BhsRTo+5bLVIerUBCObL2m4dJP7+hRxVSXjZ7EmG49ihki442
         /RfQ==
X-Gm-Message-State: AOAM533JpfSRp79DGIsv7wd54QfCLdJ/GjnbYcpkWm/mlwHghTb9oKzs
        RyK1Q6SuZM6MH0YG6jBjp7l2JKkIrXY=
X-Google-Smtp-Source: ABdhPJwLdvEUrwiAos+/k8Zo9MVrLMgAT9awX/j1PpvQMDpJPFGlC1g/Ri+O4L7wIh8A8GQserXiXw==
X-Received: by 2002:a5d:43d2:0:b0:204:5f97:d003 with SMTP id v18-20020a5d43d2000000b002045f97d003mr797192wrr.417.1647903358863;
        Mon, 21 Mar 2022 15:55:58 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:58 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 20/41] tag.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:02 +0000
Message-Id: <20220321225523.724509-21-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/tag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index e5a8f85693..55a808873c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -315,7 +315,7 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 		if (launch_editor(path, buf, NULL)) {
 			fprintf(stderr,
 			_("Please supply the message using either -m or -F option.\n"));
-			exit(1);
+			exit(EXIT_FAILURE);
 		}
 	}
 
-- 
2.35.1

