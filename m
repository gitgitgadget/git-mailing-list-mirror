From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] is_submodule_modified(): fix breakage with external
 GIT_INDEX_FILE
Date: Sat, 30 Jan 2010 12:30:31 -0800
Message-ID: <7viqajmj2w.fsf_-_@alter.siamese.dyndns.org>
References: <57518fd11001290712s2585e468o73b746b7ca27e1f1@mail.gmail.com>
 <7vzl3wiz59.fsf@alter.siamese.dyndns.org>
 <57518fd11001291646l5b0b581dm553689232b0910e8@mail.gmail.com>
 <4B642696.2070501@web.de>
 <57518fd11001300523xf7d931by254581c8494171af@mail.gmail.com>
 <4B643DEF.8010809@web.de>
 <57518fd11001300836v7f21a8a9qc09953d9091a4513@mail.gmail.com>
 <7v8wbfnyz9.fsf@alter.siamese.dyndns.org>
 <7vvdejmjaj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 21:30:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbJxu-00062Q-Tf
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 21:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104Ab0A3Ual (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 15:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648Ab0A3Ual
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 15:30:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46598 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907Ab0A3Uak (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 15:30:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F195C95723;
	Sat, 30 Jan 2010 15:30:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QoMVR0yDKdI16C51YJPeoCHe5E4=; b=n4NBfq
	9qS2S9oP9fg7CkcsweNNbSLIFhOKCgZ/bX1dW4GeT+ZTjwKfqKX9304UaIBXKyZ7
	Lf9Aoj4TvG4f9ZkoSeDoVfT3KQTGMhIzPcRsViX3ueFJHd2O/s5wd/eorGbvw8a3
	+iZoYOkFYjBZR3vj9p9/62tTqUJA/Kg6PnuXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RYg8GoMxY5QS5BHItfD7rjqBDbPNRLnr
	7fqwPf3f5qf7Xm4FC0dPP/8hJXv+M5d8UC/QTw1muVtYuJ3vV3jFAYgEb+enprbc
	yibptT7Ywok2KolRdqlHrisqKFsLyKL62/ZhczQ/jRjdaO0f0/i+6917aqEwpSb1
	4NHNzJfoxM0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BDFB395722;
	Sat, 30 Jan 2010 15:30:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0EAA95720; Sat, 30 Jan
 2010 15:30:32 -0500 (EST)
In-Reply-To: <7vvdejmjaj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 30 Jan 2010 12\:25\:56 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 52CCB27A-0DDE-11DF-A3D3-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138500>

Even when the environment was given for the top-level process, checking
in the submodule work tree should use the index file associated with the
work tree of the submodule.  Do not export it to the environment.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This seems to pass all the tests, so I'm inclined to push it out as
   a part of 1.7.0-rc1.  There might be some other enviroment variables
   we shouldn't be leaking out to the submodule environment, but that can
   be spotted and fixed in later patches before the final.

 submodule.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index ca0527f..6f7c210 100644
--- a/submodule.c
+++ b/submodule.c
@@ -126,7 +126,7 @@ int is_submodule_modified(const char *path)
 		"--porcelain",
 		NULL,
 	};
-	char *env[3];
+	char *env[4];
 	struct strbuf buf = STRBUF_INIT;
 
 	strbuf_addf(&buf, "%s/.git/", path);
@@ -142,7 +142,9 @@ int is_submodule_modified(const char *path)
 	env[0] = strbuf_detach(&buf, NULL);
 	strbuf_addf(&buf, "GIT_DIR=%s/.git", path);
 	env[1] = strbuf_detach(&buf, NULL);
-	env[2] = NULL;
+	strbuf_addf(&buf, "GIT_INDEX_FILE");
+	env[2] = strbuf_detach(&buf, NULL);
+	env[3] = NULL;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.argv = argv;
@@ -161,6 +163,7 @@ int is_submodule_modified(const char *path)
 
 	free(env[0]);
 	free(env[1]);
+	free(env[2]);
 	strbuf_release(&buf);
 	return len != 0;
 }
-- 
1.7.0.rc1.141.gbc8ce
