From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 02/25] refs/files-backend.c: new file, renamed from refs.c
Date: Tue,  3 Nov 2015 08:39:46 +0100
Message-ID: <5910b009877933ad63ca376a904f5003fcd3e627.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:40:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWCh-0007BW-HZ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbbKCHkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:40:24 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:48275 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752677AbbKCHkU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:40:20 -0500
X-AuditID: 12074411-f797e6d000007df3-c7-563864e2205f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 9D.B5.32243.2E468365; Tue,  3 Nov 2015 02:40:18 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDcx016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:17 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqPsoxSLMYO4WHouuK91MFg29V5gt
	bq+Yz2zxb0KNA4vH3/cfmDwWbCr1uHhJ2ePzJrkAlihum6TEkrLgzPQ8fbsE7owXSzcwF0wQ
	q3h8eTFLA+NaoS5GTg4JAROJb9cfsUDYYhIX7q1n62Lk4hASuMwo8ff5C2YI5xiTxPLNr5hA
	qtgEdCUW9TSD2SICahIT2w6BdTMLFEjMXrqVHcQWFvCVePqxnQ3EZhFQlTh95BuYzSsQJXH7
	7RMmiG1yElPut4PZnAIWEg/u/gHrFRIwl9h0bxnbBEbeBYwMqxjlEnNKc3VzEzNzilOTdYuT
	E/PyUot0TfVyM0v0UlNKNzFCgkdwB+OMk3KHGAU4GJV4eBcsMQ8TYk0sK67MPcQoycGkJMq7
	LsYiTIgvKT+lMiOxOCO+qDQntfgQowQHs5IIb0EgUI43JbGyKrUoHyYlzcGiJM7Lt0TdT0gg
	PbEkNTs1tSC1CCYrw8GhJMF7KRmoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4U
	G/HFwOgASfEA7V0J0s5bXJCYCxSFaD3FqCglzjsZJCEAksgozYMbC0sJrxjFgb4U5r0AUsUD
	TCdw3a+ABjMBDQ7fZgoyuCQRISXVwBjxSYzJjEmt1u3aNnsjqevOiQd5zd5Kpu4NXjmzWvJC
	ySKhuroeLsNZJy/d+hL+1WZVc83lWxdE7IOqDV7U/9ri4fcjdPmm7otid6eKuPXyRO2N2Bvi
	X+6xfy/n0iv7W78eV192uj1P/KGb94SnV248k3jPOf1SZ7qF23H3wB8r3/66ldBq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280755>

From: Ronnie Sahlberg <sahlberg@google.com>

We are about to split up the reference code into multiple source
files, to separate the generic code from the code that is specific to
the current files-based backend. To keep things organized, we will
move the reference-related code to a subdirectory, "refs/". Over time,
more files will appear in this subdirectory.

As the first step, rename refs.c to refs/files-backend.c. This file
will eventually contain only the code specific to the files-based
backend. In subsequent commits we will move backend-agnostic code to a
new refs/refs.c file that will hold the common refs code that is
shared across backends.

The reason for first moving all the code to refs/files-backend.c and
then moving the backend agnostic code back to refs/refs.c instead of
moving refs.c to refs/refs.c first is because the code that will
eventually remain in this new files-backend.c file is so entangled
that it would then be very difficult to break the split up into small
independent patches/chunks.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Makefile                       |  4 ++--
 refs.c => refs/files-backend.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)
 rename refs.c => refs/files-backend.c (99%)

diff --git a/Makefile b/Makefile
index 0d9f5dd..1a63383 100644
--- a/Makefile
+++ b/Makefile
@@ -762,8 +762,8 @@ LIB_OBJS += quote.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += reflog-walk.o
-LIB_OBJS += refs.o
 LIB_OBJS += ref-filter.o
+LIB_OBJS += refs/files-backend.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
 LIB_OBJS += rerere.o
@@ -2412,7 +2412,7 @@ profile-clean:
 	$(RM) $(addsuffix *.gcno,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
 
 clean: profile-clean coverage-clean
-	$(RM) *.o *.res block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o
+	$(RM) *.o *.res refs/*.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o
 	$(RM) xdiff/*.o vcs-svn/*.o ewah/*.o builtin/*.o
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
diff --git a/refs.c b/refs/files-backend.c
similarity index 99%
rename from refs.c
rename to refs/files-backend.c
index 132eff5..dc39b36 100644
--- a/refs.c
+++ b/refs/files-backend.c
@@ -1,10 +1,10 @@
-#include "cache.h"
-#include "lockfile.h"
-#include "refs.h"
-#include "object.h"
-#include "tag.h"
-#include "dir.h"
-#include "string-list.h"
+#include "../cache.h"
+#include "../refs.h"
+#include "../lockfile.h"
+#include "../object.h"
+#include "../tag.h"
+#include "../dir.h"
+#include "../string-list.h"
 
 struct ref_lock {
 	char *ref_name;
-- 
2.6.2
