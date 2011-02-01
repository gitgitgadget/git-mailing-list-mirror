From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (proof of concept) 2/2] gitweb: Create Gitweb::Util module
Date: Tue,  1 Feb 2011 17:50:16 +0100
Message-ID: <1296579016-13356-5-git-send-email-jnareb@gmail.com>
References: <1296579016-13356-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 01 17:51:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkJRa-0007ZV-4g
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 17:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482Ab1BAQux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 11:50:53 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41376 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335Ab1BAQuw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 11:50:52 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so6510232bwz.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 08:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=1GkH/ul9UH99SGKC766zCf9csa/u0bZbo2yJknpz0EY=;
        b=E5KnpLxP+qv77t5m2wi+p0BT4VYQFmwTQjXpcvYtN67YjT+KUs28bQSiP0yvk7HABh
         YIXE+SmgvpQjeyMXdHNYvwhni5KFnHAu0NmphcRrb0LHF45i++guHv+xaHcbKrrkshxn
         ljSLuoCim4HuV9ddZXHP553cZhAk6SYYoC73k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tvOrOThpuI2oF2vUJaTvMiwVxvF5Ce16JfsCQ8xrxDhgCpaZ9QpbETsGYnyxAKoBsO
         lPPKc0LMxrhYglzH8aSCz4yzxZooE1BJfNqpoDBqlblnuEBdg0BWUf/84CKFOoYkmhEY
         j9tDJP6ZtxOiNEeiiAMSch3J5EirCVNlA80b0=
Received: by 10.204.124.6 with SMTP id s6mr6776955bkr.51.1296579050428;
        Tue, 01 Feb 2011 08:50:50 -0800 (PST)
Received: from localhost.localdomain (abuz232.neoplus.adsl.tpnet.pl [83.8.197.232])
        by mx.google.com with ESMTPS id z18sm8881027bkf.20.2011.02.01.08.50.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 08:50:49 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1296579016-13356-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165828>

From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>

Create a Gitweb::Util module, which is meant to contain internal
utilities used by gitweb.  Currently it includes all the
quoting/unquoting and escaping subroutines that are used by the
gitweb.

Update gitweb/Makefile to install Gitweb::Util module alongside gitweb

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch serves two purposes.  First, it serves as test that earlier
"gitweb: Prepare for splitting gitweb" patch acually work correctly.

Second, it might be good starting point to splitting gitweb.
Refactoring well defined parts into separate modules (Perl packages)
could be a better, easier way than trying to come with good separation
(split) into modules upfront.  Such leisure approach to splitting
gitweb has more chance to be accepted.  Perhaps if such approach were
proposed on GSoC 2010, maybe "gitweb write" project wouldn't fail
midterm evaluations...


This module was taken out of unfinished GSoC 2010 project with
Pavan Kumar Sunkara as a student

  git://repo.or.cz/git/gsoc2010-gitweb.git

The module was renamed from Gitweb::Escape to Gitweb::Util.  Currently
the contents is the same, but it might change.

Code was updated to more modern codebase; since then esc_path_info and
esc_attr were added to gitweb - both of those are now in Gitweb::Util.

There were also required some changes and conflicts resolved due to
the fact that creating Gitweb::Util (formerly Gitweb::Escape) is no
longer in the middle of larger patch series.  In particular lack of
Gitweb::Config means that $fallback_encoding needed to be added to
Gitweb::Util module.

While at it do not export quot_cec and quot_upr helper subroutines by
default, but mark them exportable nevrtheless.

 gitweb/Makefile           |    3 +
 gitweb/gitweb.perl        |  140 +-----------------------------------
 gitweb/lib/Gitweb/Util.pm |  177 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+), 137 deletions(-)
 create mode 100644 gitweb/lib/Gitweb/Util.pm

diff --git a/gitweb/Makefile b/gitweb/Makefile
index abe9db8..9a4053b 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -114,6 +114,9 @@ endif
 
 GITWEB_FILES += static/git-logo.png static/git-favicon.png
 
