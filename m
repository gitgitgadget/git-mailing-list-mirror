From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Tue, 08 Feb 2011 01:59:01 +0100
Message-ID: <201102080159.02153.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102070958.11551.johan@herland.net>
 <20110207201912.GB13461@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 08 01:59:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmbvE-0002Se-OD
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 01:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611Ab1BHA7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 19:59:07 -0500
Received: from smtp.getmail.no ([84.208.15.66]:49503 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753303Ab1BHA7F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 19:59:05 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG900GGNXEGV320@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Feb 2011 01:59:04 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id EB38F1EA5571_D509557B	for <git@vger.kernel.org>; Tue,
 08 Feb 2011 00:59:03 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 2FC971EA2B0F_D509557F	for <git@vger.kernel.org>; Tue,
 08 Feb 2011 00:59:03 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG900KD6XEF1K10@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Feb 2011 01:59:03 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <20110207201912.GB13461@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166321>

On Monday 07 February 2011, Jeff King wrote:
> On Mon, Feb 07, 2011 at 09:58:11AM +0100, Johan Herland wrote:
> > This is the same technique we use when talking about branch names: On
> > this mailing list, nobody is confused when I refer to 'maint',
> > 'master', 'next' and 'pu'. Still, in our own work repos (at least in
> > mine), these branches are actually called "refs/remotes/origin/<name>"
> > (commonly referred to by their shorthands "origin/<name>"). Here we
> > are, juggling the same kind of namespaces that I propose for tags, and
> > it seems to work well without causing much confusion.
> 
> Just playing devil's advocate for a moment: isn't this namespace
> distinction one of the more confusing things in git for new users? That
> is, I have seen new-ish git users say "OK, so I cloned from upstream.
> How come I can't say "git log maint" now?" Or it used to be "how come I
> can't "git checkout maint" now?" The latter is now handled by some very
> specific magic in "git checkout", but in general ref lookup does not
> automagically look in remotes namespaces, and it has caused some
> confusion.
> 
> So here we are introducing more distinction between project-wide names
> and per-remote names. I absolutely think it's the right thing to do from
> a "keep it simple, orthogonal, and distributed" perspective. But we also
> need to recognize we are making some common use cases more confusing. In
> the case of remote-tracking branches, we ended up adding some porcelain
> features to make common actions (like checking out a local branch from a
> remote) more seamless. But there is still some confusion among new
> users.
> 
> I'm sort of rambling as I'm not quite sure yet what this means for the
> tags proposal, but a few questions I think are important to consider
> are:
> 
>   1. Where have we succeeded and where have we failed with making
>      separate-remotes / tracking branches seamless to the user (as
>      opposed to something like a system where
>      fetching from upstream fetches straight into your master branch
>      (which has its own problems, but would be conceptually very
>      simple)? Do those failures apply in this case, and if so how can we
>      do better?
> 
>   2. Can we apply new ideas for handling separate-remote tags to the
>      branches case? Obviously one big proposal is searching in the
>      per-remote tag namespace for refs. Should we be doing the same with
>      heads?

I pretty much completely agree with your train of thought.

First, although the separate-remotes may at first be confusing to newbies 
coming from a centralized VCS, I don't think this is the _main_ source of 
confusion. And, as you imply, we cannot eliminate this kind of conceptual 
confusion in any case, without violating core DVCS principles (like Bazaar 
does in its "centralized workflow"). The best way to address this is, as you 
say, by keeping it "simple, orthogonal, and distributed" (and try very hard 
to keep the common use cases minimally affected).

We should instead look at what other (and preferrable fixable) sources of 
confusion we have in this area. Answering Git questions from colleagues at 
$dayjob, they often describe how they tried to accomplish something in Git, 
and I sometimes find myself giving a reply of the following form: "Yes, what 
you tried does make sense from your POV, but in this situation Git actually 
does this other thing instead, so instead you have to do ...". I don't like 
giving answers like this, because I get this nagging feeling that the 
problem is Git's fault, and not the user's. So, to enumerate some of these 
inconsistencies (I'm sure there are more that I cannot recall, right now):

- Lack of consistency in the ref namespace (refs/remotes/$remote/* vs. 
refs/tags/*). Also not clear from the current layout where to add new types 
of refs (e.g. notes, replace). My proposal tries to address this issue.

- Lack of consistency in which fetch refspecs must be listed in the 
configuration. (i.e. implicit vs. explicit fetch refspecs). My proposal 
tries to address this as well.

- Lack of consistency in porcelain interfaces. Some of these have been fixed 
in recent Git version, but some are yet to be fixed: E.g. some find the use 
of FETCH_HEAD confusing (when does fetch update the remote refs, and when 
does it update FETCH_HEAD instead?). Others (myself included) wonder why 
'git push' by default updates remote branches with matching names, while 
'git pull' relies on the explicitly configured upstreams to update the local 
refs. (FWIW, I've mitigated this last complaint insisting that all users at 
$dayjob run "git config --global push.default tracking" immediately after 
installing Git.) There are other UI inconsistencies too that escape me ATM.

When it comes to your second question, I believe it's definitely worth 
looking closer at whether we can exploit unambiguity across namespaces for 
all types of refs (not just tags). I expect there are some non-trivial 
issues down that road (some of these being discussed elsewhere in this 
thread), but we may still end up with something better.


Thanks for the feedback! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
