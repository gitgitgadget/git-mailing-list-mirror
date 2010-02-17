From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Syntax highlighting support
Date: Wed, 17 Feb 2010 22:43:36 +0100
Message-ID: <20100217212855.2014.49834.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 22:44:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhrh6-0001TW-Vr
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 22:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757062Ab0BQVoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 16:44:24 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:50673 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754848Ab0BQVoX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 16:44:23 -0500
Received: by fxm7 with SMTP id 7so9329804fxm.28
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 13:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=0Govcyv3pLz13qbUPiQIXBMmgG1FHxHDS0eKpqlpU7M=;
        b=sBaAlEnzVVL1bbNTraZC5HLt9ceUNEH3VBwT71Mqv3kyoG+GTY0AQ7n0IEOZTSWCBJ
         cqODo351TnBGoUFMMKmfZV3pi3JpsiO7Ya0GLRzVXY8MbToK06WTj+LDuLAWTUp6cjOv
         NarkdRQIyYyyOTUZLFrXPKfXs3zT3ByPDFmXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=BlZuz/olFRv+A43BD6BjKoJx67YoA7bGNpPlh+D20qcUb7KewPDU0pQcHJv1ZqmTVJ
         +cxPMLSW5XLO37QSRxAbHbXMShJtyVSRFNlvIa/GN6GKEcFjcHDRJO7Mgg2FaGtT94f9
         vYfU991hdA7mqGmAGn3t+xbHg1iuTkMsWYsV4=
Received: by 10.87.36.30 with SMTP id o30mr9882497fgj.33.1266443056172;
        Wed, 17 Feb 2010 13:44:16 -0800 (PST)
Received: from localhost.localdomain (abuz209.neoplus.adsl.tpnet.pl [83.8.197.209])
        by mx.google.com with ESMTPS id 15sm4310589fxm.6.2010.02.17.13.44.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Feb 2010 13:44:15 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o1HLhaTk002336;
	Wed, 17 Feb 2010 22:43:50 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140265>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It requires the 'highlight' program to do all the heavy-lifting:
http://www.andre-simon.de / http://wiki.andre-simon.de

This is loosely based on Daniel Svensson's and Sham Chukoury's work in
gitweb-xmms2.git (it cannot be cherry-picked, as gitweb-xmms2 first
forked wildly, then not contributed back, and then went stale).

