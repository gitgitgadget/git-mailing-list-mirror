From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Wed, 05 Sep 2007 19:29:24 +0200
Message-ID: <vpq642pkoln.fsf@bauges.imag.fr>
References: <46DDC500.5000606@etek.chalmers.se>
	<1189004090.20311.12.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 19:31:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISyiY-0006X1-Gd
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 19:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbXIERbB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Sep 2007 13:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752803AbXIERbA
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 13:31:00 -0400
Received: from imag.imag.fr ([129.88.30.1]:57491 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbXIERa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 13:30:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l85HTOJJ024081
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 5 Sep 2007 19:29:25 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1ISygu-0006mV-Fx; Wed, 05 Sep 2007 19:29:24 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1ISygu-0000eX-DQ; Wed, 05 Sep 2007 19:29:24 +0200
In-Reply-To: <1189004090.20311.12.camel@hinata.boston.redhat.com> ("Kristian
 =?iso-8859-1?Q?H=F8gsberg=22's?= message of "Wed\, 05 Sep 2007 10\:54\:50
 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 05 Sep 2007 19:29:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57723>

Kristian H=F8gsberg <krh@redhat.com> writes:

> On Tue, 2007-09-04 at 22:50 +0200, Lukas Sandstr=F6m wrote:
>> Hi.
>>=20
>> This is an attempt to use "The Better String Library"[1] in builtin-=
mailinfo.c
>>=20
>> The patch doesn't pass all the tests in the testsuit yet, but I thou=
ght I'd
>> send it out so people can decide if they like how the code looks.
>>=20
>> I'm not sending a patch to add the library files at this time. I'll =
send
>> that patch when this patch is working.
>>=20
>> The changes required to make it pass the tests shouldn't be very lar=
ge.
>
> Please, no.  Let's not pull in a dependency for something as simple a=
s a
> string library.  How many distros have bstring pcakaged? =20
> The right version?

That's not a good argument. If dependancy is a problem, bsstring can
easily be distributed as part of git. It's really small, so it wont
make git bloated:

$ wc -l *.c *.h
    82 bsafe.c
  3462 bstest.c
  1134 bstraux.c
  2964 bstrlib.c
   358 testaux.c
    43 bsafe.h
   112 bstraux.h
   302 bstrlib.h
   442 bstrwrap.h
  8899 total

> Does it work on Windows?

The library is totally stand alone, portable (known to work with
gcc/g++, MSVC++, Intel C++, WATCOM C/C++, Turbo C, Borland C++, IBM's
native CC compiler on Windows, Linux and Mac OS X)

> We already have strbuf.c, lets just consolidate the string
> manipulation code already in git under that interface.

The right question is: what does git need. One way to consolidate
strbuf would be to simply

$ rm strbuf.{c,h}
$ unzip bsstring.zip

and if people decide that git needs a non-trivial string library,
writting/testing more code in strbuf.c would probably be more work
than just reading what bsstring code does to become familiar enough
with it to even be able to maintain it later.

If people decide that git needs a really trivial string library, then
a few improvements to stbuf.c can be good.

I'd argue in favor of the first option. C strings are horrible, and I
think doing something pleasant to use and safe is not completely
trivial. But I'm not a big contributor enough to really decide in
spite of others ;-).

--=20
Matthieu
