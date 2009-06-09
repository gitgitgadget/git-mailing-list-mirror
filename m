From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] autoconf: Add link tests to each AC_CHECK_FUNC() test
Date: Mon, 08 Jun 2009 22:30:20 -0700
Message-ID: <7vprdet1n7.fsf@alter.siamese.dyndns.org>
References: <1225021939-11858-1-git-send-email-david.syzdek@acsalaska.net>
	<7v4p2q3662.fsf@gitster.siamese.dyndns.org>
	<20090608212454.GA834@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David M. Syzdek" <david.syzdek@acsalaska.net>,
	git@vger.kernel.org, jnareb@gmail.com
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 09 07:30:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDtun-00009z-1o
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 07:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbZFIFaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 01:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbZFIFaT
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 01:30:19 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:50753 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbZFIFaS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 01:30:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090609053021.MSTM18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 9 Jun 2009 01:30:21 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1hWL1c0054aMwMQ04hWLEF; Tue, 09 Jun 2009 01:30:20 -0400
X-VR-Score: -140.00
X-Authority-Analysis: v=1.0 c=1 a=jcfMypue6G8A:10 a=ijhcGDNFOe0A:10
 a=TSbVqHtbAAAA:8 a=tcgjaGXTAAAA:8 a=IJRnbbTJ5L5-b03Om4gA:9
 a=mUAnMqpKZxe8YueuzagA:7 a=w31GyJl-0VFKRvGukUqanDj_F84A:4 a=_RhRFcbxBZMA:10
 a=h4OmhKvtdQkA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121138>

Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:

> Hello, and please forgive me for replying to a very old thread,
> <http://thread.gmane.org/gmane.comp.version-control.git/99159>.
> (BTW, is that frowned upon on this list?)

Not at all.

> * Junio C Hamano wrote on Sun, Nov 02, 2008 at 09:04:21AM CET:
>> "David M. Syzdek" <david.syzdek@acsalaska.net> writes:
>> > Update configure.ac to test libraries for getaddrinfo, strcasestr, memmem,
>> > strlcpy, strtoumax, setenv, unsetenv, and mkdtemp.  The default compilers
>> > on FreeBSD 4.9-SECURITY and FreeBSD 6.2-RELEASE-p4 do not generate warnings
>> > for missing prototypes unless `-Wall' is used. This behavior renders the
>> > results of AC_CHECK_FUNC() void on these platforms. The test AC_SEARCH_LIBS()
>> > verifies a function is valid by linking to symbol within the system libraries.
>
> This description does not make sense.  AC_CHECK_FUNC does not take into
> account prototypes in the test; instead, it tries to link a program that
> requires the function symbol.

Yeah, I just looked at output from AC_CHECK_FUNC(); it creates main() that
calls the function being checked and tries to see if the program links.

And SEARCH_LIBS() won't catch missing prototypes either.

> However, there might have been another reason altogether why David was
> seeing false configure test results on his system, and it would be
> interesting to know about them (both to possibly fix Autoconf, and the
> comment introducing GIT_CHECK_FUNC in configure.ac).

Yeah, I am interested, too.  The closest BSD variant I happen to have
access to is FreeBSD 7.2, and reverting the commit there does not seem to
have any ill effects, so I'd like to know what breakage the patch fixed
(or covered up).
