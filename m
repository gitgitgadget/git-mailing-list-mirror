From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 02/19] mingw: do not trust MSYS2's MinGW gettext.sh
Date: Sun, 24 Jan 2016 16:43:19 +0100 (CET)
Message-ID: <3a064c5328909399551b05d40a2fa538bf7dff61.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:44:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMpd-0000ZT-9u
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbcAXPn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:43:56 -0500
Received: from mout.gmx.net ([212.227.17.22]:65457 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475AbcAXPnX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:43:23 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MLi1v-1aOC2F3CSZ-000pxK; Sun, 24 Jan 2016 16:43:20
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:cOVqYeMLFCgmqTuSDNEhJPGZadtgtRfasO5XepbiNayL8nqcoYA
 KOyGt3b6xiN7i/ZXytv3/vn6bqUE5SYgL64T33GFx0kHKH57N7klSep6ut4fzbxNDApIt9q
 7cfTz9dAFDr3oF0lg8bLXDtCVnio720h0u9opgUmA/mpTrEw3K5d4pdXlsrDaIXuz3FgSQ6
 slNUbQ+9/Q4/pcVwhtQhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FEHc0JCAdb4=:UHMHpec038RJYZXAqcitrY
 O3fklrUO8k8QM5tiroklYU0pdCuSZRgV17NhCF4sbdCnsiQTdVToKROwkESf01bQoApfi9Ke1
 YSK7xot+7BVFQBi1m7lkEVXOlRdb5wY0hjfqRO+FVIDj+r4MGKTsborOclPSNPoKn9o+vA9BU
 /HPVNsDF+JDLPNN7KlT9DI4+YbEMOXgz3VD2QbHLB7QW5iLxy6fTdL5mWAKUs6yEkaa4ZC38F
 IisOTHeg6U27F6iEoqY0hkHFQoQvNxbpG8vQUGSW3jYqlzbrcanqajfWSelKmQH3abohcLRax
 m4Yh2FIsDVxKnix8CvZvFrYeBF0X7/92C3vGfFya1sFk/6U7K0ZmsJ6/HGrnu6bY/57/i/ASy
 RVjTjFVv9hZFpTNxr3zKTzGviPNsQoC2M3gcUUyg1K4J6zGcU7twY+MICK2fXscWHrFYLH6rT
 xPgGbsJ/r6P9h9P62R/y7Hh7DK9XMjPJ34WcSoUuX9doxXNO5Yf09okSB+levpUBsPFrhGzKo
 ZWihgg0eIlB7LFyLklunvpgthzQG2/N8CH/Ln87/Ijg3h7On7hK3ifk8qOBx9ztn30yU7C95E
 JJhHMNjINOuS484kW7yDrMSc8nWSvV4oH6ankvMWLFkSUnbazMx35EbYPCORlcy7zBT8BClAc
 lN14nqkjhHj2Rpf6oC6uZyFTnu8ZkW079S4z8A79ayfogZJLqP5HsCdqpoBK6H9Nj06b+mfdl
 GwI5SoTJAwoUAUVTDs5W7PBmyFda1uabmwlB6TDTVRxK5PILlmilhJvfr6IH4j/EQZn7hCyB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284665>

It does not quite work because it produces DOS line endings which the
shell does not like at all.

This lets t0200-gettext-basic.sh, t0204-gettext-reencode-sanity.sh,
t3406-rebase-message.sh, t3903-stash.sh, t7400-submodule-basic.sh,
t7401-submodule-summary.sh, t7406-submodule-update.sh and
t7407-submodule-foreach.sh pass in Git for Windows' SDK.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 6b25661..d6f7980 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -561,6 +561,7 @@ else
 		INTERNAL_QSORT = YesPlease
 		HAVE_LIBCHARSET_H = YesPlease
 		NO_GETTEXT =
+		USE_GETTEXT_SCHEME = fallthrough
 		USE_LIBPCRE= YesPlease
 		NO_CURL =
 		USE_NED_ALLOCATOR = YesPlease
-- 
2.7.0.windows.1.7.g55a05c8
