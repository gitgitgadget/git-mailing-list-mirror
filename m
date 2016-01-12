From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [RFC] Malicously tampering git metadata?
Date: Tue, 12 Jan 2016 13:21:38 -0500
Message-ID: <20160112182137.GE27334@LykOS>
References: <20151216032639.GA1901@LykOS>
 <20151218231032.GA16904@thunk.org>
 <20151219173018.GA1178@LykOS>
 <20151220012835.GA3013@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 12 19:21:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ3Zj-0003SY-BF
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 19:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934019AbcALSVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 13:21:43 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:32924 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933880AbcALSVl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 13:21:41 -0500
Received: by mail-qg0-f47.google.com with SMTP id b35so305380539qge.0
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 10:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to;
        bh=abztn7xmRVVnwBXNvD1dCI7sV0AM3dlOSa/PXAgljOE=;
        b=cNwhhTHsj9qMvYpMZ15SLcm2rmI0RBeeRuElce8MqbW4NKxvo9ZMer5fiqnnjGgLvk
         qtosGnOZLjrg5nxyP0ClvrIYA1gyvRypB9qpdNe2Ec43yhouexQeOgK95bqkgSThSrSM
         Eumd4eXGT0kM/Dm/G1mLDBz9PTNyGK3Y4Fw8Majng8O5hEHFCp0AfeXr3Mtd1IHJ+8mN
         8QGvC9OqOyF3nMftkseP3hW4iwbSZC/9hE5OUnpajEIqT7PCoL5EDOgWe+lvGj0Mb6Xc
         /83IHtI2yPsxypz/i2ACoC07+b9u68GGfFUhnJF93zbCP+4vEzuxRKWrrAvySGmqDlaT
         XLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to;
        bh=abztn7xmRVVnwBXNvD1dCI7sV0AM3dlOSa/PXAgljOE=;
        b=HevnqKsho+ymEcKXab522/mSHTo9H756rHIdoZfJGn4Me8b5JFbpDnSFq6OohoSNdH
         UvN3YbTASqOumtkVZRMJDuLzywNzStSLGlsP1A8GX9D4/aEFUKaatNRBTBUrJkG8pmyC
         SqcyiERAzE7qor5G0kXWyQ2JVgnL2umiZavkhMOshgPrdoc1cZkxHv4nC7rVXG7WxCAD
         PBph18kuIpHtVViRhp2qxBB0/fe2tSD56Cvfl9gbiObqL+V2+KJq28AOP5lhROlEoLmr
         LSr1nsDGLy59pDxxmcT4UqntM93JK1qFy0MvorAkncoBL57h6fXF4BY4h2+AhNet2AKI
         6H0w==
X-Gm-Message-State: ALoCoQkSX+44+K9rXnHDESqxvDerRYHXMbbQEzqXCsq6IK8TcslXy69DEPgkTmOdP8K50XWEepQ+V8QwS8I5h1nFKC0+BBDqtw==
X-Received: by 10.140.221.17 with SMTP id r17mr134388310qhb.94.1452622900889;
        Tue, 12 Jan 2016 10:21:40 -0800 (PST)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-16.NATPOOL.NYU.EDU. [216.165.95.5])
        by smtp.gmail.com with ESMTPSA id w16sm57145136qka.35.2016.01.12.10.21.40
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Jan 2016 10:21:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151220012835.GA3013@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283833>

Hello Everyone,

Thanks for the feedback regarding our attack scenario; it certainly shed some
light in what is the current state of git's metadata protection. We were
pleasantly surprised that attacks of this nature were considered, yet we think
we can improve on the current mechanisms.

We have been designing an extension that addresses this attack scenario (and
other similar attacks). Although originally it is not based on push
certificates, we feel that it works similar to them. The principal advantages
over push certificates are:

1) It doesn't require (although it could support it) a side channel. We store similar
    information about branch status (push status) on the repository itself. 

2) It is backwards compatible, as it doesn't modify the existing metadata
    format.

3) Following Ted's email, it could be easily integrated in any git workflow.
    Although some workflows might be benefitted more than others, it doesn't
    get in the way of any existing workflow that we know of.

4) It covers a broader attack suurface (e.g., our malicious-merge scenario).

To keep things simple (we can elaborate in further emails), our solution
basically works by keeping track of pushes by developers in an append only
file, so that, everytime a branch is pushed, the deloper signs his version of
the log and his "push entry" (similar to a push certificate). Right now, we
push this log to a separate branch called BSL (for Branch State Log), but
ideallly this could be part of the git metadata. 

Upon pulling/fetching, this push certificate chain (BSL) is also fetched
and used to verify whether all branches are pointing to a sensible
location (i.e., the location reported by the last user who
pushed/merged).This ensures that a malicious server can't change the
location to which branches point to.

Furthermore, upon fetching, users with write access also push an entry
indicating that they fetched the BSL. This avoids cases in which a malicious
attacker keeps older versions of the BSL and withhold changes to other users.
This mainly addresses an attack we refer to as "effort duplication attack".

