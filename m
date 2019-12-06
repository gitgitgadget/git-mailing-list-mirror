Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA8DC2D0C1
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EBE2464E
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3OaAkPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfLFNIh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:08:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37684 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfLFNId (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 08:08:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so7734208wru.4
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 05:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eiKsWnXfCifGwtnKbfJ/FV46yMNv3C4tpeaajrVzSpE=;
        b=A3OaAkPJ4uQnr6pDzzkXQzxcYOeafCW9Yl/U9lTN8sUHumKVCxHFridNfEpk8SDId3
         HuPsLftjA3bfs+Z1O5tdetEafQH9IHR7owmlQsSg1VEYSLycX4goWbqqQgV1jNCI1YGM
         9M/Q0yfFc2AWpcJd8dFa0etPtc2CpC6yDULgEco3k//vQByeLbNqa8T5Y9J+JioBAbm6
         0a7rd7uhO9nTvgi296Z06AbC/VT0SgIeyOfr5+OqFcsqtB7NiaM+5QIrdDDPn4cS9HIN
         0wQX+jYKzFGOSjwsYkzvQ+TBkVkL+BIJdL/OMc6I99ld1Gyc6fxC3kw+vrcMm0ybhP1f
         llnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eiKsWnXfCifGwtnKbfJ/FV46yMNv3C4tpeaajrVzSpE=;
        b=m7Kc5Wewu6zj5EDEnVhksFMiT7vi2j/MAnAN0UH8ckKbZbF9bsYglQbjADvQS8/DOl
         idjgAVBJttHpkZi+9binWe7hmCknNgmtWnCaWl/ZONQOK7vep/08Y6hBToJUDSHvE7Rq
         XaBXriX3nI8iwIbg47tYDpcY4nO4mvGA356wJeom6+/Cb9aL7+1jXNV+DlS8kmwq3LQH
         idVUmqxXj0rQpCkidRw1GH9YBZuAnK+LeS5ZEuVFZzeucbK2uWXJ1kgsUBrc4ZcMXi45
         Sd7PIpxKYfElHr9umOa111ZqxXaRNOKZd4fStOrmUqQAdMTSDm1kc2heBWgi2kARD6zh
         Y3xA==
X-Gm-Message-State: APjAAAWqstfTXSGgJWV2KrOPM5uMw1GSkGz+7UHdstsEmIPNnypM2Xr3
        qHk9IJ+tZOvYLG/jK0Aeal7qIPMw
X-Google-Smtp-Source: APXvYqzWwJvihIMaRwaGiQ/JcUBDUXLwDSWMkHiz2tTjiEjhupTb5wKuWO/whbsmYP7D26HPR//VBw==
X-Received: by 2002:adf:fa0b:: with SMTP id m11mr15615361wrr.98.1575637711932;
        Fri, 06 Dec 2019 05:08:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm16122502wrt.29.2019.12.06.05.08.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 05:08:31 -0800 (PST)
Message-Id: <15c4cce5a027d56c7ddbe5523cf0f3beabd06ed7.1575637705.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.172.git.1575637705.gitgitgadget@gmail.com>
References: <pull.172.git.1575637705.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Dec 2019 13:08:25 +0000
Subject: [PATCH 7/7] apply --allow-overlap: fix a corner case
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Yes, yes, this is supposed to be only a band-aid option for `git add -p`
not Doing The Right Thing. But as long as we carry the `--allow-overlap`
option, we might just as well get it right.

This fixes the case where one hunk inserts a line before the first line,
and is followed by a hunk whose context overlaps with the first one's
and which appends a line at the end.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 apply.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/apply.c b/apply.c
index f8a046a6a5..720a631eaa 100644
--- a/apply.c
+++ b/apply.c
@@ -2661,6 +2661,16 @@ static int find_pos(struct apply_state *state,
 	unsigned long backwards, forwards, current;
 	int backwards_lno, forwards_lno, current_lno;
 
+	/*
+	 * When running with --allow-overlap, it is possible that a hunk is
+	 * seen that pretends to start at the beginning (but no longer does),
+	 * and that *still* needs to match the end. So trust `match_end` more
+	 * than `match_beginning`.
+	 */
+	if (state->allow_overlap && match_beginning && match_end &&
+	    img->nr - preimage->nr != 0)
+		match_beginning = 0;
+
 	/*
 	 * If match_beginning or match_end is specified, there is no
 	 * point starting from a wrong line that will never match and
-- 
gitgitgadget
