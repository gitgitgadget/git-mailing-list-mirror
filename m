Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3FB1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 19:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbcLITBk (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 14:01:40 -0500
Received: from mout.gmx.net ([212.227.15.18]:59252 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbcLITBi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 14:01:38 -0500
Received: from fermat.fritz.box ([88.70.156.94]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LiDnn-1d1M2Z0MUN-00nPBi; Fri, 09
 Dec 2016 20:01:32 +0100
From:   Stephan Beyer <s-beyer@gmx.net>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 2/5] am: Change safe_to_abort()'s not rewinding error into a warning
Date:   Fri,  9 Dec 2016 20:01:08 +0100
Message-Id: <20161209190111.9571-2-s-beyer@gmx.net>
X-Mailer: git-send-email 2.11.0.27.g74d6bea
In-Reply-To: <20161209190111.9571-1-s-beyer@gmx.net>
References: <20161209190111.9571-1-s-beyer@gmx.net>
In-Reply-To: <xmqq4m2drlys.fsf@gitster.mtv.corp.google.com>
References: <xmqq4m2drlys.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:xw8hhafiY6ZMhIqTYrsNOaGjCvAgsOEA+qAUQ+h58sT0wdQqVzH
 44gZsmkZOs5Yk1t141Pq0amzoXXk9oOxzUmJzE1gSYEaoLnWCnopSpmqfZuGqrNQXFPH6Mj
 la0LGda1PqM+h7qgy8uZFLm4Z6dGMRkftkgcwz1un86YGXPkS59M87+u4RBBdY8qthNnm51
 hDepTy2LGYYx6z3hBag2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cqNX8t0di3g=:DawRpRuNON8h5gppejIUam
 Sd+XRpko4VECGl9xpxnJ3f+h/Bi0ojASQhVl3rXOWzKsB83q8dJWW4QCsV3TI9KQa1eiC8RUT
 OXGZcNuOpFfMSkNnsldo/y9EzGHFhNX6igRL563uDlK2jv4jGcf5CcFj7D0AFxDfrxgG40ELc
 p+l1D3eMiyg+As29dlUK05Q/dZ/6981H0LrcHOkmYTJk03npCvC0XZGmj+ouhXRt+Movd57fZ
 JROPLMHlnk9y2BZ7KDdj+FJfV5/TxBJwnrbGCx3uCvv1WPV8NdE7N1bLsC4L2vuxNlhzOvntU
 uL5SIVGoOOFI43W4y/YDFdl8kLrWoi7sthEPxcl3jYuJ/FLwHvK39wrZmLStw+TlfeKb/ipIr
 7LnFxvwD7gHvcHB5jZP+YNTLYZrlefen+7CGJr9dKE0NSzzRBPg5eySf/6CXtL5NnUf3037Dy
 +nZlFPuyG1W5CpHxbXFxRxyqDG688v2SS6dFYCbKMbDuqmvTUZ8R76DxTTokKc1MWPEtfe50f
 7uCGzP/o2YjbHKCLNFjmEVCrgBzOpWaNCi8ATkU8//wzaChMk2fgh9FuHNxTYlv9bFHEtcr9c
 yQGYDZK8C+InJW7S7DgDT5f6yUZezTyvTe4ADsQ3avqbDNUR4G5rO+NTB0CnFPTte4CU8pDPF
 By16jIYoE+xZMPRnIxGBj9f0ClLgVEh19cb0RKapJk8+v/ltrusoY9+h080fIfr1lG0XlYI1o
 kjMg/9m2hS18Ka/wP3DXR+Ipp7Su7pqpRAYhtJTQTBnR8z5NARzdwjDd5io=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The error message tells the user that something went terribly wrong
and the --abort could not be performed. But the --abort is performed,
only without rewinding. By simply changing the error into a warning,
we indicate the user that she must not try something like
"git am --abort --force", instead she just has to check the HEAD.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 builtin/am.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 7cf40e6f2..826f18ba1 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2134,7 +2134,7 @@ static int safe_to_abort(const struct am_state *state)
 	if (!oidcmp(&head, &abort_safety))
 		return 1;
 
-	error(_("You seem to have moved HEAD since the last 'am' failure.\n"
+	warning(_("You seem to have moved HEAD since the last 'am' failure.\n"
 		"Not rewinding to ORIG_HEAD"));
 
 	return 0;
-- 
2.11.0.27.g74d6bea

