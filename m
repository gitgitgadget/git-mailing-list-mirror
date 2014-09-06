From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 12/32] prepare_index(): declare return value to be (const char *)
Date: Sat,  6 Sep 2014 09:50:26 +0200
Message-ID: <1409989846-22401-13-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:52:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAnT-0000Ln-7o
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbaIFHwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:52:30 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:55662 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751076AbaIFHwP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:52:15 -0400
X-AuditID: 1207440e-f79da6d0000002fc-79-540abd2e90f0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 9A.BD.00764.E2DBA045; Sat,  6 Sep 2014 03:52:14 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHB006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:13 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixO6iqKu3lyvEYPZ8K4uuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujPXHv7EXTOaoePZkPnsD41W2LkYODgkBE4lfhzK7GDmBTDGJC/fW
	A4W5OIQELjNKnOrbzgzhHGOSuNW8hgmkik1AV2JRTzMTSEJEoI1RYtfFzawgCWaBFImO592M
	ILawQIjEz9On2UFsFgFViX8b9jGD2LwCrhJPNq1gh1gnJ7Fh93+wek6g+PSmTjBbSMBFov1k
	P9MERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9XIzS/RSU0o3MUICjW8HY/t6mUOM
	AhyMSjy8hQ5cIUKsiWXFlbmHGCU5mJREefOWA4X4kvJTKjMSizPii0pzUosPMUpwMCuJ8HZM
	BsrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4XfYANQoWpaanVqRl
	5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDYiO+GBgdICkeoL2sIO28xQWJuUBRiNZTjLoc6zq/
	9TMJseTl56VKifMygRQJgBRllObBrYCllVeM4kAfC/OKgVTxAFMS3KRXQEuYgJaYp3OCLClJ
	REhJNTBmM4s6Jp1NvqywXWdL1ckd9rxM28ViprcIWWrOz7/utGvB/3a5G/37ndm7pxzKu7NU
	+xf7xS9hKU+KInSSPpvrP5JZJ6UQVs4TuiLIeAH3gysGOq6/32qdfZAodXrtYfPQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256559>

Declare the return value to be const to make it clear that we aren't
giving callers permission to write over the string that it points at.
(The return value is the filename field of a struct lock_file, which
can be used by a signal handler at any time and therefore shouldn't be
tampered with.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a3eaf4b..046be7e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -315,8 +315,8 @@ static void refresh_cache_or_die(int refresh_flags)
 		die_resolve_conflict("commit");
 }
 
-static char *prepare_index(int argc, const char **argv, const char *prefix,
-			   const struct commit *current_head, int is_status)
+static const char *prepare_index(int argc, const char **argv, const char *prefix,
+				 const struct commit *current_head, int is_status)
 {
 	struct string_list partial;
 	struct pathspec pathspec;
-- 
2.1.0
