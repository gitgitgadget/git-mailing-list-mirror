From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 06/18] sha1_name.c: rename "now" to "current"
Date: Mon,  2 Jul 2012 15:33:57 -0700
Message-ID: <1341268449-27801-7-git-send-email-gitster@pobox.com>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 00:35:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlpD1-0003YV-7t
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 00:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933111Ab2GBWew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 18:34:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39755 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756291Ab2GBWeY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 18:34:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 189819079
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Dxyn
	XC+zg2hUUto2l/Ogaha9g10=; b=OhCuU6XFgTxMw0l7dWBc9Sgd1NmC3BPYDpwH
	YvsBGbPICC4Vn58un4N8oEonZaXNLL5W2xc/8VvKHsj+/t07+dziZuW4yottBDqv
	9tMY0xI6FwdBokiFUQmyF54Xlw0B7L1npjMvsn357qtLFmWlwl7aoKrl2w4ap2Uh
	jPImcHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ObRo7k
	5hsmRgpUCla05wNkTYGQgBp0gkNHvwIgRaWdN5I3CZk0aft8nHFrDW+WgAwpZeBG
	4D7OGNXWffi8KWUxNfb0QoFwZpz/DK5I/N8M365CrbYz/Q7SSI2CS2aUgb0SU8qs
	Av4O40rXt0yaUujyxzf1uMDnQeNNnKxSogG+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F41C9078
	for <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C5639077 for
 <git@vger.kernel.org>; Mon,  2 Jul 2012 18:34:23 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.212.g52fe12e
In-Reply-To: <1341268449-27801-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 12B583DA-C496-11E1-8CD9-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200874>

This variable points at the element we are currently looking at, and
does not have anything to do with the current time which the name
"now" implies.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 6eb3280..49d2403 100644
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
1.7.11.1.212.g52fe12e
