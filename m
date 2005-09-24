From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE qgit-0.95]
Date: Sat, 24 Sep 2005 20:16:36 +0200
Message-ID: <20050924181636.GD25069@pasky.or.cz>
References: <20050924160641.60151.qmail@web26307.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 20:17:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJEZo-0007x4-QR
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 20:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVIXSQm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 14:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVIXSQm
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 14:16:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52950 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932218AbVIXSQl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2005 14:16:41 -0400
Received: (qmail 28113 invoked by uid 2001); 24 Sep 2005 20:16:36 +0200
To: Marco Costalba <mcostalba@yahoo.it>
Content-Disposition: inline
In-Reply-To: <20050924160641.60151.qmail@web26307.mail.ukl.yahoo.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9242>

Dear diary, on Sat, Sep 24, 2005 at 06:06:40PM CEST, I got a letter
where Marco Costalba <mcostalba@yahoo.it> told me that...
> This is a performance update release.
> 
> The detailed list of changes is below, but the bottom line is 
> qgit-0.95 is _really_ fast.
> 
> It tooks about 4 seconds, on my box, to run qgit --all on today linux tree against 
> about 65 seconds with gitk. Also the used memory it seems lower.
> 
> As a 'theoretical maximum speed' a bare:
> 
> git-rev-list --header --topo-order --parents HEAD > /dev/null
> 
> Runs in about 2 seconds.
> 
> So this is the main reason I post this release. I doubt a little bit about this results 
> because the spread with gitk it seems too much, so I would like a double check.

Yes, it is several times faster than gitk, good work. Had to do this in
order to be able to compile it with gcc-3.3.6, though (it complained
about goto'ing after initialization of nc - that's bogus since there's
the return, but...):

diff --git a/src/git_startup.cpp b/src/git_startup.cpp
--- a/src/git_startup.cpp
+++ b/src/git_startup.cpp
@@ -469,7 +469,9 @@ again:
 			if (!resumeTimer.isActive())
 				resumeTimer.start(1, true); // with 0 ms there is an oops in libqt-mt
  			return; // we suspend here to let GUI updating
+		}
 
+		if (false) {
 resume:
 			suspended = false;
 			processTime.start();


Besides that, this is what I don't like about qgit:

* It'd be nice to be able to choose to see all commits in the initial
dialog by single click (I know about --all). Perhaps a radio buttons
choosing between all and selected? Also, you might add the "diff against
working copy" option to that dialog as well.

* The graph column is too narrow. It should be auto-sized so that the
graph fits in, or at least there should be some clear indication that
the graph does not fit to the column at the given point. This confused
me a lot at first.

* Could you make the grey background for odd commits span to the whole
line, including the commit graph?

* The commit time is relative to now, which makes no sense to me. Also,
it is in the second column instead of the last one like in gitk, which
seems better to me. At least, the column is too narrow and then it
blends together with the commit title.

* In the filter radio buttons groups, only first few letters of the
labels are visible, and apparently no tooltips. Same problem in the
settings dialog, most of the options have the labels cut around 2/3, and
the window is non-resizable on top of that - why? I hate non-resizable
windows, especially because they are usually too small. :-)

* Single-clicking at a commit produces a significantly slower response
than in gitk, where I see the difflist and stuff nearly instantly - it
takes several hundreds of ms in qgit. That's quite annoying.

* Getting to the diff view was non-obvious for me. It'd be nice to have
some [diff] button as well somewhere. Or you could also show the diff in
the bottom part of screen in the commit view, I think gitk solved this
nicely.

* Clicking on the file was supposed to bring some annotated view, but if
it is so, it should write "Annotate" in the window title, and should
indicate that it is computing it on the background (and is really slow
in that, or I don't know, but always only single revision was shown
there). It is unclear what the "pin file" checkbox is supposed to mean,
and the whole dialog is just very confusing. :-)

* The lane information might be available as a tooltip in addition to
right-clicking on it - that wouldn't occur to me.

* Why is the Edit menu aligned to the right?

* Well - I don't like the line graphics and prefer gitk's. This is
perhaps a matter of taste, though. I find the graphics to be too tiny,
thin and not so clear as gitk's, which makes it harder to see the commit
flow. I also like diagonal lines more than angles, but that might be
just because I'm used to them.

OTOH, qgit actually flows the commits around the 0.99.6 release and such
better than gitk, keeping them all in a single lane instead of flowing
off to the right. It is still a bit hard to see what actually went on,
but curing that would require sorting the commits by date.


Nice work otherwise. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
