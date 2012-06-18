From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/9] sha1_name.c: rename "now" to "current"
Date: Mon, 18 Jun 2012 15:05:32 -0700
Message-ID: <1340057139-8311-4-git-send-email-gitster@pobox.com>
References: <1340057139-8311-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 00:08:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgk7g-0005bJ-Ko
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 00:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868Ab2FRWId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 18:08:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752564Ab2FRWFr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 18:05:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4211297E3
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=J/MC
	MLperBdXOh8jMnj/8Ybe2gE=; b=wO6/mqK1+YzXVNyoB0273IDCmoyGi3nBh7PN
	Gy4DFkMR/PuUV8mR1iEupztX2lFvI/yqfs29+I5WFZgDgycDqxhdgJJbCzyvDS0t
	dZx7NY3xZbylpmCwyJkCsutUMB0/bovvhYajprUPMZnxiDTECWecMmM9f7Uz3RB5
	tq5IFHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=rP7FYR
	DJy5n425leo+Isnvt+3UAQqZw5NKV4LV2fODUoyuA3qpoyBbsbzLLpRBWYOyggmX
	xAUYGiuCWzSwrvUbAxu4uLZYv/uEvDuLl4jjPs73OXb5H+RaX7zCZmX7EnnH8zL5
	l5Z/g9kxGyEcMN+O8POIxw8WyaaxrA6NEQjkk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3975597E2
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C31ED97E0 for
 <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.11
In-Reply-To: <1340057139-8311-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C10D39C4-B991-11E1-908D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200174>

This variable points at the element we are currently looking at, and
does not have anything to do with the current time which the name
"now" implies.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 4cbca34..5224f39 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -93,11 +93,11 @@ static int find_short_packed_object(int len, const unsigned char *match, unsigne
 		last = num;
 		while (first < last) {
 			uint32_t mid = (first + last) / 2;
-			const unsigned char *now;
+			const unsigned char *current;
 			int cmp;
 
-			now = nth_packed_object_sha1(p, mid);
-			cmp = hashcmp(match, now);
+			current = nth_packed_object_sha1(p, mid);
+			cmp = hashcmp(match, current);
 			if (!cmp) {
 				first = mid;
 				break;
@@ -109,17 +109,17 @@ static int find_short_packed_object(int len, const unsigned char *match, unsigne
 			last = mid;
 		}
 		if (first < num) {
-			const unsigned char *now, *next;
-			now = nth_packed_object_sha1(p, first);
-			if (match_sha(len, match, now)) {
+			const unsigned char *current, *next;
+			current = nth_packed_object_sha1(p, first);
+			if (match_sha(len, match, current)) {
 				next = nth_packed_object_sha1(p, first+1);
 				if (!next|| !match_sha(len, match, next)) {
 					/* unique within this pack */
 					if (!found) {
-						found_sha1 = now;
+						found_sha1 = current;
 						found++;
 					}
-					else if (hashcmp(found_sha1, now)) {
+					else if (hashcmp(found_sha1, current)) {
 						found = 2;
 						break;
 					}
-- 
1.7.11
