From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 2/8] xdiff: factor out match_func_rec()
Date: Sat, 28 May 2016 16:58:47 +0200
Message-ID: <5749B227.2020307@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com> <5740AC28.6010202@web.de>
 <5749AF59.2070704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 16:59:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6fhd-0004mn-Fa
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 16:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbcE1O66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 10:58:58 -0400
Received: from mout.web.de ([212.227.15.14]:58227 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbcE1O65 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 10:58:57 -0400
Received: from [192.168.178.36] ([79.213.120.97]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MTuQz-1axdI82R4D-00QnL5; Sat, 28 May 2016 16:58:49
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <5749AF59.2070704@web.de>
X-Provags-ID: V03:K0:gxBQAmawl8pqdDvYUGsh0bnyLaYzhvozG8FgtV5P6e14fFvFRp+
 +cmIdDxnT7xotK59IJWWYHZnnj8VCYtKUM+Ksb6rzK74WGaAtywC0GU1dQUSqn53mgZ9Upi
 EF/k9lF3ahZp48xMVovC8iuwbgySDB1VtaCdFxty07zkVxm+/vHcIP083kzVES6a3Fg94JN
 M+YzIbiTh5FNX9zT9eNig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GfS1pG4jimU=:PFPzPsKH6rkEBmBXTNtGCV
 gh3T955BrKyRAne4/NynJU/RowK2qnqdEPm5tGnRAxeDgSo9ecWHcw/vFA5u9oidxd+aGxDu+
 SBvfKiSBcsYcuyKtwin/FDZCXajsbQmBmwlkKbcMt4oq3OsVD5OD2jERqYXKn+7e0F/5Qwm5E
 /pQnJnvQznv0H+EQjzEwawdc1VCig69AZAP5o1ad95YjgfH5pYPZScg2x6h6GnY6P50gw2jHs
 uccW/pZgTuEW5s1hSei3QOvoSO+gg9OJGqws/EReirXwfv1LdJdATm/yL3t++JErqGCul1Xnh
 xXVMI5rAWXr+bZo8Wtf4bOSX2arsHD+zuDIf7HK4BYqvC4+c2TokzJFyNd/WVaolGcn5C/0ci
 DgARnZAgaykTZXNSRP7ZoRmcQBQBRHXM61osfX8vOA8WWEDXYWEOGh/AYj6tOLD0tq1W2H8BH
 sBhGKvU2fslztBX0SKQ1R25ZImE7OqmCwaqP2e8PUdgOQxRK0M9uS0jQjq5aPChfYeGWv8Zin
 rgMfipa2BGjtluOgiJXeKEnG9LSX99LKh0vqtPq/7cALi2jFhog41qCOWKXtOiEjXao80b03n
 J+44qgZ7H4hSCM79bdegWWECFgw3WemBTtIWQUs7ClTwRQqocyUZ6XtqcMkiskj2315WkIbry
 xdZDiCQEpTvDfr/rX1HAl4y+2Au2wZdn/z+fbhIPqyz322xpW1A4EPmRMdyFM4m6Ok/gYwgWs
 +464e0+JWbP4ArvDPBC0Z3cC/A4MEIToSZEC2F3f0BD1ImW/bAwJUvuCC6vaumsGWW/c48kO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295818>

Add match_func_rec(), a helper that wraps accessing a record and calling
the appropriate function for checking if it contains a function line.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 xdiff/xemit.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 993724b..0c87637 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -120,6 +120,16 @@ static long def_ff(const char *rec, long len, char *buf, long sz, void *priv)
 	return -1;
 }
 
+static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
+			   char *buf, long sz)
+{
+	const char *rec;
+	long len = xdl_get_rec(xdf, ri, &rec);
+	if (!xecfg->find_func)
+		return def_ff(rec, len, buf, sz, xecfg->find_func_priv);
+	return xecfg->find_func(rec, len, buf, sz, xecfg->find_func_priv);
+}
+
 struct func_line {
 	long len;
 	char buf[80];
@@ -128,7 +138,6 @@ struct func_line {
 static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 			  struct func_line *func_line, long start, long limit)
 {
-	find_func_t ff = xecfg->find_func ? xecfg->find_func : def_ff;
 	long l, size, step = (start > limit) ? -1 : 1;
 	char *buf, dummy[1];
 
@@ -136,9 +145,7 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 	size = func_line ? sizeof(func_line->buf) : sizeof(dummy);
 
 	for (l = start; l != limit && 0 <= l && l < xe->xdf1.nrec; l += step) {
-		const char *rec;
-		long reclen = xdl_get_rec(&xe->xdf1, l, &rec);
-		long len = ff(rec, reclen, buf, size, xecfg->find_func_priv);
+		long len = match_func_rec(&xe->xdf1, xecfg, l, buf, size);
 		if (len >= 0) {
 			if (func_line)
 				func_line->len = len;
-- 
2.8.3
