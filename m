Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2992FC433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiCUXSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiCUXSH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:18:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB5637BE5
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:07:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h23so22064971wrb.8
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GxNPTjgQHWTwR4HeroEcCjNYl9gHKMxMRyU9DkdOhD4=;
        b=PAwrvYgkLop/xJMr2nAKAs1/sGFQNwt5cRU+080aX15I9axRgpbRzkyqR2KPdQ0pM7
         9m/uNR61PHLGBs66lZn6IZBFon+6Ii2hIwvnk2JHJA4zIy0tsev1/fLjbmMdPW03mR3V
         a1viuFcaHOuK9L7O76AVsP/Gwgo/DUmJEW8yn9UCOZLUwLmtpmeglsmnAo4+3sUim+SZ
         oKJhJiQWFpWdri3K8/9UMsaIqtXppz2rCwAwH29k+5C0cd49TL45gYMkvVw0raX4/IbW
         6IRx8pOR31xvKBS1DjpJH+LqGTX4sGLNB07GtpF8xUbqCBZEsn4+NloFD64K9pgBmsLf
         4KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GxNPTjgQHWTwR4HeroEcCjNYl9gHKMxMRyU9DkdOhD4=;
        b=P7zXQHcF5b0sAdb2clBowbHbsgGqbPJNfH7E5DHFIaQ4MWELjdLgx7iCeC7EN7N2HF
         X4rOaa7IsSU1zCA25IZrYTfz0D30wej9znWHdPmbu0bvWyad3m8i0ulFKsID4jC6QIl6
         KhI1rcqURy633aI3Yhkf76jOrwNlYvsK+erdLGGeLpJl3kf0qYslWSFTp+Bf6/myGzLn
         +WwBigHLEdml6Ny+MryDRZ9XKFh7XCQlQidFAQxSw774Pf5xr8h3U5f8h4UkcN+DO9VS
         W2QZPg5ooBBVjhNKAoIQb14uLXZcikfFWYAVqwJYQraSlQY1rJPHotn+KMsM0UfNuxT7
         +2ag==
X-Gm-Message-State: AOAM5311+RVoyxnrR2Ocq3A/8+c6eySE9+bq+69paOtOpclX/xWVWzNG
        RB7O8qzTR+w7grTjhX/pYXxPIfvXD6E=
X-Google-Smtp-Source: ABdhPJzq2DMd0ElDKwyvNSb3iYQ35SuDAk4SUOxYSRLM1Fw7Cp5RHBnecVFgXlIQ0Vj5PGRJLcvscg==
X-Received: by 2002:adf:e74a:0:b0:1f0:25cb:3ad5 with SMTP id c10-20020adfe74a000000b001f025cb3ad5mr19773505wrn.231.1647903360589;
        Mon, 21 Mar 2022 15:56:00 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:59 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 21/41] unpack-objects.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:03 +0000
Message-Id: <20220321225523.724509-22-gitter.spiros@gmail.com>
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
 builtin/unpack-objects.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index dbeb0680a5..d5838bfad1 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -118,7 +118,7 @@ static void *get_data(unsigned long size)
 			error("inflate returned %d", ret);
 			FREE_AND_NULL(buf);
 			if (!recover)
-				exit(1);
+				exit(EXIT_FAILURE);
 			has_errors = 1;
 			break;
 		}
@@ -435,7 +435,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		error("failed to read delta-pack base object %s",
 		      oid_to_hex(&base_oid));
 		if (!recover)
-			exit(1);
+			exit(EXIT_FAILURE);
 		has_errors = 1;
 		return;
 	}
@@ -482,7 +482,7 @@ static void unpack_one(unsigned nr)
 		has_errors = 1;
 		if (recover)
 			return;
-		exit(1);
+		exit(EXIT_FAILURE);
 	}
 }
 
-- 
2.35.1

