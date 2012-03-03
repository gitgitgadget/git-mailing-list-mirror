From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 4/5] gitweb.psgi: Allow passing arguments to Plack::Runner
Date: Sat,  3 Mar 2012 18:57:02 +0100
Message-ID: <1330797423-22926-5-git-send-email-jnareb@gmail.com>
References: <1330797423-22926-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 18:57:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3tCz-00031I-1K
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 18:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965Ab2CCR5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 12:57:23 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:35946 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab2CCR5P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 12:57:15 -0500
Received: by eekc41 with SMTP id c41so981398eek.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 09:57:14 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.50.20 as permitted sender) client-ip=10.14.50.20;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.50.20 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.50.20])
        by 10.14.50.20 with SMTP id y20mr367994eeb.88.1330797434873 (num_hops = 1);
        Sat, 03 Mar 2012 09:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NHId6VZSDm+z/wdaKle6Mn4npx23LndmzMmJrqCqj0U=;
        b=vLHLnfbBFnMpG17GyTAMv87qtfAO+sDDKfi2bPMwwFO5+GSBDSyTJWLj1qph6kIxTa
         eWZQ3lqH7UK8JBhfgGj4v13i0WdzH1C7UxP51cypixOIixzZQjdc4ibrlZ+e7uVcCdq4
         8sGL/px5bedRMHsUeIEQkXFmt8bFEKMwISigZjXsVAWi2X8hwN5xUSv0IJx2HuGIHCQ9
         3w5bcTGgtdmAQgEKnuKo2HNtARs2RFLu5PYvp5qt9Oy3SSmhqkcWQ56Z0OiJe9DAs9OM
         qJcbhSQbK0jNHpRYdtGMY1ri6kiIs2z8v9addAf+0isUo7zmHpcfYdasqf7iBCmOB1ZU
         p2lA==
Received: by 10.14.50.20 with SMTP id y20mr266552eeb.88.1330797434830;
        Sat, 03 Mar 2012 09:57:14 -0800 (PST)
Received: from localhost.localdomain (abwo91.neoplus.adsl.tpnet.pl. [83.8.238.91])
        by mx.google.com with ESMTPS id s48sm36973616eem.0.2012.03.03.09.57.14
        (version=SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 09:57:14 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1330797423-22926-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192126>

Command options after first '--' are passed literally to Plack::Runner
as arguments, in addition to default ones used.  This way you can
select PSGI server, host, port, etc.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Could be squashed with 4/5, now that I realized that it is that simple.

 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0dbdd15..6bd7b08 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1312,7 +1312,8 @@ sub run_psgi_app {
 
 		my $runner = Plack::Runner->new();
 		$runner->parse_options(qw(--env deployment),
-		                       qw(--host 127.0.0.1));
+		                       qw(--host 127.0.0.1),
+		                       @ARGV);
 		$runner->run($app);
 	}
 }
-- 
1.7.9
