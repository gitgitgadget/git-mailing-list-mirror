From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: CVS -> SVN -> Git
Date: Sun, 15 Jul 2007 00:19:11 +0200
Message-ID: <46994BDF.6050803@alum.mit.edu>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk> <469804B4.1040509@alum.mit.edu> <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com> <4699034A.9090603@alum.mit.edu> <20070714195252.GB11010@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
        Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org,
        dev <dev@cvs2svn.tigris.org>
To: esr@thyrsus.com
X-From: dev-return-2044-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Sun Jul 15 00:19:21 2007
Return-path: <dev-return-2044-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1I9pxQ-0008Ip-SX
	for gcvscd-dev@gmane.org; Sun, 15 Jul 2007 00:19:21 +0200
Received: (qmail 27516 invoked by uid 5000); 14 Jul 2007 22:19:16 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 27506 invoked from network); 14 Jul 2007 22:19:16 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAABjomEbAbSoIk2dsb2JhbACPOwEBAgcEBgcIGA
X-IronPort-AV: i="4.16,539,1175497200"; 
   d="scan'208"; a="62155913:sNHT56658574"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
In-Reply-To: <20070714195252.GB11010@thyrsus.com>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52512>

Eric S. Raymond wrote:
> In slightly more detail: I just finished forward-porting sccs2rcs to
> Python, I've been moving some Subversion-hosted stuff to Mercurial,
> and I've been thinking about writing a simple rcs2svn because the last
> time I tried using cvs2svn on a large RCS history (the Jargon File, as
> it happens, a couple years back) it did a very poor job of coalescing
> related commits without the CVS metadata.  I'm going to hope 2.0.0 has
> fixed that; I'll experiment and see.

Could you give a quick summary of the relevant differences between CVS
and RCS files in this context?  Then I'd be happy to try to figure out
how bad the situation still is today, and whether it can be easily improved.

> [...]
> So, I hear about plans to make cvs2svn generate something other than
> Subversion, and here's my instant reaction:
> 
> 	    	       	   DON'T DO IT!
> 
> This is not because I think Subversion is some kind of final answer to the
> VCS problem.  Fame from it -- I'm moving towards Mercurial.  No, the
> real reason I think this would be a waste of time is subtler than that.
> 
> Subversion, by design, is very good at capturing the metadata from
> SCCS and RCS and the various CVS variants floating around.  In fact,
> lifting from those into Subversion is basically lossless - the real
> problems are that (a) as Michael notes, the data you're losslessly
> lifting is scratchy, and (b) as I've noted, you have to use heuristics
> to coalesce file histories into changesets and those don't always make
> the links they should.
> 
> That being the case, two-step conversion with tools that import CVS to
> SVN and export from SVN to whatever actually works extremely well.

Other people have complained about having to convert from SVN to
distributed SCMs, because the SVN model doesn't map so easily to their
favorite.

You are basically suggesting that an SVN repository is the best lingua
franca of the SCM world, which I don't believe.  The CVS history *does*
have to be deformed a bit to fit into SVN, and an svn2xxx converter
would have to undo the deformation.

My idea is not to built (for example) cvs2git; rather, I'd like cvs2svn
to be split conceptually into two tools:

cvs2<abstract_description_of_cvs_history>, whose job it is to determine
the most likely "true" CVS history based on the data stored in the CVS
repository, and

<abstract_description_of_cvs_history>2svn

Then later write

<abstract_description_of_cvs_history>2git
<abstract_description_of_cvs_history>2hg

etc.

The first split is partly done in cvs2svn 2.0.  And I naively imagine
that writing the new output back ends won't be all that much work.

Michael
