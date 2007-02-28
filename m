From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Implement core.symlinks to support filesystems without symlinks
Date: Wed, 28 Feb 2007 01:07:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702280101560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11726125012895-git-send-email-johannes.sixt@telecom.at>
 <200702280013.45598.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 01:08:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMCMf-0000WE-DI
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 01:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbXB1AH4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 19:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbXB1AH4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 19:07:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:39028 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932073AbXB1AHz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 19:07:55 -0500
Received: (qmail invoked by alias); 28 Feb 2007 00:07:53 -0000
X-Provags-ID: V01U2FsdGVkX1998TAiTNB9KTmCaXtc4SaFOq2/uGcoHr7yT9IwRq
	BN5g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702280013.45598.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40858>

Hi,

On Wed, 28 Feb 2007, Robin Rosenberg wrote:

> tisdag 27 februari 2007 22:41 skrev Johannes Sixt:
> > 
> > Here is a small patch series that adds a configuration variable 
> > core.symlinks.
> >
> > From the manual:
> > 
> > core.symlinks::
> > 	If false, symbolic links are checked out as small plain files that
> > 	contain the link text. gitlink:git-update-index[1] and
> > 	gitlink:git-add[1] will not change the recorded type to regular
> > 	file. Useful on filesystems like FAT that do not support
> > 	symbolic links. True by default.
> 
> How useful is that? The problem is that those links won't work so the 
> checkout will be broken. Creating copies would be less broken since the 
> "links" could still be used. It should be possible to use the index to 
> see which file is an original and which is a symblink, provided both are 
> in the same repository. Then maybe fall back to this approach if the 
> symlink target cannot be resolved.

Basically, there is no proper way to solve it (other than switching to 
Linux, but that goes without saying).

Your solution would fall short if one of the two files is changed. Since 
they are supposed to be symlinks, the application expects them to be 
identical, and weird sh*t happens.

E.g. if you have a symlink "ln -s Makefile.host Makefile", and a script 
which changes "Makefile.host", and a subdirectory Makefile accessing the 
root Makefile, you will not be happy.

So, any way you go, if you have a repository containing symlinks, and you 
have an OS which does not support symlinks, you are screwed.

But since we already have a symlink in git.git, and _want_ to compile git 
on MinGW nevertheless, we should support symlinks _somehow_. Even if that 
means that advanced usage of symlinks will fail.

I agree with Johannes here how to go about this partial "support" of 
symlinks, since I cannot think of any sane way to retain the information 
(where the symlink points to) in the index.

Ciao,
Dscho
