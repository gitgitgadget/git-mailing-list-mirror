Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA68DC34994
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D31F246B8
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2HUX+jY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfLMLxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 06:53:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33334 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfLMLxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 06:53:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id d139so5832497wmd.0
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 03:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oB/srEV8UG4kb7FNjA5E/jyr2FUz9Tf3l87N4Mews34=;
        b=k2HUX+jYshxT2XnjLz3tlSz77qz97I/zW/tnYV8uh6jQ0fc8CNdllUkA8/0va37nSV
         GuO0Uo1jiYFg9H4+/bPhPjz251T2dMDof0KjokWDYhK6Ks1MH+sFtwzxXedfgytiSuxi
         k6S6y/QaVdEQ3cij9mHeB2zCpZC0Xr/gzFUrj56kZAsPC7CE+wp6rK5Cye81Zca6rP8f
         YfzEMucQ289MGPwlK+vfr76rL78t8ApPESbd1JeEYL0qn0gbCtKPs42fB29el4HkVktr
         2Qv5c1Tsd87hWjGcGdtO23SQZ8TF8AnXSO7MYljNODXEywQ2Fw75mi1lYDI064zZIMCC
         jthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oB/srEV8UG4kb7FNjA5E/jyr2FUz9Tf3l87N4Mews34=;
        b=qU8HCOJnnVYjuPRlGfEoVYsU/XnRT69WT1f1OisOc2hOtcfOPmPl1QQDml2x1cbrfJ
         0hG5jRh6rCbv65ZCDPOwa9Uh+lZrTdNGTefqAvQw2tzm23R0sZPgLoopktJuEkjUYyrl
         xqTR8Cq8/ijDNq6kc24/o/jPaMxyVEqEQlPTDXhzIKQRKVEuJcur5nBONEyTAew+W0YH
         G3X1mvhtOPltK6Aj0NNzwOlkCXKO3/ZyfzGvBeyykEEUASuozvLcFdAvro5TOrgjVA5Z
         4ucyoBWuyScJ25sjwpvmr9rZ89u9IcCO099i7rErhCOZHNF3YZ8gip3iKiJZgEK8a4xV
         wLbQ==
X-Gm-Message-State: APjAAAWOE3zBi91M4/WhFAcbmXAw8PEO4tLNkGjfAsacqDKQ6PqNLybW
        kH+MzuUqq9Hljnqxa84TTpCVdoqDqtQ=
X-Google-Smtp-Source: APXvYqwpg+3dveGQAikKiPnqV6SQ6irt27jR5n9Er28ZjHLPCiJ9efpzEVWr7ZHezDJMRixUj0vjcw==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr12329156wma.72.1576237993756;
        Fri, 13 Dec 2019 03:53:13 -0800 (PST)
Received: from localhost.localdomain ([139.47.114.52])
        by smtp.gmail.com with ESMTPSA id f207sm10250400wme.9.2019.12.13.03.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 03:53:13 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [Outreachy] [PATCH] bisect--helper: convert `*_warning` char pointers to char arrays.
Date:   Fri, 13 Dec 2019 12:52:25 +0100
Message-Id: <20191213115225.13291-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tanushree Tumane <tanushreetumane@gmail.com>

A char array creates a character array. Its size is the number
of elements plus one (compiler automatically adds '\0').
A char pointer creates a char array and a pointer to that char
array that means four extra for bytes for the pointer variable.

Let's convert `need_bad_and_good_revision_warning` and
`need_bisect_start_warning` char pointers to char arrays.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
This patch is a new version of:
https://public-inbox.org/git/cadc46442d5c960caa58227092289fa2f44fb96f.1551003074.git.gitgitgadget@gmail.com/
sent previously by Tanushree.

 builtin/bisect--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3055b2bb50..1718df7f09 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -282,11 +282,11 @@ static int mark_good(const char *refname, const struct object_id *oid,
 	return 1;
 }
 
-static const char *need_bad_and_good_revision_warning =
+static const char need_bad_and_good_revision_warning[] =
 	N_("You need to give me at least one %s and %s revision.\n"
 	   "You can use \"git bisect %s\" and \"git bisect %s\" for that.");
 
-static const char *need_bisect_start_warning =
+static const char need_bisect_start_warning[] =
 	N_("You need to start by \"git bisect start\".\n"
 	   "You then need to give me at least one %s and %s revision.\n"
 	   "You can use \"git bisect %s\" and \"git bisect %s\" for that.");
-- 
2.21.0 (Apple Git-122.2)

