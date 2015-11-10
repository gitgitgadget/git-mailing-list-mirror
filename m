From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 04/10] pack_if_possible_fn(): use ref_type() instead of is_per_worktree_ref()
Date: Tue, 10 Nov 2015 12:42:34 +0100
Message-ID: <e9063e3bf2383cc9cb9b0d8270cd9255e58450b4.1447154711.git.mhagger@alum.mit.edu>
References: <cover.1447154711.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 12:43:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw7Ks-0000ro-4Y
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 12:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247AbbKJLnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 06:43:32 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:51859 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752100AbbKJLnK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2015 06:43:10 -0500
X-AuditID: 12074414-f794f6d000007852-57-5641d842b94a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id D8.35.30802.248D1465; Tue, 10 Nov 2015 06:42:58 -0500 (EST)
Received: from michael.fritz.box (p4FC97D33.dip0.t-ipconnect.de [79.201.125.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tAABglj8014324
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 10 Nov 2015 06:42:56 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1447154711.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqOt0wzHM4P5HEYv5m04wWnRd6Way
	aOi9wmwxacpNJovbK+YzW/xo6WG2mHnV2qK37xOrA4fH3/cfmDx2zrrL7nH2YKbHs949jB4X
	Lyl77F+6jc1jwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGe8/jiPteA1Z8Xs2fdYGhj/sHcx
	cnJICJhIdN/uZISwxSQu3FvP1sXIxSEkcJlR4sDbtVDOCSaJ++1LwTrYBHQlFvU0M4HYIgJq
	EhPbDrGA2MwCy5gkZu217WLk4BAWSJB4eV4XxGQRUJV490MfpIJXIEri9p7FbBC75CSm3G9n
	AinhFLCQmHsuAyQsJGAucbx9IuMERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt9HIz
	S/RSU0o3MULCUGQH45GTcocYBTgYlXh4J3xzCBNiTSwrrsw9xCjJwaQkyrv/lGOYEF9Sfkpl
	RmJxRnxRaU5q8SFGCQ5mJRFe+xdA5bwpiZVVqUX5MClpDhYlcd5vi9X9hATSE0tSs1NTC1KL
	YLIyHBxKErzs14GGChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIOiIr4YGBcgKR6g
	vUog7bzFBYm5QFGI1lOMilLivNuuASUEQBIZpXlwY2HJ5RWjONCXwrxsIO08wMQE1/0KaDAT
	0OCl/iAPFZckIqSkGhgXPPoSb/HQf/4syzfzjjL8WL5hUlbqzzfN+/wjko4dMrs3r6o+42bv
	he6AN2fUuF8ee566eXpPjIhblpzI3kWR7Fqv4tQK/NyeCfzcUVzLfvLEv76G3T/f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281113>

is_per_worktree_ref() will soon be made private, so use the public
interface, ref_type(), in its place. And now that we're using
ref_type(), we can make it clear that we won't pack pseudorefs. This was
the case before, but due to the not-so-obvious reason that this function
is applied to references via the loose reference cache, which only
includes references that live inside "refs/".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 480de9a..82129f0 100644
--- a/refs.c
+++ b/refs.c
@@ -2671,8 +2671,6 @@ struct pack_refs_cb_data {
 	struct ref_to_prune *ref_to_prune;
 };
 
-static int is_per_worktree_ref(const char *refname);
-
 /*
  * An each_ref_entry_fn that is run over loose references only.  If
  * the loose reference can be packed, add an entry in the packed ref
@@ -2687,7 +2685,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	int is_tag_ref = starts_with(entry->name, "refs/tags/");
 
 	/* Do not pack per-worktree refs: */
-	if (is_per_worktree_ref(entry->name))
+	if (ref_type(entry->name) != REF_TYPE_NORMAL)
 		return 0;
 
 	/* ALWAYS pack tags */
-- 
2.6.2
