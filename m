From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 10/19] mingw: disable mkfifo-based tests
Date: Sun, 24 Jan 2016 16:44:54 +0100 (CET)
Message-ID: <016ed650fa03b4a2a0d61a4aefff7f193df10bc3.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:45:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMqg-0001EE-Kp
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:45:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768AbcAXPpC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:45:02 -0500
Received: from mout.gmx.net ([212.227.15.15]:53249 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753717AbcAXPpB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:45:01 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LsChr-1ZyfRw1fDj-013vw1; Sun, 24 Jan 2016 16:44:55
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:dItwY+LN6qRRxVAT61RUSvfwoIT4sCmWWIygflkXNI8ytsaa2V2
 JsW5N0eCJxng5/JRmfH5fKJSH7cDWSVgYRxUerlqbtEXlfcRonC31tfi54PKgLXa0yNt9H+
 xY1JA8Nchtn8/B9E+hcO34yBdVeM4C5MYISSGcPKiHKcwkdLjazZeBMe6e9f9oAqYY4vgYF
 6zb+v3qjg21ZdACw+SvXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PWwRlwWD6YM=:24ebM9jWZ6p64EkeagW4Sa
 mbMDuhXdd6qOMWKXLfJqNKWvCZwgJvfNWzifOz1FErutXsRS46WGEzCsyJWVk0EJC/urHTDNY
 E6ASX1zLvBtgEpcGdI3bksiAIuFsDtlDE8atFNgedlyIYypTJnRmfaK2uUqV5m19WCoubvb5q
 BnZm3JuIneafNe9A+bzMEl5J+BFxj0LPJUOWmJrEU2vVnG9aGNIoK6d0anqrOYUdMH+Vb25/C
 095uSK9eur3BwaPzfb+zwaIIK9bTZDR98vYvkWxoOzuxZhFYzghqsaa0P5/YPZj06kBzykRVz
 /8TvAOihPmKGeLv65E+hY1Vf8T1V6WRX7XXadonzUhSR6KlTD6X9hxSFgYsJgHqIzcbd7iCki
 QSiZ5uZE3CwtBneRzaXbjGlw76fgzwTd/vaninc14ac0IgdyqU+/m0BCi5/svYGpQqr3hAry3
 MvRR4fEVx99DpeyDNkjccAkUaxKkTFZdlVpBu9LMMYfB47bFNm5j6cYYMvu2JhZV/7WLHue7e
 xcYOFufZ6S7B2+nXc/9WOcA3h/PapSL+t84ZtMtHAzKmgJg90uOeY31+ApJ0rS3yoCJLmEFvv
 ZHtfgxESbpih36qxnrCqaHMogEVxy03My56odKmDPabfA8GwSy9Aj8NQTqJazBdWq824pCc/5
 T0pmiU3oMarDGN/R9T0QTuyClV6W2ZiDReJ3JXIbTu3q0qpduGfra69Tv/ekS/Je2WJjP4D2W
 Ahh/fNZ7OmfiylWfBx6ZE5QktqGefXlUgexlhN2klpT6DWOCh38K93AOMgGOKopI+TGIIjFt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284674>

MSYS2 (the POSIX emulation layer used by Git for Windows' Bash) actually
has a working mkfifo. The only problem is that it is only emulating
named pipes through the MSYS2 runtime; The Win32 API has no idea about
named pipes, hence the Git executable cannot access those pipes either.

The symptom is that Git fails with a '<name>: No such file or directory'
because MSYS2 emulates named pipes through special-crafted '.lnk' files.

The solution is to tell the test suite explicitly that we cannot use
named pipes when we want to test on Windows.

This lets t4056-diff-order.sh, t9010-svn-fe.sh and t9300-fast-import.sh
pass.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index bd4b02e..1470c8d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -998,7 +998,7 @@ test_i18ngrep () {
 test_lazy_prereq PIPE '
 	# test whether the filesystem supports FIFOs
 	case $(uname -s) in
-	CYGWIN*)
+	CYGWIN*|MINGW*)
 		false
 		;;
 	*)
-- 
2.7.0.windows.1.7.g55a05c8
