From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH v2] Make git send-email accept $EDITOR with arguments
Date: Fri, 21 Dec 2007 12:36:42 +0100
Message-ID: <1198237002-21470-1-git-send-email-hendeby@isy.liu.se>
References: <20071220203211.GA12296@bit.office.eurotux.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Gustaf Hendeby <hendeby@isy.liu.se>
To: luciano@eurotux.com
X-From: git-owner@vger.kernel.org Fri Dec 21 12:37:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5gBh-0007Ao-Ly
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 12:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbXLULgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 06:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750695AbXLULgq
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 06:36:46 -0500
Received: from bogotron.isy.liu.se ([130.236.48.26]:46785 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbXLULgp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 06:36:45 -0500
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 97F6C25A9B;
	Fri, 21 Dec 2007 12:36:43 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 27458-01; Fri, 21 Dec 2007 12:36:42 +0100 (MET)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id AE8ED25A99;
	Fri, 21 Dec 2007 12:36:42 +0100 (MET)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id 9EA891779C; Fri, 21 Dec 2007 12:36:42 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc1.4.gb8173-dirty
In-Reply-To: <20071220203211.GA12296@bit.office.eurotux.com>
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69062>

Currently git send-email does not accept $EDITOR with arguments, eg,
emacs -nw, when starting an editor to produce a cover letter.  This
fix uses perl's implicit splitting to perform the task and that should
hopefully cover most interesting cases.

Signed-off-by:  Gustaf Hendeby <hendeby@isy.liu.se>
---

Thanks to Luciano for the tip to use the internal splitting in perl,
that should be a better solution than to split on all spaces.  I don't
think it is necessary, though, to add an extra error message if the
system call fails, system in it self already produces something that
should be clear enough.  If anyone got a strong oppinion for another
error message I'll fix that.

Junio, even if this is technically not a bug fix, it would be nice to
get this fix into the 1.5.4 so that the usage of $EDITOR becomes more
consistent throughout git.

/Gustaf

 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 248d035..5764668 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -400,7 +400,7 @@ EOT
 	close(C);
 
 	my $editor = $ENV{GIT_EDITOR} || $repo->config("core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
-	system($editor, $compose_filename);
+	system("$editor $compose_filename");
 
 	open(C2,">",$compose_filename . ".final")
 		or die "Failed to open $compose_filename.final : " . $!;
-- 
1.5.4.rc1.4.gb8173-dirty
