From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: replaced objects and working directory
Date: Sun, 25 Jul 2010 14:20:45 +1000
Message-ID: <AANLkTi=3=MX8+U4Oq4q_RACyxFYj-HmBYXFBxxQdFf_e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 25 06:21:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcsiI-0006Io-Oa
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 06:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179Ab0GYEVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 00:21:10 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37327 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab0GYEVF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 00:21:05 -0400
Received: by pvc7 with SMTP id 7so4065807pvc.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 21:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=vK7uRzgzPPNIj2wFuUzyxwyhjbY5/wt50UjHTWN7jjs=;
        b=juHEai2AtixdPu2+pCCgf7j723AtOcIjtuYbtj+80YW+oRyANaZdpo9BDLrv9w8SUu
         3hJsc6B0YaUEFjKCrmnA6Vxeb/K2vXV5c6Q/E2PZofLQaPKP+XF4O55L+wX5spcRzJag
         /SoiLyuea4veTzm/hevqxfapz1BDT0zYkxNww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=odMnthAyPOwDocvwW1TD7g2/LR5bf+SVDuUcwKfJO4em39mg3WI5EI2tAr1Lpsxj0V
         O1f/uKhFaVlcA/21V5ZIA/20tn7cvHqWU45461jGGCBtWoHhB2cCpQlvRcBGiMlpEqxA
         7EwDDUIWYtvjmfL8jurGMiYL3o+CqclyvV9ps=
Received: by 10.142.172.1 with SMTP id u1mr6639346wfe.137.1280031665459; Sat, 
	24 Jul 2010 21:21:05 -0700 (PDT)
Received: by 10.142.98.1 with HTTP; Sat, 24 Jul 2010 21:20:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151707>

Hi,

Should worktree (or the index) be aware of replaced objects? It seems
a bit odd to do "git checkout HEAD^" then "git status" reports
modification. Maybe "git status" and similar operations should also
check worktree version against the replaced version, in addition to
the original version?

$ git init
$ echo 1 > 1
$ git add 1
$ SHA1=`git hash-object 1`
$ git ci -m 1
$ echo 2 >> 1
$ git add 1
$ git ci -m 2
$ SHA2=`git hash-object 1`
$ git replace $SHA1 $SHA2
$ git st
# On branch master
nothing to commit (working directory clean)
$ git co HEAD^
$ git st
# Not currently on any branch.
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   1
#
no changes added to commit (use "git add" and/or "git commit -a")
$ git di
diff --git a/1 b/1
index d00491f..1191247 100644
-- 
Duy
