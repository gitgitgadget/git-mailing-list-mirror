From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 05/25] sha1_name.c: clarify what "fake" is for in
 find_short_object_filename()
Date: Tue,  3 Jul 2012 14:36:55 -0700
Message-ID: <1341351435-31011-6-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:38:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAna-0005Fb-T4
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756596Ab2GCViH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:38:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34874 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756361Ab2GCVh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:37:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4811B8631
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=3YJN
	mqJTDFYuor+PSTPMhWCrMBk=; b=IliNWU+GIquDe98+S1lqNDK7o1CjWHpNYUUY
	rjPxAdrPLPTt5HpZnrfS/a8yoJ1KY/E5WagRCMClo5x26LYDDVPjSN3H9RLZOB9b
	Bu77XzqzLV6owjMwE8ubbPa13/nJYZI91JXHStve3aYUZwLvUZONJA9wmJ/vBhGf
	1gBbAMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=CVYFHV
	GV8ag3aBlEooqCro3Zs/wC0VsN9D4Y/PKD7cGZHqXz0AdN9lw6IkhFH/6EZiwCQv
	LewlV+2I0OIe35Dn08ouDYCuPJURKWOiSGihlxPCwmfGsN2DhuhVAl3tkuLiADxs
	ZPnHePh+WwMavY2NtayOZD0Nukn4CBEQoaM7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F77E8630
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6B19862D for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:25 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 47FA278C-C557-11E1-BD26-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200949>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sha1_name.c b/sha1_name.c
index e63459b..9bb657d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -17,6 +17,13 @@ static int find_short_object_filename(int len, const char *name, unsigned char *
 	static struct alternate_object_database *fakeent;
 
 	if (!fakeent) {
+		/*
+		 * Create a "fake" alternate object database that
+		 * points to our own object database, to make it
+		 * easier to get a temporary working space in
+		 * alt->name/alt->base while iterating over the
+		 * object databases including our own.
+		 */
 		const char *objdir = get_object_directory();
 		int objdir_len = strlen(objdir);
 		int entlen = objdir_len + 43;
-- 
1.7.11.1.229.g706c98f
