Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E092E1F790
	for <e@80x24.org>; Tue,  2 May 2017 16:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbdEBQC2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:02:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:49995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751161AbdEBQCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:02:25 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9b03-1dE3uj2VaB-00CwFX; Tue, 02
 May 2017 18:02:14 +0200
Date:   Tue, 2 May 2017 18:02:08 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 13/25] setup_bare_git_dir(): help static analysis
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <e72c90ad8445eea72f8707d6780c1553d00ac263.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VMcfK/ytk1kLAdextffD7yXJgpPRP0QOpaK1rT/u+Sh6SlGaISN
 uBnAcWTibLeNDYCeu7d5Kfwr8X35rdphE/Igd4G6ZuNDS1T3Dl9Jiydjpv/dvA0vg9OHKNi
 /1qc+I9AYUxL2w6SFicD4oCu95qswKuFukAgS1pv+RsXqdxoZNPUHcT8rmtJ8VATUBo1Zin
 iCeUlpAy4mZqkJUBvEDsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eHqCDebL2+A=:THCLz74JtiDftUn0I2x7WE
 Sd9+EhmtzGT7XqFZRbFwYK37U7VhYoIGioPOFgUjuX7yFO5uJzrM6RMHiJQkrx+vqXHvDh+j6
 icaiiekw65XAcSfvqfly9FGZpu97YZUx8sS7IbHxp6rUmmZkP/3D7YYMoBF6E6ybSVNuy7Myw
 f9BNiPLIWVnm6n8u2N5VnIhju/dhV5yYek0F0fWf3PQ2d5+mme46oNtsJJcgxtQfp/fHI7Xbm
 INOIUF047Nk14ozszVth6eAbL0KohZcK+BW6pcFHLgr1gmB+UAqdBpTROUfXnfrQEAm4epSg0
 nX6Bv9Loi1ChQ6uefSqxTcoIGYnw3FkOynjgsmyKfY63TCYHs57ofrR4eMf+UHQMrsjpiDN4L
 xU3ENz3XLVIng3ni0mHp1WuYUAB7TKiM7hipK9lD7s/8Mk5NzMsWXWntcNh0SxMTx0Xh+7UzR
 zXN80xfmb2JqSVyOmzdNZOPfyETQQon1Ny4y27FTunp9pP5v4ZnHbg4C7nB/vxiF1Su4QYRnf
 eDKuPlfXAeSkxRDROU38BOscg8b+Wa8F/Wz28ufT6ryG2T2xd8UauF5p6LLs4VS0s0TysrEfJ
 XAbNban6L16b0fBRMl+7mxp/3Nh3duV/lX2lx5JwildANyg4uUNy5o+uyOKpBNq1Jcsw23A3q
 TL3fT17WmsLs+RyRsElqYv3tapZELtJqxMxcMN/8FBV3BO+ZDEkZYqDIrvufoCxJHEaXkjyFi
 XTb2YQuHMa+zj5rVS8Ojjbwa3Fb5Gv6Ao+JZF0ChQfoOH7pCMB3mprKOGCNF72ukbK6pvLPEo
 1iKHMXU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Coverity reported a memory leak in this function. However, it can only
be called once, as setup_git_directory() changes global state and hence
is not reentrant.

Mark the variable as static to indicate that this is a singleton.

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


