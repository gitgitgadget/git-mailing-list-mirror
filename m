Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 051801F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeAYX67 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:58:59 -0500
Received: from mail-ot0-f201.google.com ([74.125.82.201]:34684 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbeAYX66 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:58:58 -0500
Received: by mail-ot0-f201.google.com with SMTP id v31so6024166otb.1
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=6GebArzHPqploqzwqHpNiYESbzra3QL9shmQCtnpUhs=;
        b=j3zw2x8e7eSvc8Uraq4/Rkl9cPXQm483uPeDPChfs4ZiGZu9ku7fLMfZoHixfzg29t
         j0A7HQ1GTUOsHouu/+LfTrSlE+0B+jjQCizQ1GG6bwfQ4nx0XcPV4LK/kHOVERl4bz8V
         c9e+UPnbgU7Rv7Whzn77fHbLikKO+7qLeYFdlhnFs+LiNFnh/SJgvfjuqo1ayWSidbVu
         u+ED3JpjDRopmZ0WXcYuDitqVeH9DGvb+PHqwDS11dIrfphq5ftabG59Bb+UAwP9xhjN
         DqkqOZuE6becPxRzHRwoUXnY+PvuVMme0+AeoDHyyziXp2BRDkce78xWbDjLpf0DvUAS
         uXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=6GebArzHPqploqzwqHpNiYESbzra3QL9shmQCtnpUhs=;
        b=Dwyqqe2ywLWyBQMJJC/HIlTb0MeRj+e82VeMBdCTZF/G1GoAy0oQQ8cCGLvw21PIwP
         3Vy4Q9HKpHYJWQss5x7X8zSLswNqv0lW2TpzCWPcq6PLg/maTPgKukU5IwhUgjeHiV5J
         5V22q8AmOOP5kF21LjwPqrpRgyx73sXOee3J9tIwNAqIo8AKCb5zQI2cpzdbe2IIsnhI
         8NTWfkCpehp1RPQJ/4B3ICRvj1Y9QiakrQT5SYG4GnfjWHGcjnQEPGNg4dWnNmwJ9AR8
         LOyrRo8mA+abQYTB7/3sY+JB70ZKTjv0/RXJxzy5moHNa6cx2D/k+Px60IE8a78kzT4v
         bcoA==
X-Gm-Message-State: AKwxytcybclxu/ok2qAVCaKeohbMhyEE0ATUFoRqK3ZDwQ0D4LcmaMRy
        BYSJpcJh3CL9Mdbhe50gJxBm+ofHZzHxDugfMlBhq98SpTgbupBH+ycNHR21maUOdQi3Qx9zkq2
        wFseRlCndEdnEGeSELJqUbG5FOWvUSN5ZzkyOS3Xgeotrtr1hciJe5tUaHw==
X-Google-Smtp-Source: AH8x226r7RgM/QffXXRbC5sLzlmr3wIYmFDC25ZFlSxJcVik7Yreg+aVNs/40F+oSPU91fltIJT2G19vtHc=
MIME-Version: 1.0
X-Received: by 10.157.17.23 with SMTP id g23mr11310400ote.14.1516924737549;
 Thu, 25 Jan 2018 15:58:57 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:17 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-7-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 06/27] transport: use get_refs_via_connect to get refs
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
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
2.16.0.rc1.238.g530d649a79-goog

