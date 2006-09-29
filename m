From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/5] fetch & co: misc output cleanup
Date: Fri, 29 Sep 2006 14:27:35 -0700
Message-ID: <7v1wpumkhk.fsf@assigned-by-dhcp.cox.net>
References: <87r6xu1rci.fsf@gmail.com> <451D6BDB.50900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 29 23:27:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTPtV-0007zs-Dv
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 23:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWI2V1i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 29 Sep 2006 17:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWI2V1i
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 17:27:38 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:19451 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932381AbWI2V1h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 17:27:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060929212736.XWYV6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Sep 2006 17:27:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UMTY1V0071kojtg0000000
	Fri, 29 Sep 2006 17:27:32 -0400
To: A Large Angry SCM <gitzilla@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28131>

A Large Angry SCM <gitzilla@gmail.com> writes:

> Santi B=E9jar wrote:
>> this patchset includes:
>>
>>       fetch: Reset remote refs list each time fetch_main is called
>>       fetch & co: Use "hash1..hash2" instead of "from hash1 to hash2=
"
>>       fetch & co: Use short sha1 in the output
>>       fetch: Add output for the not fast forward case
>>       fetch: Clean output
>
> Please do not make short ID output the default. That is, unless you
> can somehow guarantee that the short ID reported today will _always_
> be unambiguous even with future additions to the repository.

I would understand your worries of spitting out only abbreviated
object names if they appear in a document to be preserved for a
long term.  But we are talking about output to stderr to help
people see what happened in the operation they initiated a few
moments ago, and to help them use the output for cut&paste while
it is still in the scrollbuffer of the terminal.

Shortening them would help A..B avoid crossing the line
boundaries, which terminal emulators have trouble with cutting
sometimes.  That benefit may outweigh the longer term ambiguity
concerns.

The only real-life situation I can imagine the program output is
preserved in any longer term than immediate consumption for
cut&paste is to paste it into a piece of e-mail (which is
archived), to show exactly what the program said to the user.
But then it carries the timestamp and you should be able to
figure out what the abbreviation uniquely stood for back then if
you really cared.  If you are producing a document for longer
term storage, the program that produces such a document should
be doing its own rev-parse anyway (or maybe pass whatever it is
piping through git-name-rev --stdin).

I think it is Ok to always use the abbreviated form in the
places Santi's patch touched, as long as people understand these
messages are not for long term storage.  We might want to use a
bit longer abbreviation than the default (7 hexdigits).
