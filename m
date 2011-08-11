From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/11] object hash: we know the table size is a power of two
Date: Thu, 11 Aug 2011 10:53:10 -0700
Message-ID: <1313085196-13249-6-git-send-email-gitster@pobox.com>
References: <1313085196-13249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 19:54:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrZST-0000IQ-HY
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 19:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab1HKRxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 13:53:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44598 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903Ab1HKRxb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 13:53:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDC08418F
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=34Mt
	VHjrfYx7mQB/rn7lNi3iiow=; b=DJky9aF4zFKR8h1rJny7e7rEQteE40Q8yl3T
	HvWbrA52hoI1If5br3ZrK6PInyQkYySebCfa4iZWUdfgj91QQvoXpX/lQ8fIuQje
	fIPuqJTTD76XNYzaTrse0hfPZ+Q1oSMN2qkbAAgfgRLTXUePNtSkYQ+RvqPSg6op
	XKAQFxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=NlTwp2
	JEFBciEeGTM/1sacPWD+lLyKAa7jZcpDlbgaBj0ZoDqF4XiD2mnUismmL5ZBdwgg
	qyzVl9x11kz5yPCmk+Pg9JrpJpQqskcevCMn9d+/T5JV3I1LgAWZUOGrbQKY6g3C
	3t39NkupLqCGXJgwSi+G4/hqqfAPHOjn3lWtw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6586418E
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 430DA418D for
 <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:30 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.433.g1421f
In-Reply-To: <1313085196-13249-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D2B14494-C442-11E0-97F3-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179123>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/object.c b/object.c
index 259a67e..d95d7a6 100644
--- a/object.c
+++ b/object.c
@@ -52,7 +52,7 @@ static unsigned int hash_val(const unsigned char *sha1)
 
 static void insert_obj_hash(struct object *obj, struct object **hash, unsigned int size)
 {
-	unsigned int j = hash_val(obj->sha1) % size;
+	unsigned int j = hash_val(obj->sha1) & (size-1);
 
 	while (hash[j]) {
 		j++;
@@ -70,7 +70,7 @@ struct object *lookup_object(const unsigned char *sha1)
 	if (!obj_hash)
 		return NULL;
 
-	i = hash_val(sha1) % obj_hash_size;
+	i = hash_val(sha1) & (obj_hash_size-1);
 	while ((obj = obj_hash[i]) != NULL) {
 		if (!hashcmp(sha1, obj->sha1))
 			break;
-- 
1.7.6.433.g1421f
