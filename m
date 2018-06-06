Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65A21F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933697AbeFFRDj (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:03:39 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38053 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933796AbeFFRDN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:03:13 -0400
Received: by mail-lf0-f65.google.com with SMTP id i83-v6so10229882lfh.5
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KQgZet+/EcDn/nPwpITlVINZeYRX4GFoZAUtUSsN9no=;
        b=XoR6wgVUqh4cB5Hu0Btz/OOsDNoL1JgXxjXUC/T4cjoQpJ01J4loSqFjs2XlFvbhAC
         h12BmPF56ERvOf1GWyhkRus9dxlOjFuGdP6r4gJziYZ7UG7vwtwtixcmk3+OOKGLGLKo
         et58BiX97EfCL6tKmMeg+rHI0EXzNyOMj6GqBUD/BCSEtdrvDSu6Vn2tcUFjH6tswm0a
         diobVHdwothCbnGpgoscOh29f3CU4FgS0rhnFX2AhY+dHpfEywM4Q8pEcoBTQj1ZDBE0
         dekfO6KQVqFHqI1m8Ogj/WDpMj1yRZeGEi6yf7hC+F60dCqB84Yz1vcv9EAyxQio+drn
         Vc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KQgZet+/EcDn/nPwpITlVINZeYRX4GFoZAUtUSsN9no=;
        b=CVW/TUCFAxidFuO7iQbHFQ3Iw3Rur+EFY7SGgRIqwg4qlx57zdQS3hdxRiJZY3QK+H
         D5SJt8ZHpXlve0VARr0boEvBgX47DnvQsDMuziaBBEo5zmFAN/rsgSrSm0It6iWUjeUL
         dszkpBmxB6rql9uT6inIDhTkp1Vc4roNXZVM22buy9I9kwqeMlbTEXVyK38BCL7SRMHB
         +skNr0OePMtQ4pjBRY+DBbkjxuD8SeZmC/jJN9I+T0sbuo7cMFTuPSJHlR1vKJYv4Zbh
         KB15BOKyRc3q77ZEVJuSO5CvYvRYtGqs0B1+uUE3SZS4pX6FSMHqlP+tF9dBBHdPqGPv
         91WA==
X-Gm-Message-State: APt69E1fqtR8vWknyESM7NnphZxtno3SbNNk6v6tiSZBzm3PdtovKuvS
        pkwfW07wpdsK1FpFTLzTzS8=
X-Google-Smtp-Source: ADUXVKKED++f8gQS+US4gxlVa7Jsvl0Q2YQm0rziSKCKc9Rm/fhMbwMab1Yw5PYghnZ8XCstW6/Ung==
X-Received: by 2002:a19:15da:: with SMTP id 87-v6mr2486164lfv.136.1528304592366;
        Wed, 06 Jun 2018 10:03:12 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g14-v6sm1485305lfb.36.2018.06.06.10.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 10:03:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v4 18/23] apply.c: use the right index instead of the_index
Date:   Wed,  6 Jun 2018 19:02:38 +0200
Message-Id: <20180606170243.4169-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606170243.4169-1-pclouds@gmail.com>
References: <20180606165016.3285-1-pclouds@gmail.com>
 <20180606170243.4169-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index fc42a0eadf..82f681972f 100644
--- a/apply.c
+++ b/apply.c
@@ -4090,7 +4090,7 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 			return error(_("sha1 information is lacking or useless "
 				       "(%s)."), name);
 
-		ce = make_index_entry(&the_index, patch->old_mode, oid.hash, name, 0, 0);
+		ce = make_index_entry(&result, patch->old_mode, oid.hash, name, 0, 0);
 		if (!ce)
 			return error(_("make_index_entry failed for path '%s'"),
 				     name);
-- 
2.18.0.rc0.333.g22e6ee6cdf

