From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: Approaches to SVN to Git conversion
Date: Mon, 05 Mar 2012 23:27:32 +0000
Message-ID: <4F554BE4.5010401@pileofstuff.org>
References: <3c2ab05e-b2af-4df4-bca6-ff5512b0c73e@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>, David Barr <davidbarr@google.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 00:27:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4hJf-0007ns-P8
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 00:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757670Ab2CEX1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 18:27:39 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:4385 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757472Ab2CEX1h (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 18:27:37 -0500
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120305232734.LZHO4985.mtaout01-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Mon, 5 Mar 2012 23:27:34 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120305232734.DFHD13318.aamtaout03-winn.ispmail.ntl.com@[192.168.0.2]>;
          Mon, 5 Mar 2012 23:27:34 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <3c2ab05e-b2af-4df4-bca6-ff5512b0c73e@mail>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=UeB0h7Mj1QQA:10 a=u4BGzq-dJbcA:10 a=IkcTkHD0fZMA:10 a=qOz2pZ_4AAAA:8 a=8pif782wAAAA:8 a=_IEhM8lNAAAA:8 a=XKkg41o68GPDVBYwQW0A:9 a=YWo53RLZouxatfuzgIoA:7 a=QEXdDO2ut3YA:10 a=7qzHkXPk5l4A:10 a=Vwm1TLUwyryVIj_W:21 a=6n67_skgoCPmVr9_:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192286>

On 05/03/12 15:27, Stephen Bash wrote:
> All-
> 
> This turned out to be longer than I intended, but actually summarizes some of my modern thoughts on SVN to Git conversion (as always, I'm more interested in one time migration than bidirectional operation, so read with a grain of salt).
> 
> More inline...
> 
> ----- Original Message -----
>> From: "Andrew Sayers" <andrew-git@pileofstuff.org>
>> Sent: Sunday, March 4, 2012 8:36:41 AM
>> Subject: Re: [RFC] "Remote helper for Subversion" project
>>
>> ... snip ...
>>
>> While researching the problem, I found Stephen Bash's original
>> proposal[1] and snerp-vortex[2] quite inspiring, but wasn't able to
>> find any details on SoC-related work in the branching-and-merging
>> department - hopefully the following isn't just a retread of ideas
>> developed since then.  I've concentrated on importing from SVN so far,
>> but have kept an eye on update and half an eye on bi-direction in the
>> hopes of being useful there some day.
>>
>> It seems to me the "svn export" and "git import" steps make most sense
>> as two unrelated projects.  Snerp-vortex and Stephen's scripts both
>> cut the history import problem at that point, as do
>> svn-fe/git-fast-import with code import.  Exporting SVN history is a
>> messy and sometimes project-specific job, so allowing a project to
>> concentrate on that part makes it possible for SVN experts to use all
>> their skills without having to learn git plumbing before they make
>> their first commit (much respect to Stephen for managing that feat
>> BTW).
> 
> After many a long conversation with Ram and Jonathan (and others), I'm actually going the other direction.  My current thinking (and this is very much open for discussion) is that as long as the SVN properties are available (especially the copyfrom information) Git has just as much information (if not more) to reconstruct the SVN history as SVN does.  (And going through our messy history I haven't found any counterpoint to this yet)

I agree that git can be taught a superset of the information in SVN, but
you'll need absolutely all SVN properties available - somewhere out
there, someone has a created a merge script that sets "my-merge-info:
revisions 1 to 10 from trunk (inclusive)".  Building on your point
below, a git-based converter could take an ambiguous message like "merge
revision 123 from trunk" and compare the diff for this commit against
the diff for r123, for r1:r123, for r1:r132 and so on until it found a
good match.

I'm personally more interested in extracting SVN history from an SVN
dump than from git (which I'll discuss in a moment), but these
approaches sound fundamentally compatible - it sounds like we agree that
one part of the problem is a is a simple process that needs some
optimisation work and the other is a good candidate for full employment
theorem[1].  Putting an interface between them means we can write one
implementation for the bit with an obvious right answer, and continue
experimenting with different solutions for the other bit.

I described the work I've done as a solution with three parts (SVN
export, file format, Git import), but it's equally valid to call them
three different projects that were initially developed in parallel.  I'd
be quite happy for the format and import parts to move towards becoming
part of the wider "remote helper" project, and the export part to become
a CPAN module that's just one of many programs that writes the
history-import format (a bit like how svn-fe is one of many programs
that writes the git-fast-import format).

I wrote my SVN exporter based on SVN dumps for three reasons - I figured
people switching from SVN would be more comfortable customising a
solution that only used technologies they understood, I figured it might
be useful to Mercurial or Bazaar some day if it was DVCS-neutral, and I
have to use SVN for my day job so I'm more interested in getting a good
migration story today than a great one tomorrow.

My instinct is that under ideal conditions, the SVN exporter I've got
will initially surge forward, build up a great collection of test cases,
then gradually sink under the weight of hacks needed to pass the tests.
 This strikes me as a good reason to isolate the exporter from git
itself, but also a necessary step in getting SVN import done - there's
no way to really know how to architect a good solution until we can
build a spec from real world test cases.

> 
>> I've written a proof-of-concept history converter that can be split
>> into three parts: a format for describing SVN history; a large, often
>> messy Perl program that writes files in that format; and a small Perl
>> program that reads the format and translates it into git.  With
>> hindsight, Perl is the right language for the SVN exporter, but the
>> git importer would have been better written in C.
>>
>> Personally, I think SVN export will always need a strong manual
>> component to get the best results, so I've put quite a bit of work
>> into designing a good SVN history format.  Like git-fast-import, it's
>> an ASCII format designed both for human and machine consumption...
> 
> First, I'm very impressed that you managed to get a language like this up and working.  It could prove very useful going forward.  On the flip side, from my experiments over the last year I've actually been leaning toward a solution that is more implicit than explicit.  Taking git-svn as a model, I've been trying to define a mapping system (in Perl):

Just to be clear, the language described above goes after the clever
branch-detection work described below - all branches need to be
specified explicitly in the format so that it can be a simple mechanical
job.

> 
>   my %branch_spec = { '/trunk/projname' => 'master',
>                       '/branches/*/projname' => '/refs/heads/*' };
>   my %tag_spec = { '/tags/*/projname' => '/refs/tags/*' };
> 
> (See [1] for notes on our SVN structure.  In a std-layout-style repo it would be:
> 
>   my %branch_spec = { '/projname/trunk' => 'master',
>                       '/projname/branches/*' => '/refs/heads/*' };
>   my %tag_spec = { '/projname/tags/*' => '/refs/tags/*' };)
> 
> Now I know this simple mapping will fail as I get further in our history -- in particular we have one branch that came from:
> 
>   svn cp $SVN_REPO/trunk/ $SVN_REPO/foo  # OOPS! not in branches!
>   svn mv $SVN_REPO/foo $SVN_REPO/branches/foo
> 
>>From an automation perspective, I expect the first svn operation to produce an error saying "Possible branch created at /foo from known branch trunk (master), but doesn't match any known branch spec", while the second (if "continue-on-error" is turned on) would error "Branch /branches/foo created from unknown branch located at /foo".  It's then up to the user to modify the branch map to something that accounts for this behavior:
> 
>   my %branch_spec = { '/trunk/projname' => 'master',
>                       '/branches/*/projname' => '/refs/heads/*',
>                       '/foo' => '/refs/heads/foo' };
>   my %tag_spec = { '/tags/*/projname' => '/refs/tags/*' };
> 
> So in this case I'm making an explicit branch mapping, but the use of glob-style syntax allows the user to catch larger classes of branches if desired (I'll also note that depending on the implementation /foo may need to map to /refs/heads/bad-foo so that /branches/foo can map to /refs/heads/foo, but my intention has been to squash empty commits, so it's possible the name conflict is a non-issue since content didn't change).  I also know that we have some copy operations that are just weird, so it might be helpful to have an ignore mechanism that tells the system to ignore copies into/out-of certain SVN paths.
> 

