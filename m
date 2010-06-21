From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH 06/11 GSoC] gitweb: Create Gitweb::Escape module
Date: Tue, 22 Jun 2010 03:30:42 +0530
Message-ID: <1277157648-6029-7-git-send-email-pavan.sss1991@gmail.com>
References: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Tue Jun 22 00:03:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQp57-00083O-4z
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 00:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932970Ab0FUWCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jun 2010 18:02:46 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61837 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932797Ab0FUWCo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jun 2010 18:02:44 -0400
Received: by mail-pw0-f46.google.com with SMTP id 8so528092pwj.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 15:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2Q/FyZcxtO3g9pXl9EuETbXuP1tFXR3hY7JfXGnFgp8=;
        b=DgSliZimVLcykaqD9OU+VpHCDGaL76qewGph5vxHm+g9Bka2Bdo+MPMsD0WdDHgWcZ
         u7s0fF777xEObM5ZZ+4yxe3acX6mKm7KluVH4amqu/l1WK2PC7nP2r1bZ+xE8lqjYCEA
         K6MyCQZ8MkjtGOwGLOxGSyywlvkWtY+8Qt/B8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WJzcMQ9NF/Gu93m4X927qxqlnfWQh/ZSbAgitGWw6UQCDO2mY9alEdSKTZACQBWdu6
         w01p626ytMN/AES908DoGM35ibgMwVXkh6YZRpV+D2nL7ZKlIWafigOnQoAu6iWsk/Ts
         SQ6JeJ1BLn4+BABWzqi2fYv/T6h7ToDeRvrS8=
Received: by 10.142.10.8 with SMTP id 8mr4084410wfj.56.1277157763970;
        Mon, 21 Jun 2010 15:02:43 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.132])
        by mx.google.com with ESMTPS id y27sm525703wfi.17.2010.06.21.15.02.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jun 2010 15:02:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.454.g6bbe9.dirty
In-Reply-To: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149447>

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
	unquote
	untabify

Update gitweb/Makefile to install Gitweb::Escape module alongside gitweb

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 gitweb/Makefile             |    1 +
 gitweb/gitweb.perl          |  156 +--------------------------------------
 gitweb/lib/Gitweb/Escape.pm |  175 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+), 155 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/Escape.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 8c42724..c77188d 100644
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
index db2f682..87281d0 100755
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
@@ -712,160 +712,6 @@ sub validate_project {
 	}
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
-# git may return quoted and escaped filenames
-sub unquote {
-	my $str = shift;
-
-	sub unq {
-		my $seq = shift;
-		my %es = ( # character escape codes, aka escape sequences
-			't' => "\t",   # tab            (HT, TAB)
-			'n' => "\n",   # newline        (NL)
-			'r' => "\r",   # return         (CR)
-			'f' => "\f",   # form feed      (FF)
-			'b' => "\b",   # backspace      (BS)
-			'a' => "\a",   # alarm (bell)   (BEL)
-			'e' => "\e",   # escape         (ESC)
-			'v' => "\013", # vertical tab   (VT)
-		);
-
-		if ($seq =~ m/^[0-7]{1,3}$/) {
-			# octal char sequence
-			return chr(oct($seq));
-		} elsif (exists $es{$seq}) {
-			# C escape sequence, aka character escape code
-			return $es{$seq};
-		}
-		# quoted ordinary character
-		return $seq;
-	}
-
-	if ($str =~ m/^"(.*)"$/) {
-		# needs unquoting
-		$str = $1;
-		$str =~ s/\\([^0-7]|[0-7]{1,3})/unq($1)/eg;
-	}
-	return $str;
-}
-
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
index 0000000..d0ac715
--- /dev/null
+++ b/gitweb/lib/Gitweb/Escape.pm
@@ -0,0 +1,175 @@
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
+our @EXPORT = qw(to_utf8 esc_param esc_url esc_html esc_path quot_cec quot_upr unquote untabify);
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
+	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&=])/sprintf("%%%02X", ord($1))/eg;
+	$str =~ s/\+/%2B/g;
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
+# git may return quoted and escaped filenames
+sub unquote {
+	my $str = shift;
+
+	sub unq {
+		my $seq = shift;
+		my %es = ( # character escape codes, aka escape sequences
+			't' => "\t",   # tab            (HT, TAB)
+			'n' => "\n",   # newline        (NL)
+			'r' => "\r",   # return         (CR)
+			'f' => "\f",   # form feed      (FF)
+			'b' => "\b",   # backspace      (BS)
+			'a' => "\a",   # alarm (bell)   (BEL)
+			'e' => "\e",   # escape         (ESC)
+			'v' => "\013", # vertical tab   (VT)
+		);
+
+		if ($seq =~ m/^[0-7]{1,3}$/) {
+			# octal char sequence
+			return chr(oct($seq));
+		} elsif (exists $es{$seq}) {
+			# C escape sequence, aka character escape code
+			return $es{$seq};
+		}
+		# quoted ordinary character
+		return $seq;
+	}
+
+	if ($str =~ m/^"(.*)"$/) {
+		# needs unquoting
+		$str = $1;
+		$str =~ s/\\([^0-7]|[0-7]{1,3})/unq($1)/eg;
+	}
+	return $str;
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
1.7.1.454.g276eb9.dirty
