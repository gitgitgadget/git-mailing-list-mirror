Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE79C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 18:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F47364DE1
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 18:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhBJSJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 13:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbhBJSCo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 13:02:44 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038D9C061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 10:02:04 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o24so2601773wmh.5
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 10:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o+viT2o/wr/aBDIuNzvf/3eXrCEmSYRPxd+z/Cg9JAg=;
        b=g7AF5eDdDtZIQKmZPE4lHo7dyrWKp09KKLQQ7nL0A/plpMpO75TaM4GtlHPnRvC4+K
         +HtC0AYJTz5ikBKrwVS3H33GzUw0+vide7qJmWdc0Gv7m6jdmPxquW/BARoH3r4asRWz
         zVfSgrjfNdwIYduQo/wglFwRpkM2YlMwD3HUZni0SmX4BeD7czRLPXYbeY97aBw7WnkP
         kkSlAnJfuW/3jx3B2SJbSEj04jG3giQa16wIIq4C4RzyqAng+LjumupYzX1/1EAAtWMW
         koTqWO4oJShCtHdEkZnrbAte1X+1Vi36vwrKd1f9nW+LZjIGF2ZAVZqXCfGjnY0qE90h
         4OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o+viT2o/wr/aBDIuNzvf/3eXrCEmSYRPxd+z/Cg9JAg=;
        b=ikzP+SbwvPQznzhYLvyPs1GTpDpPfHAS/lZSESda988XNG0ydim6/BQISwECszg4FB
         Dj+bx0LMZRR+mX2k5+uProaKAxOD+41PMDV1nOVokbVPyz2ehFRUQxl44fSPLkQCCtxF
         NAZx4p9rAa6FBklZEVWjnNmOrr1zrtZih5r+TU0bnvWLOk3m4bo6AkIF3ByyntusmG/v
         xFBxOe99FKG6ATq1AZTo/PHuMP4uvC9Edj4wH0458vLzoqb7Nfuwut2XlLFgiaOIQrxF
         2kUyIdJrwwLcswgtDbZCv7KyZOhUCqJjyHHFNjmk1YV+R34lsSg4mVQ040Wx7UKhBFO6
         mbaQ==
X-Gm-Message-State: AOAM533AQUml7Dxgyh2L+1Pg+9JyG2CLKRqQiZPOevgMYGV5zTpfE2A3
        SOLu/V14Q8j9jCbP9gz6QhI1nXj2Yc8=
X-Google-Smtp-Source: ABdhPJx+fJVUfBAQvm3t3KPs9Qk6ekuxwh6e2wxbnaHJ0tMIjaAeBDfcNDC2yt1QYbeSeyZ+/M0Tgg==
X-Received: by 2002:a1c:608b:: with SMTP id u133mr63703wmb.149.1612980096040;
        Wed, 10 Feb 2021 10:01:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13sm3291077wmh.2.2021.02.10.10.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 10:01:35 -0800 (PST)
Message-Id: <03efb76b31e46ffe340fe0c6ab5fc4d804b2c273.1612980090.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.874.git.1612980090.gitgitgadget@gmail.com>
References: <pull.874.git.1612980090.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Feb 2021 18:01:30 +0000
Subject: [PATCH 2/2] fsck --name-objects: be more careful parsing generation
 numbers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 7b35efd734e (fsck_walk(): optionally name objects on the go,
2016-07-17), the `fsck` machinery learned to optionally name the
objects, so that it is easier to see what part of the repository is in a
bad shape, say, when objects are missing.

To save on complexity, this machinery uses a parser to determine the
name of a parent given a commit's name: any `~<n>` suffix is parsed and
the parent's name is formed from the prefix together with `~<n+1>`.

However, this parser has a bug: if it finds a suffix `<n>` that is _not_
`~<n>`, it will mistake the empty string for the prefix and `<n>` for
the generation number. In other words, it will generate a name of the
form `~<bogus-number>`.

Let's fix this.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c          |  5 +++++
 t/t1450-fsck.sh | 10 ++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index 73f30773f28a..83d727c6fe33 100644
--- a/fsck.c
+++ b/fsck.c
@@ -461,6 +461,11 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 				generation += power * (name[--len] - '0');
 			if (power > 1 && len && name[len - 1] == '~')
 				name_prefix_len = len - 1;
+			else {
+				/* Maybe a non-first parent, e.g. HEAD^2 */
+				generation = 0;
+				name_prefix_len = len;
+			}
 		}
 	}
 
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 779f700ac4a0..bfa3588f37ab 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -607,13 +607,15 @@ test_expect_success 'fsck --name-objects' '
 	git init name-objects &&
 	(
 		cd name-objects &&
+		git config core.logAllRefUpdates false &&
 		test_commit julius caesar.t &&
-		test_commit augustus &&
-		test_commit caesar &&
+		test_commit augustus44 &&
+		test_commit caesar  &&
 		remove_object $(git rev-parse julius:caesar.t) &&
-		test_must_fail git fsck --name-objects >out &&
 		tree=$(git rev-parse --verify julius:) &&
-		test_i18ngrep "$tree (refs/tags/julius:" out
+		git tag -d julius &&
+		test_must_fail git fsck --name-objects >out &&
+		test_i18ngrep "$tree (refs/tags/augustus44\\^:" out
 	)
 '
 
-- 
gitgitgadget
