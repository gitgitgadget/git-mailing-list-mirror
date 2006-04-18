From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: GIT_OBJECT_DIRECTORY
Date: Tue, 18 Apr 2006 20:45:08 +0200
Message-ID: <20060418184508.GC25688@wohnheim.fh-wedel.de>
References: <20060418133847.GC4720@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0604180822470.3701@g5.osdl.org> <20060418175853.GA25688@wohnheim.fh-wedel.de> <7vfykag2yd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 20:45:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVvCh-0006ZB-0m
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 20:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWDRSpc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 18 Apr 2006 14:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWDRSpc
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 14:45:32 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:46284 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932271AbWDRSpb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 14:45:31 -0400
Received: from joern by wohnheim.fh-wedel.de with local (Exim 3.36 #1 (Debian))
	id 1FVvCG-0001w0-00; Tue, 18 Apr 2006 20:45:08 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfykag2yd.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18870>

On Tue, 18 April 2006 11:20:58 -0700, Junio C Hamano wrote:
> J=F6rn Engel <joern@wohnheim.fh-wedel.de> writes:
>=20
> > Well, .git/objects for your kernel still consumes 121M.  It's not
> > gigabytes but I still wouldn't want too many copies of that lying
> > around.
>=20
> That is what "git clone -l -s" is for. =20

See my response to Linus.  .git/objects is currently the smaller
problem.  The larger problem is 311M of raw kernel source - without
any SCM overhead of any flavour.  Like many others, I solved the
larger problem with hardlink trees.  "git clone -l -s" is imo nearly
unethical, as it solved the smaller problem and leaves the larger one
unaffected.  It reeks of hypocricy.

Hardlink trees still aren't perfect.  If I take one tree, "cp -lr" it
twice and apply the same patches to both copies, the changed files
exist twice for both copies.  That sucks, but it is a fairly small
problem and there is no simple solution to it.

If git was able to deal with hardlink trees and properly break the
links when working in one copy, "cp -lr" would be a lot smarter than
"git clone -l -s".  It just happens that I have written some kernel
patches that automatically break hardlinks, even if applications don't
know how to do it.  So for my personal use, git has this ability.

Now, going one step further, GIT_OBJECT_DIRECTORY could solve another
problem.  Just like source files, git object can be pulled twice into
two copies of a tree.  But for git objects, there appeared to be an
easy solution: the central object storage.  So we're back where this
thread started.

Except that I get the idea of GIT_OBJECT_DIRECTORY not being a simple
solution to a small problem, so maybe I should just forget about it.

J=F6rn

--=20
To my face you have the audacity to advise me to become a thief - the w=
orst
kind of thief that is conceivable, a thief of spiritual things, a thief=
 of
ideas! It is insufferable, intolerable!
-- M. Binet in Scarabouche
