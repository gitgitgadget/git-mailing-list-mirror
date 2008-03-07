From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] gitweb: Make 'object' action implicit by using no action URL
Date: Fri,  7 Mar 2008 22:03:20 +0100
Message-ID: <1204923800-5923-4-git-send-email-jnareb@gmail.com>
References: <1204923800-5923-1-git-send-email-jnareb@gmail.com>
Cc: Gerrit Pape <pape@smarden.org>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 22:04:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXjk9-0003vg-HR
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 22:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbYCGVDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 16:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759462AbYCGVDb
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 16:03:31 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:2512 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759515AbYCGVDa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 16:03:30 -0500
Received: by fg-out-1718.google.com with SMTP id e21so703924fga.17
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 13:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IMSOMb6y1zvtGkvYjag28EuDKac68ubHyjn2xfbNlww=;
        b=PhAok+Hg7jmGfZfUjML20SV5izk7JLv3TzurfDYX6mp946+7voQM4WFLZDIHqBNPOhB8lkzPjzfhKD3ufNLNZ4csOpr2b0UMGlJWMcZgW4StLdRZQwDDh1Lh2tih+RlGfx9L7TDR5dEN9/MpowOvw40wZD0gyOqj3LgF9Lxjahs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IE24NxKqXfW5uGrPdH9jiG/GdJgRTNVcGDI3ECGKwgfPGKmfrSGI9le13x+qPm785exfix07v0Ig+LiK5q5uU0fN6qHejuQ9lkW1Rywvj9zX8PAL915klDkamlJCNnDQsZqYEcm5lBopiLV9Z7Igq8ZOgSOjMQcmm+qThwj/orY=
Received: by 10.86.4.2 with SMTP id 2mr2038696fgd.9.1204923808720;
        Fri, 07 Mar 2008 13:03:28 -0800 (PST)
Received: from localhost.localdomain ( [83.8.243.158])
        by mx.google.com with ESMTPS id 4sm4457025fgg.4.2008.03.07.13.03.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Mar 2008 13:03:27 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m27L3PGE005954;
	Fri, 7 Mar 2008 22:03:25 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m27L3Paa005953;
	Fri, 7 Mar 2008 22:03:25 +0100
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1204923800-5923-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76522>

In format_log_line_html() subroutine gitweb makes (shortened) SHA-1
of an object into hyperlink, as a very simple comittags support.
Usually, but not always this link is to 'commit' object.

In git_print_tree_entry() subroutine gitweb provides link to the
target of symbolic link, for easier navigation, if it looks like it
leads inside tree.  Gitweb doesn't know if it leads to directory
('tree' object), or an ordinary file ('blob' object), or if it is
broken.  (It cn also in rare cases lead to submodule, which now
will result in the 'commit' view).

Both of those cases used generic 'object' action to find correct view
on request, only when link were followed.  Now we make use of the fact
that gitweb tries to find correct action if none provided; it uses
'object' action if action is not provided, but project and either hash
or hash_base and filename are.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Hmmmm... isn't this commit message too long for such a simple change?

 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f507a5a..a5df2fe 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1072,7 +1072,7 @@ sub format_log_line_html {
 	if ($line =~ m/([0-9a-fA-F]{8,40})/) {
 		my $hash_text = $1;
 		my $link =
-			$cgi->a({-href => href(action=>"object", hash=>$hash_text),
+			$cgi->a({-href => href(hash=>$hash_text),
 			        -class => "text"}, $hash_text);
 		$line =~ s/$hash_text/$link/;
 	}
@@ -2912,7 +2912,7 @@ sub git_print_tree_entry {
 				my $norm_target = normalize_link_target($link_target, $basedir, $hash_base);
 				if (defined $norm_target) {
 					print " -> " .
-					      $cgi->a({-href => href(action=>"object", hash_base=>$hash_base,
+					      $cgi->a({-href => href(hash_base=>$hash_base,
 					                             file_name=>$norm_target),
 					               -title => $norm_target}, esc_path($link_target));
 				} else {
-- 
1.5.4.3.453.gc1ad83

