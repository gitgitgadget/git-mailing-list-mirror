From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 7/8] gitweb: Use href(-replay=>1,...) for formats links in "commitdiff"
Date: Mon, 31 Oct 2011 00:36:26 +0100
Message-ID: <1320017787-18048-8-git-send-email-jnareb@gmail.com>
References: <1320017787-18048-1-git-send-email-jnareb@gmail.com>
Cc: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 00:43:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKf2E-0006p3-VC
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 00:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946Ab1J3XnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 19:43:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39759 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491Ab1J3XnU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 19:43:20 -0400
Received: by mail-fx0-f46.google.com with SMTP id n17so5069535faa.19
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 16:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZgEMc858HVA4HWeEnqTxHVB2ytEoo8jMcgQGMU8KwPo=;
        b=AMkeh1mPIMobasqykOMABpfP4MDdWCYM5cII5GdhDCWaQe+noG+uvR/CxiRmpQ675F
         IGfFrYcMwuvFxEV2lsUafpPOta2esovboFkBFmFt3QiOFNELwKkkUIihKs8eWuFF19Yy
         +RKSCKbWonC1iaU2Tw3YvChBfae4lGxb1vxz4=
Received: by 10.223.88.216 with SMTP id b24mr8560925fam.30.1320018200024;
        Sun, 30 Oct 2011 16:43:20 -0700 (PDT)
Received: from localhost.localdomain (aeho24.neoplus.adsl.tpnet.pl. [79.186.196.24])
        by mx.google.com with ESMTPS id a26sm19652514fac.2.2011.10.30.16.43.18
        (version=SSLv3 cipher=OTHER);
        Sun, 30 Oct 2011 16:43:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1320017787-18048-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184486>

Use href(-replay->1,...) in (sub)navigation links (like changing style
of view, or going to parent commit) so that extra options are
preserved.

This is needed so clicking on such (sub)navigation link would preserve
style of diff; for example when using "side-by-side" diff style then
going to parent commit would now also use this style.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is new in this series, and independent on side-by-side stuff.
It can (and perhaps should) be moved earlier in this series.

 gitweb/gitweb.perl |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f69ed08..ffaea45 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7267,8 +7267,8 @@ sub git_commitdiff {
 				}
 			}
 			$formats_nav .= ': ' .
-				$cgi->a({-href => href(action=>"commitdiff",
-				                       hash=>$hash_parent)},
+				$cgi->a({-href => href(-replay=>1,
+				                       hash=>$hash_parent, hash_base=>undef)},
 				        esc_html($hash_parent_short)) .
 				')';
 		} elsif (!$co{'parent'}) {
@@ -7278,28 +7278,28 @@ sub git_commitdiff {
 			# single parent commit
 			$formats_nav .=
 				' (parent: ' .
-				$cgi->a({-href => href(action=>"commitdiff",
-				                       hash=>$co{'parent'})},
+				$cgi->a({-href => href(-replay=>1,
+				                       hash=>$co{'parent'}, hash_base=>undef)},
 				        esc_html(substr($co{'parent'}, 0, 7))) .
 				')';
 		} else {
 			# merge commit
 			if ($hash_parent eq '--cc') {
 				$formats_nav .= ' | ' .
-					$cgi->a({-href => href(action=>"commitdiff",
+					$cgi->a({-href => href(-replay=>1,
 					                       hash=>$hash, hash_parent=>'-c')},
 					        'combined');
 			} else { # $hash_parent eq '-c'
 				$formats_nav .= ' | ' .
-					$cgi->a({-href => href(action=>"commitdiff",
+					$cgi->a({-href => href(-replay=>1,
 					                       hash=>$hash, hash_parent=>'--cc')},
 					        'compact');
 			}
 			$formats_nav .=
 				' (merge: ' .
 				join(' ', map {
-					$cgi->a({-href => href(action=>"commitdiff",
-					                       hash=>$_)},
+					$cgi->a({-href => href(-replay=>1,
+					                       hash=>$_, hash_base=>undef)},
 					        esc_html(substr($_, 0, 7)));
 				} @{$co{'parents'}} ) .
 				')';
-- 
1.7.6
