From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: Overriding ~/.gitconfig using GIT_CONFIG
Date: Fri, 12 Aug 2011 21:44:13 +0100
Message-ID: <1313181853.14274.535.camel@rex>
References: <1313163498.14274.505.camel@rex>
	 <7vr54qmodf.fsf@alter.siamese.dyndns.org>
	 <7vmxfemnc4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 22:45:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrybX-0006qR-53
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 22:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718Ab1HLUpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 16:45:13 -0400
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:57995 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319Ab1HLUpM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 16:45:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7CKj3S2015372;
	Fri, 12 Aug 2011 21:45:03 +0100
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 13776-08; Fri, 12 Aug 2011 21:44:58 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7CKitvV015359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Aug 2011 21:44:56 +0100
In-Reply-To: <7vmxfemnc4.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179246>

On Fri, 2011-08-12 at 12:39 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Richard Purdie <rpurdie@rpsys.net> writes:
> >
> >> Looking through the manuals/code, it suggests I should be able to do:
> >>
> >> GIT_CONFIG=/dev/null git XXX
> >>
> >> and all should work happily. It doesn't though. As an example, with a
> >> ~/.gitconfig, "GIT_CONFIG=/dev/null git fetch --all" is clearly
> >> accessing the file in ~ and then acting upon it.
> >
> > If the manual says the above is expected for any value of XXX, then that
> > is a bug in the manual since mid 2008, I think.
> >
> > See dc87183 (Only use GIT_CONFIG in "git config", not other programs,
> > 2008-06-30).
> >
> > I _think_ these days a workaround to force a known config is to set HOME
> > to a value that has a known .gitconfig (or no such file), and decline
> > usage of /etc/git.config by exporting GIT_CONFIG_NOSYSTEM.
> 
> Side note. Here is what dc87183 says:
> 
> commit dc87183189b54441e315d35d48983d80ab085299
> Author: Daniel Barkalow <barkalow@iabervon.org>
> Date:   Mon Jun 30 03:37:47 2008 -0400
> 
>     Only use GIT_CONFIG in "git config", not other programs
>     
>     For everything other than using "git config" to read or write a
>     git-style config file that isn't the current repo's config file,
>     GIT_CONFIG was actively detrimental. Rather than argue over which
>     programs are important enough to have work anyway, just fix all of
>     them at the root.
>     
>     Also removes GIT_LOCAL_CONFIG, which would only be useful for programs
>     that do want to use global git-specific config, but not the repo's own
>     git-specific config, and want to use some other, presumably
>     git-specific config. Despite being documented, I can't find any sign that
>     it was ever used.
>     
>     Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> It clearly explains the reason why LOCAL_CONFIG was removed (the reader
> does not have to agree with "I can't find any sign that it was ever used",
> though), but I cannot read from the first paragraph the reason why it was
> felt necessary not to honor GIT_CONFIG in other programs, i.e. "was
> actively detrimental" is not backed by any example in the paragraph. I can
> sort of sense from "Rather than argue over..." that there may have been a
> discussion on the list, and reading the archive from that timeframe may
> reveal why many felt it was not a good idea.
> 
> Daniel, do you recall the context?

I went digging and this looks like as good a summary as any of the posts
around that time:

http://marc.info/?l=git&m=121476432303314&w=2

It sounds like if you specified GIT_CONFIG when making a clone it would
end up writing the config file specified rather than .git/config.

My problem isn't that I want to specify a specific .gitconfig file, I
just need it to ignore the one in $HOME. I'm happy for the .git/config
file to be used, in fact I need it to be.

I noticed 8f323c00dd3c9b396b01a1aeea74f7dfd061bb7f was committed which
removed GIT_CONFIG_NOGLOBAL support which is the other way to address
the problem. Could we add that back?

I appreciate I can set $HOME to something but that means creating an
empty directory to point at and feels rather like a work around rather
than a solution.

Cheers,

Richard

-- 
Linux Foundation
http://www.yoctoproject.org/
