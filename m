From: David Kastrup <dak@gnu.org>
Subject: Re: git rebase -i error message interprets \t in commit message
Date: Tue, 06 Aug 2013 21:23:41 +0200
Message-ID: <87bo5a62te.fsf@fencepost.gnu.org>
References: <87k3jy6cyc.fsf@fencepost.gnu.org> <vpqli4ekdni.fsf@anie.imag.fr>
	<87fvum694z.fsf@fencepost.gnu.org> <vpqd2pqka9e.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 06 21:23:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6mrD-0003jB-Uz
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 21:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602Ab3HFTXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 15:23:44 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:54855 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254Ab3HFTXn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 15:23:43 -0400
Received: from localhost ([127.0.0.1]:53898 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1V6mr8-0007E9-6t; Tue, 06 Aug 2013 15:23:42 -0400
Received: by lola (Postfix, from userid 1000)
	id BAC90EAC27; Tue,  6 Aug 2013 21:23:41 +0200 (CEST)
In-Reply-To: <vpqd2pqka9e.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	06 Aug 2013 19:19:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231781>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>>From 7962ac8d8f2cbc556f669fd97487f9d70edc4ea1 Mon Sep 17 00:00:00 2001
> From: Matthieu Moy <Matthieu.Moy@imag.fr>
> Date: Tue, 6 Aug 2013 19:13:03 +0200
> Subject: [PATCH] die_with_status: use "printf '%s\n'", not "echo"
>
> At least GNU echo interprets backslashes in its arguments.

I think that's incorrect in several respects.  For one thing, echo is
never called for most Bourne shells since echo is a builtin (might have
been different for UNIX version 7 or so).  For another, GNU echo would
behave like Bash:

And GNU Bash does not interpret escapes unless you do echo -e.  Escape
sequence interpretation, however, happens for Dash:

dak@lola:/usr/local/tmp/lilypond$ dash -c 'echo "x\tx"'
x	x
dak@lola:/usr/local/tmp/lilypond$ bash -c 'echo "x\tx"'
x\tx
dak@lola:/usr/local/tmp/lilypond$ /bin/echo "x\tx"
x\tx

So replace "GNU echo" in your commit message with "Dash's echo builtin"
and you get closer.

-- 
David Kastrup
