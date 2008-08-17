From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: Re: [PATCH 2/6] Only define NEEDS_SOCKET if libsocket is usable
Date: Sun, 17 Aug 2008 13:40:45 +0200
Message-ID: <0380BBDB-ABC4-49D2-AF89-A30256397CFB@web.de>
References: <2EA0EACE-D8FE-476A-BAE2-7E12EE961C46@web.de> <7v63q080io.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 13:45:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUghA-0004qU-SO
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 13:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbYHQLlL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Aug 2008 07:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbYHQLlK
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 07:41:10 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:51505 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbYHQLlJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Aug 2008 07:41:09 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id E7D86E6E50E6;
	Sun, 17 Aug 2008 13:41:07 +0200 (CEST)
Received: from [91.18.70.145] (helo=[10.0.1.1])
	by smtp07.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.109 #226)
	id 1KUgd9-0001NB-00; Sun, 17 Aug 2008 13:41:07 +0200
In-Reply-To: <7v63q080io.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
X-Sender: Andreas.Faerber@web.de
X-Provags-ID: V01U2FsdGVkX18kYm0J6BtSNgcc8cO2n1vu8nX0em5FOLnp/Q97
	/E6i/exwS67wS7e1yb8G8z9sajBkkJMu2FdTnuIs6nZjhCiC65
	GFQpF1vtmGgE9n4DbIjA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92599>


Am 17.08.2008 um 11:16 schrieb Junio C Hamano:

> Andreas F=E4rber <andreas.faerber@web.de> writes:
>
>> diff --git a/configure.ac b/configure.ac
>> index 7c2856e..75ec83a 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -223,11 +223,11 @@ AC_LINK_IFELSE(ZLIBTEST_SRC,
>> LIBS=3D"$old_LIBS"
>> AC_SUBST(NO_DEFLATE_BOUND)
>> #
>> -# Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
>> +# Define NEEDS_SOCKET if linking with libc is required (SunOS,
>> # Patrick Mauritz).
>> -AC_CHECK_LIB([c], [socket],
>> -[NEEDS_SOCKET=3D],
>> -[NEEDS_SOCKET=3DYesPlease])
>> +AC_CHECK_LIB([socket], [socket],
>> +[NEEDS_SOCKET=3DYesPlease],
>> +[NEEDS_SOCKET=3D])
>> AC_SUBST(NEEDS_SOCKET)
>> test -n "$NEEDS_SOCKET" && LIBS=3D"$LIBS -lsocket"
>
> Doesn't this force linkage with -lsocket even if -lc is enough to use
> socket(2) calls?

If both libc and libsocket provide it, yes.

> In other words, "checking libc is not enough" is only half correct.  =
=20
> The
> right thing to do is "check libc and if it is sufficient be happy, bu=
t
> otherwise do not automatically assume -lsocket is Ok."  Something =20
> like:
>
> AC_CHECK_LIB([c], [socket],
> [NEEDS_SOCKET=3D],
> [AC_CHECK_LIB([socket], [socket],
>        	[NEEDS_SOCKET=3DYesPlease],
>                [NEEDS_SOCKET=3D])])

Looks okay to me that way.

> Other patches seemed Ok from my cursory look; I do not know the
> people whose Ack's were on your patch submission, though...

Sorry for not explaining: Ingo is one of the core Haiku developers, =20
and Scott is from HaikuPorts. This is the initial submission to this =20
list, trying to adhere to the SubmittingPatches document.

Andreas
