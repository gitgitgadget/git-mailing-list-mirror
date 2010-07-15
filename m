From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCHv2 GSOC 06/11] gitweb: Create Gitweb::Escape module
Date: Thu, 15 Jul 2010 12:59:06 +0530
Message-ID: <1279178951-23712-7-git-send-email-pavan.sss1991@gmail.com>
References: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Thu Jul 15 09:30:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZItU-0003HF-Ra
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 09:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548Ab0GOH3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 03:29:45 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:58322 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932531Ab0GOH3m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 03:29:42 -0400
Received: by mail-px0-f174.google.com with SMTP id 14so278723pxi.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 00:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Kvuvfb6jEFlo7vNEtRM1ylCHrVUa1ciw5zJEwquXIqI=;
        b=S4VooctFMpBY/YJmWk6ASm61KqK/U2PlkKTaYRGOcghYxSu+0acperkirGAhSFrFp7
         LBJpTXdfTiAbd9KGKOUMuE7+Hbhgn/S9kHECeB7SSusN+DUcTxilWbVCEMNudi9O4CyP
         H45y7TWbf+kagm2zZq9LKaPu7CEPBZkY+Xpo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=A0u5UXyHkcyofhW555pnOCJjYqHKMFXH0okMEy6X14wZ5xL5DO3O/o41sofniRYNGd
         ZFhNc/ciaIjd21NYGQ+j4jZgC28kAPKhcF/+i5f5iy2MtH8icfAPUzGVvmqS1mgGuG+W
         ER5fnjURyrFlGnuZLLsF+qzRbX/V9utTsByWw=
Received: by 10.142.133.20 with SMTP id g20mr22791874wfd.3.1279178981993;
        Thu, 15 Jul 2010 00:29:41 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id l29sm8484428rvb.7.2010.07.15.00.29.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 00:29:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.455.g8f441
In-Reply-To: <1279178951-23712-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151054>

Create a Gitweb::Escape module in 'gitweb/lib/Gitweb/Escape.pm'
to store all the quoting/unquoting and escaping subroutines
regarding the gitweb.perl script.

This module imports $fallback_encoding variable from
Gitweb::Config module to use it in sub 'to_utf8'

Subroutines moved:
	to_utf8
	esc_param
	esc_url
	esc_html
	esc_path
	quot_cec
	quot_upr
	untabify

Update gitweb/Makefile to install Gitweb::Escape module alongside gitweb

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/Makefile             |    1 +
 gitweb/gitweb.perl          |  120 +-------------------------------------
 gitweb/lib/Gitweb/Escape.pm |  138 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 119 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/Escape.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index cd36dc6..c145ebd 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -115,6 +115,7 @@ GITWEB_FILES += static/git-logo.png static/git-favicon.png
 GITWEB_MODULES += lib/Gitweb/Git.pm
 GITWEB_MODULES += lib/Gitweb/Config.pm
 GITWEB_MODULES += lib/Gitweb/Request.pm
+GITWEB_MODULES += lib/Gitweb/Escape.pm
 
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 90cb6eb..ed64910 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -20,7 +20,6 @@ use lib __DIR__ . '/lib';
 use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser set_message);
-use Encode;
 use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
@@ -30,6 +29,7 @@ binmode STDOUT, ':utf8';
 use Gitweb::Git;
 use Gitweb::Config;
 use Gitweb::Request;
