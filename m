From: Magnus Hagander <magnus@hagander.net>
Subject: [PATCH] Allow gitweb tab width to be set per project.
Date: Tue, 28 Sep 2010 13:35:09 +0200
Message-ID: <1285673709-24924-1-git-send-email-magnus@hagander.net>
Cc: Magnus Hagander <magnus@hagander.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 13:35:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0YTB-0003WP-6t
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 13:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315Ab0I1Lfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 07:35:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43309 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266Ab0I1Lf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 07:35:29 -0400
Received: by fxm3 with SMTP id 3so2492292fxm.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 04:35:27 -0700 (PDT)
Received: by 10.223.116.140 with SMTP id m12mr1495857faq.64.1285673727647;
        Tue, 28 Sep 2010 04:35:27 -0700 (PDT)
Received: from mha-laptop.hagander.net ([217.78.36.66])
        by mx.google.com with ESMTPS id a6sm3010422faa.44.2010.09.28.04.35.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 04:35:26 -0700 (PDT)
Received: by mha-laptop.hagander.net (Postfix, from userid 1000)
	id 0721A1240CA; Tue, 28 Sep 2010 13:35:24 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157410>

Allow the gitweb.tabwidth option to control how many spaces a tab
gets expanded to.

Signed-off-by: Magnus Hagander <magnus@hagander.net>
---

In the PostgreSQL project, we're using 4-space tabs, but we have other projects
as well on our gitweb server, so we need to be able to control this on a
per-project basis.


 gitweb/gitweb.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a85e2f6..ef92a4f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1465,9 +1465,11 @@ sub unquote {
 # escape tabs (convert tabs to spaces)
 sub untabify {
 	my $line = shift;
+	my $tabwidth = git_get_project_config('tabwidth', '--int');
+	$tabwidth = 8 if ($tabwidth <= 0);
 
 	while ((my $pos = index($line, "\t")) != -1) {
-		if (my $count = (8 - ($pos % 8))) {
+		if (my $count = ($tabwidth - ($pos % $tabwidth))) {
 			my $spaces = ' ' x $count;
 			$line =~ s/\t/$spaces/;
 		}
-- 
1.7.0.4
