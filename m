Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD20220380
	for <e@80x24.org>; Tue, 21 May 2019 13:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfEUNOn (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 09:14:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33442 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUNOn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 09:14:43 -0400
Received: by mail-qt1-f196.google.com with SMTP id m32so20413821qtf.0
        for <git@vger.kernel.org>; Tue, 21 May 2019 06:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bo6+nAk3HIYXNvpDEC1RBfLG4a5FXhdsvfem9qD1vrs=;
        b=Z8/hckITV3kDHgvGFotcfAb6rV9EYVMNzBI82yYoYeX2OeWgiggq0LExI+KNZE21Sx
         vPra+6j2C25jMOtyGojOimimIhm4/b8Z4sbvczbr7mIKhP73ELOav/hVANn6E096tmXU
         667EiEN9Reetye3ZpsSLjN45eph1DMcSUMdyLAHmsm1Xyx73Yfrfv8vpyv1bwVlq3UoC
         GcYWHW3aSZvWeQzr9Dc8Nwm8beCKZvkr4LlkQ78fNchiZ8Jrf3mjyiaAU1h5l8pmZPTO
         BJ4wC0m9AaPny0ViSj91bnaIrczf6wcrOG560nKNwmRJD3aRfMAZDNBOvJADpg222teZ
         9DNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bo6+nAk3HIYXNvpDEC1RBfLG4a5FXhdsvfem9qD1vrs=;
        b=gfnVjbfgcjjQ0qfcvg+yjbwHB9IPp+UgWugHYPq38jaOS//tx9i7hLvSoFNSSXSion
         8NJykW3dGqODnPTiPPf20hnAqEzSa4lTl5t1KwHIB/Q3urpdoHqBhNSdpaDgxCK7rRqw
         FTa1aYJSZ/aFhxLB0D/gF130qDvYIJeaVQ9hW4+QhHoqX6pQJdGYQtdB6pcamLc93c53
         MqGoF/TcLC5EkOxFo1Zwwo7ntR1z0u2T6xnfD4Za6u7vgJofO7uLSmUDJ9s7OxwAH+3H
         Bat7BghWJ+4hIvo0UHthKwrKWvBmTEgPpXXLY3Tm9shbNoZ8qFKZgBIjELVrS1BzfkMI
         r3TA==
X-Gm-Message-State: APjAAAWPs4WKNV6QbSHKGe+HiqcGwM1fT8pXbvgRLdTd4awn+t3FD/BW
        5VmYDggodAB//J1U19F/J0jdxzlGTv4=
X-Google-Smtp-Source: APXvYqwvjudRRr1KlfIJIvgoI9lOpegYHdiLdlyqPzrOfhWVecHeW3dUc758H/DhulTkWaz0M7WpCA==
X-Received: by 2002:ac8:3316:: with SMTP id t22mr2341461qta.383.1558444481811;
        Tue, 21 May 2019 06:14:41 -0700 (PDT)
Received: from stolee-gitdev.corp.microsoft.com ([2001:4898:a800:1012:223c:4c6c:142a:3ad0])
        by smtp.gmail.com with ESMTPSA id j26sm13964812qtj.70.2019.05.21.06.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 06:14:40 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jnareb@gmail.com, jrnieder@google.com,
        mh@glandium.org, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] revision: use generation for A..B --topo-order queries
Date:   Tue, 21 May 2019 09:14:38 -0400
Message-Id: <20190521131438.58394-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.22.0.rc1
In-Reply-To: <f14799c3-e343-eb41-3536-65de7e38fbd9@gmail.com>
References: <f14799c3-e343-eb41-3536-65de7e38fbd9@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a commit-graph exists with computed generation numbers, then a
'git rev-list --topo-order -n <N> <rev>' query will use those generation
numbers to reduce the number of commits walked before writing N commits.

One caveat put in b454241 (revision.c: generation-based topo-order
algorithm, 2018-11-01) was to not enable the new algorithm for queries
with a revision range "A..B". The logic was placed to walk from "A" and
mark those commits as uninteresting, but the performance was actually
worse than the existing logic in some cases.

The root cause of this performance degradation is that generation
numbers _increase_ the number of commits we walk relative to the
existing heuristic of walking by commit date. While generation numbers
actually guarantee that the algorithm is correct, the existing logic
is very rarely wrong and that added requirement is not worth the cost.

This motivates the planned "corrected commit date" to replace
generation numbers in a future version of Git.

The current change enables the logic to use whatever reachability
index is currently in the commit-graph (generation numbers or
corrected commit date).

The limited flag in struct rev_info forces a full walk of the
commit history (after discovering the A..B range). Previosuly, it
is enabled whenever we see an uninteresting commit. We prevent
enabling the parameter when we are planning to use the reachability
index for a topo-order.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---

Mike,

If you have the chance, then please apply this patch (on v2.22.0-rc1)
and re-run your test. This will confirm if my thoughts on this matter
are correct.

Thanks,
-Stolee

 revision.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index d4aaf0ef25..be6ccf5786 100644
--- a/revision.c
+++ b/revision.c
@@ -436,7 +436,9 @@ static struct commit *handle_commit(struct rev_info *revs,
 			die("unable to parse commit %s", name);
 		if (flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
-			revs->limited = 1;
+
+			if (!revs->topo_order || !generation_numbers_enabled(the_repository))
+				revs->limited = 1;
 		}
 		if (revs->sources) {
 			char **slot = revision_sources_at(revs->sources, commit);
-- 
2.22.0.rc1

