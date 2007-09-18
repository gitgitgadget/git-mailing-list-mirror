From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] contrib/fast-import: add simple shell example
Date: Tue, 18 Sep 2007 03:26:01 -0400
Message-ID: <20070918072601.GA3506@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 09:26:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXXTI-0000jp-2C
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 09:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbXIRH0G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Sep 2007 03:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754051AbXIRH0F
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 03:26:05 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2859 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753937AbXIRH0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 03:26:04 -0400
Received: (qmail 25450 invoked by uid 111); 18 Sep 2007 07:26:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 18 Sep 2007 03:26:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2007 03:26:01 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58533>

=46rom: Nguyen Thai Ngoc Duy <pclouds@gmail.com>

This example just puts a directory under git control. It is
significantly slower than using the git tools directly, but
hopefully shows a bit how fast-import works.

  [jk: added header comments]

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/fast-import/git-import.sh |   38 +++++++++++++++++++++++++++++=
++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100755 contrib/fast-import/git-import.sh

diff --git a/contrib/fast-import/git-import.sh b/contrib/fast-import/gi=
t-import.sh
new file mode 100755
index 0000000..0ca7718
--- /dev/null
+++ b/contrib/fast-import/git-import.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+#
+# Performs an initial import of a directory. This is the equivalent
+# of doing 'git init; git add .; git commit'. It's a lot slower,
+# but is meant to be a simple fast-import example.
+
+if [ -z "$1" -o -z "$2" ]; then
+	echo "Usage: git-import branch import-message"
+	exit 1
+fi
+
+USERNAME=3D"$(git config user.name)"
+EMAIL=3D"$(git config user.email)"
+
+if [ -z "$USERNAME" -o -z "$EMAIL" ]; then
+	echo "You need to set user name and email"
+	exit 1
+fi
+
+git init
+
+(
+	cat <<EOF
+commit refs/heads/$1
+committer $USERNAME <$EMAIL> now
+data <<MSGEOF
+$2
+MSGEOF
+
+EOF
+	find * -type f|while read i;do
+		echo "M 100644 inline $i"
+		echo data $(stat -c '%s' "$i")
+		cat "$i"
+		echo
+	done
+	echo
+) | git fast-import --date-format=3Dnow
--=20
1.5.3.1.967.g6bb01
