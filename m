From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH v3] Make git send-email accept $EDITOR with arguments
Date: Sat, 22 Dec 2007 01:40:52 +0100
Message-ID: <1198284052-20590-1-git-send-email-hendeby@isy.liu.se>
References: <7vd4sz4uii.fsf@gitster.siamese.dyndns.org>
Cc: peff@peff.net, luciano@eurotux.com, git@vger.kernel.org,
	Gustaf Hendeby <hendeby@isy.liu.se>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 22 01:41:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5sQa-0008Tp-N0
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 01:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191AbXLVAkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 19:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753607AbXLVAkz
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 19:40:55 -0500
Received: from bogotron.isy.liu.se ([130.236.48.26]:56381 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462AbXLVAky (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 19:40:54 -0500
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 8A13A25A9B;
	Sat, 22 Dec 2007 01:40:53 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 02958-06; Sat, 22 Dec 2007 01:40:52 +0100 (MET)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id CA33925A9A;
	Sat, 22 Dec 2007 01:40:52 +0100 (MET)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id B1BB81779C; Sat, 22 Dec 2007 01:40:52 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc1.16.gc817f
In-Reply-To: <7vd4sz4uii.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69112>

Currently git send-email does not accept $EDITOR with arguments, eg,
emacs -nw, when starting an editor to produce a cover letter.  This
patch changes this by letting the shell handle the option parsing.

Signed-off-by:  Gustaf Hendeby <hendeby@isy.liu.se>
---

This is based on Junio's suggestion on most readable and compatible
solution.  I'm not sure if it is identical to the C solution for git
tag, but it seems to be a reasonable solution.

 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 248d035..e47994a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -400,7 +400,7 @@ EOT
 	close(C);
 
 	my $editor = $ENV{GIT_EDITOR} || $repo->config("core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
-	system($editor, $compose_filename);
+	system('sh', '-c', '$0 $@', $editor, $compose_filename);
 
 	open(C2,">",$compose_filename . ".final")
 		or die "Failed to open $compose_filename.final : " . $!;
-- 
1.5.4.rc1.16.gc817f
