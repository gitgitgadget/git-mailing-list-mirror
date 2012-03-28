From: "W. Trevor King" <wking@drexel.edu>
Subject: [PATCH v7 1/3] gitweb: add `status` headers to git_feed() responses.
Date: Wed, 28 Mar 2012 13:44:16 -0400
Message-ID: <4958e06536924de10105bb453d88e8f4c28bb8c1.1332956550.git.wking@drexel.edu>
References: <20120328164513.GA4389@odin.tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 20:44:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCxrG-0004ey-84
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 20:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587Ab2C1So3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 14:44:29 -0400
Received: from vms173019pub.verizon.net ([206.46.173.19]:43363 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932358Ab2C1So3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 14:44:29 -0400
X-Greylist: delayed 3609 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Mar 2012 14:44:29 EDT
Received: from odin.tremily.us ([unknown] [72.68.98.116])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1L0029CVXPZ190@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 28 Mar 2012 12:44:14 -0500 (CDT)
Received: from mjolnir (mjolnir.tremily.us [192.168.0.6])
	by odin.tremily.us (Postfix) with ESMTPS id 1C35843B265; Wed,
 28 Mar 2012 13:44:12 -0400 (EDT)
Received: by mjolnir (sSMTP sendmail emulation); Wed, 28 Mar 2012 13:44:28 -0400
X-Mailer: git-send-email 1.7.3.4
In-reply-to: <20120328164513.GA4389@odin.tremily.us>
In-reply-to: <cover.1332956550.git.wking@drexel.edu>
References: <cover.1332956550.git.wking@drexel.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194162>

The git_feed() method was not setting a `Status` header unless it was
responding to an If-Modified-Since request with `304 Not Modified`.
Now, when it is serving successful responses, it sets status to `200
OK`.

Signed-off-by: W Trevor King <wking@drexel.edu>
---
 gitweb/gitweb.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a8b5fad..041da17 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7841,11 +7841,13 @@ sub git_feed {
 		print $cgi->header(
 			-type => $content_type,
 			-charset => 'utf-8',
-			-last_modified => $latest_date{'rfc2822'});
+			-last_modified => $latest_date{'rfc2822'},
+			-status => '200 OK');
 	} else {
 		print $cgi->header(
 			-type => $content_type,
-			-charset => 'utf-8');
+			-charset => 'utf-8',
+			-status => '200 OK');
 	}
 
 	# Optimization: skip generating the body if client asks only
-- 
1.7.3.4
