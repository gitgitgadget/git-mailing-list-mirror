From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/18] entry.c: mark file-local function static
Date: Mon, 11 Jan 2010 23:52:49 -0800
Message-ID: <1263282781-25596-7-git-send-email-gitster@pobox.com>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:54:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbaW-00056x-T8
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab0ALHx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277Ab0ALHxZ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:25 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab0ALHxV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F7078E88C
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=+a3w
	iwuPSVgo6Hgo9PylVChjPOA=; b=lcmnmP+TQzqHZ0a/yeSgmXR/5+47WlgBDejy
	sjE0wvfgX0/2YDAM/wjHSExv6MVYtoJzQHK82zW1VomOGaJzHrbRE8x/DF8z3rvC
	fLPysg1NbEHS0EmUFXY+Rft3dwTf2UP7MfJtK2HhFbKJw85RNz0mIuWOyTs1DVIO
	LuAaK28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=bKEhnc
	VsEXpafwTlATqrI0R4bxnV9wT9DQ+CJQ3iFdcrKwunp/PatgT3BOqmR4zVyzmvtz
	p6XuLmfmgk4bMvaM1DLa5UtTi6nPxrwsGiIzzbW+yx2jW9K1UISHOfJdQCRJrAKH
	POobTiZdhD2MFCvz5z5DL1gEdnuBva5LGrGRY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 183968E88B
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EAA48E88A for
 <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:20 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
In-Reply-To: <1263282781-25596-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8D964044-FF4F-11DE-99AA-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136697>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h |    3 ---
 entry.c |    2 +-
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 3f9ee86..30b9048 100644
--- a/cache.h
+++ b/cache.h
@@ -473,9 +473,6 @@ extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_obje
 extern int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 
-/* "careful lstat()" */
-extern int check_path(const char *path, int len, struct stat *st, int skiplen);
-
 #define REFRESH_REALLY		0x0001	/* ignore_valid */
 #define REFRESH_UNMERGED	0x0002	/* allow unmerged */
 #define REFRESH_QUIET		0x0004	/* be quiet about it */
diff --git a/entry.c b/entry.c
index 06d24f1..55b988e 100644
--- a/entry.c
+++ b/entry.c
@@ -179,7 +179,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
  * This is like 'lstat()', except it refuses to follow symlinks
  * in the path, after skipping "skiplen".
  */
-int check_path(const char *path, int len, struct stat *st, int skiplen)
+static int check_path(const char *path, int len, struct stat *st, int skiplen)
 {
 	const char *slash = path + len;
 
-- 
1.6.6.280.ge295b7.dirty
