From: Alberto Bertogli <albertito@gmail.com>
Subject: [PATCH] Allow git-svnimport to take "" as the trunk directory.
Date: Tue, 14 Aug 2007 01:03:18 -0300
Message-ID: <11870641981207-git-send-email-albertito@gmail.com>
Cc: llucax@gmail.com, Alberto Bertogli <albertito@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 14 06:03:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKnd7-0001HL-SC
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 06:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbXHNEDh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 00:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbXHNEDh
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 00:03:37 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:12384 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbXHNEDf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 00:03:35 -0400
Received: by py-out-1112.google.com with SMTP id d32so2749116pye
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 21:03:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=MUcFbXss4OslJOYk67dv7SAbxJDz+5Jd1/HlaEAHaNFkBp786XfNgl3O30D5HOYqGoUKEzjPPDLSOa6bGXswBJuYEddKlyqHuI++VYMVYiHJKN7LTv9sB+OmHjpkePz15MYA/axq6+GEUNXV7modZ5OMJ2d8Xg3tUyyvrkFw8H0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=h1EvYEVCRb4PseGUknubLWUK37l09c1t/hpMaml/7e1WLw6MBUiwC4abNKuKesLrS2uurpZYllmSaCYAH8LfdlxZV0mB5aIcONj0CWNzlT9W0oKkYYLow8hD3tDB7rLpZ2Z0/mVw8/CgjEaODz7Xs/dQVfhQk8/ky5skbP1SRMI=
Received: by 10.35.115.18 with SMTP id s18mr9840670pym.1187064214160;
        Mon, 13 Aug 2007 21:03:34 -0700 (PDT)
Received: from gmail.com ( [201.253.220.24])
        by mx.google.com with ESMTPS id 15sm24718468nzo.2007.08.13.21.03.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Aug 2007 21:03:32 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.rc4.67.gf9286-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55802>

Some repositories started with the trunk in "/" and then moved it to the
standard "trunk/" location.

On these repositories, the correct thing would be to call git-svnimport -T "",
but because of the way the options are handled, it uses the default "trunk"
instead of the given empty string. This patch fixes that behaviour.

Reported by Leandro Lucarella <llucax@gmail.com>.

Signed-off-by: Alberto Bertogli <albertito@gmail.com>
---

While the same could be done for tags and branches, I don't think it makes
much sense.


git-svnimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svnimport.perl b/git-svnimport.perl
index b73d649..8c17fb5 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -49,7 +49,7 @@ getopts("A:b:C:dDFhiI:l:mM:o:rs:t:T:SP:R:uv") or usage();
 usage if $opt_h;
 
 my $tag_name = $opt_t || "tags";
-my $trunk_name = $opt_T || "trunk";
+my $trunk_name = defined $opt_T ? $opt_T : "trunk";
 my $branch_name = $opt_b || "branches";
 my $project_name = $opt_P || "";
 $project_name = "/" . $project_name if ($project_name);
-- 
1.5.3.rc4.67.gf9286-dirty
