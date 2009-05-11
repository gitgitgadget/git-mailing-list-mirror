From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH v2 2/5] gitweb: Do not use bareword filehandles
Date: Mon, 11 May 2009 03:21:06 +0200
Message-ID: <200905110321.08109.jnareb@gmail.com>
References: <200905100203.51744.jnareb@gmail.com> <200905100236.20158.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 03:22:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3KDw-0001fM-Rx
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 03:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117AbZEKBVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 21:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754469AbZEKBVK
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 21:21:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:38039 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbZEKBVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 21:21:09 -0400
Received: by fg-out-1718.google.com with SMTP id 16so834900fgg.17
        for <git@vger.kernel.org>; Sun, 10 May 2009 18:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=tZGVFiwFHtlKhxM2KfF4oLX3ygOnz4MsZU0lqHDgfeE=;
        b=qcZSOx6jfiCDbxrH/YlBLfdX5NdgzGgK97hMrVaTTfod+O7APfzs2MAKdUhXfeMvoV
         eW4rcefIr4O9wvRsl2Z1ceq72bLwkRz68eizfJtboEpqV0KmeTPb8an99EagOt++lcut
         qNS26pEcqDWN5GTa/AClRd7ydC6woOBvOYwic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=eyRcVEPJqDYjnUPK6G2I4f/JexYu23Fl1pTCYGo/Vjo6dmwHmC0H7RW3yN4nD0P4Ti
         wWj0OMdXRUJCu78vDux2/TLdkKFA4ketDWeh6o/GBABmdUtsXlpwnYSkzOeegBeyxSO1
         iOhjW91LoJo/ObKpsXrPwXjE9MzVfL1w4rMpI=
Received: by 10.86.86.2 with SMTP id j2mr5894805fgb.50.1242004867100;
        Sun, 10 May 2009 18:21:07 -0700 (PDT)
Received: from ?192.168.1.13? (abvi64.neoplus.adsl.tpnet.pl [83.8.206.64])
        by mx.google.com with ESMTPS id 12sm5802987fgg.25.2009.05.10.18.21.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 May 2009 18:21:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200905100236.20158.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118766>

gitweb: Do not use bareword filehandles

The script was using bareword filehandles.  This is considered a bad
practice so they have been changed to indirect filehandles.

Changes touch git_get_project_ctags and mimetype_guess_file;
while at it rename local variable from $mime to $mimetype (in
mimetype_guess_file) to better reflect its value (its contents).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I'm extremely sorry for this stupid mistake. Below there is interdiff
(indented, as to not be mistaken for diff itself)

	diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
	index a9daa1d..584644c 100755
	--- a/gitweb/gitweb.perl
	+++ b/gitweb/gitweb.perl
	@@ -2065,9 +2065,8 @@ sub git_get_project_ctags {
	        my $ctags = {};
	 
	        $git_dir = "$projectroot/$path";
	-       unless (opendir my $dh, "$git_dir/ctags") {
	-               return $ctags;
	-       }
	+       opendir my $dh, "$git_dir/ctags"
	+               or return $ctags;
	        foreach (grep { -f $_ } map { "$git_dir/ctags/$_" } readdir($dh)) {
	                open my $ct, $_ or next;
	                my $val = <$ct>;

 gitweb/gitweb.perl |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 06e9160..584644c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2065,18 +2065,17 @@ sub git_get_project_ctags {
 	my $ctags = {};
 
 	$git_dir = "$projectroot/$path";
-	unless (opendir D, "$git_dir/ctags") {
-		return $ctags;
-	}
-	foreach (grep { -f $_ } map { "$git_dir/ctags/$_" } readdir(D)) {
-		open CT, $_ or next;
-		my $val = <CT>;
+	opendir my $dh, "$git_dir/ctags"
+		or return $ctags;
+	foreach (grep { -f $_ } map { "$git_dir/ctags/$_" } readdir($dh)) {
+		open my $ct, $_ or next;
+		my $val = <$ct>;
 		chomp $val;
-		close CT;
+		close $ct;
 		my $ctag = $_; $ctag =~ s#.*/##;
 		$ctags->{$ctag} = $val;
 	}
-	closedir D;
+	closedir $dh;
 	$ctags;
 }
 
@@ -2804,18 +2803,18 @@ sub mimetype_guess_file {
 	-r $mimemap or return undef;
 
 	my %mimemap;
-	open(MIME, $mimemap) or return undef;
-	while (<MIME>) {
+	open(my $mh, $mimemap) or return undef;
+	while (<$mh>) {
 		next if m/^#/; # skip comments
-		my ($mime, $exts) = split(/\t+/);
+		my ($mimetype, $exts) = split(/\t+/);
 		if (defined $exts) {
 			my @exts = split(/\s+/, $exts);
 			foreach my $ext (@exts) {
-				$mimemap{$ext} = $mime;
+				$mimemap{$ext} = $mimetype;
 			}
 		}
 	}
-	close(MIME);
+	close($mh);
 
 	$filename =~ /\.([^.]*)$/;
 	return $mimemap{$1};
-- 
1.6.3
