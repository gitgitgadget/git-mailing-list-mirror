From: =?utf-8?q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [COGITO PATCH] fetch_local -d behaves different from other fetch_*
Date: Wed, 01 Jun 2005 12:55:28 +0200
Message-ID: <87psv6ibxb.fsf@ifae.es>
References: <87is0zginw.fsf@ifae.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Jun 01 12:53:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdQqK-0005n2-Q9
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 12:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVFAKzk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 1 Jun 2005 06:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVFAKzj
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 06:55:39 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:43652 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S261216AbVFAKz1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 06:55:27 -0400
Received: from bela (ifae-s1.ifae.es [192.101.162.148])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id j51AtPZ02123
	for <git@vger.kernel.org>; Wed, 1 Jun 2005 12:55:26 +0200
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <87is0zginw.fsf@ifae.es> (
 =?utf-8?q?Santi_B=C3=A9jar's_message_of?= "Wed, 01 Jun 2005 00:00:35
 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


"fetch_local -d src dst" does not respect the dst directory name=20
if both have different names. So

fetch_local -d /path/to/some/src /path/to/dst

copies to /path/to/src.

In fact this way it's never used in the current cogito so it's not
really affected but it's needed in the case where the heads and tags
are in directories.

Signed-off-by: "Santi B=C3=A9jar" <sbejar@gmail.com>

 cg-pull |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cg-pull b/cg-pull
--- a/cg-pull
+++ b/cg-pull
@@ -223,15 +223,15 @@ fetch_local () {
 		shift
 	fi
=20
-	cut_last=3D
+	dirs=3D
 	if [ "$1" =3D "-d" ]; then
-		cut_last=3D1
+		dirs=3D1
 		shift
 	fi
=20
 	src=3D"$1"
 	dest=3D"$2"
-	[ "$cut_last" ] && dest=3D${dest%/*}
+	[ "$dirs" ] && src=3D"${src%/}/."
=20
 	cp $cp_flags_l "$src" "$dest"
 }

