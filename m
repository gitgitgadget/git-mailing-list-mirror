Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1455D207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936395AbdDZUVA (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:21:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:59717 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936392AbdDZUU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:20:58 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M5q45-1e0pJo3RAP-00xuKR; Wed, 26
 Apr 2017 22:20:49 +0200
Date:   Wed, 26 Apr 2017 22:20:48 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 14/26] setup_bare_git_dir(): fix memory leak
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <042b3e98e9e5b8850c35103cc56cf651b2fb3f6e.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mLiNMrYgEPewlk72Org/nTWiYLvONfSK/06du48s2EfssMe1Mkj
 zraNflfliJh9zmlprBNjcZrIbYx+SrgO/J6cIN3Zn6OvIioa7fcM0gV7Vth4tH4Bfi4oRn5
 lbfxQwKtgkL9bfaXO4Omh/qVT9v/GhEoWMHp9lC7kQA2P2IOlMseaji2haWfDJHzGVrZVTV
 Pla2uezoFs4BpKkd5bAaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HUU3wLYAEuQ=:VmU6q/djHKUK8xqlrtPQlx
 JC0QxXJbL8JhoCQhPDJaHv+A4eJ8oNaXEDxbu4AFTmkhIdB+GJGne/VwyFA9I8Yv4eAceTPFN
 Apt6SpV+7nEv9pMZrp48Sx5JIz7zfkH7lnnIUiCc9O4MrGejiGmek8bESvkEzNxfj9v/VFCAp
 zj850GWOfHlo9s6RKylt2SajjjGY0IFOc/Lpis/7qawWVUsBuctN+IG7sGPBy4J1CPerUGL3k
 pj8G4ldvYz6KiQ8UOgKe86eDjqmdEv0zV2LMJ5OBuNS3Wyo9AP5pr2LKtc9/tkXk+JKVyqqi2
 0Cn4pwrNOWEX8NokoFQF+k+aNoMyu76O4aE27WK8AYWJDdqEzjlfEg1hyhuE7yK39skjsFy0i
 dJzxg6rEe+7gNj34m6L3jrGES+ncEs8CSHc1y3O6bwLLpUf67o1ktRCZpTJFuAEil5jhDkX9W
 ZMWBksuxkUYYqJXKMho0n2Lqo1Bq1a+Rm8nGFnC/HbXAv3QcFdGGynEXSmLVP0TBOzyauT1mi
 pXqQTD+A0lUCEKZ0SiemzXbfNz5ag+Gqrq0ANUUOjC2Qko+ZOAiGUiU7F62UYxALFihTlWu7x
 d0x3TvJ0ZAbY/8Zpt3Ff8TPBRurNyCCREoBUXxWMjjp944H9KvMK+ysjdU/6iPrIYahuxBj/K
 1a16Tq2pMF6iwb1h5CfIAla2svdt2lFm+jejckfY2Ob4B4KFqQUcHnf8ByHmWfgolJgG70sOf
 Gzor+mzSJfBvjqX6bLnts3o2YRRpZaZqF8i5iPRlrtT5BlOaUWvRl+Z+fSExHZWw1VzJWlUqh
 Fk8r77f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 0309c278218..0320a9ad14c 100644
--- a/setup.c
+++ b/setup.c
@@ -748,7 +748,7 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
 
 	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
-		const char *gitdir;
+		static const char *gitdir;
 
 		gitdir = offset == cwd->len ? "." : xmemdupz(cwd->buf, offset);
 		if (chdir(cwd->buf))
-- 
2.12.2.windows.2.800.gede8f145e06


