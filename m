From: Pavel Roskin <proski@gnu.org>
Subject: Re: Default remote branch for local branch
Date: Fri, 31 Mar 2006 23:18:43 -0500
Message-ID: <1143865123.14465.26.camel@dv>
References: <1143856098.3555.48.camel@dv>
	 <7vodzmngfp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 01 06:19:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPXZs-0004U3-AU
	for gcvg-git@gmane.org; Sat, 01 Apr 2006 06:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWDAESs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 23:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWDAESs
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 23:18:48 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:54186 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750801AbWDAESs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 23:18:48 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FPXZW-0004qB-Eq
	for git@vger.kernel.org; Fri, 31 Mar 2006 23:18:46 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1FPXZU-0003sU-43; Fri, 31 Mar 2006 23:18:44 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodzmngfp.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18244>

Hello, Junio!

On Fri, 2006-03-31 at 19:05 -0800, Junio C Hamano wrote:
>  - Multiple subsystem maintainer trees tracked in the same local
>    repository.  Most generally, two local branches per each
>    remote head can be used (one tracking branch to fetch into,
>    another to build your changes based on it).  Alternatively,
>    you can use one local branch per each remote head without
>    using any tracking branch.
> 
> Your proposal to give default branch to pull from per the local
> branch would help only the last case.

Exactly.  I tried to track the main Linus repository and Jeff Garzik's
netdev in one place.  Then I discovered that my repository if full of
unintended merges made by "stg pull".

> The first one you do not
> switch between local branches at all and pull from many
> different places; the second is to merge from different topic
> branches from time to time and does not benefit from fixed
> configuration; the third does not even need configuration.
> 
> Maybe you would want something like this.
>
> In $GIT_DIR/config:
> 
> 	[pull]
> 	origin = linus for master
>         origin = irq-pio of libata for ata-irq-pio
>         origin = pata-drivers of libata for ata-pata

First of all, using "origin" on every line carries to little
information.

Secondly, I think the relationship should be between a local development
branch and a local tracking branch.  After all, all remote data is
placed on a local tracking branch first.  It's better not to jump over
layers of abstraction.  Suppose I want to update "masterB".  I tell git
to sync "originB" first.  git already has rules what to do if it should
sync "originB".  Let's not supersede those rules.

I would write the config like this:

[branch-upstream]
master = linus
ata-irq-pio = irq-pio
ata-pata = pata-drivers

> While we are on the topic, it _might_ be worthwhile to think
> about revamping the syntax of $GIT_DIR/remotes file, maybe even
> breaking backward compatibility.  The Pull: lines can be
> independently specified which gives flexibility, but I suspect
> local tracking branches from the same remote tend to live in the
> same place; IOW, you would probably not do something like:
> 
> 	URL: git://git.kernel.org/.../jgarzik/libata-dev.git
> 	Pull: refs/heads/irq-pio:refs/remotes/libata/irq-pio
> 	Pull: refs/heads/pata-drivers:refs/heads/pata-drivers
> 
> in practice.

Sorry, I don't understand this part.

-- 
Regards,
Pavel Roskin
