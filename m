From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What about allowing multiple hooks?
Date: Wed, 21 Jan 2009 22:10:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901212206430.3586@pacific.mpi-cbg.de>
References: <20081121133828.GB5912@gmx.de> <20090103233252.GA12095@myhost> <7vd4f3z8xu.fsf@gitster.siamese.dyndns.org> <4977872E.70901@0x63.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Alexander Potashev <aspotashev@gmail.com>,
	Marc Weber <marco-oweber@gmx.de>,
	Rogan Dawes <lists@dawes.za.net>,
	martin f krafft <madduck@madduck.net>
To: Anders Waldenborg <anders@0x63.nu>
X-From: git-owner@vger.kernel.org Wed Jan 21 22:13:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPkMz-00076d-1S
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 22:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbZAUVKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 16:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754027AbZAUVKr
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 16:10:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:33618 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753961AbZAUVKp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 16:10:45 -0500
Received: (qmail invoked by alias); 21 Jan 2009 21:10:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 21 Jan 2009 22:10:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UjVosjnFU4V7IExeA3WsEFi3Pyxm4eVL0eGBpLo
	sWoSoyBIAJDl/6
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4977872E.70901@0x63.nu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106672>

Hi,

On Wed, 21 Jan 2009, Anders Waldenborg wrote:

> I need multiple hooks, so I've done some thinking about this, so I 
> thought it may be a good idea to share this here.
> 
> I currently use configvalues to specify which hooks to run. For example 
> this is how my post-receive looks:
> 
> data=$(cat)
> git config --get-all hooks.post-receive.hook | while read hook; do
>         $hook <<__EOF__
> "$data"
> __EOF__
> done

I wonder why you don't do the obvious thing:

	data=$(cat)
	for hook in .git/hooks/update.d/*
	do
		test -x "$hook" || continue
		echo "$data" | "$hook" | exit
	done

and then name the hooks in your .git/hooks/update.d/ with leading 
zero-padded numbers so that you guarantee a certain order.

You can even share special hooks between repositories by symlinking, as is 
done in /etc/init.d/rc?.d.

Hth,
Dscho

P.S.: If you want to save even more interactive work, you can name the 
hooks .git/hooks/update.[0-9]*.
