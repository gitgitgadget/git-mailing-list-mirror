Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8429A1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeCORcE (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:32:04 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:46380 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbeCORcC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:02 -0400
Received: by mail-ua0-f202.google.com with SMTP id y43so4733993uac.13
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=pHmOLUi1wos6OpZebzLWG0MCR4Pl3vXTfEGRx9c9RQY=;
        b=rrM7L3TDzMOINCO/3oAlXQc/Hsw6rO9QXUdXoSGXZCx67+RJ3krIIjQJi6PDDhHsFW
         N78h6zS+r6nv4bvkk88jelicHUk6uOCbC5CEv4HD9LiyLQfBLlhc8hSG0PkQDbTnlnzh
         +K+jx/o+WUQ4ZoBdtqa0FRHHHTk8woh/WEJDAd32rgnJ5xp0HfqjWO3Ui4SHFRwxUrWS
         no3qhE0uIMVeT9WeaEzjZ+r/8iTuFk/1jR6a1hix5Ndi9LIpAvUvWiFOucd+6bZ44JLj
         Ue6jNTz7zplAfbBrOOHOkLaNx37mEzOGbsozZfc1Vfo5Hh9myAMcelGlRkTv3pkCApjU
         sw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=pHmOLUi1wos6OpZebzLWG0MCR4Pl3vXTfEGRx9c9RQY=;
        b=qvehS+4JLcXTD77xtcxp19jD5UyiLUs65wKIIH0l5DZJPvXXv4x/lfRijjhCWUglqC
         /yxBwL7x+IO6oenr6caJjw98WMFubQus+yDrn9mxkUmInfy/duqD+1q4atPEwSP40lFR
         lyAILTnoc+tgeN4hAcgzMpB0OSWIcbg5lkNIYeCFk7isVC5dIYpoXs+gAHhRvX7vcEKp
         kTFnaRiB6Sf/XaaRRJL8tEQQLffXKpmtJQ0NngUTUzuvLE8/yEA/Wq4lXwAGlObx3E6U
         EfLTsggkdhV1a5r6BlQaPkfl7FTRhpsMCabR6gbI6yAGs4NDWWOxAExZOZ9hOu4XUfJy
         BNeA==
X-Gm-Message-State: AElRT7F3tYubGFapIahnlaiglFXtNR35CzvxCr3yzNODTlnnJPa+xGFM
        K0yB0fRtw8qmOnJm6N+tqG1Q8/G1URtVBi7XbIU5l7g6bT8O136VdZvOj9LJm74isWcjcdmYG1c
        jzqZT+guyTNqAgOGpdRQrpcQxxuMkhBd0qYp9l5YxqqOIUabjzGZpYiFygA==
X-Google-Smtp-Source: AG47ELu4pxELgckbUqqqZswy4ARa55f2yIQ+Dxv5jxnD3sE71qjch3h4XH+gLS4vlNQR+aQCtcTqyrxXD9g=
MIME-Version: 1.0
X-Received: by 10.176.18.91 with SMTP id s27mr4029855uac.70.1521135121277;
 Thu, 15 Mar 2018 10:32:01 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:13 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-7-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 06/35] transport: use get_refs_via_connect to get refs
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

