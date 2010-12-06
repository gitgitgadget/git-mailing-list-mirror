From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH 24/24] gitweb: Add beginnings of cache administration page (proof of concept)
Date: Tue,  7 Dec 2010 00:11:09 +0100
Message-ID: <1291677069-6559-25-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:17:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkJg-0002Va-Gk
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384Ab0LFXRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:17:51 -0500
Received: from mail-ey0-f171.google.com ([209.85.215.171]:37279 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab0LFXRv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:17:51 -0500
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Dec 2010 18:17:05 EST
Received: by mail-ey0-f171.google.com with SMTP id 5so8018462eyg.2
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7LjUBUOPrHg8Dcqs+zh0t8wTXhxabxGq1WHPKlDzu1I=;
        b=E/W6CtejR3reMQhIIdd+Mgzl24/66OvxsTbcGu6BGg+rJLzuByJVJKhRDH2KJAcNPJ
         txqEjpk1Ak513gY61ApiBeB4p/E3C34FrlHAGaV/YgADhLVdaICnA/Y0k2dgVAhpYPuO
         dw0NxnzizdJtxaJaI5oNCGdfgKSOhJOUIl0mE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AMa1rAhhIagJOQifi5yopV2hcy/CEjXncTurBtTDAAjNAb5ov/mz2R+fNpaKWHJtsC
         u/+QRMu7YeU3eCOKOvkZTZLVjeiQGCfq64dGAU9Mr0piVpJk0yav7GC3QD86gP2Gv7YS
         shlDDAuoo0QtKGnfnlHytN7imQhJcPoTxn3NU=
Received: by 10.14.29.71 with SMTP id h47mr5100982eea.29.1291677161143;
        Mon, 06 Dec 2010 15:12:41 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.12.39
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:12:40 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163051>

Currently cache administration page ('cache' action) shows estimated
size of cache, and provides link to clearing cache.

Cache administration page is visible only on local computer; the same
is true with respect to ability to clear cache.  Those are bare
beginnings of autorization framework.

If you can use cache administration page, you will see 'admin' link at
the botom of the page to it.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is "frontend" (interface) patch for gitweb cache management.

This is very much work in progress, sent to git mailing list as a
proof of concept.  Would something like that (perhaps with more
advanced authorization for admin) be useful?

The 'cache' page looks like this:

  Cache location      Size	 
  ------------------+---------+--------------
  cache/gitweb        14 KiB	[Clear cache]
  ------------------+---------+--------------

where '[Clear cache]' is a submit button.


Compared to previous series there is now 'admin' link that leads to
cache administration page, which is present only if you have
permissions to access said page.

Also for empty cache we show '-'.  

Code was made slightly safer, though still I wouldn't use it in
production, as there might be a chance that remote attacker could
possibly clear cache (meaning I didn't prove that it couldn't happen).


In the final version this patch should probably be split into a few
smaller commits, for example:
* adding support for $opts{'-title'} to git_header_html
* action_is_cacheable subroutine
* human_readable_size (which could also be used in 'tree' view at request)
* xxx_admin_auth_ok, i.e. authorization and authentication for admin and
  write actions in gitweb
* 'cache' (i.e. cache admin) and 'clear_cache' (worker) methods

 gitweb/gitweb.perl |  138 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1521bf2..66e240f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -25,6 +25,8 @@ use Encode;
 use Fcntl qw(:mode :flock);
 use File::Find qw();
 use File::Basename qw(basename);
+use POSIX; # for POSIX::ceil($x)
+
 binmode STDOUT, ':utf8';
 
 our $t0;
@@ -888,6 +890,10 @@ sub evaluate_actions_info {
 	map { $actions_info{$_}{'output_format'} = undef }
 		qw(blob_plain object);
 	$actions_info{'snapshot'}{'output_format'} = 'binary';
+
+	# specify uncacheable actions
+	map { $actions_info{$_}{'uncacheable'} = 1 }
+		qw(cache clear_cache);
 }
 
 sub action_outputs_html {
@@ -895,6 +901,11 @@ sub action_outputs_html {
 	return $actions_info{$action}{'output_format'} eq 'html';
 }
 
+sub action_is_cacheable {
+	my $action = shift;
+	return !$actions_info{$action}{'uncacheable'};
+}
+
 sub browser_is_robot {
 	return 1 if !exists $ENV{'HTTP_USER_AGENT'}; # gitweb run as script
 	if (eval { require HTTP::BrowserDetect; }) {
@@ -1245,12 +1256,13 @@ sub dispatch {
 	if (!defined($actions{$action})) {
 		die_error(400, "Unknown action");
 	}
-	if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
+	if ($action !~ m/^(?:opml|project_list|project_index|cache|clear_cache)$/ &&
 	    !$project) {
 		die_error(400, "Project needed");
 	}
 
-	if ($caching_enabled) {
+	if ($caching_enabled &&
+	    action_is_cacheable($action)) {
 		# human readable key identifying gitweb output
 		my $output_key = href(-replay => 1, -full => 1, -path_info => 0);
 
@@ -1397,6 +1409,10 @@ sub configure_caching {
 		require GitwebCache::Capture::Simple;
 		$capture = GitwebCache::Capture::Simple->new();
 	}
+
+	# some actions are available only if cache is turned on
+	$actions{'cache'} = \&git_cache_admin;
+	$actions{'clear_cache'} = \&git_cache_clear;
 }
 
 run();
@@ -3760,7 +3776,7 @@ sub git_header_html {
 	my $expires = shift;
 	my %opts = @_;
 
-	my $title = get_page_title();
+	my $title = $opts{'-title'} || get_page_title();
 	my $content_type;
 	# require explicit support from the UA if we are to send the page as
 	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
@@ -3936,10 +3952,18 @@ sub git_footer_html {
 
 	} else {
 		print $cgi->a({-href => href(project=>undef, action=>"opml"),
-		              -class => $feed_class}, "OPML") . " ";
+		              -class => $feed_class}, "OPML") . "\n";
 		print $cgi->a({-href => href(project=>undef, action=>"project_index"),
 		              -class => $feed_class}, "TXT") . "\n";
+
 	}
+
+	if ($actions{'cache'} &&
+	    cache_admin_auth_ok()) {
+		print $cgi->a({-href => href(project=>undef, action=>"cache"),
+		              -class => $feed_class}, "<i>admin</i>") . "\n";
+	}
+
 	print "</div>\n"; # class="page_footer"
 
 	# timing info doesn't make much sense with output (response) caching,
@@ -7412,3 +7436,109 @@ XML
 </opml>
 XML
 }
+
+# see Number::Bytes::Human
+sub human_readable_size {
+	my $bytes = shift || return;
+
+	my @units = ('', 'KiB', 'MiB', 'GiB', 'TiB');
+	my $block = 1024;
+
+	my $x = $bytes;
+	my $unit;
+	foreach (@units) {
+		$unit = $_, last if POSIX::ceil($x) < $block;
+		$x /= $block;
+	}
+
+	my $num;
+	if ($x < 10.0) {
+		$num = sprintf("%.1f", POSIX::ceil($x*10)/10); 
+	} else {
+		$num = sprintf("%d", POSIX::ceil($x));
+	}
+
+	return "$num $unit";
+}
+
+sub cache_admin_auth_ok {
+	if (defined $ENV{'REMOTE_ADDR'}) {
+		if (defined $ENV{'SERVER_ADDR'}) {
+			# SERVER_ADDR is not in RFC 3875
+			return $ENV{'SERVER_ADDR'} eq $ENV{'REMOTE_ADDR'};
+		} elsif ($ENV{'REMOTE_ADDR'} =~ m!^(?:127\.0\.0\.1|::1/128)$!) {
+			# localhost in IPv4 or IPv6
+			return 1;
+		}
+	} else {
+		# REMOTE_ADDR not defined, probably calling gitweb as script
+		return 1;
+	}
+
+	# restrict all but specified cases
+	return 0;
+}
+
+sub git_cache_admin {
+	$caching_enabled
+		or die_error(403, "Caching disabled");
+	cache_admin_auth_ok()
+		or die_error(403, "Cache administration not allowed");
+	$cache && ref($cache)
+		or die_error(500, "Cache is not present");
+
+	git_header_html(undef, undef,
+		-title => to_utf8($site_name) . " - Gitweb cache");
+
+	print <<'EOF_HTML';
+<table class="cache_admin">
+<tr><th>Cache location</th><th>Size</th><th>&nbsp;</th></tr>
+EOF_HTML
+	print '<tr class="light">' .
+	      '<td class="path">' . esc_path($cache->path_to_namespace()) . '</td>' .
+	      '<td>';
+	my $size;
+	if ($cache->can('size')) {
+		$size = $cache->size();
+	} elsif ($cache->can('get_size')) {
+		$size = $cache->get_size();
+	}
+	if (defined $size) {
+		print human_readable_size($size);
+	} else {
+		print '-';
+	}
+	print '</td><td>';
+	if ($cache->can('clear')) {
+		print $cgi->start_form({-method => "POST",
+		                        -action => $my_uri,
+		                        -enctype => CGI::URL_ENCODED}) .
+		      $cgi->input({-name=>"a", -value=>"clear_cache", -type=>"hidden"}) .
+		      $cgi->submit({-label => 'Clear cache'}) .
+		      $cgi->end_form();
+	}
+	print <<'EOF_HTML';
+</td></tr>
+</table>
+EOF_HTML
+
+	git_footer_html();
+}
+
+sub git_cache_clear {
+	$caching_enabled
+		or die_error(403, "Caching disabled");
+	cache_admin_auth_ok()
+		or die_error(403, "Clearing cache not allowed");
+	$cache && ref($cache)
+		or die_error(500, "Cache is not present");
+
+	if ($cgi->request_method() eq 'POST') {
+
+		$cache->clear();
+	}
+
+	#print "cleared";
+	print $cgi->redirect(-uri => href(action=>'cache', -full=>1),
+	                     -status => '303 See Other');
+}
-- 
1.7.3
