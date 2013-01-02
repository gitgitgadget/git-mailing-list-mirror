From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major
 bugs.
Date: Wed, 2 Jan 2013 17:28:49 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130102222849.GA21105@thyrsus.com>
References: <20130101172645.GA5506@thyrsus.com>
 <7vfw2k8t7k.fsf@alter.siamese.dyndns.org>
 <20130102003344.GA9651@thyrsus.com>
 <20130102080247.GA20002@elie.Belkin>
 <20130102105919.GA14391@thyrsus.com>
 <20130102153933.GA30813@elie.Belkin>
 <20130102161848.GA18447@thyrsus.com>
 <CACPiFCKDoAoKxM4YU6uKoOGcDgLbXnCoUMO5iyf-wCWXh3j70A@mail.gmail.com>
 <20130102164107.GA19006@thyrsus.com>
 <CACPiFCKNkpaf6CgU=5rn1dyUSG2KV43oeTKJgRsSh9-Rhtq3Kw@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 23:29:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqWos-0003E1-Ut
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 23:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735Ab3ABW3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 17:29:37 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:39229
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab3ABW3f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 17:29:35 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id DF5FF4415C; Wed,  2 Jan 2013 17:28:49 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CACPiFCKNkpaf6CgU=5rn1dyUSG2KV43oeTKJgRsSh9-Rhtq3Kw@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212547>

Martin Langhoff <martin.langhoff@gmail.com>:
> I dealt with enough CVS repos to see that the branch point could be
> ambiguous, and that some cases were incurably ugly and ambiguous.

You are quite right, but you have misintepreted the subject of my
confidence.  I am under no illusion that the new cvsimport/cvsps 
pair is a perfect solution to the CVS-lifting problem, nor even that
such a solution is possible.

> My best guess is that you haven't dealt with enough ugly CVS repos. I
> used to have the old original X.org repos, but no more. Surely
> Mozilla's fugly old CVS repos are up somewhere, and may be
> therapeutic.

Thanks, but since I wrote reposurgeon in 2010 I've done more conversions
of messy CVS and Subversion repositories than I can easily remember (the
Subversion ones being relevant because they often have truly nasty CVS
artifacts in their early history).  Just off the top of my head there's
been gpsd, the Network Utility Tools, Roundup, SSTK2000, the Hercules 
project, and robotfindskitten.  And a raft of smaller projects - I sought
them out as torture tests for reposurgeon.

I am therefore intimately, painfully familiar with how bad CVS repos
can get.  I take it as given that there are still boojums that will
perplex my tools lurking out there in the unexplored jungle.

In fact, this very kind of prior experience had been a major
motivation for reposurgeon.  I became convinced several years back
that the batchy design philosophy of conventional repo-conversion
tools was flawed, not flexible enough to deal with the real-world
messes out there.  So I wrote reposurgeon to amplify human judgment
rather than try to replace it.
 
An example of the batchiness mistake close to home is the -m and -M
options in the old version of cvsimport.  It takes human judgment
looking at the whole commit DAG in gitspace to decide what merge
points would best express the (as you say, sometimes ambiguous) CVS
history - what's needed is a scalpel and sutures in a surgeon's hand,
not a regexp hammer.

For extended discussion, see my blog post "Repositories In
Translation" at http://esr.ibiblio.org/?p=3859 in which I argue that
the process has much more in common with the ambiguity of literary
translation than is normally understood.

No, what I am very confident about is the performance and stability of
the new cvsps/cvsimport code on *the cases the old code handled* - and
a fairly well-defined larger group of many more cases.

My confidence is derived from having built a test suite that
incorporates and improves on the git-tree tests. I don't have to merely
guess or hope that the new code works better, I can exhibit tests
that demonstrate it.

Among my near-term to-do items are applying those tests to cvs2git and
parsecvs.  But I first need to get parsecvs working again; presently, as I've
inherited it, it does not correctly create a HEAD reference in the
translated git repo.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
