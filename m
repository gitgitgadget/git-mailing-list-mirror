From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/9] git rm ":" is like specifying nothing
Date: Mon,  9 May 2011 22:51:14 -0700
Message-ID: <1305006678-4051-6-git-send-email-gitster@pobox.com>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
 <1305006678-4051-1-git-send-email-gitster@pobox.com>
Cc: pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:51:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJfrN-0001Iw-67
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 07:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548Ab1EJFvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 01:51:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab1EJFvk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 01:51:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 164475C97;
	Tue, 10 May 2011 01:53:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Czlq
	KbiIFVQEx5aT821yZOrpnuM=; b=vWuX5toGw0A8PosLEVqbLgikGqakGS5G5oVV
	A9IEtmXuHU4AGjYM09yqw4zXioTeRgoX+/vAnwxfzhKA4qQ2lZSp3kGu9+gJbt5i
	E04LtAyqiO79/+4Nat6LJONmLDKhG7g98pWuNH3AhzUZjKeXCiP1I8q9Sk5RqZG9
	BmVGVmI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	F7JtZ0gvpF0t8JnutOOpYayIuxNs1sh3awYSVyaXoDLRzcs0wLtxvm2/2O82KikS
	38tJas8kB9GDmiLRw97GnJYIURYz9O5UFrnd5OJQq66YW/oRUffpWEvLxFO2mEsZ
	LZxcDz545TNqALZHe3OsD3uowAQzDnSDrybk1E3Z3iQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 030805C96;
	Tue, 10 May 2011 01:53:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 444135C95; Tue, 10 May 2011
 01:53:41 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.290.g1b565
In-Reply-To: <1305006678-4051-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DD33780A-7AC9-11E0-A73E-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173309>

"git cmd :" should be exactly the same as running "git cmd" from the
root level of the working tree.  Do not decide solely on the value of
argc (i.e. remaining parameters after options and revs are parsed) to
see if the user limited the operation with paths.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index ff491d7..c31f915 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -162,11 +162,13 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		die("index file corrupt");
 
 	pathspec = get_pathspec(prefix, argv);
+	if (!pathspec)
+		die("removing nothing?");
 	refresh_index(&the_index, REFRESH_QUIET, pathspec, NULL, NULL);
 
 	seen = NULL;
 	for (i = 0; pathspec[i] ; i++)
-		/* nothing */;
+		; /* nothing */
 	seen = xcalloc(i, 1);
 
 	for (i = 0; i < active_nr; i++) {
-- 
1.7.5.1.290.g1b565
