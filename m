From: Zygo Blaxell <zblaxell@esightcorp.com>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Sun, 14 Feb 2010 18:52:19 -0500
Message-ID: <20100214235219.GE24809@gibbs.hungrycats.org>
References: <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com> <20100213223733.GP24809@gibbs.hungrycats.org> <20100214011812.GA2175@dpotapov.dyndns.org> <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de> <20100214024259.GB9704@dpotapov.dyndns.org> <alpine.DEB.1.00.1002141908150.20986@pacific.mpi-cbg.de> <37fcd2781002141106v761ce6e0kc5c5bdd5001f72a9@mail.gmail.com> <alpine.DEB.1.00.1002142021100.20986@pacific.mpi-cbg.de> <alpine.DEB.1.00.1002142025160.20986@pacific.mpi-cbg.de> <37fcd2781002141156n7e2b9673s1eb6c12869facdb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 00:52:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgoGK-0007CW-QX
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 00:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626Ab0BNXwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 18:52:21 -0500
Received: from ip-70-38-54-39.static.privatedns.com ([70.38.54.39]:47179 "EHLO
	ginevra.hungrycats.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752765Ab0BNXwU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 18:52:20 -0500
X-Envelope-Mail-From: zblaxell@esightcorp.com
X-Envelope-Mail-From: zblaxell@esightcorp.com
X-Envelope-Mail-From: zblaxell@esightcorp.com
X-Envelope-Mail-From: zblaxell@esightcorp.com
X-Envelope-Mail-From: zblaxell@esightcorp.com
X-Envelope-Mail-From: zblaxell@esightcorp.com
Received: from gibbs.hungrycats.org (gibbs.vpn7.hungrycats.org [10.132.226.42])
	by ginevra.hungrycats.org (Postfix) with ESMTP id 9130A8018;
	Sun, 14 Feb 2010 18:52:19 -0500 (EST)
Received: from zblaxell by gibbs.hungrycats.org with local (Exim 4.69)
	(envelope-from <zblaxell@esightcorp.com>)
	id 1NgoGB-0007XK-EV; Sun, 14 Feb 2010 18:52:19 -0500
Content-Disposition: inline
In-Reply-To: <37fcd2781002141156n7e2b9673s1eb6c12869facdb2@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139950>

On Sun, Feb 14, 2010 at 10:56:46PM +0300, Dmitry Potapov wrote:
> It may not work without enough swap space, and it will not pretty anyway
> due to swapping. So, I see the following options:
> 
> 1. to introduce a configuration parameter that will define whether to use
> mmap() to hash files or not. It is a trivial change, but the real question
> is what default value for this option (should we do some heuristic based
> on filesize vs available memory?)

I'm a fan of having the option.  It lets users who know what they're
doing (and who might be doing something unusual, like files that are
large relative to memory size, or files that are being modified during
git add) decide how to make the performance-robustness trade-off.

"Large" is relative.  How common is it to add files to git that are
large relative to the RAM size of the machine?  I have a machine with 6GB
of RAM and a repo on that machine with half a dozen 0.5-1.5GB files in it.
Git add is painfully slow on that repo even with mmap().  I wouldn't dare
trying to manipulate that repo on a machine with less than 1GB of RAM.
