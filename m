From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] gitweb: Use underscore instead of hyphen to separate words in HTTP headers names
Date: Tue, 22 Aug 2006 16:55:34 +0200
Message-ID: <200608221655.34246.jnareb@gmail.com>
References: <200608221651.19629.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 22 16:59:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFXjF-0006mJ-SB
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 16:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWHVO7k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 10:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWHVO7k
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 10:59:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:34686 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932289AbWHVO7i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 10:59:38 -0400
Received: by nf-out-0910.google.com with SMTP id o25so78050nfa
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 07:59:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cTpDe7wNCEA2tayCCk6CfCo0j2+wKERsQ4y+FnJwk6I4igAEKWJeWRAJqBmcmnZ0gEiUMDuCRJYfBkIbjdfUvhEE5HhjCK3vrOoUbzOSScFURVpnzufc+9t+6Hqtr0uD6k/vK7pA8h/1Nqls81UhepZ6Q+2IutLbHNA88gotQtU=
Received: by 10.49.8.4 with SMTP id l4mr514666nfi;
        Tue, 22 Aug 2006 07:59:36 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id o9sm639373nfa.2006.08.22.07.59.35;
        Tue, 22 Aug 2006 07:59:36 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608221651.19629.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25855>

Use underscore (which will be turned into hyphen) to separate words in
HTTP header names, in keys to CGI header() method, consistently.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Sometimes using quites for header() keys and sometimes not was not
a good practice.

Excerpt from CGI(3pm):

       The last example shows the named argument style for passing arguments to
       the CGI methods using named parameters.  Recognized parameters are -type,
       -status, -expires, and -cookie.  Any other named parameters will be
       stripped of their initial hyphens and turned into header fields, allowing
       you to specify any HTTP header you desire.  Internal underscores will be
       turned into hyphens:

           print header(-Content_length=>3002);


 gitweb/gitweb.perl |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 182fe33..f59213e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2202,7 +2202,8 @@ sub git_blob_plain {
 		$save_as .= '.txt';
 	}
 
-	print $cgi->header(-type => "$type", '-content-disposition' => "inline; filename=\"$save_as\"");
+	print $cgi->header(-type => "$type",
+	                   -content_disposition => "inline; filename=\"$save_as\"");
 	undef $/;
 	binmode STDOUT, ':raw';
 	print <$fd>;
@@ -2386,8 +2387,8 @@ sub git_snapshot {
 	my $filename = basename($project) . "-$hash.tar.$suffix";
 
 	print $cgi->header(-type => 'application/x-tar',
-	                   -content-encoding => $ctype,
-	                  '-content-disposition' => "inline; filename=\"$filename\"",
+	                   -content_encoding => $ctype,
+	                   -content_disposition => "inline; filename=\"$filename\"",
 	                   -status => '200 OK');
 
 	open my $fd, "-|", "$GIT tar-tree $hash \'$project\' | $command" or
@@ -2705,7 +2706,7 @@ sub git_commitdiff_plain {
 
 	print $cgi->header(-type => "text/plain",
 	                   -charset => 'utf-8',
-	                  '-content-disposition' => "inline; filename=\"git-$hash.patch\"");
+	                   -content_disposition => "inline; filename=\"git-$hash.patch\"");
 	my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
 	my $comment = $co{'comment'};
 	print "From: $co{'author'}\n" .
-- 
1.4.1.1
