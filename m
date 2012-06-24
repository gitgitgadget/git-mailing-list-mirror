From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/9] sha1_name.c: rename "now" to "current"
Date: Sat, 23 Jun 2012 17:11:25 -0700
Message-ID: <1340496691-12258-4-git-send-email-gitster@pobox.com>
References: <1340496691-12258-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 02:12:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiaRJ-0001ZB-U5
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 02:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756661Ab2FXAMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jun 2012 20:12:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43752 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756506Ab2FXALj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 20:11:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 710DB8F20
	for <git@vger.kernel.org>; Sat, 23 Jun 2012 20:11:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=fXGz
	fs6AQycOvn+nQdke9HhchAU=; b=q41cCvi5yRYlMUOvchUyP2sRP9OPmHou7qFB
	1/3XvXGTZOlGSwO2OOUPxug3Ho1EipbIKyMbFeADc77TIHdUdmWU49/KAxYYbMnR
	Kwu6fx7ungxkKlTLTZNZKuYxAwnXw4jSbHeEfXwVx+2CPZXoyYK6FGy2nbUL6I/a
	DZvjd0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=S5E4Tr
	aYfzHQ8ztbtkH+ZCtoGU6FHL1OpDIlSgSWMpkG0X9DAPyAnitOtgx93eaqbIAvMm
	N/3mJLliFRB7V7/oZFi7dwv0pTC8+qilhFnlRWFxffPbrCCQbiF8C3k2nlDhu58U
	o/2YRtvHejDtBmfMh5nXtbWpBeMmFg9bIp2kQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68BDC8F1F
	for <git@vger.kernel.org>; Sat, 23 Jun 2012 20:11:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F02978F1E for
 <git@vger.kernel.org>; Sat, 23 Jun 2012 20:11:38 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.29.gf71be5c
In-Reply-To: <1340496691-12258-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2B2A832C-BD91-11E1-9163-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200508>

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
1.7.11.1.29.gf71be5c
