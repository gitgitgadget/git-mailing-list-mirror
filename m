Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A60871F461
	for <e@80x24.org>; Sun, 14 Jul 2019 03:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfGNDCZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jul 2019 23:02:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39352 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfGNDCY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jul 2019 23:02:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so6175975pgi.6
        for <git@vger.kernel.org>; Sat, 13 Jul 2019 20:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZMU7gcpr01/sJa2qvcHhdq/4odlcfJ5CK8RaJPoaFOU=;
        b=T3xN9GUs2DJNXEjn2tIpgBvEiroiJUoL0mfIFZ2xv7cy8vM4zMyP+xxNOXcZ2IRBVF
         EavzVoKg0DMjXqeMK0Wuysp9PH64HcObOUYJB4Pm49d+b9VQEXAs5WBoMKJ8Jpl6tuNd
         qUdjgWResT+/foeF9hFuieZEeVXDF6NrUSnEPnBS9P4T686TlGoM9ZutdjR0mt1OFQ3w
         BF9xpniBPBD36FBDmffdsGnPS5Rkr6W0BKSueChSMaSuu0Ma0CM+Lizyj88yht8lEsnj
         y8dXLPXG4HM9p226oM2bI80XLgkMxhBFXchid0Ab4XQymBd7YJ+6tRDtDgPnWNkzNWGA
         DIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZMU7gcpr01/sJa2qvcHhdq/4odlcfJ5CK8RaJPoaFOU=;
        b=BDwauKPWgtByluPgiKfTrxeQttCpeLrMLLSCrcoiwQMsz4UAb7dTjKdMDgF/dMv9Lk
         t/tmJicA9BGP6EUBibrYR8VV3oTCLmTaGMcifBzt9Sd4L32gLNECqBMQ9SwZEIrfHp2q
         uoR0pYyVWR7jxnvLIOszesH5QYXFmRqyKiS0BCrYMukJ2GgBaSod68Ax02+6lAjf0amf
         V8LqeEtpbBxutxGP64cz8hORR4ERuoR1RJmIwu3q28VGJreeaC9gz1tOeKwOnLyUlvIz
         wdEbnz/cxjbZ0oujXLG8mCE3pp3rqOp3N6J72dR7etwXqFHQUR2fxwFjdYkYvaSouInq
         b1zQ==
X-Gm-Message-State: APjAAAVC2gVBkIFtJ8vgKKMqcOKtEWUtu1ibol87K7um+EQpgSCBQdX8
        5bEZ7wRwWR0zTkPYRWzuhtjqHfhB
X-Google-Smtp-Source: APXvYqwxzASrqeY46daMi9whiuapeMPN1G41WNcCklXp+yaZ5/sKJ3Q3BnAlbgwjEqna/tsZUeHD/Q==
X-Received: by 2002:a17:90a:1c17:: with SMTP id s23mr21537259pjs.108.1563073343936;
        Sat, 13 Jul 2019 20:02:23 -0700 (PDT)
Received: from localhost.localdomain (92.18.24.136.in-addr.arpa. [136.24.18.92])
        by smtp.googlemail.com with ESMTPSA id i7sm10875069pjk.24.2019.07.13.20.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Jul 2019 20:02:23 -0700 (PDT)
From:   Varun Naik <vcnaik94@gmail.com>
To:     git@vger.kernel.org
Cc:     Varun Naik <vcnaik94@gmail.com>
Subject: [PATCH] read-cache.c: do not die if mmap fails
Date:   Sat, 13 Jul 2019 20:01:53 -0700
Message-Id: <20190714030153.22022-1-vcnaik94@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

do_read_index() mmaps the index, or tries to die with an error message
on failure. It should call xmmap_gently(), which returns MAP_FAILED,
rather than xmmap(), which dies with its own error message.

An easy way to cause this mmap to fail is by setting $GIT_INDEX_FILE to
a path to a directory and then invoking any command that reads from the
index.

Signed-off-by: Varun Naik <vcnaik94@gmail.com>
---
I believe this is the only place that calls xmmap() when it should be
calling xmmap_gently(). There is a related recent commit 3203566a71
("Use xmmap_gently instead of xmmap in use_pack", 2019-05-16).

 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 22e7b9944e..4e30dafa9d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2140,7 +2140,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	if (mmap_size < sizeof(struct cache_header) + the_hash_algo->rawsz)
 		die(_("%s: index file smaller than expected"), path);
 
-	mmap = xmmap(NULL, mmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	mmap = xmmap_gently(NULL, mmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (mmap == MAP_FAILED)
 		die_errno(_("%s: unable to map index file"), path);
 	close(fd);
-- 
2.22.0

