From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] gitweb: prefer git_get_project_owner() over
	get_file_owner()
Date: Wed, 4 Jul 2007 00:11:23 +0200
Message-ID: <20070703221122.GI32766@genesis.frugalware.org>
References: <11834862893846-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 00:24:15 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5qn9-0005In-4X
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 00:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253AbXGCWYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 18:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757023AbXGCWYM
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 18:24:12 -0400
Received: from fallback.mail.elte.hu ([157.181.151.13]:50069 "EHLO
	fallback.mail.elte.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656AbXGCWYL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 18:24:11 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim)
	id 1I5qn3-0001N5-R2
	from <vmiklos@frugalware.org>
	for <git@vger.kernel.org>; Wed, 04 Jul 2007 00:24:09 +0200
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1I5qan-0005kT-Vb
	from <vmiklos@frugalware.org>; Wed, 04 Jul 2007 00:11:32 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 4F3651868117; Wed,  4 Jul 2007 00:11:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11834866911868-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-1.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0021]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51546>

This way if $projects_list exists, it'll be used, otherwise get_file_owner()
will be used as before.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Sorry for sending it again, even if sending it to myself first, the long
description was left out somehow.

Also it seems that i had some problem with git-send-email, my bad.

 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index dbfb044..6201b90 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3166,7 +3166,7 @@ sub git_project_list_body {
 			$pr->{'descr'} = chop_str($descr, 25, 5);
 		}
 		if (!defined $pr->{'owner'}) {
-			$pr->{'owner'} = get_file_owner("$projectroot/$pr->{'path'}") || "";
+			$pr->{'owner'} = git_get_project_owner("$pr->{'path'}") || "";
 		}
 		if ($check_forks) {
 			my $pname = $pr->{'path'};
@@ -3590,7 +3590,7 @@ sub git_project_index {
 
 	foreach my $pr (@projects) {
 		if (!exists $pr->{'owner'}) {
-			$pr->{'owner'} = get_file_owner("$projectroot/$pr->{'path'}");
+			$pr->{'owner'} = git_get_project_owner("$pr->{'path'}");
 		}
 
 		my ($path, $owner) = ($pr->{'path'}, $pr->{'owner'});
-- 
1.5.2.2
