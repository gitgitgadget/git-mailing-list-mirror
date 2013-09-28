From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] clone: local URLs are not for ssh
Date: Sat, 28 Sep 2013 21:37:21 +0200
Message-ID: <201309282137.21802.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 21:37:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ0Km-0001ut-1f
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 21:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838Ab3I1Thk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Sep 2013 15:37:40 -0400
Received: from mout.web.de ([212.227.15.4]:62933 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752655Ab3I1Thj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Sep 2013 15:37:39 -0400
Received: from appes.localnet ([217.208.218.204]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0LjJK3-1VzdCY3wFT-00dTfC for <git@vger.kernel.org>;
 Sat, 28 Sep 2013 21:37:38 +0200
X-Provags-ID: V03:K0:XJzPvQhodt+YaM5F+nTEyXZcue2lbOxIoaR4tDgKNBPM9nORieV
 2LqhO2bH/tRbeJ5wsDDhajRWBPWzvZto7kMHjws0EhCJAiyJLlm7c2qil6N3X0zG199uHdE
 nYpAAjhB4jZp+0xk3pChC1KNiT0HKbvmcvRDgS6kNkJjX97I0QFo0ih7ldvURTHM7ouXUZK
 Co4ibYFrWEbJpfZZAv2/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235505>

"git clone /foo/bar:baz" or "git clone ../foo/bar:baz"
are meant to clone from the local file system, and not to clone
from a remote server over git-over-ssh.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 connect.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index a80ebd3..b382032 100644
--- a/connect.c
+++ b/connect.c
@@ -550,7 +550,8 @@ struct child_process *git_connect(int fd[2], const =
char *url_orig,
 		end =3D host;
=20
 	path =3D strchr(end, c);
-	if (path && !has_dos_drive_prefix(end)) {
+	if (path && !has_dos_drive_prefix(end) &&
+	    url[0] !=3D '/' && url[0] !=3D '.' ) {
 		if (c =3D=3D ':') {
 			if (path < strchrnul(host, '/')) {
 				protocol =3D PROTO_SSH;
--=20
1.8.4.457.g424cb08
