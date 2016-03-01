From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2] Mark win32's pthread_exit() as NORETURN
Date: Tue, 1 Mar 2016 15:13:49 +0100 (CET)
Message-ID: <d584d8bdaa8645a406c96f2a11f04febf57b2c25.1456841593.git.johannes.schindelin@gmx.de>
References: <69eef72cfc77e62ad7ad17c6df5f2d2396c64991.1456840324.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 15:14:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aal3y-00072k-2b
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 15:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbcCAOOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 09:14:04 -0500
Received: from mout.gmx.net ([212.227.17.21]:50969 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbcCAOOD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 09:14:03 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lb90f-1aC7UM39ZZ-00kfZM; Tue, 01 Mar 2016 15:13:51
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <69eef72cfc77e62ad7ad17c6df5f2d2396c64991.1456840324.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:a3vk4UAJI08GlY58l1ygpN0i8r32xn7jn4zN6npqxs4IXVoJFVp
 prWGioD77BqXCwBE2W7j5kl3U4/hxORQmU9an4enX9eNciiCR4jVvB+4wCmPV7TGkxEC15Z
 xV1FYBl9FzVXLTPvrC6AR4WuPb6WQxLRfzoS6eM8OLffTkETX3P8iiqVd/PZU89IYeuZZbq
 jrfITQlSFIOn3Drfx0g6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BOuhymaBPTQ=:RfVxdaPCXY6RfH8N3dtXEp
 KAOAXTtOVOuvgb+KfUwiHWx2ixVyCGRi7s+yDUGISFWEa8IF4ailONmlFOoj1vQHTAbHInTnc
 vYlFWG1T1sltAYuhBhphIG6FEDDEeaLMMUErtvzu6xkMg0DvNOt+gy2QXNkk4DYXTPK4ygfwj
 K2SkYyC0Qz0XemCFZ5+qXUrLnBeP1VrPG8hDQmhn/dnxmxkPLLWvT2YeTpbTE6RSVMcA/Yl5f
 GsZPG0VrlPFGTKP2QYJ6qghrEBKVuOQ70GJjHvRzF7nVtueJnndANO/tYm7QFeJ+1mE8SL+8b
 uk5AqgzM3HGCXy9YgfIEGWxIiJamcgshWan0XeRsi4NdwNDx+krCFpCpreJgdDlNJbxqVzWRy
 lw7NzKJcPicJnT6CrjdpCSDfdGVrYVv4Z3d4z/pXw3IfWhHnvRBnXrGP/vIOTtnSKDnU4ZZtB
 046l+swhV6zDk2SdX+ef5C4lpv/fr+fpXRTQJ0bd6HGHmUy+OK4HrQoDC+3diGii3+mGJVLh0
 lp4pZCmRYizUol1y8iuj9GpuG699wF66kRh6HSLAtUszH7esFN4DMQcrKS4pSEyN/6lfy6xlY
 JCNg7RI9PY5Jr+6Lg41Fo7+5qx+n7R+wBWPuMdjAsBN8emHLO3/3jtwOhWqilbQ7f0/5h0JBo
 T3RB/EgwT4SQHvP72hxxb1fnpbAUAD+O8ohpm4Dbi7oIiPMfijzo7WxrNpMfWJJBf1VKSivAa
 2MV7OIi/lssG3WrbGeW9onwOur/3vU8RpmTVMqrd1MdqCN6w5lEQip4zSWRQcZ6Scu2aNlPo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288016>

The pthread_exit() function is not expected to return. Ever. On Windows,
we call ExitThread() whose documentation claims: "This function does not
return a value.":

	https://msdn.microsoft.com/en-us/library/windows/desktop/ms682659

Pointed out by Jeff King.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Relative to v1, only the commit message changed (to clarify that
	ExitThread() indeed never returns).

 compat/win32/pthread.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index 20b35a2..148db60 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -78,7 +78,7 @@ extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
 #define pthread_equal(t1, t2) ((t1).tid == (t2).tid)
 extern pthread_t pthread_self(void);
 
-static inline int pthread_exit(void *ret)
+static inline int NORETURN pthread_exit(void *ret)
 {
 	ExitThread((DWORD)(intptr_t)ret);
 }
-- 
2.7.2.windows.1.5.g64acc33
