From: "James Henstridge" <james@jamesh.id.au>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 10:53:52 +0800
Message-ID: <a7e835d40610191953i467ce853k4b4740bbfdd92936@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca>
	 <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	 <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org>
	 <453792A8.1010700@utoronto.ca> <878xjc2qeb.wl%cworth@cworth.org>
	 <453803E6.2060309@utoronto.ca> <87ods727pn.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Aaron Bentley" <aaron.bentley@utoronto.ca>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Andreas Ericsson" <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 20 04:54:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GakWE-0000Vx-Rk
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 04:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992442AbWJTCxz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 22:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992440AbWJTCxz
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 22:53:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:20657 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S2992442AbWJTCxy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 22:53:54 -0400
Received: by nf-out-0910.google.com with SMTP id c2so1258005nfe
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 19:53:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=qtfM5xCcq8+ZIqPL2gzQkMAcqKgAyPBFlVvuSWSKpAJEzJCFcEpW4hdmPSkP2Ym+oEY5FcZmAaAKIEHeqkv04kIcBhsu190och/ULYg8eVKKQ9H2PXe5oogKncGmqjdaYeKOOhUPisBW7a43mkHM92+x4x4N6ZyzlCoVrKocJgI=
Received: by 10.82.129.5 with SMTP id b5mr384089bud;
        Thu, 19 Oct 2006 19:53:52 -0700 (PDT)
Received: by 10.82.108.1 with HTTP; Thu, 19 Oct 2006 19:53:52 -0700 (PDT)
To: "Carl Worth" <cworth@cworth.org>
In-Reply-To: <87ods727pn.wl%cworth@cworth.org>
Content-Disposition: inline
X-Google-Sender-Auth: de50d34d0885aba0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29404>

On 20/10/06, Carl Worth <cworth@cworth.org> wrote:
> On Thu, 19 Oct 2006 19:01:58 -0400, Aaron Bentley wrote:
> > I don't think this is true.  The abandoned mainline does not need to be
> > destroyed.  It can be kept at the same location that it always was, with
> > the numbers that it always had. So the number + URL combo stays
> > meaningful.
>
> Sure that's possible, but it gets rather unwieldy the more
> repositories you have involved. I've been arguing that bzr really does
> encourage centralized, not distributed development, and you were having
> trouble seeing how I came to that conclusion. Do you see how "maintain
> an independent URL namespace for every distributed branch" doesn't
> encourage much distributed development?
>
> >             Additionally, the new mainline can keep a mirror of the
> > abandoned mainline in its repository, because there are virtually no
> > additional storage requirements to doing so.
>
> And this part I don't understand. I can understand the mainline
> storing the revisions, but I don't understand how it could make them
> accessible by the published revision numbers of the "abandoned"
> line. And that's the problem.

With this sort of setup, I would publish my branches in a directory
tree like this:

    /repo
        /branch1
        /branch2

I make "/repo" a Bazaar repository so that it stores the revision data
for all branches contained in the directory (the tree contents,
revision meta data, etc).

The "/repo/branch1" essentially just contains a list of mainline
revision IDs that identify the branch.  This could probably be just
store the head revision ID, but there are some optimisations that make
use of the linear history here.

If the ancestry of "/repo/branch2" is a subset of branch1 (as it might
be if the in the case of forked then merged projects), then all its
revision data will already be in the repository when branch1 was
imported.  The only cost of keeping the branch around (and publishing
it) is the list of revision IDs in its mainline history.

For similar reasons, the cost of publishing 20 related Bazaar branches
on my web server is generally not 20 times the cost of publishing a
single branch.

I understand that you get similar benefits by a GIT repository with
multiple head revisions.


> > > But for these communications, revision numbers will not provide
> > > historically stable values that can be used.
> >
> > They certainly can.
> >
> > The coder says "I've put up a branch at http://example.com/bzr/feature.
> >  In revision 5, I started work on feature A.  I finished work in
> > revision 6.  But then I had to fix a related bug in revision 7."
>
> "I've put this branch up" isn't historically stable...

