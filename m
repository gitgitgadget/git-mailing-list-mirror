From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: use git-log rather than rev-list | xargs cat-file
Date: Mon, 11 Jun 2007 23:17:53 -0700
Message-ID: <20070612061753.GA4080@muzzle>
References: <20070610091259.48F8D13A4F8@magnus.utsl.gen.nz> <20070610212459.GA12222@muzzle> <7vhcpfrlk1.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 08:18:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxzhY-0005y2-MI
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 08:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbXFLGRz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 02:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755931AbXFLGRz
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 02:17:55 -0400
Received: from hand.yhbt.net ([66.150.188.102]:37074 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753447AbXFLGRz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 02:17:55 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 4A10C7DC09D;
	Mon, 11 Jun 2007 23:17:53 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 11 Jun 2007 23:17:53 -0700
Content-Disposition: inline
In-Reply-To: <7vhcpfrlk1.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49925>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Sam Vilain <sam@vilain.net> wrote:
> >> This saves a bit of time when rebuilding the git-svn index.
> >
> > Does git-log still have the 16k buffer limit?  If so then we can't use
> > it because commit messages over 16k will be truncated and the git-svn-id
> > line will not show up.  Also, if that limit is removed I'd prefer to
> > just add --pretty=raw to rev-list because git-log is stil porcelain and
> > more likely to change.
> 
> How about this?  It passes the test suite, but other than that
> hasn't seen much test yet.  I tried to be careful, but sanity
> checking by extra sets of eyeballs would be needed.

The patch looks and runs alright to me, but then again I haven't looked
at the C portions of git in a while :x

I expected the malloc/free overhead to be much greater, but it's hardly
noticeable (nor measureable with /usr/bin/time or bash built-in time).
There are just a handful more pagefaults measured with /usr/bin/time,
but the runtime performance is neck-and-neck with/without the patch.

Maybe glibc (2.3.6 on x86 Debian Etch) and Linux (2.6.18) are just doing
a very good job with memory allocation... I wonder how well it runs on
other platforms.

-- 
Eric Wong
