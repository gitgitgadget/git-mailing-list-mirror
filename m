Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1103D1F859
	for <e@80x24.org>; Tue,  6 Sep 2016 18:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938813AbcIFSIp (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 14:08:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33824 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933062AbcIFSIo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 14:08:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id w12so10312570wmf.1
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 11:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8ROvhvAY5XQF51CXLZN/ZOAIuZ86qKrdLZlR7MBua6s=;
        b=RoqG81NwTcJLzzvKm2/KQINQbiy+A3GjSo/CdzlpJy573dkcteUNnnkYF099Wo1CqX
         hVIyufM7YpowmBRo1SXiET1pZ2N16lPRe9eJ0Sq+6RS1nrukGrfODsJ7nZGuLEUDW7iI
         1NmhfEnl95mBhqZIXuI1DaV3o0bq48l5afLtMtlwQLc+EJFZqWauobi2/B63MTpKMKZs
         jfMUrSP73G479LqryL1Lv6xYyOF/PzDBNqFrkTuNbwXRn3xfu1+GPM2NZMe4Q13B1Dn1
         k9xnOfsqbvQPTSwkWeOp9zYTGcE+LDMfGYRZ/DjYehLsE6y5tDQa0ye5ixXj0/rq4bTn
         ebRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8ROvhvAY5XQF51CXLZN/ZOAIuZ86qKrdLZlR7MBua6s=;
        b=OYkwkHwNmnjHLbKBXB2jP+QC8qw7IxcE21kJ4fRGYzZGEN3sTh87bZTAL1ID5/S5VB
         hHacSuxcnu0s1mKK43IT8sTYOTvTTtXZqrvP+lRh1zIIuBsahqAfKE4eRHmM3E+xa6Oa
         +O3A+TGIujkULi/BsbXnjlKGMS+qIHPZIHDfhV1+jGii9nxZlbr2nFue1dX+bi3/ZMr/
         D3NcF2CXeCUiFLAAI5CEP2t6wYeYSfFRwjXJBImPGVKJboQF7QMLCUWdEDtgu0CHwx7j
         FHjqVBb4+CCgC/UN5PT9l1ZAcfYWwxDtEkfP6SNHSmxfLJqn3qcwMLhH6O1BydWtDT83
         pQ5Q==
X-Gm-Message-State: AE9vXwPvDlLUq6bNa57UWP0CXCiLXZuJfxl51Ykhy17m0EDXCWSOVQ1TRKfpOjj/vW0ZPQ==
X-Received: by 10.194.119.197 with SMTP id kw5mr16679758wjb.143.1473185322889;
        Tue, 06 Sep 2016 11:08:42 -0700 (PDT)
Received: from localhost (cable-62-117-29-79.cust.telecolumbus.net. [62.117.29.79])
        by smtp.gmail.com with ESMTPSA id ex14sm34624016wjc.30.2016.09.06.11.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Sep 2016 11:08:41 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] rebase -i: improve advice on bad instruction lines
Date:   Tue,  6 Sep 2016 20:08:38 +0200
Message-Id: <20160906180838.865-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.10.0.304.gf2ff484.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we found bad instruction lines in the instruction sheet
of interactive rebase, we give the user advice on how to
fix it.  However, we don't tell the user what to do afterwards.
Give the user advice to run 'git rebase --continue' after
the fix.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b1ba21c..029594e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1041,7 +1041,7 @@ The possible behaviours are: ignore, warn, error.")"
 		# placed before the commit of the next action
 		checkout_onto
 
-		warn "$(gettext "You can fix this with 'git rebase --edit-todo'.")"
+		warn "$(gettext "You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.")"
 		die "$(gettext "Or you can abort the rebase with 'git rebase --abort'.")"
 	fi
 }
-- 
2.10.0.304.gf2ff484

