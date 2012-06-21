From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 9/9] sha1_name.c: get_describe_name() by definition groks
 only commits
Date: Wed, 20 Jun 2012 23:35:32 -0700
Message-ID: <1340260532-11378-10-git-send-email-gitster@pobox.com>
References: <1340260532-11378-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 08:36:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shb07-0007HF-0B
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 08:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436Ab2FUGf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 02:35:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44012 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295Ab2FUGfv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 02:35:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6D308B39
	for <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=TiAh
	ijJr/ltJrEIluZ743XPxjmQ=; b=e0FerYF82eS5jKdsz4NcJJaia2rrpTtt8veq
	Jt4g81gRQ5IU311OnRuQYsjsn+/0reSV00Uvr++VlXLuVlshQy29+nci/YmjfPHG
	L2wB0MSME7up/sXyXTdS7q8Gp6xNZYv5AshPk4rHXScOd9+C4sz7IXuG3Y3/6YVM
	YKqx1kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=N5M+49
	hFvBAbGhWV0+pE4bA8+Da92G4yxjZlCW4L1yWTnzF1bqDZFx+YRN/mNC0TxxFw8E
	3ihKxuJUZ8uierJYD2a6ruTBfFeyEvjp4ipHskZop9GprOCwam/UkpzRmZEKVpVQ
	3SmX+zbsu1EBowW//xZgZ/6AGBpitLzsqj4qo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F3E38B38
	for <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E55A8B37 for
 <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:50 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.2.gd284367
In-Reply-To: <1340260532-11378-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5783FA84-BB6B-11E1-90CE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200394>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 58dbbe2..15e97eb 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -606,6 +606,7 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 static int get_describe_name(const char *name, int len, unsigned char *sha1)
 {
 	const char *cp;
+	unsigned flags = GET_SHORT_QUIETLY | GET_SHORT_COMMIT_ONLY;
 
 	for (cp = name + len - 1; name + 2 <= cp; cp--) {
 		char ch = *cp;
@@ -616,7 +617,7 @@ static int get_describe_name(const char *name, int len, unsigned char *sha1)
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
-				return get_short_sha1(cp, len, sha1, GET_SHORT_QUIETLY);
+				return get_short_sha1(cp, len, sha1, flags);
 			}
 		}
 	}
-- 
1.7.11.2.gd284367
