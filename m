From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [RFC PATCH 6/6] gitweb: Add _defaults_ keyword for feature lists in project config
Date: Tue, 17 Nov 2009 22:22:30 -0800
Message-ID: <1258525350-5528-7-git-send-email-marcel@oak.homeunix.org>
References: <200906221318.19598.jnareb@gmail.com>
 <1258525350-5528-1-git-send-email-marcel@oak.homeunix.org>
 <1258525350-5528-2-git-send-email-marcel@oak.homeunix.org>
 <1258525350-5528-3-git-send-email-marcel@oak.homeunix.org>
 <1258525350-5528-4-git-send-email-marcel@oak.homeunix.org>
 <1258525350-5528-5-git-send-email-marcel@oak.homeunix.org>
 <1258525350-5528-6-git-send-email-marcel@oak.homeunix.org>
Cc: Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Francis Galiegue <fge@one2team.net>,
	"Marcel M. Cary" <marcel@oak.homeunix.org>
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 18 07:29:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAe2d-00034T-78
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 07:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010AbZKRG3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 01:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753918AbZKRG3K
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 01:29:10 -0500
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:47285 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753817AbZKRG3K (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 01:29:10 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2009 01:29:09 EST
Received: (qmail 5917 invoked from network); 18 Nov 2009 06:22:35 -0000
Received: from adsl-76-246-148-73.dsl.pltn13.sbcglobal.net (marcel@76.246.148.73 with plain)
        by smtp125.sbc.mail.sp1.yahoo.com with SMTP; 17 Nov 2009 22:22:34 -0800 PST
X-Yahoo-SMTP: WxgK_ZmswBCwjfqSjWfXdnSm2tyuJVtcxuu8Nw--
X-YMail-OSG: u.gHlokVM1lqTuNmJqWp8JUmLS8_ddZWt0NkPDw_nwXkEWdX6QQuJ3wjcbLlcJOIXLGbaFlVaZSalSsTJIQ4ATNeQsNZpgIEkgOjiIZ6aW.jWN_0s6ukDiqpWwEzcubVdQCAcRbLcYmNND4hJ6ptT69C2CC4PkCwb11gptHatl1j2AktgtcG9L_AfZ2.V1cecGb8ahkoHr3V0pxOAY28GS7BwGeL5Ou66U_wJIG_ipUu7fHttaF5zXtVOKjqDw.BmXRV2DqtlnG3ZVGs7IxRRyjrbnW3BPTQ4Db56sTDuIh9SjUK2vamsybP1m9UKF9SmkFI1YnRh.7sQnWV8.10XZszvHnxACN_HardmndNVKZUtejvMpaXqWDyprUVgw__XgA-
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1NAdw0-0004p6-EL; Tue, 17 Nov 2009 22:22:33 -0800
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1258525350-5528-6-git-send-email-marcel@oak.homeunix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133142>

If the site admin configures the list of committags, there's no way
for a project to get the defaults back short of enumerating them
explicitly.  Worse yet, when the distribution upgrades the default
list, perhaps to push more pre-existing functionality into committags,
the project would have to discover this and upgrade its configuration
to match the new defaults.

Add a special _defaults_ list entry which, in the project config,
expands to the build-time default list configured for that variable.
A project may use this to append or prepend to the default
configuration, even as the default configuration changes with new
releases.
---
 gitweb/INSTALL               |    5 +++++
 gitweb/gitweb.perl           |   18 +++++++++++++-----
 t/t9502-gitweb-committags.sh |   29 +++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 15c0128..83e6a5e 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -143,6 +143,11 @@ And then let each project configure its bug tracker URL:
 
 	git config gitweb.committag.bugzilla.url 'http://bts.example.com?bug='
 
+In a project config, the build-time list of committags can be accessed
+with the special _defaults_ entry.
+
+	git config gitweb.committags '_defaults_, bugzilla'
+
 
 Gitweb repositories
 -------------------
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d413f22..707e76e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -334,6 +334,13 @@ our %committags = (
 	},
 );
 
+sub make_list_feature {
+	my ($name, $hash) = @_;
+	$hash->{'build_default'} = [@{$hash->{'default'}}];
+	$hash->{'sub'} = sub { feature_list($name, @_) };
+	return @_;
+}
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -378,8 +385,7 @@ our %feature = (
 	# $feature{'snapshot'}{'override'} = 1;
 	# and in project config, a comma-separated list of formats or "none"
 	# to disable.  Example: gitweb.snapshot = tbz2,zip;
-	'snapshot' => {
-		'sub' => sub { feature_list('snapshot', @_) },
+	make_list_feature 'snapshot' => {
 		'override' => 0,
 		'default' => ['tgz']},
 
@@ -549,8 +555,7 @@ our %feature = (
 	# $feature{'committags'}{'override'} = 1;
 	# and in project config gitweb.committags = sha1, url, bugzilla
 	# to enable those three committags for that project
-	'committags' => {
-		'sub' => sub { feature_list('committags', @_) },
+	make_list_feature 'committags' => {
 		'override' => 0,
 		'default' => ['signoff', 'sha1']},
 
@@ -621,7 +626,10 @@ sub feature_list {
 	my ($cfg) = git_get_project_config($key);
 
 	if ($cfg) {
-		return ($cfg eq 'none' ? () : split(/\s*[,\s]\s*/, $cfg));
+		return () if $cfg eq 'none';
+		return map {
+				$_ eq '_defaults_' ? @{$feature{$key}{'build_default'}} : $_
+			} split(/\s*[,\s]\s*/, $cfg);
 	}
 
 	return @defaults;
diff --git a/t/t9502-gitweb-committags.sh b/t/t9502-gitweb-committags.sh
index cbe607b..7d16329 100755
--- a/t/t9502-gitweb-committags.sh
+++ b/t/t9502-gitweb-committags.sh
@@ -276,5 +276,34 @@ test_expect_success 'custom committags: ignored when disabled' '
 test_debug 'cat gitweb.log'
 test_debug 'grep -F "foo" gitweb.output'
 
+# ----------------------------------------------------------------------
+# default keyword
+#
+echo default_test > file.txt
+git add file.txt
+git commit -q -F - file.txt <<END
+Lets see what's enabled...
+
+Bug 1234
+567890ab
+See msg-id <x@y.z>
+
+Signed-off-by: A U Thor <at@example.com>
+END
+echo '
+$feature{"committags"}{"default"} = ["sha1", "messageid"];
+$feature{"committags"}{"override"} = 1;
+' >> gitweb_config.perl
+git config gitweb.committags '_defaults_, bugzilla'
+# All these committags should be in effect except messageid
+test_expect_success '_defaults_ keyword: restores build-time default' '
+	gitweb_run "p=.git;a=commit;h=HEAD" &&
+	grep -q "Bug&nbsp;<a[^>]*>1234</a>" gitweb.output &&
+	grep -q "<a[^>]*>567890ab</a>" gitweb.output &&
+	grep -q "See&nbsp;msg-id&nbsp;&lt;x@y.z&gt;" gitweb.output &&
+	grep -q "<span[^>]*>Signed-off-by:" gitweb.output
+'
+test_debug 'cat gitweb.log'
+test_debug 'for i in Bug 5678 msg-id Signed-off; do grep $i gitweb.output; done'
 
 test_done
-- 
1.6.4.4
