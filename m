From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 06/11] gitweb: allow action specialization in page header
Date: Thu, 11 Nov 2010 13:26:13 +0100
Message-ID: <1289478378-15604-7-git-send-email-giuseppe.bilotta@gmail.com>
References: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 13:27:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGWF6-0000Sd-C6
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 13:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756501Ab0KKM0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 07:26:44 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64924 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756482Ab0KKM0n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 07:26:43 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so1036109eye.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 04:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XAqagZkDfPVM1N8AYFdWdjzxAbtNTnUWQjDma88gaX4=;
        b=gcAeenhQx1Lvxt82AKKPL1wPV6tkwEdEGlBllJm5Vw6xRUbwl+dcnNqZrRPfsGd/NS
         ttzSIpMhRSYl18alINJJ2CnNLtEjswlcWQmQfmizPcBXZVNQTnZN+hKTVIxcIVez3ItT
         hlDpcQO5wEMCxbsZaSO7oFAFZ6S3KLE1bzbD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pYrFDKQnsgGGR4wRH4pepIWWIa2WOY27zgPlj8pfG1v60hkhyrTWKFHDjd0eHM7Dmt
         Ro96b8tBNnKMp54+Lze2L/zt56Peo7paFzZ/yaOtEYVUvE+DIYGqye3Vr8Af6O27TiVH
         IsYrHVMF5L+6lUhKsQwVdTsarje1/+j937f2Y=
Received: by 10.216.180.133 with SMTP id j5mr604412wem.79.1289478402640;
        Thu, 11 Nov 2010 04:26:42 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id k4sm1241859weq.33.2010.11.11.04.26.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 04:26:41 -0800 (PST)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161236>

An optional -action_extra parameter is given to git_header_html() to
identify a variant of the action that is being displayed. For example,
this can be used to specify that the remotes view is being used for a
specific remote and not to display all remotes.

When -action_extra is provided, the action name in the header will be
turned into a link to the action without any arguments or parameters, to
provide a quick link to the non-specific variant of the action.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7cd50d4..c3b8966 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3526,7 +3526,15 @@ EOF
 	if (defined $project) {
 		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
 		if (defined $action) {
-			print " / $action";
+			my $action_print = $action ;
+			if (defined $opts{-action_extra}) {
+				$action_print = $cgi->a({-href => href(action=>$action)},
+					$action);
+			}
+			print " / $action_print";
+		}
+		if (defined $opts{-action_extra}) {
+			print " / $opts{-action_extra}";
 		}
 		print "\n";
 	}
-- 
1.7.3.68.g6ec8
