From: Jay Soffian <jaysoffian@gmail.com>
Subject: rebasing a merge
Date: Thu, 17 Jun 2010 11:51:03 -0400
Message-ID: <AANLkTilY_9j2sXlplhYB4FPAIAzuPBg2UyUTEk4DaaYF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 17 17:51:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPHN2-00065a-KA
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 17:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760079Ab0FQPvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 11:51:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43129 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755277Ab0FQPvF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 11:51:05 -0400
Received: by iwn9 with SMTP id 9so6921696iwn.19
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=SltAadgdqiXFBU0AQUAM+vLipZ/8L15rApwmQGVE434=;
        b=vrNSkhZmpVbPdM3/C6mAmlx+JYvHwzvUOxStriuzRLrQ6s+iD/1ZZPt7mSscIy0ytc
         toQuGm3RsZxPKHcYl2wK+4TiehTLQn+omCMPwWmvqrt6pHsiziQ3MeXUF+sImScskbtd
         zy+8dSsZh0Vpj4KCufFk5bcBGHli6GqfVyHYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=LMkK4+zVs3umSfJTU8vimIiFG87k9LjS1mC8xzB/a/geNVn9dvLy8WTyP3z9rmVgwf
         Bb8LycXdVM2bdO/BlVj6zv8nJetgLwUGUITjZmxUdWsz65N7jhwdeG3ktYfw0ine87mQ
         D1QeJyK6Nbz9T2xSbOxfYf7HHM8hN0gmxSL34=
Received: by 10.231.130.162 with SMTP id t34mr10948167ibs.157.1276789863138; 
	Thu, 17 Jun 2010 08:51:03 -0700 (PDT)
Received: by 10.231.120.19 with HTTP; Thu, 17 Jun 2010 08:51:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149315>

Say you have:

-o--o--o--m master
         /
--o--o--o   side

You're ready to push the merge, but in the mean time:

         o--o--o origin/master
        /
-o--o--o--m master
         /
--o--o--o   side

For various reasons, when this happens I want to rebase my merge (m).
It is almost always a merge that involves a fair amount of conflict
resolution. Here's how I've been doing it, but I'll bet there's a less
convoluted way:

git merge origin/master                      # resolve as needed
git branch -f temp                           # save the tree
git reset --hard ORIG_HEAD                   # restore back to the merge
git rebase -i -p --onto origin/master HEAD~1 # rebase the merge
git checkout temp -- .                       # resolve the conflict here
git rebase --continue                        # commit the resolution
git diff temp                                # no differences
git branch -D temp

Thoughts?

j.
