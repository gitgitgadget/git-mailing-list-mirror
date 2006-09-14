From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: cvs import
Date: Thu, 14 Sep 2006 01:30:19 -0400
Message-ID: <9e4733910609132230p272c205eq45d9da24267396a8@mail.gmail.com>
References: <45084400.1090906@bluegap.ch>
	 <9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>
	 <46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com>
	 <4508724D.2050701@bluegap.ch>
	 <46a038f90609131416s1a53b53xd12c3661140fec7a@mail.gmail.com>
	 <4508D7DA.8000302@alum.mit.edu>
	 <9e4733910609132134j63857912keed6a42682f69d66@mail.gmail.com>
	 <4508E26B.5000106@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>, 
	"Markus Schiltknecht" <markus@bluegap.ch>, 
	"Git Mailing List" <git@vger.kernel.org>, monotone-devel@nongnu.org, 
	dev@cvs2svn.tigris.org
X-From: dev-return-1645-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Thu Sep 14 07:30:24 2006
Return-path: <dev-return-1645-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc51.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by ciao.gmane.org with smtp (Exim 4.43)
	id 1GNjnq-00068U-7B
	for gcvscd-dev@gmane.org; Thu, 14 Sep 2006 07:30:22 +0200
Received: (qmail 4916 invoked by uid 5000); 14 Sep 2006 05:30:20 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 4899 invoked from network); 14 Sep 2006 05:30:20 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAGSECEWLJkYCCQIKBwgd
X-IronPort-AV: i="4.09,161,1157353200"; 
   d="scan'208"; a="26772054:sNHT18522581"
X-IRONPORT: SCANNED
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YouXBZtNfRjMe1HhS3q7SCkVaTdLuMxplfJWLELd81Pr9IbYz922MmPdRSsT4PIvwxX1Fxn0JPljDyW0ckNNEilxhFQMfXSxl9RSJhfm7v60rXYOiXYnYkAGDC6+HgeDzbfcGQHbin873NTp0D022KX7Z/Nq0pSscCtsP3fRKcI=
To: "Michael Haggerty" <mhagger@alum.mit.edu>
In-Reply-To: <4508E26B.5000106@alum.mit.edu>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26984>

On 9/14/06, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Jon Smirl wrote:
> > On 9/14/06, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> >> But aside from this point, I think an intrinsic part of implementing
> >> incremental conversion is "convert the subsequent changes to the CVS
> >> repository *subject to the constraints* imposed by decisions made in
> >> earlier conversion runs.  And the real trick is that things can be done
> >> in CVS (e.g., line-end changes, manual copying of files in the repo)
> >> that (a) are unversioned and (b) have retroactive effects that go
> >> arbitrarily far back in time.  This is the reason that I am pessimistic
> >> that incremental conversion will ever work robustly.
> >
> > We don't need really robust incremental conversion. It just needs to
> > work most of the time. Incremental conversion is usually used to track
> > the main CVS repo with the new tool while people decide if they like
> > the new tool. Commits will still flow to the CVS repo and get
> > incrementally copied to the new tool so that it tracks CVS in close to
> > real time.
>
> I hadn't thought of the idea of using incremental conversion as an
> advertising method for switching SCM systems :-)  But if changes flow
> back to CVS, doesn't this have to be pretty robust?

Changes flow back to CVS but using the new tool to generate a patch,
apply the patch to your CVS check out and commit it.

There are too many people working on Mozilla to get agreement to
switch in a short amount of time. git may need to mirror CVS for
several months. There are also other people pushing svn, monotone,
perforce, etc, etc, etc. Bottom line, Mozilla really needs a
distributed system because external companies are making large changes
and want their repos in house.

In my experience none of the other SCMs are up to taking one Mozilla
yet. Git has the tools but I can get a clean import.


I am using this process on Mozilla right now with git. I have a script
that updates my CVS tree overnight and then commits the changes into a
local git repo. I can then work on Mozilla using git but my history is
all messed up. When a change is ready I generate a diff against last
night's check out and apply it to my CVS tree and commit. CVS then
finds any merge problems for me.

>
> In our trial period, we simply did a single conversion to SVN and let
> people play with this test repository.  When we decided to switch over
> we did another full conversion and simply discarded the changes that had
> been made in the test SVN repository.
>
> The use cases that I had considered were:
>
> 1. For conversions that take days, one could do a full commit while
> leaving CVS online, then take CVS offline and do only an incremental
> conversion to reduce SCM downtime.  This is of course less of an issue
> if you could bring the conversion time down to a couple hours for even
> the largest CVS repos.
>
> 2. Long-term continuous mirroring (backwards and forwards) between CVS
> and another SCM, to allow people to use their preferred tool.  (I
> actually think that this is a silly idea, but some people seem to like it.)
>
> For both of these applications, incremental conversion would have to be
> robust (for 1 it would at least have to give a clear indication of
> unrecoverable errors).
>
>
> Michael
>


-- 
Jon Smirl
jonsmirl@gmail.com
