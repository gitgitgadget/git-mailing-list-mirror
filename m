From: =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>
Subject: [PATCH] gitweb: Remove "uninitialized value" Perl warning
Date: Tue, 12 Jan 2016 04:31:56 +0100
Message-ID: <1452569516-25657-1-git-send-email-sunny@sunbase.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jnareb@gmail.com, gitster@pobox.com,
	=?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 04:54:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIq2o-0007Xq-PX
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 04:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761230AbcALDyv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jan 2016 22:54:51 -0500
Received: from sunbase.org ([178.79.142.16]:55611 "EHLO linode"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761203AbcALDyu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 22:54:50 -0500
X-Greylist: delayed 1367 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jan 2016 22:54:49 EST
Received: from sunny by linode with local (Exim 4.80)
	(envelope-from <sunny@sunbase.org>)
	id 1aIpgd-0006ia-2a; Tue, 12 Jan 2016 04:31:59 +0100
X-Mailer: git-send-email 2.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283764>

git_object(): Check if $type is defined before chomping it. This remove=
s
a Perl warning in the server error log:

  gitweb.cgi: Use of uninitialized value $type in scalar chomp at
  [...]/gitweb.cgi line 7579., referer: [...]

when trying to access a non-existing commit, for example:

  http://HOST/?p=3DPROJECT.git;a=3Dcommit;h=3DNON_EXISTING_COMMIT

Signed-off-by: =C3=98yvind A. Holm <sunny@sunbase.org>
---
 gitweb/gitweb.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7a5b23a..05d7910 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7576,7 +7576,7 @@ sub git_object {
 			git_cmd(), 'cat-file', '-t', $object_id) . ' 2> /dev/null'
 			or die_error(404, "Object does not exist");
 		$type =3D <$fd>;
-		chomp $type;
+		defined $type && chomp $type;
 		close $fd
 			or die_error(404, "Object does not exist");
=20
--=20
2.7.0
