From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: Re: Error.pm: add configuration variable in Makefile
Date: Sat, 17 Feb 2007 14:38:58 +0000 (UTC)
Message-ID: <loom.20070217T152508-6@post.gmane.org>
References: <200702162200.15241.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 17 15:45:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIQoP-0003cm-Pn
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 15:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946765AbXBQOpO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 09:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946762AbXBQOpO
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 09:45:14 -0500
Received: from main.gmane.org ([80.91.229.2]:55490 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946765AbXBQOpM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 09:45:12 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HIQoB-0000QG-Na
	for git@vger.kernel.org; Sat, 17 Feb 2007 15:45:04 +0100
Received: from mars-fw.arces.unibo.it ([137.204.143.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Feb 2007 15:45:03 +0100
Received: from scallegari by mars-fw.arces.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Feb 2007 15:45:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.143.2 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.1) Gecko/20060601 Firefox/2.0.0.1 (Ubuntu-edgy))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39990>

Michael <barra_cuda <at> katamail.com> writes:

> 
> When compiling, we check in perl/Makefile.PL if Error.pm is available. If not, 
> we use our Error.pm instead. So, after a "make install" the system does have 
> an Error.pm. This is fine, unless we are used to create an 
> rpm/deb/whatever-it-is by ourselves and install it with the system's package 
> manager: in this case, in fact, the git package we are building will have an 
> Error.pm only if the package currently installed does not. Of course, once we 
> install the new package, the next one won't ship Error.pm because 
> perl/Makefile.PL thinks it doesn't need to; but that's obviously wrong, since 
> the package manager will delete the old Error.pm when installing the new git 
> package.
> 
> 

Apart from those making rpm/deb/whatever, I see another scenario where the
current selection logic for systemwide Error.pm and private Error.pm may fail.
This is if one uses GNU Stow for managing software that is not managed by the
distro packaging system... whatever.

A typical upgrade flow would be:

You have Git version X installed in /usr/local/stow/Git-X and stowed.
You now compile version X+1 of git, with prefix /usr/local/stow/Git-X+1
(here the current Error.pm logic thinks that there is no need for the private  
 Error.pm since it finds an Error.pm -- only it is the Error.pm from the Git-X
stowing)
You install Git version X+1 in /usr/local/stow/Git-X+1
You unstow Git version X
You stow Git version X+1
Git version X+1 fails because of missing Error.pm

I.e. identical problem as with a true package manager.
Problem is that the "private" Error.pm is put in a "public" location and not
kept private with the current installation of Git.
  
