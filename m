From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
Date: Thu, 21 Oct 2010 17:52:58 +0200
Message-ID: <201010211752.59514.jnareb@gmail.com>
References: <20101018051702.GD22376@kytes> <201010202244.39728.jnareb@gmail.com> <1287652097.9207.31.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 17:53:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8xSB-0001k1-2N
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 17:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323Ab0JUPxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 11:53:11 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41334 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab0JUPxK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 11:53:10 -0400
Received: by bwz18 with SMTP id 18so427824bwz.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LLyXxpG3mOI8wzUtREbn2OuQUs+z3E2d0gWWhkMe+y8=;
        b=yGYtzXvlTfvJhDPLAW9gic9PmPLtp0aHKaJGxFCpK9zz7TXbctJUsjDvo+Rc0ZKHE2
         nYSnhBId6+Sqkz5vBuYxxJtw2qvCrVubKVop+r1rC+9djnMOLL7PxRluODAmHPUavCUi
         LOn+E8mwRPnZqoAOFx+foo+2d4OmPOfuPQoLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bQUuNNq98zWsItMjZ0o3nsrpZtYBZIHIzxtvWgd0hbDSnXmYqvjEIm1IFczD9mdoXT
         ifn0QWsjdgMwNQIA3wu2BISOGtXXJoAN0GWdM8ylbmmZolZBYre3i3SiKKn9IgWpTBjO
         K1T3TmaZs/iO2EXulMnG+nhK6vB3D80jfdGNA=
Received: by 10.204.51.200 with SMTP id e8mr450172bkg.155.1287676387570;
        Thu, 21 Oct 2010 08:53:07 -0700 (PDT)
Received: from [192.168.1.13] (abvl250.neoplus.adsl.tpnet.pl [83.8.209.250])
        by mx.google.com with ESMTPS id y19sm1290964bkw.18.2010.10.21.08.52.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 08:53:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1287652097.9207.31.camel@wpalmer.simply-domain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159517>

On Thu, 21 Oct 2010, Will Palmer wrote:
> On Wed, 2010-10-20 at 22:44 +0200, Jakub Narebski wrote:

> > Because (from what I understand) revisions in Subversion are whole
> > project all-branches snapshots, and because revision identifiers are
> > monotonically incrementing numbers, there is no inherent notion of
> > _parent_ of commit, like there is in Git.  (I think that was the reason
> > why merge tracking was absent from Subversion until version 1.5, and
> > why mergeinfo is per-file rather than per-commit/per-revision property).
> 
> To clarify, I was saying that there is a "parent" of each SVN commit, in
> the top-level sense. This can be easily converted into a "whole
> repository" ("svnroot") tree in git. Of course, this isn't useful for
> actual work, but it's a good middle-layer, from which other more-useful
> things can be derived.

"Whole repository hierarchy (snvroot) snapshots" are useless without
extra work; Git needs "whole project" snapshots for its commits.

But the whole long description of "branching" model in Subversion was
meant as intro for explanation why there can be mishandled commits
in Subversion, which make it impossible to have 1-to-1 SVN revision to
Git commit mapping.
 
> In terms of converting the svnroot git history into actual branches,
> there are several options for mapping things. Ignoring merges for a
> moment, we could (for example) notice when two trees (as in tree
> objects) are very similar at some point in history, and decide that
> those are probably branches.

Actually as Stephen Bash wrote in his response creating branches in
Subversion generates 'copy' operations in svndump... we have to filter
out 'copy' operations which do not create new branches, though.

> It's tedious, but still fairly simple, to 
> walk the history and build a new history consisting only of edits to a
> subtree (even if the commit messages don't always make sense out of
> context). It really doesn't matter one lick whether a single svn commit
> touched multiple generated git commits.

We would have to ensure that commits in Git in branch 'foo' are the same
as history of 'project/branches/foo' subtree in svnroot in Subversion.
Otherwise we would either have different history in Git and in Subversion,
or we would have screwed up DAG of revisions in Git.

> Of course, "ignoring merges" is temporary and a total cop-out, but I
> wouldn't for a moment pretend that converting svn branches into git
> branches is difficult.

I don't think the most common "sane" Subversion merge case would be
difficult to translate into merge commit in Git: the svn:mergeinfo 
property would have common revisions for all affected files/directories.

The problem is that like it is possible to mishandle commit like described
by Stephen Bash by creating all-branches revision, it is also possible
to mishandle merge in Subversion, creating revision where different files
are merged from different branches: such thing does not have easy
translation to Git commit-level rather than file-level merge tracking.
 
[...]

> > So to have the same results for 'svn log' when on branchs 'foo' and
> > 'bar' (however you switch branches in subversion), or 
> > 'svn log <foo URL>' and 'svn log <bar URL>' like for 'git log foo'
> > and 'git log bar' in the [mishandling] situation described above
> > you have to map single all-branches revision 4 in Subversion into
> > two commits 4' and 4'' in Git.
> > 
> > 
> > Please correct me if I am wrong about Subversion model.
> 
> Also correct. One SVN commit would logically map to several git commits.
> It's best to think in terms of:
> ([svn commit] + [svn path]) -> [git commit] (or git tag, if we can get
> the heuristics right)

