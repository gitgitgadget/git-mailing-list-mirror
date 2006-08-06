From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/6] gitweb: Make blob diff -p1 like commit diff
Date: Sun, 6 Aug 2006 02:13:50 +0200
Message-ID: <200608060213.50613.jnareb@gmail.com>
References: <200608060206.49086.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 06 02:16:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9WK3-0003bb-ML
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 02:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWHFAQl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 20:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWHFAQk
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 20:16:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:7474 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751453AbWHFAQf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 20:16:35 -0400
Received: by nf-out-0910.google.com with SMTP id p46so40350nfa
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 17:16:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KObwwysOOz2IMIa8O5ejNSnk6JUEKFruzUoaW0K0I0mijGzhK9x2bMDF//zZocY2mMPCIV7zEJqAK03FWfgpuAta3xLC+cTwzPOYDrLKYUpppsAgw4K+qG09M2k4nHHlLa+RaCmISEi5b4v+pfAbFvIaoJgaO5TIoV7Xiuo++Us=
Received: by 10.49.29.3 with SMTP id g3mr6980226nfj;
        Sat, 05 Aug 2006 17:16:33 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id r33sm4188262nfc.2006.08.05.17.16.33;
        Sat, 05 Aug 2006 17:16:33 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608060206.49086.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24949>

Add 'a/' and 'b/' as prefix for blobdiff, blobdiff_plain, like it is
in commitdiff, commitdiff_plain.  Ensure that label for /dev/null is
actually /dev/null.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
For consistency.

 gitweb/gitweb.perl |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cdce481..f402c8f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1236,6 +1236,8 @@ sub git_diff_print {
 		print { $fd2 } <$fd>;
 		close $fd2;
 		close $fd;
+	} else {
+		$from_name = "/dev/null";
 	}
 
 	# create tmp to-file
@@ -1247,6 +1249,8 @@ sub git_diff_print {
 		print { $fd2 } <$fd>;
 		close $fd2;
 		close $fd;
+	} else {
+		$to_name = "/dev/null";
 	}
 
 	open my $fd, "-|", "/usr/bin/diff",
@@ -2105,7 +2109,8 @@ sub git_blobdiff {
 	      " -> blob:" .
 	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash;hb=$hash_base;f=$file_name")}, $hash) .
 	      "</div>\n";
-	git_diff_print($hash_parent, $file_name || $hash_parent, $hash, $file_name || $hash);
+	git_diff_print($hash_parent, 'a/' . ($file_name || $hash_parent),
+	               $hash,        'b/' . ($file_name || $hash));
 	print "</div>";
 	git_footer_html();
 }
@@ -2113,7 +2118,8 @@ sub git_blobdiff {
 sub git_blobdiff_plain {
 	mkdir($git_temp, 0700);
 	print $cgi->header(-type => "text/plain", -charset => 'utf-8');
-	git_diff_print($hash_parent, $file_name || $hash_parent, $hash, $file_name || $hash, "plain");
+	git_diff_print($hash_parent, 'a/' . ($file_name || $hash_parent),
+	               $hash,        'b/' . ($file_name || $hash), "plain");
 }
 
 sub git_commitdiff {
-- 
1.4.1.1
