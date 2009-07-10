From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH/RFC] grep: Add --directories option.
Date: Fri, 10 Jul 2009 18:41:19 +0200
Message-ID: <20090710184119.072e5a0f@gmail.com>
References: <1247167228-2466-1-git-send-email-michal.kiedrowicz@gmail.com>
	<4A56EED7.9040008@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Jul 10 18:41:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPJAD-00010h-7q
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 18:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884AbZGJQl1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2009 12:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754681AbZGJQl0
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 12:41:26 -0400
Received: from ey-out-1920.google.com ([74.125.78.148]:21694 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875AbZGJQlZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jul 2009 12:41:25 -0400
Received: by ey-out-1920.google.com with SMTP id 3so204352eyh.36
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=btgmR+n6LkGJjGntEEp6fMkJ5OoBwyEgI5YhEu9AEgM=;
        b=HqU52zdfRei6Oo3tY+vCBRrQxR4V0lOxWhvQUbn/qEatehbk3DY8+z2jNj0rZvh5kG
         LxTYav165Jzl0p7RoJdwnObYrAIBMspn1axRDG+DehcS3PMQQo6/Sx9Hsaamsp2AiLmt
         R7s3ibVI5jnxariSsJk8uhvkaNAjxGJNWLopI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=i0ZOqbjK4RsG6IzYcoIsVUKuysmr9eAL+xlv+gaQY8rBfXGf9NKlDzzPid8kUQckBS
         WHdzkKaT0s68J/imFZhFdwNLMvC+ePvpHRgSdB7jfprhLehirRf6rlHSpbR0ue2hEi4t
         WIB2R3O5AL4KZjuxQXCVwslJxegjtgEi8PjRg=
Received: by 10.210.118.13 with SMTP id q13mr2649510ebc.45.1247244083724;
        Fri, 10 Jul 2009 09:41:23 -0700 (PDT)
Received: from localhost (87-205-51-27.adsl.inetia.pl [87.205.51.27])
        by mx.google.com with ESMTPS id 23sm3018381eya.26.2009.07.10.09.41.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Jul 2009 09:41:23 -0700 (PDT)
In-Reply-To: <4A56EED7.9040008@lsrfire.ath.cx>
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123062>

Hi,

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:

>=20
> I suspect the patch would shrink significantly if you moved "int
> recurse" into struct grep_opt, because then you wouln't need to add i=
t
> as a parameter to the grep_* functions.

Yes. At the beginning, I placed 'int recurse' in that struct. However, =
I
thought that this struct does not say anything about selecting files,
but it says how to grep files (invert, count, fixed [string], binary
etc.). Most of opts (if not all) are used in grep.c, not builtin-grep.c=
=2E

>=20
> > diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
> > index 7868af8..6d1faf4 100755
> > --- a/t/t7002-grep.sh
> > +++ b/t/t7002-grep.sh
> > @@ -22,7 +22,9 @@ test_expect_success setup '
> >  	echo zzz > z &&
> >  	mkdir t &&
> >  	echo test >t/t &&
> > -	git add file w x y z t/t &&
> > +	mkdir t/a &&
> > +	echo aa aa aa aa >t/a/a &&
> > +	git add file w x y z t/t t/a/a &&
>=20
> This conflicts with a recent change.

Yeah, I found out that...
>=20
> It seems your patch still allows recursion, one level deep.  In git's
> repo:
>=20
> 	$ grep -l --directories=3Dskip GNU compat
>=20
> 	$ grep -l --directories=3Dskip GNU compat/*
> 	compat/qsort.c
> 	compat/snprintf.c
>=20
> 	$ git grep -l --directories=3Dskip GNU compat
> 	compat/qsort.c
> 	compat/snprintf.c
>=20
> 	$ git grep -l --directories=3Dskip GNU compat/*
> 	compat/fnmatch/fnmatch.c
> 	compat/fnmatch/fnmatch.h
> 	compat/nedmalloc/malloc.c.h
> 	compat/nedmalloc/nedmalloc.c
> 	compat/nedmalloc/nedmalloc.h
> 	compat/qsort.c
> 	compat/regex/regex.c
> 	compat/regex/regex.h
> 	compat/snprintf.c
>=20
> Ren=C3=A9

Actually, this is what I wanted: Do not descend to subdirectories of
selected directories. After a while, I think this action should be
called "read [files in that directory]", not "skip".
