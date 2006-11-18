X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/5] gitweb: New improved formatting of chunk header in diff
Date: Sat, 18 Nov 2006 23:35:40 +0100
Message-ID: <1163889345640-git-send-email-jnareb@gmail.com>
References: <1163889342877-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Sat, 18 Nov 2006 22:34:45 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BXLWxhZD1TRNsuzSfDm3OcRhWcOiwLMIr6f7iRtDuJwQ6Qis1N+iNxCYnBGMYD0SVcFD0dEkon8BokR44FejWnWWebNw5jBQ3QN7m/ZyNAJsCLcvaeBxZjpsl2qPnDf3Cc6E7MqLnJynJKTBgQtUg1iwucTrWji+20djYLedwJs=
X-Mailer: git-send-email 1.4.3.4
In-Reply-To: <1163889342877-git-send-email-jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31806>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlYlc-0001jk-4o for gcvg-git@gmane.org; Sat, 18 Nov
 2006 23:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755272AbWKRWeX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 17:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755279AbWKRWeX
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 17:34:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:5395 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1755275AbWKRWeV
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 17:34:21 -0500
Received: by ug-out-1314.google.com with SMTP id m3so953026ugc for
 <git@vger.kernel.org>; Sat, 18 Nov 2006 14:34:21 -0800 (PST)
Received: by 10.67.97.7 with SMTP id z7mr4617462ugl.1163889260735; Sat, 18
 Nov 2006 14:34:20 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 a1sm6096018ugf.2006.11.18.14.34.19; Sat, 18 Nov 2006 14:34:20 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kAIMZkhE015355; Sat, 18 Nov 2006 23:35:46 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kAIMZjsG015354; Sat, 18 Nov 2006 23:35:45 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

If we have provided enough info, and diff is not combined diff,
and if provided diff line is chunk header, then:
* split chunk header into .chunk_info and .section span elements,
  first containing proper chunk header, second section heading
  (aka. which function), for separate styling: the proper chunk
  header is on non-white background, section heading part uses
  slightly lighter color.
* hyperlink from-file-range to starting line of from-file, if file
  was not created.
* hyperlink to-file-range to starting line of to-file, if file
  was not deleted.
Links are of invisible variety (and "list" class).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This version deals correctly with hunks of form "@@ -n +m,l @@" and
friends. The number of lines in from/to part ($from_lines/$to_lines
variables) is not used.

 gitweb/gitweb.css  |   13 +++++++++++++
 gitweb/gitweb.perl |   23 ++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 974b47f..7177c6e 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -334,11 +334,13 @@ div.diff.extended_header {
 	padding: 2px 0px 2px 0px;
 }
 
+div.diff a.list,
 div.diff a.path,
 div.diff a.hash {
 	text-decoration: none;
 }
 
+div.diff a.list:hover,
 div.diff a.path:hover,
 div.diff a.hash:hover {
 	text-decoration: underline;
@@ -362,14 +364,25 @@ div.diff.rem {
 	color: #cc0000;
 }
 
+div.diff.chunk_header a,
 div.diff.chunk_header {
 	color: #990099;
+}
 
+div.diff.chunk_header {
 	border: dotted #ffe0ff;
 	border-width: 1px 0px 0px 0px;
 	margin-top: 2px;
 }
 
+div.diff.chunk_header span.chunk_info {
+	background-color: #ffeeff;
+}
+
+div.diff.chunk_header span.section {
+	color: #aa22aa;
+}
+
 div.diff.incomplete {
 	color: #cccccc;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bf58c3b..eadaa31 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -874,8 +874,10 @@ sub format_subject_html {
 	}
 }
 
+# format patch (diff) line (rather not to be used for diff headers)
 sub format_diff_line {
 	my $line = shift;
+	my ($from, $to) = @_;
 	my $char = substr($line, 0, 1);
 	my $diff_class = "";
 
@@ -891,6 +893,25 @@ sub format_diff_line {
 		$diff_class = " incomplete";
 	}
 	$line = untabify($line);
+	if ($from && $to && $line =~ m/^\@{2} /) {
+		my ($from_text, $from_start, $from_lines, $to_text, $to_start, $to_lines, $section) =
+			$line =~ m/^\@{2} (-(\d+)(?:,(\d+))?) (\+(\d+)(?:,(\d+))?) \@{2}(.*)$/;
+
+		$from_lines = 0 unless defined $from_lines;
+		$to_lines   = 0 unless defined $to_lines;
+
+		if ($from->{'href'}) {
+			$from_text = $cgi->a({-href=>"$from->{'href'}#l$from_start",
+			                     -class=>"list"}, $from_text);
+		}
+		if ($to->{'href'}) {
+			$to_text   = $cgi->a({-href=>"$to->{'href'}#l$to_start",
+			                     -class=>"list"}, $to_text);
+		}
+		$line = "<span class=\"chunk_info\">@@ $from_text $to_text @@</span>" .
+		        "<span class=\"section\">" . esc_html($section, -nbsp=>1) . "</span>";
+		return "<div class=\"diff$diff_class\">$line</div>\n";
+	}
 	return "<div class=\"diff$diff_class\">" . esc_html($line, -nbsp=>1) . "</div>\n";
 }
 
@@ -2372,7 +2393,7 @@ sub git_patchset_body {
 
 			next PATCH if ($patch_line =~ m/^diff /);
 
-			print format_diff_line($patch_line);
+			print format_diff_line($patch_line, \%from, \%to);
 		}
 
 	} continue {
-- 
1.4.3.4
