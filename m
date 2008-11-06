From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvs2git
Date: Thu, 06 Nov 2008 13:42:00 +0100
Message-ID: <4912E618.1060801@alum.mit.edu>
References: <200811052319.04879.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: cvs2svn developers <dev@cvs2svn.tigris.org>,
        Git Mailing List <git@vger.kernel.org>
To: Francis Galiegue <fg@one2team.net>
X-From: dev-return-2295-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Thu Nov 06 13:43:23 2008
connect(): Connection refused
Return-path: <dev-return-2295-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1Ky4Ck-0004K7-5Z
	for gcvscd-dev@gmane.org; Thu, 06 Nov 2008 13:43:18 +0100
Received: (qmail 5822 invoked by uid 5000); 6 Nov 2008 12:42:04 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 5812 invoked from network); 6 Nov 2008 12:42:04 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: At0CAG90EknAbSoIgWdsb2JhbACUGgEBFiKqGIYlhDmDVQ
X-IronPort-AV: E=Sophos;i="4.33,557,1220252400"; 
   d="scan'208";a="15481093"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.17) Gecko/20080925 Thunderbird/2.0.0.17 Mnenhy/0.7.5.666
In-Reply-To: <200811052319.04879.fg@one2team.net>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100234>

Francis Galiegue wrote:
> I don't like to reinvent the wheel and you have gone a lot further than I did
> wrt cvs2git, with the added advantage that you work on a physical CVS tree
> and you know a LOT more about CVS than I do. And I do, indeed, have physical
> access to "my" CVS tree.

Even for the few people who don't have physical access to their CVS
tree, there is a solution [1].  I don't think this is a significant
issue, and indeed we've had very few complaints about this over the years.

> I wish that cvs2svn[2git] gets things as right as possible, and am willing to
> help in any way possible.

The first step is to send in bug reports (including sample repositories)
for anything you think can be improved.  It is very easy to produce a
test case from even a proprietary repository [2].

> Have you ever had a look at git-cvsimport already? Not my code, it relies on
> cvsps, which is flawed, that's a given fact. But it builds a state-of-the-art
> git repository.

How do you define "state-of-the-art"?  Granted, the resulting git
repository is simpler than the one created by cvs2git, but that is
because *it is typically wrong*.  The tool produces simple output
because it assumes away so much of the true complexity that can be
recorded in a CVS history.

I am not interested in a known-to-be-incorrect conversion, no matter how
pretty it looks in gitk.

git-cvsimport is *broken*, and the only way to fix it is to give it (and
its output) all of the complexity of cvs2svn/cvs2git.  I know that for a
fact because cvs2svn used to be based on simpler algorithms (though even
then not as naive as those used by cvsps!) and we were constantly trying
to patch up this or that edge case in a futile struggle against a system
that was fundamentally broken.  The switch to the current
topological-based changeset creation fixed all such bugs at once.

If you try to build a robust and correct tool on cvsps, you are doomed
to failure because (1) cvsps can crash complex CVS repositories and (2)
cvsps doesn't even *try* to supply all information correctly, e.g.
regarding the true contents of tags and branches [3].

> By now, I have achieved the first part of my project (correctly parsing the
> cvsps cache file), next step I'll "lighten" the git-cvsimport source (bug for
> bug compatibility to start with).

Please believe me, because I have years of suffering behind me:

1. cvsps is broken and not useful for this purpose

2. "parsing the cvsps cache file" is an absolutely minuscule part of
writing a CVS -> anything converter.  You think you're making good
progress, but you have no idea of what you are getting into.  Read [4]
and really think about whether you want to reimplement a comparable set
of features from scratch.  And remember that many of these features are
not optional bells and whistles; they are *needed for correctness*.

> One thing is that this program uses bare git commands, not the fast-import
> way.

This will absolutely kill performance for a large repository.  There is
a discussion of this issue in our mailing list archives and probably
also on the git mailing list.

> Hence my first question: if I lighten git-cvsimport code, will that help
> you for cvs2git?

If I polish up my roller skates, will that help you fix your car? ;-)

Michael

[1] http://cvs2svn.tigris.org/faq.html#repoaccess
[2] http://cvs2svn.tigris.org/faq.html#testcase
[3] http://selenic.com/pipermail/mercurial-devel/2008-February/004975.html
[4] http://cvs2svn.tigris.org/features.html
