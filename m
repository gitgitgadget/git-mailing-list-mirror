From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/4] gitweb: Add '..' (up directory) to tree view if applicable
Date: Sat, 21 Oct 2006 17:54:44 +0200
Message-ID: <200610211754.44981.jnareb@gmail.com>
References: <200610211750.49188.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 21 17:55:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbJBn-0004Wo-UY
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 17:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993116AbWJUPzA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 11:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993123AbWJUPzA
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 11:55:00 -0400
Received: from hu-out-0506.google.com ([72.14.214.226]:50341 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S2993118AbWJUPy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 11:54:56 -0400
Received: by hu-out-0506.google.com with SMTP id 28so571726hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 08:54:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ojpM5nebtBxUvgVPc4bfq4mWknV8gBBLyLX/DLP04k0mpXWEFXX7Ial0EnNBO7dUFG0pPvUVBDY4cZpmITHqBdMhEUMy+7ntDeNs/Q/5kGyCwyrNtw0cA+iZcDtJ/4EiOJjpupnwITvqMwv//Clq8QgrvS1vn7KnYkfALyg1Fv4=
Received: by 10.67.89.5 with SMTP id r5mr3975859ugl;
        Sat, 21 Oct 2006 08:54:54 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id s1sm2762273uge.2006.10.21.08.54.54;
        Sat, 21 Oct 2006 08:54:54 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200610211750.49188.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29626>

Adds '..' (up directory) link at the top of "tree" view listing,
if both $hash_base and $file_name are provided, and $file_name
is not empty string.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This was meant to send as single patch...

 gitweb/gitweb.perl |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 126cf3c..c9e57f0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2871,6 +2871,30 @@ sub git_tree {
 	print "<div class=\"page_body\">\n";
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 1;
+	# '..' (top directory) link if possible
+	if (defined $hash_base &&
+	    defined $file_name && $file_name =~ m![^/]+$!) {
+		if ($alternate) {
+			print "<tr class=\"dark\">\n";
+		} else {
+			print "<tr class=\"light\">\n";
+		}
+		$alternate ^= 1;
+
+		my $up = $file_name;
+		$up =~ s!/?[^/]+$!!;
+		undef $up unless $up;
+		# based on git_print_tree_entry
+		print '<td class="mode">' . mode_str('040000') . "</td>\n";
+		print '<td class="list">';
+		print $cgi->a({-href => href(action=>"tree", hash_base=>$hash_base,
+		                             file_name=>$up)},
+		              "..");
+		print "</td>\n";
+		print "<td class=\"link\"></td>\n";
+
+		print "</tr>\n";
+	}
 	foreach my $line (@entries) {
 		my %t = parse_ls_tree_line($line, -z => 1);
 
-- 
1.4.2.1
