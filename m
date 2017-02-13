Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AEB41FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 22:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbdBMWei (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 17:34:38 -0500
Received: from mout.gmx.net ([212.227.17.20]:61509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751371AbdBMWeh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 17:34:37 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MAhTr-1cWVZL0AKh-00Buwk; Mon, 13
 Feb 2017 23:34:08 +0100
Date:   Mon, 13 Feb 2017 23:34:06 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH] mingw: make stderr unbuffered again
Message-ID: <c88612da0a62bfcbc3e278296f9d3eb010057071.1487025228.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:E1nB3ZoSne4DzkC99P6LXi5nw4GY7ItuBp538DDQdcgj47huHk8
 pDMDDhPqjTr5KGV1JTy4NcLd5b1EV3f8KRsMnmlt8eVE795IKvY5hIfxsoyXgQ/hYxecUC5
 1LaUkyB3MK2yHc2H9inXNUO5wzsjT3H5zJcOP8EGhjTmgCeifxvIUSx1lnGr0M0t5PqJ1a7
 y4J+ebeoh1VQ2VYWg/xuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ecjQmBJQivU=:fqcze00GF9kogVQvQivt1U
 uxlDb9Y73rcdJvSsjWZhKrJJOXPh5urbEP16DBjJQeMeAEhqTRXtzwcmUzFXhs6d6n9SxXnqG
 yNrNMpDv6wkSzZAejmgyzNlr9+YTA2ICVpA7XGJHPHLxrMJcGlF1b0JGioSckfBJ5gAZsaZWI
 09r5AG21nJAO8tM3z/WDJiPxPuuhYANYHBjTUJadYUv/9YV9Ehg/nq8qHamgMceXiR+WYajtt
 1B+VTEOJpHY+jhZ7mBoz2VYEwpSr3zd8kzCG/FXV1U+fX1e6vAv6Ik5QeyQKOb6FU8qZZRLxU
 CNwmXvf98Fk2FigqDJ1AfMDtQa6DYmzxNFtivANqO1J7Xt2uaBYedTM79wpHgGLgleRttzCqC
 JDFHwrRGaaxrEMfAbph67WrAzPtfhTA55BFDGyjolz3AYXxf9n3OT+vjxVQ3lsVfyZGVQr/1I
 XUJaeFRLDE/r/MJXZMCCCX3jr/9Jf+tSN+5Vl5THv+eKiqFwkAVbJ5EC0/8EuQp/kri+igmic
 lTsfNvXHMm3tFe3mD56KG/4EEf9JKR+vbY41Tp72mbsoxRO07Sb1pbKS/dsj2ZItVWoTyg0CV
 Jb2EnhPaK4oyeWuh93ARuEOalzT4hoAvAvOfMbNij8pnPCFrEcWuWsq0INAVGPYYjrftSAFGV
 pJxMuAQpyla+Su5amxmuJj3+/gWWGvdWEUtCkEGPoPByxF1Wwlejcib1+RkrzhkR8hRTxcIes
 uIv0X/wXoImxy4OL0aBc27HgSgI5qBu75cQduPzR1+Gv4PSaRiZatwyxafe8TMa/K5E6/oFCi
 9NW8i3/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When removing the hack for isatty(), we actually removed more than just
an isatty() hack: we removed the hack where internal data structures of
the MSVC runtime are modified in order to redirect stdout/stderr.

Instead of using that hack (that does not work with newer versions of
the runtime, anyway), we replaced it by reopening the respective file
descriptors.

What we forgot was to mark stderr as unbuffered again.

Reported by Hannes Sixt. Fixed with Jeff Hostetler's assistance.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/mingw-unbuffered-stderr-v1
Fetch-It-Via: git fetch https://github.com/dscho/git mingw-unbuffered-stderr-v1

 compat/winansi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat/winansi.c b/compat/winansi.c
index 82b89ab1376..793420f9d0d 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -510,6 +510,8 @@ static HANDLE swap_osfhnd(int fd, HANDLE new_handle)
 	 */
 	close(new_fd);
 
+	if (fd == 2)
+		setvbuf(stderr, NULL, _IONBF, BUFSIZ);
 	fd_is_interactive[fd] |= FD_SWAPPED;
 
 	return duplicate;
@@ -547,6 +549,8 @@ static void detect_msys_tty(int fd)
 			!wcsstr(name, L"-pty"))
 		return;
 
+	if (fd == 2)
+		setvbuf(stderr, NULL, _IONBF, BUFSIZ);
 	fd_is_interactive[fd] |= FD_MSYS;
 }
 

base-commit: 5588dbffbd61e4906e453808c6ad32f792fea521
-- 
2.11.1.windows.1
