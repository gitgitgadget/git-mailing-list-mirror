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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8AD1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbfGZPxH (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36976 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfGZPxH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so24934399plr.4
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aSum+Jh11Oyos5gFJ/QTMvDCeh3RcHbNa4clahepe4g=;
        b=NSCLTJ9yPJS6XrM3IlneZzUibqgbARaBm8diCTO+Y82C9XIBXU0Oz3X6+zTiClS2u6
         pFzk5oQdKSl03PRFkRGituzZM3BXpROGwtmBBgQaJaH1iydVhbxBS/ixoSiSCHj6w1hk
         6KhMvNWhbbvT1MOBK9YsIqacU/pxL5iuYkGoeIld4xredUwPYHkQ8zRza9bpb9LyqBWT
         LUi4RTLMD1yi62y0Mr7hqLPIii6eEMz4ebOwGFTA0MTJgR1iweeLHJC91i8rXWqEQnQi
         hSiGFFNKktx16ZzvRT6bK7KlaPlSdgeOCSzZNDqyTi97pg7Pul8gQyVVyzEwog+WeWB5
         qjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aSum+Jh11Oyos5gFJ/QTMvDCeh3RcHbNa4clahepe4g=;
        b=Opfwt6LfLDX0yyOM4BY85ZYY8ngRDJSj5+MLWz0VNjBxIrE2eh7fVDw/K/UOcRMt2X
         U/bAAszc/WSHSO9r9BwTFxRE8YvqeAbk294HOgkmerUc2WUEM6NWT5AeVH3xkfWEsxru
         WgTBimGumhUUfbjrA7gmksePeoFGdrpm5wWnS8lHAWYkTfy/0u670nNJd4gZRncOXSxL
         TDnpURa1oNE9F5xppwKNfBn5D6s+J98q04Cu28T+OeKSKffcONw9dwzK2W7B7Lfz87cy
         xe1J3B8kuIeiQksd+RUE+5vszD2YGQbVtg/ymUS6RJXd6KYFcF3RLFBFW/E3btCMughh
         3ANQ==
X-Gm-Message-State: APjAAAXsYH7RxshsX3Bzn8dgAcJT6/gLjj+ZsT9rB/QH1Uhk5GWiktpD
        p2B/K6oB3TsYjPZp3Iyw8hnn1wbC
X-Google-Smtp-Source: APXvYqwthATnV2SLqkk8ie8bENrq1lTvE6vOKipXLCrSg93y7abSFzy72QFldwLBsZzVjufREiCigw==
X-Received: by 2002:a17:902:4c:: with SMTP id 70mr96695625pla.308.1564156385939;
        Fri, 26 Jul 2019 08:53:05 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:05 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 01/20] merge-recursive: fix minor memory leak in error condition
Date:   Fri, 26 Jul 2019 08:52:39 -0700
Message-Id: <20190726155258.28561-2-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.550.g71c37a0928.dirty
In-Reply-To: <20190726155258.28561-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
 <20190726155258.28561-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Returning before freeing the allocated buffer is suboptimal; as with
elsewhere in the same function, make sure buf gets free'd.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 12300131fc..1163508811 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -934,9 +934,11 @@ static int update_file_flags(struct merge_options *opt,
 		}
 
 		buf = read_object_file(&contents->oid, &type, &size);
-		if (!buf)
-			return err(opt, _("cannot read object %s '%s'"),
-				   oid_to_hex(&contents->oid), path);
+		if (!buf) {
+			ret = err(opt, _("cannot read object %s '%s'"),
+				  oid_to_hex(&contents->oid), path);
+			goto free_buf;
+		}
 		if (type != OBJ_BLOB) {
 			ret = err(opt, _("blob expected for %s '%s'"),
 				  oid_to_hex(&contents->oid), path);
-- 
2.22.0.550.g71c37a0928.dirty

