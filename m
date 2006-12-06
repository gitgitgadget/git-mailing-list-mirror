X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: bug: git-sh-setup should not be in $PATH
Date: Wed, 6 Dec 2006 17:27:53 +0100
Message-ID: <200612061727.54058.jnareb@gmail.com>
References: <el6c6o$oa7$1@sea.gmane.org> <200612061656.55888.jnareb@gmail.com> <4576E9DF.5090709@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 6 Dec 2006 16:25:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PvZHpxrTo23jxPP5iYBiNYIiKKf1uWhaYjyK8gPvyupms3fyp29mh0ng69vE6O5u+ztjT5fu5eRZhvScCbwHsZ6yjRrzA8T24OZO4A81zfEQlV/09fbYX8ZWz/doRHd5gzpwPa5hKFhzROxzokjWCpLeYYGHCHWag1jgPQ0N4xk=
User-Agent: KMail/1.9.3
In-Reply-To: <4576E9DF.5090709@xs4all.nl>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33485>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grzaj-0004KN-Te for gcvg-git@gmane.org; Wed, 06 Dec
 2006 17:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936337AbWLFQZu convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006 11:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936390AbWLFQZu
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 11:25:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:14306 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S936337AbWLFQZt (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 11:25:49 -0500
Received: by ug-out-1314.google.com with SMTP id 44so190747uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 08:25:48 -0800 (PST)
Received: by 10.67.22.7 with SMTP id z7mr1078532ugi.1165422347742; Wed, 06
 Dec 2006 08:25:47 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 20sm10261752uga.2006.12.06.08.25.47; Wed, 06 Dec
 2006 08:25:47 -0800 (PST)
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Dnia =B6roda 6. grudnia 2006 17:03, Han-Wen Nienhuys napisa=B3:

> Jakub Narebski escreveu:
>
>> The fact that I didn't understood what this part of patch is meant
>> to do should be the big hint that this commit needs some longer comm=
it
>> message explaining purpose of such mess.
>>=20
>> I still don't understand what this part do (and how come it is
>> in configure.ac which should be _only_ about generating=20
>> config.mak.autogen Makefile configuration file and _not_ about
>> generating Makefiles). You want what sequence of commands to work?
>>=20
>>   $ $srcdir/configure --srcdir=3D$srcdir
>>   $ make -D $srcdir
>>   $ make -D $srcdir DESTDIR=3D$DESTDIR install
>=20
> make -D doesn't exist.

Oops. I meant make -C, not make -D.

> This is about=20
>=20
>   mkdir git-build
>   cd git-build
>   $my_git_source/configure =20
>   make=20
>=20
> this _was_ actually documented in that one-line commit message, that
> you found to be too short.

Because it was so short (one line) while being long for one line.
Why don't you write above in commit message?

> Since git does recursive makes, among others in=20
>=20
>  perl/=20
>  Documentation/
>  templates/
>  contrib/
>  =20
> there should be Makefiles in said directories. Otherwise, every rule
> in the toplevel Makefile saying
>=20
>=20
>   $(MAKE) -C subdir/
>=20
> will fail because $builddir/ does not have a Makefile in
> $builddir/subdir.

Wouldn't it be better just to modify toplevel Makefile to say:

   $(MAKE) -C $(srcdir)/subdir/

without messing with ./configure script, and creating "redirect"
Makefiles?

> The part you don't understand is a generic way of duplicating the
> Makefiles from the git sources, while making sure that they work when
> $srcdir !=3D $builddir
>=20
>=20
> Yes, if builddir !=3D srcdir , then configure is about more than
> generating config.mak.autogen

Once again: git is not autotool'ed project. Everything you want to
do should work regardless if you would run ./configure, or if you
would hand-craft config.mak file.

--=20
Jakub Narebski
