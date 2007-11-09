From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Add strchrnul()
Date: Fri, 9 Nov 2007 17:44:49 +0100
Message-ID: <200711091744.50017.jnareb@gmail.com>
References: <4733AEA0.1060602@lsrfire.ath.cx> <fh1o4o$jei$1@ger.gmane.org> <473467C4.8020208@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:45:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqWyt-0005K4-FF
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 17:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbXKIQpF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 11:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754068AbXKIQpE
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 11:45:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:2472 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410AbXKIQpB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 11:45:01 -0500
Received: by nf-out-0910.google.com with SMTP id g13so525778nfb
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 08:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=SNbt0QF2LLIvBMFkxs4yQmgBEj56VOTr25ZfeKo0XRE=;
        b=qb306HVnh/ZXHtpMyJHJkhKmRfti/NDJRo5UNLjs02ygngg2ruk9mL9EYpKGcJ5rNDz428jK2OjHL6CIMHHOKO1Q2BbVuDT07ZRdQKJg2Swbtwy6btMu493S50qDgr/WzZkz1XquTCTUfIUwYxOSUeIi1NDtbOLL9KxDEwV1WAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GfXX8qLQfck0zJfZPy3m+dGAA6Fxw/C4guNtsmjUF0ke9EgyDqWQOW706WeZDU261AvfsKiehzhmT8d2iN5Gef+itjxy/zXI/ayPI70k1yQNXsurI5DD0l0EYfnTi4l/vvhhU1pQ6UxEYtrb+7ujEKF6DlMZaiHI4P4zg3ZkYZ0=
Received: by 10.86.98.18 with SMTP id v18mr1557258fgb.1194626698258;
        Fri, 09 Nov 2007 08:44:58 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.213.178])
        by mx.google.com with ESMTPS id 3sm1601362fge.2007.11.09.08.44.55
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Nov 2007 08:44:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <473467C4.8020208@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64217>

Andreas Ericsson wrote:
> Jakub Narebski wrote:
>> Ren=E9 Scharfe wrote:

>>> +#if !defined(__GLIBC__) && !__GLIBC_PREREQ(2, 1)
>>> +# define strchrnul(s, c) gitstrchrnul(s, c)
>>> +static inline char *gitstrchrnul(const char *s, int c)
>>> +{
>>> +       while (*s && *s !=3D c)
>>> +               s++;
>>> +
>>> +       return (char *)s;
>>> +}
>>> +#endif
>>> +
>>=20
>> This is good solution, although I'm not sure about the check itself.
>> What if somebody has libc which is not glibc, but it does have
>> strchrnul?=20
>=20
> They most likely fall into the minority that get to suffer from
> using code that's as fast as what's in there today, although
> a bit more readable. The glibc optimization is really only
> worthwhile for architectures where strchrnul()-like operations
> have microcode support, or when it's used on large strings.

If we end up using this solution, then adding test for strchrnul in the=
=20
configure (configure.ac and config.mak.in) is not needed...

> YMMV. I suppose rewriting it as
>=20
> #if defined(__GLIBC_PREREQ) && __GLIBC_PREREQ(2, 1)

#if !defined(HAVE_STRCHRNUL) && \
     defined(__GLIBC_PREREQ) && __GLIBC_PREREQ(2, 1)

> # define HAVE_STRCHRNUL
> #endif
>=20
> #ifdef HAVE_STRCHRNUL
> ...
>=20
> would work too, and will provide an easier way out for other fellas
> wanting to say "Hey, my favourite solaris libc has this too!". OTOH,
> that rewrite can be done when the first such case appears.

=2E..but if we end up using this version (be it HAVE_STRCHRNUL, or=20
NO_STRCHRNUL), then test for strchrnul in ./configure is I think
necessary.

--=20
Jakub Narebski
Poland
