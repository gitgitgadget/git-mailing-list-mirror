Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C1A32021E
	for <e@80x24.org>; Tue, 15 Nov 2016 14:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755104AbcKOO5Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 09:57:24 -0500
Received: from smtprelay03.ispgateway.de ([80.67.29.28]:58728 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753274AbcKOO5S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 09:57:18 -0500
Received: from [84.46.92.130] (helo=localhost)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1c6fAi-0007ga-Gh; Tue, 15 Nov 2016 15:57:16 +0100
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>, Jens.Lehmann@web.de,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: [PATCH v3 4/4] submodule_needs_pushing() NEEDSWORK when we can not answer this question
Date:   Tue, 15 Nov 2016 15:56:17 +0100
Message-Id: <1d87628994df89751afdcc7e180ebcdc29dde722.1479221071.git.hvoigt@hvoigt.net>
X-Mailer: git-send-email 2.10.1.386.gc503e45
In-Reply-To: <cover.1479221071.git.hvoigt@hvoigt.net>
References: <cover.1479221071.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1479221071.git.hvoigt@hvoigt.net>
References: <cover.1479221071.git.hvoigt@hvoigt.net>
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 submodule.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/submodule.c b/submodule.c
index e1196fd..29efee9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -531,6 +531,14 @@ static int submodule_has_commits(const char *path, struct sha1_array *commits)
 static int submodule_needs_pushing(const char *path, struct sha1_array *commits)
 {
 	if (!submodule_has_commits(path, commits))
+		/* NEEDSWORK: The correct answer here is "We do not
+		 * know" instead of "No push needed". We currently
+		 * proceed pushing here as if the submodules commits are
+		 * available on a remote. Since we can not check the
+		 * remote availability for this submodule we should
+		 * consider changing this behavior to: Stop here and
+		 * tell the user how to skip this check if wanted.
+		 */
 		return 0;
 
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
-- 
2.10.1.386.gc503e45

