From: "Hannes Eder" <hannes.eder@gmail.com>
Subject: [PATCH] allow a single form feed in pre commit hook
Date: Tue, 18 Dec 2007 11:09:20 +0100
Message-ID: <5d2716640712180209k7e2fc9fdw74508178cb9fa54f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 11:09:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4ZOS-000311-OY
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 11:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbXLRKJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 05:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbXLRKJW
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 05:09:22 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:6132 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbXLRKJV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 05:09:21 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3973819wah.23
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 02:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=5/YsGN7sC/nFHL6YINfI6imhXI01cJiJ7KnzE41+Hzs=;
        b=QtnHhIQh84BNVZsM+N9f+gNl4q6rUlslYn3sl0dObWRteBpdOLrq0Zi1qlBPspmyoQ5zvODrkmH/qAk6g4hGBeH6FZjMOW+mBaXoUm1b1JeAPHjxYtRK9aXPh4qKguG8UXWA3N9MLDhBUTR8BaoaIZ4z1dKtLN6C/e/4I7EylzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tzbCu2gyca8tEm09UI7jaurHv0hcM33n++ORp4dxIruEZ0bLYC8N8VpAU0cRZkxht2WWM/IRLPIGugweeuG9hDzNBv4LNhHrVowZEDuljBEA/wZK5smLvdGmYwE+gpZLdAiMAswJAJAEpTBh7PoM87hi/xD4thf1gOYQo8OL5X8=
Received: by 10.114.14.1 with SMTP id 1mr323520wan.9.1197972560268;
        Tue, 18 Dec 2007 02:09:20 -0800 (PST)
Received: by 10.114.156.7 with HTTP; Tue, 18 Dec 2007 02:09:20 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68724>

It's not uncommon to have a line with a single form feed in it, e.g.
the default GPL COPYING and also in .c files and others. Attached
patch allows this in the pre-commit hook.

-Hannes

diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
index 7092bae..a759f92 100644
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit
@@ -55,7 +55,7 @@ perl -e '
 	if (s/^\+//) {
 	    $lineno++;
 	    chomp;
-	    if (/\s$/) {
+	    if (!/^\f$/ && /\s$/) {
 		bad_line("trailing whitespace", $_);
 	    }
 	    if (/^\s* \t/) {
