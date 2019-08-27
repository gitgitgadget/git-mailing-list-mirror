Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1902E1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 10:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfH0KOW (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 06:14:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33349 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfH0KOV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 06:14:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so18209105wrr.0
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 03:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=frnhtb+/jIPyrLQ/2eIV7b0SW4r/HDvHTMd5ZQe0D4I=;
        b=FNESviYHU5LilAkZTjrWWmB0XnWylCU/BJ/dF9p9v7ZG/6euRj7DFDG/a58PrJFL8v
         fQybxd6KXn4/4aC3SogRmdAyff1cNTR3GrrBrrIxtOxxpQPycR1P307ZL34tP+9zQnur
         X3b+2+omMo17yq6J7nUY8tXvqkHWZqfzpeQSBOXS4dvjpADa+hAGBR2FcVF+uSfDeuV8
         30t5AGZOBVpd6/bYIVoTpcdVGgjSnFfe4AuUTh38xcpVm3qTHFAQJGFusKfvBEmbgd/3
         H9SrnUqHk6Yp/Zx3b+4ci7Qndb8opDVFZH1jbtGPrbHxPJ2ntpkI47CHytGae2JWkW/9
         qlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=frnhtb+/jIPyrLQ/2eIV7b0SW4r/HDvHTMd5ZQe0D4I=;
        b=sdNE9ppBPgfaomIxRKl3+tl84IKi4RwaJhiTjHOapIHSHeUUYcw+TAqe+H9rWXZPuY
         fMLOJlTQU3by4Eaggnpoy5bKolZbeuyX+U4ULO6cEjx8yGgBACH5KsRzVXOQJ285CrEH
         +hmZ80eyFUe03npdRzPSUrh6hbrw6eTREyWZUbT0jmFQXjKqkizvi9v9RWqXwtUA0bmx
         Xfx8XNscnQkqIwOnaljAilI4e/m/WIBnxJCOhf0udR9/r5RIdnm4WkIEMaeyCLYSJ5bN
         RD1kLjdxuB42WB6Gnyoei8lio17Fz0pEB4flQexGylz1LPh1Yr7E9mgwnrS1zx/KVWIL
         Hh2Q==
X-Gm-Message-State: APjAAAXN/xKspXFTEOegbuCCLwpRI0ky8C7a/cCaJDGh8coN/MHUiMOl
        6XizVywIIumffKXIxngvCStkRWfH
X-Google-Smtp-Source: APXvYqx10jrW0yTGEb/eYWPlcIzIaidE8sSHHi+LEGPhwKslqD1UGmwalHmaPPRdMifNuQ8DrNresQ==
X-Received: by 2002:adf:a1de:: with SMTP id v30mr28218767wrv.138.1566900859550;
        Tue, 27 Aug 2019 03:14:19 -0700 (PDT)
Received: from localhost ([2.31.128.175])
        by smtp.gmail.com with ESMTPSA id 24sm2773866wmf.10.2019.08.27.03.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 03:14:18 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/3] merge: use refresh_and_write_cache
Date:   Tue, 27 Aug 2019 11:14:07 +0100
Message-Id: <20190827101408.76757-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.194.ge5444969c9
In-Reply-To: <20190827101408.76757-1-t.gummerer@gmail.com>
References: <20190827101408.76757-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the 'refresh_and_write_cache()' convenience function introduced in
the last commit, instead of refreshing and writing the index manually
in merge.c

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/merge.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index e2ccbc44e2..b5e31ce283 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -691,11 +691,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	struct lock_file lock = LOCK_INIT;
 	const char *head_arg = "HEAD";
 
-	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
-	refresh_cache(REFRESH_QUIET);
-	if (write_locked_index(&the_index, &lock,
-			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-		return error(_("Unable to write index."));
+	if (refresh_and_write_cache(REFRESH_QUIET, COMMIT_LOCK | SKIP_IF_UNCHANGED) < 0)
+		return -1;
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
 		int clean, x;
@@ -860,13 +857,9 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 {
 	struct object_id result_tree, result_commit;
 	struct commit_list *parents, **pptr = &parents;
-	struct lock_file lock = LOCK_INIT;
 
-	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
-	refresh_cache(REFRESH_QUIET);
-	if (write_locked_index(&the_index, &lock,
-			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
-		return error(_("Unable to write index."));
+	if (refresh_and_write_cache(REFRESH_QUIET, COMMIT_LOCK | SKIP_IF_UNCHANGED) < 0)
+		return -1;
 
 	write_tree_trivial(&result_tree);
 	printf(_("Wonderful.\n"));
-- 
2.23.0.rc2.194.ge5444969c9

