Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDDE91F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbdBCCyp (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:54:45 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36354 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752333AbdBCCyl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:54:41 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so1190868wmd.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLKLJoPETMAtjYoq2IIUgfZEV69JOeMCGdR0kWLjUTE=;
        b=qLd7hfC6xeQa4mtnFUZ4IbqkxQmrSd8dzP+tGSdHKY+OAg/wJfveikN0H8VCf9J0ad
         x0flZZAAodnleafBlI2XZfLLB+bLguMhdBqgdNj/b5cKHtLhUY/zLhx9eCQT4cz5Wn4E
         8TZOEO5+R81Y7PGfaV2NPqjsg0j23Sg/Zs6fBR8dw0+J+KhqnFJWdt5tRfz1fy7cPfld
         7HTnbqVMNUBjPLz/rmMP9P12mYo2DRrkDkRgytdnZdmpG7QvtviYVFf75f4EgMFNU5/K
         zNqEgvkw0FeJgh0D6LhFef6UOO8mTGxdBiASjSAr8FX0fepOFspSI1AoOkI2EqCfWM8d
         POgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLKLJoPETMAtjYoq2IIUgfZEV69JOeMCGdR0kWLjUTE=;
        b=PjfShwLrwmeewbtsQrysaC7AnTV7VWgKn7AGb5/a6SUpKSbZMk4wtT5NQ5w4jfxTEx
         mmW8/EqH3oVJrIUodWM3CDA/5BRVjN2glBvurYJc1NjSYPapIC5XGBe6r62lyCsZo6fu
         CiSmqA05iZNVqQDQDZqZLqpWhCqdx5W/BiBfMcwC+PO2NiteyoO0KiJkkgUIQu6e9QAy
         g81bSvNNNBxKK3O+0btP4HrgCND3ZyS20KQ04e0v8Ch+wzYlDQTVPmYP16J1VcPCed5o
         NSx1nENasrqw1L6THlIocA1KQUlLcTYi7fcUw5my4tlh7U2cFgAg2UX7mqYK3mQ/biUw
         ZTDA==
X-Gm-Message-State: AIkVDXJKozksw4iaQVNnZeRvFfUuXVLP4sVOUN0Z1YZYo3Oml1cdX2T2oFiFCYntO3+zfQ==
X-Received: by 10.223.150.238 with SMTP id u101mr9798492wrb.175.1486090473883;
        Thu, 02 Feb 2017 18:54:33 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id c133sm652291wmd.13.2017.02.02.18.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:54:33 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 10/12] completion: let 'for-each-ref' sort remote branches for 'checkout' DWIMery
Date:   Fri,  3 Feb 2017 03:54:03 +0100
Message-Id: <20170203025405.8242-11-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203025405.8242-1-szeder.dev@gmail.com>
References: <20170203025405.8242-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When listing unique remote branches for 'git checkout's tracking
DWIMery, __git_refs() runs the classic '... |sort |uniq -u' pattern to
filter out duplicate remote branches.

Let 'git for-each-ref' do the sorting, sparing the overhead of
fork()+exec()ing 'sort' and a stage in the pipeline where potentially
relatively large amount of data can be passed between two subsequent
pipeline stages.

This speeds up refs completion for 'git checkout' a bit when a lot of
remote branches match the current word to be completed.  Listing a
single local and 100k remote branches, all packed, best of five:

  On Linux, before:

    $ time __git_complete_refs --track

    real    0m1.856s
    user    0m1.816s
    sys     0m0.060s

  After:

    real    0m1.550s
    user    0m1.512s
    sys     0m0.060s

  On Windows, before:

    real    0m3.128s
    user    0m2.155s
    sys     0m0.183s

  After:

    real    0m2.781s
    user    0m1.826s
    sys     0m0.136s

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e2c4794f3..9f5a6f44e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -414,8 +414,9 @@ __git_refs ()
 			# Try to find a remote branch that matches the completion word
 			# but only output if the branch name is unique
 			__git for-each-ref --format="%(refname:strip=3)" \
+				--sort="refname:strip=3" \
 				"refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" | \
-			sort | uniq -u
+			uniq -u
 		fi
 		return
 	fi
-- 
2.11.0.555.g967c1bcb3

