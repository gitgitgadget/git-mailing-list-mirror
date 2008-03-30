From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Sun, 30 Mar 2008 19:00:55 -0400
Message-ID: <32541b130803301600g5005876enf0fbcfe03e660fc8@mail.gmail.com>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com>
	 <47EECF1F.60908@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Mar 31 01:01:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg6Wz-0002E0-KB
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 01:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbYC3XA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 19:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbYC3XA6
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 19:00:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:18476 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbYC3XA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 19:00:57 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1551485fgb.17
        for <git@vger.kernel.org>; Sun, 30 Mar 2008 16:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=U+nKu6c6pRFYNjH1KSDmToWCG/IXnfaFEPQWm/CypA0=;
        b=JZpeo+vtXsUqn6xW+C3Fpcp85NPpOVT0S5abci4uOE/Id5Wy/ZFzTTEXpSJ04Tsv43U+MI1smF+f/yojyOg14ZLFmK5iO+YWjNUvyH+NYNwXl3Ocdjhqcl0j8f5Eu7lxFPBrUSTSJatO5+j/WcMQMijxq1uAYFSLHnmWd9mDjao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H3eWwPJCNBl5YV6nnXP3kapJchIUFP2/D3sQNSwy7HsbFMy5/QpYXvFSUtfn09v2RACwixl0tVPl3Sdg/2HT6e3iX5tclN5OPPBfxUTZaM4YsLI7ztaAmodPMIPpS5MUynuQQiaKFDeM/VKm8Tn4SkDyhpMnWaa/hCFSw5TMLW4=
Received: by 10.82.187.2 with SMTP id k2mr14994211buf.26.1206918055686;
        Sun, 30 Mar 2008 16:00:55 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Sun, 30 Mar 2008 16:00:55 -0700 (PDT)
In-Reply-To: <47EECF1F.60908@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78521>

On Sat, Mar 29, 2008 at 7:22 PM, Sam Vilain <sam@vilain.net> wrote:
> Avery Pennarun wrote:
>  > What if *all* the objects for A, B, and C were always in the *same*
>  > repository?  Almost all the problems would go away.  Imagine if it
>  > worked like this:
>
>  Well, that would create a lot of unnecessary work when cloning.
>  Partitioning by project is a natural way to divide the projects up.

What unnecessary work do you mean?  Certainly fetching only a
particular set of refs from a remote repository is possible, as that's
what 'git pull' does.

I agree that partitioning by project makes sense... but it also seems
to me that throwing extra objects into a repository that requires them
anyhow shouldn't have any major negative results.  After all, if you
can't build A without B, then downloading A might as well download the
objects from B too.  Which is not to say that B shouldn't *also* have
its own repository.

>  It's worth noting that the early implementations of submodules were
>  based on this design, of keeping everything together.

I'd like to read about the rationale behind this change.  Is there a
thread you can point to?

>  However, what you are suggesting should IMHO be allowed to work.  In
>  particular, if the submodule path is ".", then I think there's a good
>  case that they should come from within the same project.  If it's a
>  relative URL, it should initialize based on the remote URL that was used
>  for the original fetch (or, rather, the remote URL for the current branch).

I agree, there's no reason to take away the existing functionality of
allowing split repos.  I was more suggesting a new functionality so
that splitting isn't *required*.

>  > 2. You still check into C, then B, then A, but it doesn't actually
>  > matter if you put B and C on a branch first or not, because 'git push'
>  > will work properly, because it auto-pushes B and C revisions based on
>  > the fact that A refers to them (ie. implicit branches via the
>  > submodule mechanism).
>
>  This push failure thing is regrettable; however it's not clear which
>  branch name the submodules should get.  A given commit might exist on
>  several branches, which one do you choose to name it?

One option is to make a simple "git push origin" operation fail if
you're not on any branch; iirc, if you try that now, it just silently
*succeeds* without uploading anything at all, which is one reason I so
frequently screw it up.  Alternatively, is there a reason I can't
upload an object *without* giving it a branch name?  I guess that
would cause problems with garbage collection.

Now, the fail-on-branchless-push option still isn't really perfect,
because then I'll screw up like this:
- make change
- check in
- try to push: fails
- switch to branch
- realize I've lost my checkin(s) and have to go scrounge in the
reflog to try to find it

If we could disallow checkins to disconnected heads, then I'd get an
error at step 1, before I had a chance to screw up.  I think that
would be a usability improvement to git in general.  For example, if I
screw up a git-rebase and forget to abort, my HEAD ends up
disconnected and I occasionally check things in by accident and then
lose them (only to be saved by the reflog).  Perhaps an extra option
to git-commit that must be used if you want to check into a
non-branch?  Is that too harsh?

Another option would be to simply *always* create/update a branch tag
when doing "git submodule update".  But then the question is which
branch tag.  One thing that would give pretty useful semantics would
be to create a local branch tag with the same name as it had when the
submodule ref was checked in in the first place.

That is, if I make a change to B on branch "master," and then check
that into A, then the next time someone checks out A, it would be
great if it retrieved B with the same commitid, then named that
commitid "master".  This is *despite* the fact that the
"remotes/master" branch might be *newer* than the newly created local
"master".  Why?  Because it would give standard git semantics to my
new checkout: I can "git pull" to pull in the latest changes from
remote/master, or I can checkin and try to "git push" and it'll fail,
just like it should, which would encourage me to either "git pull" or
create a *new* topic branch, just as it should.

I think that solution would be great for me, but it would require
changes to the tree format in order to store the branch name, which is
unfortunately since trees currently don't know *anything* about branch
names afaict.  Is there a better way to achieve the same result?
(Note that in this case, "correct" operation doesn't *require* the new
branch name information; we just use it as a hint.)

>  > 4. You can 'git clone' a local copy of A, and B/C will be cloned
>  > automatically along with it.
>
> > 6. git-pull should be modified to auto-download objects referred to by
>  > 'submodule' references in trees.
>
>  I think this could be a switch to git clone/pull, configurable to be the
>  default action.

Sure.  Or it could try by default, but not error out if it turned out
not to be able to find them.

>  > 5. B and C, when git-submodule checks them out, should have their own
>  > .git directories, but use A as an 'alternatives' entry.
>
>  There is also a Google Summer of Code project for this - see
>  http://git.or.cz/gitwiki/SoC2008Ideas#head-9215572f23513542a23d3555aa72775bc4b91038

ok.  I was hoping it wouldn't be so hard as to require an entire SoC
project, since using --alternate when checking out the child repo
shouldn't be too hard.

Have fun,

Avery
