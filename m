From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] gitweb: escape searchtext and parameters for replay
Date: Wed, 29 Apr 2009 13:44:19 +0200
Message-ID: <1241005459-17311-1-git-send-email-git@drmicha.warpmail.net>
References: <337ECD47-D343-40F2-9E41-9E7D8531C5DF@aepfle.de>
Cc: Jakub Narebski <jnareb@gmail.com>, Olaf Hering <olaf@aepfle.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 13:44:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz8DU-00079J-1H
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 13:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbZD2Lob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 07:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752520AbZD2Loa
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 07:44:30 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44373 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753192AbZD2Lo3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 07:44:29 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4514E335C37;
	Wed, 29 Apr 2009 07:44:29 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 29 Apr 2009 07:44:29 -0400
X-Sasl-enc: aAhXq7+jGDfPBo/2VWFsPLDjwPq/pNdWI9C/nG1XjelA 1241005468
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A4CD659134;
	Wed, 29 Apr 2009 07:44:28 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc3
In-Reply-To: <337ECD47-D343-40F2-9E41-9E7D8531C5DF@aepfle.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117874>

Search texts may very likely include characters like '@' when grepping
for author names. Currently, gitweb produces first/prev/next links with
incorrectly escaped characters.

Make gitweb escape searchtext and parameters which are reused in href()
when replay is set. (cgi params are de-escaped when put into the
parameter dictionary and need to be re-escaped when reused.)

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Maybe something like this? Highly untested!

Cheers,
Michael


 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3f99361..e1b09f8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -848,7 +848,7 @@ sub href (%) {
 	if ($params{-replay}) {
 		while (my ($name, $symbol) = each %cgi_param_mapping) {
 			if (!exists $params{$name}) {
-				$params{$name} = $input_params{$name};
+				$params{$name} = esc_url($input_params{$name});
 			}
 		}
 	}
@@ -5775,7 +5775,7 @@ sub git_search {
 		if ($page > 0) {
 			$paging_nav .=
 				$cgi->a({-href => href(action=>"search", hash=>$hash,
-				                       searchtext=>$searchtext,
+				                       searchtext=>esc_url($searchtext),
 				                       searchtype=>$searchtype)},
 				        "first");
 			$paging_nav .= " &sdot; " .
-- 
1.6.3.rc3
