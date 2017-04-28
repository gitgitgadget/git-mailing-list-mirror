Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2B63207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 14:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2997990AbdD1OFI (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 10:05:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:62474 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965808AbdD1OFH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 10:05:07 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LeSOH-1dthh341O9-00q9TE; Fri, 28
 Apr 2017 16:05:01 +0200
Date:   Fri, 28 Apr 2017 16:04:46 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 25/25] submodule_uses_worktrees(): plug memory leak
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <f3a803b812e74c7ea4166fdc443a16129784d133.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3CCASvrkSl7ivu2xD1ffSi37U5MBXOgB9PoYOs6rbuVzPK0PFTz
 BJoMJkobNJcZZ2AaL47sA8Inj2mDUxJXYTSm0AuToxaDdjLcsHXkCvsQ/t6zlgSec9LVhG+
 27aNvAijnXvsjgxTPgGSqlwXj0SpVnnsKH4TinopM9N+pAq4LqGfNSQOhnztbl7wpEZ+sth
 ipkPn0BZNymFo75Jy+tHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a6LmYVzln+0=:Xn4FZDWSAdYOiJjcEK/+wo
 j5L9CxFGyVOG5IV1lQdN1S23xpxGInDn4ihnKcgJ5nw+ubmnwGs+tp6W5UoqBvisqMgFXBY/4
 Bq1myVNAws7x0t8xFZS/k+KEWRXvfvl+F97hXGmHMMfDBlu7p/WcjKwOWZGzv8iRODUU2aPOu
 lvsMjn72UJnBZF+H0cqH8y3IukkdsGz3HrF39gEbOFrGjliSuy4MhXjLDQednq8nKl8OoVoW1
 bHPrkgRmTArxXJZU0nu8Y2E6XKMgf/ZfJ+jjb3ZPkJzNhL5vPSE2DAmThs8Eo7Cs3lmi8rD+O
 2IbkOSG7MW/l9jTsBc6uWMINzcdeAGGooaUhCfKtADhCXNgttXNLNeUeWcTa2/GNy9pN7aqEr
 U5+DrByDWAaihHi9CvUYN4+eqLDYM9j+YQ4HOjFxCd4yv65i0jI9x9sR0Hwqx/Nrr9JYt7jet
 8VaXxIa+rkrkhQgyZnFDTF/K/NWvCVeYp88ebCzaSdFBYo3sbBIewDbzgc8BhZ9LPDfV2GTeJ
 r+BRus+b0z4noKIMreq6RQmkBhIIjT8MRWF2fEf88d+XCtuGrJxE2vo7pqryEuuX5aHxD7QLL
 frXhBD/5V0pe/sZ8kaj3A0miZHpZFBm9ShGlarmuz6RwVktkqXJW3JT//DLGl7pvw3r6hVxKC
 D5DtBBi25tppFlMo5yXoo9mjbnosxXcpM+8lG1fiH4CpHItmmGFSog8v/xs84i2jJ5U6Zi51Y
 AbYSIyiLI1GiYCJCT9rys7Hc+ZyGPkKX4fBXrvmp2QJbECMk7cONljj9XLPgnnbAGpZamDtQQ
 jmxMrh4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is really no reason why we would need to hold onto the allocated
string longer than necessary.

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/worktree.c b/worktree.c
index bae787cf8d7..89a81b13de3 100644
--- a/worktree.c
+++ b/worktree.c
@@ -399,6 +399,7 @@ int submodule_uses_worktrees(const char *path)
 
 	/* The env would be set for the superproject. */
 	get_common_dir_noenv(&sb, submodule_gitdir);
+	free(submodule_gitdir);
 
 	/*
 	 * The check below is only known to be good for repository format
@@ -418,7 +419,6 @@ int submodule_uses_worktrees(const char *path)
 	/* See if there is any file inside the worktrees directory. */
 	dir = opendir(sb.buf);
 	strbuf_release(&sb);
-	free(submodule_gitdir);
 
 	if (!dir)
 		return 0;
-- 
2.12.2.windows.2.800.gede8f145e06
