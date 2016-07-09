Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1AAC2018F
	for <e@80x24.org>; Sat,  9 Jul 2016 15:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746AbcGIPoL (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 11:44:11 -0400
Received: from mout.web.de ([212.227.15.4]:54593 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539AbcGIPoI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 11:44:08 -0400
Received: from [192.168.178.36] ([79.237.48.206]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LyUy6-1bJNsl3Q2g-015mv5; Sat, 09 Jul 2016 17:44:01
 +0200
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] worktree: use strbuf_add_absolute_path() directly
Message-ID: <57811BBF.3020101@web.de>
Date:	Sat, 9 Jul 2016 17:43:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:S7wkFnMLj9V9rVVZ1V6U/XyqOLxDauXN+C93KnvWksWSlhJEWAX
 41X4TFupiHsWB7vJOrOw+3iwWVl4HyaaatSP44OgTX3eZRB46JzA16DXR7uu1oWZk75jGkV
 o7K4HCnwRbQwWVXrGxgbjMZP56gXkOB7o7q+fd89DQc5FDuam5l8A8S4beess8BpyiQAuPa
 ivjHBUSR4fxaj/vxagChA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:o4OI6LszK0c=:1urZ+IU8+EaUI32m07kBEe
 oQjow0tlVD7ntyZ/8m18vs13qqAFC80HQDBT0fOYYk3dsjVQ0HrNK8gl/LPpQ99XtsGcR+pm2
 T3XoBxz+qcgxZ6QsdzHifOgnS69U6Dq2EgXhBbg3q85HQTJVYfAJNYSGoeEPEv8B+1O2DnL+S
 J96ahIWlQgemWzgJ5jCHGseR+cyU2y3Xikg7vTI4F1zC46LSrbqP7T+3qDvFrZ4hCq6eeKXmO
 GxzgGAb5jfOvhVzzS0yKAAgYNqhUzZUsdv6C/NbOKtfMWZ5/2kMJnzykStUqJeVwIddsOYFn6
 H+vamieJHd+wTBUNOY2mblQVSD8QQ+mral1SU4P2du6gwM4vikMMAEeoIVlFh1uW6CCKJJgXt
 tivLug8NLm79lZzUblNecTTxZts1OmNBW94HH5QvBDn9VvnFsoQRM8V18QRKIl/YLe7j+qez5
 QL/wcxhzJsSrL/ghxypTNPxt/Gb48bH3QRYvTMKFb0+Ts/imxEamcN9j5p4IoeIeN3x7z3dK2
 FkO6adVjCRVn77+ixlA6nZyEs4Q2Eel1jU3iluGHxc84kvHhMQvd+mqsOiWI6Kt+4cXP+Xtee
 kyrL+6kZC31JxYg7RUIF72lD68F4DGRTNofgApiYPSGjzWnllw40mC9XZQ+S4EI18edJvpYaN
 BoxFQyxo1tW2zGG+lSA8nw3NKonZ1VKQYGjkMOgknUkhJN2z5f4TG5Z+Tu4o9ENhFLYlUXa+3
 haU4s6U8QfDy/T/CMsLpbfrIdFMr6MgvFhT6e6sYmvVirLNwCRKzAFY5zKR5cl8VVBBOn9mZP
 gAjuWCD
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

absolute_path() is a wrapper for strbuf_add_absolute_path().  Call the
latter directly for adding absolute paths to a strbuf.  That's shorter
and avoids an extra string copy.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 worktree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/worktree.c b/worktree.c
index e2a94e0..b819baf 100644
--- a/worktree.c
+++ b/worktree.c
@@ -80,7 +80,7 @@ static struct worktree *get_main_worktree(void)
 	int is_bare = 0;
 	int is_detached = 0;
 
-	strbuf_addstr(&worktree_path, absolute_path(get_git_common_dir()));
+	strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
 	is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
 	if (is_bare)
 		strbuf_strip_suffix(&worktree_path, "/.");
@@ -125,7 +125,7 @@ static struct worktree *get_linked_worktree(const char *id)
 	strbuf_rtrim(&worktree_path);
 	if (!strbuf_strip_suffix(&worktree_path, "/.git")) {
 		strbuf_reset(&worktree_path);
-		strbuf_addstr(&worktree_path, absolute_path("."));
+		strbuf_add_absolute_path(&worktree_path, ".");
 		strbuf_strip_suffix(&worktree_path, "/.");
 	}
 
-- 
2.9.0

