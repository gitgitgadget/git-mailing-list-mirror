From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/4] git-instaweb: Use $conf, not $fqgitdir/gitweb/httpd.conf
Date: Thu, 23 Jun 2011 21:56:37 +0200
Message-ID: <20110623195516.18265.825.stgit@localhost.localdomain>
References: <20110623194624.18265.82482.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Gurjeet Singh <singh.gurjeet@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 21:57:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZq1W-0002Zb-95
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 21:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932968Ab1FWT5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 15:57:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41834 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932704Ab1FWT5D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 15:57:03 -0400
Received: by fxm17 with SMTP id 17so1475228fxm.19
        for <git@vger.kernel.org>; Thu, 23 Jun 2011 12:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:subject:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=LX48uNd7jek5zC542NJw37VDBvUnTCGVDkxyQB3kO7c=;
        b=adnb3JiDWI3KxcnP4cSa48L1ewy7CRKDaEhX4HTs2PpKCiIPYGf1/FxzksiFz3Ck3V
         QJjddWSuN8hfwXzeOhgw3FZSPDFF78lCEpW7zUROBOuPWqr1av/dyiLfgcGuXUKQrEN2
         VcqTpcgj3gP8JEzHyB1viVZjx/44SfLYcX2mI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=eAEPfoFeAkJjaGSPfuAkZn598BcawQKcnbz6GA6FT8ihU7Op0c881UF7ayx6N8ojwk
         laEz4yvrOEeE3U2GMeQSdulJMNEHmnceo3+tZlK7MCV7Zq+FNiQj8r0X0naQhC0ZgOw2
         CS+3C+Fv9Wzj9Pc/RJwTh4cpJaxXEKUMinokA=
Received: by 10.223.33.6 with SMTP id f6mr3202296fad.85.1308859022275;
        Thu, 23 Jun 2011 12:57:02 -0700 (PDT)
Received: from localhost.localdomain (abva28.neoplus.adsl.tpnet.pl [83.8.198.28])
        by mx.google.com with ESMTPS id p3sm577653fan.21.2011.06.23.12.57.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Jun 2011 12:57:01 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5NJubVj018475;
	Thu, 23 Jun 2011 21:56:47 +0200
In-Reply-To: <20110623194624.18265.82482.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176290>

Don't repeat yourself: use "$conf" instead of its [current] contents,
namely "$fqgitdir/gitweb/httpd.conf".

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Straighforward improvement.  Note that currently $conf is constant,
and doesn't change its value.

 git-instaweb.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 49bab7b..2be22a0 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -103,7 +103,7 @@ start_httpd () {
 	case "$httpd" in
 	*mongoose*|*plackup*)
 		#These servers don't have a daemon mode so we'll have to fork it
-		$full_httpd "$fqgitdir/gitweb/httpd.conf" &
+		$full_httpd "$conf" &
 		#Save the pid before doing anything else (we'll print it later)
 		pid=$!
 
@@ -117,7 +117,7 @@ $pid
 EOF
 		;;
 	*)
-		$full_httpd "$fqgitdir/gitweb/httpd.conf"
+		$full_httpd "$conf"
 		if test $? != 0; then
 			echo "Could not execute http daemon $httpd."
 			exit 1
