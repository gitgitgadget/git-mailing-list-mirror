From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Emit helpful status for accidental "git stash" save
Date: Sat, 22 Dec 2007 15:22:49 +0100
Message-ID: <1198333369-17788-1-git-send-email-win@wincent.com>
References: <7vmys36d7n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 15:23:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J65GJ-00046q-85
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 15:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbXLVOXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 09:23:10 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbXLVOXJ
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 09:23:09 -0500
Received: from wincent.com ([72.3.236.74]:44767 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302AbXLVOXI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 09:23:08 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBMEMpbM025079;
	Sat, 22 Dec 2007 08:22:52 -0600
X-Mailer: git-send-email 1.5.4.rc0.68.g15eb8-dirty
In-Reply-To: <7vmys36d7n.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69134>

El 21/12/2007, a las 20:48, Junio C Hamano escribi=C3=B3:

> (4) A tool should support safety for clueless people when it is
>    reasonable.
>
>    Even though "I did not know what command foo does, so I
>    tried running it and it did something unexpected" is a
>    silly excuse to rob quickie "git stash" from people who
>    know better, we cannot avoid the fact that there are
>    clueless people.  I think checking stash.iknowwhatitdoes to
>    detect first-time users, and explaining what it does to
>    them, may make sense.  And we can take hints from the patch
>    that started this thread how to do this.
>
>    The decision here is that I am open to a change that
>    implements the one-time safety instruction.

Here's a less invasive change that I think addresses this point (4)
that you make.

-- 8< --
Emit helpful status for accidental "git stash" save

If the user types "git stash" mistakenly thinking that this will list
their stashes he/she may be surprised to see that it actually saved
a new stash and reset their working tree and index.

In the worst case they might not know how to recover the state. So
help them by telling them exactly what was saved and also how to
restore it immediately.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 git-stash.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index f16fd9c..a2f3723 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -99,7 +99,8 @@ save_stash () {
=20
 	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
 		die "Cannot save the current status"
-	printf >&2 'Saved "%s"\n' "$stash_msg"
+	printf >&2 'Saved working directory and index state "%s"\n' "$stash_m=
sg"
+	echo >&2 '(To restore them type "git stash apply")'
 }
=20
 have_stash () {
--=20
1.5.4.rc0.68.g15eb8-dirty
