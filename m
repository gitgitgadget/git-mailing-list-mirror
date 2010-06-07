From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [RFC/PATCH 2/4] gitweb: Create Gitweb::HTML::Link module
Date: Tue,  8 Jun 2010 02:20:42 +0530
Message-ID: <1275943844-24991-2-git-send-email-pavan.sss1991@gmail.com>
References: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Mon Jun 07 22:51:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLjI5-00072v-3o
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 22:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704Ab0FGUvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 16:51:19 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51197 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560Ab0FGUvT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 16:51:19 -0400
Received: by pvg16 with SMTP id 16so1588771pvg.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 13:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=IGrV1qRDEXnQMC0KyVyFGWetXLHp/X4Jc19JlElcUfo=;
        b=BYlKI+e85jHRXdM1sseHgSJuxjaLUiO5IQ8sMsOZ3MZ5s2lFoDHFIra3H70WY8tyBz
         nWncZTjOuzhikfCSk3eitimoMh+1thEwvevrXzSUySN3g1JWflCrpUg94muhJp0MpD2r
         ECWH6ctPPSfPgaTSsgeSMbOH8U2ZPbK5w6nKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SHKmafDwrGnNwI92JMA7GDCwy1Ro0MKkTzbXPnru3nmCoj3AnxUDS2D5JYX6AD40on
         HUNRKWGnLMIKwyFMI0KCqEI00WjoWEZeBLC0VvtbEpcoe74Ows3Hy7Ap1wVUSa8stuiT
         VDTd+rYHWU4EeNPYe0pZj+oXdqIBhA0UOgsn0=
Received: by 10.141.88.16 with SMTP id q16mr71343rvl.156.1275943877962;
        Mon, 07 Jun 2010 13:51:17 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id o38sm1180853rvp.2.2010.06.07.13.51.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 13:51:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.454.ga8c50c
In-Reply-To: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148625>

Create Gitweb::HTML::Link module in 'gitweb/lib/Gitweb/HTML/Link.pm'
to store the subroutines from the section 'action links' in the
previous gitweb.perl

Subroutines moved:
	href

Update 'gitweb/Makefile' to install this module alongside gitweb.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/Makefile                |    5 +-
 gitweb/gitweb.perl             |  123 +-----------------------------------
 gitweb/lib/Gitweb/HTML/Link.pm |  137 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 123 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/HTML/Link.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index fcd4042..28f0858 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -116,6 +116,8 @@ GITWEB_LIB_GITWEB += lib/Gitweb/Config.pm
 GITWEB_LIB_GITWEB += lib/Gitweb/Request.pm
 GITWEB_LIB_GITWEB += lib/Gitweb/Escape.pm
 GITWEB_LIB_GITWEB += lib/Gitweb/Git.pm
+# Files: gitweb/lib/Gitweb/HTML
+GITWEB_LIB_GITWEB_HTML += lib/Gitweb/HTML/Link.pm
 
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
@@ -157,8 +159,9 @@ install: all
 	$(INSTALL) -m 755 $(GITWEB_PROGRAMS) '$(DESTDIR_SQ)$(gitwebdir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
 	$(INSTALL) -m 644 $(GITWEB_FILES) '$(DESTDIR_SQ)$(gitwebstaticdir_SQ)'
-	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitweblibdir_SQ)/Gitweb'
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitweblibdir_SQ)/Gitweb/HTML'
 	$(INSTALL) -m 644 $(GITWEB_LIB_GITWEB) '$(DESTDIR_SQ)$(gitweblibdir_SQ)/Gitweb'
+	$(INSTALL) -m 644 $(GITWEB_LIB_GITWEB_HTML) '$(DESTDIR_SQ)$(gitweblibdir_SQ)/Gitweb/HTML'
 
 ### Cleaning rules
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3931064..bd11ae0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -28,6 +28,7 @@ use Gitweb::Git;
 use Gitweb::Config;
 use Gitweb::Request;
 use Gitweb::Escape;
