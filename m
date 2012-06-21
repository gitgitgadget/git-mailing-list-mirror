From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/9] sha1_name.c: rename "now" to "current"
Date: Wed, 20 Jun 2012 23:35:26 -0700
Message-ID: <1340260532-11378-4-git-send-email-gitster@pobox.com>
References: <1340260532-11378-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 08:36:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shazl-0006l5-3Q
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 08:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604Ab2FUGfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 02:35:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755016Ab2FUGfj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 02:35:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6501E8B1D
	for <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=iWfo
	uXNhU7OIcDqpJpukkJhZK6I=; b=mUPB1GWsK+RA8a7ZDEkShx0m1sNM6/b/EsmZ
	r7hQmOtTC4PuWQWnhuBqpZQWn2BQtSGa4dlMOjgAos1GJlWgAwzeUGIjbBhweqHQ
	Xe+pMJw8hcHK1dD832RC0K/pX+g3460vQ7AzRdTNh8hPP15ToOM3hXBvToq9k12Y
	sPJidw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=wsGA+3
	ZoOG/0928Zru0ghyur1K6x49r5/qdpDZpa8+FNHTWkeAr3b6ztKTe6hkx1xELnpn
	Dew1u02XsxacNCs7mPZDslweBrhsEGTEDAQx2mRV+sOPRYOBKZ/RMdmmSANk6Tm8
	wdd3DnycJ9Iy56wbtmkb8v0LEwp5xPv4UnSY4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C9C58B1C
	for <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2B758B1B for
 <git@vger.kernel.org>; Thu, 21 Jun 2012 02:35:38 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.2.gd284367
In-Reply-To: <1340260532-11378-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 50CDA9EC-BB6B-11E1-A457-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200393>

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
1.7.11.2.gd284367
