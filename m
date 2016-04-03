From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] convert.c: fix some sparse warnings
Date: Sun, 3 Apr 2016 19:43:35 +0100
Message-ID: <57016457.30405@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Apr 03 20:43:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ammzx-0007se-LZ
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 20:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbcDCSnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 14:43:42 -0400
Received: from avasout07.plus.net ([84.93.230.235]:36630 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbcDCSnl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 14:43:41 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id duje1s0062D2Veb01ujfSf; Sun, 03 Apr 2016 19:43:39 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=zHjHsN-zKt21vhrpEdYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290645>


Sparse complains thus:

        SP convert.c
    convert.c:180:24: warning: Using plain integer as NULL pointer
    convert.c:241:28: warning: dubious: !x & y

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Torsten,

When you re-roll your 'tb/safe-crlf-output-fix' branch, could you
please squash this into your patch (corresponding to commit 9c7b132f,
"convert.c: more safer crlf handling with text attribute", 01-04-2016).

>From an earlier email, I see that you are aware that t6038 is failing, so
I won't look into that.

Thanks!

ATB,
Ramsay Jones

 convert.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 1fddbe8..1fa7986 100644
--- a/convert.c
+++ b/convert.c
@@ -177,7 +177,7 @@ const char *get_wt_convert_stats_ascii(const char *path)
 	memset(&stats, 0, sizeof(stats));
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
-		return 0;
+		return NULL;
 	for (;;) {
 		char buf[1024];
 		ssize_t readlen = read(fd, buf, sizeof(buf));
@@ -238,7 +238,7 @@ static int would_convert_lf_at_checkout(unsigned convert_stats,
 		return 0;
 
 	/* No "naked" LF? Nothing to convert, regardless. */
-	if (!convert_stats & CONVERT_STAT_BITS_TXT_LF)
+	if (!(convert_stats & CONVERT_STAT_BITS_TXT_LF))
 		return 0;
 
 	if (crlf_action == CRLF_AUTO ||
-- 
2.8.0
