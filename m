From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 01:19:08 +0200
Message-ID: <200610170119.09066.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 01:18:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZbjM-00089a-HE
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 01:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWJPXSp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 19:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWJPXSp
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 19:18:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:38093 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750807AbWJPXSo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 19:18:44 -0400
Received: by ug-out-1314.google.com with SMTP id o38so885911ugd
        for <git@vger.kernel.org>; Mon, 16 Oct 2006 16:18:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kiexAqYigmCONl7/6vsESs98ci+47Bz6WpuWFzvgeZxlR0O+HQCj4C2me0cdICh1R3o11LaCxEdGl1cGDapgVoyBN8Rown5JPq4JGUuOVWiK4iWWs/LppJcdZgW0oudBMFl8fNYWR73ja7bd+k0gF7sdf09IsyKz6hXbTyNg7DE=
Received: by 10.67.29.12 with SMTP id g12mr8969200ugj;
        Mon, 16 Oct 2006 16:18:42 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id 27sm2458551ugp.2006.10.16.16.18.41;
        Mon, 16 Oct 2006 16:18:42 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <45340713.6000707@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28993>

Aaron Bentley wrote:
> Jakub Narebski wrote:
> >>Does it accurately reflect the current status of git? Is their
> >>assessment of git's rename capability correct?
> >
> >
> > For example simple namespace for git: you can use shortened sha1
> > (even to only 6 characters, although usually 8 are used), you can
> > use tags, you can use ref^m~n syntax.
> 
> Bazaar's namespace is "simple" because all branches can be named by a
> URL, and all revisions can be named by a URL + a number.

Well, all refs (branches and tags) are named by [relative] path. So for
example we can have 'master', 'next', 'jc/diff' branches, 'v1.4.0' and
'examples/tag' tags. Cogito for example uses <repository URL>#<branch>
syntax.

> If that's true of Git, then it certainly has a simple namespace.  Using
> eight-digit hex values doesn't sound simple to me, though.

Well, <ref>~<n> means <n>-th _parent_ of a given ref, which for branches
(which constantly change) is a moving target.

There was proposal to add some kind of serial number to git (like 
Subversion revision numbers) and even solution how to do this...
but one must realize that any serial number must be _local_ to the
repository. One cannot have universally valid revision numbers (even
only per branch) in distributed development. Subversion can do that only
because it is centralized SCM. Global numbering and distributed nature
doesn't mix... hence contents based sha1 as commit identifiers.


But this doesn't matter much, because you can have really lightweight
tags in git (especially now with packed refs support). So you can have
the namespace you want.

>> I'm not sure about "No" in "Supports Repository". Git supports multiple
>> branches in one repository, and what's better supports development using
>> multiple branches, but cannot for example do a diff or a cherry-pick
>> between repositories (well, you can use git-format-patch/git-am to
>> cherry-pick changes between repositories...).
> 
> That sounds right.  So those branches are persistent, and can be worked
> on independently?

Branches are persistent, have _separate_ (!) namespace (are not
incorporated in repository URL according to some kind of convention
like in Subversion), can be worked independently, you can easily
switch between branches in one working directory. Branches are cheap
in git (notion of topic branches).

I wonder if any SCM other than git has easy way to "rebase" a branch,
i.e. cut branch at branching point, and transplant it to the tip
of other branch. For example you work on 'xx/topic' topic branch,
and want to have changes in those branch but applied to current work,
not to the version some time ago when you have started working on
said feature.

What your comparison matrick lacks for example is if given SCM
saves information about branching point and merges, so you can
get where two branches diverged, and when one branch was merged into
another.
 
>> About "checkouts", i.e. working directories with repository elsewhere:
>> you can use GIT_DIR environmental variable or "git --git-dir" option,
>> or symlinks, and if Nguyen Thai Ngoc D proposal to have .gitdir/.git
>> "symref"-like file to point to repository passes, we can use that.
> 
> It sounds like the .gitdir/.git proposal would give Git "checkouts", by
> our meaning of the term.

Actually it is better to work with clone of repository, perhaps either
symlinking object database, or by alternates mechanism (with alternates
repositories would share old history, but gather new independetly
I think).

>> Git doesn't have some "plugin framework", but because it has many
>> "plumbing" commands, it is easy to add new commands, and also new
>> merge strategies, using shell scripts, Perl, Python and of course C.
>> So the answer would be "Somewhat", as git has plugable merge strategies,
>> or even "Yes" at it is easy to add new git command.
> 
> It sounds like you're saying it's extensible, not that it supports
> plugins.  Plugins have very simple installation requirements.  They can
> provide merge strategies, repository types, internet protocols, new
> commands, etc., all seamlessly integrated.

Plugins = API + detection ifrastructure + loading on demand.
Git has API, has a kind of detection ifrastructure (for commands and
merge strategies only), doesn't have loading on demand. You can
easily provide new commands (thanks to git wrapper) and new merge
strategies. 

Does git needs "plugin framework"? I'm not sure. Now it is like
Linux kernel without loadable modules support...

> What you're describing actually sounds like the Arch approach to
> extensibility: provide a whole bunch of basic commands and let users
> build an RCS on top of that.
>
> As the author of two different Arch front-ends, I can say I haven't
> found that approach satisfactory.  Invoking multiple commands tends
> re-invoke the same validation routines over and over, killing
> efficiency, and diagnostics tend to be pretty poorly integrated.

Actually I think it is how git was made. First came low level stuff,
"plumbing" in git parlance. Then there were scripts which used those
low level commands. There is ongoing project to rewrite them as builtin
commands (written in C); many of them got rewritten.

When git had very few higher level commands, here came git-pasky,
later renamed to Cogito; higher level SCM built on top of Git (in bash
shell). Now core git contains many high level commands, porcelanish
in git jargon.

Well, there is also StGit and it's alternative pg (Patchy Git), which
implement Quilt-like functionality (patch management) on top of Git.

-- 
Jakub Narebski
Poland
