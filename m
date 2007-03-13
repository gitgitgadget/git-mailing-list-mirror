From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 14 Mar 2007 00:14:50 +0100
Message-ID: <8aa486160703131614i1b67e6c3vf7ccf395d63573b4@mail.gmail.com>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
	 <7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
	 <7v7itx5mep.fsf@assigned-by-dhcp.cox.net>
	 <7vps7dle8j.fsf@assigned-by-dhcp.cox.net>
	 <7vhcsphqtk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Paolo Bonzini" <paolo.bonzini@lu.unisi.ch>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 00:15:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRGDS-0004uQ-PI
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 00:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbXCMXPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 19:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbXCMXPf
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 19:15:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:5808 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbXCMXPe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 19:15:34 -0400
Received: by nf-out-0910.google.com with SMTP id o25so2735696nfa
        for <git@vger.kernel.org>; Tue, 13 Mar 2007 16:15:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j6r0U6epLfkAT/2LqMuiU7Oi91APVtgvcREISYbwYOELjJ4yOm6NrlWQsG3ceWLjU+UsCM0LzRFQdLcJez0lXPFv6zzrtf0BKRXXBxEmJeDj//jG6NnV5C9reGFA+AJ+R4kXIa1ePoU/Z+WNY216bg2CWb7qjDdmEFPeoFnk/2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JcTfCrv7tx1MOBH426ZRr89PgRs2zCxjTFDWrErzwXDWDJWE25YXHnPeTv76EK8GtCusNcPxNv89xAost+w7pMkqhSiAH8DZ8a2O9X7sv4VgUVmK/k9Aibxyx/4RTKJZCN5jHOjoAcphOTf9OYRBX38L0pwAAcyCTdQYOV1te24=
Received: by 10.78.200.3 with SMTP id x3mr669250huf.1173827725819;
        Tue, 13 Mar 2007 16:15:25 -0700 (PDT)
Received: by 10.78.69.4 with HTTP; Tue, 13 Mar 2007 16:14:50 -0700 (PDT)
In-Reply-To: <7vhcsphqtk.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42156>

On 3/13/07, Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
>
> > Here are the topics that have been cooking.
>
> > * sb/fetch (Mon Mar 12 19:01:11 2007 -0700) 19 commits
> >  + git-fetch.sh:append_fetch_head() no longer has a remote_nick
> >    argument
> >  + git-fetch: Split fetch and merge logic
> >
> > I have a soft spot to anything that claims to be a clean-up, but
> > I suspect that the shell loop this series introduces may defeat
> > the git-fetch--tool optimization.  Also I think having to base
> > the patch on this made Paolo's "dot is special token to mean
> > 'git pull' merges from a local branch" needlessly complex (but I
> > haven't tried rewriting it myself without these two).  Although
> > I merged these to 'next', I am considering to revert them.
>
> I tried the "NULL fetch between 1000-refs repositories" test,
> which prompted the git-fetch--tool work that was done on
> jc/fetch topic in 'next', with the following versions:
>
>  (1) 1.5.0 (without any git-fetch--tool optimization)
>  (2) master (ditto)
>  (3) master with jc/fetch (but not sb/fetch topic)
>  (4) next ((3) plus sb/fetch and others)
>
> The test scripts are at the end of this message.  Both (1) and
> (2) take 3 minutes 7 seconds wallclock time.  (3) improves it
> down to 15 seconds.  (4) makes the operation spend 24 seconds
> (the times are all on my primary machine x86-64 with 1GB, hot
> cache and average of three runs each).

I think it is not fair, I wonder what would be the time with the merge
logic in sb/fetch in C. I'll try to make the git-fetch--tool
optimization.

>
> So the "Split fetch and merge" series hurts the performance
> quite a bit.  If it had enough "code clean-up" merit to warrant
> this, I would say it probably is a cost we should bear, but I
> personally do not see it.
>
> Paolo recently worked on top of next to base the fake '.' remote
> patch.  This wants to allow:
>
>         [branch "foo"]
>                 remote = .
>                 merge = refs/heads/master
>
> with an implicit (meaning, you do not have to have this in your
> configuration):
>
>         [remote "."]
>                 url = .
>                 fetch = refs/*
>
> so that you can say:
>
>         $ git checkout foo
>         $ git pull
>
> to merge from the local 'master' branch.
>
> I haven't reimplemented Paolo's patch on top of (3) above for
> comparison, but I have a feeling that it would not have been
> helped by the alleged clean-up value of "Split fetch and merge"
> patch (iow, I do not think it would be the case that the code
> got clearer to understand thanks to the clean-up).
>
> What Paolo's patch needs to do is to bypass the actual fetch and
> generate the following line in .git/FETCH_HEAD:
>
>         sha1-of-our-master <TAB> <TAB> branch 'master' of .
>
> I even suspect that "Split fetch and merge", by introducing
> FETCH_FETCHED and making FETCH_HEAD generated from it, made
> Paolo's patch more difficult to do and the end result less
> efficient.

I think my patch to support this is independent of the "Split fetch and merge".

>
> So unless there is a convincing counterexample otherwise, I'd
> like to revert the "Split fetch and merge" series.

Santi
