From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] gitweb: Quote hash keys, and do not use barewords keys
Date: Sun, 1 Apr 2007 22:22:21 +0200
Message-ID: <200704012222.21920.jnareb@gmail.com>
References: <200704012221.01676.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 02 00:55:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HY8xq-0004B4-8V
	for gcvg-git@gmane.org; Mon, 02 Apr 2007 00:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbXDAWzh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Apr 2007 18:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753164AbXDAWzh
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Apr 2007 18:55:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:42353 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbXDAWzW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2007 18:55:22 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1386144uga
        for <git@vger.kernel.org>; Sun, 01 Apr 2007 15:55:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CKZeApCDpz5jDclIMI+ZsU8Zb5avSvpfZgK50pke3VSUMHqwcTTNC3FCKwBJ5SSGUsFnkhNTfG4AUCuUFcxj5FD0OFsQYG5eF4azFZs4ZBf2oq7D5rQk/wGsz4HvmkPd/FyN9cnr3VdvD3IFdnBf3/xj8FYj/fUYxaMKHBNCuSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bhEPI3ebvzE8YbpX+zzSf2c8yBweOhunlcQOvzjDOF7or9I+Elvnqube9+XM0LQwTLEqAHr0nt3ThXV961SEdeANoyC9O4tUzpUYlWh+k7zrKEHSL6VgjH44w761FvFe9HGdiL5c7UWCO+XqNmQoj+vxOdma8HHfpdSZ/5zWuiw=
Received: by 10.67.100.17 with SMTP id c17mr2483704ugm.1175468121551;
        Sun, 01 Apr 2007 15:55:21 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id j9sm17434124mue.2007.04.01.15.55.20;
        Sun, 01 Apr 2007 15:55:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200704012221.01676.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43594>

Ensure that in all references to an elemento of a hash the value
of key is singlequoted, instead of using bareword: use $hash{'key'}
instead of $hash{key}

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5c49056..eab8f3f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -19,7 +19,7 @@ use File::Basename qw(basename);
 binmode STDOUT, ':utf8';
 
 BEGIN {
-	CGI->compile() if $ENV{MOD_PERL};
+	CGI->compile() if $ENV{'MOD_PERL'};
 }
 
 our $cgi = new CGI;
@@ -1870,16 +1870,16 @@ sub git_print_page_nav {
 	my %arg = map { $_ => {action=>$_} } @navs;
 	if (defined $head) {
 		for (qw(commit commitdiff)) {
-			$arg{$_}{hash} = $head;
+			$arg{$_}{'hash'} = $head;
 		}
 		if ($current =~ m/^(tree | log | shortlog | commit | commitdiff | search)$/x) {
 			for (qw(shortlog log)) {
-				$arg{$_}{hash} = $head;
+				$arg{$_}{'hash'} = $head;
 			}
 		}
 	}
-	$arg{tree}{hash} = $treehead if defined $treehead;
-	$arg{tree}{hash_base} = $treebase if defined $treebase;
+	$arg{'tree'}{'hash'} = $treehead if defined $treehead;
+	$arg{'tree'}{'hash_base'} = $treebase if defined $treebase;
 
 	print "<div class=\"page_nav\">\n" .
 		(join " | ",
@@ -1927,9 +1927,9 @@ sub git_print_header_div {
 	my ($action, $title, $hash, $hash_base) = @_;
 	my %args = ();
 
-	$args{action} = $action;
-	$args{hash} = $hash if $hash;
-	$args{hash_base} = $hash_base if $hash_base;
+	$args{'action'} = $action;
+	$args{'hash'} = $hash if $hash;
+	$args{'hash_base'} = $hash_base if $hash_base;
 
 	print "<div class=\"header\">\n" .
 	      $cgi->a({-href => href(%args), -class => "title"},
-- 
1.5.0.5
