From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 21:42:51 +0100
Message-ID: <20050417214251.G13233@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <20050417162448.A13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504170926410.7211@ppc970.osdl.org> <20050417195742.D13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171226530.7211@ppc970.osdl.org> <20050417205149.E13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171306360.7211@ppc970.osdl.org> <20050417211116.F13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171324340.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 22:48:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNGgv-0001lf-UG
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 22:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVDQUv0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 16:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVDQUtr
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 16:49:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2572 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261517AbVDQUm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 16:42:57 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DNGbU-0008Sq-F8; Sun, 17 Apr 2005 21:42:52 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DNGbT-0007DZ-AL; Sun, 17 Apr 2005 21:42:51 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0504171324340.7211@ppc970.osdl.org>; from torvalds@osdl.org on Sun, Apr 17, 2005 at 01:26:27PM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 17, 2005 at 01:26:27PM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 17 Apr 2005, Russell King wrote:
> > 
> > It's trivial to change - it's either sort -n or sort -nr !
> 
> Yes.
> 
> Btw, it might make sense to do the "grep" before the sort, since the sort 
> doesn't scale as nicely with lots of output. On the other hand, then the 
> grep pattern needs to be a bit more complex (so that it doesn't pick up on 
> things that have _parents_ with ":1"). I think the rev-tree output is 
> obvious enough that it's pretty trivial to grep for..

sed works as well - in fact, we can use it to both select lines based
upon the :1 _and_ cut out the bulk of the stuff we're not interested in.
So:

rev-tree $to $prev | \
  sort -nr | cut -d' ' -f2 | grep :1 | cut -d: -f1

becomes:

rev-tree $to $prev | \
  sed -n 's,\([[:digit:]]\+\)[[:space:]]\+\([[:xdigit:]]\+\):1.*,\1 \2,p' | \
  sort -nr | cut -d' ' -f2

(appologies to those who don't like regexps 8))

One thing to note about that sed expression though - using \+ is a GNU
extension - do we care about that?  The portable way is to use \{1,\}
but that'd clutter it some more.

-- 
Russell King