+use Gitweb::HTML::Link;
 
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
@@ -554,128 +555,6 @@ sub run {
 run();
 
 ## ======================================================================
-## action links
-
-# possible values of extra options
-# -full => 0|1      - use absolute/full URL ($my_uri/$my_url as base)
-# -replay => 1      - start from a current view (replay with modifications)
-# -path_info => 0|1 - don't use/use path_info URL (if possible)
-sub href {
-	my %params = @_;
-	# default is to use -absolute url() i.e. $my_uri
-	my $href = $params{-full} ? $my_url : $my_uri;
-
-	$params{'project'} = $project unless exists $params{'project'};
-
-	if ($params{-replay}) {
-		while (my ($name, $symbol) = each %cgi_param_mapping) {
-			if (!exists $params{$name}) {
-				$params{$name} = $input_params{$name};
-			}
-		}
-	}
-
-	my $use_pathinfo = gitweb_check_feature('pathinfo');
-	if (defined $params{'project'} &&
-	    (exists $params{-path_info} ? $params{-path_info} : $use_pathinfo)) {
-		# try to put as many parameters as possible in PATH_INFO:
-		#   - project name
-		#   - action
-		#   - hash_parent or hash_parent_base:/file_parent
-		#   - hash or hash_base:/filename
-		#   - the snapshot_format as an appropriate suffix
-
-		# When the script is the root DirectoryIndex for the domain,
-		# $href here would be something like http://gitweb.example.com/
-		# Thus, we strip any trailing / from $href, to spare us double
-		# slashes in the final URL
-		$href =~ s,/$,,;
-
-		# Then add the project name, if present
-		$href .= "/".esc_url($params{'project'});
-		delete $params{'project'};
-
-		# since we destructively absorb parameters, we keep this
-		# boolean that remembers if we're handling a snapshot
-		my $is_snapshot = $params{'action'} eq 'snapshot';
-
-		# Summary just uses the project path URL, any other action is
-		# added to the URL
-		if (defined $params{'action'}) {
-			$href .= "/".esc_url($params{'action'}) unless $params{'action'} eq 'summary';
-			delete $params{'action'};
-		}
-
-		# Next, we put hash_parent_base:/file_parent..hash_base:/file_name,
-		# stripping nonexistent or useless pieces
-		$href .= "/" if ($params{'hash_base'} || $params{'hash_parent_base'}
-			|| $params{'hash_parent'} || $params{'hash'});
-		if (defined $params{'hash_base'}) {
-			if (defined $params{'hash_parent_base'}) {
-				$href .= esc_url($params{'hash_parent_base'});
-				# skip the file_parent if it's the same as the file_name
-				if (defined $params{'file_parent'}) {
-					if (defined $params{'file_name'} && $params{'file_parent'} eq $params{'file_name'}) {
-						delete $params{'file_parent'};
-					} elsif ($params{'file_parent'} !~ /\.\./) {
-						$href .= ":/".esc_url($params{'file_parent'});
-						delete $params{'file_parent'};
-					}
-				}
-				$href .= "..";
-				delete $params{'hash_parent'};
-				delete $params{'hash_parent_base'};
-			} elsif (defined $params{'hash_parent'}) {
-				$href .= esc_url($params{'hash_parent'}). "..";
-				delete $params{'hash_parent'};
-			}
-
-			$href .= esc_url($params{'hash_base'});
-			if (defined $params{'file_name'} && $params{'file_name'} !~ /\.\./) {
-				$href .= ":/".esc_url($params{'file_name'});
-				delete $params{'file_name'};
-			}
-			delete $params{'hash'};
-			delete $params{'hash_base'};
-		} elsif (defined $params{'hash'}) {
-			$href .= esc_url($params{'hash'});
-			delete $params{'hash'};
-		}
-
-		# If the action was a snapshot, we can absorb the
-		# snapshot_format parameter too
-		if ($is_snapshot) {
-			my $fmt = $params{'snapshot_format'};
-			# snapshot_format should always be defined when href()
-			# is called, but just in case some code forgets, we
-			# fall back to the default
-			$fmt ||= $snapshot_fmts[0];
-			$href .= $known_snapshot_formats{$fmt}{'suffix'};
-			delete $params{'snapshot_format'};
-		}
-	}
-
-	# now encode the parameters explicitly
-	my @result = ();
-	for (my $i = 0; $i < @cgi_param_mapping; $i += 2) {
-		my ($name, $symbol) = ($cgi_param_mapping[$i], $cgi_param_mapping[$i+1]);
-		if (defined $params{$name}) {
-			if (ref($params{$name}) eq "ARRAY") {
-				foreach my $par (@{$params{$name}}) {
-					push @result, $symbol . "=" . esc_param($par);
-				}
-			} else {
-				push @result, $symbol . "=" . esc_param($params{$name});
-			}
-		}
-	}
-	$href .= "?" . join(';', @result) if scalar @result;
-
-	return $href;
-}
-
-
-## ======================================================================
 ## validation, quoting/unquoting and escaping
 
 sub validate_action {
diff --git a/gitweb/lib/Gitweb/HTML/Link.pm b/gitweb/lib/Gitweb/HTML/Link.pm
new file mode 100644
index 0000000..086809f
--- /dev/null
+++ b/gitweb/lib/Gitweb/HTML/Link.pm
@@ -0,0 +1,137 @@
+#!/usr/bin/perl
+#
+# Gitweb::HTML::Link -- gitweb's action links package
+#
+# This program is licensed under the GPLv2
+
+package Gitweb::HTML::Link;
+
+use strict;
+use warnings;
+use Exporter qw(import);
+
+our @EXPORT = qw(href);
+
+use Gitweb::Config qw(gitweb_check_feature %known_snapshot_formats @snapshot_fmts);
+use Gitweb::Request qw($project %cgi_param_mapping @cgi_param_mapping $my_url $my_uri %input_params);
+use Gitweb::Escape qw(esc_url esc_param);
+
+# possible values of extra options
+# -full => 0|1      - use absolute/full URL ($my_uri/$my_url as base)
+# -replay => 1      - start from a current view (replay with modifications)
+# -path_info => 0|1 - don't use/use path_info URL (if possible)
+sub href {
+	my %params = @_;
+	# default is to use -absolute url() i.e. $my_uri
+	my $href = $params{-full} ? $my_url : $my_uri;
+
+	$params{'project'} = $project unless exists $params{'project'};
+
+	if ($params{-replay}) {
+		while (my ($name, $symbol) = each %cgi_param_mapping) {
+			if (!exists $params{$name}) {
+				$params{$name} = $input_params{$name};
+			}
+		}
+	}
+
+	my $use_pathinfo = gitweb_check_feature('pathinfo');
+	if (defined $params{'project'} &&
+	    (exists $params{-path_info} ? $params{-path_info} : $use_pathinfo)) {
+		# try to put as many parameters as possible in PATH_INFO:
+		#   - project name
+		#   - action
+		#   - hash_parent or hash_parent_base:/file_parent
+		#   - hash or hash_base:/filename
+		#   - the snapshot_format as an appropriate suffix
+
+		# When the script is the root DirectoryIndex for the domain,
+		# $href here would be something like http://gitweb.example.com/
+		# Thus, we strip any trailing / from $href, to spare us double
+		# slashes in the final URL
+		$href =~ s,/$,,;
+
+		# Then add the project name, if present
+		$href .= "/".esc_url($params{'project'});
+		delete $params{'project'};
+
+		# since we destructively absorb parameters, we keep this
+		# boolean that remembers if we're handling a snapshot
+		my $is_snapshot = $params{'action'} eq 'snapshot';
+
+		# Summary just uses the project path URL, any other action is
+		# added to the URL
+		if (defined $params{'action'}) {
+			$href .= "/".esc_url($params{'action'}) unless $params{'action'} eq 'summary';
+			delete $params{'action'};
+		}
+
+		# Next, we put hash_parent_base:/file_parent..hash_base:/file_name,
+		# stripping nonexistent or useless pieces
+		$href .= "/" if ($params{'hash_base'} || $params{'hash_parent_base'}
+			|| $params{'hash_parent'} || $params{'hash'});
+		if (defined $params{'hash_base'}) {
+			if (defined $params{'hash_parent_base'}) {
+				$href .= esc_url($params{'hash_parent_base'});
+				# skip the file_parent if it's the same as the file_name
+				if (defined $params{'file_parent'}) {
+					if (defined $params{'file_name'} && $params{'file_parent'} eq $params{'file_name'}) {
+						delete $params{'file_parent'};
+					} elsif ($params{'file_parent'} !~ /\.\./) {
+						$href .= ":/".esc_url($params{'file_parent'});
+						delete $params{'file_parent'};
+					}
+				}
+				$href .= "..";
+				delete $params{'hash_parent'};
+				delete $params{'hash_parent_base'};
+			} elsif (defined $params{'hash_parent'}) {
+				$href .= esc_url($params{'hash_parent'}). "..";
+				delete $params{'hash_parent'};
+			}
+
+			$href .= esc_url($params{'hash_base'});
+			if (defined $params{'file_name'} && $params{'file_name'} !~ /\.\./) {
+				$href .= ":/".esc_url($params{'file_name'});
+				delete $params{'file_name'};
+			}
+			delete $params{'hash'};
+			delete $params{'hash_base'};
+		} elsif (defined $params{'hash'}) {
+			$href .= esc_url($params{'hash'});
+			delete $params{'hash'};
+		}
+
+		# If the action was a snapshot, we can absorb the
+		# snapshot_format parameter too
+		if ($is_snapshot) {
+			my $fmt = $params{'snapshot_format'};
+			# snapshot_format should always be defined when href()
+			# is called, but just in case some code forgets, we
+			# fall back to the default
+			$fmt ||= $snapshot_fmts[0];
+			$href .= $known_snapshot_formats{$fmt}{'suffix'};
+			delete $params{'snapshot_format'};
+		}
+	}
+
+	# now encode the parameters explicitly
+	my @result = ();
+	for (my $i = 0; $i < @cgi_param_mapping; $i += 2) {
+		my ($name, $symbol) = ($cgi_param_mapping[$i], $cgi_param_mapping[$i+1]);
+		if (defined $params{$name}) {
+			if (ref($params{$name}) eq "ARRAY") {
+				foreach my $par (@{$params{$name}}) {
+					push @result, $symbol . "=" . esc_param($par);
+				}
+			} else {
+				push @result, $symbol . "=" . esc_param($params{$name});
+			}
+		}
+	}
+	$href .= "?" . join(';', @result) if scalar @result;
+
+	return $href;
+}
+
+1;
-- 
1.7.1.454.ga8c50c
