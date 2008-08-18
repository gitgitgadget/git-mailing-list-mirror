From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [QGIT RFC] Unit tests for QGit
Date: Mon, 18 Aug 2008 20:00:48 +0200
Message-ID: <20080818180048.GA15520@efreet.light.src>
References: <20080808211318.GA4396@efreet.light.src> <e5bfff550808170846y522cc6a8w59b696be39df311b@mail.gmail.com> <20080817195839.GB4542@efreet.light.src> <e5bfff550808171330w28dda6a2m32b0e51b1ef73cdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 20:02:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV93J-0007uN-Ny
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 20:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbYHRSA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 14:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754040AbYHRSA5
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 14:00:57 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:45556 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753664AbYHRSA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 14:00:56 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id AC9ED572F6;
	Mon, 18 Aug 2008 20:00:55 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id Kw+6uWMkNKR8; Mon, 18 Aug 2008 20:00:51 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 2A2B05730D;
	Mon, 18 Aug 2008 20:00:50 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KV928-0004BE-4g; Mon, 18 Aug 2008 20:00:48 +0200
Content-Disposition: inline
In-Reply-To: <e5bfff550808171330w28dda6a2m32b0e51b1ef73cdc@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92722>

On Sun, Aug 17, 2008 at 21:30:46 +0100, Marco Costalba wrote:
> On Sun, Aug 17, 2008 at 8:58 PM, Jan Hudec <bulb@ucw.cz> wrote:
> >
> > But as I said, I only have basic infrastructure and am currently looking at
> > what to write tests for and how exactly that test should work. The detection
> > of git vs. stgit branch (does not work for me)
> 
> This sounds as a bug. Could you elaborate on that please ?
> 
> 
> BTW the test for a StGit repo is:
> 
> isStGIT = run("stg branch", &stgCurBranch); // slow command
> 
> in function Git::getRefs() , file git_startup.cpp

Yes, I've seen that command. But it returns true for me even when it's not
a stg branch :-(. I am not sure what the problem there is.

> > Well, I somehow managed -- except I am not sure I dealed with the windows
> > part correctly. What could be improved is maybe if you know how to signal
> > a dependency between two projects. I currently rely on the top-level makefile
> > always calling the subdirs in the order they are specified, but I fear
> > portable recursive make does not really offer any better solution, so qmake
> > can't really do that either.
> >
> 
> Could the following help ?
> 
> http://lists.trolltech.com/qt4-preview-feedback/2004-10/thread00174-0.html

Does help a bit. Thanks.
That is, confirms my suspicion that there is no really correct solution and
remembered me the ordered config option, that I noticed in the documentation
once, but wasn't able to find again when I actually wrote the .pro files.

Added the option and rewound the branch on repo.or.cz.

> > Note: I think I found a bug in qmake here -- when you run qmake at top level,
> > the makefile will call qmake in subdirectories to create makefiles there, but
> > the rule has no dependencies, so it will not remake the makefiles when the
> > .pro files change there.
> >
> 
> I knew that. For my use I always delete Makefiles after modifying any
> of *.pro files, I'm sure it exists a better way but honestly I didn't
> investigate too much on this.

I don't think there's too much to investigate -- it looks like an obvious bug
;-). Unless it's caused by the MAKEFILE setting :-( (I'll have to remove it
and check)

> > Also I don't understand why you set 'MAKEFILE = qmake' in the src/src.pro --
> > it does not seem to be respected, at least when I call it through the
> > top-level qgit.pro (which I now have to when there are 3 subdirs).
> >
> 
> >From http://doc.trolltech.com/4.0/qmake-variable-reference.html#makefile
> 
> MAKEFILE
> This variable specifies the name of the Makefile which qmake should
> use when outputting the dependency information for building a project.
> The value of this variable is typically handled by qmake or qmake.conf
> and rarely needs to be modified.
> 
> I annotated the src.pro file and I found that line belongs from the
> very first version of src.pro, possibly copied from the Qt examples,
> so it smells you are right and we could remove that.

Looks like that. Funny thing is, that normally the makefiles are called
Makefile for me, not qmake, but I did see the qmake files (IIRC when I ran
qmake -recursive). That would mean it takes the value from the top-level .pro
and ignores it in the subdirs.

Regards,
Jan

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
