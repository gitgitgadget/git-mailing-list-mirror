Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B84D21F404
	for <e@80x24.org>; Wed, 28 Feb 2018 19:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933004AbeB1TIV (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 14:08:21 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50532 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932365AbeB1TIU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 14:08:20 -0500
Received: by mail-wm0-f67.google.com with SMTP id w128so7154404wmw.0
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 11:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VCjLvuDkNdDh1n4Eb8cYOItgvxyIpCOjJx3JQ1EwTSw=;
        b=MToCStKhS+bce4Z8fxo25JWTUW+grTDY72xR5dfpJOdHPOcrZowmausnRLbGYhG50Z
         N//7TY6uOT5dFpkeTtbpGvBjTeZ6nXXF1LlZ26ol6TEnh36MZ+/kY2XDJ/+uSbyNZaW5
         pPZnda5oA1eNM4H9WHmy9bZT1JIetvkQBVi03VXCWNBnB9EsFK62ibfEuW35AoFEPA/I
         dzocsiUN0NF0ttkiGOjF2PJfmEzRuLzVGQ27t+L+CuQ9WqRNZMQImTDkW30LlasDsGi4
         uc9Wo4z+zTu+u9P58mHLwv6MpJJ/dhX0BS0Plb6wW85C9x75FOHBFFWm2gYDYLiwY8FT
         mAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VCjLvuDkNdDh1n4Eb8cYOItgvxyIpCOjJx3JQ1EwTSw=;
        b=fEGUDkPuoVCOv9cuk907r99oXo7VHzzJCCUrvMaE8d+rp+Whex7rF9i0kHxsQtDEH4
         4GWq3FT1VMTHx5qkI6X+NgRhNQ101hg9djCRVXi9COt//7qHiOZdEPJsoyOkEpd+yo6v
         giV9WGYoCKqjGRREsCC30AmH4Rp4REwXfHR0KB+7VYAywLRRLDjjrvmqzqL2Ps+tvfTO
         LP5gSuuW5uqAOGx1trF1k1Ipm1m7XTiD70TJgepFGTqyK6AlJEORQwBCPnlEBM674Zq2
         g3pisAO+2NwD6yJ25Cy0ZAiyZ4HRJ878XmxLqJL3ZT8pkLYUpTTC0Tw3GgArq7UWtO/Z
         mwJA==
X-Gm-Message-State: APf1xPCCgflKVb0xYPNCdtO1JQm937oaE9Xoelz4YUVUgFWbzj4gHODr
        uhn4SFC3LfU1figQFyVx6fcQCAvm
X-Google-Smtp-Source: AG47ELthDZASwH7QGS/1QG3dVUlBhTwN9rjMQSbjrWelAT1BS8GRRRxW9AnGiGKqdsdgmTJEoS39nw==
X-Received: by 10.28.43.199 with SMTP id r190mr15820300wmr.58.1519844898652;
        Wed, 28 Feb 2018 11:08:18 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id p76sm2832609wmb.19.2018.02.28.11.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Feb 2018 11:08:17 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 2/5] sequencer: always roll back lock in `do_recursive_merge()`
Date:   Wed, 28 Feb 2018 20:07:55 +0100
Message-Id: <5d657ac87d1e71fd95175faed2b591fa609b8f1c.1519843916.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1519843916.git.martin.agren@gmail.com>
References: <CAN0heSqmWAN=rCO8busGtb0xNPiB5H_jkL664qH8xasPq1Sy0A@mail.gmail.com> <cover.1519843916.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we return early, we forget to roll back the lockfile. Do so.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 sequencer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 90807c4559..e6bac4692a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -465,8 +465,10 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 		fputs(o.obuf.buf, stdout);
 	strbuf_release(&o.obuf);
 	diff_warn_rename_limit("merge.renamelimit", o.needed_rename_limit, 0);
-	if (clean < 0)
+	if (clean < 0) {
+		rollback_lock_file(&index_lock);
 		return clean;
+	}
 
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
-- 
2.16.2.246.ga4ee44448f

