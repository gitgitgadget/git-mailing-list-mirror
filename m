From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [QGIT RFC] Unit tests for QGit
Date: Sun, 17 Aug 2008 21:58:39 +0200
Message-ID: <20080817195839.GB4542@efreet.light.src>
References: <20080808211318.GA4396@efreet.light.src> <e5bfff550808170846y522cc6a8w59b696be39df311b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 22:00:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUoQI-0006d7-O6
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757399AbYHQT6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 15:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756584AbYHQT6w
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 15:58:52 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:39532 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757317AbYHQT6v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 15:58:51 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 3B91857387;
	Sun, 17 Aug 2008 21:58:47 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id yoYiGQ0SoIVP; Sun, 17 Aug 2008 21:58:43 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 3DAA557423;
	Sun, 17 Aug 2008 21:58:42 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KUoOd-00020n-Mx; Sun, 17 Aug 2008 21:58:39 +0200
Content-Disposition: inline
In-Reply-To: <e5bfff550808170846y522cc6a8w59b696be39df311b@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92623>

On Sun, Aug 17, 2008 at 16:46:34 +0100, Marco Costalba wrote:
> On Fri, Aug 8, 2008 at 10:13 PM, Jan Hudec <bulb@ucw.cz> wrote:
> > I've already done the later (have patch series ready), but I am now thinking
> > that I should probably redo it the first way. What do you think. Does it make
> > sense to do that?
> 
> Could you please post somewhere the patches ?

I only have the basic infrastructure (building and basic runner) ready, while
I am trying to figure out how individual parts of QGit are supposed to work.
But I can publish that, yes.

We had a very busy time at work lately, so I didn't get to it much. I'll try
to write some tests soon.

> Better yet to fork from http://repo.or.cz/w/qgit4.git and set up your
> tree on http://repo.or.cz/ host (it's easy and fast, thanks Peter :-)
> 
> I can check that and eventually pulling from that.

Makes sense. git://repo.or.cz/qgit4/bulb.git

But as I said, I only have basic infrastructure and am currently looking at
what to write tests for and how exactly that test should work. The detection
of git vs. stgit branch (does not work for me) is likely first candidate, but
that is not UI thing. Maybe the effects of that option on the UI are the next
(I would like to make them more localized somehow, though I don't know how
yet). Other likely candidate would be anything which could be affected by
funny filenames (containing spaces, newlines, quotes, backslashes, control
chars and such).

> As a general rule if you have already done a good chunk of work with
> unit test patches I would avoid to ask you to redo in a different way,
> so I would say it does not make a lot of sense to me at least before
> looking at the code.

I was testing what can be done so far. So now I decided to go the library way
(in scons or manually written makefiles I would just re-link the same .o
files, but qmake does not seem to allow that) to avoid double compilation.

> Marco
> 
> P.S: I have played a bit with qmake some time ago (to set-up the
> double build environment Windows/Linux) so perhaps I could help you in
> finding some useful trick to avoid the cons regarding .pro files you
> posted. But of course I first need to see the patches.

Well, I somehow managed -- except I am not sure I dealed with the windows
part correctly. What could be improved is maybe if you know how to signal
a dependency between two projects. I currently rely on the top-level makefile
always calling the subdirs in the order they are specified, but I fear
portable recursive make does not really offer any better solution, so qmake
can't really do that either.

Unfortunately while Qt is generally documented quite well, qmake
documentation is not so good.

Note: I think I found a bug in qmake here -- when you run qmake at top level,
the makefile will call qmake in subdirectories to create makefiles there, but
the rule has no dependencies, so it will not remake the makefiles when the
.pro files change there.

Also I don't understand why you set 'MAKEFILE = qmake' in the src/src.pro --
it does not seem to be respected, at least when I call it through the
top-level qgit.pro (which I now have to when there are 3 subdirs).

Regards,
Jan

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
