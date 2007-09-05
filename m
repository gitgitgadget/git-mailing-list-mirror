From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git's database structure
Date: Wed, 5 Sep 2007 09:41:26 -0400
Message-ID: <9e4733910709050641j34d58683ra72caa52c56cdf0f@mail.gmail.com>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
	 <9e4733910709040928n6535e49esaf713b2c63ba0831@mail.gmail.com>
	 <7vtzqany0z.fsf@gitster.siamese.dyndns.org>
	 <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>
	 <20070904212507.GA24434@thunk.org>
	 <9e4733910709041454i189e6629k78ddeb89797276b3@mail.gmail.com>
	 <46DE5861.4050201@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Sep 05 15:41:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISv8Q-0007Bb-Ka
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 15:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003AbXIENla (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 09:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755981AbXIENl3
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 09:41:29 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:6712 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755916AbXIENl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 09:41:28 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2591224wah
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 06:41:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NY71DmjVVPAXBoaFy7dfb+rGdZImueq6Zx1tWLUBPo/uRyYWMMvv6T2WGRM0e8tR2ZvENHkytMZRpD+/ph/D9MAR2+KtdoPmZ/47WmH3hod9sNQ+kPbDuV79oUUcdvLIrC9XDJAhLo10M/G9v6452RvmfSR+vYy5WOzce62qx1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ei/MWOVX8LGHmP+hlz7ckE++5d0m+Gzc3jmiAkEXIDwbswuWB2Mz+NYHPk9tiz1Dfu/GSmb8oN8TTQ9v99dz2fjhhraTKwCOrTU5plMY0Z3lAAgzcKbMDHS6n+YKcNETHYvNUeTjdDAXzCVeqYXBF8T1ItghaBAM+uFVczA4VRo=
Received: by 10.114.204.7 with SMTP id b7mr2422924wag.1188999687233;
        Wed, 05 Sep 2007 06:41:27 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Wed, 5 Sep 2007 06:41:26 -0700 (PDT)
In-Reply-To: <46DE5861.4050201@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57711>

On 9/5/07, Andreas Ericsson <ae@op5.se> wrote:
> Jon Smirl wrote:
> > On 9/4/07, Theodore Tso <tytso@mit.edu> wrote:
> >> On Tue, Sep 04, 2007 at 01:44:47PM -0400, Jon Smirl wrote:
> >>> The current data store design is not very flexible. Databases solved
> >>> the flexibility problem long ago. I'm just wondering if we should
> >>> steal some good ideas out of the database world and apply them to git.
> >>> Ten years from now we may have 100GB git databases and really wish we
> >>> had more flexible ways of querying them.
> >> Databases solved the flexibility problem, at the cost of performance.
> >> And if you use full normalized form in your database scheme, it costs
> >> you even more in performance, because of all of the joins that you
> >> need in order get the information you need to do, you know, useful
> >> work as opposed to database wanking.
> >>
> >> If you take a look at the really big databases with super high
> >> performance requirements, say like those used to managed airline
> >> tickets/reservation/fares, you will find that they are not normalized,
> >> and they are not relational; they can't afford to be.  And if you take
> >> a look at some of git competition that use relational databases to
> >> store their SCM data, and take a look at how loooooong they they take
> >> to do even basic operations, I would say that the onus is on you to
> >> prove that normalization is actually a win in terms of real (not
> >> theoretical) advantages, and that it doesn't cause performance to go
> >> into the toilet.
> >>
> >> I think the fundamental disconnect here is that no one is buying your
> >> claim that just because the data design is "more flexible" that this
> >> is automatically a good thing in and of itself, and we should even for
> >> a moment, "put performance aside".
> >
> > It is very easy to get bogged down in performance arguments on
> > database design when the correct answer is that there are always lots
> > of different ways to achieve the same goal. I wanted to defer debating
> > performance until we closely looked at the relationships between the
> > data at an abstract level.
> >
>
> But you cannot. Git is performance-critical, for the same reason every
> other performance-critical application is: It's a tool to save human
> time. Linux development *could* be done using patchfiles by the bundle
> and masses of tarballs. It's just not the fastest way to do it, so enter
> git, and lots of problems just go away. It's not the only way of doing
> it, but it saves time. If you were to add 2 seconds to each commit,
> that's several months of developer time that is lost every day!
>
>
> > Since git hasn't stored all of the fields in the object table (the
> > path is encoded in the index) we are never going to be able to build
> > an alternative way of indexing the object table.
>
> We can still build alternative indexes. They just have to be separate
> from the DAG and the current indexing scheme. Junio has pointed out
> ways of doing this already.
>
> > Not being able to
> > build alternative indexes is likely to cause problems when the
> > database starts getting really big. Without an index every query that
> > can't use the path name index is reduced to doing full table scans.
> >
>
> I've said it before; The most common delimiter used today is paths. It's
> a behaviour git was designed to handle well, because it *is* the most
> common way of limiting and separating content. It's not some random
> fluke that has made git perform very well on actions that commonly
> performed in large scale software projects; Linus designed it that way
> from the start, and kudos to him for a job well done.


This is why I wanted to separate the abstract data structure design
discussion from the performance one. In the flat design indexes are
like caches and can be created and destroyed. There will definitely be
an index created on the the paths. This index will work like the
current tree nodes. The difference is that this index is a cache
unlike the current tree nodes which are an immutable part of the the
data base.

The path name field needs to be moved back into the blobs to support
alternative indexes. For example I want an index on the Signed-off-by
field. I use this index to give me the SHAs for the blobs
Signed-off-by a particular person. In the current design I have no way
of recovering the path name for these blobs other than a brute force
search following every path looking for the right SHA.



>
> > A few things that could benefit from alternative indexing, blame,
> > full-text search, automating the Maintainers file, etc.
> >
>
> Yes, but getting rid of the tree objects and storing pathnames in
> blob objects would penalize log-viewing, diffs and merges, which
> are far more common operations than full-text searches in a software
> project.
>
> > I'm just asking if we really want to make full table scans the only
> > possible way to implement these types of queries. If the answer is no,
> > then let's first explore how to fix things at an abstract level before
> > diving into the performance arguments.
> >
>
> Personally, I really don't care. But you should really have read Junio's
> mail a bit more carefully. He explained about 'notes' that can be attached
> to commits and contain arbitrary data. By all means, create your indexes
> there and use them for whatever you like, but leave the foundation on which
> git was built *alone*. The design hasn't changed since April 2006 (subtrees
> were introduced April 26, I think), because it's a *good* design.
>
> --
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
