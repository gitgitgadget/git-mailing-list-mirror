From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [QGIT RFC] Unit tests for QGit
Date: Wed, 27 Aug 2008 22:18:19 +0200
Message-ID: <20080827201819.GD15520@efreet.light.src>
References: <20080808211318.GA4396@efreet.light.src> <e5bfff550808170846y522cc6a8w59b696be39df311b@mail.gmail.com> <20080817195839.GB4542@efreet.light.src> <e5bfff550808171330w28dda6a2m32b0e51b1ef73cdc@mail.gmail.com> <20080818180048.GA15520@efreet.light.src> <e5bfff550808190753t4f99ddb6q83886dbca27dbf03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 22:19:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYRUL-0005B8-Cy
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 22:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbYH0US3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 16:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbYH0US3
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 16:18:29 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:49061 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802AbYH0US2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 16:18:28 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 373F557323;
	Wed, 27 Aug 2008 22:18:27 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 3SVnC0HE-ylZ; Wed, 27 Aug 2008 22:18:24 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id E1D28572B0;
	Wed, 27 Aug 2008 22:18:23 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KYRT9-0008Ne-Rt; Wed, 27 Aug 2008 22:18:19 +0200
Content-Disposition: inline
In-Reply-To: <e5bfff550808190753t4f99ddb6q83886dbca27dbf03@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93940>

On Tue, Aug 19, 2008 at 15:53:05 +0100, Marco Costalba wrote:
> On Mon, Aug 18, 2008 at 7:00 PM, Jan Hudec <bulb@ucw.cz> wrote:
> > On Sun, Aug 17, 2008 at 21:30:46 +0100, Marco Costalba wrote:
> >> On Sun, Aug 17, 2008 at 8:58 PM, Jan Hudec <bulb@ucw.cz> wrote:
> >> >
> >> > But as I said, I only have basic infrastructure and am currently looking at
> >> > what to write tests for and how exactly that test should work. The detection
> >> > of git vs. stgit branch (does not work for me)
> >>
> >> This sounds as a bug. Could you elaborate on that please ?

I am slowly progressing towards writing a test case for it ;-).

Actually, I just wrote a first simple test for it. I didn't find this (now
the stg branch finds out properly), but I found another problem -- when
switching from non-stgit branch to a stgit one, Git::init will not notice,
because the path didn't change, so the check is not re-run. Applies to the
other direction too, of course.

> >> BTW the test for a StGit repo is:
> >>
> >> isStGIT = run("stg branch", &stgCurBranch); // slow command
> >>
> >> in function Git::getRefs() , file git_startup.cpp
> >
> > Yes, I've seen that command. But it returns true for me even when it's not
> > a stg branch :-(. I am not sure what the problem there is.
> >
> 
> That's interesting !
> 
> The command just runs "stg branch", in my StGit setup this returns an
> error (some stuff written to stderr) if the directory where it is run
> is not a StGit stack.

I don't recall the details (it was some time ago) and the repository might
have been a bit screwed up. The point there was the branch /used to be/
a stgit one. So it was rather a problem of stgit keeping duplicate
information all over the place.

> run() just detects the error and returns false.

By the way, I looked at the makefiles again and found that they are actually
regenerated correctly when you change the .pro files. While the master
makefile does not have dependencies for the subdir makefiles, each makefile
does have dependencies for itself. And make always tries to rebuild the
makefile before doing anything else. Therefore it does not work to:
    make src//Makefile
but it *does* work to:
    make -C src Makefile
(*and* it will rebuild the makefile when you 'make debug' or 'make release').

Regards,
Jan

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
