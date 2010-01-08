From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 3/3] ident.c: treat $EMAIL as giving user.email identity
 explicitly
Date: Fri, 08 Jan 2010 08:08:50 -0800
Message-ID: <7v637cefzh.fsf_-_@alter.siamese.dyndns.org>
References: <xuu2fx6m4vdi.fsf@nowhere.com>
 <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com>
 <xuu2zl4tfuij.fsf@nowhere.com> <20100106073806.6117@nanako3.lavabit.com>
 <7v4omz17xz.fsf@alter.siamese.dyndns.org> <xuu28wc9xd42.fsf@nowhere.com>
 <7vskagh9fg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Megacz <adam@megacz.com>
To: git@vger.kernel.org, Matt Kraai <kraai@ftbfs.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:09:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTHOg-0004Z6-Fm
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 17:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533Ab0AHQJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 11:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450Ab0AHQJG
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 11:09:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab0AHQJE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 11:09:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 024E68F0E2;
	Fri,  8 Jan 2010 11:09:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8ANTXYlpJYH8xamFy5N74tRunvg=; b=Ng7yX5
	Ra1KJwuXfFV9A6g7dQNo5I+k3XMZlbZTf2OXuhEGvfL1B4F2UQTkN5lT+rTHIkFa
	5fEd9qyD44rcg5ed2AnpXdHsTIhTuqnZyyt8/Kd01GCEmLYK0hlZkyf71eA+nkBV
	QiqzUl25685OIwIXqFRpfhywPQSxsw6DzuKUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q2Q6Rn+mj1JjShRx36CNCvJT70ZQ6txu
	tmAZtUpUcsXz8KqGyXgnBC8NpOLTrj7ptlKTt4LgqelUkmX2nKf1Lcc5XH4dpHVv
	rVjexiQy71H3gy55VLds4xF+QNFcgDnbTaVaFOZeNRz/iL6Hz4e9JCl/jO5tYzm+
	JaRM62llmmc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A77F8F0DD;
	Fri,  8 Jan 2010 11:08:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 858248F0D3; Fri,  8 Jan
 2010 11:08:51 -0500 (EST)
In-Reply-To: <7vskagh9fg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 08 Jan 2010 08\:02\:11 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 204A49EA-FC70-11DE-B27E-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136451>

The environment variable EMAIL has been honored since 28a94f8 (Fall back
to $EMAIL for missing GIT_AUTHOR_EMAIL and GIT_COMMITTER_EMAIL,
2007-04-28) as the end-user's wish to use the address as the identity.
When we use it, we should say we are explicitly given email by the user.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is an RFC as some people would feel strongly about _not_ using
   $EMAIL as their commit identity and would rather override it explicitly
   with user.email; if they weren't told about git using their $EMAIL,
   they will complain.

 ident.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/ident.c b/ident.c
index e67c5ad..d4f6145 100644
--- a/ident.c
+++ b/ident.c
@@ -85,10 +85,11 @@ static void setup_ident(void)
 	if (!git_default_email[0]) {
 		const char *email = getenv("EMAIL");
 
-		if (email && email[0])
+		if (email && email[0]) {
 			strlcpy(git_default_email, email,
 				sizeof(git_default_email));
-		else {
+			user_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+		} else {
 			if (!pw)
 				pw = getpwuid(getuid());
 			if (!pw)
-- 
1.6.6.209.g52296.dirty
