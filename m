Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93C3C433FE
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiCUXLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiCUXIo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:08:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AFE217957
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j18so13024259wrd.6
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/cyaSgQCTA5gZ6CvxqC6/5tlKYEYq3tmxpt5d28Uy7E=;
        b=KJUoP7pegDMFLoQEEHhxU3+XokxrnGVSIhmxNE9PE78EN228PfjjboDT2i+IkUX05z
         FrxBnagPsvF8OhUjaHWX1GIEA2H0Nq8iTnvJkESVGKOFqZKt+CT8uRYvDwQZWoBXhdDB
         W8eUxoEsW37WU/5u6uP1a/wVjguLpS5OMVnk5OOr3dzJ0ol3tyHWQbXL358eL1jP9OnV
         dOk3NR8OopbcYL5DnyvXRTuoAV39GPY6Lj38eJWIko1MaGaS+6Ci+HJN3KAdwgcFBRBN
         Ie8Hsk4ZLoOe0EghTTY6Z1iZ3zUJ8PccEvvBja9kc7b9ZmixePLzJI9mQ51b5tjKGgi+
         OAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/cyaSgQCTA5gZ6CvxqC6/5tlKYEYq3tmxpt5d28Uy7E=;
        b=R6SlODtduMK5t9lYa1j2OgxsCbsbjGgbQWm4mOv0BqtIK4+PJGiSTaVjQ8XBHTSu2a
         Lpatz6VTaH6SAuLm/qNpXzbLm0jWs2teslY5xoImYPQYUaOJ0YyOEHBHrG8StGZmgS76
         r9Fj5YW0Qux7BSo0929eXm2VAnLKn82nxaGMHl4xF8hqIJk8dKz3SEWstz4DscrKFn+t
         zpPZ7l8Qeo/a2EixvUdJWOk6o+2p+oTRuWRQWhP9qZlUaCWoJj7MjxVa4WsF+vXnClP4
         Sbglh2C8oKkwKK1ugu16qnTJbmoK3qbJ6xXDLqxaythcnuoU3VKlHfK3H0me98+/EgPe
         2xCg==
X-Gm-Message-State: AOAM532LdIHtv3fGr55tBLe5fjHthNJq2pgHlofgXIVDI0SiOGhE0YvV
        4DCteKhUWVcJBB9V42kskqUJo0X6Ofg=
X-Google-Smtp-Source: ABdhPJydLfIo1G2q/JvrSKpMCUp/KcViIEiH+r9l6Q6LpqFinRiPG9hGrddyPZG3Q0xC4cU6ejFWAQ==
X-Received: by 2002:a05:6000:178b:b0:204:f77:c0c with SMTP id e11-20020a056000178b00b002040f770c0cmr6470673wrg.150.1647903350064;
        Mon, 21 Mar 2022 15:55:50 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:49 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 10/41] merge-index.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:54:52 +0000
Message-Id: <20220321225523.724509-11-gitter.spiros@gmail.com>
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
 builtin/merge-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index c0383fe9df..efa7ceaa35 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -37,7 +37,7 @@ static int merge_entry(int pos, const char *path)
 		else {
 			if (!quiet)
 				die("merge program failed");
-			exit(1);
+			exit(EXIT_FAILURE);
 		}
 	}
 	return found;
-- 
2.35.1

