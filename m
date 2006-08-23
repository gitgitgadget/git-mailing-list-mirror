From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Proposal for new git Merge Strategy
Date: Thu, 24 Aug 2006 11:05:53 +1200
Message-ID: <46a038f90608231605w4d08d59bw42fc84669e16363f@mail.gmail.com>
References: <E1GFxeZ-0000Nw-ED@jdl.com>
	 <7vsljngr34.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jon Loeliger" <jdl@jdl.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 01:06:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GG1nX-00021z-PW
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 01:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965294AbWHWXGB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 19:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965293AbWHWXGB
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 19:06:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:27287 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965294AbWHWXGA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 19:06:00 -0400
Received: by nf-out-0910.google.com with SMTP id o25so453192nfa
        for <git@vger.kernel.org>; Wed, 23 Aug 2006 16:05:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BI5/7Ma0B1i0JfvRh+eMmRL8L8ZLRqXMpXGf/0h5SC5daSFRLC20BC+FgjkNYMXtl+SOfpRiUXuEoJl3ANepB/diE7TXQ9PoXlohaMtKsS1uP3gTMofQqPje8sH0+6weX6G6uSM+/eXiZeFA0ynjOtM/oYuy+rTYkN7MqYexOAQ=
Received: by 10.49.41.18 with SMTP id t18mr2702261nfj;
        Wed, 23 Aug 2006 16:05:59 -0700 (PDT)
Received: by 10.49.6.16 with HTTP; Wed, 23 Aug 2006 16:05:53 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vsljngr34.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25932>

On 8/24/06, Junio C Hamano <junkio@cox.net> wrote:
> Jon Loeliger <jdl@jdl.com> writes:
...
> > Any thoughts down this line?  Good idea?  Bad idea?
>
> We had some discussion on this with Catalin in "Unresolved
> issues #3" thread, regarding git-xxdiff (did I ever take it?  I
> liked it for what it does, but I was not sure about its
> odd-man-out-ness) which was proposed by Martin Langhoff.

I've been slack on my reading of the list lately so totally missed out
on that thread. I'll go and read it now...

...

> We should be able to make the part that call "merge/diff3" to
> alternatively call xxdiff or its friends (kompare, emerge, pick
> your favorites).  Catalin even showed us a code snippet used in
> StGIT for this in the thread.

I still think that the default initial behaviour git has is right.
Most conflicts are trivial, and people can deal with conflict markers
just right. It's what we are used to.

Except when it's a mess and it's unclear what goes where and why.
That's when git log --merge and my git-xxdiff help. I've also been
wondering if I can do gitk --merge easily ;-)

> Martin's proposed tool git-xxdiff is meant to be invoked after
> all of the above still left conflict markers.  As Catalin
> pointed out, using "xxdiff -U" to work on a file with conflict
> markers is less powerful than working on three stages directly,
> but on the other hand it can be used as the last stage fixup,
> independent from what git-merge does internally.  In other
> words, it is meant to help solving the same problem but in a
> different part of the workflow.

My implementation doesn't use the 3 stages either, just because I
didn't see xxdiff giving any stage a particular meaning. I should
rework it to have the 3 stages there, and trust users to read the
filename, which should say 'ancestor'.

In terms of the one script or many, if there is concensus on
OneScriptToRuleThemAll, I am not that opposed to reworking it to
something like

  git-mergehelper --tool xxdiff path/to/file.c

with a big switch statement inside the script :-p What bothers me is
that there may be interesting parameters to pass to the invoked tool,
and other than having a stupid '--toolopts' passthrough, we are pretty
fsck'd.

By having separate git-xxdiff, git-meld, etc the git- scripts would
accept all/most of the same params that the tool accepts, therefore
feeling "natural" to users of the tool. A definite advantage, IMHO.

{Ugh, my implementation doesn't get that far. But hey, good intentions!}

cheers,



martin
