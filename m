Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99178202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 20:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755261AbdKAUfK (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 16:35:10 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43830 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755260AbdKAUfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 16:35:09 -0400
Received: by mail-wr0-f194.google.com with SMTP id w105so3043328wrc.0
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pHYA3S/0Q3bQYt1OAgQaO7BtIstJ/aVFWEzCFCAB5WA=;
        b=Q+iVRj6CG6dq3nJT6Ob6ee9yqorhYIgZU5RxQ2rSQWJF1difDbFX435B8r3+LcQYDd
         4e1/CFcRGlEIDLaR2lsfL4o7gXvirkc2OEzyX9yqIxxuoXDd8RqogNQ41Q69bzzhhjV4
         YLIzERV2BaOBzVHcR1dkkfJfdFiYnbu9uadLaXQ8k9WrGppnkfRIahEpQnNWs4MqDCfO
         yBoclXVRCiXEhS6CwX2QYT3OyDkyKPNAxPOsB4JEN19r0rK0OTzzREekpS+tqxRWXaGK
         UtQB+Cq9foy42cwhIdNnUBmTGS7i5Ex1lBT9Key+dCiaTMl4Vfmpmz5FXkgrlEZVZsBQ
         1uoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pHYA3S/0Q3bQYt1OAgQaO7BtIstJ/aVFWEzCFCAB5WA=;
        b=d9wb4cT2NZOuFXxu4CQz6IoIzU1nJFYnPL7An66T7IOc3OjsWiTJu7EVwEI+GHev20
         +JVzsXmijjoFUG9PYp9SNnpF8m0zl2Nxduwn/KJyjpyGB8rHQkRzzMs4pmXiD4aJBY4/
         Fi/lYkyOfNxVttlSJoQD4b9bDkgbUJk3Gk87i21WuYhPOJBsAs4L/o6yySl6Sbm6QBMn
         lbcZNx4wFJQ2i4fwIGar+MSB8nKtcIaTvpK8wsYkUjwYm4/9NOY4K3TDJhCEvb8i5nWS
         9Hx6bIcPwjcV8cEA3sFxFIvKY4L1hhAjJQpmnGuLQrnU4gmqxs8EhGKE+TYKo/hAVMyW
         /5sA==
X-Gm-Message-State: AMCzsaVEC/lu4uG6h7n6q4Fx/rFIWnLQ87S2hGIjAOILLEuJMEwq/q/u
        bVSCt8KbMIAUv2ilx1GQj1owJtjRNs8=
X-Google-Smtp-Source: ABhQp+TN/2aIeySMttJgz62qhhYWFX+STu6x3tFQO4u3IKGtB8J8P9q8DG6VFGIWh1kxBHTUk11tHg==
X-Received: by 10.223.186.20 with SMTP id o20mr932514wrg.3.1509568508054;
        Wed, 01 Nov 2017 13:35:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id m8sm1312235wrg.55.2017.11.01.13.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Nov 2017 13:35:07 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 2/3] bisect: fix off-by-one error in `best_bisection_sorted()`
Date:   Wed,  1 Nov 2017 21:34:38 +0100
Message-Id: <f2bfca40bc6f9a0146e2699cbe2e569c67573e76.1509557518.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <4795556016c25e4a78241362547c5468877f808d.1509557518.git.martin.agren@gmail.com>
References: <4795556016c25e4a78241362547c5468877f808d.1509557518.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After we have sorted the `cnt`-many commits that we have selected, we
place them into the commit list. We then set `p->next` to NULL, but as
we do so, `p` is already pointing one beyond item number `cnt`. Indeed,
we check whether `p` is NULL before dereferencing it.

This only matters if there are TREESAME-commits. Since they should be
skipped, they are not included in `cnt` and we will hit the situation
where we set `p->next` to NULL. As a result, the list will be one longer
than it should be. The last commit in the list will be one which occurs
earlier, or which shouldn't be included.

Do not update `p` the very last round in the loop. This ensures that
after the loop, `p->next` points to the remainder of the list, and we
can set it to NULL. While we're here, free that remainder to fix a
memory leak.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 bisect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index f9de4f2e8..fda527b89 100644
--- a/bisect.c
+++ b/bisect.c
@@ -226,10 +226,11 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 		add_name_decoration(DECORATION_NONE, buf.buf, obj);
 
 		p->item = array[i].commit;
-		p = p->next;
+		if (i < cnt - 1)
+			p = p->next;
 	}
-	if (p)
-		p->next = NULL;
+	free_commit_list(p->next);
+	p->next = NULL;
 	strbuf_release(&buf);
 	free(array);
 	return list;
-- 
2.15.0.415.gac1375d7e

