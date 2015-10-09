From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 07/13] push_refs_with_export: convert to struct object_id
Date: Fri,  9 Oct 2015 01:43:53 +0000
Message-ID: <1444355039-186351-8-git-send-email-sandals@crustytoothpaste.net>
References: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 03:46:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkMkw-0001vC-3F
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 03:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974AbbJIBps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 21:45:48 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58076 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755822AbbJIBpL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2015 21:45:11 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 077CF2809D;
	Fri,  9 Oct 2015 01:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1444355111;
	bh=fEOyNKIJSF1a9nVOigkPb2/eK9M7IGGNxARD+bkJsvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0foN9fqRAq5tGr9BnTTRf1/Nj7lzIX8YDCxri202eplaWe50wIF4BQ7CXuHjvRDRj
	 PsTcc8gYVzKtcBfFfue9FNFF8NrJURUbnNh7hGRBaDjkmmGXuieCUacSjGMlx2PSYI
	 Vdvo1VRVD8WyQGNp74jGN9cjls6f7RB8bYofAl+tTumkbsxhL1FctFfXh3e7TtPfu9
	 WLjm9F3YTLKr1yai6+Mj25LFyb9FFc2cpm2AbTQIdbNoaPvEi/+wuzTVtnVcfCpupu
	 znAlN6n3EAU4Fm4FUJjlcc6VOn4qwXXJn6mnlHGEY/Opa+/r5YkzI4aO4oUIpcQqxw
	 ib/JKYsMc8eGK/u9wrN2eGgmpZYUe+DXEJn74OO65N9ehd/COLfGf9Irk3o0DDVHn+
	 Ft0unLUV/p0HS59j1kiqTSjW6udSFU0oUDqO9/6Oneg85ZdG3Hfq4KvXoX5aq5YHWE
	 v2aM4MvkVgtrjvbTlVvVZ7Tme26xvisRr0uYss1pfVl5lLwPjSE
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.49 ALL_TRUSTED,BAYES_00,T_FILL_THIS_FORM_SHORT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279295>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 transport-helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 91cb0e72..0eb3cf01 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -878,13 +878,13 @@ static int push_refs_with_export(struct transport *transport,
 
 	for (ref = remote_refs; ref; ref = ref->next) {
 		char *private;
-		unsigned char sha1[20];
+		struct object_id oid;
 
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
-		if (private && !get_sha1(private, sha1)) {
+		if (private && !get_sha1(private, oid.hash)) {
 			strbuf_addf(&buf, "^%s", private);
 			string_list_append(&revlist_args, strbuf_detach(&buf, NULL));
-			hashcpy(ref->old_oid.hash, sha1);
+			oidcpy(&ref->old_oid, &oid);
 		}
 		free(private);
 
@@ -898,7 +898,7 @@ static int push_refs_with_export(struct transport *transport,
 					name = resolve_ref_unsafe(
 						 ref->peer_ref->name,
 						 RESOLVE_REF_READING,
-						 sha1, &flag);
+						 oid.hash, &flag);
 					if (!name || !(flag & REF_ISSYMREF))
 						name = ref->peer_ref->name;
 
-- 
2.6.1
