Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C01F81F406
	for <e@80x24.org>; Mon, 14 May 2018 21:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752405AbeENV5H (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:57:07 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:38361 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752341AbeENV5A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:00 -0400
Received: by mail-it0-f73.google.com with SMTP id p138-v6so16935893itc.3
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=PJ4vElEbhu8iwzbaPdG5iDoXC+S2fX4XA7SMpGPzhyg=;
        b=CYrJZ7XPT7thGBn3X5U6SuhMp16Mqkx8FWdPpxQpowpJFvzH2Tjg7OaqDQG5oS3p4L
         hiy40+wCwqzykSUnjTya8W68TD2KNx4o+zqtGycIH+wAYGXJYnYJuhROV/HPQy9EVlDK
         cyiV0wKf6+3TDf95nIoYkASWfe30DuMgn79Jv1CKBgNeiA+1aXLV5tIlji9lsJ4rpGiy
         rTDH6M07CFJCGWpLcZIslM3yfxVGOL5bQS6U18FBM0ekgYUb4rK8zK+Xu2bzXAXWdjPQ
         hzFS4azw4FraZmaeH6XKhDBl2NlBq/yfSYCQKWoFkEb85GZbDBHrafF/mELJ+jsPGApG
         T+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=PJ4vElEbhu8iwzbaPdG5iDoXC+S2fX4XA7SMpGPzhyg=;
        b=rqvr/WAH9PpEwQUNOe7SK7T/1uSa96KR1BOynZN6TdFKouPye1evExv6x01ZRGdOLe
         APj/5tt7G/3+KvgIm6ZjYv/Psbd/wQWY0Z/m3W/Cf1kwzTDt4xOHucCZxFLubyYTIbGF
         2PwCor/Xg4sy/fxsqFayqpKlmqvkcIpinKEbynN6GwL1ABlfPGIFmvXhgrcFb6BndA2w
         hq1cY3qHellFJ4fYQ3GPCgXOPU4rxCVmsijQDDa6YTwfLuweGaGKYqNI2OCmerGjFpBJ
         Yo0TfjZhmGY/qzcn2NYqFZpFnhtj/+MDGBXv4zgsVlq+lOrRsLWWepCuPgldw3oLklCu
         SbUg==
X-Gm-Message-State: ALKqPwfhRwnVNGJqnQdcUiv83rTc+SMpZ3BUItVcANSj2F3CrnusqA+e
        nUi7BcNrigaEHcRWPc9bOvkYjWmjwZAKJT9Re5NFVxfPsTI9LFis+vu86w2kBvUdEbtizOmMMz8
        jmSAkpFV7KXKrHCSpOySu2e9+56+gRmld4qSv6tFlUikFPlK7pTYTPTfvNA==
X-Google-Smtp-Source: AB8JxZr5lZLTUHKQH0Vem4RfzH1eIQOi4xIkDUvVDxd0cmyG9/0AWWx6cc3OcoyUTf0rqH4shRePaDFm/MU=
MIME-Version: 1.0
X-Received: by 2002:a24:b607:: with SMTP id g7-v6mr13796778itf.25.1526335019690;
 Mon, 14 May 2018 14:56:59 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:00 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-10-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 09/35] remote: convert check_push_refs to use struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'check_push_refs()' to use 'struct refspec'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index 89820c476..191855118 100644
--- a/remote.c
+++ b/remote.c
@@ -1282,12 +1282,14 @@ static void prepare_ref_index(struct string_list *ref_index, struct ref *ref)
  */
 int check_push_refs(struct ref *src, int nr_refspec, const char **refspec_names)
 {
-	struct refspec_item *refspec = parse_push_refspec(nr_refspec, refspec_names);
+	struct refspec refspec = REFSPEC_INIT_PUSH;
 	int ret = 0;
 	int i;
 
-	for (i = 0; i < nr_refspec; i++) {
-		struct refspec_item *rs = refspec + i;
+	refspec_appendn(&refspec, refspec_names, nr_refspec);
+
+	for (i = 0; i < refspec.nr; i++) {
+		struct refspec_item *rs = &refspec.items[i];
 
 		if (rs->pattern || rs->matching)
 			continue;
@@ -1295,7 +1297,7 @@ int check_push_refs(struct ref *src, int nr_refspec, const char **refspec_names)
 		ret |= match_explicit_lhs(src, rs, NULL, NULL);
 	}
 
-	free_refspec(nr_refspec, refspec);
+	refspec_clear(&refspec);
 	return ret;
 }
 
-- 
2.17.0.441.gb46fe60e1d-goog

