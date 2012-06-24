From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/9] sha1_name.c: clarify what "fake" is for in
 find_short_object_filename()
Date: Sat, 23 Jun 2012 17:11:24 -0700
Message-ID: <1340496691-12258-3-git-send-email-gitster@pobox.com>
References: <1340496691-12258-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 02:12:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiaRe-0001nK-UO
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 02:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756683Ab2FXAMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jun 2012 20:12:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43737 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756269Ab2FXALi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 20:11:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B37BD8F1D
	for <git@vger.kernel.org>; Sat, 23 Jun 2012 20:11:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zy84
	cPQyclJoosGaTKy/kQIgYkw=; b=jXj5snW5UEVq6pq0yIlj4EuOy7IlrioVuKZt
	eKEMzZyGAcb+UIEHzdaf5gZk4anpxd6ubXMPz7ZiUDle3g0Uo29L58kJQMjSZEux
	0ulH8U1qj10QzwTukJI28FBLLGr68ASOaUtIGt7qMKatI1OMNXvWKmlwBA5la9hy
	igx6omM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ZD61Z5
	Fv679x91NXhY+atoV9JCCurhPWrBfCZ0QgmmIsvTrUqhFyN/wRFp4f6HZK+UfC5J
	iqqPoVhZndJZVaMNRKxI4/E+lhHKgxys4KPwSklXoo1WcPAC+fyqRsTnlJbZmK4M
	ucLTdgwsVphX5ho/iIRqjL6+3TghNVqXKMaRw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB3A98F1C
	for <git@vger.kernel.org>; Sat, 23 Jun 2012 20:11:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B7298F1B for
 <git@vger.kernel.org>; Sat, 23 Jun 2012 20:11:37 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.29.gf71be5c
In-Reply-To: <1340496691-12258-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2A2117E8-BD91-11E1-B1CA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200515>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sha1_name.c b/sha1_name.c
index 5b0c845..4cbca34 100644
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
1.7.11.1.29.gf71be5c