If I remember correctly some of discussion was whether there can truly
be irrecovable situation where single SVN revision *must* be mapped into
more than one Git commit (one-to-many mapping).

> > > The difference of course is that the "name" of an svn revision stays the
> > > same even if aspects of that revision (for example, the commit message)
> > > are changed, while the "name" of a git commit is dependent on everything
> > > that makes up a commit. In git terms, changing a commit message is
> > > considered to be history rewriting, whereas in svn terms it is merely
> > > something which happens occasionally as part of regularly maintained
> > > repository.
> > > 
> > > the git Philosophy is ingrained in its object model: If you change
> > > something which led to a state, you change the state itself. I don't
> > > think there should be an attempt to work-around that philosophy when
> > > talking to external repositories. That is to say: if a commit message
> > > (or other revprop) in history changes, we want to treat it as if we were
> > > recovering from an upstream rebase. Of course, a problem in that could
> > > very well be "how would we know about it?", which is a good question,
> > > but one not directly related to [revision+directory]<->[commit]
> > > mappings, afaik ;)
> > 
> > Better solution, actually proposed in separate subthread, is to make use
> > of new 'git replace' / 'refs/replaces/*' feature in Git, creating 
> > replacement for revision which changed some property retroactively...
> 
> I'm not entirely familiar with the git replace mechanism, but wouldn't
> that mean that repository git-A (cloned from SVN before the property
> change) and repository git-B (cloned from SVN after the property change)
> would be unable to merge with each-other?
> In my mind, if it would be a rebase when it happens in git-land, it
> should be a rebase when it happens in
> mechanism-to-make-external-repository-act-just-like-git land.

Note that there is problem with possibly changing svn:log, svn:author and
svn:date revision properties is only when there is ongoing interaction
between Subversion repository (or mirror) and Git repository (or mirror).
There is no problem with this issue when doing one-shot conversion.
 
The major problem is that svn:log etc. are _unversioned_ properties (see
http://svnbook.red-bean.com/en/1.5/svn.ref.properties.html), so I am not
sure if there is a way for Subversion server to tell that some svn:log
properties changed.  Perhaps there is a log, even if properties are
unversioned... otherwise we would have to detect somehow that properties
changed.


But let's assume that we have a way of notifying or noticing that e.g.
svn:log property changed.

Say that svn:log property for revision 'n was A at the time Git fetched
from SVN repository, and SVN revision 'n' is mapped to commit AA with
commit message A.

Later we fetch again from SVN repository, and besides new revisions to
be converted we notice somehow that svn:log property for revision 'n'
changed from A to B.

We now create replacement commit BB in Git, with the same Git parent
as commit AA, and with commit message changed to BB.  Then we add
commit BB as replacement for AA:

  $ git replace -f AA BB

(or its low level equivalent, or its batch equivalent when it exists).
This replacement is saved as a ref in 'refs/replaces/*' namespace.  All
git commands (except some plumbing perhaps, and unless you pass 
'--no-replace-objects' option to git wrapper) would then work as if
commit AA was replaced by commit BB; in particular 'git show AA' and
'git log' would show BB version.

Because replacements are stored as refs in 'refs/replaces/*' namespace,
it is simple to transfer them.  Each repository that fetches those refs
(+refs/replaces/*:refs/replaces/*) would see replaced contents.  Those
that do not fetch it would see old contents (and perhaps would have
problems like iteracting with SVN repository).


Alternate solution, though not as natively nice, would be to have empty
or placeholder commit, and store true commit message in notes for commit
AA, i.e. the message A would be in git note for AA.  Changing commit
message would mean changing note: after change commit AA would have a
commit-message note with contents B.


If changes to unversioned revision properties are rare, then replacement
technique is much superior to using notes, which generates unnatural git
repository.  When changing commit messages (svn:log) and the like are 
common and often, which would result in great many replacements, the
notes technique could be better because of performance reasons.

> > ...if Subversion actually offer any way to ask for changed properties.
> > Thankfully from what I understand from comments in this thread this
> > feature of being able to change revision properties like commit message
> > or authorship is by default turned off in Subversion.
> 
> Any sufficiently large SVN-tracked project will use all of SVN's
> features, whether the maintainer remembers or not ;)

Heh.

> Certainly it could be a "few and far between" thing, which doesn't need
> to be handled to get going / usable (especially since creating a fresh
> clone is so much faster than with git-svn). I don't know the internals
> of SVN beyond what was mentioned in the manual 5 or so years ago, but I
> assume you'd need to pretty much iterate over the entire history in
> either a slow, git-svn like manner, or a wasteful, "download everything
> to check a few things" manner, just in order to check that your
> properties are up-to-date. Perhaps I'm thinking of these things wrongly,
> and there's actually a simple log-based mechanism for checking such
> things which would be fast enough to work into regular git-gc-ish
> maintenance.

Again: svn:log, svn:author and svn:date are Unversioned Properties, but
perhaps Subvrsion repository stores log of changes somewhere (similarly
to git reflog, though hopefully not expired too early).

P.S. The later in this thread, the more I see how utterly wrong
     Subversion model of version control is (branches, tags, merges).

-- 
Jakub Narebski
Poland
