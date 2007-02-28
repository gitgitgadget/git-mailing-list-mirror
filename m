From: Junio C Hamano <junkio@cox.net>
Subject: Re: bug report, error : Unable to find 000000000.....
Date: Wed, 28 Feb 2007 13:34:19 -0800
Message-ID: <7v8xei0xwk.fsf@assigned-by-dhcp.cox.net>
References: <BAY120-W200B9984A9E70409399666AE810@phx.gbl>
	<slrneubrsd.2pm.siprbaum@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeremy Sw <kertejeremy@hotmail.com>,
	James Ketrenos <jketreno@linux.intel.com>
To: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
X-From: git-owner@vger.kernel.org Wed Feb 28 22:34:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMWRZ-0003EA-PZ
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 22:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbXB1Veg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 16:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbXB1Veg
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 16:34:36 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:46628 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbXB1Vef (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 16:34:35 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070228213434.HTKD1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 28 Feb 2007 16:34:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id V9aK1W00g1kojtg0000000; Wed, 28 Feb 2007 16:34:34 -0500
In-Reply-To: <slrneubrsd.2pm.siprbaum@xp.machine.xx> (Peter Baumann's message
	of "Wed, 28 Feb 2007 22:09:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41009>

Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de> writes:

> Jeremy Sw <kertejeremy@hotmail.com> schrieb:
>>
>> By running  # git clone http://intellinuxwireless.org/repos/ipwraw.git
>> git return an error when trying to Get alternates list.
>> the error is :
>> "error: Unable to find 0000000000000000000000000000000000000000 under http://intellinuxwireless.org/repos/ipwraw.git/
>> Cannot obtain needed object 0000000000000000000000000000000000000000"
>> apparently caused by a weird architecture of the tree !
>> there is 4 or 5 diffrents projects, but they have commun files because firmwares are related !
>
> I suggested on IRC to try this (I reproduced the error)
>
> mkdir test && cd test && \
> git-init && \
> git fetch http://intellinuxwireless.org/repos/ipwraw.git master:master
>
> and it works. Ok, fist I thought the error is in another branch, but
>
> git-ls-remote http://intellinuxwireless.org/repos/ipwraw.git
> 7e85b2032a864fcfe489085b768eea4b3a3a9d0b        refs/heads/master
> 7e85b2032a864fcfe489085b768eea4b3a3a9d0b        refs/heads/origin
> 7e85b2032a864fcfe489085b768eea4b3a3a9d0b        refs/tags/ipwraw-0.0.1
> 7e85b2032a864fcfe489085b768eea4b3a3a9d0b        refs/tags/ipwraw-0.0.2
>
> there is no other branch, at least as I could see.

The repository is seriously broken.  If you try wget to see
refs/tags/* files, you will find out that they are not even
tags; they are symrefs and both point at the master branch.

I do not think the Porcelain-ish shipped with git creates symref
in refs/tags/, so it was done by somebody playing with symbolic-ref
by hand perhaps?

I'd suggest James to do delete these bogus refs/tags/* files and
tag the correct commit with "git tag".
