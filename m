From: Mark Levedahl <mlevedahl@gmail.com>
Subject: git rebase--interactive, doesn't ignore commits already in upstream
Date: Wed, 01 Aug 2007 07:28:22 -0400
Message-ID: <46B06E56.2040206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 13:28:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGCNd-0004IO-23
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 13:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288AbXHAL22 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 07:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbXHAL22
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 07:28:28 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:52936 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbXHAL21 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 07:28:27 -0400
Received: by wx-out-0506.google.com with SMTP id h31so156323wxd
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 04:28:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=MiPrAkKkfUQhRMl1tnq6+XbkpSmAhaKGoFyMfbFF0Wz2zB5KTWovq0quEsR5wKjI1Ig0aKxIREfxaZFrYcZY3e4JXWuQFszrTizIZQEQ699IuKlY8YMhSdwdJ5c02fIK3lrA6Iw3ut6m5hzs+8zFwMFunIrwehh77RCmFQQtQZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=LwpqrgSI7WswKBew8iN2ut+/XWVBEFE9cJlP1NgbTVbTig17hkdFHPrDUwzv5Z4108cAShURqVjhKDjdeHntSs/umWRA3POfr4ugj0wBxtq5MlZLyJgkipIR0WvAEd+pjQ2rcIzCO33SpO5+yMhAKd4vrnJXiYNa4dlT7QszWOo=
Received: by 10.90.113.18 with SMTP id l18mr275615agc.1185967706972;
        Wed, 01 Aug 2007 04:28:26 -0700 (PDT)
Received: from ?10.71.0.114? ( [208.51.193.66])
        by mx.google.com with ESMTPS id 6sm566801agd.2007.08.01.04.28.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Aug 2007 04:28:25 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54428>

git rebase -i does not correctly ignore commits in the local branch that 
are also in upstream. For example, create a branch that is two commits 
back from upstream, add one of those on to the local branch

upstream=83b3df7d58
git checkout -f $upstream
git checkout -b foo $upstream~2
git cherry-pick $upstream~1
git rebase -i  $upstream

"git rebase -i" happily presents commit "$upstream~1" in the list to be 
applied to upstream. This of course results in a conflict. Should the 
user simply delete the offending commit from the presented list, git 
rebase -i then refuses to do anything, saying "Nothing to do."

Bare "git rebase" handles this case correctly (essentially fast forwards 
the branch to upstream.

Mark
