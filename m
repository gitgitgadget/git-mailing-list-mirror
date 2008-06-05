From: Greg KH <greg@kroah.com>
Subject: Re: git clone stable-2.6.25.y fails over HTTP
Date: Wed, 4 Jun 2008 22:08:55 -0700
Message-ID: <20080605050855.GA22825@kroah.com>
References: <200806041511.m54FBPL9006783@pogo.cesa.opbu.xerox.com> <20080604154523.GA25747@kroah.com> <7vr6bdxh3l.fsf@gitster.siamese.dyndns.org> <20080605040315.GA21798@kroah.com> <7vabi05xl1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Klossner <andrew@cesa.opbu.xerox.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 07:18:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K47rV-0003hC-5C
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 07:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbYFEFRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 01:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbYFEFRB
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 01:17:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54160 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbYFEFRA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 01:17:00 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1K47q5-0006sA-5d; Thu, 05 Jun 2008 05:16:49 +0000
Content-Disposition: inline
In-Reply-To: <7vabi05xl1.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83860>

On Wed, Jun 04, 2008 at 09:12:42PM -0700, Junio C Hamano wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > On Wed, Jun 04, 2008 at 10:09:02AM -0700, Junio C Hamano wrote:
> >
> >> A quick fix is obviously to remove the extra prefix but it makes me wonder
> >> how these two "stable" repositories were prepared differently.  Could this
> >> be a regression in "git clone"?  Or perhaps you "clone -s"'s Linus's
> >> repository slightly differently between them?
> >
> > That's odd.
> >
> > Chris was the one that created the .24 tree and I created the .25 tree,
> > so we must have done so differently, sorry.
> 
> No need to be sorry.  Thanks for raising the issue up.
> 
> I think I have one possible explanation.  When "git clone" was rewritten
> in C some time ago, it started to dereference symlinks, and newer git
> would dereference /pub -> /home/ftp/pub when you do:
> 
> 	git clone -s --bare /pub/scm/linux/kernel/git/torvalds/linux-2.6/ linux-2.6.2x.y
> 
> while the scripted version used to keep /pub/scm path.
> 
> A bit further digging is necessary to make sure if we can fix this easily,
> but I suspect this is worth fixing.

I can duplicate what I did, and it did it again:
	on master.kernel.org:
	$ cd /pub/scm/linux/kernel/git/stable/
	$ git clone -s --bare ../torvalds/linux-2.6.git/ test
	$ cat test/objects/info/alternates
	/home/ftp/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects

I'm guessing this is because /pub/ is a symlink:
	$ ls -l /pub
	lrwxrwxrwx 1 root root 13 Feb  4  2006 /pub -> /home/ftp/pub

	$ git --version
	git version 1.5.5.3

thanks,

greg k-h
