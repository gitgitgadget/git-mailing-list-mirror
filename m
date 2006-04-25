From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: [BUG] gitk draws a wrong line
Date: Tue, 25 Apr 2006 09:54:29 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060425075429.GA1532@informatik.uni-freiburg.de>
References: <20060418104014.GA2299@informatik.uni-freiburg.de> <17485.31716.452326.229628@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 09:54:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYINa-0005Qb-Px
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 09:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWDYHyg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 03:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWDYHyg
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 03:54:36 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:40896 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751407AbWDYHyf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 03:54:35 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FYINW-0000zR-59; Tue, 25 Apr 2006 09:54:34 +0200
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.11.7p2+Sun/8.12.11) id k3P7sTr01950;
	Tue, 25 Apr 2006 09:54:29 +0200 (MEST)
To: Paul Mackerras <paulus@samba.org>
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <17485.31716.452326.229628@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19134>

Hello Paul,

Paul Mackerras wrote:
> Uwe Zeisberger writes:
> 
> > and then going to commit 10c2df65060e1ab57b2f75e0749de0ee9b8f4810, 
> > I see a small superfluous line between the two commits under 10c2df.
> > 
> > But still worse, if I select the line going down from 10c2df and then
> > select it's parent (i.e c76b6b) I get a big line ending in the commit
> > descriptions and four lines ending in midair.
> 
> That is an X server bug, it seems.  Tk already clips vertices that it
> sends to the X server to be within a box that is no more than 32000
> pixels wide or high, but that seems not to be enough with some X
> servers.  What X server version are you using and what sort of video
> card?
It's a Debian system with XFree 4.3.0.dfsg.1-14 and according to lspci I
have

	0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]

> If you're feeling adventurous, you can rebuild Tk with the patch below
> (courtesy of D. Richard Hipp) and see if that fixes it.  If it does it
> proves that it is an X server bug.
OK, I tried that and it helped. 

I list my steps for people who want to "fix" it, too:

	Note: You need a deb-src line in your sources.list.  Moreover
	some packages are assumed to be installed (e.g. devscripts,
	fakeroot, vim :-))

	~$ mkdir src; cd src
	~/src$ apt-get build-dep tk8.4
	~/src$ apt-get source tk8.4
	~/src$ cd tk8.4-8.4.12
	~/src/tk8.4-8.4.12$ vim generic/tkCanvUtil.c

	[ apply the patch provided by Paul/D. Richard Hipp ]

	~/src/tk8.4-8.4.12$ dch -n

	[ write a sensible changelog entry ]

	~/src/tk8.4-8.4.12$ fakeroot dpkg-buildpackage
	...

	~/src/tk8.4-8.4.12$ cd ..
	~/src$ sudo dpkg -i tk8.4_8.4.12-1.1_i386.deb

I'm not entirely clear what this patch does.  From only reading it, I
assume it should only have an effect on rather big windows, right?

Do you know some more details about the bug?  Do you know to who it
should get reported?

Thanks for your help
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=gravity+on+earth%3D
