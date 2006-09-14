From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvs import
Date: Thu, 14 Sep 2006 16:40:47 +1200
Message-ID: <46a038f90609132140v10118b53q8f8001bcf575263d@mail.gmail.com>
References: <45084400.1090906@bluegap.ch>
	 <9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>
	 <46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com>
	 <4508724D.2050701@bluegap.ch>
	 <46a038f90609131416s1a53b53xd12c3661140fec7a@mail.gmail.com>
	 <4508D7DA.8000302@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Markus Schiltknecht" <markus@bluegap.ch>, "Jon Smirl" <jonsmirl@gmail.com>, 
	"Git Mailing List" <git@vger.kernel.org>, monotone-devel@nongnu.org, 
	dev@cvs2svn.tigris.org
X-From: dev-return-1640-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Thu Sep 14 06:41:13 2006
Return-path: <dev-return-1640-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc51.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1GNj25-0006xv-Hi
	for gcvscd-dev@gmane.org; Thu, 14 Sep 2006 06:41:01 +0200
Received: (qmail 16196 invoked by uid 5000); 14 Sep 2006 04:41:00 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 16172 invoked from network); 14 Sep 2006 04:40:59 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAALJ4CEWLJkYCAgcECAkGGw
X-IronPort-AV: i="4.09,161,1157353200"; 
   d="scan'208"; a="26769100:sNHT19338669"
X-IRONPORT: SCANNED
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=toaVxyG9z/f6w8RIRTe8cnLtTnygaD7nisOCVn2U9qkgqN8EQeM0WRsTvTi2BzDtvSk6Gb9QJKmNKrD5s2Mp+90/NhfYik/+/bbrumwgrEXlHKe7s7ZtubAmMVkZTpIeO6w6c3MOTL7DWi336bL+kN0l6vw8esnE0PW/ubMR1zE=
To: "Michael Haggerty" <mhagger@alum.mit.edu>
In-Reply-To: <4508D7DA.8000302@alum.mit.edu>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26981>

On 9/14/06, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> > IIRC, it places branch tags as late as possible. I haven't looked at
> > it in detail, but an import immediately after the first commit against
> > the branch may yield a different branchpoint from the same import done
> > a bit later.
>
> This is correct.  And IMO it makes sense from the standpoint of an
> all-at-once conversion.
>
> But I was under the impression that this wouldn't matter for
> content-indexed-based SCMs.  The content of all possible branching
> points is identical, and therefore from your point of view the topology
> should be the same, no?

Exactly. But if you shift the branching point to later, two things change

 - it is possible that (in some corner cases) the content itself
changes as the branching point could end up being moved a couple of
commits "later". one of the downsides of cvs not being atomic.

 - even if the content does not change, rearranging of history in git
is a no-no. git relies on history being read-only 100%

> But aside from this point, I think an intrinsic part of implementing
> incremental conversion is "convert the subsequent changes to the CVS
> repository *subject to the constraints* imposed by decisions made in
> earlier conversion runs.

Yes, and that's a fundamental change in the algorithm. That's exactly
why I mentioned it in this thread ;-) Any incremental importer has to
make up some parts of history, and then remember what it has made up.

So part of the process becomes
 - figure our history on top of the history we already parsed
 - check whether the cvs repo now has any 'new' history that affects
already-parsed history negatively, and report those as errors

hmmmmmm.

> This is the reason that I am pessimistic
> that incremental conversion will ever work robustly.

We all are :) But for a repo that doesn't go through direct tampering,
we can improve the algorithm to be more stable.



martin
