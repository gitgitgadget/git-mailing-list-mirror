From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 4/5] wt-status: don't skip a magical number of characters
 blindly
Date: Sat, 31 Oct 2015 18:37:12 +0100
Message-ID: <5634FC48.7070609@web.de>
References: <5634FB59.1000506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 18:37:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsa5m-00045d-Fe
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 18:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbbJaRhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 13:37:23 -0400
Received: from mout.web.de ([212.227.17.12]:65228 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbbJaRhW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 13:37:22 -0400
Received: from [192.168.178.36] ([79.253.163.201]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MT8fq-1a0j1T3LwU-00S87S; Sat, 31 Oct 2015 18:37:13
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <5634FB59.1000506@web.de>
X-Provags-ID: V03:K0:s3qljz2spZ4uNHrrmdmXAmAsorbXXCrZOQMMF8tIHaZb17yPGDd
 pisiuVYVRVdwJofW8drXoN7CjPVz5kYJCLVnRwWCT+0IJOUo7fH/92FtFXIrc+2cdVzs7Z+
 Vex0L8PZMo+7H/Qh79mkPdci4q5sTwd9tJf4niBB/tA9QTuxf+SS1nAuuoTp9Txo5XiY59L
 1efT3UWFV3OTa2bW5tE1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6tFLoSfUrHc=:HpruSpqm94I9PvPYKR2g82
 Tf5mJVpm1AtjP0JZNuw/CqEJyf3Olc3U9DClQwtPqTvjAb6eDXaUezA7N9fU0WDPtBJG9OBbu
 tMrgcUKli5VEq/Sxy7LoUifLcQwrK7Df4TAaJU1n2sXhyShCHzDGvbOI0jl/yJaDY+fnKpqDC
 CQgDKYMdFk6+r2UlqBM9y18xU/QQuw88FBc8RmxeY6cgGeOJ/0y0vDtqN5PoufgbFYbH8Qtm6
 RFVL8rW58DEKDkmFJ1nJrrHXJL+Xw3gXmGEQoO3d4mxuP2TUbZ8O2kL4hEz2o71cyBKNOEiZ2
 p+CmQ3tAlJ7lTMwGhf0mGdcdy0Pn5tAr9iIR5auGetts7oLBU7ny7kNZmxQjn4kC+fqBdKlCu
 mPprHE1KdaswO9mPZLIEwGoTsccA92QRkOaNFibKy1+nWzhD65HoO8IE+u4Xrf85qiXntAiBO
 gzl2UF/gJTtnkRITZV+MtiEpXGe8xOVfe2qwPKgTwKxXOsEKVq4hWkz7JXy+31m059Z6Q7My3
 n16hXriUIlAlMWcrPXKjzXqj3TWrLUFBYfNoHT3gQ1vkcyCGPQCkCqxlFHsnwBKIekCUX/ooO
 /6uSh6OB8O1d0bqYfqvKgvK78LrwiRiPzMBdSMLxC9+G+jLLCmFFwTcKnYzb1upWLjjSRBDXQ
 pe686x7X/R9AEbJ9Y57pqHKpBkEHRKpUmZyZ/R1oo2m98PtW3ZkcHj/o9UMClIolJFtb9PsBG
 KSoecd1V5jrleXuh9EuJWGHz1TXrhN6U2a/bqR7gllw0Fd+lpq8xndMIQ40RCj17fU4Fkbmk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280590>

Use the variable branch_name, which already has "refs/heads/" removed,
instead of blindly advancing in the ->branch string by 11 bytes.  This
is safer and less magical.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 wt-status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index e206cc9..42ea15e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1656,7 +1656,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	if (starts_with(branch_name, "refs/heads/"))
 		branch_name += 11;
 
-	branch = branch_get(s->branch + 11);
+	branch = branch_get(branch_name);
 
 	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
 
-- 
2.6.2
