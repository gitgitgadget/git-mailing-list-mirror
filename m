From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Per-path attribute based hunk header selection.
Date: Sat, 07 Jul 2007 03:22:09 -0700
Message-ID: <7vabu88qem.fsf@assigned-by-dhcp.cox.net>
References: <7v8x9tdlbv.fsf@assigned-by-dhcp.cox.net>
	<200707071011.l67AB9rg005792@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sat Jul 07 12:22:28 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I77Qm-00052D-Nb
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 12:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbXGGKWM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 7 Jul 2007 06:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbXGGKWM
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 06:22:12 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:51753 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbXGGKWL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jul 2007 06:22:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070707102211.LAKC3098.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Jul 2007 06:22:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LaNA1X0051kojtg0000000; Sat, 07 Jul 2007 06:22:10 -0400
In-Reply-To: <200707071011.l67AB9rg005792@mi0.bluebottle.com>
	(nanako3@bluebottle.com's message of "Sat, 07 Jul 2007 19:08:25
	+0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51812>

=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93  <nanak=
o3@bluebottle.com> writes:

> I would love to see "diff=3Dtex" attribute to work on my manuscripts,=
 but I
> do not write C and do not understand the long length of backslashes v=
ery
> well.  I guessed in the source file a backslash needs to be doubled, =
and
> what I want to match is "\section{", "\subsection{", and "\subsubsect=
ion{"
> at the beginning of lines, and attempted to do it like the patch at t=
he
> end.

Heh, I do not speak TeX very well, so we are even ;-)

> It does not work well, however.  It shows only part of lines.
>
> 	@@ -8,7 +8,8 @@ \section{
> 	@@ -224,7 +225,7 @@ sub
> 	@@ -240,7 +241,7 @@ subsub
>
> I have no idea what am I doing wrong (truthfully, I do not know what =
I am
> doing, period).
>
> diff --git a/diff.c b/diff.c
> index 04e7e91..57f91b0 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1226,6 +1226,8 @@ static const char *diff_hunk_header_regexp(stru=
ct diff_filespec *one)
>  			"^[ 	]*\\(\\([ 	]*"
>  			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
>  			"[ 	]*([^;]*$\\)";
> +	if (!strcmp(ident, "tex"))
> +		return "^\\\\\\(sub\\)*section{";
> =20
>  	return NULL;
>  }

It's getting late so I won't be testing this myself tonight, but
I think

	return "^\\(\\\\\\(sub\\)*section{.*\\)$";

would do the job.

HOWEVER.

Johannes, it strikes me that it is very odd having to add ".*$"
at the end and to surround the whole thing in a parentheses.
Shouldn't the ff_regexp() grabber simply pick the whole line?
After all, that is what GNU "diff -p -F RE" does.

Also this makes me realize that not all contents in the world
are not programming language source files, and "funcname" is
a misnomer.  For this one, however, we _can_ blame GNU diff, as
they call this --show-function-line option ;-)
=20
