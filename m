From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-archive: document CWD effect
Date: Tue, 10 Apr 2007 14:49:28 -0700
Message-ID: <7v8xczvr13.fsf@assigned-by-dhcp.cox.net>
References: <esc64d$d2u$1@sea.gmane.org>
	<7virc68nc1.fsf@assigned-by-dhcp.cox.net>
	<461A55FB.6070600@lsrfire.ath.cx>
	<200704092137.22781.andyparkins@gmail.com>
	<461B9E22.5020102@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Nick Williams <njw@jarb.freeserve.co.uk>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Apr 11 07:00:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbODX-0008Mb-P3
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 23:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbXDJVtc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 Apr 2007 17:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753575AbXDJVtb
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 17:49:31 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62549 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbXDJVta convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2007 17:49:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070410214929.LCQJ1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Apr 2007 17:49:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lZpV1W0051kojtg0000000; Tue, 10 Apr 2007 17:49:29 -0400
In-Reply-To: <461B9E22.5020102@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of
	"Tue, 10 Apr 2007 16:24:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44181>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> But just because there is currently no way (that I know of) to change
> the working directory on the remote end that doesn't mean the command
> needs to ignore the working directory when operating locally, where i=
t
> can be changed easily.

I do not think it has much to do with "working directory".  The
remote one would most often be bare, and especially the public
ones are so.  I think the issue is if I ask a tarball of this
commit without giving any specific parameters, what should
happen.

And I think most people find it natural if you give them the
whole tree no matter where they start from.

You could:

        $ git archive HEAD -- t/howto

to have a narrowed tarball, and even if you make:

	$ cd t/howto
	$ git archive HEAD

to produce the whole tree, the user can still do:

	$ cd t/howto
        $ git archive HEAD -- .

to get the narrowed tree if the command understands the prefix
it receives from git_setup_directory().

So while I understand when you say this is "another input
method", letting people in a deep directory to abbreviate their
cwd with "." would equally a good input method, and probably
better than the current implementation, which leaves people
without a single way to say "I want the whole tree" without
cd'ing up.
