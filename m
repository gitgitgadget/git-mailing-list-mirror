From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Remove commit title from comitdiff_plain body
Date: Wed, 19 Mar 2008 23:28:58 +0100
Message-ID: <20080319222858.733.79714.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 23:31:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc6oM-00067Z-GV
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 23:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S941271AbYCSW3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 18:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S941269AbYCSW3P
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 18:29:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:39700 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935794AbYCSW3N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 18:29:13 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1342899ugc.16
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 15:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:subject:to:date:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        bh=UX03uvyueBnAkVpXWaKdRHilybFe55+L8vW2Dp8TcgI=;
        b=QBf0z0rE5dpyrDI0ulSL/GfCnHgGaDpQeerEW4vLWzOjyw5QASPXZ9R82wspONACSOh9w6T1X3wJK0whD+7rTimLoFzbL8CTwEpaUGWj8rjjIqYAz1ZZ+TIOrcde2FOO98AtA7mAEJM98q+LMpJcEJ77/fCRAL8Rl9rRJkD1Jq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=from:subject:to:date:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        b=tx4v2cGFeQu0Q9FEmMH3otumLtBw1r8uhEQjomV9xDPZgP8+NcST3qLUk4oHVpXpNcl8XbsaDu+4FsKpXPdnPhsC/YU/6dB4wRC9FC6qk/J+OhoNSPOmq025gQnHD3VkGbYb+eNtepCdJ09kzRcsg12iQUD3tL1dk0mI2xOUSHY=
Received: by 10.78.172.5 with SMTP id u5mr2718922hue.10.1205965748558;
        Wed, 19 Mar 2008 15:29:08 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.232.48])
        by mx.google.com with ESMTPS id d2sm1323706nfc.11.2008.03.19.15.29.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Mar 2008 15:29:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2JMSwFU000759
	for <git@vger.kernel.org>; Wed, 19 Mar 2008 23:28:59 +0100
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77574>



Remove commit title (first line of commit message) from the "body" of
commitdiff_plain view: it is present there already in format-patch
like Subject: header.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

 gitweb/gitweb.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)


diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ec73cb1..6e3ab85 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5122,8 +5122,11 @@ sub git_commitdiff {
 		print "Subject: " . to_utf8($co{'title'}) . "\n";
 
 		print "X-Git-Tag: $tagname\n" if $tagname;
-		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
+		print "X-Git-Url: " . $cgi->self_url() . "\n";
 
+		# remove title, i.e. first line of log
+		shift @{$co{'comment'}};
+		# leading empty lines would separate headers from body
 		foreach my $line (@{$co{'comment'}}) {
 			print to_utf8($line) . "\n";
 		}
