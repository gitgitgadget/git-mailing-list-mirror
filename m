From: Greg KH <greg@kroah.com>
Subject: Re: git clone stable-2.6.25.y fails over HTTP
Date: Fri, 6 Jun 2008 13:48:14 -0700
Message-ID: <20080606204814.GE11209@kroah.com>
References: <200806041511.m54FBPL9006783@pogo.cesa.opbu.xerox.com> <20080604154523.GA25747@kroah.com> <7vr6bdxh3l.fsf@gitster.siamese.dyndns.org> <20080605040315.GA21798@kroah.com> <7vabi05xl1.fsf@gitster.siamese.dyndns.org> <20080605050855.GA22825@kroah.com> <alpine.LNX.1.00.0806051546480.19665@iabervon.org> <7vzlpzzi8c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Andrew Klossner <andrew@cesa.opbu.xerox.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 22:54:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4ixP-0003xk-Nv
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 22:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932783AbYFFUxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 16:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbYFFUxh
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 16:53:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47835 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932739AbYFFUxf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 16:53:35 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1K4ivw-0003LL-U5; Fri, 06 Jun 2008 20:53:13 +0000
Content-Disposition: inline
In-Reply-To: <7vzlpzzi8c.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84113>

On Thu, Jun 05, 2008 at 02:26:11PM -0700, Junio C Hamano wrote:
> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Wed, 4 Jun 2008, Greg KH wrote:
> > ...
> >> I can duplicate what I did, and it did it again:
> >> 	on master.kernel.org:
> >> 	$ cd /pub/scm/linux/kernel/git/stable/
> >> 	$ git clone -s --bare ../torvalds/linux-2.6.git/ test
> >> 	$ cat test/objects/info/alternates
> >> 	/home/ftp/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects
> >> 
> >> I'm guessing this is because /pub/ is a symlink:
> >> 	$ ls -l /pub
> >> 	lrwxrwxrwx 1 root root 13 Feb  4  2006 /pub -> /home/ftp/pub
> >
> > We're using getcwd() to make the absolute path, but it looks like we 
> > should check whether $PWD is set and names the same directory, and, if so, 
> > base on that instead.
> >
> > Actually, make_absolute_path() seems to go to an awful lot of trouble to 
> > make sure that there aren't symlinks in the resulting path. Is this 
> > actually necessary or even desireable for some reason? Should clone be 
> > just pasting $PWD (or, failing that, getcwd()) and the given path, and 
> > using that to identify the repo to clone?
> 
> I am not 100% sympathetic if ../torvalds/linux-2.6.git/ was what caused
> this.  Perhaps 30% or so ;-).

I agree, if I did something stupid like this, that's my fault.  I didn't
realize that it was stupid, so I guess a simple warning, "don't use
relative paths when cloning with alternates" would have told me so.

> However, I think /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ would
> result in the same breakage, and that is something I consider gravely
> broken.

Yeah, especially as I never realized that /pub/ was a symlink in the
first place :)

thanks,

greg k-h