+use Gitweb::Escape;
 
 BEGIN {
 	CGI->compile() if $ENV{'MOD_PERL'};
@@ -745,110 +745,6 @@ sub validate_refname {
 	return $input;
 }
 
-# decode sequences of octets in utf8 into Perl's internal form,
-# which is utf-8 with utf8 flag set if needed.  gitweb writes out
-# in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning
-sub to_utf8 {
-	my $str = shift;
-	return undef unless defined $str;
-	if (utf8::valid($str)) {
-		utf8::decode($str);
-		return $str;
-	} else {
-		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
-	}
-}
-
-# quote unsafe chars, but keep the slash, even when it's not
-# correct, but quoted slashes look too horrible in bookmarks
-sub esc_param {
-	my $str = shift;
-	return undef unless defined $str;
-	$str =~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
-	$str =~ s/ /\+/g;
-	return $str;
-}
-
-# quote unsafe chars in whole URL, so some charactrs cannot be quoted
-sub esc_url {
-	my $str = shift;
-	return undef unless defined $str;
-	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&= ]+)/CGI::escape($1)/eg;
-	$str =~ s/ /\+/g;
-	return $str;
-}
-
-# replace invalid utf8 character with SUBSTITUTION sequence
-sub esc_html {
-	my $str = shift;
-	my %opts = @_;
-
-	return undef unless defined $str;
-
-	$str = to_utf8($str);
-	$str = $cgi->escapeHTML($str);
-	if ($opts{'-nbsp'}) {
-		$str =~ s/ /&nbsp;/g;
-	}
-	$str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
-	return $str;
-}
-
-# quote control characters and escape filename to HTML
-sub esc_path {
-	my $str = shift;
-	my %opts = @_;
-
-	return undef unless defined $str;
-
-	$str = to_utf8($str);
-	$str = $cgi->escapeHTML($str);
-	if ($opts{'-nbsp'}) {
-		$str =~ s/ /&nbsp;/g;
-	}
-	$str =~ s|([[:cntrl:]])|quot_cec($1)|eg;
-	return $str;
-}
-
-# Make control characters "printable", using character escape codes (CEC)
-sub quot_cec {
-	my $cntrl = shift;
-	my %opts = @_;
-	my %es = ( # character escape codes, aka escape sequences
-		"\t" => '\t',   # tab            (HT)
-		"\n" => '\n',   # line feed      (LF)
-		"\r" => '\r',   # carrige return (CR)
-		"\f" => '\f',   # form feed      (FF)
-		"\b" => '\b',   # backspace      (BS)
-		"\a" => '\a',   # alarm (bell)   (BEL)
-		"\e" => '\e',   # escape         (ESC)
-		"\013" => '\v', # vertical tab   (VT)
-		"\000" => '\0', # nul character  (NUL)
-	);
-	my $chr = ( (exists $es{$cntrl})
-		    ? $es{$cntrl}
-		    : sprintf('\%2x', ord($cntrl)) );
-	if ($opts{-nohtml}) {
-		return $chr;
-	} else {
-		return "<span class=\"cntrl\">$chr</span>";
-	}
-}
-
-# Alternatively use unicode control pictures codepoints,
-# Unicode "printable representation" (PR)
-sub quot_upr {
-	my $cntrl = shift;
-	my %opts = @_;
-
-	my $chr = sprintf('&#%04d;', 0x2400+ord($cntrl));
-	if ($opts{-nohtml}) {
-		return $chr;
-	} else {
-		return "<span class=\"cntrl\">$chr</span>";
-	}
-}
-
 # git may return quoted and escaped filenames
 sub unquote {
 	my $str = shift;
@@ -885,20 +781,6 @@ sub unquote {
 	return $str;
 }
 
-# escape tabs (convert tabs to spaces)
-sub untabify {
-	my $line = shift;
-
-	while ((my $pos = index($line, "\t")) != -1) {
-		if (my $count = (8 - ($pos % 8))) {
-			my $spaces = ' ' x $count;
-			$line =~ s/\t/$spaces/;
-		}
-	}
-
-	return $line;
-}
-
 sub project_in_list {
 	my $project = shift;
 	my @list = git_get_projects_list();
diff --git a/gitweb/lib/Gitweb/Escape.pm b/gitweb/lib/Gitweb/Escape.pm
new file mode 100644
index 0000000..3d81682
--- /dev/null
+++ b/gitweb/lib/Gitweb/Escape.pm
@@ -0,0 +1,138 @@
+#!/usr/bin/perl
+#
+# Gitweb::Escape -- gitweb's quoting/unquoting, escaping package
+#
+# This program is licensed under the GPLv2
+
+package Gitweb::Escape;
+
+use strict;
+use warnings;
+use Exporter qw(import);
+
+our @EXPORT = qw(to_utf8 esc_param esc_url esc_html esc_path quot_cec quot_upr untabify);
+
+use Encode;
+use CGI;
+
+use Gitweb::Config qw($fallback_encoding);
+
+# decode sequences of octets in utf8 into Perl's internal form,
+# which is utf-8 with utf8 flag set if needed.  gitweb writes out
+# in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning of gitweb.perl
+sub to_utf8 {
+	my $str = shift;
+	return undef unless defined $str;
+	if (utf8::valid($str)) {
+		utf8::decode($str);
+		return $str;
+	} else {
+		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
+	}
+}
+
+# quote unsafe chars, but keep the slash, even when it's not
+# correct, but quoted slashes look too horrible in bookmarks
+sub esc_param {
+	my $str = shift;
+	return undef unless defined $str;
+	$str =~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
+	$str =~ s/ /\+/g;
+	return $str;
+}
+
+# quote unsafe chars in whole URL, so some charactrs cannot be quoted
+sub esc_url {
+	my $str = shift;
+	return undef unless defined $str;
+	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&= ]+)/CGI::escape($1)/eg;
+	$str =~ s/ /\+/g;
+	return $str;
+}
+
+# replace invalid utf8 character with SUBSTITUTION sequence
+sub esc_html {
+	my $str = shift;
+	my %opts = @_;
+
+	return undef unless defined $str;
+
+	$str = to_utf8($str);
+	$str = CGI::escapeHTML($str);
+	if ($opts{'-nbsp'}) {
+		$str =~ s/ /&nbsp;/g;
+	}
+	$str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
+	return $str;
+}
+
+# quote control characters and escape filename to HTML
+sub esc_path {
+	my $str = shift;
+	my %opts = @_;
+
+	return undef unless defined $str;
+
+	$str = to_utf8($str);
+	$str = CGI::escapeHTML($str);
+	if ($opts{'-nbsp'}) {
+		$str =~ s/ /&nbsp;/g;
+	}
+	$str =~ s|([[:cntrl:]])|quot_cec($1)|eg;
+	return $str;
+}
+
+# Make control characters "printable", using character escape codes (CEC)
+sub quot_cec {
+	my $cntrl = shift;
+	my %opts = @_;
+	my %es = ( # character escape codes, aka escape sequences
+		"\t" => '\t',   # tab            (HT)
+		"\n" => '\n',   # line feed      (LF)
+		"\r" => '\r',   # carrige return (CR)
+		"\f" => '\f',   # form feed      (FF)
+		"\b" => '\b',   # backspace      (BS)
+		"\a" => '\a',   # alarm (bell)   (BEL)
+		"\e" => '\e',   # escape         (ESC)
+		"\013" => '\v', # vertical tab   (VT)
+		"\000" => '\0', # nul character  (NUL)
+	);
+	my $chr = ( (exists $es{$cntrl})
+		    ? $es{$cntrl}
+		    : sprintf('\%2x', ord($cntrl)) );
+	if ($opts{-nohtml}) {
+		return $chr;
+	} else {
+		return "<span class=\"cntrl\">$chr</span>";
+	}
+}
+
+# Alternatively use unicode control pictures codepoints,
+# Unicode "printable representation" (PR)
+sub quot_upr {
+	my $cntrl = shift;
+	my %opts = @_;
+
+	my $chr = sprintf('&#%04d;', 0x2400+ord($cntrl));
+	if ($opts{-nohtml}) {
+		return $chr;
+	} else {
+		return "<span class=\"cntrl\">$chr</span>";
+	}
+}
+
+# escape tabs (convert tabs to spaces)
+sub untabify {
+	my $line = shift;
+
+	while ((my $pos = index($line, "\t")) != -1) {
+		if (my $count = (8 - ($pos % 8))) {
+			my $spaces = ' ' x $count;
+			$line =~ s/\t/$spaces/;
+		}
+	}
+
+	return $line;
+}
+
+1;
-- 
1.7.1.455.g8f441
