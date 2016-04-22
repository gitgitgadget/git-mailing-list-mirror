From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/3] Improve the mmap() emulation on Windows
Date: Fri, 22 Apr 2016 16:31:17 +0200 (CEST)
Message-ID: <cover.1461335463.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Sven Strickroth <email@cs-ware.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 16:31:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atc7K-0006JT-Uy
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbcDVObc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 10:31:32 -0400
Received: from mout.gmx.net ([212.227.15.18]:52949 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753961AbcDVObb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:31:31 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MAgzj-1azuhQ0UNX-00Bst0; Fri, 22 Apr 2016 16:31:19
 +0200
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:WJH9idNmTK2yIoOay/Ts2tYmdLEdstFfLCOt3AKWFtg06mJRav1
 9thbhhn6y9zZCNh/x3s0egZpK3GeGNVWW5Sp1JYcV6qpHoeY6eBLGccZao9Yad3rR8dW97z
 3NE2llWUgJQR4KjCeYh4LjXSs6U0dmJVK0RaZYUAIDF9sFTlk5zxdCepGLQ0CX9ntLeSn23
 P1g0TozrQwrUgfF9BScBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q93AIBXP5BI=:O8gaHDwIcP5VaHwBgkdm+1
 1gw5f25V3nyLNp9JdPhw1iO9J+2ZmdM6SX/d/xAP+FFR0RpsW32/lIHYJyxlb9+PIDDvfz8H1
 lbATuUTCEuZ+G+noIxjKriv4W6Mgx0e7K5t4A2my/+BwPoRo9uA/bgqi95G9lCO27oq5QMGWH
 C6a9Pc8uOIotEeSFwLDRl48kq2pKcF7DehRADSqH4KN2tKl5jDC410MKW40vCkaunjeAqUVs0
 bRH9ALeu7z4hmSb9WfvfM3Aj9730NkywUfvqlwc8uawfZLQo6UcjWk7R5KjTQI9n4pKbwqBvs
 Al3jZ7T+2NVYa/LfhgptcN1TnCgHJXv7nkUfqHCSLP/ZFMtJf8ItcsqQwHRf6y8dMqnrwCwH3
 eq+41/7bFIA94kos6TpxbUMA86ceWLQCgDR0B6eSwzV/rGiRMV6D4Inw2VhWQiLhsSiyQvkv+
 q7jxrot6Y/MASfJ+0HiqdNMld1unrnEYaqjbw7ClAtVcxv2sZq8JgC/idZEJknnP+N9uhPRnV
 TzXuWQbYN+OmKAIa83mHEpVXz40npkppjbxETnyaORXX42LkDfqyhnYOmvXWagIKq5hLVOaMj
 PmAQtqs9mQ1vVXow4qm7N/j/KwYbpUasX0hvP/Fuisdrtox7/HtQL9ymUnaaCd+cv7jtS7kgF
 kwj6oDHOTWCp/Qw0uoOFNWxULPfT6227zfLXF3WyD2c04ySP24j7OOCqMacR2qprq3ciKPgwP
 eaJQF8Vpv6sJaAVQ9ZdSl8MXRXcXZei64PtCLWF2ILdh8r9du1mdySnZWoy21hfZz7XI+QBo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292207>

Kevin David reported a problem last October where a simple git fetch
would produce this error output:

	fatal: mmap failed: No error
	fatal: write error: Invalid argument

The reason was that several bits of our mmap() emulation left room for
improvement. These patches fix it, and made it already into Git
for Windows v2.6.2 and have been working without problems ever since.


Johannes Schindelin (3):
  win32mmap: set errno appropriately
  mmap(win32): avoid copy-on-write when it is unnecessary
  mmap(win32): avoid expensive fstat() call

 compat/win32mmap.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

-- 
2.8.1.306.gff998f2
