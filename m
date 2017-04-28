Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 248A1207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 14:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2997851AbdD1OEx (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 10:04:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:49647 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965808AbdD1OEu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 10:04:50 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTCDO-1dV1HZ2thm-00S7X2; Fri, 28
 Apr 2017 16:04:43 +0200
Date:   Fri, 28 Apr 2017 16:04:42 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 24/25] show_worktree(): plug memory leak
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <61752ef33781402fe90dfa92dee2427e3cd00e5b.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LuhEGbXLxgiqrRWxtKbGyb+ZMv5rhKNPGxTO95U4zdGJ2B/8PTw
 XrGSkAf2MbVq+np+9fMmRmz8wJHRatD6E2fHszDqPAJN1ykn7uYCwzBUFwBgweB/7toAB/J
 3Kj2qTZ8GHsXSKaHFCP9BESxJoLWZVh6J/lsVe50f8ux3fhTiQ9VACCYU/uWOjF3rz8I3YP
 GJ25P0XtXIaw8mxexNqBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qQYWdj5DtiE=:g7iDe2TCGD+GFMUXP9zrHh
 F10qb/+5XEY7DFB7mdL+XonKSMZHbwMn65NWzzb2i4i5Xm8i1j3TNp0SYsu4BJ8cREKcS/TTD
 VZpLGduQNBDqRfUSGJJti2nWdw0BTbz3nzODMXws1df9GHuVxFXqUq13Q3tVBiNME1qQRh9rN
 qsHbfIl4axs6yPmeON1EFHPZJXqHLr3v3KXbm4qblyIMf6MiIvfriPaHDtv6WRjnoxOwRyJlJ
 bWeeLp+mmoikfpjqHgxrYccPn+sdmAnTJRTjaPsI+h1ba2FJJKDOCGM8U2UpwX7yITFa732KJ
 uzddXNb6TYmiRiVcIuT8rWLWpa69ySGdfM4LbNr3qhFGpHumyCyiTNL9IX+S67zvemn9Un40e
 RqqG9cEDt3j3Gp7bhBbbHh7M2MGcPwAChcSvmn40IphQ1thu4o5NI2SnUxlMogMzCPTa4ma5Y
 mpd3DcxCl0lkIiKJ5+bpcLQWLDISLkd/t+r2PInk7R0fdbLKLUqg0aOB7d3o3BHWUltgdTdCO
 u+iaNID5a+7vnoYH0G8EQoKLSUhGkObk8PgK00AriOhNiEmz+s44BDFn1ANAlBQ7FtyVruFWT
 dTGixXCfnkjrwDSl8qT9MlLA2iHKeuge9FhYl5D8m+k9qZIal2AtXY7l1RzA/ysMGj3ZaxyNv
 BmAOiYqsF3IuRLhyyQv3FoGWvQhAQLwweWwVTh/767/nbDFYdbdDpGFsK0vzEIRIO8IVhs9Ou
 jn+638pW2pnupnvuxFoZjEWnGLAeZ3N8iUQ6y3BBA9KoLz1KOCiH9T8zCHnG4et1JqY/q+pjg
 wqno5N8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The buffer allocated by shorten_unambiguous_ref() needs to be released.

Discovered by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/worktree.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1722a9bdc2a..ff5dfd2b102 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -414,9 +414,11 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 				find_unique_abbrev(wt->head_sha1, DEFAULT_ABBREV));
 		if (wt->is_detached)
 			strbuf_addstr(&sb, "(detached HEAD)");
-		else if (wt->head_ref)
-			strbuf_addf(&sb, "[%s]", shorten_unambiguous_ref(wt->head_ref, 0));
-		else
+		else if (wt->head_ref) {
+			char *ref = shorten_unambiguous_ref(wt->head_ref, 0);
+			strbuf_addf(&sb, "[%s]", ref);
+			free(ref);
+		} else
 			strbuf_addstr(&sb, "(error)");
 	}
 	printf("%s\n", sb.buf);
-- 
2.12.2.windows.2.800.gede8f145e06


