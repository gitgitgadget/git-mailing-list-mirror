Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB811F790
	for <e@80x24.org>; Tue,  2 May 2017 16:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbdEBQDZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:03:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:57309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbdEBQDY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:03:24 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhQxO-1dSDkc2I0Q-00MfEV; Tue, 02
 May 2017 18:03:08 +0200
Date:   Tue, 2 May 2017 18:03:07 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 25/25] submodule_uses_worktrees(): plug memory leak
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <d2e7c5e84c7f4dcdafe7fc135d2aa673deb3e112.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rBfu/LWK4WyLF8v9jFSxnUe5/tCZr9MLB6gHpWwWApXmWrtgoNv
 N+UDNO2dU2XlZTmPteqm1aekuJ71kGyh2hj2ZJzHTc0T4V7PLvIPlpa6BUPpQdm2xfu0sZZ
 chDNCZOUdguqWu2oaHSLGQcIj884GeZUG23qsgxDAptGT/tTxaHkjNR+XWCFFCIn7rUwWmm
 jUDIoaACI34GO975tfHyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ENpnJRBEc00=:89keZ3LWLNnMoGe+MIDGsc
 F9BkSm4ND/PrwT+6S87HfN9yKqP5ir2uEUjPsaGxC/CxkwD89UHMZxrGI21Fm1RG8fxPBI1jT
 hbPb8cXSvX+HwkMQAqNsr4ghR2cFL0pVtrOHeYBMvGudafoLXvRYWbX8tOC61yqH22nQl6lk+
 eHxhWEgyoBxm2DNFfpJCTDaFOZ3AnJQ4wsDDD6J4vgsgDs2ipEjlHiHSWvvdzq5qdOABsJjQ6
 r39n8bZJfP1/KnqdJczHvIYuNpg8vFZaaxlCouxkyeRIQfvXqXEsYqjxkru5axwyXjrKYeSZn
 hzlKXqT+4hoKN4tP+hBOi/nyax0Caep7VevvUR71FsgXsWSLfqO600WDUOwcaRfxj6x/HH2wn
 4AmZEPJrSrEd4JWtlRyhnPMkoZZw2TqEo8iF8OrhPDzcquwSdqXCeSIpHoj+vsAwGzXi8Sns3
 SZRxpsPBZ2rsDsq+ML1OjVSTbmNC60jNFhJC82Tt7F+SQ/qg/WKgSxd+KkXDHcB7A4ojpUFJl
 5pVB/b18QlSkwapcm3dw+11Ykv/8xXzubcRHPE5AwOF3YKGoqDBO12TJTobwHFc5ZRrDG66SQ
 Gdr+145te97pSgeElFeSt43UScAcyl7Ks09DDr2IgU3NrmVAKYQk83Pp9n8EoL5dWRuHl5dg1
 5tNckWOd2yscV0k2Tqoopua0GQPoXQy5qrLFKxP3l3hxfDNvPl8dhWZoYMHpWvxzx089ABnHo
 rDQEVef5FF8vt+MRqcxz2XVRtCmJLP+BWFZHf/mDc6hxdWZL8J7oGTTW+H7vpTv/+2JR+S0dg
 T2aa6FK
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
