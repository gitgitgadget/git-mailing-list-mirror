From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 10 Jun 2007 15:34:57 +0200
Message-ID: <20070610133457.GB24869@artemis>
References: <20070603114843.GA14336@artemis> <20070609121244.GA2951@artemis> <46a038f90706092359i43a6e834rc096e53a28fbee51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 15:35:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxNZZ-0001Wy-Ed
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 15:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbXFJNfB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 10 Jun 2007 09:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbXFJNfB
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 09:35:01 -0400
Received: from pan.madism.org ([88.191.52.104]:44949 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbXFJNfA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 09:35:00 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 5D882CAF1
	for <git@vger.kernel.org>; Sun, 10 Jun 2007 15:34:58 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A70B7C1F3; Sun, 10 Jun 2007 15:34:57 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46a038f90706092359i43a6e834rc096e53a28fbee51@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49727>

On Sun, Jun 10, 2007 at 06:59:13PM +1200, Martin Langhoff wrote:
> On 6/10/07, Pierre Habouzit <madcoder@debian.org> wrote:
> >  FWIW I've begun to work on this (for real). I've called the tool
> >"grit". You can follow the developpement on:
> >
> >  * gitweb: http://git.madism.org/?p=3Dgrit.git;a=3Dsummary
> >  * git:    git://git.madism.org/grit.git/
>
> Call me a fool, but writing a <new> bugtracker looks like a
> boil-the-oceans scheme.

  Sure, what if I like it anyway ?

> Adding git & gitweb support to traq, bugzilla, mantis, gforge, etc is
> what is going to make the difference. Most of those have already the
> ability to "link" to one or more commits -- after the commits are don=
e
> and in GIT.

  Sure, you can do that and still inherit from the many downsides of
those tools: central, needs another separate tool to work with, and a
tool that nowadays tends to eat 500Mb of your memory if you take the
most hype implementation of it (Yes I'm describing a web browser), that
is slow like hell (because yes, there is many clients at the same time
on the central server, that is overloaded like hell), and so on.

  You can like central web UIs, your choice. And I suppose if grit work=
s
well, there will be one at some point.

> So you can tell your bugtracker
> - which commit fixed it -- usually auto-linked if you include the
> bugnumber in the commit message
> - which commit added the test -- auto linked as above
> - which commit introduced the bug -- if such thing exists and someone
> digs it up

  yeah, that is what bugtrackers already do. Though, that's of no use
for release managers. What is useful is what people call "milestones" i=
n
trac e.g., meaning a set of bugs that has been flagged as needing to be
fixed. And what a release manager need is a tool to deal with this set
of bugs as a whole.

  That's the same argument that Linus has against per-file tracking.
Also atm when you e.g. backport a patch that fixes this or this bug,
you're no BTS helps you tagging the bug as fixed in that branch as well=
=2E
Not to mention that BTS I know do not make any use of the commits DAG.
And for a very good reason, there is no real DAG in many existing tools
(svn, cvs, ...).

> If the bugtracker can also auto-link things that look committish in
> text entered by users (someone might write "bisect sez that f345e is
> to blame"), with tooltips indicating in which heads those commits
> resides (like gitk does), then it's just gorgeous.

  that's not up to the BTS tool to do that, it's way to high level. It'=
s
up to the importing filters/hooks that will parse the associated ML, an=
d
that would translate that to useful low level BTS commands.


> And definitely, if you use git as an alibi to write a new bugtracker,
> don't use the "works only with git" as a feature. It should work with
> as many SCMs as possible.

  No it should not, because it can't. I want the distributed and
Bug status spanning-DAGS be a central feature. So that means that this
tool can only work on top of SCMs that support that. ttbomk git, hg,
_maybe_ bzr fit the description. I only know the former, but I really
plan to write the tool in a way that the underlying SCM does not matter=
s
_too_ much. Maybe I'll fail. Honestly, I don't really care (yet ?).



> OTOH, that's just me, I'm lazy and like to work on already-successful
> projects that are 99% there for my needs (and where I can add that
> 1%).

  You're a lucky guy. All bug trackers I've used suck a way or another,
that impedes my workflow a lot. Let's cite a couple:
  * bugzilla: takes more from the -zilla than from the BTS side. It's
    huge, monstruous, slow (have ever used glibc's bugzilla ? it has
    maybe 5k bugs, it's slow like if it ran on an Atari ST), complex,
    the mail gateway suck hard, it's completely unusable for me. Believ=
e
    me, I've packaged KDE for 2 years in Debian, now am in the glibc
    team. Every single day I have to work on this horrible tool is a
    PITA.

  * flyspray: I've been upstream for a short time. Visually nice, good
    to work with, UI is great. Integration totally suck, worthless.
    Can't use mails either, needs a Web Browser -> useless. The same
    holds for mantis, roundup and a lot of other friends.

  * debbugs: oh yeah there is a mail interface. So slow that you have t=
o
    wait up to 15 minutes to see your command be taken into account. An=
d
    when you have to deal with dozens of bugs (Yes I've done that on a
    regular basis) you _have_ sometimes to wait for the answer to come
    back (because you need an ID that will be in there e.g.) to continu=
e
    your work. That is unacceptable, you pass most of your time waiting=
=2E
    Moreover sometimes you made an error in your commands, so you also
    need to parse the anwer ... one day later because "immediateley whe=
n
    you still remembered what this was about" is not an option.
    Unacceptable again. The plus: it uses mboxes, hence is worthwile in
    a hacking environment, it fits the workflow well.

  * trac: very very very nice tool. I mean it. We use it at work, where
    I have to suffer svn (through git-svn though). It's really nice (di=
d
    I repeat myself ?). THough, it's on top of svn, and you can't use
    the Bugs informations from your repository. You can't say: I'm
    backporting that patch into that branch. Now what affects this
    branch please ? Trac can't answer that (and ttbomk now BTS really
    can anyway, except Debian's debbugs instance, and it's somehow
    limited). That is a question a release manager takes 80% of his tim=
e
    to ask. I hope grit can take back to the 0.01% of his time, which i=
s
    still too much.


On Sun, Jun 10, 2007 at 08:55:21PM +1200, Martin Langhoff wrote:
> On 6/10/07, Jan Hudec <bulb@ucw.cz> wrote:
> >I don't know about any *distributed* bug tracker, which is the point
> >here.
>
> As an end user, I suspect I _don't_ want to have to report a bug in a
> distributed bug tracker ;-)

  I trol^Wdiscuss everyday on debian's channel with friends that tell
that svn is the best tool ever, and that they would never ever use a
distributed SCM because it's too hard to understand. Your call.

> > We have several distributed version control tools, but no other
> > distributed tools for the other tasks in configuration management.
>
> Bugtrackers are co-owned by developers, users and (where they exist)
> project managers.

  That's exactly why distributed rock. Because everyone could _really_
own _his_ bugtracker. This solves the same range of ACLish issues git
solves with respect to the code.

> > - Distributed version control is designed to decrease the workload =
of
> >   the central maintainer(s) while keeping him in control. But with
> >   centralized
>
> And to provide a single place for users to report a problem and track
> its status.

  Why wouldn't it exist a "public reporting interface"-branch ? that
would be the same purpose as the mainline ~linus/linux2.6.git tree. And
you can build/instanciate your beloved web UI on top of that, and peopl=
e
would just have to pull from there. What a shock, it's easy !

> > If it uses git as it's database, which it probably will,
>
> Well - hmmm. Git's database is great at tracking _content identity_.
> But a bug's content identity (description+comments+status) changes al=
l
> the time. I don't think it's naturally a good match.

  Oh, because the code never changes. Doh, how stupid I am :)
  No, really, you name your bug after the sha hash of the first report,
