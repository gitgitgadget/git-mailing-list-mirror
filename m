From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 2/2] gitweb: introduce localtime feature
Date: Tue, 15 Mar 2011 19:15:55 -0700
Message-ID: <e272fa98ecab9d30edb4457e2e215688@localhost>
References: <3ef1af6874437043a4451bfbcae59b2b@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 03:31:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzgWB-0001dn-5R
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 03:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610Ab1CPCbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 22:31:18 -0400
Received: from [69.28.251.93] ([69.28.251.93]:57017 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751131Ab1CPCbR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 22:31:17 -0400
Received: (qmail 1579 invoked from network); 16 Mar 2011 02:24:33 -0000
Received: from localhost (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by localhost with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 Mar 2011 02:24:33 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Tue, 15 Mar 2011 19:24:33 -0700
In-Reply-To: <3ef1af6874437043a4451bfbcae59b2b@localhost>
User-Agent: vim 7.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169097>

With this feature enabled, all timestamps are shown in the machine's
local timezone instead of GMT.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 gitweb/gitweb.perl |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3b6a90d..d171ad5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -504,6 +504,12 @@ our %feature = (
 		'sub' => sub { feature_bool('remote_heads', @_) },
 		'override' => 0,
 		'default' => [0]},
+
+	# Use localtime rather than GMT for all timestamps.  Disabled
+	# by default.  Project specific override is not supported.
+	'localtime' => {
+		'override' => 0,
+		'default' => [0]},
 );
 
 sub gitweb_get_feature {
@@ -2927,6 +2933,12 @@ sub parse_date {
 	$date{'iso-tz'} = sprintf("%04d-%02d-%02d %02d:%02d:%02d %s",
 	                          1900+$year, $mon+1, $mday,
 	                          $hour, $min, $sec, $tz);
+
+	if (gitweb_check_feature('localtime')) {
+		$date{'rfc2822'}   = sprintf "%s, %d %s %4d %02d:%02d:%02d $tz",
+				     $days[$wday], $mday, $months[$mon],
+				     1900+$year, $hour ,$min, $sec;
+	}
 	return %date;
 }
 
@@ -3989,7 +4001,7 @@ sub git_print_authorship_rows {
 		      "</td></tr>\n" .
 		      "<tr>" .
 		      "<td></td><td> $wd{'rfc2822'}";
-		print_local_time(%wd);
+		print_local_time(%wd) if !gitweb_check_feature('localtime');
 		print "</td>" .
 		      "</tr>\n";
 	}
-- 
1.7.4.1
