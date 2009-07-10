From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] gitweb: Add author initials in 'blame' view, a la "git gui blame"
Date: Sat, 11 Jul 2009 00:01:23 +0200
Message-ID: <200907110001.24093.jnareb@gmail.com>
References: <200907102354.43232.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 00:01:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPOAB-0003QR-J4
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 00:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757364AbZGJWBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 18:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754449AbZGJWBq
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 18:01:46 -0400
Received: from ey-out-1920.google.com ([74.125.78.144]:29106 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757341AbZGJWBm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 18:01:42 -0400
Received: by ey-out-1920.google.com with SMTP id 3so238069eyh.36
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=8Z23fCFOfGNc89UDwDYsiugUFF+t8Wjeg2Urh89SKuQ=;
        b=j1gTrOtkcUiztOymiqv3+JzUrSMiQv3jZJhBjm70hrr1h91w0zRPzuKsqK/efGRIf2
         y4FLTMDURZnMcjJcaF3/PnY5reH8ewJ4qb1ZG4Kp4fM4THQhIeTjw8T1PnorFKvbFxvD
         Tbc8D3GKRlEtmNckQzihExSQUat4oh1LvuL4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=uiHuflfwxuJzN9aMn24b9n+zu5lupsVJACliDtJwwd02hNxfGpEXJBZNn8L5RddWZV
         B9UXCVVASM0fq+/jrEBiiMnB84qC6daqpYf7NZA+aZM5AOTBDb+vKHn/K9qSvlbRGdhA
         7+eqTRchVFQNECqJy5Z9JyuVdwRj0XM1E4Iws=
Received: by 10.210.127.10 with SMTP id z10mr2951177ebc.21.1247263301426;
        Fri, 10 Jul 2009 15:01:41 -0700 (PDT)
Received: from ?192.168.1.13? (abwp104.neoplus.adsl.tpnet.pl [83.8.239.104])
        by mx.google.com with ESMTPS id 7sm1977058eyg.59.2009.07.10.15.01.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Jul 2009 15:01:41 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200907102354.43232.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123087>

For example for "Junio C Hamano" initials would be "JH".  Of course
initials are added (below shortened SHA-1 of blamed commit) only if
group of lines has 2 lines or more in it.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Let the bikeshedding begin!

Should it be "JH" or perhaps "J.H." for "Junio C Hamano"?  Or perhaps
username part of author email would be better solution than initials?
Should we use different style for those initials?

This patch was inspired by me adding the same feature in similar 
'blame_incremental' view in
  http://thread.gmane.org/gmane.comp.version-control.git/102657/focus=102712

 gitweb/gitweb.perl |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 36b1ce5..5336c92 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4860,6 +4860,14 @@ HTML
 			                             hash=>$full_rev,
 			                             file_name=>$file_name)},
 			              esc_html($short_rev));
+			if ($group_size >= 2) {
+				my @author_initials = ($author =~ /\b([[:upper:]])\B/g);
+				if (@author_initials) {
+					print "<br />" .
+					      esc_html(join('', @author_initials));
+					#           or join('.', ...)
+				}
+			}
 			print "</td>\n";
 		}
 		# 'previous' <sha1 of parent commit> <filename at commit>
-- 
1.6.3.3
