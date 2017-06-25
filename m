Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D921920401
	for <e@80x24.org>; Sun, 25 Jun 2017 04:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbdFYEeq (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 00:34:46 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34578 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdFYEeq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 00:34:46 -0400
Received: by mail-wr0-f193.google.com with SMTP id k67so22508432wrc.1
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 21:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7QVnM4fH9sMZiWw+foFeHMZkCrAmP0S2+ruuziy9qag=;
        b=WW65mvfbt/YfJd9+bEkLNQayJZJq7JPnrUSsZUij93lRO1DcK+dgN/bPt1E9gXc5rB
         vbKcsUSKb3Q2DdW/uKgGBjyknm2ByDuPyf7Phbb+ttbcLHbSRtqY+mCRJ9CVaQ0CtiJ4
         3pDKJZ9qCUH8pxXnsuJmUNBzO1cU9N1pQtfYkSxyUtVuxRvzr02HefjJcXSC/3SlrP+7
         XYiYJFuLblz4jNNDz8E1cP8fvAiLS4PkAGHw7UQl+gHYNP1GeMnjBHyJ1l7FcBIFv7Pn
         Evns+4cFZwMyqapjY7UITVVU8SLnr8hlAtnIW2S6eY17HvoymShYMjz0bTbXpgXXXTqg
         rB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7QVnM4fH9sMZiWw+foFeHMZkCrAmP0S2+ruuziy9qag=;
        b=tw7E2xhv7Jkc9IhbbbnWK79KvBiVciCwVuBRBRlCpjZT/LZE2nmojIYjcUDu9DPRQd
         K9jxo2gV7tzCBwkx+JU/wGF/iv8JS0y85WZbk+inAmkMB7Bm8Nk1WfzvEOjDbot/xKYE
         Ny7cX1MhoWa1CW8aj+SyuIkHqhB/xIO5BgKaCD61+o2vaSU5p/bkZvlKiWbA7fqsuibH
         Yqs81qqyXALLXVUIdjwsjjtDNeKqjVt0Besqtkf9svOyN3CPZvNZFU2rDBwEcAU8+7lS
         xQEVdC5UmOOetCZFpLcV6UDRffrUhZuP82I0zHXsZZMVS/5NIoWRiWY5f5vznt54NHSx
         LQ6Q==
X-Gm-Message-State: AKS2vOy0oDpcdTfC0oew6CzbYX8opuh0v9w5yWfuUYUTdmuq2n/DMYIx
        6YYbP65/ajyby2gu
X-Received: by 10.28.187.139 with SMTP id l133mr9220114wmf.116.1498365284326;
        Sat, 24 Jun 2017 21:34:44 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id a99sm4977943wrc.64.2017.06.24.21.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Jun 2017 21:34:43 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/3] read-cache: use shared perms when writing shared index
Date:   Sun, 25 Jun 2017 06:34:27 +0200
Message-Id: <20170625043429.23337-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.517.gf6399a5ea5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since f6ecc62dbf (write_shared_index(): use tempfile module, 2015-08-10)
write_shared_index() has been using mks_tempfile() to create the
temporary file that will become the shared index.

But even before that, it looks like the functions used to create this
file didn't call adjust_shared_perm(), which means that the shared
index file has always been created with 600 permissions regardless
of the shared permission settings.

Because of that, on repositories created with `git init --shared=all`
and using the split index feature, one gets an error like:

fatal: .git/sharedindex.a52f910b489bc462f187ab572ba0086f7b5157de: index file open failed: Permission denied

when another user performs any operation that reads the shared index.

Call adjust_shared_perm() on the temporary file created by
mks_tempfile() ourselves to adjust the permission bits.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 read-cache.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index bc156a133e..1f4ec1b022 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2425,6 +2425,14 @@ static int write_shared_index(struct index_state *istate,
 		delete_tempfile(&temporary_sharedindex);
 		return ret;
 	}
+	ret = adjust_shared_perm(get_tempfile_path(&temporary_sharedindex));
+	if (ret) {
+		int save_errno = errno;
+		error("cannot fix permission bits on %s", get_tempfile_path(&temporary_sharedindex));
+		delete_tempfile(&temporary_sharedindex);
+		errno = save_errno;
+		return ret;
+	}
 	ret = rename_tempfile(&temporary_sharedindex,
 			      git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
 	if (!ret) {
-- 
2.13.1.517.gf6399a5ea5

