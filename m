Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9CBE20985
	for <e@80x24.org>; Tue, 13 Sep 2016 04:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbcIMEq0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 00:46:26 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36003 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbcIMEqW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 00:46:22 -0400
Received: by mail-pf0-f182.google.com with SMTP id 128so59453124pfb.3
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 21:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0qVB0Mjbv7+iYRkMfXixRodV3hMrxOTDDaG//pNy220=;
        b=jmSAWa60KNwHPGGbMfULpot3I0YwdQ1d1x/P4qa5kPiA5o//WAzqqNURutbMthogpK
         XPN2IeLW27TEdE4uCXeFRld38+rf35i+p4J5vlVLahXJl3ivNok5+o+a/1HbdFZhOD8U
         M5tVVHFr+Ggp7xaaTqLwPjJD9pnPLDc6nzYyouOlQCs3GvUl6J+JxOgkw6WtRKKJ+WBh
         A5/L8nrUUPV9fu45QHTZP1BRon4CF82NYUNm8ud6c+vOyEWE0Xj80IBwO0RG+N+hEop8
         G3COQ17efcz87EZ5mbnlpDC++0JrcqGVwEsfzLY7YGkTK+0gt10UGprU/Kv//0um0kVr
         Tafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0qVB0Mjbv7+iYRkMfXixRodV3hMrxOTDDaG//pNy220=;
        b=i7HydNZwwvWG4HjIyqL2iq+UjDbTtIQAJLMQoLJy0DrhbfAZ7ChuicWMdJIJEE+JsW
         0fAHAxNfdIraucLXom8AeDk4nS97rtAPgTQjvSgdClE8AqPIRdsa+9Jv+PEWOcqhSVKU
         YVk6EhuGYeMDi7wB5Z+4TUXdcU0+xClnlG/o5kD4xxDLrT4w3vPIxZPLijCikd19ck+A
         LtIZ8jeFS31IEDj18jopSJtHBTvpCjLdKqXmMgWweYpmSbkjFz1hQnemDQWQ6ly3rrhF
         Th+0D3F2T7fKI/L684ctuI1giXyk9ODXgtISMFWIofTOh+Cwrv75Pievc6VAmSB7vxrF
         Jtmg==
X-Gm-Message-State: AE9vXwNgqBlGnShAg4Vb6sEDxFwWxu2FA5PL5XmWlmu5HfoRowEB4GKZoTadZ5pEAMxXgrnD
X-Received: by 10.98.59.21 with SMTP id i21mr16124468pfa.78.1473741981898;
        Mon, 12 Sep 2016 21:46:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ddae:e087:e1a2:ba54])
        by smtp.gmail.com with ESMTPSA id ps2sm27892968pab.10.2016.09.12.21.46.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 21:46:21 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 03/17] diff.c: drop tautologous condition in emit_line_0
Date:   Mon, 12 Sep 2016 21:45:59 -0700
Message-Id: <20160913044613.1037-4-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.21.g1da280f.dirty
In-Reply-To: <20160913044613.1037-1-sbeller@google.com>
References: <20160913044613.1037-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `first` equals '\r', then it cannot equal '\n', which makes
`!has_trailing_newline` always true if `first` is '\r'.
Drop that check.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 156c2aa..9d2e704 100644
--- a/diff.c
+++ b/diff.c
@@ -460,8 +460,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 
 	if (len == 0) {
 		has_trailing_newline = (first == '\n');
-		has_trailing_carriage_return = (!has_trailing_newline &&
-						(first == '\r'));
+		has_trailing_carriage_return = (first == '\r');
 		nofirst = has_trailing_newline || has_trailing_carriage_return;
 	} else {
 		has_trailing_newline = (len > 0 && line[len-1] == '\n');
-- 
2.10.0.21.g1da280f.dirty

