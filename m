Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66B7B20954
	for <e@80x24.org>; Mon,  4 Dec 2017 23:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbdLDX7S (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:59:18 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34144 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbdLDX7P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:59:15 -0500
Received: by mail-pf0-f193.google.com with SMTP id a90so9815704pfk.1
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 15:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zWNzuFaTijiv75ae7lurm1eskwR3lUPUFEbAE4CNomA=;
        b=O2ISSnaR2S3dUxyhKs2WfQ+QzPGVUr8q2m+jrV3viA8lkbSADbrExi/7CqAPZhNHGC
         2bT/n1LUhtQ/fobYDOe4v3DNzxvsP2CGn+3kUJSKYgkKiSh7PWHRdQLOvO9BK5h5EWRn
         jFNxD+30YbH4wtLbU5xkrztZCO4gwCPOFyvqJ7wtlVVJVvUEvPjbiYFrHmPNlpO7h8vu
         myVsCi5V3IFrxNFvwOI9qORSWyM+xlcdA175LtDG63SP/VrbVB77/Hvxo8tBanfn93GB
         SWAfa2/QRlfWqXyuFK2GTwTSGnXoG7mWz/a8nM6onAxflLaniha8GuX77gn1KZOaRyjB
         GMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zWNzuFaTijiv75ae7lurm1eskwR3lUPUFEbAE4CNomA=;
        b=bt0eLORmQZt+S869ylLTgozrsTeGh5CRa1YueH/mu2v+E1jhxuIyd90lxS7AjSn0Ac
         6v45+i15E91yJFdF7nCnaqPG5/Gv/KRHIpcDsyHGLmcaHJfM3+QeIRcoaYxieF6NC+Ot
         GU80117m/ue/rbBidyUV9+K/8miE2MFrcVDEMRpb0F95dLi2Zsim2lSJ6YNBjUV4kBJZ
         qH2E64V/iKKfn8Gc5f5l6Oybg/Ne3yDjx3zhu0mE7DSlcakhLR5CjkTk9OusFCW1FqkK
         CpC2KWvr8en6bT5xQLG0gke/qutI37pPw5M+iLZ3ptPxb8ICaK89SgoXlxEFH8++Y0cb
         VFlQ==
X-Gm-Message-State: AJaThX4m1owy7Bpdcb8o+TIRd7yaNH+vpm80z5CBmcXicHv9IZQPiZ3G
        hNhsDiPB5lH9pHCdMNv6aL1Ny81bHQk=
X-Google-Smtp-Source: AGs4zMbqQXLkFXNvHlNRLD4jXXH7TOM0oAbUE9++rdXTsIS/6+QUwmydpS3BvWNBadJGL8Ts0Id7OA==
X-Received: by 10.101.64.130 with SMTP id t2mr15041823pgp.299.1512431954157;
        Mon, 04 Dec 2017 15:59:14 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id b187sm24939223pfg.109.2017.12.04.15.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 15:59:12 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [WIP 06/15] transport: use get_refs_via_connect to get refs
Date:   Mon,  4 Dec 2017 15:58:14 -0800
Message-Id: <20171204235823.63299-7-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081-goog
In-Reply-To: <20171204235823.63299-1-bmwill@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
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
index d75ff0514..7c969f285 100644
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
@@ -542,14 +538,8 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
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
2.15.1.424.g9478a66081-goog

