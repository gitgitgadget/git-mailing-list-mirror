From: skillzero@gmail.com
Subject: Re: Merge into locally modified files?
Date: Mon, 8 Jun 2009 12:14:38 -0700
Message-ID: <2729632a0906081214q43e45ce7p812bd02f34934691@mail.gmail.com>
References: <2729632a0906081030k5048cb27p6950a0decaa7396a@mail.gmail.com>
	 <200906082022.09936.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 21:14:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDkIx-0000PU-Qt
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 21:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbZFHTOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 15:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbZFHTOh
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 15:14:37 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:29507 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbZFHTOg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 15:14:36 -0400
Received: by an-out-0708.google.com with SMTP id d40so6133978and.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 12:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zOI9MlGve9DdjphlTNWLhfeWonW9VjXfx33vTbakvCo=;
        b=pwHfpZJzbd733CoFxYrUG0xTVUidqTEkLsjLi99hhpGt9OPrstTvoslIvQPT70HNea
         QCvfRFSLISLOWu+NhTuYDFJhsDnRJoLlBb37e9i+LaxI5lhr6G0fR28lTQvmDUsUwNNK
         cY1uE54GGsbIxH36Q2VsW+pUZsCVyY0Vpmp80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DGnsAHgfUviWLugU6XaJjZj8Of14NXLFIDQCkMYldyOIMaPpEhoQ2sf2OtsU0HOMIt
         8G7Or2gpqnsmn0z6Xs+Nqh4TQNzMA0sLHS2P+dBbHOOhl05TgjGRmHDkN7ohXmkt9eQm
         14qiNDKtdAsaIlCyP9BhUZgADvdXY5GlCdD1Q=
Received: by 10.100.120.10 with SMTP id s10mr523397anc.86.1244488478277; Mon, 
	08 Jun 2009 12:14:38 -0700 (PDT)
In-Reply-To: <200906082022.09936.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121098>

On Mon, Jun 8, 2009 at 11:22 AM, Johan Herland <johan@herland.net> wrote:
>
> Git, instead encourages you to commit your changes _first_
> (aka. "commit-before-merge"), so that your changes are not necessarily
> affected by the updated changes from the server.

The problem I have with this is that it's a lot of extra work to
commit, pull (which will create a merge commit), then back out the
merge commit git pull did, back out my local commit, then re-apply my
local changes. I typically always have some modified files in my tree
for little things I may never want to commit. I'll tweak some build
Makefile build setting (e.g. enable extra logging, some debug printfs,
etc.). These changes are very transient. We tend to pull in changes
several times a day as people change stuff.

It looks like I can use git stash to help here. If I do 'git stash &&
git pull && git stash pop', it seemed to work in a simple example. If
I had no changes, I'd need to be careful to not try to do a git stash
pop since it would haven't stashed anything.

Is this something that would be pretty easy to add to git pull (or I
guess really to git merge since pull is just fetch+merge)? Maybe
something like a 'git pull --rebase-local'? If I wanted to add
something like this, should I just start by looking at git stash and
see how it does it and try to integrate support for that into git
merge (and make sure git pull will pass that option through to git
merge)? Conceptually, it seems easy, but I don't know how hard it
would be to get it into the code.
