Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF88C3F2D2
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 21:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9239D2469F
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 21:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onmA/3Go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgB1V6z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 16:58:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34738 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1V6z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 16:58:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id t3so2195710pgn.1
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 13:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+TMUZE3IIf/pssA7aJCHGkWcFqFnUwV/PSY5OJ7Svw=;
        b=onmA/3GoqtLQYDQjZ5eyHJq/YDG+l5PoGqdy/2pTQm0lBQ8cGri9ErOW4lqMukva6/
         eZgco5/TSfevEQmZCexkygw6dZfKTjNgEOdjKFjUWXGzL8ldu/vaewadtNwsP59AyEWL
         iZt3LZPKZPFerE5vT2RftP58PopAZmnC+x6r2X8MPZ1vGQD8XoxHUYu1j7VTPwe6/pqt
         XWS9KaP2unizen7kG83oYGJEVInckY8vXeL+/VoIHPDq3dTWySUyDljko4AOzuZ1f6Tu
         iOAjMI8hm7bGZsddaB4Hk9aJTowprzSz003Y9yj0XM9OdrEbGGI/Znp6ZZjmPka3Y6po
         WXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+TMUZE3IIf/pssA7aJCHGkWcFqFnUwV/PSY5OJ7Svw=;
        b=C+KNBmY20FPwP2jCVaD2EVlhgmIjQzYw7+sxNUdaTtOc5ERbk879e61IIV4hxFqyEK
         z0Py3WnBRwl0y8fsfU9nJbbit6e2qZefuUzgz4jt7BYw8vn+gXQHUfCGxoZ2o8EVUOT0
         pnK8YOUBJlLbuOiKJ3nWUICDJR1DFpnl8kiWzAvYCBBlSzPynTC1CMbmd/4vLeZT4Cxd
         54BLtMFN8OazvFa5HgqKxEqPegZ+I0XZsDJh9JkKvvQb/2biEyxAYS7aNj5OXj7hRQ5e
         j2L1+LhCnrQya98U3JZFlJqH+uRFLDrLTaO1hvwzJjDXoRCXRlaQMZ+xCzm4sG+FPTAw
         BCDQ==
X-Gm-Message-State: APjAAAXFz2+DJ+TKS4HL++LGXATLbxy7oTBBGsLgv9J24khi9ODJneOj
        i0/duO2BB8MfiWSKC61Xi4gfsl3m
X-Google-Smtp-Source: APXvYqz8Ur4sUr7We9ZBdDd+BsisfLEZixLFnmWHJWIwJNqi82b6Hs0iW1MzIqc15/DPXGJWpi7xoQ==
X-Received: by 2002:a62:e318:: with SMTP id g24mr6294055pfh.218.1582927133606;
        Fri, 28 Feb 2020 13:58:53 -0800 (PST)
Received: from viper.genetics.utah.edu ([155.98.131.0])
        by smtp.gmail.com with ESMTPSA id 4sm12995094pfn.90.2020.02.28.13.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 13:58:52 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, rcdailey.lists@gmail.com, newren@gmail.com,
        rsbecker@nexbridge.com, gitster@pobox.com, annulen@yandex.ru
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] pull: warn if the user didn't say whether to rebase or to merge
Date:   Fri, 28 Feb 2020 14:58:33 -0700
Message-Id: <20200228215833.319691-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most Git users are contributors, not maintainers, and want to use
`git pull` to rebase their changes before sending a pull request to the
upstream project. However, novice Git users often forget to specify the
--rebase option when pulling, leading to an unwanted merge commit. To
avoid that situation, Git should require users to explicitly specify
whether their primary workflow is a contributor/rebasing workflow or a
maintainer/merging workflow.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/pull.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 3e624d1e00..8ec8e6f5d3 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -327,6 +327,13 @@ static enum rebase_type config_get_rebase(void)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
+	if (strcmp(opt_ff, "--ff-only") != 0) {
+		warning(_("Pulling without specifying whether to rebase or to merge is discouraged\n"
+			"and will be disallowed in a future Git release.\n"
+			"Next time, run `git config pull.rebase (true|false)` first\n"
+			"or specify --rebase or --no-rebase on the command line.\n"));
+	}
+
 	return REBASE_FALSE;
 }
 
-- 
2.25.1

