From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/11] resolve_gitlink_ref_recursive(): drop arbitrary refname length limit
Date: Wed, 15 Oct 2014 17:06:20 +0200
Message-ID: <1413385583-4872-9-git-send-email-mhagger@alum.mit.edu>
References: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 17:07:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeQA9-0002Oj-Re
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 17:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbaJOPGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 11:06:45 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:53204 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751645AbaJOPGo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 11:06:44 -0400
X-AuditID: 12074414-f79f06d000000daf-97-543e8d8234a7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id A2.4F.03503.28D8E345; Wed, 15 Oct 2014 11:06:42 -0400 (EDT)
Received: from michael.fritz.box (p4FC96250.dip0.t-ipconnect.de [79.201.98.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s9FF6SNa020034
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 15 Oct 2014 11:06:41 -0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413385583-4872-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqNvUaxdi8PmylkXXlW4mi4beK8wW
	t1fMZ7bonvKW0eLfhBqLM28aGR3YPP6+/8DksXPWXXaPBZtKPS5eUvZY/MDL4/MmuQC2KG6b
	pMSSsuDM9Dx9uwTujL8H+hgL/nFVLF5m1MD4laOLkZNDQsBEYmPrQRYIW0ziwr31bF2MXBxC
	ApcZJXoWXmGEcI4zSTxpXMIMUsUmoCuxqKeZCSQhItDAKHHo1UKwFmaBRYwS7auugFUJC8RJ
	LLz/hAnEZhFQldh96zkjiM0r4CxxadkKJoh9chJ7J68G280p4CLx6+U2sBohoJoFSyezTGDk
	XcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10IvN7NELzWldBMjJMhEdjAeOSl3iFGAg1GJ
	h3fjXtsQIdbEsuLK3EOMkhxMSqK8ST12IUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeOcnAOV4
	UxIrq1KL8mFS0hwsSuK83xar+wkJpCeWpGanphakFsFkZTg4lCR47UGGChalpqdWpGXmlCCk
	mTg4QYZzSYkUp+alpBYllpZkxIOiI74YGB8gKR6gvZ4g7bzFBYm5QFGI1lOMilLivFkgCQGQ
	REZpHtxYWOp4xSgO9KUwbxhIFQ8w7cB1vwIazAQ0eGKoLcjgkkSElFQDo5ac/mKj7AdiMz+7
	v5A8FiYwT1mqU+yk6yEPQb3cBN2PncLhX18YzFI9e/7IsjQbwQvnNkzV+63rOuFncvmmnXq7
	+ie6PJUV+MbzO7v2sUXWgSuLP3dGTa9q0eTax8EyP49bxFJxpse+W8qCS5m6kyqu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This limit was added in

    0ebde32 (Add 'resolve_gitlink_ref()' helper function - 2007-04-09)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Theoretically, somebody else might be relying on
resolve_gitlink_ref_recursive() to fail for too-long reference names
to prevent path.c's pitiful error handling from returning "/bad-path/"
and causing a nonsensical file lookup. I doubt it, but if somebody is
worried about it we could leave out this patch and instead build the
MAXREFLEN check into parse_ref().

Long-term, I think we should fix up path.c to remove its PATH_MAX
limits. I've started working on that.

 refs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 9f2a0f8..e1aa6a4 100644
--- a/refs.c
+++ b/refs.c
@@ -1279,7 +1279,6 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
-#define MAXREFLEN (1024)
 
 /*
  * Called by resolve_gitlink_ref_recursive() after it failed to read
@@ -1308,7 +1307,7 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 	char buffer[128], *p;
 	char *path;
 
-	if (recursion > MAXDEPTH || strlen(refname) > MAXREFLEN)
+	if (recursion > MAXDEPTH)
 		return -1;
 	path = *refs->name
 		? git_path_submodule(refs->name, "%s", refname)
-- 
2.1.1