I started with an approach like you describe, but as you say it winds up
in a mess of special cases.  A friend pointed me to Perl's catalyst
repository[2], which is a wonderful haven of every mad SVN thing ever
dreamt up.  That got me playing with more general heuristics, and while
writing this e-mail I think I've finally nailed it.  What do you say to
defining SVN branches like this:

A directory is a branch if...
1. it is not a subdirectory of an existing branch; and
2. either:
2a. it is in a list of branches specified by the user, or
2b. it is copied from a (subdirectory of a) branch

I'll have to go and play with the implementation details, but I don't
see any misbehaviour jumping out of this approach.  Rule 1 discounts the
"svn cp /branches/foo /trunk/libfoo" pattern, but I'm fine with that
because I don't think anyone really has a good answer there yet.  Rule
2a allows the user as much input as they want but only requires most
people to say that /trunk is a branch.  Finally, rule 2b counts the "svn
cp /trunk/libfoo /branches/foo" pattern - I'm personally not bothered by
the asymmetry there compared to rule 1.

I'm afraid I've spent all my free time tonight writing this e-mail, but
the proof-of-concept code is only based on a sloppy half-realisation of
the above so probably wouldn't be that enlightening anyway.

>> Once the format is defined, git import is fairly straightforward.
>> Proof-of-concept code to follow, but it's really just a wrapper around
>> git-commit-tree, git-mktag etc.  I wrote this in Perl thinking it
>> would relate somehow to git-svn, but eventually realised it didn't and
>> that a few hundred calls to (plumbing) processes per second isn't so
>> good for performance.  The only interesting part of the problem is how
>> to tackle SVN tags.  I went for an ambitious approach, making normal
>> tags where possible and downgrading them to lightweight tags when
>> necessary.  This does involve managing something that is effectively a
>> branch in refs/tags/, but what else is an SVN tag but a branch in the
>> wrong namespace?
> 
> I don't understand how "normal" and "lightweight" apply in this situation?  As I mentioned before I'd like to squash empty commits (in the case of a one-time migration, in the bidirectional case it's probably easier not to), so many SVN tagging operations wouldn't produce new commits, and the (technically) correct commit is tagged.  In the case of actual content changes in a tag's life, I think it's up to the user to decide between three options:
> 
>   1) only retain the last SVN tag
>   2) tag using the git-svn-style 'tagname@rev' for all but the last
>   3) Do (2), but move older tags to some hidden namespace (refs/hidden/tags or the like)
> 
> Option (3) is predicated on gc searching accepting all subdirectories of refs/ as valid (it did this when I wrote my original scripts, and I don't believe this behavior has changed).  For a one-time migration I think all three of these options can be implemented using annotated tags.  In the bidirectional case things get murky (maybe always tag with tagname@rev and hope for tab completion?).
> 

I didn't explain this particularly well, as it's based largely on the
vague desire to make update work some day.  Imagine the user does this:

* git svn-pull # get tags/foo, a candidate for an annotated tag
... time passes ...
* git svn-pull # tags/foo has now been updated in another revision

If we create an annotated tag in step 1, what do we do in step 2?  You
can't make the tag object the parent of a new revision, so you need to
do something unpleasant.  The solution I proposed was to convert the tag
message to a commit message (i.e. pretend a lightweight tag had been
created all along), then add another commit on top of it and make a
lightweight tag from the new commit (i.e. treat it like a branch).  In
retrospect that's far too much magic without user involvement - a better
solution would be to give the user this option along with the ones you
outlined, and let git-config remember their preference if they want.

	- Andrew

[1] http://en.wikipedia.org/wiki/Full_employment_theorem
[2] http://dev.catalyst.perl.org/repos/bast/
