From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/3] git send-email: avoid leaking directory file descriptors.
Date: Fri, 31 Oct 2008 11:57:10 +0100
Message-ID: <1225450632-7230-2-git-send-email-madcoder@debian.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 11:59:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvriD-0001ag-18
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 11:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbYJaK5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 06:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbYJaK5Q
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 06:57:16 -0400
Received: from pan.madism.org ([88.191.52.104]:53956 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbYJaK5P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 06:57:15 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 8B4643B569;
	Fri, 31 Oct 2008 11:57:14 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id B34975EE241; Fri, 31 Oct 2008 11:57:12 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.759.g40a2.dirty
In-Reply-To: <1225450632-7230-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99571>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-send-email.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index bdbfac6..94ca5c8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -374,10 +374,9 @@ for my $f (@ARGV) {
 
 		push @files, grep { -f $_ } map { +$f . "/" . $_ }
 				sort readdir(DH);
-
+		closedir(DH);
 	} elsif (-f $f or -p $f) {
 		push @files, $f;
-
 	} else {
 		print STDERR "Skipping $f - not found.\n";
 	}
-- 
1.6.0.3.759.g40a2.dirty
