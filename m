From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 4/5] diff: don't include common trailing empty lines with -W
Date: Sat, 21 May 2016 20:46:36 +0200
Message-ID: <5740AD0C.505@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com> <5740AC28.6010202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4BvQ-0001pQ-U3
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 20:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbcEUSq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 14:46:57 -0400
Received: from mout.web.de ([212.227.15.3]:49803 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbcEUSq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 14:46:56 -0400
Received: from [192.168.178.36] ([79.237.63.247]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MZlNu-1aqV5Z3wti-00LY1D; Sat, 21 May 2016 20:46:52
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <5740AC28.6010202@web.de>
X-Provags-ID: V03:K0:rL3BhGNnWubhJyWKhapZun+NHOMmwHoKyyeoQeS8ZDt6KIIyZKJ
 qwnPuitbXNVcpm9emOcgldjJwHz6xK9n7Uo2ugmSLGmW/sC+qPChI3u957r0ZsQlCUudjbC
 QoZhenm2uzgtixFM1K85OS6q/Fk/Mc6XY7VVV3kf6AeX0hliM0HYS4Yscv/VB5lGh6O2tpz
 GvUT55TgOc0Dr+Js0u8bQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GkcPhik2SIM=:OgL7L6sAPuxUvYS7lwupj7
 DYqmkhMRhe77nOLOBYW6iRYSi/8+o5SGjbVj/fAL3zcaTAMf1VwSA9vNMUI3vAxwpKjNCHzug
 bamYrIrlVm+NrYZ9Y+pbIq5nO0MoFen6rhcMeFk4Z0IyC0E/y94VeLlyPhB/uFYygaWIn+f1M
 /C2l0KKaYOebExQZ5+hE90srymqMvVEE2a39oZHPjSTF9xxY21JjROvFVOAAsYhJa1iNMAVqV
 IINHlrGmxR+L/OfvQmQvHtIQxopFrIceze6e4NvrYsvrFWVAASG7YSojxc0y4KkHBCCqMyHF4
 PPF9CH/j/H7YsNAHBSJ1Jk6WqMRF2u9vgBwSQ7+6wPvajYaFob+oGgW4BfpOG75j+iMMBs5qa
 cOGT3XcEGq/7aUM4rj0JqVKWr1M+/bFbod1x2bUiN6mR1oX45OpWI4tSl20qcrPqrHdKqx21f
 0L5kMdIThLZvzmgpOtAWeDirs5nRi1SHlZiuwl8vXrcMKfgC26J304/dBzlAqcYMH/aIrZoFU
 QieIrrDV6JvW6fVVujDF4iD361PMtkD1/kjsYurISORrkGObF7L3ja/ZbvUyjbQXFBt4lS/l+
 vFFlmOwbQhI1pRgKS3/EQZyBX6jvPtGj+QQdZI3KmX0wy0Y07UgFvzFLCW+2jEyq7WieM7ZT5
 +aIwcktUV2a7MRHhwgRTPTOeTssvPxgENwW78257KLy3Y187sW7A2M3OZr2E5x5EK5SIAXdEb
 iAGSBf7ERRW0ejIDBn0HwfnMQM8fvMwXcaNgROVXJVi7jZT/uBYRJukJ+ib2NXrMgTVpGW8H 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295236>

Empty lines between functions are shown by diff -W, as it considers them
to be part of the function preceding them.  They are not interesting in
most languages.  The previous patch stopped showing them in the special
case of a function added at the end of a file.

Stop extending context to those empty lines by skipping back over them
from the start of the next function.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 xdiff/xemit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 087956a..d0c0738 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -231,6 +231,9 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			long fe1 = get_func_line(xe, xecfg, NULL,
 						 xche->i1 + xche->chg1,
 						 xe->xdf1.nrec);
+			while (fe1 > 0 &&
+			       is_empty_rec(&xe->xdf1, xecfg, fe1 - 1))
+				fe1--;
 			if (fe1 < 0)
 				fe1 = xe->xdf1.nrec;
 			if (fe1 > e1) {
-- 
2.8.3
