From: Robert Shearman <robertshearman@gmail.com>
Subject: [PATCH] git-rebase.sh: Display error output from git-checkout when detaching HEAD fails.
Date: Fri, 11 Jul 2008 22:26:59 +0100
Message-ID: <1215811619-28512-1-git-send-email-robertshearman@gmail.com>
Cc: Robert Shearman <robertshearman@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 23:28:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHQA0-0002Bg-UG
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 23:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940AbYGKV1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 17:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753495AbYGKV1O
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 17:27:14 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:1278 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbYGKV1N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 17:27:13 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2091006fkq.5
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 14:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=EaT0EQiOP1QaBE+1T2Sb7LFlW9nEQ2Lf5YNKF8MUnOY=;
        b=pqGwxNmg1Y5CZP/fBfsZWifMjDBle1EcQoncEK4FLrjSRVijqB/MMNHgQwPdt8CKba
         nhaPAW82nczRdAjHKTl9awuBX9i8UeVnl06/pAz6um7WJQyaQicgam+d8ZWwx8IH2giz
         Q+YbuP+c2598Kp95Xca0Hj2YV160qhLNKpaG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BUmfvk7NDcaXzzkdx7km2Uil8loWuJImP+5f2v1L+KSPEKb7qJ824nPZlZG+In7V/n
         oKldZjc+NsrFW4FrIQt6sfBgl0o5kX8e1ICqZTE3CV7JjP9eiYMiFhpCjtWOO/e3ASy4
         Q1sMXkbLhAuF8vYng66vwM6nudRx9XXT1UTWE=
Received: by 10.125.76.2 with SMTP id d2mr3235105mkl.146.1215811632108;
        Fri, 11 Jul 2008 14:27:12 -0700 (PDT)
Received: from localhost.localdomain ( [86.155.123.155])
        by mx.google.com with ESMTPS id 13sm2881141fks.6.2008.07.11.14.27.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Jul 2008 14:27:11 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.2.225.g4596.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88177>

The "git checkout" command executed could fail if, for example, upstream contains a file that would overrwrite a local, untracked file. The output redirection didn't work as stderr was redirected to /dev/null, as was stdout. This appears to be not what was intended so the order of redirections is fixed so that stderr is redirected to stdout instead.
---
 git-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index e2d85ee..0da2210 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -376,7 +376,7 @@ fi
 
 # Detach HEAD and reset the tree
 echo "First, rewinding head to replay your work on top of it..."
-git checkout "$onto^0" >/dev/null 2>&1 ||
+git checkout "$onto^0" 2>&1 >/dev/null ||
 	die "could not detach HEAD"
 # git reset --hard "$onto^0"
 
-- 
1.5.6.2.225.g4596.dirty
