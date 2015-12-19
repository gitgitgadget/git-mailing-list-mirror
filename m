From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] commit: ensure correct permissions of the commit message
Date: Sat, 19 Dec 2015 19:21:59 +0100 (CET)
Message-ID: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 19:22:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAM9I-00043k-CY
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 19:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbbLSSWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2015 13:22:19 -0500
Received: from mout.gmx.net ([212.227.15.19]:62036 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754042AbbLSSWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2015 13:22:19 -0500
Received: from virtualbox ([37.24.143.167]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lt1S6-1aLoUV12Wg-012c3c; Sat, 19 Dec 2015 19:22:01
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:NNG8U5WQLIF74h3CYDeBrlYoBI8qrNdMVnjKo+1QSd5XTeBtK9T
 qqKqRxW9gOCb3goBzXzzFAb87/jttsfixIm11ytnnax5jEtb8ytIPT7oEp0UwIkU4LHEMAD
 gK7piamYDA8Gp64LRkaWpylb6TewLil9QZa/jA4Gjk/p0X96dBMnLMZ3r+TxY6JYgW9yTGl
 lQpyVibV3nUsdLrdoo/8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WPXHBw3dEpw=:jMex4RbyHvnMfNko9kgkUD
 YWt2CsBL75J4e0x7SDBzdD+7mw9D4jzfLhiPEk5scbGeMLLMhCL85glEjMPFc7EYkeYfekvvZ
 qms6D+2arMZEp2KVLjRNWijOBr3z8LJhokmwnBWe1uHBQIyBXBfsVd3zOwpHT7QVdUjjwViIP
 wP64/MT8wLolwum/2CrTWu0EJcL4zPGmYvtWusHk162l/x1Bus3LJotoWKYbJM9ttuHvaRviw
 Smcuh019jWJyKMKuFoq11tMC7HUgWvAVhTUXjl51dYrTRd9eGZycnPwBNe9My06TrmpoAkaXO
 1++RfUpvjzVMBvADWYL6QnNqsv6sAf3B0sKGy/tAbS6Ec0pwYtcCcstU/QGL5gx9b+8RSR0Oo
 gqYe8hiP1uWOaVRk92eJjVZdf5Q/QHRXSU6WVFMKx8JuuC4spAAEVvAPM4TWOppUwgzPSpRgf
 YK+H99lxlw4XKTvdK7MIWfp1f7aB0G8oB3WTTX51W5bt7vUiPFIupziXJ02RZ742wjHj3Y72Y
 nIKnCej01ILB79ygSJScTkuxMb/gV50Qj4oeIypaHQt874DKW1X/cxeHn4x1xGA1gxDdenIii
 3j9r4A9aR392sSJaPouOEOTvCS8lhMtBHI3sYR3tqhjjl31poWLtfVVm6vv+Ak6i0eeZ45iti
 pScvyjEAqr9O0rHLiBO4YnbmscSzpI5dtXplNJmNgpYgK5BcaNWjlGGIikH06+Rk33XL+9pA1
 VwHX31iAedugkI8KFsI2hwlmYPHx1bhgw/i8lop0rrLe8A6TPPSvIuvA+zIHgcz8QCpGexkY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282750>

It was pointed out by Yaroslav Halchenko that the file containing the
commit message had the wrong permissions in a shared setting.

Let's fix that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/commit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index d054f84..3bfd457 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -905,6 +905,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	strbuf_release(&committer_ident);
 
 	fclose(s->fp);
+	adjust_shared_perm(git_path(commit_editmsg));
 
 	/*
 	 * Reject an attempt to record a non-merge empty commit without
-- 
2.6.3.windows.1.300.g1c25e49
