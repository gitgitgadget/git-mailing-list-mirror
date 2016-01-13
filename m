From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 5/5] compat/winansi: support compiling with MSys2
Date: Wed, 13 Jan 2016 14:31:13 +0100 (CET)
Message-ID: <83eb6f9b075d56049ca80502f79127db9e61979b.1452691805.git.johannes.schindelin@gmx.de>
References: <cover.1452691805.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 14:32:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJLX3-00031T-B2
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 14:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933077AbcAMNcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 08:32:08 -0500
Received: from mout.gmx.net ([212.227.15.15]:61466 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932822AbcAMNcG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 08:32:06 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MdrK9-1aXqXP1kJJ-00Pek8; Wed, 13 Jan 2016 14:31:14
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452691805.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:e7XVYnVdDjXRrLrQLWAHEbHcGiAzmK0YPBAU2azLBmr1R5GM9O5
 QNXSCgRaerfS3tOWNOy8uQ4IgZFVmDAcWJuWaazTHb29mqMxElvnmZKWviv++fjU1xLRt03
 FXaHCefYQWkmE2+n68s3N+68iCyXv1JesPN2xhKQd0alPUXUgwaI+eCXzrShds2b1Wdq+28
 Q9n5c1yEaR70eL20/yWEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Dwz29gB+C1w=:xSzZTM0jWuH4ILOSk794/j
 hETYhRy5346vEHmI+LJYOAWqxzIfC+1YbH6902JgOpLexeYUBbF7rLdW+k/JFZysM+g73JvMM
 w/Z5ApNdl1upR5nFZlZd8H5wLQ5Jok4njG75wddUevEFx+iKpVuDEwEinV1LHURIm3hhBHWKc
 G8Z/OwJhEmDlPQL+D12iGTwGzp4M8PkKDT5ONIWklPH+S9CYp3ptsLVyQW0AQRNzus1nfTF/j
 2yWi++jDo0jAK3zynEna5FGAz9EwPnrk+ZzhGkn7bIaYvRzTKFCvYgmqdi8Sd1KbJPaY87+Gk
 DCUvtkiGgasZvtv55e4yupKahw+SrDOz/wPJimRl7xrAwbXEfzMlSTtPrRIUbbsAr6ikXDYRA
 Zc2sHnh5GVSdwnmll7tQMToA+uG9iqd1C+k1n88UMPHhUEtb/DXoSDv5M8B3U7AXStbTw8DBk
 UzTbkirzQCrX8cdCbHcfYUSbDAd9Q+zppg7oUa59HbnDyKU/dF/HNPUPKtIGu0uf0ag5MAyC7
 SFsRsuNNe52csj0muhEeCcjmHtmVy360aETEgQS17NmZ9Df2oFwTMYhiTraLWIwXL1BVEIEvC
 ypWbD6XxsJXaZ7x1FJOojcAR0/rIcZnG7DDp1Ms6w9f5JQ5qyMVzWphnYvUyWfsIMOdsXDkRO
 GSvqFqVGkb2cYigKdbLCA4G5joE3HCqY/NJPVK7jF8Ea3FDE1j31rPgUi+VCa1IeS8AoDzCvZ
 qIphzG+5MUH/cKVyfhH8LhuLo0FDeIPEyqN+0CHjJb6E697rINd3COkaJytfCeUUBw7TV5/O 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283920>

MSys2 already defines the _CONSOLE_FONT_INFOEX structure.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/winansi.c b/compat/winansi.c
index ceff55b..3aa5535 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -23,6 +23,7 @@ static HANDLE hthread, hread, hwrite;
 static HANDLE hconsole1, hconsole2;
 
 #ifdef __MINGW32__
+#if !defined(__MINGW64_VERSION_MAJOR) || __MINGW64_VERSION_MAJOR < 5
 typedef struct _CONSOLE_FONT_INFOEX {
 	ULONG cbSize;
 	DWORD nFont;
@@ -32,6 +33,7 @@ typedef struct _CONSOLE_FONT_INFOEX {
 	WCHAR FaceName[LF_FACESIZE];
 } CONSOLE_FONT_INFOEX, *PCONSOLE_FONT_INFOEX;
 #endif
+#endif
 
 typedef BOOL (WINAPI *PGETCURRENTCONSOLEFONTEX)(HANDLE, BOOL,
 		PCONSOLE_FONT_INFOEX);
-- 
2.6.3.windows.1.300.g1c25e49
