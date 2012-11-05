From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/2] link_alt_odb_entries(): take (char *, len) rather than two pointers
Date: Mon,  5 Nov 2012 09:41:23 +0100
Message-ID: <1352104883-21053-3-git-send-email-mhagger@alum.mit.edu>
References: <1352104883-21053-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 05 09:42:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVIGG-0001oH-Qj
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 09:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424Ab2KEImB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 03:42:01 -0500
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:52906 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753412Ab2KEIl5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2012 03:41:57 -0500
X-AuditID: 1207440e-b7f036d0000008b5-8b-50977bd46641
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id C4.92.02229.4DB77905; Mon,  5 Nov 2012 03:41:56 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qA58fjnQ015704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 5 Nov 2012 03:41:55 -0500
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352104883-21053-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqHulenqAwb8tKhZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujA032tgK
	3gtU9E1dwdLA+Iy3i5GTQ0LAROLFv7nsELaYxIV769m6GLk4hAQuM0pMXrIJyjnNJPHwzy+w
	KjYBXYlFPc1MILaIgKzE98MbGUFsZoFcicXvboPVCAtESKx+1czaxcjBwSKgKrFhCQ9ImFfA
	RWLqnItsEMvkJD7seQRWzingKrH22AJmEFsIqGbDr4nMExh5FzAyrGKUS8wpzdXNTczMKU5N
	1i1OTszLSy3SNdbLzSzRS00p3cQICR++HYzt62UOMQpwMCrx8H6QmB4gxJpYVlyZe4hRkoNJ
	SZR3ZSVQiC8pP6UyI7E4I76oNCe1+BCjBAezkggvBwNQjjclsbIqtSgfJiXNwaIkzqu2RN1P
	SCA9sSQ1OzW1ILUIJivDwaEkwTuvCqhRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQj
	HhQZ8cXA2ABJ8QDtXQHSzltckJgLFIVoPcWoy3H0zdyHjEIsefl5qVLivDNAigRAijJK8+BW
	wJLFK0ZxoI+FeQ+CVPEAEw3cpFdAS5iAlmy/NAVkSUkiQkqqgXGem/vRNnGZ2FOTjp7QvPE9
	ccLr9m9OLLPlnvc67J+9KGUhy8kt4d08jMVvbTJ0NPtmP/l2eWPN4cKO77N7Ss5tOFAV9PRj
	tB9P06V7iVfXe7llBZxavjeRNfhG9+5fcf/cNUs0D513TS47HD3rQKuO0WrX9eLy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209054>

Change link_alt_odb_entries() to take the length of the "alt"
parameter rather than a pointer to the end of the "alt" string.  This
is the more common calling convention and simplifies the code a tiny
bit.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index c352413..40b2329 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -317,7 +317,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base, int
 	return 0;
 }
 
-static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
+static void link_alt_odb_entries(const char *alt, int len, int sep,
 				 const char *relative_base, int depth)
 {
 	struct string_list entries = STRING_LIST_INIT_NODUP;
@@ -330,7 +330,7 @@ static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
 		return;
 	}
 
-	alt_copy = xmemdupz(alt, ep - alt);
+	alt_copy = xmemdupz(alt, len);
 	string_list_split_in_place(&entries, alt_copy, sep, -1);
 	for (i = 0; i < entries.nr; i++) {
 		const char *entry = entries.items[i].string;
@@ -371,7 +371,7 @@ void read_info_alternates(const char * relative_base, int depth)
 	map = xmmap(NULL, mapsz, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
-	link_alt_odb_entries(map, map + mapsz, '\n', relative_base, depth);
+	link_alt_odb_entries(map, mapsz, '\n', relative_base, depth);
 
 	munmap(map, mapsz);
 }
@@ -385,7 +385,7 @@ void add_to_alternates_file(const char *reference)
 	if (commit_lock_file(lock))
 		die("could not close alternates file");
 	if (alt_odb_tail)
-		link_alt_odb_entries(alt, alt + strlen(alt), '\n', NULL, 0);
+		link_alt_odb_entries(alt, strlen(alt), '\n', NULL, 0);
 }
 
 void foreach_alt_odb(alt_odb_fn fn, void *cb)
@@ -409,7 +409,7 @@ void prepare_alt_odb(void)
 	if (!alt) alt = "";
 
 	alt_odb_tail = &alt_odb_list;
-	link_alt_odb_entries(alt, alt + strlen(alt), PATH_SEP, NULL, 0);
+	link_alt_odb_entries(alt, strlen(alt), PATH_SEP, NULL, 0);
 
 	read_info_alternates(get_object_directory(), 0);
 }
-- 
1.8.0