With the repository structure mentioned above, the cost of publishing
multiple branches is quite low.  If I continue to work on the project,
then there is no particular bandwidth or disk space reasons for me to
cut off access to my old branches.

For similar reasons, it doesn't cost me much to mirror other people's
related branches if I really care about them.

> > As long as that coder is active
>
> ...which is what you just said there yourself.
>
> On the other hand, git names really do live forever, regardless of
> where the code is hosted or how it moves around. When I'm talking
> about historical stability, I'm talking about being able to publish
> numbers that live forever.
>
> It sounds like bzr has numbers like this inside it, (but not nearly as
> simple as the ones that git has), but that users aren't in the
> practice of communicating with them. Instead, users communicate with
> the unstable numbers. And that's a shame from an historical
> perspective.

If you need that level of stability then you want the revision
identifier in both the GIT and Bazaar cases.

As for simplicity, note that Bazaar doesn't extract any special
meaning from the "$email-$date-$random" format of the revision
identifiers.  The only property it cares about is that they are
globally unique.  For example, revision identifiers generated by the
Arch -> Bazaar importer have a different format and are handled the
same.


> > This is true, but his code is likely to all land in the mainline at
> > once.  Since his own revnos are more fine-grained, he's not likely want
> > to use the mainline revnos.
>
> What I'd like to be able to do, is advertise a temporary repository,
> and while using it, publish names for revisions that will still be
> valid when the code gets pushed out to the mainline. That is
> supporting distributed development, and everything I'm hearing says
> that the bzr revision numbers don't support that.

That is correct.  The revision numbers assigned to particular
revisions in the context of one branch won't necessarily be the same
as the numbers in another branch.


> > I felt that you were mischaracterizing my _statement_ that "it's
> > exceedingly uncommon for [revnos] to change" as an _argument_ "it's
> > exceedingly uncommon for [revnos] to change".  The reality is that we
> > keep saying revnos don't change because git users keep saying "but what
> > if the revnos change?".
>
> OK.
>
> The original claim that sparked the discussion was that bzr has a
> "simple namespace" while git does not. We've been talking for quite a
> while here, and I still don't fully understand how these numbers are
> generated or what I can expect to happen to the numbers associated
> with a given revision as that revision moves from one repository to
> another. It's really not a simple scheme.

I can't say anything about the dotted revision numbers that have been
recently introduced to Bazaar, but I have definitely found the simple
numeric revision numbers for mainline revisions useful when using
Bazaar.  The revisions with these short revision numbers are generally
the ones I am most interested in when working on that branch.

It hasn't ever seemed a problem those revisions no longer had short
revision numbers assigned to them when someone else merged my branch.


> Meanwhile, I have been arguing that the "simple" revision numbers that
> bzr advertises have restrictions on their utility, (they can only be
> used with reference to a specific repository, or with reference to
> another that treats it as canonical). I _think_ I understand the
> numbers well enough to say that still.

Using Bazaar terminology, the revision numbers are specific to a
particular _branch_.  If I copy a branch from one repository to
another, its revision numbers will stay the same.  And conversely, two
branches in the same repository can have different revision numbers.


> Compare that with the git names. The scheme really is easy to
> understand, (either the new user already understands cryptographic
> hashes, or else it's as easy as "a long string of digits that git
> assigns as the name"). The names have universal utility in time and
> space, (for definitions of the the universe larger than I will ever be
> able to observe anyway). And the natural inclination to abbreviate the
> a name when repeating it, (note the recent post with bzr UUIDs
> exhibiting the same inclination), doesn't make the names any less
> useful since the abbreviation alone will work most always.
>
> The naming in git really is beautiful and beautifully simple.

I don't think anyone is saying that universally unique names are bad.
But I also don't see a problem with using shorter names that only have
meaning in a local scope.

I've noticed some people using abbreviated SHA1 sums with GIT.  Isn't
that also a case of trading potential global uniqueness for
convenience when working in a local scope?


James.
