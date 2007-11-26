From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use is_absolute_path() in diff-lib.c, lockfile.c, setup.c, trace.c
Date: Sun, 25 Nov 2007 19:54:48 -0800
Message-ID: <7vy7clhd9z.fsf@gitster.siamese.dyndns.org>
References: <11960297431954-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Nov 26 04:55:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwV43-0001GO-Sb
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 04:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898AbXKZDy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 22:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755409AbXKZDy4
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 22:54:56 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:53959 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355AbXKZDyz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 22:54:55 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 15DE12EF;
	Sun, 25 Nov 2007 22:55:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A080599DE8;
	Sun, 25 Nov 2007 22:55:13 -0500 (EST)
In-Reply-To: <11960297431954-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Sun, 25 Nov 2007 23:29:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66038>

Steffen Prohaska <prohaska@zib.de> writes:

> Using the helper function to test for absolute paths makes porting easier.

These probably make sense.  I obviously do not see any downside from the
POSIX side, and can imagine that treating "C:\" prefix as "absolute
paths" at these four places will not have any ill effect on the Windows
side (IOW, the codepaths that follow these four places seem to do a
sensible thing even if the "absolute path" prefix is not a single '/',
but would work fine as-is).

I am a bit surprised that there are only four places you needed to
touch, though.

> BTW, what happend to the msysgit related patches:
>
> [PATCH 1/3] sha1_file.c: Fix size_t related printf format warnings
> [PATCH 2/3] builtin-init-db: use get_git_dir() instead of getenv()
>
> I never received comments about them, nor do I find them on pu.

Lack of comments was probably due to mixture of bad timing and general
lack of interests.  Many people are busy working on their turkeys than
hacking this time of the year ;-)

I am reluctant to queue msysgit/gitwin related patches without seeing
positive comments from other people involved on the Windows side, unless
they are trivial and obvious improvements.

 * [1/3] seems without harm but on the other hand does not seem so
   urgent either.

 * [2/3] may introduce chicken-and-egg problem (use of get_git_dir()
   inside git-init feels quite iffy, as it calls setup_git_env(), which
   does repository discovery), without an obvious and clear advantage.

For these reasons, both of them disqualify from being trivial and
obvious improvements, so I did not pick them up unilaterally before
seeing positive comments from other people.
