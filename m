From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH 07/11 GSoC] gitweb: Create Gitweb::RepoConfig module
Date: Tue, 22 Jun 2010 03:30:43 +0530
Message-ID: <1277157648-6029-8-git-send-email-pavan.sss1991@gmail.com>
References: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Tue Jun 22 00:09:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQpAt-0004Lq-W8
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 00:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042Ab0FUWI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 18:08:58 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:47832 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab0FUWI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 18:08:56 -0400
Received: by pxi12 with SMTP id 12so1588856pxi.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 15:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Z93gNjgLXPj/WMpj8Jpj637UfiW7aFYMF+QrLWd2GeM=;
        b=j10otn06LwETga6gSPQaoLF66kF8Cw7j+D36HMvwzqmAmDV5TdUByPfnCq7JHYXgj7
         984kYFsGMEZ4A8IXSFgNQq9fH/CTdskcri8lfkf5awvGteRGUjs7FM3z9Oxyt3q+uHV5
         YDkYkKt2LiUongmPdH8vfNxmYeUhk+5aWG9nA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=p4JbvzsPKKKuuUbyc2zChXgm7uZlXEQpvX5z3XWpMp1UZHKr6OVXZrwYNHETFIWOiJ
         pnrD4UuPdh7w5S4+reTQF6a7OThl4roDVPBAN6wn6WbR7o6HC8GrdxAzH6d47HrQHwww
         FbEeQRsmr7L9uvTRyP1VvjmN7K+Fo00tSV01U=
Received: by 10.142.152.12 with SMTP id z12mr4183984wfd.71.1277157771363;
        Mon, 21 Jun 2010 15:02:51 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id y27sm525703wfi.17.2010.06.21.15.02.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jun 2010 15:02:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.454.g6bbe9.dirty
In-Reply-To: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149454>

Create a Gitweb::RepoConfig module in 'gitweb/lib/Gitweb/RepoConfig.pm'
to store and handle all the configuration and subroutines
related to a single repository regarding the gitweb.perl script.

This module depend on several other modules like Git.pm,
Config.pm, Request.pm and Escape.pm.

It also include subroutines regarding project_list and
it's handling.

Subroutines moved:
	check_head_link
	check_export_ok
	hash_set_multi
	git_parse_project_config
	config_to_bool
	config_to_int
	config_to_multi
	git_get_project_config
	git_get_project_description
	git_get_project_ctags
	git_populate_project_tagcloud
	git_show_project_tagcloud
	git_get_project_url_list
	git_get_projects_list
	git_get_project_list_from_file
	git_get_project_owner
	get_file_owner
	project_in_list

Update gitweb/Makefile to install Gitweb::RepoConfig module
alongside gitweb

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/Makefile                 |    1 +
 gitweb/gitweb.perl              |  400 +------------------------------------
 gitweb/lib/Gitweb/RepoConfig.pm |  424 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 426 insertions(+), 399 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/RepoConfig.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index c77188d..3ae6745 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -116,6 +116,7 @@ GITWEB_MODULES += lib/Gitweb/Git.pm
 GITWEB_MODULES += lib/Gitweb/Config.pm
 GITWEB_MODULES += lib/Gitweb/Request.pm
 GITWEB_MODULES += lib/Gitweb/Escape.pm
+GITWEB_MODULES += lib/Gitweb/RepoConfig.pm
 
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 87281d0..87f52d2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -18,7 +18,6 @@ sub __DIR__ () {
 use lib __DIR__ . '/lib';
 
 use CGI qw(:standard :escapeHTML -nosticky);
-use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser set_message);
 use Fcntl ':mode';
 use File::Find qw();
@@ -30,6 +29,7 @@ use Gitweb::Git;
 use Gitweb::Config;
 use Gitweb::Request;
 use Gitweb::Escape;
+use Gitweb::RepoConfig;
 
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
@@ -110,23 +110,6 @@ sub feature_avatar {
 	return @val ? @val : @_;
 }
 
