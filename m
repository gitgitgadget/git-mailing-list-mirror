Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90CD31F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbeACATN (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:19:13 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:41498 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbeACATJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:19:09 -0500
Received: by mail-io0-f193.google.com with SMTP id f6so459884ioh.8
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jc7GRPb+jnQOvSSk79QqTopCnbG5RX2j8cHIxGOpFuk=;
        b=fs+ROd1qUqxPsuSIGXHTNDb7In1nijWTEx2cgC2YGCHA2DC3/NQL+37+lDhUD1YzWX
         BIjRYyRTXnyg6hWdiAPiHtAy9RebhEqA/bqQTi4YZlM5jf/gFvB4SsewjaWvZc321jaz
         er6T5Cvku+9aWG5B0ribjBNTVMDYVqbvi8c0ZGBVk754J7A7pDZWxJ/Hro9MSeix88ra
         jDrq6vTNrpoMp/giMWVcza+NnEJ/Pc7rljIRq4a/TJxMsm6/7orASu/qZpkjOOe+plar
         OM4NmG7Ktm4XX3mpeIiFPujDQX5WU948TR4XlPqUEgD0vvxV0WoVrdPzmS7+hu6/V0sO
         HMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jc7GRPb+jnQOvSSk79QqTopCnbG5RX2j8cHIxGOpFuk=;
        b=FeEPVs9USpQhTk/2ehV0SqlmCGepZnSQCNETKpyfXCsiVxxNMYsrWZK6HtWOpTuPyh
         QjBPoKEZuGURIQ8JU54lqU0Km9rdZ259TtuEpTKqJGItoF9fb0d3NsOP9SfI45Zxzlvd
         FZSoAD+ZFoEZ8/bgRV+a5AWbY9yMw6ymPvMh6jNBGasdtx7G4OUvGuep3/uZHc2F4PCC
         UWZLsn/k8OEHmCFn5uTSerfhsthCZY3EZdKZh1cnyCQbC1ZzKO7pa9ddxP/CQQZ1PeQg
         AN4pQhZQ2YfR5P46SfjoKd49KBsiE6D5LXKkmPu8pHBq8jNI4Wo5hW+xWJGVg2A8s6vy
         jBpQ==
X-Gm-Message-State: AKGB3mJmauBcOCR/n0bhJYRHs2hJTw1wWgi/pTKqV/zhgr0nENxnkrN+
        +yjFwLqRBAEpq3Zc5ZPhA7jpPZ/Blck=
X-Google-Smtp-Source: ACJfBot1UUOhS8SQFV+7SDCnvVe1r2HuqLZITr4NiYTf1Qj4jXKbrr7qUTFuGgF74DCEdfrnaxv8fA==
X-Received: by 10.107.6.9 with SMTP id 9mr62422200iog.200.1514938747951;
        Tue, 02 Jan 2018 16:19:07 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:19:07 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 18/26] push: pass ref patterns when pushing
Date:   Tue,  2 Jan 2018 16:18:20 -0800
Message-Id: <20180103001828.205012-19-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Construct a list of ref patterns to be passed to 'get_refs_list()' from
the refspec to be used during the push.  This list of ref patterns will
be used to allow the server to filter the ref advertisement when
communicating using protocol v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index dfc603b36..6ea3905e3 100644
--- a/transport.c
+++ b/transport.c
@@ -1026,11 +1026,26 @@ int transport_push(struct transport *transport,
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
 		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
 		int push_ret, ret, err;
+		struct refspec *tmp_rs;
+		struct argv_array ref_patterns = ARGV_ARRAY_INIT;
+		int i;
 
 		if (check_push_refs(local_refs, refspec_nr, refspec) < 0)
 			return -1;
 
-		remote_refs = transport->vtable->get_refs_list(transport, 1, NULL);
+		tmp_rs = parse_push_refspec(refspec_nr, refspec);
+		for (i = 0; i < refspec_nr; i++) {
+			if (tmp_rs[i].dst)
+				argv_array_push(&ref_patterns, tmp_rs[i].dst);
+			else if (tmp_rs[i].src && !tmp_rs[i].exact_sha1)
+				argv_array_push(&ref_patterns, tmp_rs[i].src);
+		}
+
+		remote_refs = transport->vtable->get_refs_list(transport, 1,
+							       &ref_patterns);
+
+		argv_array_clear(&ref_patterns);
+		free_refspec(refspec_nr, tmp_rs);
 
 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
-- 
2.15.1.620.gb9897f4670-goog