For key distribution, we consider it could be done via the BSL itself, where a
user can sign the public key of a newly-added developer to the system as an
entry. To produce a local trust keychain, our tool simply requires an initial
root of trust (say, the main developer's trusted key), and it builds up the
keychain by traversing the BSL. Revocation could be done similarly too.

We already have a proof of concept of this scheme, and we have performed timing
and storage measurements, as well as stress tests. We believe integration
should not be hard, and that it is not particularly invasive with any type of
workflow. We wanted to note that our current implementation was designed in
with the aim of not changing the Git source code (although we would like to do
that in the future), which makes it a little more network-storage
expensive than a native solution.

Here is the overhead of our proof of concept:

    1) Storage overhead only increases for about 1kb per push entry. Right now,
    since we are storing each entry as a separate file in a separate branch, the
    storage overhead is non-optimal. If this file were to be stored as git
    metadata, it would only be around 345 bytes, depending on the signature
    scheme). 
        
    2) Network overhead is linear, and it adds less than 23kb per
    pull/fetch/push, mainly because we are opening three different tcp sessions
    with git. If we were able to integrate this in the git protocol,
    network overhead should be really close to the storage overhead x
    unseen push entries.

    3) For "fetch entries", storage and network overhead is minimal, as users
    only need to upload a 4-byte random number per fetch. We consider this cost to
    be negligible, (although we'd like to hear the insight from people
    knowledgeable to git).

    4) Timing shouldn't be a concern. Verifying an entry (using 1024 dsa with libgcrypt)
    is done in 30 microseconds per entry with an average laptop. A BSL with 46633
    entries --- imagine git.git had a push entry for each commit --- is less than
    1.28 seconds (assuming the whole BSL is verified upon cloning, for example).

In general, this solution seems to be achieveable, nonintrusive and, overall, a
nice thing to have. We were considering working towards a patch if it sounds
reasonable to the community.

Thanks!
-Santiago.

On Sat, Dec 19, 2015 at 08:28:35PM -0500, Theodore Ts'o wrote:
> On Sat, Dec 19, 2015 at 12:30:18PM -0500, Santiago Torres wrote:
> > > Now, the crazy behavior where github users randomly and promiscuously
> > > do pushes and pull without doing any kind of verification may very
> > > well be dangerous. 
> > 
> > Yes, we were mostly familiar with this workflow before starting this
> > research. I can see how the "github generation" is open to many attacks
> > of this nature. Would git be interested in integrating a defense that
> > covers users of this nature (which seems to be a growing userbase)?
> 
> One of the interesting challenges is that git is a pretty low-level
> tool, and so people have built all sorts of different workflows on top
> of it.
> 
> For example, at $WORK, we use gerrit, which is a code review tool, so
> all git commits that are to be merged into the "upstream" repository
> 0gets pushed to a gerrit server, where it goes through a code review
> process where a second engineer can review the code, request changes,
> make comments, or ask questions, and where the git commits can go
> through multiple rounds of review / revision before they are finally
> accepted (at least one reviewer must give a +2 review, and there must
> be no -2 reviews; and there can be automated tools that do build or
> regression tests that can give automated -1 or -2 reviews) --- and
> where all of the information collected during the code review process
> is saved as part of the audit trail for a Sarbanes-Oxley (SOX)
> compliance regime.
> 
> Other people use github-style workflows, and others use signed tags
> with e-mail code reviews, etc.  And I'm sure there must be many others.
> 
> So the challenge is that in order to accomodate many possible
> workflows, some of which use third-party tools, changes to make git
> more secure for one workflow must not get in the way of these other
> workflows --- which means that enforcement of new controls for the
> "github generation" probably will have to be optional.  But then
> people belonging to the "github generation" can also easily turn off
> these features.  And as the NSA learned the hard way in Vietnam, if
> the tools cause any inconenience, or has the perception of
> constraining legitmate users, security features can have a way of
> getting turned off.[1]
> 
> [1] A History of US Communications Security, The David G. Boak
> lectures, Volume II, "Nestor in Vietname".  pg 43-44.  (A declassified
> version can be found at:
> http://www.governmentattic.org/18docs/Hist_US_COMSEC_Boak_NSA_1973u.pdf)
> 
> > > But so is someone who saves a 80 patch series from
> > > their inbox, and without reading or verifying all of the patches
> > > applies them blindly to their tree using "git am" --- or if they were
> > > using cvs or svn, bulk applied the patches without doing any
> > > verification....
> > 
> > Just out of curiosity, are there known cases of projects in which this
> > has happened (I've noticed that both Git and Linux are quite stringent
> > in their review/merge process so this wouldn't be the case).
> 
> I can't point at specific instances, but given that in the "github
> generation", people are fine with blindly pulling someone else's
> Docker images and running it on their production servers or
> workstations, and where software installation gets done with "wget
> http://example.org | bash" or the equivalent, that it's probably more
> often than we might be comfortable.
> 
> I also suspect that a bad guy would probably find inserting a
> man-in-the-middle server into one of these installation flows is
> probably a much more practical attack in terms of real world
> considerations.  :-)
> 
> Cheers,
> 
> 						- Ted
