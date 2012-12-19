From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t0200: "locale" may not exist
Date: Tue, 18 Dec 2012 22:47:03 -0800
Message-ID: <7vlicubkt4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 07:47:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlDR8-0002sw-EO
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 07:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796Ab2LSGrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 01:47:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64914 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727Ab2LSGrH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 01:47:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20E33874C;
	Wed, 19 Dec 2012 01:47:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=O
	V3TZdOFp7RWGkVvLsQxbtTOhVg=; b=aRehf9pUxyO2mo/fah+0mJQbk8lbzMuXD
	+R1GzOMVOKEdASGQ3xmO77/Hr0Dsay3UMhM5qrPYO8lLOIPYLEsoxo/2+9Ot5ijn
	xAIVvc/amZIE+gf6zuY342UsjTVKOEX50/TPdYUCwMKrMB7cPodMrisHZgKqgiZc
	0EgeZ1XNEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Yn9
	/zbApT5e68Bu0L8U/S8uiqCaJvtkhqLpx/Gr6Cc3e3jxqJZ+FHyNl2BARXTOG1Qj
	qhSVe8Drcjqyt/ByLpZhrbWgq4bZTp+JkyLl7vV6ZnQu7Ho81WSBaIHP9cKGqoPg
	GNzXPlJv1qsEZbEzR3i7gRHhP28wgDCI/1MXDjUA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F952874B;
	Wed, 19 Dec 2012 01:47:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D19F8748; Wed, 19 Dec 2012
 01:47:05 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6C4751E-49A7-11E2-AE5E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211810>

On systems without "locale" installed, t0200-gettext-basic.sh leaked
error messages when checking if some test locales are available.
Hide them, as they are not very useful.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-gettext.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/lib-gettext.sh b/t/lib-gettext.sh
index 0f76f6c..ae8883a 100644
--- a/t/lib-gettext.sh
+++ b/t/lib-gettext.sh
@@ -14,12 +14,14 @@ export GIT_TEXTDOMAINDIR GIT_PO_PATH
 if test_have_prereq GETTEXT && ! test_have_prereq GETTEXT_POISON
 then
 	# is_IS.UTF-8 on Solaris and FreeBSD, is_IS.utf8 on Debian
-	is_IS_locale=$(locale -a | sed -n '/^is_IS\.[uU][tT][fF]-*8$/{
+	is_IS_locale=$(locale -a 2>/dev/null |
+		sed -n '/^is_IS\.[uU][tT][fF]-*8$/{
 		p
 		q
 	}')
 	# is_IS.ISO8859-1 on Solaris and FreeBSD, is_IS.iso88591 on Debian
-	is_IS_iso_locale=$(locale -a | sed -n '/^is_IS\.[iI][sS][oO]8859-*1$/{
+	is_IS_iso_locale=$(locale -a 2>/dev/null |
+		sed -n '/^is_IS\.[iI][sS][oO]8859-*1$/{
 		p
 		q
 	}')
-- 
1.8.1.rc2.196.g654d69e
