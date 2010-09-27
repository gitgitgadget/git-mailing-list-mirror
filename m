From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH] git-send-email.perl: ensure $domain is defined before using it
Date: Sun, 26 Sep 2010 22:18:01 -0500
Message-ID: <1285557481-16357-1-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, brian@gernhardtsoftware.com,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 27 05:18:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P04Eg-000283-0Y
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 05:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758686Ab0I0DSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 23:18:33 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56020 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758362Ab0I0DSc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 23:18:32 -0400
Received: by gxk9 with SMTP id 9so1414376gxk.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 20:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=2nD0t4yq8qOpwdf6r6aPWDCjpz5ISSUQEylbV+Kvjvc=;
        b=O6IkOZdQLhSEPChyeNM8iGzJ0hwH+TgzeKBPdvw/LZp3YKQWmPoM4bwtbuFSIhnCNm
         2khYm43ctMMOIvIGRluJT1KSEQYklbukjWnkCPqWw/nfq+CcH31cgFTWuY6Z5yk4HcoQ
         dVDV8+hvW0XrJL+aziVRdulTs+oHy/OO/aCLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=gu0MJY5BrP+HUBmFy7Pj0DdltdLqgf7BkzIKsp/0vsSPFWhRKlCC886yBqhLBVWS1u
         KbeVrORjdDpWZjZEkqZJtFEX2jYA/woiJmDdh3E+fLmGcV80wpSbn1KninUkO0OI5+jy
         tnzpXl5GX+3v5b5QiO1k0Vw3xEGuU4j0roOVc=
Received: by 10.151.139.16 with SMTP id r16mr8140888ybn.168.1285557511398;
        Sun, 26 Sep 2010 20:18:31 -0700 (PDT)
Received: from localhost.localdomain ([96.19.141.3])
        by mx.google.com with ESMTPS id m11sm7620585ybn.4.2010.09.26.20.18.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 20:18:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.geb284
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157291>

valid_fqdn() may attempt to operate on an undefined value if
Net::Domain::domainname fails to determine the domain name.  This causes
perl to emit unpleasant warnings.

So, add a check for whether $domain has been defined before using it.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6dab3bf..e1f29a7 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -895,7 +895,7 @@ sub sanitize_address {
 
 sub valid_fqdn {
 	my $domain = shift;
-	return !($^O eq 'darwin' && $domain =~ /\.local$/) && $domain =~ /\./;
+	return defined $domain && !($^O eq 'darwin' && $domain =~ /\.local$/) && $domain =~ /\./;
 }
 
 sub maildomain_net {
-- 
1.7.3.1.geb284
