From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Tue, 18 Sep 2007 16:01:46 +0200
Message-ID: <8c5c35580709180701m54810d80nefa4704abb8797dd@mail.gmail.com>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com>
	 <20070918005013.GA6368@muzzle>
	 <8c5c35580709172312w55613a1bw8cc58b200c526fab@mail.gmail.com>
	 <7v4phsxy55.fsf@gitster.siamese.dyndns.org>
	 <46EF7EA1.6020402@vilain.net> <46EF9687.6070304@vilain.net>
	 <8c5c35580709180419i4500a2d4s8a997d45dd31944e@mail.gmail.com>
	 <46EFBB9A.5070404@vilain.net>
	 <8c5c35580709180503g24ef6c5hda2877e2215ba58d@mail.gmail.com>
	 <46EFD0F8.5050603@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Eric Wong" <normalperson@yhbt.net>,
	"Andreas Ericsson" <ae@op5.se>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Chris Shoemaker" <c.shoemaker@cox.net>, git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 16:02:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXdeG-0001Jq-8X
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 16:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968AbXIROBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 10:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754883AbXIROBt
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 10:01:49 -0400
Received: from qb-out-0506.google.com ([72.14.204.227]:57355 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738AbXIROBs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 10:01:48 -0400
Received: by qb-out-0506.google.com with SMTP id e11so1998558qbe
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4WxVFjOuteXp1cWY0P1izx7PMiQdOd3p6kUK6siKwv0=;
        b=urD5zlx5nvbMCHlDZ4xEM6ri1ife+RtLZ/HAhoq+j1Ny4o7WrwqiwI4ZrbZGj5Jrr0jRaH8+yM6QPqa499YKqXHnh80/1FUVcjmGR+7SJyAWC/T0ASarHLF+M7UESMtKf9tDTYlSw8yZhk6t90n8HCgqbUCZPDgvRfg+ZlsFIUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DbyaSe/bBjfx5eiuNx7P5fqtB9mJLvdGz3uVuSjI4HBOYevZ92k78h1SZJ18HfpHmp3nWLJVlK1DgY7RFEoVx+izIwURE5/0Yw5YqVaQVrh9vtPEAmrfWEd89bI7NwsxUYhBQ2SzjVqeCpFsZj2npzEbkBPwkzEln8XOwuvylaI=
Received: by 10.114.194.1 with SMTP id r1mr4456116waf.1190124106906;
        Tue, 18 Sep 2007 07:01:46 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Tue, 18 Sep 2007 07:01:46 -0700 (PDT)
In-Reply-To: <46EFD0F8.5050603@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58611>

On 9/18/07, Sam Vilain <sam@vilain.net> wrote:
> Lars Hjemli wrote:
> > On 9/18/07, Sam Vilain <sam@vilain.net> wrote:
> >> If you really want one, use git commit-tree directly.
> >>
> > Yeah, that's an option, but --no-ff is somewhat less work ;-)
> >
>
> Sure.  I just don't see a good use case for it from this yet.

Ok. I'll try to explain why I needed --no-ff in the first place:

I have two git-svn brances, lets call them FEATURE and RELEASE. At one
point, I did
  $ git checkout FEATURE
  $ git merge RELEASE
  $ git svn dcommit

Now, my coworkers can continue testing/developing on top of the
subversion branch FEATURE (I'm currently the only git user), knowing
that every bugfix from RELEASE have been merged.

A few days later, FEATURE is completed and tested and should be
integrated in RELEASE. I did

  $ git checkout RELEASE
  $ git merge FEATURE
  $ git svn dcommit -n

and noticed that git-svn wanted to commit the result to FEATURE, since
the merge actually was a fast-forward. If this was a a pure git
environment it would be no problem, but as I needed to get a merge
revision on top of the subversion RELEASE branch, I was in trouble.

My options:
* rebase FEATURE onto RELEASE: this would have duplicated ~150
revisions from FEATURE onto RELEASE in subversion
* merge --squash: this would have created the wanted history in
subversion, but my git history would have lacked the info that
everything in FEATURE had been integrated into RELEASE (this could
have been fixed by editing the grafts file)
* merge --no-ff: this made both the subversion history and my local
git history reflect what actually happened.

So I went for the --no-ff option.

If this use-case isn't good enough, oh well. I can always carry the
patch forward in my git repo ;-)

--
larsh
