Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92ADE202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 12:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbdIVMEY (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 08:04:24 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:50328 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752429AbdIVMEW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 08:04:22 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue102
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0LlnLU-1dM1wK2jOC-00ZNN9; Fri, 22
 Sep 2017 14:04:20 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Subject: [PATCH 2/4] merge: do no-verify like commit
Date:   Fri, 22 Sep 2017 14:04:13 +0200
Message-Id: <1ec69134cad991f01f6a48b57fbc7047cc226965.1506081120.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.909.g0fa57a0913
In-Reply-To: <cover.1506081120.git.git@grubix.eu>
References: <cover.1506081120.git.git@grubix.eu>
X-Provags-ID: V03:K0:Oet1V+MfUhGYe7NyDDKQQtZrKF+n5AH/xOcJXC8YFjHvAg2s9E1
 v1i6lU+XBN8YB8+WKU2H1NLPGLTxADEcqDhhRwWOjETNzSEKDSL38Ez/iap83M2WfJti0bq
 XphugQ2YBKNOVTf1a5z6puCDWWTcK2qnx3kFuss8nKoTgrh2EKUa0CIPowVYEiBPoypZE5w
 oXnavsLz7ZgkFhuO78XWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4+AR6sRtyyU=:kf+6TX9ouW5t3Tztjv0Jt5
 rwMeq+ioGwF/NLKR/N3Mr3SMWfk1WlJCixa7rD+FCxHdunc3m1vsailS245+wZmKbU5Q4Tazh
 XFv0yrEAymUVXHwYb/cE1BQ41EPVxVZFOSsDeATcnhE4MGJfCKirpO1YJ68E/wBHkST/nQhhz
 aYY0x3OAP3mcuo2xDme+ac8GBpLjUiSnFntS+zEgJwRq5GFwQBSsAvblZdRWP+IsNzP19Pt6B
 ORmUsL21CHqMdFHoKP0/YUbRtEowglRH4D0K6Hd4GPjCBwWF1jU/nnqoUIXrqc0ufHSUWpRQC
 IIKV57IzE3D/m9CAx9ZaUP2XvJCbrv7iWxavKXIiCBcdx+S6pP1gnlW5EZgIOfr0zYnBGyxpZ
 mfnjB6oaj/V1jzjCIaf03I0RB8JfCUBgfMak7gP2PSPcyVpbbgnEt6VE+uX/feTTXRWorFXIA
 KJO9tWqCRjNdIJeZwe4jce5f9RIPJoViZkBmGQ/0dxd8W/zWH94oYvmSQKS/rw1Pyj7EAOsd3
 AfOtckDQr9tOBdpvYn822iE4NqPM9eaVZU/mJy0PO08Q4DbJBwwa+gHnOBMFxb/JjoyO7mO5m
 vXrOzB5fRtiU+F2ImwbMDCaal3QF7fmalzuymjOfZxnZ5wKKYruJAPQhGXc2e3yfvQzMTxZIc
 E56yT6qGf7v4t+oRoVudlprLZEHIvj69vrT6MU/jl2i8kfE7QMId9nyIROxB15kUaWYZqLxOc
 JXSnCKVVXeJlAwwJmbJWUceIyzl1hiIq71ooEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

f8b863598c ("builtin/merge: honor commit-msg hook for merges", 2017-09-07)
introduced the no-verify to merge for bypassing the commit-msg hook,
though in a different way from the implementation in commit.c.

Change the implementation in merge.c to be the same as in merge.c so
that both do the same in the same way.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 builtin/merge.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index de254d466b..7ba094ee87 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -73,7 +73,7 @@ static int show_progress = -1;
 static int default_to_upstream = 1;
 static int signoff;
 static const char *sign_commit;
-static int verify_msg = 1;
+static int no_verify;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -237,7 +237,7 @@ static struct option builtin_merge_options[] = {
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
-	OPT_BOOL(0, "verify", &verify_msg, N_("verify commit-msg hook")),
+	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass commit-msg hook")),
 	OPT_END()
 };
 
@@ -798,7 +798,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 			abort_commit(remoteheads, NULL);
 	}
 
-	if (verify_msg && run_commit_hook(0 < option_edit, get_index_file(),
+	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
 					  "commit-msg",
 					  git_path_merge_msg(), NULL))
 		abort_commit(remoteheads, NULL);
-- 
2.14.1.909.g0fa57a0913

