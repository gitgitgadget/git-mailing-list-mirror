From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 05/11] pack_if_possible_fn(): use ref_type() instead of is_per_worktree_ref()
Date: Mon,  9 Nov 2015 18:03:42 +0100
Message-ID: <d229d316ab0cf086f5b93e5d720f011701129791.1447085798.git.mhagger@alum.mit.edu>
References: <cover.1447085798.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 18:04:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvpry-0007tx-Ns
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 18:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbbKIREc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 12:04:32 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57424 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752237AbbKIREW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 12:04:22 -0500
X-AuditID: 12074413-f79bd6d000007ac2-74-5640d20d1263
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 51.11.31426.D02D0465; Mon,  9 Nov 2015 12:04:13 -0500 (EST)
Received: from michael.fritz.box (p4FC97689.dip0.t-ipconnect.de [79.201.118.137])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA9H41Ys026059
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Nov 2015 12:04:11 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1447085798.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqMt7ySHMYPVZEYv5m04wWnRd6Way
	aOi9wmwxacpNJovbK+YzW/xo6WG26O37xOrA7vH3/Qcmj52z7rJ7nD2Y6fGsdw+jx8VLyh4L
	nt9n9/i8SS6APYrbJimxpCw4Mz1P3y6BO+P1x3msBa85K2bPvsfSwPiHvYuRk0NCwESi/Xwf
	lC0mceHeerYuRi4OIYHLjBIPfm1hhnBOMElc3tbPAlLFJqArsainmQnEFhFQk5jYdogFpIhZ
	4COjxNwfC4ESHBzCAgkSD+4YgtSwCKhKbG2fzQZi8wpESbz7NZERYpucxJT77WBzOAUsJHac
	+AcWFxIwl5i4ag3TBEbeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfVyM0v0UlNKNzFC
	Qk94B+Ouk3KHGAU4GJV4eCNm2ocJsSaWFVfmHmKU5GBSEuWNPuEQJsSXlJ9SmZFYnBFfVJqT
	WnyIUYKDWUmEt2AXUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMG7
	6QJQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoNuKLgdEBkuIB2rsDpJ23uCAx
	FygK0XqKUVFKnHcRSEIAJJFRmgc3FpZQXjGKA30pzGtwEaiKB5iM4LpfAQ1mAhq81B9scEki
	QkqqgTHGpi7z76LdU8+2r0hgnHz3zxXe2htJs075nWWI9d1yxcdmSfu1HwbmOXVhdW+ilGtz
	7hqEVPx0mtZwzbfRgfH5lvD+lYKvZ7a83t/a/tp7/tJG06xImaQnR61d1k56dLV1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281061>

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
