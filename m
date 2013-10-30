From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 21/23] ref_remote_duplicates(): extract a function handle_duplicate()
Date: Wed, 30 Oct 2013 06:33:10 +0100
Message-ID: <1383111192-23780-22-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:42:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOXm-0007Xo-Cg
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab3J3FmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:42:07 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:48314 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752692Ab3J3FmC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:42:02 -0400
X-AuditID: 1207440e-b7fbc6d000004ad9-3e-52709a712149
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id F0.1E.19161.17A90725; Wed, 30 Oct 2013 01:34:41 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIW014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:34:39 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqFs4qyDI4PRGNYvpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE7Y8qO/2wFnzgr1qx/zNLAeIW9i5GTQ0LAROLImgPMELaYxIV769lAbCGBy4wS39fYdTFy
	AdlXmCTe/l3KCpJgE9CVWNTTzARiiwioSUxsO8QCUsQsMJFZ4vj0RSwgCWGBCIkLW7oZQWwW
	AVWJGbcmgMV5BVwlZjfvhtqmIHGjeSrYUE6g+KddN9khNrtINLV/Zp/AyLuAkWEVo1xiTmmu
	bm5iZk5xarJucXJiXl5qka6xXm5miV5qSukmRkjY8u1gbF8vc4hRgINRiYfX4EF+kBBrYllx
	Ze4hRkkOJiVR3rQpBUFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHinHwcq501JrKxKLcqHSUlz
	sCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8CrPBBoqWJSanlqRlplTgpBm4uAEEVwgG3iA
	NvCAFPIWFyTmFmemQxSdYlSUEudNAkkIgCQySvPgBsASzCtGcaB/hCHaeYDJCa77FdBgJqDB
	e1jyQAaXJCKkpBoY5RysKvZlXGW75XPwpZH2n4dH/X8cnbF/w2fhiWvmLN0Ukbcgm42TaW6T
	jIN/nWBJUuj2jEdqq6YLPJGJ3nTqOOsiiR6fGd372W6v6bmcr7SH+fKOa5FTq2ZN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236981>

It will become more complex in a moment.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 remote.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/remote.c b/remote.c
index c90a2bf..2deb2db 100644
--- a/remote.c
+++ b/remote.c
@@ -745,6 +745,15 @@ int for_each_remote(each_remote_fn fn, void *priv)
 	return result;
 }
 
+static void handle_duplicate(struct ref *ref1, struct ref *ref2)
+{
+	if (strcmp(ref1->name, ref2->name))
+		die("%s tracks both %s and %s",
+		    ref2->peer_ref->name, ref1->name, ref2->name);
+	free(ref2->peer_ref);
+	free(ref2);
+}
+
 struct ref *ref_remove_duplicates(struct ref *ref_map)
 {
 	struct string_list refs = STRING_LIST_INIT_NODUP;
@@ -766,14 +775,7 @@ struct ref *ref_remove_duplicates(struct ref *ref_map)
 
 			if (item->util) {
 				/* Entry already existed */
-				if (strcmp(((struct ref *)item->util)->name,
-					   ref->name))
-					die("%s tracks both %s and %s",
-					    ref->peer_ref->name,
-					    ((struct ref *)item->util)->name,
-					    ref->name);
-				free(ref->peer_ref);
-				free(ref);
+				handle_duplicate((struct ref *)item->util, ref);
 			} else {
 				*p = ref;
 				p = &ref->next;
-- 
1.8.4.1
