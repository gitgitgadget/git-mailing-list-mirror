From: Zapped <zapped@mail.ru>
Subject: [PATCH 2/3] Fixes bug: git-svn: svn.pathnameencoding is not respected with dcommit/set-tree
Date: Sat, 25 Dec 2010 04:20:48 +0300
Message-ID: <1293240049-7744-2-git-send-email-zapped@mail.ru>
References: <1293240049-7744-1-git-send-email-zapped@mail.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 25 02:21:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWIou-0003mU-8T
	for gcvg-git-2@lo.gmane.org; Sat, 25 Dec 2010 02:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab0LYBU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Dec 2010 20:20:56 -0500
Received: from smtp8.mail.ru ([94.100.176.53]:35489 "EHLO smtp8.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab0LYBUz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 20:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=References:In-Reply-To:Message-Id:Date:Subject:To:From; bh=Ldx04jILFzfmB0nae4aM9+u2cYf8LaeOLJyybGj6jp4=;
	b=cWT0RlMd2IMbkw7Loia1azPvQv6WpGsWWGkxd/5IiqzDFqlD5sPXX9Ol/W2Vpf//7FI9/ZZzXXqpcU1fo/JSJZwHarGdhY1rR7e1mzDxyEl6z5XptSC4YRw2+OHk/DTi;
Received: from [85.140.52.43] (port=41177 helo=localhost.localdomain)
	by smtp8.mail.ru with asmtp 
	id 1PWIoX-0001Kk-01
	for git@vger.kernel.org; Sat, 25 Dec 2010 04:20:53 +0300
X-Mailer: git-send-email 1.7.3.4.3.g3f811
In-Reply-To: <1293240049-7744-1-git-send-email-zapped@mail.ru>
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164165>

git-svn dcommit/set-tree fails when svn.pathnameencoding is set for native OS encoding (e.g. cp1251 for Windows) though git-svn fetch/clone works well

Signed-off-by: Zapped <zapped@mail.ru>
---
 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 757de82..399bf4c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -4451,6 +4451,7 @@ sub new {
 	$self->{path_prefix} = length $self->{svn_path} ?
 	                       "$self->{svn_path}/" : '';
 	$self->{config} = $opts->{config};
+	$self->{pathnameencoding} = Git::config('svn.pathnameencoding');
 	return $self;
 }
 
-- 
1.7.3.4.3.g3f811
