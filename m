From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/6] gitweb: Add links to blobdiffs in from-file/to-file
	header for merges
Date: Fri, 08 Jun 2007 13:32:44 +0200
Message-ID: <20070608113000.3594.74677.stgit@roke.D-201>
References: <20070608112337.3594.93976.stgit@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 13:27:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwccn-0002Nd-JW
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 13:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967971AbXFHL1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 07:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967847AbXFHL1Y
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 07:27:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:58061 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966961AbXFHL1X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 07:27:23 -0400
Received: by ug-out-1314.google.com with SMTP id j3so930958ugf
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 04:27:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=chhDfwGFatOVkeIB7+YBTjR2bCadSy9yYpgd4853FLB/6GuTfOO8kNO2VLvlWVgCEn7hw06f4hkqTqJrFQJIP8Mx/cxuo8mR9P+vcgtrG9Vlm7PPgphoCVXa9n0ZsmdJwNyc54xnfNY9AFqqUkdhxbsZKzUe6hSb8Jsh7RrpyvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=EH8GTx2v9LjmgFmJR2jby+unpRDx1FQ3TP5u/YhZuoEDbmVR/Iv0mWtkvLb3Q+GYQqZx68ngQE0GBUgSk5rn5MTt//jAzV2jmq52A9B5EYe6ZRCCF8j9qzLa/EqF5zMfwtwHkornmlTWmDTmxYskqC4LTqxA2i+cWXddtMlhmLE=
Received: by 10.82.105.13 with SMTP id d13mr5151767buc.1181302042309;
        Fri, 08 Jun 2007 04:27:22 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id 34sm71991nfu.2007.06.08.04.27.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jun 2007 04:27:21 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l58BWiqV003697;
	Fri, 8 Jun 2007 13:32:44 +0200
In-Reply-To: <20070608112337.3594.93976.stgit@roke.D-201>
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49468>

Add links to diff to file ('blobdiff' view) for each of individual
versions of the file in a merge commit to the from-file/to-file header
in the patch part of combined 'commitdiff' view for merges.

The from-file/to-file header for combined diff now looks like:

  --- _1_/_git-gui/git-gui.sh_
  --- _2_/_git-gui.sh_
  +++ b/_git-gui/git-gui.sh_

where _<filename>_ link is link to appropriate version of a file
('blob' view), and _<n>_ is link to respective diff to mentioned
version of a file ('blobdiff' view). There is even hint provided in
the form of title attribute.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
As requested by Junio C Hamano and Petr "Pasky" Baudis in:
  Message-ID: <7v1wh1en8k.fsf@assigned-by-dhcp.cox.net>
  Message-ID: <20070528132959.GT4489@pasky.or.cz>

I don't know if the link placement is best possible; I tried for
combined diff output be similar to ordinary diff output, but also
provide reqeusted additional functionality (which does not make
sense for ordinary diff). You have to know ehere to search for
the link.

 gitweb/gitweb.perl |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 13114bc..c7acfad 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1058,7 +1058,7 @@ sub format_extended_diff_header_line {
 
 # format from-file/to-file diff header
 sub format_diff_from_to_header {
-	my ($from_line, $to_line, $diffinfo, $from, $to) = @_;
+	my ($from_line, $to_line, $diffinfo, $from, $to, @parents) = @_;
 	my $line;
 	my $result = '';
 
@@ -1084,7 +1084,17 @@ sub format_diff_from_to_header {
 		for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
 			if ($from->{'href'}[$i]) {
 				$line = '--- ' .
-				        ($i+1) . "/" .
+				        $cgi->a({-href=>href(action=>"blobdiff",
+				                             hash_parent=>$diffinfo->{'from_id'}[$i],
+				                             hash_parent_base=>$parents[$i],
+				                             file_parent=>$from->{'file'}[$i],
+				                             hash=>$diffinfo->{'to_id'},
+				                             hash_base=>$hash,
+				                             file_name=>$to->{'file'}),
+				                 -class=>"path",
+				                 -title=>"diff" . ($i+1)},
+				                $i+1) .
+				        '/' .
 				        $cgi->a({-href=>$from->{'href'}[$i], -class=>"path"},
 				                esc_path($from->{'file'}[$i]));
 			} else {
@@ -3042,7 +3052,8 @@ sub git_patchset_body {
 		#assert($patch_line =~ m/^\+\+\+/) if DEBUG;
 
 		print format_diff_from_to_header($last_patch_line, $patch_line,
-		                                 $diffinfo, \%from, \%to);
+		                                 $diffinfo, \%from, \%to,
+		                                 @hash_parents);
 
 		# the patch itself
 	LINE:
