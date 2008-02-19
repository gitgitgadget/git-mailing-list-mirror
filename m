From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream local branches
Date: Tue, 19 Feb 2008 08:40:47 -0500
Message-ID: <76718490802190540i50cefe15ja8f18e4a397f151d@mail.gmail.com>
References: <1203386832-43969-1-git-send-email-jaysoffian@gmail.com>
	 <7vprutlchh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 14:41:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRSit-0000TP-Fh
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 14:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbYBSNkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 08:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbYBSNkv
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 08:40:51 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:9928 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbYBSNku (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 08:40:50 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1741622wxd.4
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 05:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=p3+OUgVTyXgcrTc619qzdtgM55c8rY5ekkDiYz3dau0=;
        b=LwGNbYkA5Fgwq2ERh0wvwnTglji3VefWPTfhnyeoanvjJBW9DQ1HvfyO4q+yPxmavmhv57bGzDdrn2VAR9Yx2pIl5y0cnSBI7RpUr8ZG0yKfzjBkcLHAWEB5tDjMbHEki9Tir+7+VwhZVgxgAnlpxxpvpiXnHDihe4Zo8AK8Wlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KovH32XoXjsJzwVhkUHo3SkULBOgHOmt+Qvntnnyp+d4zWapAYReeKiwglcPI7/bfSpsyzkdWnPOrBb8szu1xKGyeod8ZjetRy+Yx9zscpNwD/yMHyQF0c6sliiDcPPSMmf0NB7k82X4KVM7eggyS1qav7ahXkw1/s9MRMINfSY=
Received: by 10.114.103.1 with SMTP id a1mr8407497wac.59.1203428447267;
        Tue, 19 Feb 2008 05:40:47 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Tue, 19 Feb 2008 05:40:47 -0800 (PST)
In-Reply-To: <7vprutlchh.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74403>

On Feb 19, 2008 12:52 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Three issues.
>
>  (1) "tells X and Y to configure" is bad.  We may later want to
>      add a command that forks a new branch from an existing one,
>      and you sure do want it to honor this variable.  Better not
>      list the commands but tell the reader that it applies to
>      the act of forking a new branch based on an existing one.
>
>  (2) "configure X and Y" is bad.  We may later want to add new
>      configuration variables to facilitate marking a branch that
>      builds on top of another in addition to the existing remote
>      and merge, and you sure do want them to be also set up
>      appropriately.
>
>  (3) "for use with X and Y" is bad.  We may later want to add
>      new commands that you would use to work with a branch that
>      builds on top of another, and you sure do want them to
>      honor the configuration variables this automatically sets
>      up.
>
> So, how about...
>
>         When creating a new branch starting at an existing 'upstream'
>         branch, the new branch can be marked as building on top of the
>         'upstream' branch, by setting a few configuration variables
>         (e.g. branch.<name>.remote and branch.<name>.merge).  This can
>         be explicitly asked for by giving `--track` (and turned off by
>         giving `--no-track`) option to commands that create a new branch
>         (e.g.  linkgit:git-branch[1]); this variable is consulted when
>         neither option is given.

I disagree. I think explicit is better than implicit and if a new
command or config variable is added, then the docs should be similarly
updated.

> Looks more-or-less unnecessary churn to me.

I was trying to make git-branch(1) and git-checkout(1) consistent.

> > -When a local branch is started off a remote branch, git sets up the
> > -branch so that linkgit:git-pull[1] will appropriately merge from that
> > -remote branch.  If this behavior is not desired, it is possible to
> > -disable it using the global `branch.autosetupmerge` configuration
> > -flag.  That setting can be overridden by using the `--track`
> > -and `--no-track` options.
>
> Why remove this?

Because --track and --no-track are documented in the OPTIONS section, so there
is no reason to document them up top as well. None of the other options [-l],
[-q], [-f] are documented in the intro.

> By the way, I think the existing code is buggy.  When you say:
>
>         $ git branch --track new $(git rev-parse --verify HEAD~12)
>
> the command should barf, saying "Starting point is not a branch; it
> is impossible to set up a tracking information", perhaps without even
> creating the "new" branch.  Instead, it silently creates a new branch.

That's what it did before I started touching any code. Perhaps it
should be a separate cleanup patch.

> >  <start-point>::
> >       The new branch will be created with a HEAD equal to this.  It may
> > -     be given as a branch name, a commit-id, or a tag.  If this option
> > -     is omitted, the current branch is assumed.
> > +     be given as a branch name, a commit-id, or a tag.  Defaults
> > +     to the current HEAD.
>
> I do not think this is what _you_ want (although I do not personally
> care).  Defaulting to HEAD means <start-point> is not a name of the
> branch in such a case.

Okay, that's a subtle difference. The existing documentation conflates (I think)
"HEAD" with "current branch". I see now they are different.

> Now this is getting tiresome.  The rewrite might be a good change for
> readability but this does not have anything to do with --track.  The
> review process of such a rewrite should be done as an independent
> topic.
>
> I give up (for now).

<grumble>
I will rip all the documentation changes out of this patch and do them
separately at a later time if at all. The current documentation has lots of
areas for improvement. It's hard to touch it w/o realizing you've made a clean
spot and then wanting to rewrite whole swaths. I happen to think I'm a decent
technical writer (no, it's not my day job) and I thought the changes I was
making, from the perspective of a new set of eyes, made things more clear. I
give up on that for now.

	
I too find it tiresome trying to get this patch into git. As a newbie
contributor, I'm beginning to find this very discouraging. I appreciate that
changes need a lot of scrutiny, but if the same amount of scrutiny were applied
to the existing code it would never get through.

Which is not to say that I don't appreciate your feedback and work on git.
</grumble>
j.
