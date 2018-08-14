Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBFAF1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 01:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbeHNE02 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 00:26:28 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:37006 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeHNE02 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 00:26:28 -0400
Received: by mail-ua1-f73.google.com with SMTP id w15-v6so8824901uao.4
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 18:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Pi8Py/+Ryx0h5DauzM8bcd/r7qDgDhl8V0ff3ZVQX1I=;
        b=Eh3cXRO+akvDTTNz38J23JPIDfRh6mjG0RRj8VS+Vw9dsOVKxOuc8or658PeuP0WOM
         ++gcnDy3o4ZLlfi5J7TPUvkbzV8d5i4VDFywwpQBZ74NI+pzjAESIR00eJzN1b1yB6RT
         vAgYSlIQFY9pfYoGQuvyXOLtjlZJm2GbuYbdpSnuc7m35I+5f7E/FR1eS5CmbkyxThEZ
         E6v1eHAhOycYjdweFtK44AdjV8TVzdlzw4vvzP1JWZnJ+0TYLnI8rn6eGCWyJl4ifI3B
         0MTEltPjZR4pB4bUOJF3hD/wFKrZb9wcTbEmEZ7CAonD2FwBkcpCLiM5TrtamzdlPkYm
         p8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Pi8Py/+Ryx0h5DauzM8bcd/r7qDgDhl8V0ff3ZVQX1I=;
        b=BIGIXuryRJZ3sHEMvnKoykm6O2GarHEARxE9C8qKOGJHaAuI1JhkJD1uthbHDEZEkp
         /kj5TPEqttdPuwfoXQnk4OvyAyjaz5RSMlld/hWe3zyxOFcURBIVz773AweqPedO9Bus
         771jBXbxHaSMrBNHb6SwrbdKlkUIIG9K7msJKKUUQH3YYU8x0E8QJxBrTEWagViY26kr
         VSq674VqR7xFU77B1mAf+JManatjj270uyElnUh+IpOeEbWnBfUCYglVTOY0T07Fg0Le
         7BKHJ7a7DIkHVPjS+RBq5chyEX+lmUtdBHfs/72aeW1JSmzcb9w7OAeRSbsNEDE2mckJ
         2sMg==
X-Gm-Message-State: AOUpUlFSej+7Wx8iuHmr+bA32qFp1OQyjJOT4ApeKwTUHcwwOu+jZPvY
        DOosN+WmVeBUwD6Dq2RmqorgP82hG+YS
X-Google-Smtp-Source: AA+uWPyihzGZwOUCWlDqjtdG9fSvh+IFblkQHR1Y2NoK5HE+AognNDgLODqm2GvJbqXK0jVm3it/C3NvEvZZ
X-Received: by 2002:ab0:2398:: with SMTP id b24-v6mr9623236uan.26.1534210897768;
 Mon, 13 Aug 2018 18:41:37 -0700 (PDT)
Date:   Mon, 13 Aug 2018 18:41:17 -0700
In-Reply-To: <20180814014122.30662-1-sbeller@google.com>
Message-Id: <20180814014122.30662-4-sbeller@google.com>
Mime-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com> <20180814014122.30662-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 3/8] diff.c: simplify caller of emit_line_0
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Due to the previous condition we know "set_sign != NULL" at that point.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index ae131495216..f6df18af913 100644
--- a/diff.c
+++ b/diff.c
@@ -1202,8 +1202,7 @@ static void emit_line_ws_markup(struct diff_options *o,
 		emit_line_0(o, set, 0, reset, sign, line, len);
 	else if (!ws) {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
-			    sign, "", 0);
+		emit_line_0(o, set_sign, !!set_sign, reset, sign, "", 0);
 		emit_line_0(o, set, 0, reset, 0, line, len);
 	} else if (blank_at_eof)
 		/* Blank line at EOF - paint '+' as well */
-- 
2.18.0.865.gffc8e1a3cd6-goog

