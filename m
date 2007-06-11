From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce light weight commit annotations
Date: Sun, 10 Jun 2007 18:11:03 -0700
Message-ID: <7vsl8z2t3s.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706091854330.4059@racer.site>
	<20070610232016.GB5761@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 03:11:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxYRG-0000Uz-7U
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 03:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763326AbXFKBLN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 21:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763270AbXFKBLI
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 21:11:08 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:46960 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763041AbXFKBLF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 21:11:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070611011105.SMDJ25947.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Jun 2007 21:11:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id A1B41X00B1kojtg0000000; Sun, 10 Jun 2007 21:11:05 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49810>

Alex Riesen <raa.lkml@gmail.com> writes:

> BTW, the annotations are a bit cumbersome to merge, if this
> implementation is to stay (and I personally would like it to) we may
> have to mention this little inconvenience somewhere.
>
> And can I suggest an interface like the below?
>
>     git notes [[--show] <commit>+] [-d|--delete <commit>+] [-e|--edit <commit>]
>
> With the annotations file being completely removed if it is empty.

That is a saner and more extensible interface.

I'll commit a minimally fixed version (essentially, renaming
"annotations" to "notes") of Johannes's and push it out to 'pu'
tonight.

I think it is a mistake to use config in Johannes's patch,
especially without giving a command line override to disable
the call to show_annotations() in a repository that has
config.showannotations variable set, because the script primes
the input with something like this:

	git log -1 $COMMIT | sed -e 's/^/#/' >$MESSAGE
	git cat-file blob $existing_note >>$MESSAGE

and the first "git log" would have already given you the
contents of the existing note ;-).