I think that's pretty obvious. That gives you a bug name. Then you ask
git for "what's the current sha for this bug in the tip of the BTS
branch", then you ask "so now what this new sha is pointing to in the
code". That's a small indirection that I suppose is bearable.

> > Yes. But for many people current bug tracking tools do NOT work 99%=
=2E
>
> Hmmm. I agree in that "does not work disconnected" is a big issue wit=
h
> web tools, but debbugs works disconnected, and is good. Git's
> bugtracker (git@vger) works disconnected too ;-) And googlegears migh=
t
> help the rest of us. Is there any other problem with current BTs?

  It's not integrated with the workflow. And sorry, but git@vger (or
workse lkml@vger).. it does not work. Maybe for git it does because the
flow is still human manageable, and that it seems junio has enough time
for it. But for the kernel ? please. You should read Bastian Blank
frustration about regressions and nobody tracking them. Know why ?
because there is no tool that is well known and well integrated in the
workflow. There is a long rant against kernel.org's bugzilla, you shoul=
d
read it as well. It's not really instructive (at least there wasn't
anything new for me in it, I was already bought to many arguments in
there). But you'll see the world isn't as rosa-lila you think it is.


On Sun, Jun 10, 2007 at 08:38:03PM +1200, Martin Langhoff wrote:
> On 6/10/07, Junio C Hamano <gitster@pobox.com> wrote:
> > After looking at the above existing alternatives, some brave soul
> > might decide and say, "Hey, I can write something better in 2 weeks=
"
> > ;-).

  I'm sure I could come up with something really better in say a
