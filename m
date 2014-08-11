From: Chris Packham <judge.packham@gmail.com>
Subject: Sharing merge conflict resolution between multiple developers
Date: Mon, 11 Aug 2014 16:59:15 +1200
Message-ID: <CAFOYHZCiKC4TR4jFVUB=W5qbDG8XvB2Obx1ZfTH8OF3E_c5BnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 06:59:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGhhe-0007RO-Ir
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 06:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbaHKE7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 00:59:16 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34409 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbaHKE7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 00:59:16 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so10116816pde.37
        for <git@vger.kernel.org>; Sun, 10 Aug 2014 21:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=+3OfXh0AjQ3M9MmiK9DWVVa0tp8aiNu72IFUD6QSRsA=;
        b=Tvthroxp+b5eXA7q4Y7StO6yAUrbZ+IfVVPdTRSs4rLj7zr7WamdNa7Tg1JLR20jJq
         x9dOBP7zctwH5BUXVvvsWqFc8ZV+g+M7UOYuvi3S3sbUhC7LnFwogcnSLA5Z4i2bfrL7
         Sv8/4uiLeZbqIyHhp2QdeyLc6mQvcfdmIVoJuPE9atRjArBUKX+FPssq5khZq4TmY//5
         3bqHOayVBCYLOBe7ztwIgYaH/U7TMFGFIw3Bo3cyEQNSvyp2qSHpg6LSnvlQ3U9IydSc
         8pmE1ZXxbh8cJ+rRiEYZeBMcfBa5cjjd0hDDe0OIRWLw108Og2Yhb5PcvQfq/4NdvIdn
         zMAw==
X-Received: by 10.70.62.5 with SMTP id u5mr16652687pdr.100.1407733155809; Sun,
 10 Aug 2014 21:59:15 -0700 (PDT)
Received: by 10.70.98.140 with HTTP; Sun, 10 Aug 2014 21:59:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255116>

Hi List,

At $dayjob we maintain internal forks of the a number of upstream repositories.

Unsurprisingly updating these forks can be extremely problematic,
especially when it's only one person doing the merge. Fortunately most
of us are in the same physical location so it is possible to drag in
someone who knows more about the code than the person merging but I
can't see that scaling with remote developers.

Is there any way where we could share the conflict resolution around
but still end up with a single merge commit. I'm thinking of something
like the following workflow

developer A:
  git merge $upstream
  <conflicts>
  git mergetool ...
  <resolves some of the conflicts>
  git commit -m "WIP: Merge upstream" --something-like--all-but-not

developer B:
  git pull developer_A
  git reset HEAD^
  <at this point it's be nice if developer B's work tree and index
were in the same state as developer A's before they ran 'git commit'>
  git mergetool ...
  <resolves the conflicts that they know about>
  git commit -m "WIP: Merge upstream" --something-like--all-but-not

developer A:
  git pull developer_B
  git reset HEAD^
  git mergetool ....
  <finishes off anything left>
  git commit
  <It'd be really nice if MERGE_MSG was retained through all of this>
  git push

Any thoughts on if something like this is currently possible? Is this
something other git users would find useful?

Thanks,
Chris
