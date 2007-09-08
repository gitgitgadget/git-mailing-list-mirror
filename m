From: David Kastrup <dak@gnu.org>
Subject: [PATCH] diff-delta.c: rename {a,}{entry,hash} to {,u}{entry,hash}
Date: Sat, 8 Sep 2007 10:54:03 +0200
Organization: Organization?!?
Message-ID: <f1161c08aeeca60b6c33af34ccea68fd99b9ea4e.1189243702.git.dak@gnu.org>
References: <0cd39105dcd57a60eca290db598613aafcc8c577.1189243702.git.dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 11:31:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITwfG-0003FG-Hm
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 11:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbXIHJbf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 05:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbXIHJbf
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 05:31:35 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:36736 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751370AbXIHJbe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2007 05:31:34 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 38B7631F4BD
	for <git@vger.kernel.org>; Sat,  8 Sep 2007 11:31:33 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id DCCD223D327
	for <git@vger.kernel.org>; Sat,  8 Sep 2007 11:31:32 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-013-010.pools.arcor-ip.net [84.61.13.10])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id ADD593425E5
	for <git@vger.kernel.org>; Sat,  8 Sep 2007 11:31:32 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 468021CAD71E; Sat,  8 Sep 2007 11:31:32 +0200 (CEST)
X-From-Line: f1161c08aeeca60b6c33af34ccea68fd99b9ea4e Mon Sep 17 00:00:00 2001
In-Reply-To: <0cd39105dcd57a60eca290db598613aafcc8c577.1189243702.git.dak@gnu.org>
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4194/Sat Sep  8 06:33:29 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58112>

The variables for the packed entries are now called just entry and
hash rather than aentry+ahash, and those for the unpacked entries have
been renamed to uentry and uhash from the original entry and hash.

While this makes the diff to the unchanged code larger, it matches the
type declarations better.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 diff-delta.c |   65 ++++++++++++++++++++++++++++-----------------------------
 1 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 1b4b1c1..e7c33aa 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -135,8 +135,8 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	unsigned int i, hsize, hmask, entries, prev_val, *hash_count;
 	const unsigned char *data, *buffer = buf;
 	struct delta_index *index;
-	struct unpacked_index_entry *entry, **hash;
-	struct index_entry *aentry, **ahash;
+	struct unpacked_index_entry *uentry, **uhash;
+	struct index_entry *entry, **hash;
 	void *mem;
 	unsigned long memsize;
 
@@ -153,21 +153,21 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	hmask = hsize - 1;
 
 	/* allocate lookup index */
-	memsize = sizeof(*hash) * hsize +
-		  sizeof(*entry) * entries;
+	memsize = sizeof(*uhash) * hsize +
+		  sizeof(*uentry) * entries;
 	mem = malloc(memsize);
 	if (!mem)
 		return NULL;
-	hash = mem;
-	mem = hash + hsize;
-	entry = mem;
+	uhash = mem;
+	mem = uhash + hsize;
+	uentry = mem;
 
-	memset(hash, 0, hsize * sizeof(*hash));
+	memset(uhash, 0, hsize * sizeof(*uhash));
 
 	/* allocate an array to count hash entries */
 	hash_count = calloc(hsize, sizeof(*hash_count));
 	if (!hash_count) {
-		free(hash);
+		free(uhash);
 		return NULL;
 	}
 
@@ -181,15 +181,15 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 			val = ((val << 8) | data[i]) ^ T[val >> RABIN_SHIFT];
 		if (val == prev_val) {
 			/* keep the lowest of consecutive identical blocks */
-			entry[-1].entry.ptr = data + RABIN_WINDOW;
+			uentry[-1].entry.ptr = data + RABIN_WINDOW;
 			--entries;
 		} else {
 			prev_val = val;
 			i = val & hmask;
-			entry->entry.ptr = data + RABIN_WINDOW;
-			entry->entry.val = val;
-			entry->next = hash[i];
-			hash[i] = entry++;
+			uentry->entry.ptr = data + RABIN_WINDOW;
+			uentry->entry.val = val;
+			uentry->next = uhash[i];
+			uhash[i] = uentry++;
 			hash_count[i]++;
 		}
 	}
@@ -209,17 +209,17 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	for (i = 0; i < hsize; i++) {
 		if (hash_count[i] < HASH_LIMIT)
 			continue;
-		entry = hash[i];
+		uentry = uhash[i];
 		do {
-			struct unpacked_index_entry *keep = entry;
+			struct unpacked_index_entry *keep = uentry;
 			int skip = hash_count[i] / HASH_LIMIT;
 			do {
 				--entries;
-				entry = entry->next;
-			} while(--skip && entry);
+				uentry = uentry->next;
+			} while(--skip && uentry);
 			++entries;
-			keep->next = entry;
-		} while(entry);
+			keep->next = uentry;
+		} while(uentry);
 	}
 	free(hash_count);
 
@@ -227,13 +227,12 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	 * linked lists */
 
 	memsize = sizeof(*index)
-		+ sizeof(*ahash) * (hsize+1)
-		+ sizeof(*aentry) * entries;
-
+		+ sizeof(*hash) * (hsize+1)
+		+ sizeof(*entry) * entries;
 	mem = malloc(memsize);
 
 	if (!mem) {
-		free(hash);
+		free(uhash);
 		return NULL;
 	}
 
@@ -244,25 +243,25 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	index->hash_mask = hmask;
 
 	mem = index + 1;
-	ahash = mem;
-	mem = ahash + (hsize+1);
-	aentry = mem;
+	hash = mem;
+	mem = hash + (hsize+1);
+	entry = mem;
 
 	/* Coalesce all entries belonging to one linked list into
 	 * consecutive array entries */
 
 	for (i = 0; i < hsize; i++) {
-		ahash[i] = aentry;
-		for (entry = hash[i]; entry; entry = entry->next)
-			*aentry++ = entry->entry;
+		hash[i] = entry;
+		for (uentry = uhash[i]; uentry; uentry = uentry->next)
+			*entry++ = uentry->entry;
 	}
 
 	/* Sentinel value to indicate the length of the last hash
 	 * bucket */
 
-	ahash[hsize] = aentry;
-	assert(aentry - (struct index_entry *)mem == entries);
-	free(hash);
+	hash[hsize] = entry;
+	assert(entry - (struct index_entry *)mem == entries);
+	free(uhash);
 
 	return index;
 }
-- 
1.5.3.GIT
