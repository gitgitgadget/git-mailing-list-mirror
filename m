From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v5] git-am: allow e-mail file(s) as input
Date: Thu, 16 Jul 2009 07:23:02 +0200
Message-ID: <eb6317e39369adc8d2594c35ee351b49aaadcc24.1247721562.git.nicolas.s.dev@gmx.fr>
References: <7v7hy9bb8k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 16 07:23:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRJRB-0008M8-Pv
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 07:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757504AbZGPFXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 01:23:14 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757489AbZGPFXO
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 01:23:14 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:44894 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757464AbZGPFXN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 01:23:13 -0400
Received: by mail-ew0-f226.google.com with SMTP id 26so4564867ewy.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 22:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=s+0xVv4JFASDM2ipY9NJ+pp5NRbzTxVjLe/dEOQdVos=;
        b=OcmTEDUrNLp5CFcQYdtHBEaGm2xTjYpUz5C6USO7HDq6WJcxY86V76jGnMA7PqgNMN
         9+gd6i7T+PTvM0gwOy3O6k3SYRNmGfFI8CKYmVPPcDaM+p9SADHSTx+XxIraiF7JGsKn
         12sYSFGfP+TJkfIQ0oiLcDs/TC8xIbREW7FqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=krZLyyuzl4RHtL26RVjMCP02LMIEEThkCmjfoE0XDZrbWZTCzBa45aa7wt5X1Hxaqn
         7p4xo94w7VzW8YMtAFId8ePepCnHXxNa8KPFC4mE8Plkr3dD0v1CEfIhKzavFfaWZjsw
         V3QH8uDxJb7gK5ifG+tk+BChgM5yu3ivi3DpY=
Received: by 10.210.125.7 with SMTP id x7mr1637094ebc.19.1247721793456;
        Wed, 15 Jul 2009 22:23:13 -0700 (PDT)
Received: from localhost (88-121-124-61.rev.libertysurf.net [88.121.124.61])
        by mx.google.com with ESMTPS id 23sm3416891eya.39.2009.07.15.22.23.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 22:23:12 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.rc0.129.gdc42
In-Reply-To: <7v7hy9bb8k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123363>

We traditionally allowed a mbox file or a directory name of a maildir t=
o be
given to "git am". Even though file in a maildir (or more generally, a =
piece
of RFC2822 e-mail) is not a mbox file, it contains enough information t=
o create
a commit out of it, so there is no reason to reject one.

This builds on top of a5a6755 (git-am foreign patch support: introduce
patch_format, 2009-05-27) that introduced mailbox format detection. The=
 codepath
to deal with a mbox requires it to begin with "From " line and also all=
ows it to
begin with "From: ", but a random piece of e-mail can and often do begi=
n with
any valid RFC2822 header lines.

Instead of checking the first line, we extract all the lines up to the
first empty line, and make sure they look like e-mail headers.

Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---

This should be the last version of this *%/=C2=A3 patch.
Thanks Junio for your feedbacks.

 Documentation/git-am.txt |    6 +++---
 git-am.sh                |   11 +++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 32e689b..2a930a7 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	 [--ignore-date]
 	 [--whitespace=3D<option>] [-C<n>] [-p<n>] [--directory=3D<dir>]
 	 [--reject] [-q | --quiet]
-	 [<mbox> | <Maildir>...]
+	 [<mbox> | <Maildir>... | <email>... ]
 'git am' (--skip | --resolved | --abort)
=20
 DESCRIPTION
@@ -25,8 +25,8 @@ current branch.
=20
 OPTIONS
 -------
-<mbox>|<Maildir>...::
-	The list of mailbox files to read patches from. If you do not
+<mbox>|<Maildir>...|<email>...::
+	The list of mailbox files or email to read patches from. If you do no=
t
 	supply this argument, the command reads from the standard input.
 	If you supply directories, they will be treated as Maildirs.
=20
diff --git a/git-am.sh b/git-am.sh
index d64d997..2b55ddc 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -162,6 +162,17 @@ check_patch_format () {
 		return 0
 	fi
=20
+	# Then, accept what really looks like (series of) email(s).
+	# the first sed select headers but the folded ones
+	sed -e '/^$/q' -e '/^[[:blank:]]/d' "$1" |
+	# this one is necessary for the next 'grep -v'
+	sed -e '/^$/d' |
+	grep -v -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' ||
+	{
+		patch_format=3Dmbox
+		return 0
+	}
+
 	# otherwise, check the first few lines of the first patch to try
 	# to detect its format
 	{
--=20
1.6.4.rc0.129.gdc42
