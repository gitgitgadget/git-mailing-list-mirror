From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 06/25] sha1_name.c: rename "now" to "current"
Date: Tue,  3 Jul 2012 14:36:56 -0700
Message-ID: <1341351435-31011-7-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:38:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAnb-0005Fb-D4
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601Ab2GCViI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:38:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34903 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756394Ab2GCVh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:37:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15A868644
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=r0yQ
	l9tn8mYVtcmhdrSenEWcp5Y=; b=Q7smMdp77wu3VDlxvjmmMQSxezuRBnTNcU9G
	U5ndu2DcQrLkBFazD3G7q2Dc7tqDJ9HkKK3Gs4CQd0zybb/hqI9PzABpluMn2XUu
	FuLTmMdO0t/tB6cxhbgucXPXVM17bW711bYTpwthXmxJFMGecT+Q8bOxvj1Rut7m
	vE65fBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Mar74A
	JWVuNCM+5aB0CUHXpEv9koZTgurntC7mVuKUzeqKFv70v0wu3TJCpcFeVBeXFduf
	PS8vp3POs4tvcPcW9rXDL+gRt14lkw3UnjLL+YVeSgw9ArlXi3Lky9dGT7mwWj4J
	F0v3JEUKjFdGQCmyemjT3Mz5jtIEmwjc/L0dQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CDEC8636
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D2098635 for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:27 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 49075EA6-C557-11E1-9477-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200952>

This variable points at the element we are currently looking at, and
does not have anything to do with the current time which the name
"now" implies.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 9bb657d..c5c4591 100644
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
1.7.11.1.229.g706c98f
