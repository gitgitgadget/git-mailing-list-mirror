From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH 2/2] Add test for git clean -e.
Date: Tue, 20 Jul 2010 12:30:13 -0400
Message-ID: <4cc65cc57f6eea298401a2de0aa5fb378703fb38.1279643093.git.jaredhance@gmail.com>
References: <e257dd98b7493dcd72de9cf62d5847116e030ed0.1279564639.git.jaredhance@gmail.com>
 <cover.1279643093.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 20 18:30:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObFi7-0004Oa-Uv
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 18:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761319Ab0GTQaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 12:30:21 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:46337 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758607Ab0GTQaU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 12:30:20 -0400
Received: by qyk38 with SMTP id 38so2643598qyk.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 09:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=atPKZ/GejNrtqhnZiEFd/Q35997JVEF33dRAlAhJ3lo=;
        b=IB02Yy2SKGDqcUEsiLGjr/T+RbQ3x4hlEMSvKsDvCjX3SZ0MxV1swdZzpn2hXNPL5P
         cDCnvIhEUSdnmIdrbNe/KnjcpcFVxs+upvtRKR7v7h1ywwyplG+4b3hXpaxT4xiDESqH
         xfsqEd17eCaLqIb78cQe8KZqYKH3kLxwMA+aI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=x43XisSIEf9KbRg6NzlU4FTA6q+Xzlg/PEdr/XGae53s/gflDV2qFi/eGaH7XSsJkE
         NrfVkW+2FFyCbrw2dKF50CZeMIDeiQMunm2HrZeuCMBYHanKgLY85sVma5Jd/Kypp8D4
         apYWbKkOzuHQzlV47ukej2j0qWBLSwOTeGqUw=
Received: by 10.224.44.77 with SMTP id z13mr5691009qae.342.1279643418839;
        Tue, 20 Jul 2010 09:30:18 -0700 (PDT)
Received: from localhost.localdomain (cpe-75-186-1-50.cinci.res.rr.com [75.186.1.50])
        by mx.google.com with ESMTPS id js14sm28186538qcb.6.2010.07.20.09.30.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 09:30:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1279643093.git.jaredhance@gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151326>


Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 t/t7300-clean.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 7d8ed68..c6df26d 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -438,4 +438,20 @@ test_expect_success 'force removal of nested git work tree' '
 	! test -d bar
 '
 
+test_expect_success 'git clean -e' '
+	rm -fr repo &&
+	mkdir repo &&
+	(
+		cd repo &&
+		git init &&
+		touch 1 2 3 known &&
+		git add known &&
+		git clean -f -e "1 2" &&
+		test -e 1 &&
+		test -e 2 &&
+		! (test -e 3) &&
+		test -e known
+	)
+'
+
 test_done
-- 
1.7.1.1
