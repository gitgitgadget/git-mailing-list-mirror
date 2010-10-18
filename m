From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Mon, 18 Oct 2010 22:08:42 +0530
Message-ID: <20101018163836.GI22376@kytes>
References: <AANLkTimn99ErpLNfX-Jxn2t6cKCOoKFb91g1_m3TypOf@mail.gmail.com>
 <12137268.486377.1287073355267.JavaMail.root@mail.hq.genarts.com>
 <20101018051702.GD22376@kytes>
 <20101018073102.GA3979@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Bash <bash@genarts.com>, Matt Stump <mstump@goatyak.com>,
	git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 18:39:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7skU-0003Tm-Pb
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 18:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989Ab0JRQjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 12:39:33 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47538 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932926Ab0JRQjb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 12:39:31 -0400
Received: by gwj19 with SMTP id 19so18266gwj.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xCkTWtKaj68F5yBjpf3BY4lRxKrzOjh5olv8Evd5Fcc=;
        b=h2A8UytdvpqwDBhBfCBvEMu1uHB6q8PjI91EDF4TBdbBGWSqdJLnbRnqeet1HRhiFx
         IH7ssS5gLISlk+qGamRbvawR23fdinNawPMFfGP9jRV3kZ96xN8DZB8EooyLH4ZdbJai
         fxnQz5qhN+8jhU5iQYyz3bm8hmNzOl7B/RTqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KraGNUF4Lgs58fQJKgh6ixjF2Xedk8qGH6cPa/KvAopahuUtwiRiNAqMBkr2Izw5Wu
         S8tYmZyr7SFDwXhKeaARclqdsTlGaImqfp7l0PqhhWcQBzIQZRTBMWT+V6bL//bSzTjC
         0Viqd7On4wVFRlCNwd8O5K5u/aLzU3FyoO1z4=
Received: by 10.42.219.69 with SMTP id ht5mr996646icb.354.1287419970632;
        Mon, 18 Oct 2010 09:39:30 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id f46sm13595640yhc.17.2010.10.18.09.39.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 09:39:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101018073102.GA3979@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159262>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> > Also, since we're aiming for a two-way mapping, it's going to be
> > significantly more challenging: we will need a mapping function that
> > can be inverted perfectly.
> 
> Sounds interesting!  Let's see how much I can narrow scope/dash hopes.
> :)
> 
> First of dreams is the possibility of using git as a replacement for
> svnsync, to get semantically identical SVN repositories like so:
> 
> [...]
> > SVN repository 1 -> dumpfile -> Git repository
> > Git repository -> dumpfile' -> SVN repository 2
> 
> in a way that svn tools can look at repo 2 as a basically perfect
> replacement for repo 1.  This means copying svnsync properties,
> rename tracking info, svn properties, etc.
> 
> I. Some people might want that, and I wouldn't want to stop them
>    trying (maybe using notes, perhaps even the mythical tree-based
>    form) but I'm not interested in it at all.  Is it a goal for you?

Hm. I didn't imagine that it would be *that* difficult. The challenge
is to design an invertible mapping function by encapsulating
incompatibilities (or inconsistencies) bit-by-bit using hacks like
notes for the additional information. I'll think about this a little
more and get back to it in a few days.

> Second would be the possibility of using an SVN repository as a
> conduit for communication between git repositories:
> 
> Git repository 1 -> fast-export stream -> SVN repository
> SVN repository -> dumpfile -> Git repository 2

Interesting, but I don't necessarily see why this is useful.

> II. It would be super cool to be able to transport arbitrary git
>     objects via svn (maybe using custom properties and fabricated
>     temporary branches named after the first commit after a fork
>     point).  Perhaps some people could host git projects on Google
>     Code this way.  Is that a goal?
> 
> Git 1 -> SVN 1 -> Git 2 -> SVN 2 -> Git 3

Wow. That IS super-cool, but I'd have to stretch my imagination quite
a bit to find a usecase for this. I actually find this inelegant (and
probably even grotesque) on many levels, so no- absolutely not
interested in this.

> III. Perhaps only the subset of git objects with certain properties
>      should be considered safe to transport via an SVN repository
>      (e.g.:
> 
>       - author matches committer
>       - timestamps are New York time
>       - author address is of the format username <username>
>       - filenames are valid UTF-8
> 
>      ).  And maybe any existing git repository can be painlessly
>      transformed to consist only of such commits.  Is that a model
>      to strive for?
> 
> SVN 1 -> Git 1 -> SVN 2 -> Git 2 -> SVN 3

Dunno, and I don't like this.

> IV. Maybe only some svn changes would be considered safe to
>     transport via git: no weird properties, no tracked renames
>     not involved in branches/merges, all branches named after the
>     git commit id of the first rev after the fork point, ...
>     And maybe any existing svn repository can be painlessly
>     transformed to consist only of such revisions.  Is that a goal?

Again, no usecase. I'm not looking for making SVN do Git wizardry-
there's always Git for that. SVN is a simple book-keeping system, and
I want to keep it that way.

> (As you might have guessed, my answers are "no, no, no, and no, at
> least at first, but it is fun to imagine how a person would go about
> achieving these things anyway").

Let me guess: you're targeting git-svn like functionality with all the
dcommit/ rebase ugliness? I'm looking for a slightly nicer way, not
too much more; (I) is just a sort of "ideal" target- it's just nice to
think about it that way. It's needn't be entirely realistic.

-- Ram
