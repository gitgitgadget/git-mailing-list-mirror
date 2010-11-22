From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Submodules or similar for exercise/exam management
Date: Mon, 22 Nov 2010 14:56:19 +0100
Message-ID: <201011221456.19784.trast@student.ethz.ch>
References: <201011181109.08345.trast@student.ethz.ch> <7vsjyyb6ui.fsf@alter.siamese.dyndns.org> <20101118234916.GB21621@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>, <in-gitvger@baka.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 15:02:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKWyb-0004ZW-An
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 15:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab0KVOCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 09:02:32 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:8964 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755112Ab0KVOCb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 09:02:31 -0500
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Nov 2010 09:02:31 EST
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 22 Nov
 2010 14:55:46 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 22 Nov
 2010 14:56:19 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.36-93-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <20101118234916.GB21621@burratino>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161895>

Jonathan Nieder wrote:
> Junio C Hamano wrote:
> > Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
> >>> 3) never need to be aware of repo boundaries or manipulate sub-repo
> >>
> >> I think that this requirement is the hardest for any solution I know
> >> of or can imagine, as you hit these boundaries sooner or later either
> >> when you want to commit, push and/or when you have to resolve merge
> >> conflicts.
> >
> > Just a quick sanity check.  When this "requirement" makes sense, does the
> > whole thing need to be a superproject with bunch of submodules, and why?
> 
> In this example: because the submodule represents individual
> questions that are used by multiple exams.

Indeed.

I tried to not go too deeply into the status quo to keep the original
mail short, but if you really care, here goes (there's nothing else
below this point so you can also stop reading):

In my own group (theoretical CS), we have a Big Ugly SVN repository
with a directory per class taught, with subdirectories for the
exercises of every year.  Either at the beginning or during the year,
we copy the previous exercises and solutions to a new directory and
modify/fix them to taste.  Similar for exams.

This works reasonably well because all our lectures are on mostly
disjoint topics, so we rarely share anything between them.  The
directories act more as a "tag" of the old version than anything else,
and also help lazy users find the old version without talking to SVN.
Converting it to git would be fairly trivial since the usage maps
straight to lecture-projects with tags at the end of every semester,
but largely due to inertia nobody wants to do it.

The statistics institute where my colleague works is different in two
major respects.

First, they do not currently have any kind of enforced versioning.
There apparently are a bunch of directories along similar lines as the
above, but they live on a big shared NFS and thus it's easy to lose
existing state simply by overwriting it.  This is good for the
purposes of this discussion because we can weigh the pain of living
with the existing solution against the pain of using the new solution
;-)

More importantly, and this spawned my question, they have a lot more
overlaps between lectures.  (I assume this is because they give
statistics courses at various levels of difficulty to various other
departments/subjects of study, but I don't really know.)

Thus it often happens that an exercise is copied from lecture A to B,
then later some mistake is fixed in A and the fix does not propagate.
Worse, for whatever reason they might later copy back the exercise
from B to A and thus have a regression.

Handling at least this case sanely would already be good.  The
requirement that Junio criticized above is geared not towards sanity
of the use-case, but towards not making adoption so complicated as to
make it impossible.

It is true that in cases where submodules really pay off, such
exercises (or perhaps more realistically, guides and lecture notes)
being customized slightly for each course.  This would need branches.
For now I am putting this case a bit into the background since it can
be solved by working on such documents in a separate repo, splitting
the customizations into branches and merging the fixes from the main
copy; and then just binding the appropriate version as a sub-repo.

And yes, this would in theory also go for books as you described:

> suppose a certain chapter is part of multiple works I have
> published --- maybe in an article and a larger book.  When working on
> the book:
> 
>  - I do not want to make changes to that chapter and forget to commit
>    them.
> 
>  - After making changes to many chapters, I do not want the fuss of
>    going from chapter to chapter and commiting them one by one.
> 
>  - I certainly do not want to publish a version of the book that
>    "includes" versions of the chapters as dead links, so to speak.
>    That is, when I publish the current version of the book, I want
>    to publish the current version of all chapters, too.
> 
>  - When starting work on the book again after long absence, I would
>    like to be able to see and have the chance to adopt changes to
>    chapters made as part of this book and as part of others.

Though I wonder how that pans out in practice since it is rarely
possible to just "drop in" a chapter without rewriting significant
parts of it to match the rest of the book.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
