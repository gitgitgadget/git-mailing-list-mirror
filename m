Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC9171F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeCNSet (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:34:49 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:52301 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752350AbeCNScc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:32:32 -0400
Received: by mail-qk0-f202.google.com with SMTP id e6so2688979qkf.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=pHmOLUi1wos6OpZebzLWG0MCR4Pl3vXTfEGRx9c9RQY=;
        b=qay0no728+0pox7CUL4mfnzENDNUFipMrU32FUfGWXFyZMfxDlHS8JAHeEn1euEpSx
         CmbuMYlj4XqvTEZQoDI02Pc4Vh9Mr8lzYskqVSrgKngz/IHS5lIJVW65sqqfrDbnhmc4
         653w1HJm2O5KBPj+QjljhWwLaS5+bAmXkqzA7t6AJcxH8eotm1ZWVChKghikAk4e5cjE
         y33zg5kqpOFEmjKjqEB/cAFrvT3/SZHzrnpGE4ieWoPrbov3xLBbIq/TRU5hklF9YWDe
         9cA9AkZuI/k4eHNnMg/CMijjTwdNI3p1nrJmulNn23H3K1r9jY16heQ50JRfu+/6Iqe6
         MXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=pHmOLUi1wos6OpZebzLWG0MCR4Pl3vXTfEGRx9c9RQY=;
        b=NH61g9SiddjJ97YuRSvJjpCD8ilztb3JIe4FGt5RVmwE0dFLWbqUBoc9HNx+oAQFp0
         LgbZsLO0iDjktmUUBlGnyk/mmiIXNTFedimfrUPWLQJz/ZyR6FrFkLxZwYcTsk3GD8N0
         qq6UEXT683TE0+3T1BAuS31RfCdSzptM6SyKWmsRrHvFc7G7KLczjPKDX4d8tJjT/ECw
         feZIovLhNJglGDO4jiAwGkv87B4JHrJdR5RjZAaj0/CDctGjt3waxkRTDvCKzRLF1a08
         qORCqpkykryshPmZAgtk1Hh6DgIm2E8i5mT6sw29OVJrWSVEFwTxSHycfFksB/rlrRW6
         vaGA==
X-Gm-Message-State: AElRT7E1kw4lS8WXSw5Hnj5vgxLeW+ra44edvfZ5xr1mW5UebzhnpxIC
        pvXYKMazhB64ImVPpOUYC9OA/sDgccnTcFDjFXp4v2i0uY+c6pidLN9uYrL3geGDDUJqXDKdtgo
        VSrYCX6yZ+mzxoLF2MpX7aRZdM0LKZQ3jI2U8oljCsSOFGc73Bnch8ByGPA==
X-Google-Smtp-Source: AG47ELvBGCvoIH3wzUrnAT6EGY2l/Y/tQq8zLvJk7JbXWBxdBs4V6RH3MIp6hIctuAiazKIZeOR5Dvn43xc=
MIME-Version: 1.0
X-Received: by 10.200.12.10 with SMTP id k10mr3622623qti.46.1521052351275;
 Wed, 14 Mar 2018 11:32:31 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:31:43 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-7-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 06/35] transport: use get_refs_via_connect to get refs
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
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
index fc802260f6..8e87790962 100644
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
2.16.2.804.g6dcf76e118-goog

