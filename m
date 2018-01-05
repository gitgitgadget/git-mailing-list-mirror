Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B751F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbeAEU2m (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:28:42 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:44355 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbeAEU2k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:28:40 -0500
Received: by mail-io0-f194.google.com with SMTP id k18so6967900ioc.11
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GSFeXVEJLnzfARr96WXbCypr55IWcqe1GHpXhcplyqg=;
        b=YLYER3/r+xRtYDz0zq3SOCHmNivYIdquDq+4YhK++mLUh77s/aUbzUeIiZnGPJoCo8
         4Re6YBvjTQt3YDO26r0rZZrXY6T1LQQlsM2ifolbnWySa6Er96jXAU62ThXHRqRoznuX
         C55y3KKFx/PsB6z76Dlk2Xjyhm+PTrwC9pd/7XmPZKlyReJJJmcDUcdaFWDGX0Am2EHy
         Ngjb7thPwkpWyn1Sc3mMfVTiP46VYcj+6cXOof2LADHQHxfc7pDP1oIL7GBMNtRTy3R5
         TPlBF2nHgJFRGPrSTMandpKSBR3KRbU3Lx83TKRI4QbLVvq8QBeM9PDXXJvcbfZFJWYY
         6mbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GSFeXVEJLnzfARr96WXbCypr55IWcqe1GHpXhcplyqg=;
        b=Wl76FUSEePlbRAXViHzPn/V9xe5FAYeAmwgQ66sVr9hq1udq38WE1YMBzt8l2JS1R6
         4BYXcTyRXvU9VyVcJJLCvuCp3+B1E2LTNvv377HBbk7JYfTUMZWg0EWqW3ST8/NOrtcS
         skcoTZnYkZMlxg1MvseNCCqhtTEO/dX8SZXz2xK+zdBvUMf5dyElEScQ6+9x0mKudCe0
         F0ZONwlkrZNYE7LgefUyx5TnpjxzQdPC0/GTOWf9EQptCgFMtZ5I6VtMc354UxIloE5U
         TCxGWPGdmwfZ3M10zOmcFfgWwu82XDoP2txqeU/v2UeQ3iZEUkf8EFQ+2Y3Nu0HSvT6M
         hf6g==
X-Gm-Message-State: AKGB3mKKDyLj9l+cVVpRfr7RYN3PY52FFus2cYZ757DtlNcmVGBAqiMj
        J4rKJS5cXZaGRRVOHkt2hSOdTTsZ
X-Google-Smtp-Source: ACJfBotFNo2Nbi2DXZztYUUZKjRwm5C83AzggoeihvffTnwtP86WtWSXp+po82s2lI/VxnUoBnMaJg==
X-Received: by 10.107.171.198 with SMTP id u189mr3956388ioe.95.1515184119287;
        Fri, 05 Jan 2018 12:28:39 -0800 (PST)
Received: from localhost.localdomain (c-73-20-122-173.hsd1.ut.comcast.net. [73.20.122.173])
        by smtp.gmail.com with ESMTPSA id 6sm3739659iow.55.2018.01.05.12.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:28:38 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, szeder.dev@gmail.com, j6t@kdbg.org,
        jrnieder@gmail.com, peff@peff.net, git@matthieu-moy.fr,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 15/31] merge-recursive: make !o->detect_rename codepath more obvious
Date:   Fri,  5 Jan 2018 12:26:55 -0800
Message-Id: <20180105202711.24311-16-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.409.g72e1e5805
In-Reply-To: <20180105202711.24311-1-newren@gmail.com>
References: <20180105202711.24311-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, if !o->detect_rename then get_renames() would return an
empty string_list, and then process_renames() would have nothing to
iterate over.  It seems more straightforward to simply avoid calling
either function in that case.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index cdd0afa04..da7c67eb8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1329,8 +1329,6 @@ static struct string_list *get_renames(struct merge_options *o,
 	struct diff_options opts;
 
 	renames = xcalloc(1, sizeof(struct string_list));
-	if (!o->detect_rename)
-		return renames;
 
 	diff_setup(&opts);
 	opts.flags.recursive = 1;
@@ -1648,6 +1646,12 @@ static int handle_renames(struct merge_options *o,
 			  struct string_list *entries,
 			  struct rename_info *ri)
 {
+	ri->head_renames = NULL;
+	ri->merge_renames = NULL;
+
+	if (!o->detect_rename)
+		return 1;
+
 	ri->head_renames  = get_renames(o, head, common, head, merge, entries);
 	ri->merge_renames = get_renames(o, merge, common, head, merge, entries);
 	return process_renames(o, ri->head_renames, ri->merge_renames);
@@ -1658,6 +1662,9 @@ static void cleanup_rename(struct string_list *rename)
 	const struct rename *re;
 	int i;
 
+	if (rename == NULL)
+		return;
+
 	for (i = 0; i < rename->nr; i++) {
 		re = rename->items[i].util;
 		diff_free_filepair(re->pair);
-- 
2.14.2

