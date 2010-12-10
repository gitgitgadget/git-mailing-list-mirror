From: =?UTF-8?B?UMOpdGVyIEFuZHLDoXMgRmVsdsOpZ2k=?= <petschy@gmail.com>
Subject: Oops, I screwed it up
Date: Fri, 10 Dec 2010 19:31:23 +0100
Message-ID: <AANLkTi=eFmCjdBYHx9Jy=Q7993GghuV1dp12E4Aj7pkZ@mail.gmail.com>
References: <AANLkTinyZ-dqV5=yaucLZTj14hdxS61v=VT-j82SqN7r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 19:31:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR7kf-0006VA-M5
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 19:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab0LJSbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 13:31:25 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34719 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab0LJSbY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 13:31:24 -0500
Received: by ywl5 with SMTP id 5so2263307ywl.19
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 10:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=w8q3xu+trh5rQx8SaLRNilGEJicTQ3/gC/qCtocAVbI=;
        b=JwKPM1vF+Am6EKFi2nVZ+ssM+cJqB1WWIsmS21iJjYrfTamRcqlYVT2tRhsrgBQsqR
         Sb4BO/I+1Ai5bN9dYFhAr5S68goI340GloPfdLg+tAvMtnj9ePkGgBVgcu41Mivh1oTe
         +1IBPe37KhsO8CdJoYazBsVcImb9dSTMe2KL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=VzWrEt3oqoFIKs3nGRqmxXJavgbL84a9xvfKrAP9TcDfVy+6Jobgq8JKcdwuN4pJ8/
         2jlTxX3VqoaTU0aNDRXakWHY4g2z28LMDMTAeWS5h+stkwdXGZw4fR7OIafvHoZQ3xDS
         pXOCZLvkplSJXma6jp8+HVPf0LH42ttRW6Stg=
Received: by 10.42.174.134 with SMTP id v6mr824179icz.226.1292005883442; Fri,
 10 Dec 2010 10:31:23 -0800 (PST)
Received: by 10.42.230.195 with HTTP; Fri, 10 Dec 2010 10:31:23 -0800 (PST)
In-Reply-To: <AANLkTinyZ-dqV5=yaucLZTj14hdxS61v=VT-j82SqN7r@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163425>

Dear All,

I did some rebasing which ended in an unexpected result.

This is what I did precisely:
- added 3 files to the index, then committed (#1)
- realized that a file was left out (not yet tracked), so added + committed it
- stashed the local changes
- used rebase -i to meld the last commit into the previous one (fixup)
- stash pop
- added more files to the index, committed (#2)
- made some minor changes to a file committed in #1, added, committed
- decided to meld into #1
- there were 3 more locally changed files
- stashed them
- rebase -i, moved the last item one line up, set to fixup, so that it
melds into #1
- stash pop: surprise! the stash was empty

git log --stat showed that the 3 stashed files got melded into commit #1, too.

I didn't expect this. Is this the normal operation?

I was able to undo the effects by rebase -i, edit (as in the git
rebase manpage under SPLITTING COMMITS), committing again w/o the 3
files I didn't need, saving them to a temp dir, revert them via
checkout, rebase --continue, then move the files from temp to have
them locally changed again. This is where I would have been if stash
pop succeeded.

The files in commit #1, #2, and the last 3 locally changed ones where disjunct.

I don't know how those 3 locally changed, stashed files ended up in
the commit. I checked my command line history, I wasn't adding them.

Unfortunately, I wasn't able to reproduce the phenomenon on a test
repo, by 3 files:
- commit a, b, c
- change a, commit
- change b, commit
- change a, commit
- change c
- stash c
- rebase -i to meld the two a's, making b the last commit
- stash pop : it worked

Any ideas?

I'm using git version 1.7.2.3 under Debian Squeeze AMD64.

Please CC me, I'm not on the list. Thanks.

Regards, Peter
