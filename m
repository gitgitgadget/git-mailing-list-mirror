From: Junio C Hamano <gitster@pobox.com>
Subject: Re: (resend) [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Sun, 24 Jun 2007 02:01:59 -0700
Message-ID: <7vzm2pwws8.fsf@assigned-by-dhcp.cox.net>
References: <87abuq1z6f.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@linux-foundation.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sun Jun 24 11:02:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Nz6-0002dt-Gl
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 11:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbXFXJCE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 05:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752933AbXFXJCD
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 05:02:03 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:49754 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbXFXJCB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 05:02:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070624090200.HDKB3339.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 24 Jun 2007 05:02:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FM1z1X00C1kojtg0000000; Sun, 24 Jun 2007 05:02:00 -0400
In-Reply-To: <87abuq1z6f.fsf@rho.meyering.net> (Jim Meyering's message of
	"Sat, 23 Jun 2007 17:13:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50780>

Jim Meyering <jim@meyering.net> writes:

> From: Jim Meyering <jim@meyering.net>
> Date: Sat, 26 May 2007 13:43:07 +0200
> Subject: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
>
> Currently, when git-diff writes to a full device or gets an I/O error,
> it fails to detect the write error:
> ...
> Also, to be consistent with e.g., write_or_die, do not
> diagnose EPIPE write failures.

I still do not like the fact that this patch makes an error from
the final stdout flushing override the return value from p->fn()
even when the function already diagnosed an error, but otherwise
I think it is a good change, as it allows us to catch one error
case that we currently don't, without introducing an annoying
EPIPE diagnosis.

Naks, or vetoes?
