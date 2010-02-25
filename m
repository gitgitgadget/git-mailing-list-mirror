From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] notes: fix malformed tree entry
Date: Wed, 24 Feb 2010 21:58:12 -0800
Message-ID: <7vocjdkgaz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 06:58:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkWk0-0004OI-FT
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 06:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278Ab0BYF6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 00:58:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568Ab0BYF6X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 00:58:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CE6959A5FC;
	Thu, 25 Feb 2010 00:58:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=dbxp
	Efy2kQmpJBW9Q8+cSHiVKbI=; b=fyKxr8SkGpZHq/gAWooo4p3pD2GdYMDxZa9G
	623L1YBmTsnc1j9eHJpqmXV5UmVt+qClItTKOR1w82p3mhJs5RHLi32CNy89Au7X
	n51WkcC+YlyWSrOs0MouUSgdlXZZJq9tQ0vsNhC31+rNmkuzTvHtGqsg/Sh83kKP
	V2O1ERM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	HZ5eJHYF2rYZX583gvCF4+fB3tmkAZcnecLuD1t+LUNh16KwjzgfWAP1/s7DK+2f
	/1BFZSKfc9ZtdkV31n6OUpZZtBlUONnw4Xkk7bjeVn2oitQ4kwDVbWrNz/RoMs6i
	zTk9TH7lee2aVRzRZW7HkFZKjp4ZASHW4tNPX0rIRF4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A49749A5FB;
	Thu, 25 Feb 2010 00:58:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9FE09A5FA; Thu, 25 Feb
 2010 00:58:14 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C4FFFE62-21D2-11DF-8BD1-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141028>

The mode bits for entries in a tree object should be an octal number
with minimum number of digits.  Do not pad it with 0 to the left.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This comes from 61a7cca (Notes API: write_notes_tree(): Store the notes
   tree in the database, 2010-02-13)

 notes.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/notes.c b/notes.c
index 3ba3e6d..a4f9926 100644
--- a/notes.c
+++ b/notes.c
@@ -624,8 +624,8 @@ static void write_tree_entry(struct strbuf *buf, unsigned int mode,
 		const char *path, unsigned int path_len, const
 		unsigned char *sha1)
 {
-		strbuf_addf(buf, "%06o %.*s%c", mode, path_len, path, '\0');
-		strbuf_add(buf, sha1, 20);
+	strbuf_addf(buf, "%o %.*s%c", mode, path_len, path, '\0');
+	strbuf_add(buf, sha1, 20);
 }
 
 static void tree_write_stack_init_subtree(struct tree_write_stack *tws,
-- 
1.7.0.227.g2f3f2
