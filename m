From: "J.H." <warthog9@kernel.org>
Subject: Re: Another bench on gitweb (also on gitweb caching)
Date: Thu, 14 Feb 2008 14:43:53 -0800
Message-ID: <1203029034.4766.19.camel@localhost.localdomain>
References: <20080210030919.GA32733@c3sl.ufpr.br>
	 <200802131317.48815.jnareb@gmail.com>
	 <1202929923.2687.15.camel@localhost.localdomain>
	 <200802140201.55420.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 23:45:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPmpP-00045e-DS
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 23:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757252AbYBNWoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 17:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbYBNWoY
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 17:44:24 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:40357 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932665AbYBNWoU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 17:44:20 -0500
Received: from [10.255.255.198] (65-115-68-195.dia.static.qwest.net [65.115.68.195])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.13.8) with ESMTP id m1EMhsBs008515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Feb 2008 14:43:54 -0800
In-Reply-To: <200802140201.55420.jnareb@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-1.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/5813/Thu Feb 14 10:42:23 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73919>

On Thu, 2008-02-14 at 02:01 +0100, Jakub Narebski wrote: 
> On Wed, 13 Feb 2008, J.H. "Warthog9" wrote:
> > On Wed, 13 Feb 2008 13:17:46 +0100, Jakub Narebski wrote:
> >> 
> >> BTW. did you consider using cgit (C/Caching git web interface) instead
> >> or in addition to gitweb? Freedesktop.org uses it side by side with
> >> gitweb. I wonder how it would perform on kernel.org...
> > 
> > When I branched and did the initial work for gitweb-caching CGit had
> > only barely made verion 0.01.  So putting something *that* new into
> > production on Kernel.org didn't even remotely make sense.
> 
> If I remember correctly cgit was _created_ in response (or at least
> around) to discussion on git mailing list that kerne.org needs caching
> for gitweb.
> 
> BTW. I have CC-ed CGit author, Lars Hjemli.

I didn't realize it had come out of those discussions a couple of years
ago, though it's good to hear that it did come out.  From what I have
used of it, it does seem to be as fast as gitweb-caching and it's
caching doesn't seem to be quite the sledge hammer that mine is.

> 
> > Since than 
> > the caching modifications (along with a few other fixes and such) have
> > proven to be quite stable and have withstood the onslaught of users
> > fairly well.  I have toyed with the idea of giving up on gitweb-caching
> > (since I either need to redo it to bring it closer to mainline gitweb,
> > and probably give up on breaking it up into multiple files or switch to
> > something new)
> 
> By the way, why did you split into so many modules? I would think
> that separating into generic modules (like for example commit parsing),
> HTML generation modules (specifing to gitweb) and caching module;
> perhaps for easier integration only main gitweb (core version)
> and caching module would be enough.

I did it originally for a couple of reasons:

1) a single script that's almost 6000 lines long is a little hard to
handle in a single gulp.  I can appreciate why it's being done that way,
mainly to simplify installation, but...

2) ... I needed something to help me understand the flow of code more -
ripping it apart was a good way to do it and try and group similar
functions.

There is an obvious downside, in retrospect, to me doing it this way - I
can't track upstream *nearly* as easily as I would like.  Which means
that the code gitweb-caching is based on is about a year and a half old
(it has had a major update along the way but that took me two days of
manually applying patches to get updated)

> 
> I was thinking about adding caching, using code from your fork,
> to git.git gitweb, somewhere along the line... I guess I can move
> it earlier in the TODO list, somewhere along CSS cleanup and log-like
> views generation cleanup, and using feed links depending on page.

It's on my todo list as well, basically re-base to current head and
instead of breaking stuff up like I did in the original, completely redo
the tree so that I can pull from trunk easier.  Considering I'll have
some time that I can spend on my OSS projects in the next couple of
weeks again - I was going to try and get this accomplished and back into
my tree.

> 
> > but the current question that I, and no one else on the 
> > kernel.org admin staff has had time to investigate is does cgit use the
> > same url paths.  If so it would be a simple drop-in replacement and that
> > would appeal to us.  If it doesn't we can't use cgit and will have to
> > stick with gitweb or a direct derivative there-of.
> 
> Unfortunately cgit is not designed to be gitweb compatibile; it is
> simplier (which might be considered better), doesn't support the
> multitude of gitweb views, and unfortunately doesn't understand
> gitweb URLs.

Sadly - that makes it more or less unusable to us at this point.  There
are, I'm sure, a number of links that point back to kernel.org that
would be nice to not break - if it's really felt that this isn't the
case I would consider switching, but if gitweb + my caching code works
it might be better for me to try and get the code merged back into trunk
and not risk changing infrastructure that's been in place for several
years now.

> 
> On the other side having gitweb and cgit coexist together on the same
> set of repositories should be quite easy, as shown by FreeDesktop folks:
> http://gitweb.freedesktop.org and http://cgit.freedesktop.org
> 

I'm not a big fan of maintaining multiple things that all accomplish
the same goal.  I would rather devote the resources to maintaining one
on kernel.org vs. maintaining two.  This prevents users from getting
confused and in the event of upgrades forgetting that one needs
updating vs. the other one.

