From: =?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
Subject: [PATCH 3/3] git-rebase--interactive.sh: Make 3-way merge strategies work for -p.
Date: Wed, 31 Oct 2007 03:20:32 +0100
Message-ID: <1193797232-1062-3-git-send-email-B.Steinbrink@gmx.de>
References: <1193797232-1062-1-git-send-email-B.Steinbrink@gmx.de>
 <1193797232-1062-2-git-send-email-B.Steinbrink@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Wed Oct 31 03:21:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In3CT-0008Nq-GI
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 03:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbXJaCUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 22:20:40 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510AbXJaCUj
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 22:20:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:34259 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752336AbXJaCUh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 22:20:37 -0400
Received: (qmail invoked by alias); 31 Oct 2007 02:20:35 -0000
Received: from i577B89A4.versanet.de (EHLO localhost) [87.123.137.164]
  by mail.gmx.net (mp052) with SMTP; 31 Oct 2007 03:20:35 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+dgWpCLoudScY7JQwXwz0NYgr9p8AA5RyiACrl++
	VmBGvUdGSg8tOQ
X-Mailer: git-send-email 1.5.3.4.456.g072a
In-Reply-To: <1193797232-1062-2-git-send-email-B.Steinbrink@gmx.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62781>

git-rebase--interactive.sh used to pass all parents of a merge commit t=
o
git-merge, which means that we have at least 3 heads to merge: HEAD,
first parent and second parent. So 3-way merge strategies like recursiv=
e
wouldn't work.

=46ortunately, we have checked out the first parent right before the me=
rge
anyway, so that is HEAD. Therefore we can drop simply it from the list
of parents, making 3-way strategies work for merge commits with only
two parents.

Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index cc949db..e63e1c9 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -172,6 +172,9 @@ pick_one_preserving_merges () {
 			author_script=3D$(get_author_ident_from_commit $sha1)
 			eval "$author_script"
 			msg=3D"$(git cat-file commit $sha1 | sed -e '1,/^$/d')"
+
+			# No point in merging the first parent, that's HEAD
+			new_parents=3D${new_parents# $first_parent}
 			# NEEDSWORK: give rerere a chance
 			if ! GIT_AUTHOR_NAME=3D"$GIT_AUTHOR_NAME" \
 				GIT_AUTHOR_EMAIL=3D"$GIT_AUTHOR_EMAIL" \
--=20
1.5.3.4.456.g072a
