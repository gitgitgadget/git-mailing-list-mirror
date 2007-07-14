From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: CVS -> SVN -> Git
Date: Sat, 14 Jul 2007 22:01:31 +0200
Message-ID: <46992B9B.1070306@alum.mit.edu>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk> <469804B4.1040509@alum.mit.edu> <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com> <4699034A.9090603@alum.mit.edu> <20070714173223.GA25574@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
        Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org,
        dev <dev@cvs2svn.tigris.org>
To: Chris Shoemaker <c.shoemaker@cox.net>
X-From: dev-return-2040-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Sat Jul 14 22:01:44 2007
Return-path: <dev-return-2040-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1I9noF-00036o-Is
	for gcvscd-dev@gmane.org; Sat, 14 Jul 2007 22:01:43 +0200
Received: (qmail 27250 invoked by uid 5000); 14 Jul 2007 20:01:39 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 27240 invoked from network); 14 Jul 2007 20:01:39 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAANPImEbAbSoIk2dsb2JhbACPNwEBAgcIBgcIHQ
X-IronPort-AV: i="4.16,539,1175497200"; 
   d="scan'208"; a="77301257:sNHT18665878"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
In-Reply-To: <20070714173223.GA25574@pe.Belkin>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52502>

Chris Shoemaker wrote:
> [...] I, for one, would be interested to know how
> cvs2svn's output compared to CVSps's, especially w.r.t. detecting each
> branch's parent.

The problem, as I'm sure you are aware, is that CVS does not record
unambiguously the parent of a branch.  For example, the following two
situations are indistinguishable from the data stored in CVS:

1. Create BRANCH1 from trunk, then create BRANCH2 from BRANCH1 before
making any commits to BRANCH1

2. Create BRANCH1 from trunk, then create BRANCH2 from the same trunk
revision.

Older versions of cvs2svn would always create both branches from trunk.
 cvs2svn 2.0 gathers statistics about the "possible parents" of each
symbol across multiple files.  If BRANCH1 and BRANCH2 occur in another
file in a context that makes it clear that BRANCH2 was created from
BRANCH1 (i.e., because a revision was committed to BRANCH1 before
BRANCH2 was created), then it attempts to use BRANCH1 as the parent of
BRANCH2 in all files.

So yes, cvs2svn is somewhat intelligent about determining the correct
branch ancestry.

Michael
