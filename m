From: Willy Tarreau <w@1wt.eu>
Subject: Re: Reporting bugs and bisection
Date: Wed, 16 Apr 2008 22:04:08 +0200
Message-ID: <20080416200408.GA7764@1wt.eu>
References: <48028830.6020703@earthlink.net> <alpine.DEB.1.10.0804131546370.9318@asgard> <20080414043939.GA6862@1wt.eu> <20080414053943.GU9785@ZenIV.linux.org.uk> <20080413232441.e216a02c.akpm@linux-foundation.org> <20080414072328.GW9785@ZenIV.linux.org.uk> <Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au> <4804765B.2070300@davidnewall.com> <bd6139dc0804160515s64a36748v49556c56d475dda4@mail.gmail.com> <20080416132634.GA545@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sverre@rabbelier.nl, git@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	James Morris <jmorris@namei.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>, david@lang.hm,
	Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Tilman Schmidt <tilman@imap.cc>,
	Valdis.Kletnieks@vt.edu, Mark Lord <lkml@rtr.ca>,
	David Miller <davem@davemloft.net>, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org, netdev@vger.kernel.org,
	David Newall <davidn@davidnewall.com>
To: Adrian Bunk <bunk@kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 16 22:38:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmEF8-00086d-Uo
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 22:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbYDPU1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 16:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753296AbYDPU1s
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 16:27:48 -0400
Received: from 1wt.eu ([62.212.114.60]:3166 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051AbYDPU1q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 16:27:46 -0400
Content-Disposition: inline
In-Reply-To: <20080416132634.GA545@cs181133002.pp.htv.fi>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79746>

On Wed, Apr 16, 2008 at 04:26:34PM +0300, Adrian Bunk wrote:
> On Wed, Apr 16, 2008 at 02:15:22PM +0200, Sverre Rabbelier wrote:
> > I'm not subscribed to the kernel mailing list, so please include me in
> > the cc if you don't reply to the git list (which I am subscribed to).
> > 
> > Git is participating in Google Summer of Code this year and I've
> > proposed to write a 'git statistics' command. This command would allow
> > the user to gather data about a repository, ranging from "how active
> > is dev x" to "what did x work on in the last 3 weeks". It's main
> > feature however, would be an algorithm that ranks commits as being
> > either 'buggy', 'bugfix' or 'enhancement'. (There are several clues
> > that can aid in determining this, a commit msg along the lines of
> > "fixes ..." being the most obvious.)
> >...
> 
> At least with the data we have currently in git it's impossible to 
> figure that out automatically.
> 
> E.g. if you look at commit f743d04dcfbeda7439b78802d35305781999aa11 
> (ide/legacy/q40ide.c: add MODULE_LICENSE), how could you determine 
> automatically that it is a bugfix, and the commit that introduced
> the bug?
> 
> You can always get some data, but if you want to get usable statistics 
> you need explicit tags in the commits, not some algorithm that tries 
> to guess.

yes, and doing that would get back to the bureaucracy some people are
trying to reduce in order to save time to do the real work.

However, in another project of mine, I've got used to systematically
indicate the type of change in the subject line. It does not get any
slower for the author, and it appears in shortlogs. And quite amazingly
the principle has immediately been adopted by several contributors :

-----
Note to contributors: it's very handy when patches comes with a properly
formated subject. Try to put one of the following words between brackets
to indicate the importance of the patch followed by a short description:

[MINOR]    minor fix, very low risk of impact
[MEDIUM]   medium risk, may cause unexpected regressions of low importance or
           which may quickly be discovered
[MAJOR]    major risk of hidden regression. This happens when I rearrange large
           parts of code, when I play with timeouts, with variable
           initializations, etc...
[BUG]      fix for a minor or medium-level bug.
[CRITICAL] medium-term reliability or security is at risk, an upgrade is
           absolutely required.
[RELEASE]  release a new version
[BUILD]    fix build issues. If you could build, no upgrade required.
[CLEANUP]  code cleanup, silence of warnings, etc... theorically no impact
[TESTS]    added regression testing configuration files or scripts
[DOC]      documentation updates, no need to upgrade
[LICENSE]  licensing updates (may impact distro packagers)

Example: "[DOC] document options forwardfor to logasap"
-----

Nothing is mandatory, and I (as the maintainer) can still choose to
adjust the prefix if I want. But in fact, I only had to to it when
contributors did not classify their patch themselves. Several other
tags may be added for LKML, such as "RFC" which is already used,
etc...

The advantages of this usage are multiple. Nothing needs to be changed
in the tools, no header needs to be added, it's still very compatible
with the mailing-list usages (and helps focusing on specific patches),
it's absolutely not mandatory and easily tweakable.

I'd like people in this thread not to forget that what we need is not
a fantastic tool to work around some developers' weaknesses, but cheap
(if any) help from the developers to help reviewers. I think that such
a proposal falls exactly in this category.

I'm quite ready to use it already (though I do not post often), and
think that it would still feel natural to many developers since most
of them are already used to such a format. I think it just requires
a few starters to get most of us to progressively use such a scheme
by default.

Regards,
Willy
