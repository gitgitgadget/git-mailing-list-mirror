From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/6] gitweb: Add combined diff support
Date: Mon,  7 May 2007 01:10:02 +0200
Message-ID: <11784930091585-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 01:05:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkpne-00082c-9i
	for gcvg-git@gmane.org; Mon, 07 May 2007 01:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbXEFXFr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 19:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbXEFXFr
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 19:05:47 -0400
Received: from qb-out-0506.google.com ([72.14.204.227]:26571 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbXEFXFq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 19:05:46 -0400
Received: by qb-out-0506.google.com with SMTP id a16so3059604qbd
        for <git@vger.kernel.org>; Sun, 06 May 2007 16:05:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=q7hED980ehkTOU7nihJsrIhlrlxSWsj6zz/nL/sdblJOoi18A2euNSDAdDGWx1ZJacF+g+rMfshDcYxWeSVU42bbmzJ0U6a3dbg5wkG6mcR156VsYJsGcBfD8PZtptl/kD6woGFpqop/aYhLPrDPHjU7bjfUzWgP6k9wd9FJVmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=k0X4xrcI2b+Z+nS4lSu2eVOENQHkdAhqEKG9oT/dWh2bEDWZPMgklNt5JzJ2nB+vGxSIMJwkSiMKoA4M7NMaRoWvOeEF8WG6aormjWKiRXmqRQ+zsu96SICNGBcPArUBVqEfmMd1UD79LLPF8JjHgQ1QQqLIdCiSIYUKpg/xMh0=
Received: by 10.65.154.2 with SMTP id g2mr8902991qbo.1178492745039;
        Sun, 06 May 2007 16:05:45 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id a29sm4748616qbd.2007.05.06.16.05.43;
        Sun, 06 May 2007 16:05:44 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l46NAAWR015904;
	Mon, 7 May 2007 01:10:10 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l46NA9pH015903;
	Mon, 7 May 2007 01:10:09 +0200
X-Mailer: git-send-email 1.5.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46385>

This series of patches adds support for showing combined diff for
merge commits in gitweb, instead of using diff with the first parent
(for 'commitdiff' view), or not showing difftree (for 'commit' view).

We use diff -c (diff --combined) and not diff --cc; the latter would
require modifying git_difftree_body and git_patchset_body for the
possibility that there is line in raw diff output format (in difftree)
that doesn't correspond to any patch: the patch part was removed due
to hunks simplification.

See also notes in individual patches.


Diffstat:
=========

 gitweb/gitweb.css  |   17 ++
 gitweb/gitweb.perl |  480 +++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 394 insertions(+), 103 deletions(-)


Table of contents:
==================

 [PATCH 1/6] gitweb: Add parsing of raw combined diff format to parse_difftree_raw_line
 [PATCH 2/6] gitweb: Add combined diff support to git_difftree_body
 [PATCH 3/6] gitweb: Add combined diff support to git_patchset_body
 [PATCH 4/6] gitweb: Make it possible to use pre-parsed info in git_difftree_body

Those patches prepare for adding support for combined diff for
'commitdiff' and 'commit' views.


 [PATCH 5/6] gitweb: Show combined diff for merge commits in 'commitdiff' view
 [PATCH 6/6] gitweb: Show combined diff for merge commits in 'commit' view

Those patches add (preliminary) generating combined diff for merge
commits for 'commitdiff' view (if there was not provided commit to
compare againts), and for 'commit' view.


 [PATCH 7/6] todo: todo: Remove "Gitweb diff on merge commits" entry

This patch updates TODO list in 'todo' branch.

-- 
Jakub Narebski
