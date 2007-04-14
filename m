From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] create_directories: simplify and avoid repeated copying
Date: Sat, 14 Apr 2007 07:11:14 -0700
Message-ID: <7vlkgv9hbx.fsf@assigned-by-dhcp.cox.net>
References: <20070414013003.B0B4C2F1DC3@geert-boschs-computer.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Geert Bosch <bosch@gnat.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 16:11:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HciyK-0005s4-6g
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 16:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030524AbXDNOLP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 10:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030584AbXDNOLP
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 10:11:15 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:57856 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030524AbXDNOLP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 10:11:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070414141114.NBZD1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 14 Apr 2007 10:11:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id n2BE1W00A1kojtg0000000; Sat, 14 Apr 2007 10:11:14 -0400
In-Reply-To: <20070414013003.B0B4C2F1DC3@geert-boschs-computer.local> (Geert
	Bosch's message of "Thu, 12 Apr 2007 16:29:10 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44459>

Geert Bosch <bosch@gnat.com> writes:

> Signed-off-by: Geert Bosch <bosch@gnat.com>
> ---
> I needed to change the logic of this function a bit for
> doing some local hacks^Wmodifications and thought it might
> be a slight improvement/simplification.
> No change in functionality and passed 'make test'.

I like the removal of repeated copying, but I wonder if the
denser condition is really easier to read.

I tried to like it, but I needed to reindent it first, and then
I needed to read it three times to convince myself that they are
equivalent.

        if (errno != EEXIST
            || ((!force || unlink(buf) || mkdir(buf, 0777))
                && (stat(buf, &st) || !S_ISDIR(st.st_mode))) )
                die("cannot create directory at %s", buf);

In the end, I managed to convince myself that this denser
version is doing the same thing as the original, and it is nicer
to see it in only three lines, I am not sure if it is easier to
read anymore, judging from the time it took me to reach that
conclusion...
