Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0078211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 18:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfANSfM (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 13:35:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44914 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfANSfL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 13:35:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so19932225lji.11
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 10:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o0VIYgX1c9jC3smjGNXEBNkVwQPlGBUU5SeAS4NKSa8=;
        b=MXhOufAFeVlOXBufhPrtR6E6aaMnzQUsHm5SSxjCwIAHV2mQs67Z6UWE1zWTJnQTlx
         uhjJmwD/kb3aqBLZjgbdTNOEW8K9brlLQMdkZTxiQ0jO1tcBk1fFjN1SrYhQblRxkrbD
         X8cLa7g/CfAmwN63hPwY8RHdGtw7Iyks7b8c1pUZbCXX6ymUk1gRo6XqCcQDbTK0NkML
         a0k2sgbW+dRzdlG7IbDCzHObKF/hVVHvHacaKxOao665NErYLMMpbgNlLXkKO2Y3nTMa
         4lXOlR7crHFug9aFim80OIAw2mNDboYxKEhZu64ROy6bFrlwkwEMJv2HcjOz/lvopMBK
         awkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o0VIYgX1c9jC3smjGNXEBNkVwQPlGBUU5SeAS4NKSa8=;
        b=WH5h7GpkKtrlCcDnKQZTxrxUV0eXKucJhNvZdP7UAluqT3gsdYwFF75SZVd4y6UBQ9
         svmt0hjdLqR/pbYx5ueww+wYg6jnOM+iGQfWWTkOa4W2x7OY44E6qF7WtQAc5hhygCMu
         uK9OglHs5gWyJJXOmZqsLhRqJhbFTZnkaSvXzUYz9KI57xk9frtTgF/EDwbocIcTH21S
         PifDEUz2HyzR+rD1CkXYsQGripXC8X8UQCK7tVI0Qnn3BpxCZ1Apkz4Vm7rSbwnJysKw
         RvqyQHXkObD5VRgdwP5dizwAac7TEdqWAaB3aLDZDnbaMNAoTTOqQVnG3vkz83OKDcI9
         TkWA==
X-Gm-Message-State: AJcUukcpW0K1ZMeGKQIo9kJwVCrZweQsPOeLucptUiuuXV92PQ5IGfXd
        PrLtUQfY2HCv6VhtzRY+eW3+7WbP
X-Google-Smtp-Source: ALg8bN7GpHTF7obdOJueW4mS0Rs9MJ5GP9QPmS/sBjiKXw6wgODjKyILIeyZM4pDxms4iP4CcArrzA==
X-Received: by 2002:a2e:841:: with SMTP id g1-v6mr252354ljd.21.1547490909151;
        Mon, 14 Jan 2019 10:35:09 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id x24-v6sm224492ljc.54.2019.01.14.10.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 10:35:08 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 2/3] setup: do not use invalid `repository_format`
Date:   Mon, 14 Jan 2019 19:34:56 +0100
Message-Id: <a7e58385290e6789105d2d5b794f4bf8607285dd.1547488709.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1547488709.git.martin.agren@gmail.com>
References: <20181218072528.3870492-1-martin.agren@gmail.com> <cover.1547488709.git.martin.agren@gmail.com>
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
 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index bb633942bb..4d3d67c50b 100644
--- a/setup.c
+++ b/setup.c
@@ -1140,7 +1140,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
 			setup_git_env(gitdir);
 		}
-		if (startup_info->have_repository)
+		if (startup_info->have_repository && repo_fmt.version > -1)
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
 	}
 
-- 
2.20.1

