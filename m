Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809C61F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932191AbeBGBNd (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:13:33 -0500
Received: from mail-yw0-f201.google.com ([209.85.161.201]:42320 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932165AbeBGBNa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:13:30 -0500
Received: by mail-yw0-f201.google.com with SMTP id x68so4451513ywx.9
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=6GebArzHPqploqzwqHpNiYESbzra3QL9shmQCtnpUhs=;
        b=cW64d02qCiZHEB0zliWWNTGggP+jjvca4xHSLLf+l8leELfatKgpK+i2CL9xWQjEZ5
         OiRWneLycJ1epVSUepA5dxmM0TfrBAPsdP8V3xnFWur9Uq20coKd4j2HgyF/omalqCZq
         s+NXz8sTv9uNRGF3OQvcK8WUu0RanRyAvOxcPRt5haQVsvIhsikpun2k1hy7cEqPHCEL
         5MzQCRDxgc2NrEOmzXTyl/C3AWpbQHJXqrHWoSHy+asX3UvrgMx+uJq7CYZqLcf6ezdV
         c3VSShiE89XeXLZ4aXABgzht6I+s+2wiBDSsbEfLkgb5qERFbuiH2g3/HC9orQVL35mH
         ZYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=6GebArzHPqploqzwqHpNiYESbzra3QL9shmQCtnpUhs=;
        b=CykxezMfXTNxmPtm9ZV1CtJAc/wBk9DxaZQQjTyHkJrV3h+ljoctb8yCub5UxMzAiM
         U4LfTKzi4e33y+EeTveG7d5Ljjr27yKznMtxP7jqaYid9sU5v0wNKQBwZuSZdgjUv7z+
         k29N4waX+LMKidhfwzCCJTbbB1gY3fNn9/Rf7H9lAUr3ezJtVgpZ5Fj2cq1ELWWdCrAd
         rpEV2gWzGnAxWofitMXKYwITHfgmDf3hPrnUm2MdMZw42LnWbPvnzvnK4yAncGAaCO4e
         MTeeThv/ZUdcaLC+WjlbKiH4iidjWDLvm0wBlqdpqNnLNO8Dixu3z7VaOk1nS/+BQ1yw
         7BdQ==
X-Gm-Message-State: APf1xPCEFMj0dGqOANDSPJnBbVTW43Sz3L0bkxiFGD/2+jJM/Ew2GpC3
        aDGcn206bzlU4C2X0DuK8r2aURVoDvq2GZaMmfKQ9TCzVgnhqTwJjsuTyZ0i/XQccZ38FAjzgpM
        Gn5ufy/ST49ViDu8GFTcGRtnHUC354TW+WvAlZBel41eONZSL0yN+22XzZQ==
X-Google-Smtp-Source: AH8x226BQ6Vn6N1fgx1YrBPrflNNBUqKyiN2C6D4bKAK9DKF7v8magqfeUOZSeHbR8dCpaXFZNSAizsSBQI=
MIME-Version: 1.0
X-Received: by 10.37.164.200 with SMTP id g66mr2214847ybi.76.1517966010239;
 Tue, 06 Feb 2018 17:13:30 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:12:43 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-7-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 06/35] transport: use get_refs_via_connect to get refs
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
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

