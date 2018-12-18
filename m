Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F20EF1F405
	for <e@80x24.org>; Tue, 18 Dec 2018 07:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbeLRH0A (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 02:26:00 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:37271 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRH0A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 02:26:00 -0500
Received: by mail-lj1-f176.google.com with SMTP id t18-v6so1272859ljd.4
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 23:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wwr9gD7/3GMH8hKiwWfqoGyLKYAmhCZNtWrQ7jYakms=;
        b=Uu1piUxbgUu3gMm9PxIPVqIEa1ilSqpmugAAiCCW2JTKMEtMVAimHYS34DYdxgFEky
         Pxky5wTJc8fG84up4t10oQHNmMk0jQcqG2KN37PLj50+IKWCl17fdoxhkdDU4nh3AzqZ
         YGiBNKkkjd9F+mFChKGagvMIuL7pUao1uoN4dZO/h7J2sKdIWSRQPOsbQlcMayhdV2hC
         jU6iHJBW0zeoEcgY/d2wRtZ/2bOLIl5LOG2ExSxgajv5r+gWI3gEYSnyb18PU8sJn/+G
         nvcaq7naSagYgD2RVOSmI2gFyfEDzY4DJqsEzB1Log1UrihOH9k+v7ZOwFdcpzTe9pwR
         nUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wwr9gD7/3GMH8hKiwWfqoGyLKYAmhCZNtWrQ7jYakms=;
        b=XeBtuizHFzzg8uH8U5b37k6TmXEemD2rAV8TBLNyigybx8fVC4rdOMz4a5pPiCIQN/
         TCNcq/WtmLob6Ta1eNU/AYbBtYP3hYQ5UV6r7mwQUo5qaEqD6vVzUylwoBHbxtkxZ6CH
         TJzIKDZxWBOdotglzP6zOBgdmi6tBXJIEYDR7RDlZ9IokXuC93R5nT9FjOJ9G4ceLvO3
         I8Bjc5ReD0sH5WGWbRmq4joF+WXj5hyBYWaLQdGGosn+qbYBhq5/CVAlt91zq9wJRdT4
         XokJ602sccQyDi4oEAD29IsWiiXW7gmvmf8EmbDzxIi1PzL8obddI8DAdH9rhkfBNv48
         LcQg==
X-Gm-Message-State: AA+aEWbQrKlbCT/YZf/RX7Iw68g+urzhgpjabtNHpJDP27B2G+1wji0V
        3Zi+HG9jQeFx6rHpRc4sPxFEb026
X-Google-Smtp-Source: AFSGD/Xzdr1NZ7DQz/4yKdF29ffSrg2A08qnZp2Q+EOwQax2VneB2ObMJxP7xPCBJhpaYXKqfZXTSw==
X-Received: by 2002:a2e:e02:: with SMTP id 2-v6mr7979893ljo.10.1545117958018;
        Mon, 17 Dec 2018 23:25:58 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id f11sm3142441lfi.12.2018.12.17.23.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 23:25:57 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/3] setup: do not use invalid `repository_format`
Date:   Tue, 18 Dec 2018 08:25:27 +0100
Message-Id: <20181218072528.3870492-3-martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218072528.3870492-1-martin.agren@gmail.com>
References: <20181218072528.3870492-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If `read_repository_format()` encounters an error, `format->version`
will be -1 and all other fields of `format` will be undefined. However,
in `setup_git_directory_gently()`, we use `repo_fmt.hash_algo`
regardless of the value of `repo_fmt.version`.

This can be observed by adding this to the end of
`read_repository_format()`:

	if (format->version == -1)
		format->hash_algo = 0; /* no-one should peek at this! */

This causes, e.g., "git branch -m q q2 without config should succeed" in
t3200 to fail with "fatal: Failed to resolve HEAD as a valid ref."
because it has moved .git/config out of the way and is now trying to use
a bad hash algorithm.

Check that `version` is non-negative before using `hash_algo`.

This patch adds no tests, but do note that if we skip this patch, the
next patch would cause existing tests to fail as outlined above.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 I fully admit to not understanding all of this setup code, neither in
 its current incarnation, nor in terms of an ideal end game. This check
 seems like a good thing to do though.

 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 27747af7a3..52c3c9d31f 100644
--- a/setup.c
+++ b/setup.c
@@ -1138,7 +1138,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
 			setup_git_env(gitdir);
 		}
-		if (startup_info->have_repository)
+		if (startup_info->have_repository && repo_fmt.version > -1)
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
 	}
 
-- 
2.20.1

