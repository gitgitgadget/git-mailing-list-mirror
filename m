Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF7691F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964979AbeB1XXg (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:23:36 -0500
Received: from mail-ua0-f202.google.com ([209.85.217.202]:56088 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964912AbeB1XXd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:23:33 -0500
Received: by mail-ua0-f202.google.com with SMTP id s22so2504861uae.22
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=5Ef9oVBgtMgc86gv8bOUlEvEO34Rhh1KT5WTtrLi9Ro=;
        b=fdaEK2YT83nCWTLdFuqa47nYUIHytza+atZf6ArCF0zXeou3r6u/xo5eUQrn2fTi17
         Cf8Zj84kThSPGH/zR6SR36FVxRD1IrN2vWEu791l09nLGwYZJg5enFqzGpylQ8rPbiav
         LsXuj8YwyqUk7+ufowhhU2PPscPRjjx3DCity5LCMfh3t9YoABjEBugrxIfX/UWiqJyG
         H2011cpHdVGYqzmt929A/iUqV3f4F5e5NpEfWHWU2J6Ml8Wu4noD1Jj6yixfIJCoJJ5G
         sgSQ1FfT3FyRQjx+kxOq71X5IqYMlymVkUmDOianqhZrmlpgNfeUPdMvQlP1pbM0+8eK
         xb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=5Ef9oVBgtMgc86gv8bOUlEvEO34Rhh1KT5WTtrLi9Ro=;
        b=lfOW6cU0y05hbydgI00+xODVo+Hy6yVo/OjTD7OppwAijccva35jMr1QxF0BPHav4z
         jG4S5pK+vUP45U8AbQaqN3RzlHlXEtsNVwF0XFw+v/C3IMzaMFOuD778UioXke/5vSmf
         Jcg1aV59dmLlWysxDAv57sglEJry8qMna3pomuhfeok8zD8CKjEnihotXnzqErnKNaa4
         5G+AV7rR8Zn4kiRdNPL1rYScfl+z4P2D+9MxlUQSQCdgOOM3GMoXmX/c01h3fu986prR
         7sxU7EBoq18Ud6R412Ep+vqrfVJY/4cXMLqyYSiklmK9u0fGU4t2jrMCq1DVjD2tT70H
         r7/w==
X-Gm-Message-State: APf1xPBSvyFxpJQ4Dps8fGNITR/24MuxGrvDwE6TT89IPYLjDpa8gt7z
        11HlJJW6Y5JLjF+RafOb3dxgoB9GIGzLlbA8IuuOrWTSoxL5u+xIqx9413Amnii/lFz6Fw9zheT
        MMmJOgVAE5W6JfY3pcmqUwrQw1v8JqfhVyZO+dcGS1rDepkew+n+OdrN42g==
X-Google-Smtp-Source: AG47ELtf+O61nCfcTZntf0/TXOuJex4ilTx1cpdZazx57E2geiBOpyYvaXHNZqYQDZbZB6oBfACElJHnWyE=
MIME-Version: 1.0
X-Received: by 10.159.43.8 with SMTP id p8mr9751154uaj.44.1519860212461; Wed,
 28 Feb 2018 15:23:32 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:23 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-7-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 06/35] transport: use get_refs_via_connect to get refs
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
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
2.16.2.395.g2e18187dfd-goog