-# checking HEAD file with -e is fragile if the repository was
-# initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
-# and then pruned.
-sub check_head_link {
-	my ($dir) = @_;
-	my $headfile = "$dir/HEAD";
-	return ((-e $headfile) ||
-		(-l $headfile && readlink($headfile) =~ /^refs\/heads\//));
-}
-
-sub check_export_ok {
-	my ($dir) = @_;
-	return (check_head_link($dir) &&
-		(!$export_ok || -e "$dir/$export_ok") &&
-		(!$export_auth_hook || $export_auth_hook->($dir)));
-}
-
 # Get loadavg of system, to compare against $maxload.
 # Currently it requires '/proc/loadavg' present to get loadavg;
 # if it is not present it returns 0, which means no load checking.
@@ -712,12 +695,6 @@ sub validate_project {
 	}
 }
 
-sub project_in_list {
-	my $project = shift;
-	my @list = git_get_projects_list();
-	return @list && scalar(grep { $_->{'path'} eq $project } @list);
-}
-
 ## ----------------------------------------------------------------------
 ## HTML aware string manipulation
 
@@ -1526,129 +1503,6 @@ sub git_get_type {
 	return $type;
 }
 
-# repository configuration
-our $config_file = '';
-our %config;
-
-# store multiple values for single key as anonymous array reference
-# single values stored directly in the hash, not as [ <value> ]
-sub hash_set_multi {
-	my ($hash, $key, $value) = @_;
-
-	if (!exists $hash->{$key}) {
-		$hash->{$key} = $value;
-	} elsif (!ref $hash->{$key}) {
-		$hash->{$key} = [ $hash->{$key}, $value ];
-	} else {
-		push @{$hash->{$key}}, $value;
-	}
-}
-
-# return hash of git project configuration
-# optionally limited to some section, e.g. 'gitweb'
-sub git_parse_project_config {
-	my $section_regexp = shift;
-	my %config;
-
-	local $/ = "\0";
-
-	open my $fh, "-|", git_cmd(), "config", '-z', '-l',
-		or return;
-
-	while (my $keyval = <$fh>) {
-		chomp $keyval;
-		my ($key, $value) = split(/\n/, $keyval, 2);
-
-		hash_set_multi(\%config, $key, $value)
-			if (!defined $section_regexp || $key =~ /^(?:$section_regexp)\./o);
-	}
-	close $fh;
-
-	return %config;
-}
-
-# convert config value to boolean: 'true' or 'false'
-# no value, number > 0, 'true' and 'yes' values are true
-# rest of values are treated as false (never as error)
-sub config_to_bool {
-	my $val = shift;
-
-	return 1 if !defined $val;             # section.key
-
-	# strip leading and trailing whitespace
-	$val =~ s/^\s+//;
-	$val =~ s/\s+$//;
-
-	return (($val =~ /^\d+$/ && $val) ||   # section.key = 1
-	        ($val =~ /^(?:true|yes)$/i));  # section.key = true
-}
-
-# convert config value to simple decimal number
-# an optional value suffix of 'k', 'm', or 'g' will cause the value
-# to be multiplied by 1024, 1048576, or 1073741824
-sub config_to_int {
-	my $val = shift;
-
-	# strip leading and trailing whitespace
-	$val =~ s/^\s+//;
-	$val =~ s/\s+$//;
-
-	if (my ($num, $unit) = ($val =~ /^([0-9]*)([kmg])$/i)) {
-		$unit = lc($unit);
-		# unknown unit is treated as 1
-		return $num * ($unit eq 'g' ? 1073741824 :
-		               $unit eq 'm' ?    1048576 :
-		               $unit eq 'k' ?       1024 : 1);
-	}
-	return $val;
-}
-
-# convert config value to array reference, if needed
-sub config_to_multi {
-	my $val = shift;
-
-	return ref($val) ? $val : (defined($val) ? [ $val ] : []);
-}
-
-sub git_get_project_config {
-	my ($key, $type) = @_;
-
-	return unless defined $git_dir;
-
-	# key sanity check
-	return unless ($key);
-	$key =~ s/^gitweb\.//;
-	return if ($key =~ m/\W/);
-
-	# type sanity check
-	if (defined $type) {
-		$type =~ s/^--//;
-		$type = undef
-			unless ($type eq 'bool' || $type eq 'int');
-	}
-
-	# get config
-	if (!defined $config_file ||
-	    $config_file ne "$git_dir/config") {
-		%config = git_parse_project_config('gitweb');
-		$config_file = "$git_dir/config";
-	}
-
-	# check if config variable (key) exists
-	return unless exists $config{"gitweb.$key"};
-
-	# ensure given type
-	if (!defined $type) {
-		return $config{"gitweb.$key"};
-	} elsif ($type eq 'bool') {
-		# backward compatibility: 'git config --bool' returns true/false
-		return config_to_bool($config{"gitweb.$key"}) ? 'true' : 'false';
-	} elsif ($type eq 'int') {
-		return config_to_int($config{"gitweb.$key"});
-	}
-	return $config{"gitweb.$key"};
-}
-
 # get hash of given path at given ref
 sub git_get_hash_by_path {
 	my $base = shift;
@@ -1703,245 +1557,6 @@ sub git_get_path_by_hash {
 ## ......................................................................
 ## git utility functions, directly accessing git repository
 
-sub git_get_project_description {
-	my $path = shift;
-
-	$git_dir = "$projectroot/$path";
-	open my $fd, '<', "$git_dir/description"
-		or return git_get_project_config('description');
-	my $descr = <$fd>;
-	close $fd;
-	if (defined $descr) {
-		chomp $descr;
-	}
-	return $descr;
-}
-
-sub git_get_project_ctags {
-	my $path = shift;
-	my $ctags = {};
-
-	$git_dir = "$projectroot/$path";
-	opendir my $dh, "$git_dir/ctags"
-		or return $ctags;
-	foreach (grep { -f $_ } map { "$git_dir/ctags/$_" } readdir($dh)) {
-		open my $ct, '<', $_ or next;
-		my $val = <$ct>;
-		chomp $val;
-		close $ct;
-		my $ctag = $_; $ctag =~ s#.*/##;
-		$ctags->{$ctag} = $val;
-	}
-	closedir $dh;
-	$ctags;
-}
-
-sub git_populate_project_tagcloud {
-	my $ctags = shift;
-
-	# First, merge different-cased tags; tags vote on casing
-	my %ctags_lc;
-	foreach (keys %$ctags) {
-		$ctags_lc{lc $_}->{count} += $ctags->{$_};
-		if (not $ctags_lc{lc $_}->{topcount}
-		    or $ctags_lc{lc $_}->{topcount} < $ctags->{$_}) {
-			$ctags_lc{lc $_}->{topcount} = $ctags->{$_};
-			$ctags_lc{lc $_}->{topname} = $_;
-		}
-	}
-
-	my $cloud;
-	if (eval { require HTML::TagCloud; 1; }) {
-		$cloud = HTML::TagCloud->new;
-		foreach (sort keys %ctags_lc) {
-			# Pad the title with spaces so that the cloud looks
-			# less crammed.
-			my $title = $ctags_lc{$_}->{topname};
-			$title =~ s/ /&nbsp;/g;
-			$title =~ s/^/&nbsp;/g;
-			$title =~ s/$/&nbsp;/g;
-			$cloud->add($title, $home_link."?by_tag=".$_, $ctags_lc{$_}->{count});
-		}
-	} else {
-		$cloud = \%ctags_lc;
-	}
-	$cloud;
-}
-
-sub git_show_project_tagcloud {
-	my ($cloud, $count) = @_;
-	print STDERR ref($cloud)."..\n";
-	if (ref $cloud eq 'HTML::TagCloud') {
-		return $cloud->html_and_css($count);
-	} else {
-		my @tags = sort { $cloud->{$a}->{count} <=> $cloud->{$b}->{count} } keys %$cloud;
-		return '<p align="center">' . join (', ', map {
-			"<a href=\"$home_link?by_tag=$_\">$cloud->{$_}->{topname}</a>"
-		} splice(@tags, 0, $count)) . '</p>';
-	}
-}
-
-sub git_get_project_url_list {
-	my $path = shift;
-
-	$git_dir = "$projectroot/$path";
-	open my $fd, '<', "$git_dir/cloneurl"
-		or return wantarray ?
-		@{ config_to_multi(git_get_project_config('url')) } :
-		   config_to_multi(git_get_project_config('url'));
-	my @git_project_url_list = map { chomp; $_ } <$fd>;
-	close $fd;
-
-	return wantarray ? @git_project_url_list : \@git_project_url_list;
-}
-
-sub git_get_projects_list {
-	my ($filter) = @_;
-	my @list;
-
-	$filter ||= '';
-	$filter =~ s/\.git$//;
-
-	my $check_forks = gitweb_check_feature('forks');
-
-	if (-d $projects_list) {
-		# search in directory
-		my $dir = $projects_list . ($filter ? "/$filter" : '');
-		# remove the trailing "/"
-		$dir =~ s!/+$!!;
-		my $pfxlen = length("$dir");
-		my $pfxdepth = ($dir =~ tr!/!!);
-
-		File::Find::find({
-			follow_fast => 1, # follow symbolic links
-			follow_skip => 2, # ignore duplicates
-			dangling_symlinks => 0, # ignore dangling symlinks, silently
-			wanted => sub {
-				# skip project-list toplevel, if we get it.
-				return if (m!^[/.]$!);
-				# only directories can be git repositories
-				return unless (-d $_);
-				# don't traverse too deep (Find is super slow on os x)
-				if (($File::Find::name =~ tr!/!!) - $pfxdepth > $project_maxdepth) {
-					$File::Find::prune = 1;
-					return;
-				}
-
-				my $subdir = substr($File::Find::name, $pfxlen + 1);
-				# we check related file in $projectroot
-				my $path = ($filter ? "$filter/" : '') . $subdir;
-				if (check_export_ok("$projectroot/$path")) {
-					push @list, { path => $path };
-					$File::Find::prune = 1;
-				}
-			},
-		}, "$dir");
-
-	} elsif (-f $projects_list) {
-		# read from file(url-encoded):
-		# 'git%2Fgit.git Linus+Torvalds'
-		# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
-		# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
-		my %paths;
-		open my $fd, '<', $projects_list or return;
-	PROJECT:
-		while (my $line = <$fd>) {
-			chomp $line;
-			my ($path, $owner) = split ' ', $line;
-			$path = unescape($path);
-			$owner = unescape($owner);
-			if (!defined $path) {
-				next;
-			}
-			if ($filter ne '') {
-				# looking for forks;
-				my $pfx = substr($path, 0, length($filter));
-				if ($pfx ne $filter) {
-					next PROJECT;
-				}
-				my $sfx = substr($path, length($filter));
-				if ($sfx !~ /^\/.*\.git$/) {
-					next PROJECT;
-				}
-			} elsif ($check_forks) {
-			PATH:
-				foreach my $filter (keys %paths) {
-					# looking for forks;
-					my $pfx = substr($path, 0, length($filter));
-					if ($pfx ne $filter) {
-						next PATH;
-					}
-					my $sfx = substr($path, length($filter));
-					if ($sfx !~ /^\/.*\.git$/) {
-						next PATH;
-					}
-					# is a fork, don't include it in
-					# the list
-					next PROJECT;
-				}
-			}
-			if (check_export_ok("$projectroot/$path")) {
-				my $pr = {
-					path => $path,
-					owner => to_utf8($owner),
-				};
-				push @list, $pr;
-				(my $forks_path = $path) =~ s/\.git$//;
-				$paths{$forks_path}++;
-			}
-		}
-		close $fd;
-	}
-	return @list;
-}
-
-our $gitweb_project_owner = undef;
-sub git_get_project_list_from_file {
-
-	return if (defined $gitweb_project_owner);
-
-	$gitweb_project_owner = {};
-	# read from file (url-encoded):
-	# 'git%2Fgit.git Linus+Torvalds'
-	# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
-	# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
-	if (-f $projects_list) {
-		open(my $fd, '<', $projects_list);
-		while (my $line = <$fd>) {
-			chomp $line;
-			my ($pr, $ow) = split ' ', $line;
-			$pr = unescape($pr);
-			$ow = unescape($ow);
-			$gitweb_project_owner->{$pr} = to_utf8($ow);
-		}
-		close $fd;
-	}
-}
-
-sub git_get_project_owner {
-	my $project = shift;
-	my $owner;
-
-	return undef unless $project;
-	$git_dir = "$projectroot/$project";
-
-	if (!defined $gitweb_project_owner) {
-		git_get_project_list_from_file();
-	}
-
-	if (exists $gitweb_project_owner->{$project}) {
-		$owner = $gitweb_project_owner->{$project};
-	}
-	if (!defined $owner){
-		$owner = git_get_project_config('owner');
-	}
-	if (!defined $owner) {
-		$owner = get_file_owner("$git_dir");
-	}
-
-	return $owner;
-}
-
 sub git_get_last_activity {
 	my ($path) = @_;
 	my $fd;
@@ -2449,19 +2064,6 @@ sub git_get_tags_list {
 ## ----------------------------------------------------------------------
 ## filesystem-related functions
 
-sub get_file_owner {
-	my $path = shift;
-
-	my ($dev, $ino, $mode, $nlink, $st_uid, $st_gid, $rdev, $size) = stat($path);
-	my ($name, $passwd, $uid, $gid, $quota, $comment, $gcos, $dir, $shell) = getpwuid($st_uid);
-	if (!defined $gcos) {
-		return undef;
-	}
-	my $owner = $gcos;
-	$owner =~ s/[,;].*$//;
-	return to_utf8($owner);
-}
-
 # assume that file exists
 sub insert_file {
 	my $filename = shift;
diff --git a/gitweb/lib/Gitweb/RepoConfig.pm b/gitweb/lib/Gitweb/RepoConfig.pm
new file mode 100644
index 0000000..fa7d909
--- /dev/null
+++ b/gitweb/lib/Gitweb/RepoConfig.pm
@@ -0,0 +1,424 @@
+#!/usr/bin/perl
+#
+# Gitweb::RepoConfig -- gitweb's per-repository configuration subs package
+#
+# This program is licensed under the GPLv2
+
+package Gitweb::RepoConfig;
+
+use strict;
+use warnings;
+use Exporter qw(import);
+
+our @EXPORT = qw($config_file %config $gitweb_project_owner git_get_project_url_list
+                 git_get_project_config git_get_project_description git_get_project_ctags
+                 git_populate_project_tagcloud git_show_project_tagcloud check_head_link
+                 check_export_ok git_get_projects_list git_get_project_list_from_file
+                 git_get_project_owner project_in_list);
+
+use CGI::Util qw(unescape);
+use Gitweb::Git qw(git_cmd $git_dir);
+use Gitweb::Config qw(gitweb_check_feature $projectroot $projects_list
+                      $project_maxdepth $export_ok $export_auth_hook);
+use Gitweb::Request qw($home_link);
+use Gitweb::Escape qw(to_utf8);
+
+# repository configuration
+our $config_file = '';
+our %config;
+
+# checking HEAD file with -e is fragile if the repository was
+# initialized long time ago (i.e. symlink HEAD) and was pack-ref'ed
+# and then pruned.
+sub check_head_link {
+	my ($dir) = @_;
+	my $headfile = "$dir/HEAD";
+	return ((-e $headfile) ||
+		(-l $headfile && readlink($headfile) =~ /^refs\/heads\//));
+}
+
+sub check_export_ok {
+	my ($dir) = @_;
+	return (check_head_link($dir) &&
+		(!$export_ok || -e "$dir/$export_ok") &&
+		(!$export_auth_hook || $export_auth_hook->($dir)));
+}
+
+# store multiple values for single key as anonymous array reference
+# single values stored directly in the hash, not as [ <value> ]
+sub hash_set_multi {
+	my ($hash, $key, $value) = @_;
+
+	if (!exists $hash->{$key}) {
+		$hash->{$key} = $value;
+	} elsif (!ref $hash->{$key}) {
+		$hash->{$key} = [ $hash->{$key}, $value ];
+	} else {
+		push @{$hash->{$key}}, $value;
+	}
+}
+
+# return hash of git project configuration
+# optionally limited to some section, e.g. 'gitweb'
+sub git_parse_project_config {
+	my $section_regexp = shift;
+	my %config;
+
+	local $/ = "\0";
+
+	open my $fh, "-|", git_cmd(), "config", '-z', '-l',
+		or return;
+
+	while (my $keyval = <$fh>) {
+		chomp $keyval;
+		my ($key, $value) = split(/\n/, $keyval, 2);
+
+		hash_set_multi(\%config, $key, $value)
+			if (!defined $section_regexp || $key =~ /^(?:$section_regexp)\./o);
+	}
+	close $fh;
+
+	return %config;
+}
+
+# convert config value to boolean: 'true' or 'false'
+# no value, number > 0, 'true' and 'yes' values are true
+# rest of values are treated as false (never as error)
+sub config_to_bool {
+	my $val = shift;
+
+	return 1 if !defined $val;             # section.key
+
+	# strip leading and trailing whitespace
+	$val =~ s/^\s+//;
+	$val =~ s/\s+$//;
+
+	return (($val =~ /^\d+$/ && $val) ||   # section.key = 1
+	        ($val =~ /^(?:true|yes)$/i));  # section.key = true
+}
+
+# convert config value to simple decimal number
+# an optional value suffix of 'k', 'm', or 'g' will cause the value
+# to be multiplied by 1024, 1048576, or 1073741824
+sub config_to_int {
+	my $val = shift;
+
+	# strip leading and trailing whitespace
+	$val =~ s/^\s+//;
+	$val =~ s/\s+$//;
+
+	if (my ($num, $unit) = ($val =~ /^([0-9]*)([kmg])$/i)) {
+		$unit = lc($unit);
+		# unknown unit is treated as 1
+		return $num * ($unit eq 'g' ? 1073741824 :
+		               $unit eq 'm' ?    1048576 :
+		               $unit eq 'k' ?       1024 : 1);
+	}
+	return $val;
+}
+
+# convert config value to array reference, if needed
+sub config_to_multi {
+	my $val = shift;
+
+	return ref($val) ? $val : (defined($val) ? [ $val ] : []);
+}
+
+sub git_get_project_config {
+	my ($key, $type) = @_;
+
+	return unless defined $git_dir;
+
+	# key sanity check
+	return unless ($key);
+	$key =~ s/^gitweb\.//;
+	return if ($key =~ m/\W/);
+
+	# type sanity check
+	if (defined $type) {
+		$type =~ s/^--//;
+		$type = undef
+			unless ($type eq 'bool' || $type eq 'int');
+	}
+
+	# get config
+	if (!defined $config_file ||
+	    $config_file ne "$git_dir/config") {
+		%config = git_parse_project_config('gitweb');
+		$config_file = "$git_dir/config";
+	}
+
+	# check if config variable (key) exists
+	return unless exists $config{"gitweb.$key"};
+
+	# ensure given type
+	if (!defined $type) {
+		return $config{"gitweb.$key"};
+	} elsif ($type eq 'bool') {
+		# backward compatibility: 'git config --bool' returns true/false
+		return config_to_bool($config{"gitweb.$key"}) ? 'true' : 'false';
+	} elsif ($type eq 'int') {
+		return config_to_int($config{"gitweb.$key"});
+	}
+	return $config{"gitweb.$key"};
+}
+
+sub git_get_project_description {
+	my $path = shift;
+
+	$git_dir = "$projectroot/$path";
+	open my $fd, '<', "$git_dir/description"
+		or return git_get_project_config('description');
+	my $descr = <$fd>;
+	close $fd;
+	if (defined $descr) {
+		chomp $descr;
+	}
+	return $descr;
+}
+
+sub git_get_project_ctags {
+	my $path = shift;
+	my $ctags = {};
+
+	$git_dir = "$projectroot/$path";
+	opendir my $dh, "$git_dir/ctags"
+		or return $ctags;
+	foreach (grep { -f $_ } map { "$git_dir/ctags/$_" } readdir($dh)) {
+		open my $ct, '<', $_ or next;
+		my $val = <$ct>;
+		chomp $val;
+		close $ct;
+		my $ctag = $_; $ctag =~ s#.*/##;
+		$ctags->{$ctag} = $val;
+	}
+	closedir $dh;
+	$ctags;
+}
+
+sub git_populate_project_tagcloud {
+	my $ctags = shift;
+
+	# First, merge different-cased tags; tags vote on casing
+	my %ctags_lc;
+	foreach (keys %$ctags) {
+		$ctags_lc{lc $_}->{count} += $ctags->{$_};
+		if (not $ctags_lc{lc $_}->{topcount}
+		    or $ctags_lc{lc $_}->{topcount} < $ctags->{$_}) {
+			$ctags_lc{lc $_}->{topcount} = $ctags->{$_};
+			$ctags_lc{lc $_}->{topname} = $_;
+		}
+	}
+
+	my $cloud;
+	if (eval { require HTML::TagCloud; 1; }) {
+		$cloud = HTML::TagCloud->new;
+		foreach (sort keys %ctags_lc) {
+			# Pad the title with spaces so that the cloud looks
+			# less crammed.
+			my $title = $ctags_lc{$_}->{topname};
+			$title =~ s/ /&nbsp;/g;
+			$title =~ s/^/&nbsp;/g;
+			$title =~ s/$/&nbsp;/g;
+			$cloud->add($title, $home_link."?by_tag=".$_, $ctags_lc{$_}->{count});
+		}
+	} else {
+		$cloud = \%ctags_lc;
+	}
+	$cloud;
+}
+
+sub git_show_project_tagcloud {
+	my ($cloud, $count) = @_;
+	print STDERR ref($cloud)."..\n";
+	if (ref $cloud eq 'HTML::TagCloud') {
+		return $cloud->html_and_css($count);
+	} else {
+		my @tags = sort { $cloud->{$a}->{count} <=> $cloud->{$b}->{count} } keys %$cloud;
+		return '<p align="center">' . join (', ', map {
+			"<a href=\"$home_link?by_tag=$_\">$cloud->{$_}->{topname}</a>"
+		} splice(@tags, 0, $count)) . '</p>';
+	}
+}
+
+sub git_get_project_url_list {
+	my $path = shift;
+
+	$git_dir = "$projectroot/$path";
+	open my $fd, '<', "$git_dir/cloneurl"
+		or return wantarray ?
+		@{ config_to_multi(git_get_project_config('url')) } :
+		   config_to_multi(git_get_project_config('url'));
+	my @git_project_url_list = map { chomp; $_ } <$fd>;
+	close $fd;
+
+	return wantarray ? @git_project_url_list : \@git_project_url_list;
+}
+
+sub git_get_projects_list {
+	my ($filter) = @_;
+	my @list;
+
+	$filter ||= '';
+	$filter =~ s/\.git$//;
+
+	my $check_forks = gitweb_check_feature('forks');
+
+	if (-d $projects_list) {
+		# search in directory
+		my $dir = $projects_list . ($filter ? "/$filter" : '');
+		# remove the trailing "/"
+		$dir =~ s!/+$!!;
+		my $pfxlen = length("$dir");
+		my $pfxdepth = ($dir =~ tr!/!!);
+
+		File::Find::find({
+			follow_fast => 1, # follow symbolic links
+			follow_skip => 2, # ignore duplicates
+			dangling_symlinks => 0, # ignore dangling symlinks, silently
+			wanted => sub {
+				# skip project-list toplevel, if we get it.
+				return if (m!^[/.]$!);
+				# only directories can be git repositories
+				return unless (-d $_);
+				# don't traverse too deep (Find is super slow on os x)
+				if (($File::Find::name =~ tr!/!!) - $pfxdepth > $project_maxdepth) {
+					$File::Find::prune = 1;
+					return;
+				}
+
+				my $subdir = substr($File::Find::name, $pfxlen + 1);
+				# we check related file in $projectroot
+				my $path = ($filter ? "$filter/" : '') . $subdir;
+				if (check_export_ok("$projectroot/$path")) {
+					push @list, { path => $path };
+					$File::Find::prune = 1;
+				}
+			},
+		}, "$dir");
+
+	} elsif (-f $projects_list) {
+		# read from file(url-encoded):
+		# 'git%2Fgit.git Linus+Torvalds'
+		# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
+		# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
+		my %paths;
+		open my $fd, '<', $projects_list or return;
+	PROJECT:
+		while (my $line = <$fd>) {
+			chomp $line;
+			my ($path, $owner) = split ' ', $line;
+			$path = unescape($path);
+			$owner = unescape($owner);
+			if (!defined $path) {
+				next;
+			}
+			if ($filter ne '') {
+				# looking for forks;
+				my $pfx = substr($path, 0, length($filter));
+				if ($pfx ne $filter) {
+					next PROJECT;
+				}
+				my $sfx = substr($path, length($filter));
+				if ($sfx !~ /^\/.*\.git$/) {
+					next PROJECT;
+				}
+			} elsif ($check_forks) {
+			PATH:
+				foreach my $filter (keys %paths) {
+					# looking for forks;
+					my $pfx = substr($path, 0, length($filter));
+					if ($pfx ne $filter) {
+						next PATH;
+					}
+					my $sfx = substr($path, length($filter));
+					if ($sfx !~ /^\/.*\.git$/) {
+						next PATH;
+					}
+					# is a fork, don't include it in
+					# the list
+					next PROJECT;
+				}
+			}
+			if (check_export_ok("$projectroot/$path")) {
+				my $pr = {
+					path => $path,
+					owner => to_utf8($owner),
+				};
+				push @list, $pr;
+				(my $forks_path = $path) =~ s/\.git$//;
+				$paths{$forks_path}++;
+			}
+		}
+		close $fd;
+	}
+	return @list;
+}
+
+our $gitweb_project_owner = undef;
+sub git_get_project_list_from_file {
+
+	return if (defined $gitweb_project_owner);
+
+	$gitweb_project_owner = {};
+	# read from file (url-encoded):
+	# 'git%2Fgit.git Linus+Torvalds'
+	# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
+	# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
+	if (-f $projects_list) {
+		open(my $fd, '<', $projects_list);
+		while (my $line = <$fd>) {
+			chomp $line;
+			my ($pr, $ow) = split ' ', $line;
+			$pr = unescape($pr);
+			$ow = unescape($ow);
+			$gitweb_project_owner->{$pr} = to_utf8($ow);
+		}
+		close $fd;
+	}
+}
+
+sub git_get_project_owner {
+	my $project = shift;
+	my $owner;
+
+	return undef unless $project;
+	$git_dir = "$projectroot/$project";
+
+	if (!defined $gitweb_project_owner) {
+		git_get_project_list_from_file();
+	}
+
+	if (exists $gitweb_project_owner->{$project}) {
+		$owner = $gitweb_project_owner->{$project};
+	}
+	if (!defined $owner){
+		$owner = git_get_project_config('owner');
+	}
+	if (!defined $owner) {
+		$owner = get_file_owner("$git_dir");
+	}
+
+	return $owner;
+}
+
+sub get_file_owner {
+	my $path = shift;
+
+	my ($dev, $ino, $mode, $nlink, $st_uid, $st_gid, $rdev, $size) = stat($path);
+	my ($name, $passwd, $uid, $gid, $quota, $comment, $gcos, $dir, $shell) = getpwuid($st_uid);
+	if (!defined $gcos) {
+		return undef;
+	}
+	my $owner = $gcos;
+	$owner =~ s/[,;].*$//;
+	return to_utf8($owner);
+}
+
+sub project_in_list {
+	my $project = shift;
+	my @list = git_get_projects_list();
+	return @list && scalar(grep { $_->{'path'} eq $project } @list);
+}
+
+1;
-- 
1.7.1.454.g276eb9.dirty
