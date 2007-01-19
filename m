From: Junio C Hamano <junkio@cox.net>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Fri, 19 Jan 2007 00:32:38 -0800
Message-ID: <7vfya7ju1l.fsf@assigned-by-dhcp.cox.net>
References: <87r6trsu7n.wl@mail2.atmark-techno.com>
	<7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>
	<200701190727.26505.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 09:32:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7pAx-0002Tp-KC
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 09:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbXASIck (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 03:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbXASIck
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 03:32:40 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:36066 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964939AbXASIcj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 03:32:39 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119083239.DEQX26900.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 19 Jan 2007 03:32:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id CwXk1W00B1kojtg0000000; Fri, 19 Jan 2007 03:31:44 -0500
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200701190727.26505.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 19 Jan 2007 07:27:24 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37163>

Andy Parkins <andyparkins@gmail.com> writes:

> On Friday 2007, January 19 06:47, Junio C Hamano wrote:
>
>> +	mode = share ? 0777 : 0333;
>
> So if the repository is shared we're allowed to shoot ourselves in the foot?

Have you actually read the code to see what 'share' variable
means there?  It is only false when creating the toplevel .git
directory and always true for its subdirectories.

> Also; what does this do to .git/config .git/description?

Nothing unusual.  The code explicitly asks for .git/config by
name, so that does not involve readdir(".git"), which is what
the 0333 change prevents from running.

> On ocassion I've found myself doing
>   mv .git/refs/remotes/origin .git/refs/remotes/up
>
> Which this patch would break.

Does it?

And everybody commented on this thread,

	EASY.

You all should not take "amusing" too seriously.  That was a
tongue-in-cheek patch.

I am very inclined to say

	$ cd .git && git clean

or

	$ cd .git/objects && git clean        

falls into the same category as

	$ su
	# cd / && git-init-db && git clean

In other words, I am not sure if there is anything worth fixing.
