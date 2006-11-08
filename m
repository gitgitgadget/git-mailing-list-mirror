X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] gitweb: New improved formatting of chunk header in diff
Date: Wed, 8 Nov 2006 18:00:15 +0100
Message-ID: <200611081800.16001.jnareb@gmail.com>
References: <200611081147.52952.jnareb@gmail.com> <200611081150.07469.jnareb@gmail.com> <200611081758.57597.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 17:00:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ejKJO8DcMvXAQUNSkCBqZRkBsQtFZF5+7PfWCtWqe1fqnDLdZNRADFs8mBjTY+cQ92BzCz2PqA0EMfzK8AKkBi2qrBeppTbdYaMk/J8WYKhMpT5QSdW+MWw5SIVrdBS3tdXaM5tx0YcB/Fs6yA8g/9P56R0NTsy1WErNzE/TXVM=
User-Agent: KMail/1.9.3
In-Reply-To: <200611081758.57597.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31143>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhqmK-00087z-EZ for gcvg-git@gmane.org; Wed, 08 Nov
 2006 17:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161347AbWKHQ7y (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 11:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161351AbWKHQ7y
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 11:59:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:21145 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1161347AbWKHQ7w
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 11:59:52 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1576702ugc for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 08:59:51 -0800 (PST)
Received: by 10.67.89.5 with SMTP id r5mr11243099ugl.1163005190897; Wed, 08
 Nov 2006 08:59:50 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id e1sm8082261ugf.2006.11.08.08.59.50; Wed, 08 Nov
 2006 08:59:50 -0800 (PST)
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
 gitweb/gitweb.css  |   13 +++++++++++++
 gitweb/gitweb.perl |   18 +++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletions(-)

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
index 2cf8e60..3118cb0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -873,6 +873,7 @@ sub format_subject_html {
 
 sub format_diff_line {
 	my $line = shift;
+	my ($from, $to) = @_;
 	my $char = substr($line, 0, 1);
 	my $diff_class = "";
 
@@ -888,6 +889,21 @@ sub format_diff_line {
 		$diff_class = " incomplete";
 	}
 	$line = untabify($line);
+	if ($from && $to && $line =~ m/^\@{2} /) {
+		my ($from_text, $from_start, $from_lines, $to_text, $to_start, $to_lines, $section) =
+			$line =~ m/^\@{2} (-(\d+),(\d+)) (\+(\d+),(\d+)) \@{2}(.*)$/;
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
 
@@ -2323,7 +2339,7 @@ sub git_patchset_body {
 			next LINE;
 		}
 
-		print format_diff_line($patch_line);
+		print format_diff_line($patch_line, \%from, \%to);
 	}
 	print "</div>\n" if $patch_found; # class="patch"
 
-- 
1.4.3.4
