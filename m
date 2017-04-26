Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBC30207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936467AbdDZUWK (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:22:10 -0400
Received: from mout.gmx.net ([212.227.17.21]:57723 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936456AbdDZUWI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:22:08 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LaXmV-1dpESB0Jcl-00mLSe; Wed, 26
 Apr 2017 22:22:04 +0200
Date:   Wed, 26 Apr 2017 22:22:03 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 26/26] submodule_uses_worktrees(): plug memory leak
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <f67439bafe4515179ff9dac4e5f1a325b1de6ef6.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HxGCfrqYualDnydaImY5dXbOp0jhY/MJe4KNyfAN49/CVaOV7HR
 ES+2O9OF8vLXhVHCGv71wh/vvmysoJjBAyeFxs7IikYaIkwo1WT0UbnveLkosc9RslRJu9X
 Y6yTbxVC+D/h1g/tuAcieNWSqAn9GB/Iw3wSk/M2rndckWnXxvb4SKU0F6N5jHwfLyyLnP7
 +aOvMCdQdVtnRR0YESBLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ejWU19XYWhk=:Fmn11y20ovVuR1u1aAdwYx
 Nl9iH/ThdbB/HShjtwVAKowuLklE4PHNCL4t5xIFEGxdKHRLjXSN3zl5TuHzTgJ7eHslZrsOd
 +BWXlbSvgGjPXM4d2WRgJ6k8VLF1Q0nCL/vbGatURcue5DxKC4imN2nESqDygHM1HBcm5+8TP
 iAweKpJvqjnT4aZu/nRXsQz/cKQ9qgkoUlQadDWU5Hywm588sqnYPdRLJWA8MUsekaAk08Se0
 X6brVTSu8xSEJA0AbZsa0xydBQx3lMtjf252yqvlKr7AUBPoES3QjghHQm//5l+0vM1DEKzQr
 XzlsPmP4/9A/xYzM+X8ti6v/AroeBPJjISF711ToeUhC9UpsQo5ade1UV+TncDH6I6YciOlAa
 xtZj5+iCj/JqprMv3vGuruydRV8KdNbg9OVAri2vARoulYsU8W5vbGJlPsHDb+/R9wnoQvRk5
 zCc5daI/KWvCpagJbCerbSmhqcr36/OYPxgq6++rQOnh837JKtgWAMRGlmETBq47QEXhMOMSP
 Rl8T8l1WNkR6Cx+fCgDS63TEppVEjcNODWd3AeSvHbHl1m5Z0Cqp2w0KxLE3D8+5qrFQ9QVyJ
 pei8LcLVodRA1y5tz4RoCb+3lM3Pn+owWe5dUsLaYKH1LJDZlkCJPO4db+Pn4R3txwbwJyOKH
 nmAAwcXGsIVZOpw1I6uvfUHl7qKYdrvJsedq4Sg+KmKbtvnDGzBAyc9ff+rVpr/5m244FzHq6
 ooBodyQ9uu2DAMOFN7trHyUyCZXJl5e5bphsf15myllwTrMpUXTG6t5BBepNaVpT/3JtCJRvp
 szmHOED
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
