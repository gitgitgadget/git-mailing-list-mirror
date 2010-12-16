From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 resend] bash completion: add basic support for git-reflog
Date: Thu, 16 Dec 2010 14:56:08 +0800
Message-ID: <20101216145608.000004df@unknown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 16 07:56:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PT7lQ-0000gz-CK
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 07:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815Ab0LPG41 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Dec 2010 01:56:27 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34781 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab0LPG40 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 01:56:26 -0500
Received: by iwn9 with SMTP id 9so2959543iwn.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 22:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=RQ/g2X670OrX9obddvxJWiIs1H34UAEuabghkL1dkI8=;
        b=isGXbY+ue/v4pENcC1z47nyjABHbaKl3zeJ2XhbkmSBiO82JnwTqwrPXbdqlliG9aX
         4Vcm2VSwyAlsJvQpq3ngkWYhMGrXi7cYvrGugPrwKSa4cZl5q15GnW85q1peyPa0q4nA
         saLAVVENLqhA4am/tHmj4fYRiv8uR2vIGoO+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=dVF75dADKQnOJycxmSrgF7IYXipDhwbkvk2izfN2QzONyGcPQnQLhuP1aL4uBG0V6Q
         LyqtB+KN1+T1fHpUNQno4M2gVtDgXNL4Ba6JVDJlDrmfsaACpa/UPuXAjBqE1y4KaFqV
         BEMLyk69VPlsvk8pTeB8NRoL8eA9ltEMrP0gk=
Received: by 10.42.176.1 with SMTP id bc1mr6950952icb.47.1292482585718;
        Wed, 15 Dec 2010 22:56:25 -0800 (PST)
Received: from unknown (cm8.zeta153.maxonline.com.sg [116.87.153.8])
        by mx.google.com with ESMTPS id z4sm1644000ibg.13.2010.12.15.22.56.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 22:56:24 -0800 (PST)
X-Mailer: Claws Mail 3.7.4cvs1 (GTK+ 2.16.0; i586-pc-mingw32msvc)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163802>

"Promote" the reflog command out of plumbing, so that we now run
completion for it. After all, it's listed under porcelain (ancillary),
and we do run completion for those commands.

Add basic completion for the three subcommands - show, expire, delete.
Try completing refs for these too.

Helped-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

resend note:
This didn't seem to have been picked up. FYI, Johnathan
made a comment, but it was non-blocking, so I didn't change anything.

Changed from v1:=20
 - picked up G=C3=A1bor's suggestion on using __git_find_on_cmdline()
   to correctly handle situations where subcommands are used with dashe=
d
   options.
 - don't "hide" reflog anymore - run completion for it too.

G=C3=A1bor: hmm, it really seems that reflog is treated as plumbing - n=
o completion
is done for it. Even get-tar-commit-id (I've never used this before) is=
 treated
better than reflog. Shall do something about it!

 contrib/completion/git-completion.bash |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index f710469..6732b1d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -735,7 +735,6 @@ __git_list_porcelain_commands ()
 		quiltimport)      : import;;
 		read-tree)        : plumbing;;
 		receive-pack)     : plumbing;;
-		reflog)           : plumbing;;
 		remote-*)         : transport;;
 		repo-config)      : deprecated;;
 		rerere)           : plumbing;;
@@ -1632,6 +1631,18 @@ _git_rebase ()
 	__gitcomp "$(__git_refs)"
 }
=20
+_git_reflog ()
+{
+	local subcommands=3D"show delete expire"
+	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
+
+	if [ -z "$subcommand" ]; then
+		__gitcomp "$subcommands"
+	else
+		__gitcomp "$(__git_refs)"
+	fi
+}
+
 __git_send_email_confirm_options=3D"always never auto cc compose"
 __git_send_email_suppresscc_options=3D"author self cc bodycc sob cccmd=
 body all"
=20
--=20
1.7.3.2.493.g2b058
