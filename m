Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 447D8208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 18:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755712AbdHYStq (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 14:49:46 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38039 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754592AbdHYStp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 14:49:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id z132so623390wmg.5
        for <git@vger.kernel.org>; Fri, 25 Aug 2017 11:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bskpp3JrhXteKeG7uX4axKwcQmTTGhFzDnhcmB+vnzk=;
        b=sYH3LtOpbLPtlDi/mpFzTjypEf7w1HeaVwASGTem45bfieDGj+iHkx0fEDhclELSKK
         85nO66g2l9OoF49Ovl4L6vTDwkH6NVMGIOluUo7dODoUmpQpCw2fcWmy4BahgT6uAnYz
         +U4xNWr30ymBnvejY2Hhc12rOOa0mBlHwUPGJ6+8/IJWI2IqrFBdkFwZCFJd7Abi7Pq5
         +bbAIl/GVnPUnMMph0HxyqlQcywisQL4U2k/eIopagP6+39EmlrAqxAkHnumWeMZagJN
         LcOGc6UjFTsTk7cbw8aJg5Cowv7UctUakEXzjwLhenQmhYD6OIpEYhH37hh1YHcQEgK3
         Sp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bskpp3JrhXteKeG7uX4axKwcQmTTGhFzDnhcmB+vnzk=;
        b=gy3nhjMMlf88oubkX2buX03L2tO8SMYuUHz6801D3PM27KtBkQqBhAZekxDFByEGSF
         YR2YFEFEkh6mE1c6WGGIt5PJgSg3/FeGcXlfI7Fp3Yjd4c/XvQHkKBs/TtlsKhuAoSTX
         goIeB2gCnWlldmuIGSiySutRJjMaLJwOpJWDMZkIpmqP1UPNIIv2AABmpjOV2USvn7cS
         Xpk+SmVnVBZLfyP3/xnfx89Eu1nf+k9WcndeoTJL/WFSXaGIy6+0iMKlFwTInfDiTo8a
         rcwDoSi8iDYxKkyyJa3h/eDWwLSiJefJpN6M6QseZnwmHWYB83yphEQ81PyJLQfBRX2Y
         SDhA==
X-Gm-Message-State: AHYfb5hSduq6yIQrhzQy/NUazbH/DvVwxcZ3Ovn8nPBwilGHDWJ9rYV3
        QS5w6p9sopiOburL
X-Received: by 10.28.109.151 with SMTP id b23mr219142wmi.24.1503686983739;
        Fri, 25 Aug 2017 11:49:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id m10sm2638762wrf.69.2017.08.25.11.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Aug 2017 11:49:42 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/2] refs/files-backend: duplicate strings added to affected_refnames
Date:   Fri, 25 Aug 2017 20:49:15 +0200
Message-Id: <40c5e954dd84ff42552bccfea00144eecdbd1c7e.1503496797.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.g45c1275a3.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

files_transaction_prepare() and the functions it calls add strings to a
string list without duplicating them, i.e., we keep the original raw
pointers we were given. That is "ok", since we keep them only for a
short-enough time, but we end up leaking some of them.

Switch to duplicating the strings, so that affected_refnames does not
leak memory. The original strings might still leak, but at least that
can now be addressed without worrying about these pointers.

No-one takes any pointers to the strings in the list (it is basically
only used to check for set membership), so it is ok for
string_list_clear to free them.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 refs/files-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5cca55510..22daca2ba 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2407,7 +2407,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			       "ref_transaction_prepare");
 	size_t i;
 	int ret = 0;
-	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
+	struct string_list affected_refnames = STRING_LIST_INIT_DUP;
 	char *head_ref = NULL;
 	int head_type;
 	struct object_id head_oid;
-- 
2.14.1.151.g45c1275a3.dirty

