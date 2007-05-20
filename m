From: "Fernando J. Pereda" <ferdy@gentoo.org>
Subject: [PATCH] Use PATH_MAX instead of TEMPFILE_PATH_LEN
Date: Sun, 20 May 2007 15:35:46 +0200
Message-ID: <20070520133546.GA11935@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 15:36:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HplaP-0007ot-VL
	for gcvg-git@gmane.org; Sun, 20 May 2007 15:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984AbXETNgJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 20 May 2007 09:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756166AbXETNgJ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 09:36:09 -0400
Received: from hu-out-0506.google.com ([72.14.214.224]:8217 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984AbXETNgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 09:36:07 -0400
Received: by hu-out-0506.google.com with SMTP id 22so26201hug
        for <git@vger.kernel.org>; Sun, 20 May 2007 06:36:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent:sender;
        b=EHXMaNR+W78EpuMOZxjRg9KBt1BzOp9dAtLR7fKHxUmtsxG1w/FXjldfKQnMQawI+Va98Ylz2lbVkHggcypt2MoXmnBr6UXsmfT6ApxwmP7BtYlEJ8MZMP78ZgQFKdqLJ84MjzsOb+K4bKGYkhL/CguIbhWjbO9OoGKyzI5caM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent:sender;
        b=IqFrkpiDkw8qPJjmBg4lSQeKyoCyO2FNWQTTFG7y8xAgsHHJjXufty6KKnO6kp/zykjmkj48cCowVcPBflb4KAY1FftfcJTEeSFouT+UTJM+vfMSbtg2A1Eji4qT2rhiaLOzqxq/jtshPLz0QAMXv6Y5WKlGcimcTViD9EabsVw=
Received: by 10.66.254.2 with SMTP id b2mr2657776ugi.1179668159544;
        Sun, 20 May 2007 06:35:59 -0700 (PDT)
Received: from posidon.ferdyx.org ( [213.96.222.170])
        by mx.google.com with ESMTP id 27sm5790754ugp.2007.05.20.06.35.54;
        Sun, 20 May 2007 06:35:58 -0700 (PDT)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	ferdy@ferdyx.org; Sun, 20 May 2007 15:35:56 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@gentoo.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47835>

Signed-off-by: Fernando J. Pereda <ferdy@gentoo.org>
---

	In Gentoo, packages compile with:
	TMPDIR=3D/var/tmp/portage/dev-util/git-1.5.2/temp
	so git_mkstemp couldn't fit the .diff_XXXXXX part and mkstemp was
	returning EINVAL.

 diff.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 33297aa..b23e190 100644
--- a/diff.c
+++ b/diff.c
@@ -186,13 +186,11 @@ static const char *external_diff(void)
 	return external_diff_cmd;
 }
=20
-#define TEMPFILE_PATH_LEN		50
-
 static struct diff_tempfile {
 	const char *name; /* filename external diff should read from */
 	char hex[41];
 	char mode[10];
-	char tmp_path[TEMPFILE_PATH_LEN];
+	char tmp_path[PATH_MAX];
 } diff_temp[2];
=20
 static int count_lines(const char *data, int size)
@@ -1561,7 +1559,7 @@ static void prep_temp_blob(struct diff_tempfile *=
temp,
 {
 	int fd;
=20
-	fd =3D git_mkstemp(temp->tmp_path, TEMPFILE_PATH_LEN, ".diff_XXXXXX")=
;
+	fd =3D git_mkstemp(temp->tmp_path, PATH_MAX, ".diff_XXXXXX");
 	if (fd < 0)
 		die("unable to create temp-file");
 	if (write_in_full(fd, blob, size) !=3D size)
--=20
1.5.2


--=20
=46ernando J. Pereda Garcimart=EDn
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4
