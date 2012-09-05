From: Ken Dreyer <ktdreyer@ktdreyer.com>
Subject: [PATCH] cvsimport: strip question marks from tags
Date: Tue,  4 Sep 2012 20:53:38 -0600
Message-ID: <1346813618-20279-1-git-send-email-ktdreyer@ktdreyer.com>
Cc: gitster@pobox.com, Ken Dreyer <ktdreyer@ktdreyer.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 04:54:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T95ko-0001du-K8
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 04:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038Ab2IECxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 22:53:48 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52848 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844Ab2IECxr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 22:53:47 -0400
Received: by ieje11 with SMTP id e11so70814iej.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2012 19:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=ChLqzx5DfpPLm6lGLbhVKIcFW8rOLJULE01fCUmq8Lo=;
        b=KXmRMCma6UEofsu/WedwUz5tqciScnHYw8goASy1Wwmka32pFYcbG8ViWTwmmuGv9w
         Zp5hZn+XtcZTaN9pfIphYHlNciW8ahpAD1lbXY28/tIWuCYueq/V+ePISxSyfRNcyO6z
         X7m2IcXKhyF7Y7oOuvZrP7Dp31OFZkgABqc6UqDN8iaocVE/PfMyzA01ukP8zNpMA+xy
         qtxXdNgWzZSGcgWlgLE3pjVFiQCSzJ9qWIq1dAC6PXXhamiIVkXdCpa9R38qOgO1+gXR
         xFQl2+1wTlopeim0ZR1kcBfbv3netmKsDdE9g/D7mn82ignXs6oBDPMqGiy/1hpJFFzo
         CkHA==
Received: by 10.42.155.200 with SMTP id v8mr19501255icw.12.1346813627023;
        Tue, 04 Sep 2012 19:53:47 -0700 (PDT)
Received: from phos.ktdreyer.com (c-67-190-20-168.hsd1.co.comcast.net. [67.190.20.168])
        by mx.google.com with ESMTPS id ho1sm6350598igc.3.2012.09.04.19.53.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Sep 2012 19:53:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.4
X-Gm-Message-State: ALoCoQkRZTdwbx8ln93iOD2X13KcLGW9zNeEWMdtb13clAN3xuXJPlfxb8DasekkGnEKOafzSMft
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204795>

The "?" character can be present in a CVS tag name, but git's
bad_ref_char does not allow question marks in git tags. If
git-cvsimport encounters a CVS tag with a question mark, it will error
and refuse to continue the import beyond that point.

When importing CVS tags, strip "?" characters from the tag names as we
translate them to git tag names.

Signed-off-by: Ken Dreyer <ktdreyer@ktdreyer.com>
---
 git-cvsimport.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 8d41610..36f59fe 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -890,6 +890,7 @@ sub commit {
 		$xtag =~ tr/_/\./ if ( $opt_u );
 		$xtag =~ s/[\/]/$opt_s/g;
 		$xtag =~ s/\[//g;
+		$xtag =~ s/\?//g;
 
 		system('git' , 'tag', '-f', $xtag, $cid) == 0
 			or die "Cannot create tag $xtag: $!\n";
-- 
1.7.11.4
