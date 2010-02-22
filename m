From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] am: remove rebase-apply directory before gc
Date: Mon, 22 Feb 2010 08:35:46 -0600
Message-ID: <20100222143545.GA4791@progeny.tock>
References: <20100222140911.30949.49607.reportbug@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@debian.org>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 15:35:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjZNw-0000RJ-JC
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 15:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470Ab0BVOfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 09:35:39 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:62511 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab0BVOfi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 09:35:38 -0500
Received: by yxe38 with SMTP id 38so2506988yxe.4
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 06:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=scpZ6Kjvg2FUu9I4oaEIK0kGPDLCa2cquUzZ4fOd9xY=;
        b=qi62fCgKeE9RBzzwJHNkzVLLzcy/tWhATOCeBr1PB83iZ9STMZ31nVW40oC7a0+X9b
         sh6g/iR60MN3Cg6u0A2GumklNsSR9tZAwRZfwuPJ+HpBQtqToK6yK5fHB0LqF6bNHETw
         EQkfI7Pi/tw0YMY4P2NVBrk726zkn1GUbR/Kw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pcMTAT5xPdL0Qhzd57XoXNT7xtuhRYdyq/Hgm3xI0AKH9G6sA/DbQBLXVYl3NXIHZ0
         glaMttiinKyp6qYtuSR5s3OPHq7vfR0pHI3UUuEtgeG7D49qMJ7i9CREnxHxnuxrkRPV
         oj46/1IjT6mfIBbGgZtkJwiYKtDCgEDoWI4sg=
Received: by 10.90.177.9 with SMTP id z9mr1467223age.93.1266849337350;
        Mon, 22 Feb 2010 06:35:37 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm3421140gxk.7.2010.02.22.06.35.36
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 06:35:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100222140911.30949.49607.reportbug@rakim.wolfsonmicro.main>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140685>

When git am does an automatic gc it doesn't clean up the rebase-apply
directory until after this has finished.  This means that if the user
aborts the gc then future am or rebase operations will report that an
existing operation is in progress, which is undesirable and confusing.

Reported by Mark Brown <broonie@debian.org> through
http://bugs.debian.org/570966

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-am.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 3c08d53..ebfbee5 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -776,6 +776,5 @@ do
 	go_next
 done
 
-git gc --auto
-
 rm -fr "$dotest"
+git gc --auto
-- 
1.7.0
