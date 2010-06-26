From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] Makefile: Don't pass $(ALL_CFLAGS) to the linker
Date: Sat, 26 Jun 2010 13:19:45 -0500
Message-ID: <20100626181945.GA13070@burratino>
References: <4C226520.5080009@ramsay1.demon.co.uk>
 <20100623210820.GA24242@burratino>
 <4C264019.6030408@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Peter Harris <git@peter.is-a-geek.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Jun 26 20:20:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSZzL-00067U-U3
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 20:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356Ab0FZSUH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 14:20:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63113 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031Ab0FZSUE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 14:20:04 -0400
Received: by iwn41 with SMTP id 41so3076931iwn.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 11:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zPZEr5tVqwRJkdwGUtoFyCaf2QJgSHGka1919Stlnbs=;
        b=fSqh0B6iFxi8rFJwOqhxglGYSs+HeRPc3teDADz12gYFdFBtkStROkQdDUnwtiSxQS
         UXABLBDzxxNgRJ1wPLjcRJXcPoTJQocL+0mHTtDsKHzgw9hLnU+FacOpvKPB2keG5wbW
         rd21nOBudDZMvW5U4Vy0lOTNWq3UQYNfqRoSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=vVtOAwQXUoUWhyeBjurGfsrasb+cORBZN5U+8CZZgJ7ZNR+QO5s0NxKiuzNx1AwBDz
         bbrAUC4amq8jenFcbZUUD9jc7tJar0tSzjXH32IkAe4DCSBSLReial1lwQ/T0fMvMH7Y
         LH6YjfFPwhm3OsoUAEVCoV9kKDXNTizbKIfAg=
Received: by 10.231.125.167 with SMTP id y39mr2799447ibr.93.1277576402299;
        Sat, 26 Jun 2010 11:20:02 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r3sm1220427ibk.7.2010.06.26.11.20.00
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 11:20:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C264019.6030408@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149768>

Ramsay Jones wrote:

> I thought that the general scheme was something like:
>=20
>     - LDFLAGS is for options which only affects the operation of
>       the linker (e.g. -L).
>     - CPPFLAGS is for options which only affects the operation of
>       the C pre-processor (e.g. -I, -D, -U)
>     - CFLAGS is for options which only affects the operation of
>       the compiler proper.
>
> If an option affects multiple phases, then (one option) is to include
> it into each of the above macros to which it applies.

That does make sense.  Perhaps =E2=80=9Ctraditionally=E2=80=9D was not =
the right word;
I was just looking at common practice.  I=E2=80=99ve just never seen -O=
 put
into LDFLAGS, for example, and I think most people would expect
setting CFLAGS=3D-O0 to affect the linker, too.

> Jonathan Nieder wrote:

>> I realize that the Makefile does not currently use the terms this wa=
y:
>> making it consistent would require
>>=20
>>  . s/BASIC_CFLAGS/BASIC_CPPFLAGS/, except that the
[etc]
>>=20
>> What do you think?
>
> I think I am missing something, since I don't see how this relates to
> my patch!

I suspect the problem comes from my unfamiliarity with MSVC.

By analogy with GCC, I assumed that any parameter is intended for the
preprocessor, the linker, or the frontend/both.  In other words, I was
assuming flags for the compiler proper can be safely passed to the
linker, and that /Zi must be for the preprocessor-using stages only.
CFLAGS tends to contain front-end arguments used for all stages of
translation.

What does /Zi do?  Searching online reveals:

 - it means =E2=80=9Cenable debugging information=E2=80=9D
 - weakly implies /debug for the linker
 - overrides /Z7 and /Zd, and is overridden by them
 - is incompatible with /MP
 - is among the prerequisites for /dlp and for /Gm

Maybe clink.pl should use =E2=80=9Ccl.exe /link=E2=80=9D instead of =E2=
=80=9Clink.exe=E2=80=9D and this
problem would go away.
