From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH 2/5] switch to central prompt method
Date: Tue, 27 Dec 2011 17:06:07 +0100
Message-ID: <4EF9ECEF.6020403@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 17:06:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfZY2-00013X-P8
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 17:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625Ab1L0QGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 11:06:39 -0500
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:40660 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618Ab1L0QGh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 11:06:37 -0500
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 6923942211D;
	Tue, 27 Dec 2011 17:06:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=kNZSorq5v2SJiZJTXjWBF4cC40w=; b=Ys7IUwelt5rcQbPMR7fkF4hrNYkh
	D+FvJS7SnPUEP31ixDaydXw6Y/BbFYle9lMevCIBBB47ijFoU3f01JBqIVDl1tsX
	6/3jF4H8pEO1oCqdH7L/JLzEDqam0lDJjtdX5MGZeeXb8Ra23nZ0L4cCd6tX54SB
	vlyi+1mOBULu7p4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=aGLY4NnqHu5+vi+8NSg4OVn9OEvX5utQpAQXt7jYwThK3hwn4R0G3+f
	2YgpOx9M/lbxQYjRyRcsWyv+/4jAJlsSbxaERjWG7MlaufNSnNp+G678csvdo3Zi
	61sTIMunk1hy1DD+xVmfDs+6iHs4rjr54Bmd7Of5tM6004izvXPQ=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 230D2422114;
	Tue, 27 Dec 2011 17:06:07 +0100 (CET)
Received: from [91.4.99.60] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25242514; Tue, 27 Dec 2011 17:06:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4EF9EBF4.7070200@tu-clausthal.de>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187718>


Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 git-svn.perl |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index eeb83d3..25d5da7 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4415,13 +4415,8 @@ sub username {

 sub _read_password {
 	my ($prompt, $realm) = @_;
-	my $password = '';
-	if (exists $ENV{GIT_ASKPASS}) {
-		open(PH, "-|", $ENV{GIT_ASKPASS}, $prompt);
-		$password = <PH>;
-		$password =~ s/[\012\015]//; # \n\r
-		close(PH);
-	} else {
+	my $password = Git->askpass_prompt($prompt);;
+	if (!defined $password) {
 		print STDERR $prompt;
 		STDERR->flush;
 		require Term::ReadKey;
-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
