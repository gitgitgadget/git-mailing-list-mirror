From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: Convert Content-Disposition filenames into qtext
Date: Fri, 6 Oct 2006 12:18:01 -0700 (PDT)
Message-ID: <20061006191801.68649.qmail@web31815.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2130441041-1160162281=:23316"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Oct 06 21:18:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVvCz-0005r5-OV
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 21:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422792AbWJFTSG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 15:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422685AbWJFTSG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 15:18:06 -0400
Received: from web31815.mail.mud.yahoo.com ([68.142.206.168]:14991 "HELO
	web31815.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932310AbWJFTSC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 15:18:02 -0400
Received: (qmail 68653 invoked by uid 60001); 6 Oct 2006 19:18:01 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=rEZYhBYpUYDClUFX1l6gfNoqMLN+OxkdVMdPYmFFLKfCkhsKRQ2UiDszrq/IXd3F3hWM2nv+joHyuVF17pAnpw3o7Aj1kqiM5mX++qGeV4Yk+ty7R6Sbkk+6KGmUmhLOv1Uyo7djAAxCRrl8VUJRgu1UmHfntKrcJASEcZp0jzw=  ;
Received: from [64.215.88.90] by web31815.mail.mud.yahoo.com via HTTP; Fri, 06 Oct 2006 12:18:01 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28437>

--0-2130441041-1160162281=:23316
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Convert a string (e.g. a filename) into qtext as defined
in RFC 822, from RFC 2183.  To be used by Content-Disposition.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.perl |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

--0-2130441041-1160162281=:23316
Content-Type: text/plain; name="p1.txt"
Content-Description: 1207600725-p1.txt
Content-Disposition: inline; filename="p1.txt"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f848648..a35d02c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -520,6 +520,16 @@ sub esc_html {
 	return $str;
 }
 
+# Convert a string (e.g. a filename) into qtext as defined
+# in RFC 822, from RFC 2183.  To be used by Content-Disposition.
+sub to_qtext {
+	my $str = shift;
+	$str =~ s/\\/\\\\/g;
+	$str =~ s/\"/\\\"/g;
+	$str =~ s/\r/\\r/g;
+	return $str;
+}
+
 # git may return quoted and escaped filenames
 sub unquote {
 	my $str = shift;
@@ -2742,7 +2752,7 @@ sub git_blob_plain {
 	print $cgi->header(
 		-type => "$type",
 		-expires=>$expires,
-		-content_disposition => 'inline; filename="' . "$save_as" . '"');
+		-content_disposition => 'inline; filename="' . to_qtext("$save_as") . '"');
 	undef $/;
 	binmode STDOUT, ':raw';
 	print <$fd>;
@@ -2917,7 +2927,7 @@ sub git_snapshot {
 	print $cgi->header(
 		-type => 'application/x-tar',
 		-content_encoding => $ctype,
-		-content_disposition => 'inline; filename="' . "$filename" . '"',
+		-content_disposition => 'inline; filename="' . to_qtext("$filename") . '"',
 		-status => '200 OK');
 
 	my $git = git_cmd_str();
@@ -3224,7 +3234,7 @@ sub git_blobdiff {
 			-type => 'text/plain',
 			-charset => 'utf-8',
 			-expires => $expires,
-			-content_disposition => 'inline; filename="' . "$file_name" . '.patch"');
+			-content_disposition => 'inline; filename="' . to_qtext("$file_name") . '.patch"');
 
 		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
 
@@ -3327,7 +3337,7 @@ sub git_commitdiff {
 			-type => 'text/plain',
 			-charset => 'utf-8',
 			-expires => $expires,
-			-content_disposition => 'inline; filename="' . "$filename" . '"');
+			-content_disposition => 'inline; filename="' . to_qtext("$filename") . '"');
 		my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
 		print <<TEXT;
 From: $co{'author'}
-- 
1.4.2.3.g0954


--0-2130441041-1160162281=:23316--
