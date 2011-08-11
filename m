From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/11] object: next_size() helper for readability
Date: Thu, 11 Aug 2011 10:53:09 -0700
Message-ID: <1313085196-13249-5-git-send-email-gitster@pobox.com>
References: <1313085196-13249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 19:53:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrZRn-0008JJ-Ip
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 19:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934Ab1HKRxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 13:53:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44584 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752906Ab1HKRx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 13:53:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E922C418B
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=vUKx
	kRY1kfCSjwM3SeP6eihsf+A=; b=xRMRgT4qBquFBJPRdAplw0MmebnmAWOxAf2s
	4ZDvaAKHOtcFp/OYN9LetP4fLR049uXRsMdMjsNLSFpPZESY+3iU/CaUcoEvC62U
	mLbfbBCAWXn0z9NCLyk3WlNxoX4TevPORfvGVvNGI/OFwJIaorUL46jnJ2T/KTZQ
	0AHAeQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=veG6kO
	TBt+Zt6dJfYcqzfBz7QaF1Bt7CGY9g1DF3j8ZgqYKPXQmN/EMXKXZdcAdAkyZyX8
	yBhPguvScBFhKvxgkv2/mWo9jt4REEcFNvdd3MP1Nm8XHvJPlvmX+DES1RgnvDBn
	SfXtrAVMqLGX/i93PCqKAViSo12joNXk1QrIw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2104418A
	for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76C744188 for
 <git@vger.kernel.org>; Thu, 11 Aug 2011 13:53:28 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.433.g1421f
In-Reply-To: <1313085196-13249-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D1A08736-C442-11E0-B5EF-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179118>

Move the heuristics to grow the table size into a separate
helper function to make the caller more readable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/object.c b/object.c
index 4ff2d7d..259a67e 100644
--- a/object.c
+++ b/object.c
@@ -81,10 +81,15 @@ struct object *lookup_object(const unsigned char *sha1)
 	return obj;
 }
 
+static int next_size(int sz)
+{
+	return sz < 32 ? 32 : 2 * sz;
+}
+
 static void grow_object_hash(void)
 {
 	int i;
-	int new_hash_size = obj_hash_size < 32 ? 32 : 2 * obj_hash_size;
+	int new_hash_size = next_size(obj_hash_size);
 	struct object **new_hash;
 
 	new_hash = xcalloc(new_hash_size, sizeof(struct object *));
-- 
1.7.6.433.g1421f
