From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/8] git-remote-mediawiki: fixes, optimizations, and progress report
Date: Mon, 16 Jul 2012 14:00:45 +0200
Message-ID: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Asheesh Laroia <asheesh@asheesh.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 16 14:01:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqjzk-0006YA-8Q
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 14:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab2GPMBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 08:01:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54850 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab2GPMBc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 08:01:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6GBxUfE021726
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 13:59:30 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sqjz6-0002Uy-U8; Mon, 16 Jul 2012 14:01:04 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sqjz6-0000oB-Pj; Mon, 16 Jul 2012 14:01:04 +0200
X-Mailer: git-send-email 1.7.11.1.30.g7e1baf9.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 16 Jul 2012 13:59:30 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6GBxUfE021726
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1343044772.96049@BEW7tg+ISYU+ctiSNlCdag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201510>

After the recent improvements to git-remote-mediawiki, I did a bit of
real-life testing, by importing https://ensiwiki.ensimag.fr/ and
https://git.wiki.kernel.org/. It turned out we had a few blocking bugs
and a grossly unoptimized algorithm on push. This patch serie makes
git-remote-mediawiki usable on these wikis (although it's still a bit
slow).

My initial patch serie also contained a patch "git-remote-mediawiki:
replace TODO-list in comment by appropriate link" that replaced the
TODO-list in the comments of the file with just 

 # Gateway between Git and MediaWiki.
 # Documentation & bugtracker: https://github.com/moy/Git-Mediawiki/

but I'm holding it for now as there seems to be interest in changing
the homepage, so the link may not be appropriate.

Matthieu Moy (8):
  git-remote-mediawiki: don't split namespaces with spaces
  git-remote-mediawiki: actually send empty comment when they're empty
  git-remote-mediawiki: make mediafiles export optional
  git-remote-mediawiki: get rid of O(N^2) loop
  git-remote-mediawiki: use --force when adding notes
  git-remote-mediawiki: show progress information when listing pages
  git-remote-mediawiki: show progress information when getting last
    remote revision
  git-remote-mediawiki: properly deal with invalid remote revisions

 contrib/mw-to-git/git-remote-mediawiki | 80 +++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 16 deletions(-)

-- 
1.7.11.1.30.g7e1baf9.dirty