+# Modules: Gitweb::*
+GITWEB_MODULES += Gitweb/Util.pm
+
 GITWEB_REPLACE = \
 	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	-e 's|++GIT_BINDIR++|$(bindir)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ea8ab56..e8d8589 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -23,11 +23,13 @@ use lib "++GITWEBLIBDIR++";
 use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser set_message);
-use Encode;
 use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
 use Time::HiRes qw(gettimeofday tv_interval);
+
+use Gitweb::Util;
+
 binmode STDOUT, ':utf8';
 
 our $t0 = [ gettimeofday() ];
@@ -1382,128 +1384,6 @@ sub validate_refname {
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
-# the quoting rules for path_info fragment are slightly different
-sub esc_path_info {
-	my $str = shift;
-	return undef unless defined $str;
-
-	# path_info doesn't treat '+' as space (specially), but '?' must be escaped
-	$str =~ s/([^A-Za-z0-9\-_.~();\/;:@&= +]+)/CGI::escape($1)/eg;
-
-	return $str;
-}
-
-# quote unsafe chars in whole URL, so some characters cannot be quoted
-sub esc_url {
-	my $str = shift;
-	return undef unless defined $str;
-	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&= ]+)/CGI::escape($1)/eg;
-	$str =~ s/ /\+/g;
-	return $str;
-}
-
-# quote unsafe characters in HTML attributes
-sub esc_attr {
-
-	# for XHTML conformance escaping '"' to '&quot;' is not enough
-	return esc_html(@_);
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
@@ -1540,20 +1420,6 @@ sub unquote {
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
diff --git a/gitweb/lib/Gitweb/Util.pm b/gitweb/lib/Gitweb/Util.pm
new file mode 100644
index 0000000..a213d3f
--- /dev/null
+++ b/gitweb/lib/Gitweb/Util.pm
@@ -0,0 +1,177 @@
+# Gitweb::Util -- Internal utilities used by gitweb (git web interface)
+#
+# This module is licensed under the GPLv2
+
+package Gitweb::Util;
+
+use strict;
+use warnings;
+use Exporter qw(import);
+
+our @EXPORT = qw(to_utf8
+                 esc_param esc_path_info esc_url
+                 esc_html esc_path esc_attr
+                 untabify
+                 $fallback_encoding);
+our @EXPORT_OK = qw(quot_cec quot_upr);
+
+use Encode;
+use CGI;
+
+# ......................................................................
+# Perl encoding (utf-8)
+
+# decode sequences of octets in utf8 into Perl's internal form,
+# which is utf-8 with utf8 flag set if needed.  gitweb writes out
+# in utf-8 thanks to "binmode STDOUT, ':utf8'" at beginning of gitweb.perl
+our $fallback_encoding = 'latin1';
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
+# ......................................................................
+# CGI encoding
+
+# quote unsafe chars, but keep the slash, even when it's not
+# correct, but quoted slashes look too horrible in bookmarks
+sub esc_param {
+	my $str = shift;
+	return undef unless defined $str;
+
+	$str =~ s/([^A-Za-z0-9\-_.~()\/:@ ]+)/CGI::escape($1)/eg;
+	$str =~ s/ /\+/g;
+
+	return $str;
+}
+
+# the quoting rules for path_info fragment are slightly different
+sub esc_path_info {
+	my $str = shift;
+	return undef unless defined $str;
+
+	# path_info doesn't treat '+' as space (specially), but '?' must be escaped
+	$str =~ s/([^A-Za-z0-9\-_.~();\/;:@&= +]+)/CGI::escape($1)/eg;
+
+	return $str;
+}
+
+# quote unsafe chars in whole URL, so some characters cannot be quoted
+sub esc_url {
+	my $str = shift;
+	return undef unless defined $str;
+
+	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&= ]+)/CGI::escape($1)/eg;
+	$str =~ s/ /\+/g;
+
+	return $str;
+}
+
+# ......................................................................
+# (X)HTML escaping
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
+# quote unsafe characters in HTML attributes
+sub esc_attr {
+
+	# for XHTML conformance escaping '"' to '&quot;' is not enough
+	return esc_html(@_);
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
+# ......................................................................
+# Other
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
+# ----------------------------------------------------------------------
+# Showing "unprintable" characters (utility functions)
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
+1;
-- 
1.7.3
