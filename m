From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/5] gitweb: Localize magic variable $/
Date: Sun, 10 May 2009 02:39:39 +0200
Message-ID: <200905100239.40092.jnareb@gmail.com>
References: <200905100203.51744.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 02:42:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2x7R-0005rl-46
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 02:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494AbZEJAmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 20:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755313AbZEJAmE
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 20:42:04 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:35126 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755074AbZEJAly (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 20:41:54 -0400
Received: by mail-ew0-f176.google.com with SMTP id 24so2659310ewy.37
        for <git@vger.kernel.org>; Sat, 09 May 2009 17:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bPdj72WI35oXmQljh4i7KID9bQUAaNPVfwcl6/YFBZE=;
        b=NVlwzj2NYDy3QqfKVdi+6wRoqP59N5Q5hfu5IJES18wfFilHMaqFt97t0st+EJQn+f
         LVlhbuwp/NnmoRlReGa7LjX/mwhAbl8OnyEiRvrado3x/q0QbswwMq/0/q8+3irZVX2K
         w7St+k9imZO+KPCl3nLE83E6BdAqL4IBnWuxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=Z8ZqxQ0eeih4Yl//qdGTab4ae6hOARRhadBVDws3MZ1fiFvfWsvC4H7xzho5HQfaC+
         TOCUDB/hCqO7fq1NP+D19v5oytPrU9cwD2YXtZVJ3U8GvRXKOTROXo/mP9Bwhm+8LZ9K
         akpSvwRaLu0tR4esS+S6o0OlUYNA4C6L2Ippk=
Received: by 10.210.111.17 with SMTP id j17mr3088511ebc.95.1241916115000;
        Sat, 09 May 2009 17:41:55 -0700 (PDT)
Received: from ?192.168.1.13? (abvf146.neoplus.adsl.tpnet.pl [83.8.203.146])
        by mx.google.com with ESMTPS id 7sm4827142eyb.25.2009.05.09.17.41.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 May 2009 17:41:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200905100203.51744.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118692>

Instead of undefining and then restoring magic variable $/ (input
record separator) for 'slurp mode', localize it.

While at it, state explicitly that "local $/;" makes it undefined, by
using explicit  "local $/ = undef;".

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Perl::Critic::Policy::Variables::RequireLocalizedPunctuationVars

  Magic variables should be assigned as "local".

  Punctuation variables (and their English.pm equivalents) are global
  variables. Messing with globals is dangerous in a complex program as it
  can lead to very subtle and hard to fix bugs. If you must change a magic
  variable in a non-trivial program, do it in a local scope.

  For example, to slurp a filehandle into a scalar, it's common to set the
  record separator to undef instead of a newline. If you choose to do this
  (instead of using File::Slurp!) then be sure to localize the global and
  change it for as short a time as possible.

See also Damian Conway's book "Perl Best Practices",
5.6. Localizing Punctuation Variables (If you're forced to modify
a punctuation variable, localize it.)


Perl::Critic::Policy::Variables::RequireInitializationForLocalVars

  Write  'local $foo = $bar;'  instead of just  'local $foo;'.

  Most people don't realize that a localized copy of a variable does
  not retain its original value. Unless you initialize the variable
  when you local-ize it, it defaults to undef. If you want the
  variable to retain its original value, just initialize it to
  itself. If you really do want the localized copy to be undef, then
  make it explicit.


 gitweb/gitweb.perl |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 852beb6..1cb3a4f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3326,7 +3326,7 @@ sub git_get_link_target {
 	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
 		or return;
 	{
-		local $/;
+		local $/ = undef;
 		$link_target = <$fd>;
 	}
 	close $fd
@@ -4801,11 +4801,10 @@ sub git_blob_plain {
 		-content_disposition =>
 			($sandbox ? 'attachment' : 'inline')
 			. '; filename="' . $save_as . '"');
-	undef $/;
+	local $/ = undef;
 	binmode STDOUT, ':raw';
 	print <$fd>;
 	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
-	$/ = "\n";
 	close $fd;
 }
 
@@ -4907,12 +4906,15 @@ sub git_tree {
 		}
 	}
 	die_error(404, "No such tree") unless defined($hash);
-	$/ = "\0";
-	open my $fd, "-|", git_cmd(), "ls-tree", '-z', $hash
-		or die_error(500, "Open git-ls-tree failed");
-	my @entries = map { chomp; $_ } <$fd>;
-	close $fd or die_error(404, "Reading tree failed");
-	$/ = "\n";
+
+	{
+		local $/ = "\0";
+		open my $fd, "-|", git_cmd(), "ls-tree", '-z', $hash
+			or die_error(500, "Open git-ls-tree failed");
+		my @entries = map { chomp; $_ } <$fd>;
+		close $fd
+			or die_error(404, "Reading tree failed");
+	}
 
 	my $refs = git_get_references();
 	my $ref = format_ref_marker($refs, $hash_base);
@@ -5807,7 +5809,7 @@ sub git_search {
 
 		print "<table class=\"pickaxe search\">\n";
 		my $alternate = 1;
-		$/ = "\n";
+		local $/ = "\n";
 		open my $fd, '-|', git_cmd(), '--no-pager', 'log', @diff_opts,
 			'--pretty=format:%H', '--no-abbrev', '--raw', "-S$searchtext",
 			($search_use_regexp ? '--pickaxe-regex' : ());
@@ -5877,7 +5879,7 @@ sub git_search {
 		print "<table class=\"grep_search\">\n";
 		my $alternate = 1;
 		my $matches = 0;
-		$/ = "\n";
+		local $/ = "\n";
 		open my $fd, "-|", git_cmd(), 'grep', '-n',
 			$search_use_regexp ? ('-E', '-i') : '-F',
 			$searchtext, $co{'tree'};
-- 
1.6.3
