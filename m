From: Reece Dunn <msclrhd@googlemail.com>
Subject: Running 'git pull' from an unnamed branch
Date: Sun, 5 Apr 2009 22:33:57 +0100
Message-ID: <3f4fd2640904051433u199587c3wc9bf080d138944e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 23:35:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqa05-0004cG-CT
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 23:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625AbZDEVeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 17:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753004AbZDEVeB
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 17:34:01 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:37928 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbZDEVeA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 17:34:00 -0400
Received: by bwz17 with SMTP id 17so1634107bwz.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 14:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Hj4z7/x16wRfAyKANCP+jebG9X89Co9sy0s81ZiZA4A=;
        b=ZTa1IagV8Mx12tP6MEs0v57P9S/6FrLLzGhJDRrVek7P2ARsP52ZoZ+5V6tbw+is2j
         /FDW0NN6B2UbeVM22zQvNHtba0iYqkeLxG+kRs586aR1lqtiqyjE2zicWB6NMo2Vnfp+
         /FCM8rUf9uO0pi5Xl7cgs62uz0RdniUFln/fk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=TELHaU8T2OS9/JSrZZCOvdQCkb3kYGqnTPhG36zYHcVc2Mc7Trj7fhe/WO7OInBSEq
         +KJWPwP53b/PlvBIXHz+ep3NnVVf9sKMxNBlGdQ3xw0Kp1UM58qPLHGu2s6dhIxAA3B7
         ck9otCfFhhqSEQQ6nvB87BmgmRZYz0FZposeE=
Received: by 10.239.165.5 with SMTP id v5mr47093hbd.80.1238967237048; Sun, 05 
	Apr 2009 14:33:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115716>

Hi,

Here is something I have just recently tripped up on.

$ git pull
You asked me to pull without telling me which branch you
want to merge with, and 'branch..merge' in
your configuration file does not tell me either.  Please
name which branch you want to merge on the command line and
try again (e.g. 'git pull <repository> <refspec>').
See git-pull(1) for details on the refspec.

If you often merge with the same branch, you may want to
configure the following variables in your configuration
file:

    branch..remote = <nickname>
    branch..merge = <remote-ref>
    remote.<nickname>.url = <url>
    remote.<nickname>.fetch = <refspec>

See git-config(1) for details.

$ git branch
* (no branch)
  master

Running `git checkout master && git pull` fixed the above issue. The
patch below improves the error message for users that are in this
state.

Also, is "branch..remote" valid? Should this be "branch.remote"?

- Reece

>From c3933ba95f705dae1a41cb2ee6a282f3be0a6ab0 Mon Sep 17 00:00:00 2001
From: Reece Dunn <msclrhd@gmail.com>
Date: Sun, 5 Apr 2009 22:27:10 +0100
Subject: [PATCH] Improve the message when pulling to a headless branch.

---
 git-pull.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 8a26763..00a72dd 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -97,6 +97,10 @@ error_on_no_merge_candidates () {
 	echo "try again (e.g. 'git pull <repository> <refspec>')."
 	echo "See git-pull(1) for details on the refspec."
 	echo
+	echo "You may not be on a branch. In this case, you need to move"
+	echo "onto the branch you want to pull to (usually master):"
+	echo "    git checkout <branch>"
+	echo
 	echo "If you often merge with the same branch, you may want to"
 	echo "configure the following variables in your configuration"
 	echo "file:"
-- 
1.6.0.4
