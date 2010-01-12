From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 16/18] blob.c: remove unused function
Date: Mon, 11 Jan 2010 23:52:59 -0800
Message-ID: <1263282781-25596-17-git-send-email-gitster@pobox.com>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:54:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbaY-00056x-Jd
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab0ALHxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753495Ab0ALHxu
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485Ab0ALHxm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 498518E8B1;
	Tue, 12 Jan 2010 02:53:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=UMeg
	I8DONJ6+KXlkArKnxXd2Des=; b=JINZ3T9AcbrOzdQFlKAFKmcgQFVHMsn0dLvx
	xy2WXhQ4y1SNzPZxj3seixFEAuCzqxDMKUoVi0P8avRlubcXe7UHOphjitzX+LOm
	2auVZ0HxGSeoLz1vPFdX+c45UoKujCqw2AjJPW6mhaLAD9Tp5wwsitRD7SpC8i5H
	7xXsNyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ZrItaJxVFVevkUkw6yxHjncXw1X99fV8NS7lPkqAMURiTQFP/AK42W/27Djdax5E
	FHF5OtfJvzXv+jhMy26vzlCb8RPS32hTjh8bOy90L5KohslwUSwXoa4gDsz2z9vI
	msubDWM5YFW+298rvlt4zV4jH4cBklrTh1QVARrrqTw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 32C3F8E8B0;
	Tue, 12 Jan 2010 02:53:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 925EB8E8AE; Tue, 12 Jan
 2010 02:53:39 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
In-Reply-To: <1263282781-25596-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 999380E6-FF4F-11DE-93EE-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136700>

parse_blob() is not used anywhere since a510bfa (Mark blobs as parsed when
they're actually parsed, 2005-04-28).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 blob.c |   21 ---------------------
 blob.h |    2 --
 2 files changed, 0 insertions(+), 23 deletions(-)

diff --git a/blob.c b/blob.c
index bd7d078..ae320bd 100644
--- a/blob.c
+++ b/blob.c
@@ -23,24 +23,3 @@ int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
 	item->object.parsed = 1;
 	return 0;
 }
-
-int parse_blob(struct blob *item)
-{
-        enum object_type type;
-        void *buffer;
-        unsigned long size;
-	int ret;
-
-        if (item->object.parsed)
-                return 0;
-        buffer = read_sha1_file(item->object.sha1, &type, &size);
-        if (!buffer)
-                return error("Could not read %s",
-                             sha1_to_hex(item->object.sha1));
-        if (type != OBJ_BLOB)
-                return error("Object %s not a blob",
-                             sha1_to_hex(item->object.sha1));
-	ret = parse_blob_buffer(item, buffer, size);
-	free(buffer);
-	return ret;
-}
diff --git a/blob.h b/blob.h
index ea5d9e9..1f66b9d 100644
--- a/blob.h
+++ b/blob.h
@@ -13,6 +13,4 @@ struct blob *lookup_blob(const unsigned char *sha1);
 
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
 
-int parse_blob(struct blob *item);
-
 #endif /* BLOB_H */
-- 
1.6.6.280.ge295b7.dirty
