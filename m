From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Do not show 'patch' link in 'commit' view for merges
Date: Wed, 30 Sep 2009 22:21:53 +0200
Message-ID: <20090930201953.22301.73887.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 30 22:22:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt5h3-0004HZ-3C
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 22:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbZI3UWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 16:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbZI3UWU
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 16:22:20 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:54815 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbZI3UWU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 16:22:20 -0400
Received: by fxm18 with SMTP id 18so5659314fxm.17
        for <git@vger.kernel.org>; Wed, 30 Sep 2009 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=xEdJnZS+n6Uu/j/Uu/yFZwWumwUagT0ryzQWrp/l55k=;
        b=ufpPq8B7NoF7+qZhH9xI7uCYvmYdj3L4oFhhwk7WiNiVFxWnaiAYd0Dzk5Dp9GkpiE
         gTTuFlOplySHDDBLcPIb7FjafnC17ldthqu4FlC1Q/wDgap+/qCWxBJazhT+Wu4dhjkg
         oqlXUORnqzdqMd+Vs/OaptqEOLhuLP4fvDRss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=C601xzbAl7GGcZy/WIjtXbL5MKAGr2nC/mkXb79sKE9QAPtl+miDzQ8hQPKo0VHjOf
         tgie98g2D+8STQ9F7nBGMarCOfOavZ/+60Zr21/f+Xn+MA9GAO5UougvNpjMXoEiEPLg
         yLHoumM3g6oURbC09/UICJMk97kNxTW3uUV1Y=
Received: by 10.86.226.5 with SMTP id y5mr386861fgg.36.1254342143233;
        Wed, 30 Sep 2009 13:22:23 -0700 (PDT)
Received: from localhost.localdomain (abvd215.neoplus.adsl.tpnet.pl [83.8.201.215])
        by mx.google.com with ESMTPS id 12sm93182fgg.8.2009.09.30.13.22.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Sep 2009 13:22:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n8UKLrlu022360
	for <git@vger.kernel.org>; Wed, 30 Sep 2009 22:22:04 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129354>

Show 'patch' link in the 'commit' view only for commits which have
exactly one parent, otherwise call to git-format-patch would fail for
the hyperlinked 'patch' action.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Just noticed this issue, thanks indirectly to 
"Re: How can I download a git commit as a diff patch?"
thread.

This is conservative change: perhaps we could extend 'patch' view to
work also for root commit...

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 24b2193..fb045a1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5328,7 +5328,7 @@ sub git_commit {
 			} @$parents ) .
 			')';
 	}
-	if (gitweb_check_feature('patches')) {
+	if (gitweb_check_feature('patches') && @$parents == 1) {
 		$formats_nav .= " | " .
 			$cgi->a({-href => href(action=>"patch", -replay=>1)},
 				"patch");
