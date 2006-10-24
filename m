From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] gitweb: Print commit message without title in commitdiff only if there is any
Date: Tue, 24 Oct 2006 13:55:33 +0200
Message-ID: <200610241355.33560.jnareb@gmail.com>
References: <200610241349.54685.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 24 13:55:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcKsW-0005Jy-He
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 13:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbWJXLz1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 07:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWJXLz0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 07:55:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:15201 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030391AbWJXLzY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 07:55:24 -0400
Received: by ug-out-1314.google.com with SMTP id 32so174711ugm
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 04:55:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hZeJCA/QUo2RpLYu4KvYUDD3lwNeX3MZ6rwQ29uzA1HBN7lOyYpqVKvoPqYoIHntIhBO0q9qTlCTS4KzbduS0PwONQaMd+e7RfLejpTS3AHy641H3zK5nmD9O0GLzQjuwoCXgtdH2h+SUt5XxsP1Jr4cyst8T6aYfu1AYNlgpkU=
Received: by 10.67.119.13 with SMTP id w13mr8695181ugm;
        Tue, 24 Oct 2006 04:55:15 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id b35sm582575ugd.2006.10.24.04.55.14;
        Tue, 24 Oct 2006 04:55:14 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200610241349.54685.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29973>

Print the rest of commit message (title, i.e. first line of commit
message, is printed separately) only if there is any.

In repository which uses signoffs this shouldn't happen, because
commit message should consist of at least title and signoff.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a88e0a8..e35ecb4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3360,9 +3360,11 @@ sub git_commitdiff {
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
 		git_print_authorship(\%co);
 		print "<div class=\"page_body\">\n";
-		print "<div class=\"log\">\n";
-		git_print_log($co{'comment'}, -final_empty_line=> 1, -remove_title => 1);
-		print "</div>\n"; # class="log"
+		if (@{$co{'comment'}} > 1) {
+			print "<div class=\"log\">\n";
+			git_print_log($co{'comment'}, -final_empty_line=> 1, -remove_title => 1);
+			print "</div>\n"; # class="log"
+		}
 
 	} elsif ($format eq 'plain') {
 		my $refs = git_get_references("tags");
-- 
1.4.2.1
