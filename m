From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin/config.c: compilation fix
Date: Thu, 08 Aug 2013 21:41:44 -0700
Message-ID: <7vli4b79x3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 06:41:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7eWP-0003LV-Jw
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 06:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184Ab3HIElt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 00:41:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54169 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932114Ab3HIEls (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 00:41:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 020E131938;
	Fri,  9 Aug 2013 04:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=9
	hN3PAAOSWYW/7m6sc1bGLJP4W8=; b=LeApihMG2Y5LcA1LDLG31Ouhr9J6JGG9v
	jc5BUeBTaj+itlFLTUc6kU1x3UdLSGYuTslnpbLyJGPtXt5Lo6R8cWALREG0Y0wr
	HRrOAtdi8cZVYtULR9dcbOhCtS8W7H1ZUDNKSIoSdKDjC41mi5ksdKINtsLfvGyS
	hk31a+xLNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=BIKWEYzhBruKLxZOTtQXwY8+Mrj+CQz1r7O2LZgiX7ElnQ4jZSo5maVX
	iIuslJOUwdBkHjLNCpzOlI2+PG1kV+6moQI1dzPM3J7UMeP5UzQhp10bOzRkg5mj
	vxt6zM2xGzZYwOfOoDWmtq0s7DaGjtISP+6Ox1TvLxFwMENb1/Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9B3E31935;
	Fri,  9 Aug 2013 04:41:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8324331933;
	Fri,  9 Aug 2013 04:41:46 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF909600-00AD-11E3-A541-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231954>

Do not feed a random string as the first parameter to die(); use "%s"
as the format string instead.

Do the same for test-urlmatch-normalization.c while saving a single
pointer variable by turning a "const char *" constant string into
"const char []".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/config.c              | 2 +-
 test-urlmatch-normalization.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index c046f54..ae199e9 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -404,7 +404,7 @@ static int get_urlmatch(const char *var, const char *url)
 	config.cb = &values;
 
 	if (!url_normalize(url, &config.url))
-		die(config.url.err);
+		die("%s", config.url.err);
 
 	config.section = dup_downcase(var);
 	section_tail = strchr(config.section, '.');
diff --git a/test-urlmatch-normalization.c b/test-urlmatch-normalization.c
index 2603899..78c8b3a 100644
--- a/test-urlmatch-normalization.c
+++ b/test-urlmatch-normalization.c
@@ -3,7 +3,7 @@
 
 int main(int argc, char **argv)
 {
-	const char *usage = "test-urlmatch-normalization [-p | -l] <url1> | <url1> <url2>";
+	const char usage[] = "test-urlmatch-normalization [-p | -l] <url1> | <url1> <url2>";
 	char *url1, *url2;
 	int opt_p = 0, opt_l = 0;
 
-- 
1.8.3.3-1049-g890a991