month... If I hadn't paid work to do too :)

> And "it's closely integrated with git" can actually be a misfeature.
> Cool if it's what gets you going, but not enough for world domination
> ;-)

  It's a misfeature for you because you read it as "non portable".
That's a fair point. And like said, it may be extended to SCM's with th=
e
same set of features I need to build it. But let's be honnest, I don't
care about a BTS that uses the smallest common set of features of SCM's=
=2E
Reading this list, you should know it's almost a void set. No, I think =
a
good BTS should make an excellent use of high level features of the SCM=
=2E
The real problem is, there is maybe 2 or 3 SCMs that have this set of
strong and good features. Too bad for the other, I can't work with them=
,
they suck hard, and I don't see why I should support bad practices
anyways.

  (Yes I'm also a guy with strong opinions too, it's not really
restricted to Linus ;p)

> I agree it's useful, but I don't think it has any benefit having it i=
n
> the SCM _at all_. Having them in the BT is a lot more flexible -- and
> the fact that git has stable commit IDs makes it easier to integrate
> in a BT; as the BT can spot that the commit fixing bug 123 is now
> merged into head ZZ as well as head YYY.

  If you do that you loose:
  * fastness, and I don't want to work with debbugs anymore.

  * distribution: Meaning that for _one_ project everybody needs to use
    this central bugtracker. Whereas .oO(kernel) there is some projects
    where the subcomponents are dealt with from very different teams,
    very different way to release things, and they are interested with
    their bugs, and their bugs only. They would prefer a very fast
    interface to deal with their 1k bugs, and not worry about the 100k
    the rest of the project has.
    Branching bugs also makes sense you know ?

> Now, to rule the world, BTs gain a lot more from being able to
> integrate with different SCMs,

  You are the one saying it. I beg to differ.

> automated test systems (like tinderbox), MTAs (debbugs), wikis (traq)=
,
> stats tracking for PHBs (bugzilla), etc. So loose coupling wins here,
> and git's SHA1s are great for that.

  IMHO a BTS is a _low_ level tool. that's the road git took, I
sometimes describe the plumbing git commands as the "Assembler" of the
SCM world to friends when I talk to them about git. That's really the
best way to implement a thing: have a small small set of rock solid,
well designed tools, and build the others as porcelains with them.

  Testing is a high level tool. I don't need to support them, I need to
have exactly the low level querying rocket-fast query interfaces so tha=
t
integration scripts are at most 100 lines long.

> And at git's end we can get the smooth integration using/abusing that
> loose coupling strategy. So if git-log/gitk/qgit grow some hooks that
> can be used to perform a lookup... I can think of a perl script that
> gets events for each SHA1 that git-rev-list produces and returns one
> bug number, url and title (or more than one) that then git-log / gitk
> / qgit / annotate can use to further "decorate" the commit info in a
> similar style to what gitk is doing now with head names in each
> commit.
>
> Would that fit your vision of a nicely integrated tracker?

  Honestly ? No, because that would be horribly slow (but I'd love to b=
e
proven wrong).


Cheers,

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
