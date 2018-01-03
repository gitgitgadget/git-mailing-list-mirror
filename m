Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA331F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751208AbeACAS6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:18:58 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:44469 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbeACASu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:18:50 -0500
Received: by mail-it0-f66.google.com with SMTP id b5so43305itc.3
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2zdkuPdMcXBKLFGqoQyYAQJ7H+so2+fmJ9XssbbiID8=;
        b=sc+eOZ2905OHS+Sp2L3iTP8SX7J7x4acLkf1ehImRmOvkg3oKWFVOZcMBUzjrXH5y2
         1AgA9VcfzGb1JjuHQg62/gmzCQvINaGEIX2lie87cf0cwz3/vqVAMHDrTJH7Eozb+T1y
         oRfRjlIR0KoOdWaoYDdlmcWu1GGLYyrs/dA5/ql8fSMDgdGE941y9LIExSZBolpuc9Og
         Hh7b1C8W89X5LRhXx3BAsyqg+h91U1ZUqpsjcqDCqd1EvWLNFRBOkd3TexPIS+2wktHO
         nP8atzi2MwKS7HmD9fK8LksAJGoZCV3LNxQbpKF6zLaRtD/2SwG43KKm8V+gr/6/Bjp3
         i7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2zdkuPdMcXBKLFGqoQyYAQJ7H+so2+fmJ9XssbbiID8=;
        b=FwIGU1/MWl1rq+zVKqLns94q9Hvwb0+1ufWW89/+0WKghRmyMCpjulAtKfZa+j1FlU
         f4ceX8n8zmPUPGjUEaCCsDpV0ITlvK3nWAJllJ7P1g8EJMmJCGXlhZ7Qz1cMDsmRHS9J
         HH0p4TCUMJ4Vr8x2wnIgPp5b2EuuUXaLfNybigt3XMMAVfB/geP5URg/bByeMsReaG/2
         qUYHA9dgil+nYZJV/fW07CLMxGh01DMOQmhFkz3Gs4lqfVwyol8Yxg/06KUA9SGsgmb2
         MisG1Rpepl7Y55rOsqtnHQ7dHRNV8VzIZUN9MxTl6/42nIHTvvpmmI5rwJeguSxBWuB3
         wDmA==
X-Gm-Message-State: AKGB3mKNmT47Y/wpVd90kWK8zoG2Mp6ARyD4pIdZEKdqmgIrD7mJT1Hk
        +9r/ko716mMT5B1F/hIvPwDQrxAmmrY=
X-Google-Smtp-Source: ACJfBouL/nHX+VM6a+7dOXZyujNTN1e4jikMqe2gmoiQipAFQXqoIvONT8GyK7xSiOd43em4Mdr8XA==
X-Received: by 10.36.94.202 with SMTP id h193mr84687itb.129.1514938729243;
        Tue, 02 Jan 2018 16:18:49 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:18:48 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 06/26] transport: use get_refs_via_connect to get refs
Date:   Tue,  2 Jan 2018 16:18:08 -0800
Message-Id: <20180103001828.205012-7-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove code duplication and use the existing 'get_refs_via_connect()'
function to retrieve a remote's heads in 'fetch_refs_via_pack()' and
'git_transport_push()'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/transport.c b/transport.c
index fc802260f..8e8779096 100644
--- a/transport.c
+++ b/transport.c
@@ -230,12 +230,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.cloning = transport->cloning;
 	args.update_shallow = data->options.update_shallow;
 
-	if (!data->got_remote_heads) {
-		connect_setup(transport, 0);
-		get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0,
-				 NULL, &data->shallow);
-		data->got_remote_heads = 1;
-	}
+	if (!data->got_remote_heads)
+		refs_tmp = get_refs_via_connect(transport, 0);
 
 	refs = fetch_pack(&args, data->fd, data->conn,
 			  refs_tmp ? refs_tmp : transport->remote_refs,
@@ -541,14 +537,8 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	struct send_pack_args args;
 	int ret;
 
-	if (!data->got_remote_heads) {
-		struct ref *tmp_refs;
-		connect_setup(transport, 1);
-
-		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL,
-				 NULL, &data->shallow);
-		data->got_remote_heads = 1;
-	}
+	if (!data->got_remote_heads)
+		get_refs_via_connect(transport, 1);
 
 	memset(&args, 0, sizeof(args));
 	args.send_mirror = !!(flags & TRANSPORT_PUSH_MIRROR);
-- 
2.15.1.620.gb9897f4670-goog