[jn: cherry picked from bc1ed6aafd9ee4937559535c66c8bddf1864bec6
 in http://repo.or.cz/w/git/dscho.git, with a few changes]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is a RFC, because there exist other syntax highlighters that can
function as filter (take input from STDIN, and write result to STDOUT),
and have (X)HTML among supported output formats.  Beside 'highlight'
by Andre Simon, there is also 'source-highlight' (GNU Source Highlight),
and probably other programs.  

It would be nice to be able to configure which program to use.  The
question is if it should be configurable in per-repository basis, or
there should be global (per gitweb configuration) highlighter, while
highlighting can be turned on and off in per-repository basis.

The list of supported extensions is widened, but I see that I fotgot
to include syntax highlighting for Perl.

Compared to the version in Dscho repository, it makes gitweb do line
numbering by itself, instead of making 'highlight' do it... and then
rewriting it to conform to the rest of gitweb.  We should probably
leave tab expansion to gitweb, so that 'blob' view would look the same
with and without syntax hightlighting enabled.

Note that gitweb.css contains default 'highlight' style, but perhaps
other style would be better fit for deafule gitweb CSS.

WARNING: No tests!

Have fun playing with it!

 gitweb/gitweb.css  |   18 ++++++++++++++++
 gitweb/gitweb.perl |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 50067f2..4132aab 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -572,3 +572,21 @@ span.match {
 div.binary {
 	font-style: italic;
 }
+
+/* Style definition generated by highlight 2.4.5, http://www.andre-simon.de/ */
+
+/* Highlighting theme definition: */
+
+.num    { color:#2928ff; }
+.esc    { color:#ff00ff; }
+.str    { color:#ff0000; }
+.dstr   { color:#818100; }
+.slc    { color:#838183; font-style:italic; }
+.com    { color:#838183; font-style:italic; }
+.dir    { color:#008200; }
+.sym    { color:#000000; }
+.line   { color:#555555; }
+.kwa    { color:#000000; font-weight:bold; }
+.kwb    { color:#830000; }
+.kwc    { color:#000000; font-weight:bold; }
+.kwd    { color:#010181; }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 32b04a4..3b6df9f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -227,6 +227,26 @@ our %avatar_size = (
 # Leave it undefined (or set to 'undef') to turn off load checking.
 our $maxload = 300;
 
+# syntax highlighting
+our %highlight = (
+	# match by basename
+	'SConstruct' => 'py',
+	'Program' => 'py',
+	'Library' => 'py',
+	'Makefile' => 'make',
+	# match by extension
+	'\.py$' => 'py',
+	'\.c$' => 'c',
+	'\.h$' => 'c',
+	'\.cpp$' => 'cpp',
+	'\.cxx$' => 'cpp',
+	'\.rb$' => 'ruby',
+	'\.java$' => 'java',
+	'\.css$' => 'css',
+	'\.php3?$' => 'php',
+	'\.sh$' => 'sh',
+);
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -445,6 +465,19 @@ our %feature = (
 	'javascript-actions' => {
 		'override' => 0,
 		'default' => [0]},
+
+	# Syntax highlighting support. This is based on Daniel Svensson's
+	# and Sham Chukoury's work in gitweb-xmms2.git.
+	# It requires the 'highlight' program, and therefore is disabled
+	# by default.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'highlight'}{'default'} = [1];
+
+	'highlight' => {
+		'sub' => sub { feature_bool('highlight', @_) },
+		'override' => 0,
+		'default' => [0]},
 );
 
 sub gitweb_get_feature {
@@ -5340,6 +5373,7 @@ sub git_blob {
 	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
 		or die_error(500, "Couldn't cat $file_name, $hash");
 	my $mimetype = blob_mimetype($fd, $file_name);
+	# use 'blob_plain' (aka 'raw') view for files that cannot be displayed
 	if ($mimetype !~ m!^(?:text/|image/(?:gif|png|jpeg)$)! && -B $fd) {
 		close $fd;
 		return git_blob_plain($mimetype);
@@ -5347,6 +5381,25 @@ sub git_blob {
 	# we can have blame only for text/* mimetype
 	$have_blame &&= ($mimetype =~ m!^text/!);
 
+	my $have_highlight = gitweb_check_feature('highlight');
+	my $syntax;
+	if ($have_highlight && defined($file_name)) {
+		my $basename = basename($file_name);
+		foreach my $regexp (keys %highlight) {
+			if ($basename =~ /$regexp/) {
+				$syntax = $highlight{$regexp};
+				last;
+			}
+		}
+
+		if ($syntax) {
+			close $fd;
+			open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
+			          "highlight --xhtml --fragment -t 8 --syntax $syntax |"
+				or die_error(500, "Couldn't open file or run syntax highlighter");
+		}
+	}
+
 	git_header_html(undef, $expires);
 	my $formats_nav = '';
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
@@ -5395,10 +5448,10 @@ sub git_blob {
 		while (my $line = <$fd>) {
 			chomp $line;
 			$nr++;
-			$line = untabify($line);
+			$line = untabify($line) unless ($syntax);
 			printf "<div class=\"pre\"><a id=\"l%i\" href=\"" . href(-replay => 1)
 				. "#l%i\" class=\"linenr\">%4i</a> %s</div>\n",
-			       $nr, $nr, $nr, esc_html($line, -nbsp=>1);
+			       $nr, $nr, $nr, $syntax ? $line : esc_html($line, -nbsp=>1);
 		}
 	}
 	close $fd
