Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5424D1FE90
	for <e@80x24.org>; Tue, 18 Apr 2017 09:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755948AbdDRJaA (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 05:30:00 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34878 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755123AbdDRJ3M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 05:29:12 -0400
Received: by mail-wr0-f195.google.com with SMTP id l44so23827597wrc.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 02:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B2oo4ILeJKhqDYrPeezKigpiULsDd7ZFuEnBMx3m1vw=;
        b=QaShJLc0aEC6PobU+h/u3L9kJjOyS8pz6ZuFCuzA0qDi6WGE+AzhNScBtcJmte7iYq
         eBp4bzD/fj6Z7dwbGoyHrAYFoYL2Nccg+k/418PJe9YQBuuac3ZFgplm4rvhrlFNJqwE
         gcbB+xMAPpBPzYTBx1sh2bl8H5I7VsGUyb7T8Ittx9fk4H/k9SCw5qWqvDWYEd5oBTp0
         SZ+Cses0Z8HD5YeDHmSt+WlT+rJg/nd6NsMljXm0gbFEHqvqJ/bEuPTLzNEuew+kiyyZ
         oPcrFMTABCaLGSrkYRnHWWWWgNteA5FOzc/Gr7WoR4MVQrz1lvi+JpZNQAfDLt3Nw4rt
         9Aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B2oo4ILeJKhqDYrPeezKigpiULsDd7ZFuEnBMx3m1vw=;
        b=e+f/76XNz/wRBrqpEu7tKFNB1PL+NxE9bDY9VKLPaEShyqnNI0KdO1P+JxhH+lwtm1
         QK/a6bDS/IourJLEtfY3QZSU7RyUZrgScNef8Dr62Y28ff6q3IBx4Ctt72VwuLoSFFqV
         GXr89XD7fVH7Ok5K+gKhHLXNNOjeX34HPssJ4WjPkR6xhzavZUnE0EVowqByAg1XTcJX
         iqRFUnB8A7puGVzAihBZOQN+xI9mpQcVCG3gCcsK8Piv7woyIkxYlAB3h+2OkFtzRLEA
         +LyHuyaVkKESQ+UvQtHF/Us+fwQWU6msWPaVN1MYoZhiKdeSJ0REnxWGEqCV2/d5woHY
         rLhA==
X-Gm-Message-State: AN3rC/7PQI0o3DxL/d2aR9TDqxBf/+Fehqgc0+/Mi81nWW7bpKTGodxW
        Gq2kNvrA/vFK5Q==
X-Received: by 10.223.135.7 with SMTP id a7mr21544773wra.103.1492507751122;
        Tue, 18 Apr 2017 02:29:11 -0700 (PDT)
Received: from localhost ([193.206.223.117])
        by smtp.gmail.com with ESMTPSA id c5sm13107269wre.60.2017.04.18.02.29.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Apr 2017 02:29:09 -0700 (PDT)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v4 1/3] builtin/am: obey --signoff also when --rebasing
Date:   Tue, 18 Apr 2017 11:29:03 +0200
Message-Id: <20170418092905.20097-2-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.12.2.820.g78c033c3a1.dirty
In-Reply-To: <20170418092905.20097-1-giuseppe.bilotta@gmail.com>
References: <20170418092905.20097-1-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signoff is handled in parse_mail(), but not in parse_mail_rebasing(),
since the latter is only used when git-rebase calls git-am with the
--rebasing option, and --signoff is never passed in this case.

In order to introduce (in the upcoming commits) support for `git-rebase
--signoff`, we must make gi-am obey it also in the rebase case. This is
trivially fixed by moving the conditional addition of the signoff from
parse_mail() to the caller am_run(), after either of the parse_mail*()
functions were called.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 builtin/am.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index f7a7a971fb..d072027b5a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1321,9 +1321,6 @@ static int parse_mail(struct am_state *state, const char *mail)
 	strbuf_addbuf(&msg, &mi.log_message);
 	strbuf_stripspace(&msg, 0);
 
-	if (state->signoff)
-		am_signoff(&msg);
-
 	assert(!state->author_name);
 	state->author_name = strbuf_detach(&author_name, NULL);
 
@@ -1848,6 +1845,9 @@ static void am_run(struct am_state *state, int resume)
 			if (skip)
 				goto next; /* mail should be skipped */
 
+			if (state->signoff)
+				am_append_signoff(state);
+
 			write_author_script(state);
 			write_commit_msg(state);
 		}
-- 
2.12.2.820.g78c033c3a1.dirty

