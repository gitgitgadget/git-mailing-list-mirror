From: Chris Packham <judge.packham@gmail.com>
Subject: Redoing a merge for a particular file
Date: Fri, 8 Jul 2011 10:24:10 +1200
Message-ID: <CAFOYHZCFetkokgtn4z0O3nPTEy6GCTEcN0Pzc8ce-joqMzZM1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 08 00:24:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qewzj-0000IC-2J
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 00:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182Ab1GGWYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 18:24:12 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54655 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888Ab1GGWYL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 18:24:11 -0400
Received: by vws1 with SMTP id 1so1055123vws.19
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 15:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=lfZzK8b0YFD1jpEMVUTyANX2ntoiVoEabaiqeAUQqxE=;
        b=I956ANq8ERzcyQpHI2OMBi9JIeJqev+g32GtGTDZjKGK1OAFJ70+AlZK0z5jTIXaly
         lIlGr2wAzmes7rmsMupS6UXmFF/PFD1d9AVZRUwoeRFhv/W/5XgiRm/4ih5TUB18hCfl
         pdixm/qV51kmJH993d344zpdjDp3PJGJ7Oj9k=
Received: by 10.220.209.196 with SMTP id gh4mr497213vcb.50.1310077450555; Thu,
 07 Jul 2011 15:24:10 -0700 (PDT)
Received: by 10.220.200.72 with HTTP; Thu, 7 Jul 2011 15:24:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176782>

Hi All,

I'm in the middle of merging to branches and I've screwed up my manual
merge, I've also got rerere enabled and I can't seem to get back into
a state to trigger git mergetool again.

  $ git merge topic
  ...
  $ git mergetool
  $ make
  error: foo.c ... oops screwed up that merge.

The merge wasn't too painful so I don't mind starting again.

  $ git reset --hard HEAD^
  HEAD is now at 59c6097 ...
  $ git merge topic
  Auto-merging foo.c
  CONFLICT (content): Merge conflict in foo.c
  Auto-merging bar.c
  CONFLICT (content): bar.c
  Auto-merging otherfile1.c
  Auto-merging otherfile2.c
  Auto-merging otherfile3.c
  Resolved 'foo.c' using previous resolution.
  Resolved 'bar.c' using previous resolution.
  Automatic merge failed; fix conflicts and then commit the result.
  $ git mergetool
  No files need merging

So rerere has remembered the bad resolution of foo.c.  But even if I
run 'git rerere clear' and repeat the above sequence I get the same
result. I seem to remember something like this coming up before.
Wasn't there an option added to checkout to allow us to recreate the
pre-merge state?

  $ git checkout --merge foo.c
  $ git mergetool
  No files need merging

I can manually fix the error and amend the merge commit I just thought
git should be able to give me some help. I could have sworn that
checkout --merge is the right thing to do. Sure enough the man page
says it is "When checking out paths from the index, this option lets
you recreate the conflicted merge in the specified paths." maybe this
is a bug?

Looking at git status I think checkout is working as advertised but
maybe the bug is with mergetool.

  $ git status
  # On branch master
  # Your branch is behind 'origin/master' by 1 commit, and can be
fast-forwarded.
  #
  # Changes to be committed:
  ....
  # Unmerged paths:
  #   (use "git add/rm <file>..." as appropriate to mark resolution)
  #
  #	both modified:      foo.c
  #

foo.c now does have conflict markers in it so I think it's crying out
to be re-merged I just can't convince mergetool to do it. Am I doing
something wrong?

Thanks,
Chris

P.S.
  $ git --version
  git version 1.7.5.4
