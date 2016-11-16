Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C71F2042F
	for <e@80x24.org>; Wed, 16 Nov 2016 15:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933245AbcKPPMH (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 10:12:07 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.95]:52758 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbcKPPMD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 10:12:03 -0500
Received: from [84.46.92.130] (helo=localhost)
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1c71sX-0004Tw-9W; Wed, 16 Nov 2016 16:12:01 +0100
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Jens.Lehmann@web.de, Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: [PATCH v4 4/4] submodule_needs_pushing() NEEDSWORK when we can not answer this question
Date:   Wed, 16 Nov 2016 16:11:07 +0100
Message-Id: <9c95594f73625e06374f323fa5dc7d6487aa0356.1479308877.git.hvoigt@hvoigt.net>
X-Mailer: git-send-email 2.10.1.386.gc503e45
In-Reply-To: <cover.1479308877.git.hvoigt@hvoigt.net>
References: <cover.1479308877.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1479308877.git.hvoigt@hvoigt.net>
References: <cover.1479308877.git.hvoigt@hvoigt.net>
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 submodule.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/submodule.c b/submodule.c
index 11391fa..00dd655 100644
--- a/submodule.c
+++ b/submodule.c
@@ -531,6 +531,17 @@ static int submodule_has_commits(const char *path, struct sha1_array *commits)
 static int submodule_needs_pushing(const char *path, struct sha1_array *commits)
 {
 	if (!submodule_has_commits(path, commits))
+		/*
+		 * NOTE: We do consider it safe to return "no" here. The
+		 * correct answer would be "We do not know" instead of
+		 * "No push needed", but it is quite hard to change
+		 * the submodule pointer without having the submodule
+		 * around. If a user did however change the submodules
+		 * without having the submodule around, this indicates
+		 * an expert who knows what they are doing or a
+		 * maintainer integrating work from other people. In
+		 * both cases it should be safe to skip this check.
+		 */
 		return 0;
 
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
-- 
2.10.1.386.gc503e45

