From: Russell <russellsteicke@gmail.com>
Subject: [PATCH] git-archimport: Don't include the first line of the tla log message if it's the same as the summary.
Date: Mon, 3 Dec 2007 20:23:03 +0900
Message-ID: <c1b8b6670712030323p22f4c548w9bf08f66010a7d21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 12:23:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz9Ob-00057m-7N
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 12:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbXLCLXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 06:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbXLCLXI
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 06:23:08 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:55016 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbXLCLXF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 06:23:05 -0500
Received: by wa-out-1112.google.com with SMTP id v27so5083726wah
        for <git@vger.kernel.org>; Mon, 03 Dec 2007 03:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=zz38tfWztnxEFtoHCnYXRD5fjEsR3PCY3NpP3jVOaXA=;
        b=uZUp3mwTh8ZJjU0WQZ45ySNxP90p94/ilWY5GrLGo/Ccv37OnOkGm2iftPm27zyk2Mw49ohq6ehLEoI9X/5OR8v/UA5JsWrArHOVlKzf0JsCAJ08F8pBks2XdBigU0BaAQtUiGXFjhDrT0m5lZs294SaLq1yhK9TNVkqL9vsBmY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=d96xQH5PRsE320peaPBjqqE1XVkAaD3oDjuOonn+CxqTuY9ayxofvMZSJ+uw6Al0nEWhJoj4sNXmHbrAPgnUWSBPJnK2b+2W1qWtW9FA2mIPo5GSSeHt0T9Bs3lNPwUZ9V2BdgFYJhwEdGfx602UhS0giw0txqTms3S03Lvlhn4=
Received: by 10.114.36.1 with SMTP id j1mr3520422waj.1196680983843;
        Mon, 03 Dec 2007 03:23:03 -0800 (PST)
Received: by 10.115.78.5 with HTTP; Mon, 3 Dec 2007 03:23:03 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66911>

I have a few gnu arch (tla) archives that I've been converting to git
repositories.  In many of the revisions in those archives, I have used
the ``-L msg'' flag to tla to specify the log message on the command
line.  This results in the summary field of the revision being
duplicated in the first line of the log message.  When I then use
git-archimport to make a git repo with the tla history, this line
appears twice in the git log message, which is ugly.

This patch drops the first line of the log message if it is identical
to the summary field.

---
 git-archimport.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-archimport.perl b/git-archimport.perl
index 9a7a906..cdf7a11 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -833,6 +833,10 @@ sub parselog {
         }
     }

+    # Drop the first line of the log if it's the same as the summary.
+    if ($ps->{summary}->[0] eq $log->[0]) {
+	shift @$log;
+    }
     # drop leading empty lines from the log message
     while (@$log && $log->[0] eq '') {
	shift @$log;
--
1.5.3.7.966.g1c46-dirty


-- 
Virus found in this message.
