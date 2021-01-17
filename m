Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C369C433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 12:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B1312226A
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 12:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbhAQMGq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 07:06:46 -0500
Received: from mail2.pdinc.us ([67.90.184.28]:39340 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbhAQMGo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 07:06:44 -0500
X-Greylist: delayed 3688 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jan 2021 07:06:43 EST
Received: from kyle-ppc64le.internal.gigabyteproductions.net (cpe-173-88-170-197.neo.res.rr.com [173.88.170.197])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 10HB3bac002017
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 17 Jan 2021 06:03:38 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 10HB3bac002017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1610881419; bh=vRcZvS6WdnoHYlm/tI2dW1aQLgZZ33Bz6QEBVDjPAx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BxYPU5O0ohN2tIAf/uKWG/KH1bSKNxBcjmNt+P+FexEMzbGxm23C5D+UImJHLcLrx
         bjD5XbkHYIEF1yzkiBrWFrfDyyAbU3WvsHZpUnOtuqZA6pyMgF66fISLNVhC7t9k19
         xGvCyBSmigAB1Sn0wG3FqbLEOTBhaK0zU5iJoz+2Bu7MWGwbqT5aNOjs73CapQjxg0
         u9dWXsDSyRGpmUSAFrW3Hvwvmqet1cSxyWfmwIU0PVU/Y5/xLy07FDtmJb6iuRyRxx
         Dbb2xp9PiSN/5E70KDetHTi7WJxo+n/k/lHzE0K9gzkvBPcs/MNoBKnbjoBkbFhYbb
         UmPVRKyuQ8XVA==
From:   Kyle Marek <kmarek@pdinc.us>
To:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [PATCH 1/2] revision: Denote root commits with '#'
Date:   Sun, 17 Jan 2021 06:03:36 -0500
Message-Id: <20210117110337.429994-2-kmarek@pdinc.us>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117110337.429994-1-kmarek@pdinc.us>
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
 <20210117110337.429994-1-kmarek@pdinc.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This aids in identifying where an unrelated branch history starts when
using `git log --graph --oneline --all`

Signed-off-by: Kyle Marek <kmarek@pdinc.us>
---
 revision.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 9dff845bed..8556923de8 100644
--- a/revision.c
+++ b/revision.c
@@ -4191,9 +4191,11 @@ const char *get_revision_mark(const struct rev_info *revs, const struct commit *
 			return "<";
 		else
 			return ">";
-	} else if (revs->graph)
+	} else if (revs->graph) {
+		if (!commit->parents)
+			return "#";
 		return "*";
-	else if (revs->cherry_mark)
+	} else if (revs->cherry_mark)
 		return "+";
 	return "";
 }
-- 
2.29.2

