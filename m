From: Allan Caffee <allan.caffee@gmail.com>
Subject: [PATCH 1/3] t4202-log: extend test coverage of graphing
Date: Wed, 22 Apr 2009 17:27:15 -0400
Message-ID: <20090422212715.GA30442@linux.vnet>
References: <20090422193838.GA1841@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 23:29:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwk0A-0002C9-6d
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 23:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbZDVV1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 17:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755119AbZDVV1V
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 17:27:21 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:49602 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845AbZDVV1V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 17:27:21 -0400
Received: by wf-out-1314.google.com with SMTP id 26so162456wfd.4
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 14:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=bEqQYQY5XAJmSnkw/yAwl2eclL74nvcFf3SU12Pd6VQ=;
        b=sFcdYGWsbIKNY/ok0SSh3D1JO3IKzYB4hdJTrUKc9Euq6Qnaq9E9DD0K3Gzhv3ufPm
         DfWli0EqqEWexT8VCY+GXc7BMULk05P8GZcQNF3Npjf5TJLx1a70cdRadmCOPdnk9tRI
         zY4n4eAuBAY8L20wIXah/wYeC3lvz+kW0wHaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=P1e/IG7ZWIDLCMkZ4XevOekVgTeLz2Hr+512Wx3NIBvcz5fwM3nMGj2owkKzCfeETc
         BDbszhUJTHaIktbce28Y5wQv+RYfLKhcGv36jfNzOBfzontqsnywMkN4hO3xQg6OFQ3l
         /qM4g9GJrHzsICqUpMf+Ru1ZQpgftsspdDb1U=
Received: by 10.143.38.6 with SMTP id q6mr73266wfj.70.1240435640533;
        Wed, 22 Apr 2009 14:27:20 -0700 (PDT)
Received: from linux.vnet (pool-71-185-49-127.phlapa.fios.verizon.net [71.185.49.127])
        by mx.google.com with ESMTPS id 32sm975088wfc.6.2009.04.22.14.27.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Apr 2009 14:27:19 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20090422193838.GA1841@linux.vnet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117267>

Extend this test to cover the rendering of graphs with octopus merges
and pre_commit lines.

Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---
 t/t4202-log.sh |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

This patch by itself should cause the test to fail.  Proving that the
following two patches are required too return us to sane behaviour.

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index b986190..64502e2 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -284,10 +284,36 @@ test_expect_success 'set up more tangled history' '
 	git merge master~3 &&
 	git merge side~1 &&
 	git checkout master &&
-	git merge tangle
+	git merge tangle &&
+	git checkout -b reach &&
+	test_commit reach &&
+	git checkout master &&
+	git checkout -b octopus-a &&
+	test_commit octopus-a &&
+	git checkout master &&
+	git checkout -b octopus-b &&
+	test_commit octopus-b &&
+	git checkout master &&
+	test_commit seventh &&
+	git merge octopus-a octopus-b
+	git merge reach
 '
 
 cat > expect <<\EOF
+*   Merge branch 'reach'
+|\
+| \
+|  \
+*-. \   Merge branches 'octopus-a' and 'octopus-b'
+|\ \ \
+* | | | seventh
+| | * | octopus-b
+| |/ /
+|/| |
+| * | octopus-a
+|/ /
+| * reach
+|/
 *   Merge branch 'tangle'
 |\
 | *   Merge branch 'side' (early part) into tangle
-- 
1.5.6.3
