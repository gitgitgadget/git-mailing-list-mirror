From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/10] pack-bitmap.c: make pack_bitmap_filename() static
Date: Wed, 14 Jan 2015 15:40:53 -0800
Message-ID: <1421278855-8126-9-git-send-email-gitster@pobox.com>
References: <1421278855-8126-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 00:41:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBXZ9-0002o2-87
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 00:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbbANXla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 18:41:30 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751845AbbANXl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 18:41:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A6AC2DBB9;
	Wed, 14 Jan 2015 18:41:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=e62e
	KLWiRIrCAd1zs42AM/cAhhs=; b=wcSEIG+nbZHdiuuzrtC6/AJH7cCZv7Kziz+h
	pxWzrHRJq5ykETV6gyvKDUeR6dw5Av0OIoGB+/aa5KYdkPeKIq6msDCthDn/DWh1
	0/j1PM50y40t7ZW0mbEMhCfe9hwOs/zxuD1AOhSPDyHg99DKD+7nGRMYD/h0nCrJ
	3Rd3nwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=oMqt8w
	b2AXsTg9zJMMlg3p5rAbeGIW1+nX7e3XnCX7VBoiAcw3McEmO26s9HshTmk9GKxQ
	jsmCFWfGnW3q6FhGtXhLNkA6/jCKbgqrQ1jWTJ5bo0c2w1J0LaEqJw85Kml7v4rK
	BX6Yc3PtimIBdE5hjkpBEk5fkHeY9BJzmKpE8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F2E22DBB8;
	Wed, 14 Jan 2015 18:41:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E6EC2DB99;
	Wed, 14 Jan 2015 18:41:12 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc0-134-g109a908
In-Reply-To: <1421278855-8126-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D2B415D6-9C46-11E4-96EC-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262447>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pack-bitmap.c | 28 ++++++++++++++--------------
 pack-bitmap.h |  1 -
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 6a81841..0cd85f6 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -252,6 +252,20 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 	return 0;
 }
 
+static char *pack_bitmap_filename(struct packed_git *p)
+{
+	char *idx_name;
+	int len;
+
+	len = strlen(p->pack_name) - strlen(".pack");
+	idx_name = xmalloc(len + strlen(".bitmap") + 1);
+
+	memcpy(idx_name, p->pack_name, len);
+	memcpy(idx_name + len, ".bitmap", strlen(".bitmap") + 1);
+
+	return idx_name;
+}
+
 static int open_pack_bitmap_1(struct packed_git *packfile)
 {
 	int fd;
@@ -322,20 +336,6 @@ failed:
 	return -1;
 }
 
-char *pack_bitmap_filename(struct packed_git *p)
-{
-	char *idx_name;
-	int len;
-
-	len = strlen(p->pack_name) - strlen(".pack");
-	idx_name = xmalloc(len + strlen(".bitmap") + 1);
-
-	memcpy(idx_name, p->pack_name, len);
-	memcpy(idx_name + len, ".bitmap", strlen(".bitmap") + 1);
-
-	return idx_name;
-}
-
 static int open_pack_bitmap(void)
 {
 	struct packed_git *p;
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 487600b..0adcef7 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -38,7 +38,6 @@ int prepare_bitmap_git(void);
 void count_bitmap_commit_list(uint32_t *commits, uint32_t *trees, uint32_t *blobs, uint32_t *tags);
 void traverse_bitmap_commit_list(show_reachable_fn show_reachable);
 void test_bitmap_walk(struct rev_info *revs);
-char *pack_bitmap_filename(struct packed_git *p);
 int prepare_bitmap_walk(struct rev_info *revs);
 int reuse_partial_packfile_from_bitmap(struct packed_git **packfile, uint32_t *entries, off_t *up_to);
 int rebuild_existing_bitmaps(struct packing_data *mapping, khash_sha1 *reused_bitmaps, int show_progress);
-- 
2.3.0-rc0-134-g109a908
