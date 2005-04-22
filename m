From: Petr Baudis <pasky@ucw.cz>
Subject: Re: First web interface and service API draft
Date: Fri, 22 Apr 2005 14:10:09 +0200
Message-ID: <20050422121009.GA7173@pasky.ji.cz>
References: <1114166517.3233.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 14:06:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOwvN-0001XW-G3
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 14:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVDVMKg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 08:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVDVMKg
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 08:10:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49047 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262025AbVDVMKO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 08:10:14 -0400
Received: (qmail 10245 invoked by uid 2001); 22 Apr 2005 12:10:09 -0000
To: Christian Meder <chris@absolutegiganten.org>
Content-Disposition: inline
In-Reply-To: <1114166517.3233.4.camel@localhost>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 12:41:56PM CEST, I got a letter
where Christian Meder <chris@absolutegiganten.org> told me that...
> Hi,

Hi,

> /<project>
> 
> Ok. The URI should start by stating the project name
> e.g. /linux-2.6. This does bloat the URI slightly but I don't think
> that we want to have one root namespace per git archive in the long
> run. Additionally you can always put rewriting or redirecting rules at
> the root level for additional convenience when there's an obvious
> default project.
> 
> Should provide some meta data, stats, etc. if available.

I don't think this makes much sense. I think you should just apply -p1
to all the directories, and define that there should be some / page
which should contain some metadata regarding the repository you are
accessing (probably branches, tags, and such).

> -------
> /<project>/blob/<blob-sha1>
> /<project>/commit/<commit-sha1>
> 
> These are the easy ones: the web interface should be able to spit out
> the plain text data of a blob and a commit at these URIs. Users would
> be probably scripts and other downloads.
> Open questions:
> * Blob data should be probably binary ?

What do you mean by binary?

> * Should it be commit or changeset ? Linus seems to have changed
> nomenclature in the REAME

We call it commit everywhere but in the README. :-)

The "changeset" name is bad anyway. It is a commit of a complete tree
state, diff against one of its parent commits is the set of changes.

> -------
> /<project>/tree/<tree-sha1>
> 
> Tree objects are served in binary form. Primary audience are scripts,
> etc. Human beings will probably get a heart attack when they
> accidentally visit this URI.

Binary form is unusable for scripts.

Anything wrong with putting ls-tree output there?


We should also have /gitobj/<sha1> for fetching the raw git objects.

> -------
> /<project>/blob/<blob-sha1>.html
> /<project>/commit/<commit-sha1>.html
> /<project>/tree/<tree-sha1>.html
> 
> A HTML version of blob, commit and tree fully linked aimed at human
> beings.

How can I imagine an "HTML version of blob"?


> -------
> /<project>/tree/<tree-sha1>/diff/<ancestor-tree-sha1>/html
> 
> Non recursive HTML view of the objects which are contained in the diff
> fully linked with the individual HTML views.

Why not .html?

> -------
> /<project>/changelog/<time-spec>

I'd personally prefer /log/, but whatever.

For consistency, I'd stay with the plaintext output by default, .html if
requested.

And I think abusing directories for this is bad. Query string seems much
more appropriate, since this is something that changes dynamically a
lot, not a permanent resource identifier.

OTOH, I'd use

	/log/<commit>

to specify what commit to start at. It just does not make sense
otherwise, you would not know where to start.

I think the <commit> should follow the same or similar rules as Cogito
id decoding. E.g. to get latest Linus' changelog, you'd do

	/log/linus

> -------
> /<project>/changelog/<time-spec>/search/<regexp>
> 
> HTML changelog for the given <time-spec> filtered by the <regexp>.
> 
> * again plain version needed ?
> 
> ------
> /<project>/changelog/<time-spec>/search/author/<regexp>
> /<project>/changelog/<time-spec>/search/committer/<regexp>
> /<project>/changelog/<time-spec>/search/signedoffby/<regexp>
> 
> convenience wrappers for generic search restricted to these fields.

Same here. just ?author=...&committer=...&signedoffby=... etc. You can
even combine several criteria.

> ------
> 
> open questions:
> * how to generate and publish additional merge information ?

I don't understand....

> * how to generate and publish tree and blob history information ? This
> is probably expensive with git.

...this either.

> * how to represent branches ? should we code up the branches in the
> project id like linux-2.6-mm or whatever ?

See above.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
