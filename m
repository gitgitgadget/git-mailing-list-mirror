From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/8] am: suppress error output from a conditional
Date: Fri, 10 May 2013 19:56:38 +0530
Message-ID: <1368196005-5354-2-git-send-email-artagnon@gmail.com>
References: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 10 16:25:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaoGD-000780-Cl
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756295Ab3EJOZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:25:15 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:59274 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756237Ab3EJOZM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:25:12 -0400
Received: by mail-pd0-f171.google.com with SMTP id r11so2837320pdi.30
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=+XV5c3vxyrn/PUnXE7A8ev4JT9thUatUqkQGhCY8/ck=;
        b=Drcv/pTufbjyrNRTDvbc3HehTanD5AF55e3jbLJ4YH8jMoI4hIWRmlu/LxxmzKpay4
         YDpBkZsVphiihTpBppYgXIhA0PPI+hUIxzuCQceYezKsqkeOTMFaa+hteRsC2/AhxYYe
         HZuANh5oRAwPdcpHILrD9p56Ieliix1+jdXTrYnRw+IMV6soPBidff45CdTt+3qUFX/V
         NdfamCUXx+wW4/7fuULvOJpaRrEKy6A+mRt5ZKWXMzyGrEUJusUDiVLeAn3w8VAXLUvs
         rjULwETc602qL77ANAk5rtB/K24KD3MzLDnpd4k8MWucZcMw+3kOO5Iy29NG0dOiuxx3
         EX7g==
X-Received: by 10.68.200.10 with SMTP id jo10mr17688713pbc.53.1368195911824;
        Fri, 10 May 2013 07:25:11 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id nt2sm2915928pbc.17.2013.05.10.07.25.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 07:25:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.gc14258d
In-Reply-To: <1368196005-5354-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223841>

In preparation for a later patch that creates $dotest/autostash in
git-rebase.sh before anything else happens, don't assume that the
presence of a $dotest directory implies the existence of the $next and
$last files.  The check for the files is in a conditional anyway, but
`cat` is executed on potentially non-existent files.  Suppress this
error output.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-am.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index c092855..88aa438 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -446,8 +446,8 @@ done
 # If the dotest directory exists, but we have finished applying all the
 # patches in them, clear it out.
 if test -d "$dotest" &&
-   last=$(cat "$dotest/last") &&
-   next=$(cat "$dotest/next") &&
+   last=$(cat "$dotest/last" 2>/dev/null) &&
+   next=$(cat "$dotest/next" 2>/dev/null) &&
    test $# != 0 &&
    test "$next" -gt "$last"
 then
-- 
1.8.3.rc1.52.gc14258d