>  
> >> (Almost) every optimization should begin with profiling. Could you tell
> >> us which gitweb pages are most called and perhaps which pages generate
> >> most load for kernel.org?
> > 
> > That would be correct, though when I did up gitweb-caching the profiling
> > was blatantly obvious, with every single page request git was being
> > called, git was hammering the disk and it was becoming increasingly
> > obvious that going and running git for every page load was completely
> > impractical.
> 
> [bringing back old quote]
> >> On Wed, 13 Feb 2008, J.H. "Warthog9" wrote:
> >>
> >>>  There is currently something like 20G of disk being used on one
> >>> of kernel.org's machines providing the cache (this does get flushed on
> >>> occasion - I think) but that is providing caching for everything that
> >>> kernel.org has in it's git trees (or 255188 unique urls currently).
> 
> What I meant here that one should balance between not having cache
> at all (and spending all the CPU), to caching everything under the
> sun (and spending all the HDD space). To that one should know which
> pages are most requested, so they would be cached by having static
> page to serve; which generate most load / are less requested, so
> perhaps git commands output would be cached; and which are rare enough
> that caching is waste of disk space, and hints to caching proxies
> should be enough.

To a greater extent, disk is cheap, and load is expensive.  While I
agree it would be worth spending cpu time to not cache things - thats
not the way gitweb / git works.  Gitweb forces calls down to disk if
it's displaying the index page or showing a diff between two
revisions.  The problem comes in that git, while fast, is very resource
intensive, requiring a lot of ram and a lot of disk seeking - on a very
busy setup, disk seeking is a killer.  What you want to be able to do
is take a file and just run it straight out, not have to poke around to
re-assemble everything and then output.  This is one of the reasons why
the index page is so painful - it's reassembling bits from *every*
repository.  It's not cpu that's getting hit, it's the disk and ram
that's getting hit.

So yes - while I agree caching can be expensive, in very high volume
setups you have to have caching of some sort.  Caching proxies aren't
smart enough for something like gitweb either, having a caching layer
directly in gitweb makes a lot more sense - you know what pages need
caching, which ones don't, what may be hit harder than others, what you
can have a longer cache timeout, etc on.


> [...]
> > As for the most often hit pages - the front page is by far hit the most,
> > which should be no surprise to everyone, and it is by far the most
> > abusive since it has to query *every* project have.  After that things
> > taper off as people find the project they want and go looking for the
> > data they are interested in.
> 
> But what of those pages are most requested and generate most load?
> 'summary' page? 'rss' or 'atom' feeds? 'tree' view? README 'blob'?
> snapshot (if enabled)?

Right now I don't have explicit statistics on that, though it wouldn't
be hard to add in an additional file or small database of some sort
that would track generation times.  My gut feeling is the index page is
the worst (particularly with the number of trees we have), followed by
the summary pages, and from there things will fall off dramatically as
most pages after that may not get hit often.

   
> >>  How new projects are added (old projects
> >> deleted)?
> > 
> > By and large - left up to the users - if they don't want their tree
> > anymore they delete it (though I don't know of anyone who has) if they
> > need another one - they create it.
> 
> Bummer. If projects were created by some script (like I think is
> the case for git hosting facilities, like repo.or.cz, GitHub,
> Gitorious or TucFamily) we could update projects listing file
> (so gitweb doesn't need to scan directories), and perhaps even
> add some gitweb-specific hooks (add multiplexer + hooks).

At this point the git tree is left up to the user and we have no
intention of changing it, we don't even force them to turn on the
post-update hook that will deal with git-update-server-info.

> 
> >>  Do you control (can add to or can add multiplexing) to update
> >> or post-receive hooks?
> > 
> > No.  We do not want to, at all, control in any way the tree's that
> > people put up on Kernel.org.  We just don't have the bandwidth to deal
> > with that for every single tree on kernel.org.  Anything that would
> > require us to go changing or forcing a user to change something in their
> > git tree means we've already lost.  Taking the caching layer and making
> > it 100% transparent to the git tree's owners and generally speaking to
> > the end user makes things very simple for us to deal with.
> 
> That's bad, because update / post-recive hook could be used for example
> to invalidate 'summary', 'rss' and 'atom' views cache, and perhaps
> regenerate projects list page. First request would generate cache, which
> would be then used till it was deleted by the hook script.

They could be useful, but this is completely left up to the tree's
owner, we provide a location for them to publish their trees, we don't
want to control or limit how or what they do with those trees.

>  
> >> 
> >> Without this data we could concentrate on things which are of no
> >> importance. BTW. I wonder if slitting projects_list page would help...
> > 
> > That would be bad - I know for a fact there are people who will go to
> > git.kernel.org and then search on the page for the things they want - so
> > changing this would probably cause a lot of confusion for minor gain at
> > this point.
> 
> I was thinking about first page being page of categories, perhaps with
> "search projects" box. The page with so many projects is a bit unwieldy.
> 
> P.S. Do you make use of alternates, or do you left it to users to setup.?

Left up to the users, we suggest it's use but I'm sure there are trees
on kernel.org that could use alternates but don't.

- John 'Warthog9' Hawley
