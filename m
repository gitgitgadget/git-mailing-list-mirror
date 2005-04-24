From: Christian Meder <chris@absolutegiganten.org>
Subject: Re: First web interface and service API draft
Date: Mon, 25 Apr 2005 00:29:20 +0200
Message-ID: <1114381760.3259.37.camel@localhost>
References: <1114166517.3233.4.camel@localhost>
	 <20050422121009.GA7173@pasky.ji.cz> <1114176579.3233.42.camel@localhost>
	 <20050422225733.GH21204@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 00:24:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPpX2-0006yP-1t
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 00:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVDXW3s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 18:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbVDXW3s
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 18:29:48 -0400
Received: from shadow.prohost.de ([216.71.84.228]:41884 "EHLO
	shadow.prohost.de") by vger.kernel.org with ESMTP id S262471AbVDXW3a
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 18:29:30 -0400
Received: from blue (p54A27E62.dip.t-dialin.net [84.162.126.98])
	by shadow.prohost.de (8.11.6/8.11.6) with ESMTP id j3OMTQ029420;
	Mon, 25 Apr 2005 00:29:26 +0200
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050422225733.GH21204@pasky.ji.cz>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-23 at 00:57 +0200, Petr Baudis wrote:
> Dear diary, on Fri, Apr 22, 2005 at 03:29:39PM CEST, I got a letter
> where Christian Meder <chris@absolutegiganten.org> told me that...
> > > > /<project>
> > > > 
> > > > Ok. The URI should start by stating the project name
> > > > e.g. /linux-2.6. This does bloat the URI slightly but I don't think
> > > > that we want to have one root namespace per git archive in the long
> > > > run. Additionally you can always put rewriting or redirecting rules at
> > > > the root level for additional convenience when there's an obvious
> > > > default project.
> > > > 
> > > > Should provide some meta data, stats, etc. if available.
> > > 
> > > I don't think this makes much sense. I think you should just apply -p1
> > > to all the directories, and define that there should be some / page
> > > which should contain some metadata regarding the repository you are
> > > accessing (probably branches, tags, and such).
> > 
> > Hi,
> 
> Hi,
> 
> > remember that I want to stay stateless as long as possible so everything
> > important has to be encoded in the url. So somewhere in the url the git
> > archive to show has to be encoded. If I remove the <project> portion how
> > do I know on the server side which repo to show ?
> 
> since you are configured appropriately.
> 
> You need to be anyway. Someone needs to tell you or your web server
> "this lives at http://pasky.or.cz/wit/". So you bind "this" to the
> given repository.
> 
> No problem with an additional configuration possibility to say "at that
> place, clone your life place for the given repositories", but if I want
> to have just a single repository at a given URL, it should be possible.
> 
> I'm just trying to argue that having it _forced_ to have <project> as
> the part of the URL is useless; this is matter of configuration.

Ok. Got it. <project> for a multi-repo setup and in the simple case of
just one repo <project> can be dropped from the url. Reasonable.

> > > > * Blob data should be probably binary ?
> > > 
> > > What do you mean by binary?
> > 
> > content-type: binary/octet-stream
> 
> Ah. So just as-is, you mean?

Yes.

> 
> > > Anything wrong with putting ls-tree output there?
> > 
> > ls-tree output should be in .html (see below)
> 
> What if I actually want to process it by a script?

Use the .html variant and parse it. Or we add a .txt and/or .xml for
easier parsing.

> 
> > > > -------
> > > > /<project>/tree/<tree-sha1>
> > > > 
> > > > Tree objects are served in binary form. Primary audience are scripts,
> > > > etc. Human beings will probably get a heart attack when they
> > > > accidentally visit this URI.
> > > 
> > > Binary form is unusable for scripts.
> > 
> > Why should it be unusable for a downloading script. It's just the raw
> > git object.
> > 
> > > We should also have /gitobj/<sha1> for fetching the raw git objects.
> > 
> > Everything above is supposed to be raw git objects. No special encoding
> > whatever.
> 
> You have a consistency problem here.
> 
> Raw git objects as in database contain the leading object type at the
> start, then possibly some more stuff, then '\0' and then compressed
> binary stuff. You mean you are exporting _this_ stuff through this?
> 
> That's not very useful except for http-pull, if you as me. It also does
> not blend well with the fact that you say commits are in text or so.

Ok. We spoke of two different things. With raw objects I meant the
uncompressed raw content while you spoke of the raw compressed git
objects. Ok I'm dumb but now that I've understood what you said I agree
with you: we need one generic url for fetching compressed objects.

> 
> > > > -------
> > > > /<project>/tree/<tree-sha1>/diff/<ancestor-tree-sha1>/html
> > > > 
> > > > Non recursive HTML view of the objects which are contained in the diff
> > > > fully linked with the individual HTML views.
> > > 
> > > Why not .html?
> > 
> > I think .html isn't very clear because it would
> > be ..../<ancestor-tree-sha1>.html which somehow looks like it has
> > anything to do with the ancestor-tree. But it's the html version of the
> > _diff_ and not the ancestor-tree.
> 
> Perhaps /tree/<sha1>.html/diff/<ancestor> ?
> 
> I'd lend to ?diff=<ancestor> more and more. The path part of URI is
> there to express _hierarchy_, I think you are abusing that when there is
> no hierarchy.

But I'd argue that you are abusing queries ;-)
After all any given URI of the above kind is linking a specific diff
resource. It's a completely static resource from a user POV. The fact
that the server is probably dynamically generating it is just an
implementation detail.

> 
> > > For consistency, I'd stay with the plaintext output by default, .html if
> > > requested.
> > 
> > Remember that I'm just sitting on top of git and not git-pasky right
> > now. So there's no canonical changelog plaintext output for me. But I'm
> > not religious about that.
> 
> But there is canonical HTML output for you? ;-)

No. Changelog isn't defined by git so there's no canonical output of any
flavour.

> > > OTOH, I'd use
> > > 
> > > 	/log/<commit>
> > > 
> > > to specify what commit to start at. It just does not make sense
> > > otherwise, you would not know where to start
> > 
> > Start for the changelog is always head, but I guess that's pretty
> > standard. With git log you always start at the head too.
> 
> If you are sitting on top of git and not git-pasky, you have no assured
> HEAD information at all.

I've got HEAD. I'm still watching the discussion of tags.

> > If you want to start at a specific commit. Why not start
> > at /linux-2.6/commit/<sha1>.html ?
> 
> And how does that give me the changelog?

You could click through the commit chain interactively or we could add a
changelog from here function.
 
> > > I think the <commit> should follow the same or similar rules as Cogito
> > > id decoding. E.g. to get latest Linus' changelog, you'd do
> > > 
> > > 	/log/linus
> > 
> > Like I said above I think the shown head should be encoded in the
> > project id.
> 
> I thought the project was mapped to repository? But I might just have
> blindly assumed that. ;-) (That does not make me like your approach
> more, though.)

Ok. I think I misunderstood you here. You want to publish the different
heads you are tracking with the same repo, right ?

The proposal didn't account for this scenario yet. I'll think about it.



				Christian

-- 
Christian Meder, email: chris@absolutegiganten.org

The Way-Seeking Mind of a tenzo is actualized 
by rolling up your sleeves.

                (Eihei Dogen Zenji)

