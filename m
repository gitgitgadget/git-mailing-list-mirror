From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v2] Support for setitimer() on platforms lacking it
Date: Tue, 4 Sep 2012 12:30:46 +0200
Message-ID: <002001cd8a88$58e43ab0$0aacb010$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 12:31:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8qPM-0003nT-2X
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 12:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756736Ab2IDKax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 06:30:53 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:52386 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab2IDKaw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 06:30:52 -0400
Received: from DualCore (dsdf-4d0a1636.pool.mediaWays.net [77.10.22.54])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MVqHM-1T6aGn45Ie-00X8og; Tue, 04 Sep 2012 12:30:50 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2KhC5jCGW/VYkxTQaUbSOYXNPpcQ==
Content-Language: de
X-Provags-ID: V02:K0:GQwLUxYcs5WsOqFhyB7rgtcTrvbbUmK/qrmVncJLbpx
 wff+UJbxdH5fnbuVmwpoGoJdhpIFDHZNsXE6IAtyInyplvs2jc
 PNaj5Cq8P2Nsc5N7EGowT4oj3oALrjsQzF3PgFEUVBlIHasX1a
 6P/THUCaAOa5RfNYCE5qB0/UFA4CaXfixRfFnp2TacfHQxi/v/
 E+bBk9Hz7WFN2O6w/yTI16YUIu4BqzeIZakik3+i96aJnD58w7
 0JcLzNi5j84Ipbex6x4s5Onu04dDMM+UawzXMB+t4uQ8EVXBOR
 JqBQFyPLK2USSGlzgoqz4rAxHi5LuaGNOf9UBxr+O39yeCfebr
 kX1UMN/5OEM/Ff8qxx7i1BkUE/MG2UPmm/RZ+xeVeJ9inb2xJc
 1o+LD/B519mkA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204733>


Poor man's getitimer(), simply based on alarm().

Currently needed on HP NonStop ("#ifdef __TANDEM"),
which does provide "struct itimerval", but no setitimer().
Alarm times are rounded up to the next full second.

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
Revert/remove my previous 2 patches for this first (from 'pu').

 git-compat-util.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 18089f0..55b9421 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h@@ -163,6 +163,10 @@
 #define probe_utf8_pathname_composition(a,b)
 #endif

+#ifdef NO_SETITIMER /* poor man's setitimer() */
+#define setitimer(w,v,o) alarm((v)->it_value.tv_sec+((v)->it_value.tv_usec>0))
+#endif
+
 #ifdef MKDIR_WO_TRAILING_SLASH
 #define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
 extern int compat_mkdir_wo_trailing_slash(const char*, mode_t);
-- 
1.7.12
