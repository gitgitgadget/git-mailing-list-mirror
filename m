From: Christian Himpel <chressie@googlemail.com>
Subject: [PATCH] git-am: force egrep to use correct characters set
Date: Fri, 25 Sep 2009 18:43:20 +0200
Message-ID: <f0bd48168975c3b2328cf26f9a37a0f54b898473.1253896646.git.chressie@gmail.com>
References: <215cc4f241162377b9249c2b3d74050cc77bac16.1253893253.git.chressie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 25 18:46:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrDvn-00018A-Ec
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 18:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbZIYQnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 12:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbZIYQnU
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 12:43:20 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:59451 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbZIYQnT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 12:43:19 -0400
Received: by bwz6 with SMTP id 6so61492bwz.37
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 09:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bLE6C5t+rXiVsn7OQYUe2xHtI9UXz1/llSFrXcuXJtA=;
        b=fbXhgEdikRsj/uYtgLJmluv2rLNbdAsUZrjM5Rbrc5JGgAzOwWMpi+ZLsz7sQdpwQE
         +gIC+JG9AQ5qVR2G25DQ+kZ07teXyfvanlkuCOzXInitqNLb0bE1f2ae3zgpzxB0iKSx
         YjCBfXaarzspAVVJkaRc3wTU+TZ0WsBgAurDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=u+IANTdCA4+RuVh3F6iIS5wtXPN6egPcNxfSHlowwPkqJYab6TexhVme3w/BmvemnQ
         A85gn8AkSc5mDuJd+UwDbe9b6ws2dIPutXdmPGu7V0g/ak/66rwLqcpP6fg03FPHFZ06
         +0UHrthwSKTkk38mrB5xrrYon2VbxYLmgtWVg=
Received: by 10.204.32.146 with SMTP id c18mr299555bkd.88.1253897002578;
        Fri, 25 Sep 2009 09:43:22 -0700 (PDT)
Received: from mrslave (HSI-KBW-078-043-091-043.hsi4.kabel-badenwuerttemberg.de [78.43.91.43])
        by mx.google.com with ESMTPS id 9sm72604fks.54.2009.09.25.09.43.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 25 Sep 2009 09:43:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <215cc4f241162377b9249c2b3d74050cc77bac16.1253893253.git.chressie@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129097>

According to egrep(1) the US-ASCII table is used when LC_ALL=C is set.
We do not rely here on the LC_ALL value we get from the environment.

Signed-off-by: Christian Himpel <chressie@gmail.com>
---

sorry for being so noisy, but forgot to signoff last time

 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 0ddd80f..c132f50 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -205,7 +205,7 @@ check_patch_format () {
 			# and see if it looks like that they all begin with the
 			# header field names...
 			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p "$1" |
-			egrep -v '^[!-9;-~]+:' >/dev/null ||
+			LC_ALL=C egrep -v '^[!-9;-~]+:' >/dev/null ||
 			patch_format=mbox
 		fi
 	} < "$1" || clean_abort
-- 
1.6.4.4
