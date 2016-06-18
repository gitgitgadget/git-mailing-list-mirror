Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D69F20189
	for <e@80x24.org>; Sat, 18 Jun 2016 13:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbcFRNMY (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 09:12:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:58338 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110AbcFRNMX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 09:12:23 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MZCxA-1axgbN3ZzI-00Ktqk; Sat, 18 Jun 2016 15:12:17
 +0200
Date:	Sat, 18 Jun 2016 15:12:17 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Make find_commit_subject() more robust
Message-ID: <34ef85eb4e2aef0b342ef5d3bce9e468c8339486.1466255489.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:usiy0bIx1x8yIEQgVOBLlaFJu6MX5Kc75CAGWyCfICxWtJ0ZRK2
 RyF4SWVCiTUfU3iNzErRGYC8rwucNSEb3gVh7YYL3ZrZ39dKBBu62/XPo7OEtwcGQrUcXRf
 DkSzqppMLgFRytzq1GULh4SBMC3DqsMpdaJEkvpLY+utxEBdbGwCfe/83/OiuR8cHGVp9jX
 cnYltRVPfXFHxtkehh7Rg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:nnUHAZlSvuc=:as+rHnCHtzsY1yU92ra9uN
 LOio6r7nznPf34c8I5hXggJo1uVA8kDuRmoWfvB/toAiUfHnd42rRxho/C/S5Jqzx4Wseb5Lf
 vqAImn7cR3M1XMC5FyGVXqnm0IJeeLrYPA5sDFXrgnmsrg/OVdEUnd0pxubJ+jinpGj41L6L8
 0ovBylWeGFmXFqpki3tE5nDINJujeCe3BS4RTxFE0+pEpCxeSBnlIPN9/v3rYKOjs7PWWh77e
 +KxDGrbdhQ1JiW5O60wlp4eskmNNDtZdo09/D0aaLrb6Wkln0MrXNsIswOj54BkwyKRxuZORO
 K2MyrL3+tXQiG1uJnPGPUxVaW+uDeDKfejG8Y6G3mlBJZvv9FsqukSncfhR903isrEosEVEri
 jEDkz/iBahLu6YQwB5tOyLEFZ96Y11QhmJiBcUbFwqrk+kTRYiExUaw+f7De/j3EhOKEsBuTa
 r8HHyvItsM+PsTZLNGAkwKZhhrBrWGuVyBm+IIsrKJbEmaepecJtrdy7biEVp4BAUuGMytoTY
 44vyH1BfeOi6NNHfTfL3I+cdY2FaFUxZ7vDyuFRtq+z6sOnNwTErZwRj/OvmU6blQS66o7CNy
 NiPDu+aE+8UTJNp0CfmCCPHgd8eyWEiK1/dXnwvsCTi7ou2PeUM5jPDPUldaHum5R20ZDXwg1
 TyEVRF0P3NvN3lH7kuF6N6/4BFx44QQdzHYDkzOUo99iS0QS13NaX70wvEyRPN0IVDLT2wYmD
 FSdMfb73abu4c90U5b7K2q5Z29bUhJunHulxeX1ZoPgBcYupWBINZY6WYry6A0YLlDroRdpBT
 4Y844v+
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Just like the pretty printing machinery, we should simply ignore empty
lines at the beginning of the commit messages.

This discrepancy was noticed when an early version of the rebase--helper
produced commit objects with more than one empty line between the header
and the commit message.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/leading-empty-lines-v1

	Aaaaand another patch from the rebase--helper front. I guess I'll
	call it a day with this one.

 commit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/commit.c b/commit.c
index 3f4f371..7b00989 100644
--- a/commit.c
+++ b/commit.c
@@ -415,6 +415,8 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
 		p++;
 	if (*p) {
 		p += 2;
+		while (*p == '\n')
+			p++;
 		for (eol = p; *eol && *eol != '\n'; eol++)
 			; /* do nothing */
 	} else
-- 
2.9.0.119.gb7b8d21

base-commit: 05219a1276341e72d8082d76b7f5ed394b7437a4
