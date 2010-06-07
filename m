From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [RFC/PATCH 4/4] gitweb: Create Gitweb::HTML::String module
Date: Tue,  8 Jun 2010 02:20:44 +0530
Message-ID: <1275943844-24991-4-git-send-email-pavan.sss1991@gmail.com>
References: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Mon Jun 07 22:51:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLjIF-0007CR-HL
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 22:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938Ab0FGUvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 16:51:31 -0400
Received: from mail-pz0-f185.google.com ([209.85.222.185]:35699 "EHLO
	mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715Ab0FGUva (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 16:51:30 -0400
Received: by pzk15 with SMTP id 15so1304pzk.15
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 13:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=U81Dy4AwUHCKQpqKH7/1SXdeZIEm2sxKrzRpyEpPsgo=;
        b=txNJeTPo7q0JobT3y4T/8g+Z+xOT2Ax/GId16x0dxHZoK5JXZQuvw/LenNhyU529OA
         kzKV4G8wYtboyIoB34eMSecu3SqricJvdyZGf1gKE3q++VL4eKJQ7x7jVE0+1ZeTnSYD
         wrAqPVJcESXW0F92XdnSWy1GULDH633KaqECo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=to7tj5buKHb4tLx2BIwHyU4CPhfqUz+NWCTnTsNqO5B1PmjlxhiB7k+BX8Mevy9YG7
         27RbBBj4y/2FTs+wT4vMEbvxt44SFvP6TgvDZNXMXqwT5i7PkdJ2t4OVuqCbLJSo+0kj
         4ekFX8wEEf66lwl8qJBGAmRzCTBoc/qOKGN94=
Received: by 10.141.14.4 with SMTP id r4mr12393250rvi.171.1275943889458;
        Mon, 07 Jun 2010 13:51:29 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id o38sm1180853rvp.2.2010.06.07.13.51.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 13:51:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.454.ga8c50c
In-Reply-To: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148627>

Create Gitweb::HTML::String module in 'gitweb/lib/Gitweb/HTML/String.pm'
to store all the subs involving string manipulation and those returning
short strings regarding gitweb.perl.

Subroutines moved:
	chop_str
	chop_and_escape_str
	S_ISGITLINK
	mode_str
	file_type
	file_type_long
	age_class
	age_string

Import Gitweb::HTML:String into Gitweb::HTML module.

Updare gitweb/Makefile to install this module alongside gitweb.

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/Makefile                  |    1 +
 gitweb/gitweb.perl               |  213 ----------------------------------
 gitweb/lib/Gitweb/HTML.pm        |    4 +-
 gitweb/lib/Gitweb/HTML/String.pm |  232 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 236 insertions(+), 214 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/HTML/String.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 5e44ace..9b4b718 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -119,6 +119,7 @@ GITWEB_LIB_GITWEB += lib/Gitweb/Git.pm
 GITWEB_LIB_GITWEB += lib/Gitweb/HTML.pm
 # Files: gitweb/lib/Gitweb/HTML
 GITWEB_LIB_GITWEB_HTML += lib/Gitweb/HTML/Link.pm
+GITWEB_LIB_GITWEB_HTML += lib/Gitweb/HTML/String.pm
 
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 12646c0..f2fdcae 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -582,219 +582,6 @@ sub project_in_list {
 }
 
 ## ----------------------------------------------------------------------
-## HTML aware string manipulation
-
-# Try to chop given string on a word boundary between position
-# $len and $len+$add_len. If there is no word boundary there,
-# chop at $len+$add_len. Do not chop if chopped part plus ellipsis
-# (marking chopped part) would be longer than given string.
-sub chop_str {
-	my $str = shift;
-	my $len = shift;
-	my $add_len = shift || 10;
-	my $where = shift || 'right'; # 'left' | 'center' | 'right'
-
-	# Make sure perl knows it is utf8 encoded so we don't
-	# cut in the middle of a utf8 multibyte char.
-	$str = to_utf8($str);
-
-	# allow only $len chars, but don't cut a word if it would fit in $add_len
-	# if it doesn't fit, cut it if it's still longer than the dots we would add
-	# remove chopped character entities entirely
-
-	# when chopping in the middle, distribute $len into left and right part
-	# return early if chopping wouldn't make string shorter
-	if ($where eq 'center') {
-		return $str if ($len + 5 >= length($str)); # filler is length 5
-		$len = int($len/2);
-	} else {
-		return $str if ($len + 4 >= length($str)); # filler is length 4
-	}
-
-	# regexps: ending and beginning with word part up to $add_len
-	my $endre = qr/.{$len}\w{0,$add_len}/;
-	my $begre = qr/\w{0,$add_len}.{$len}/;
-
-	if ($where eq 'left') {
-		$str =~ m/^(.*?)($begre)$/;
-		my ($lead, $body) = ($1, $2);
-		if (length($lead) > 4) {
-			$lead = " ...";
-		}
-		return "$lead$body";
-
-	} elsif ($where eq 'center') {
-		$str =~ m/^($endre)(.*)$/;
-		my ($left, $str)  = ($1, $2);
-		$str =~ m/^(.*?)($begre)$/;
-		my ($mid, $right) = ($1, $2);
-		if (length($mid) > 5) {
-			$mid = " ... ";
-		}
-		return "$left$mid$right";
-
-	} else {
-		$str =~ m/^($endre)(.*)$/;
-		my $body = $1;
-		my $tail = $2;
-		if (length($tail) > 4) {
-			$tail = "... ";
-		}
-		return "$body$tail";
-	}
-}
-
-# takes the same arguments as chop_str, but also wraps a <span> around the
-# result with a title attribute if it does get chopped. Additionally, the
-# string is HTML-escaped.
-sub chop_and_escape_str {
-	my ($str) = @_;
-
-	my $chopped = chop_str(@_);
-	if ($chopped eq $str) {
-		return esc_html($chopped);
-	} else {
-		$str =~ s/[[:cntrl:]]/?/g;
-		return $cgi->span({-title=>$str}, esc_html($chopped));
-	}
-}
-
-## ----------------------------------------------------------------------
-## functions returning short strings
-
-# CSS class for given age value (in seconds)
-sub age_class {
-	my $age = shift;
-
-	if (!defined $age) {
-		return "noage";
-	} elsif ($age < 60*60*2) {
-		return "age0";
-	} elsif ($age < 60*60*24*2) {
-		return "age1";
-	} else {
-		return "age2";
-	}
-}
-
-# convert age in seconds to "nn units ago" string
-sub age_string {
-	my $age = shift;
-	my $age_str;
-
-	if ($age > 60*60*24*365*2) {
-		$age_str = (int $age/60/60/24/365);
-		$age_str .= " years ago";
-	} elsif ($age > 60*60*24*(365/12)*2) {
-		$age_str = int $age/60/60/24/(365/12);
-		$age_str .= " months ago";
-	} elsif ($age > 60*60*24*7*2) {
-		$age_str = int $age/60/60/24/7;
-		$age_str .= " weeks ago";
-	} elsif ($age > 60*60*24*2) {
-		$age_str = int $age/60/60/24;
-		$age_str .= " days ago";
-	} elsif ($age > 60*60*2) {
-		$age_str = int $age/60/60;
-		$age_str .= " hours ago";
-	} elsif ($age > 60*2) {
-		$age_str = int $age/60;
-		$age_str .= " min ago";
-	} elsif ($age > 2) {
-		$age_str = int $age;
-		$age_str .= " sec ago";
-	} else {
-		$age_str .= " right now";
-	}
-	return $age_str;
-}
-
-use constant {
-	S_IFINVALID => 0030000,
-	S_IFGITLINK => 0160000,
-};
-
-# submodule/subproject, a commit object reference
-sub S_ISGITLINK {
-	my $mode = shift;
-
-	return (($mode & S_IFMT) == S_IFGITLINK)
-}
-
-# convert file mode in octal to symbolic file mode string
-sub mode_str {
-	my $mode = oct shift;
-
-	if (S_ISGITLINK($mode)) {
-		return 'm---------';
-	} elsif (S_ISDIR($mode & S_IFMT)) {
-		return 'drwxr-xr-x';
-	} elsif (S_ISLNK($mode)) {
-		return 'lrwxrwxrwx';
-	} elsif (S_ISREG($mode)) {
-		# git cares only about the executable bit
-		if ($mode & S_IXUSR) {
-			return '-rwxr-xr-x';
-		} else {
-			return '-rw-r--r--';
-		};
-	} else {
-		return '----------';
-	}
-}
-
-# convert file mode in octal to file type string
-sub file_type {
-	my $mode = shift;
-
-	if ($mode !~ m/^[0-7]+$/) {
-		return $mode;
-	} else {
-		$mode = oct $mode;
-	}
-
-	if (S_ISGITLINK($mode)) {
-		return "submodule";
-	} elsif (S_ISDIR($mode & S_IFMT)) {
-		return "directory";
-	} elsif (S_ISLNK($mode)) {
-		return "symlink";
-	} elsif (S_ISREG($mode)) {
-		return "file";
-	} else {
-		return "unknown";
-	}
-}
-
-# convert file mode in octal to file type description string
-sub file_type_long {
-	my $mode = shift;
-
-	if ($mode !~ m/^[0-7]+$/) {
-		return $mode;
-	} else {
-		$mode = oct $mode;
-	}
-
-	if (S_ISGITLINK($mode)) {
-		return "submodule";
-	} elsif (S_ISDIR($mode & S_IFMT)) {
-		return "directory";
-	} elsif (S_ISLNK($mode)) {
-		return "symlink";
-	} elsif (S_ISREG($mode)) {
-		if ($mode & S_IXUSR) {
-			return "executable";
-		} else {
-			return "file";
-		};
-	} else {
-		return "unknown";
-	}
-}
-
-
-## ----------------------------------------------------------------------
 ## functions returning short HTML fragments, or transforming HTML fragments
 ## which don't belong to other sections
 
diff --git a/gitweb/lib/Gitweb/HTML.pm b/gitweb/lib/Gitweb/HTML.pm
index a0a1606..49a3b54 100644
--- a/gitweb/lib/Gitweb/HTML.pm
+++ b/gitweb/lib/Gitweb/HTML.pm
@@ -10,8 +10,10 @@ use strict;
 use warnings;
 use Exporter qw(import);
 
-our @EXPORT = qw(href);
+our @EXPORT = qw(href chop_str chop_and_escape_str age_class age_string mode_str
+                 file_type file_type_long);
 
 use Gitweb::HTML::Link;
+use Gitweb::HTML::String;
 
 1;
diff --git a/gitweb/lib/Gitweb/HTML/String.pm b/gitweb/lib/Gitweb/HTML/String.pm
new file mode 100644
index 0000000..a8f6417
--- /dev/null
+++ b/gitweb/lib/Gitweb/HTML/String.pm
@@ -0,0 +1,232 @@
+#!/usr/bin/perl
+#
+# Gitweb::HTML::String -- gitweb's string manipulation & short string package
+#
+# This program is licensed under the GPLv2
+
+package Gitweb::HTML::String;
+
+use strict;
+use warnings;
+use Exporter qw(import);
+
+our @EXPORT = qw(chop_str chop_and_escape_str age_class age_string mode_str
+                 file_type file_type_long);
+
+use Fcntl ':mode';
+use Gitweb::Request qw($cgi);
+use Gitweb::Escape qw(to_utf8 esc_html);
+
+## ----------------------------------------------------------------------
+## HTML aware string manipulation
+
+# Try to chop given string on a word boundary between position
+# $len and $len+$add_len. If there is no word boundary there,
+# chop at $len+$add_len. Do not chop if chopped part plus ellipsis
+# (marking chopped part) would be longer than given string.
+sub chop_str {
+	my $str = shift;
+	my $len = shift;
+	my $add_len = shift || 10;
+	my $where = shift || 'right'; # 'left' | 'center' | 'right'
+
+	# Make sure perl knows it is utf8 encoded so we don't
+	# cut in the middle of a utf8 multibyte char.
+	$str = to_utf8($str);
+
+	# allow only $len chars, but don't cut a word if it would fit in $add_len
+	# if it doesn't fit, cut it if it's still longer than the dots we would add
+	# remove chopped character entities entirely
+
+	# when chopping in the middle, distribute $len into left and right part
+	# return early if chopping wouldn't make string shorter
+	if ($where eq 'center') {
+		return $str if ($len + 5 >= length($str)); # filler is length 5
+		$len = int($len/2);
+	} else {
+		return $str if ($len + 4 >= length($str)); # filler is length 4
+	}
+
+	# regexps: ending and beginning with word part up to $add_len
+	my $endre = qr/.{$len}\w{0,$add_len}/;
+	my $begre = qr/\w{0,$add_len}.{$len}/;
+
+	if ($where eq 'left') {
+		$str =~ m/^(.*?)($begre)$/;
+		my ($lead, $body) = ($1, $2);
+		if (length($lead) > 4) {
+			$lead = " ...";
+		}
+		return "$lead$body";
+
+	} elsif ($where eq 'center') {
+		$str =~ m/^($endre)(.*)$/;
+		my ($left, $str)  = ($1, $2);
+		$str =~ m/^(.*?)($begre)$/;
+		my ($mid, $right) = ($1, $2);
+		if (length($mid) > 5) {
+			$mid = " ... ";
+		}
+		return "$left$mid$right";
+
+	} else {
+		$str =~ m/^($endre)(.*)$/;
+		my $body = $1;
+		my $tail = $2;
+		if (length($tail) > 4) {
+			$tail = "... ";
+		}
+		return "$body$tail";
+	}
+}
+
+# takes the same arguments as chop_str, but also wraps a <span> around the
+# result with a title attribute if it does get chopped. Additionally, the
+# string is HTML-escaped.
+sub chop_and_escape_str {
+	my ($str) = @_;
+
+	my $chopped = chop_str(@_);
+	if ($chopped eq $str) {
+		return esc_html($chopped);
+	} else {
+		$str =~ s/[[:cntrl:]]/?/g;
+		return $cgi->span({-title=>$str}, esc_html($chopped));
+	}
+}
+
+## ----------------------------------------------------------------------
+## functions returning short strings
+
+# CSS class for given age value (in seconds)
+sub age_class {
+	my $age = shift;
+
+	if (!defined $age) {
+		return "noage";
+	} elsif ($age < 60*60*2) {
+		return "age0";
+	} elsif ($age < 60*60*24*2) {
+		return "age1";
+	} else {
+		return "age2";
+	}
+}
+
+# convert age in seconds to "nn units ago" string
+sub age_string {
+	my $age = shift;
+	my $age_str;
+
+	if ($age > 60*60*24*365*2) {
+		$age_str = (int $age/60/60/24/365);
+		$age_str .= " years ago";
+	} elsif ($age > 60*60*24*(365/12)*2) {
+		$age_str = int $age/60/60/24/(365/12);
+		$age_str .= " months ago";
+	} elsif ($age > 60*60*24*7*2) {
+		$age_str = int $age/60/60/24/7;
+		$age_str .= " weeks ago";
+	} elsif ($age > 60*60*24*2) {
+		$age_str = int $age/60/60/24;
+		$age_str .= " days ago";
+	} elsif ($age > 60*60*2) {
+		$age_str = int $age/60/60;
+		$age_str .= " hours ago";
+	} elsif ($age > 60*2) {
+		$age_str = int $age/60;
+		$age_str .= " min ago";
+	} elsif ($age > 2) {
+		$age_str = int $age;
+		$age_str .= " sec ago";
+	} else {
+		$age_str .= " right now";
+	}
+	return $age_str;
+}
+
+use constant {
+	S_IFINVALID => 0030000,
+	S_IFGITLINK => 0160000,
+};
+
+# submodule/subproject, a commit object reference
+sub S_ISGITLINK {
+	my $mode = shift;
+
+	return (($mode & S_IFMT) == S_IFGITLINK)
+}
+
+# convert file mode in octal to symbolic file mode string
+sub mode_str {
+	my $mode = oct shift;
+
+	if (S_ISGITLINK($mode)) {
+		return 'm---------';
+	} elsif (S_ISDIR($mode & S_IFMT)) {
+		return 'drwxr-xr-x';
+	} elsif (S_ISLNK($mode)) {
+		return 'lrwxrwxrwx';
+	} elsif (S_ISREG($mode)) {
+		# git cares only about the executable bit
+		if ($mode & S_IXUSR) {
+			return '-rwxr-xr-x';
+		} else {
+			return '-rw-r--r--';
+		};
+	} else {
+		return '----------';
+	}
+}
+
+# convert file mode in octal to file type string
+sub file_type {
+	my $mode = shift;
+
+	if ($mode !~ m/^[0-7]+$/) {
+		return $mode;
+	} else {
+		$mode = oct $mode;
+	}
+
+	if (S_ISGITLINK($mode)) {
+		return "submodule";
+	} elsif (S_ISDIR($mode & S_IFMT)) {
+		return "directory";
+	} elsif (S_ISLNK($mode)) {
+		return "symlink";
+	} elsif (S_ISREG($mode)) {
+		return "file";
+	} else {
+		return "unknown";
+	}
+}
+
+# convert file mode in octal to file type description string
+sub file_type_long {
+	my $mode = shift;
+
+	if ($mode !~ m/^[0-7]+$/) {
+		return $mode;
+	} else {
+		$mode = oct $mode;
+	}
+
+	if (S_ISGITLINK($mode)) {
+		return "submodule";
+	} elsif (S_ISDIR($mode & S_IFMT)) {
+		return "directory";
+	} elsif (S_ISLNK($mode)) {
+		return "symlink";
+	} elsif (S_ISREG($mode)) {
+		if ($mode & S_IXUSR) {
+			return "executable";
+		} else {
+			return "file";
+		};
+	} else {
+		return "unknown";
+	}
+}
+
+1;
-- 
1.7.1.454.ga8c50c
