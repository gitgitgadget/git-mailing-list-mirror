From: David Aguilar <davvid@gmail.com>
Subject: Re: RFC: git status --amend
Date: Wed, 1 Apr 2015 01:43:24 -0700
Message-ID: <20150401084230.GA12282@gmail.com>
References: <551AB64F.4030400@cs-ware.de>
 <20150331180414.GB19206@peff.net>
 <xmqqvbhhqal6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>, Sven Strickroth <sven@cs-ware.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 10:43:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdEFS-0004Or-Fv
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 10:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbbDAIni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 04:43:38 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35492 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbbDAIne (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 04:43:34 -0400
Received: by obcjt1 with SMTP id jt1so68913678obc.2
        for <git@vger.kernel.org>; Wed, 01 Apr 2015 01:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5SxZ6hPj53LxmsNwRXhnFekYbfgJ/izw6FRYY2fycMk=;
        b=JZzRCERF8EtqRLaKdrALu/ika2yTN7+qUU99oj8TnR4u/KRAxtWgzBie6S/94X1iex
         TLQESUd0NhnpUigr+uVCR+plFjJ9xXvvv8LVMkltLD6t4mn5Uq+MfXXVY9FMcE7iSCRZ
         D54IPMH/gaAikCpW2g2ktiSseqiF3EsHbB0T/oZcHAhlxVfx00VWN6jEflsgOO3TO9bk
         /+FsRcJsXKraGs9D/IckDd/yZioS8y/Uoj3TxgCRjY1O6gZ2LxCXhxtal4rNbsiEUlBD
         l6gkfD9tWMWzKE0qjXkM1Cwj6esKUjJ4EvTJi6C7qD0U6DNAPQZUql6HjXJ7JBuBR1MG
         QOAw==
X-Received: by 10.182.74.166 with SMTP id u6mr38640224obv.68.1427877813586;
        Wed, 01 Apr 2015 01:43:33 -0700 (PDT)
Received: from gmail.com ([32.147.206.137])
        by mx.google.com with ESMTPSA id na2sm1215094obb.28.2015.04.01.01.43.29
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 01 Apr 2015 01:43:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqvbhhqal6.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266595>

On Tue, Mar 31, 2015 at 11:35:17AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Mar 31, 2015 at 04:59:27PM +0200, Sven Strickroth wrote:
> >
> >> for frontends or scripts it would be helpful to be able to use "git
> >> status" for getting the repository status compared to HEAD~1 instead of
> >> only HEAD (as provided by "git commit --amend" in the pre-filled commit
> >> message).
> >> 
> >> Thus, I'm suggesting to add a "--amend" parameter (or a parameter with a
> >> better naming) to "git status".
> >> 
> >> What do you think of this idea?
> >
> > Once upon a time "git status" really was just "git commit --dry-run".
> > These days it has diverged a bit. But I think you could get what you
> > want with:
> >
> >   git commit --dry-run --amend
> >
> > It even supports alternate styles like --short.
> 
> I think everything you said is correct, but your "diverged a bit"
> may hide one difference that could be crucial depending on the use
> case: pathspec.
> 
> What "git commit --dry-run [--other-options] <pathspec>" does, and
> what "git status [--other-options] <pathspec>" does, are different.
> 
> With or without --dry-run, to "git commit", <pathspec> tells the
> command to update the index at the paths specified by it from the
> working tree contents before proceeding (the contents recorded for
> the other paths depend on the use of -o or -i option).  But ever
> since "git status" departed from being "git commit -n", a pathspec
> given to the command means completely different thing.
> 
> After working on various parts of the tree, planning to conclude the
> current work with "commit", "git status directory/" is a good way to
> see what you did in that directory without seeing what you did
> outside (which will be included in the commit, too).
> 
> But what you get from "git commit --no-edit --dry-run directory/"
> would be different; it would show all the changes in the working
> tree inside directory/, including the ones that you deliberately
> left out of the index, as paths to be committed.
> 
> Having said all that, I am a bit torn on this topic.  Just like "git
> status" is a way to ask "I've worked so far, planning to conclude
> this with 'git commit'; tell me what I have achieved so far that are
> in the index and in the working tree, possibly limiting to these
> paths?", I think it is a reasonable thing to ask the same question
> with "s/git commit/git commit --amend/".
> 
> One workaround might be to
> 
>     git reset --soft HEAD^
>     git status [<pathspec>]
>     ...
>     git commit -c @{1}
> 
> but that is simply too error prone and ugly.  I would say it would
> be better if "status" knows how to answer that "I am planning to
> conclude with 'git commit --amend'" question.
> 
> The reason why I am torn is because I do not think "status --amend"
> is a sensible name for that option.  "status" is not about amending
> anything.
> 
> If the normal "status" is "give me status for the next commit", this
> new mode would be "give me status for the 'commit --amend'".  Naming
> it "git status --for-amend" crossed my mind, but it does not sound
> great to me, either.
> 
> So...

I think I can understand some of the "feeling torn" aspects.

I know exactly the problem that "status --amend" is trying to
solve, as it is non-trivial to get the status bits correct
for "what it looks like when amending a commit".

git-gui and git-cola both do some clever things to make their
amend modes work smoothly for the user, and having something
like "status --amend" could have made the implementation
simpler.

But "status --amend" still makes me torn too because it's too
special-purpose.  Taking a step back, "status" gives you a lot
of information, and all of it is relative to HEAD.

"status --amend" is really asking to make it all relative to
HEAD^ instead.

So I wonder, would the syntax not be more gittish if it were,

	git status HEAD
	git status HEAD^
	git status <ref> -- <pathspec>

and it'll compare your repo's status relative to any ref.

I like the above because it's general and not hard-wired into
the concept of amending a commit, but it enables that use case
as well.

The ultimate convenience for script writers would be if this
command gracefully handled the edge cases.  I have a separate
code path for this one, and eliminating it would be awesome.

"git init" time, where no commit exists (and thus "git status
HEAD|HEAD^" makes no sense) is an inconvenience to script
around. The most convenient behavior for the user would be to
treat that situation as being equivalent to comparing against an
empty tree.

That could extend to post-"git init" when a single commit exists
and the user asks for "git status HEAD^" for amending purposes.
It'd be great if the tool was dwim enough to also treat that as
an empty tree comparison.

I don't know if that's going too far, because normally git
would just yell, "HEAD^ makes no sense!" and tell the user to
bugger off, but I can definitely see the utility in a dwimmy
soft-edges status tool that papers over some of these edge
cases.

Would generalizing "status" to have a more gittish syntax make
you feel less torn?
-- 
David
