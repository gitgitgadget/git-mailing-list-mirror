From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Thu, 17 May 2007 13:02:25 +0200
Message-ID: <20070517110225.GA3334@steel.home>
References: <11793556363795-git-send-email-junkio@cox.net> <11793556371774-git-send-email-junkio@cox.net> <200705170539.11402.andyparkins@gmail.com> <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 17 13:02:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hodku-0002gE-VX
	for gcvg-git@gmane.org; Thu, 17 May 2007 13:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbXEQLC3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 07:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754380AbXEQLC3
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 07:02:29 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:55337 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775AbXEQLC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 07:02:28 -0400
Received: from tigra.home (Fcb4a.f.strato-dslnet.de [195.4.203.74])
	by post.webmailer.de (mrclete mo57) (RZmta 6.3)
	with ESMTP id I06b5fj4H8Q9Eu ; Thu, 17 May 2007 13:02:26 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 52402277BD;
	Thu, 17 May 2007 13:02:25 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1DA7AD195; Thu, 17 May 2007 13:02:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqB09/A==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47510>

Junio C Hamano, Thu, May 17, 2007 07:21:40 +0200:
> What I was "handwaving" (or "envisioning") was to have something
> like this in .gitmodules:
> 
> 	[subproject "kernel/"]
>         	URL = git://git.kernel.org/pub/linux-2.4.git

So, assuming .gitmodules is versioned (afaics, it is), it would mean
that after a some unlucky git-pull, where someone changed the upstream
.gitmodules ("linux-2.4" for whatever reason is changed to just
"linux"). And suddenly all such local configuration is useless:

> (or 2.6, depending on the revision of the superproject) and per
> repository configuration would maps this with these two entries:
> 
> 	[subproject "git://git.kernel.org/pub/linux-2.4.git"]
>         	URL = http://www.kernel.org/pub/linux-2.4.git
>
> 	[subproject "git://git.kernel.org/pub/linux-2.6.git"]

isn't there a typo somewhere around "2.6"?

>         	URL = http://www.kernel.org/pub/linux-2.6.git

because there is no URL to map from.

why can't I just have _repo_ configuration:

 	[subproject "kernel/"]
         	URL = http://www.kernel.org/pub/linux-2.6.git
?
It can be first-time cloned from the upstream, but it stays after
people change it to suit their systems. They can depend on it not to
be broken by upstream.

> The intent is 
> 
> 	(1) "kernel/" directory is found to be a gitlink in the
>             tree/index; .gitmodules is consulted to find the
>             "URL", which is just a handle and the initial hint
> 
> 	(2) That "initial hint" is used to look up the
>             subproject entry from the configuration, to find the
>             "real" URL that is used by this repository

It is quite long-living to be just initial hint. And will be redundant
after the hint loses all meaning (after some time it _will_ happen,
sites do move around), and is just a strange looking mapping key.

Can I suggest a part of repo configuration to be clonable? So that
there is a something in .git/config.dist, which is _cloned_ with
git-clone. The obviuos thing to put there would be subproject
configuration, and maybe there will be something else in the future
(I'd think of description, which is a separate file now, and as for
now, the only way to get this description is to use gitweb or ssh).
git-ls-remote could be made to show this "remote-accessible"
configuration, in case someone have to update/compare local copy of
this config.
