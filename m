From: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
Subject: [PATCH/RFC 1/2] gitweb: change format_diff_line() to remove leading
 SP from $diff_class
Date: Mon, 17 Oct 2011 15:59:55 +0900
Message-ID: <CAFo4x0LP4fXgSNAnss_WRLo-TH_qe=esYn7P+=iS6t87tdzcbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 17 09:00:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFhBu-0001Ly-4R
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 09:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921Ab1JQHAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 03:00:45 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50862 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436Ab1JQHAo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 03:00:44 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt19so3346473bkb.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 00:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=5QPwlW5MDt1u4UulfSia8uVGUlgm3dQ0pZt7mTKEeJ8=;
        b=q3KdLrrRXehMu+7d09ZLEcHKh52YZ0tQq5Y1RxqRlc1XxsMywkakNhv+9QhsQVQIkR
         Bh5KdsIw+aOunmGbobUKbPwk2w59DbdyUKGbzp3X1QaZwslbx/XoZTOE3kHS0Sp3RKpC
         lL4c8i3kUvMfDJXY/6juXQ6P8NLahCZT33Dd4=
Received: by 10.204.13.68 with SMTP id b4mr9518663bka.96.1318834844186; Mon,
 17 Oct 2011 00:00:44 -0700 (PDT)
Received: by 10.204.36.132 with HTTP; Sun, 16 Oct 2011 23:59:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183770>

The format_diff_line() will return $diff_class and HTML in upcoming changes.
---
 gitweb/gitweb.perl |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 85d64b2..095adda 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2235,28 +2235,30 @@ sub format_diff_line {
 		# combined diff
 		my $prefix = substr($line, 0, scalar @{$from->{'href'}});
 		if ($line =~ m/^\@{3}/) {
-			$diff_class = " chunk_header";
+			$diff_class = "chunk_header";
 		} elsif ($line =~ m/^\\/) {
-			$diff_class = " incomplete";
+			$diff_class = "incomplete";
 		} elsif ($prefix =~ tr/+/+/) {
-			$diff_class = " add";
+			$diff_class = "add";
 		} elsif ($prefix =~ tr/-/-/) {
-			$diff_class = " rem";
+			$diff_class = "rem";
 		}
 	} else {
 		# assume ordinary diff
 		my $char = substr($line, 0, 1);
 		if ($char eq '+') {
-			$diff_class = " add";
+			$diff_class = "add";
 		} elsif ($char eq '-') {
-			$diff_class = " rem";
+			$diff_class = "rem";
 		} elsif ($char eq '@') {
-			$diff_class = " chunk_header";
+			$diff_class = "chunk_header";
 		} elsif ($char eq "\\") {
-			$diff_class = " incomplete";
+			$diff_class = "incomplete";
 		}
 	}
 	$line = untabify($line);
+
+	my $div_open = '<div class="' . (join ' ', ('diff', $diff_class)) . '">';
 	if ($from && $to && $line =~ m/^\@{2} /) {
 		my ($from_text, $from_start, $from_lines, $to_text, $to_start,
$to_lines, $section) =
 			$line =~ m/^\@{2} (-(\d+)(?:,(\d+))?) (\+(\d+)(?:,(\d+))?) \@{2}(.*)$/;
@@ -2274,7 +2276,7 @@ sub format_diff_line {
 		}
 		$line = "<span class=\"chunk_info\">@@ $from_text $to_text @@</span>" .
 		        "<span class=\"section\">" . esc_html($section, -nbsp=>1) .
"</span>";
-		return "<div class=\"diff$diff_class\">$line</div>\n";
+		return "$div_open$line</div>\n";
 	} elsif ($from && $to && $line =~ m/^\@{3}/) {
 		my ($prefix, $ranges, $section) = $line =~ m/^(\@+) (.*?) \@+(.*)$/;
 		my (@from_text, @from_start, @from_nlines, $to_text, $to_start, $to_nlines);
@@ -2307,9 +2309,9 @@ sub format_diff_line {
 		}
 		$line .= " $prefix</span>" .
 		         "<span class=\"section\">" . esc_html($section, -nbsp=>1)
. "</span>";
-		return "<div class=\"diff$diff_class\">$line</div>\n";
+		return "$div_open$line</div>\n";
 	}
-	return "<div class=\"diff$diff_class\">" . esc_html($line, -nbsp=>1)
. "</div>\n";
+	return $div_open . esc_html($line, -nbsp=>1) . "</div>\n";
 }

 # Generates undef or something like "_snapshot_" or "snapshot (_tbz2_ _zip_)",
-- 
1.7.7.213.g8b0e1.dirty
