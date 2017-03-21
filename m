Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F099F20323
	for <e@80x24.org>; Tue, 21 Mar 2017 10:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756133AbdCUKIl (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 06:08:41 -0400
Received: from smtpo.poczta.interia.pl ([217.74.65.206]:59085 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbdCUKIk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 06:08:40 -0400
Date:   Tue, 21 Mar 2017 11:08:30 +0100
From:   Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
Subject: Re: fatal: Could not get current working directory: Permission
 denied | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     =?iso-8859-1?b?UmVu6Q==?= Scharfe <l.s.r@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
X-Mailer: interia.pl/pf09
In-Reply-To: <7f25def4-9943-ae59-a649-b4348a79890e@web.de>
References: <elvahoiwfqayelbskykd@qjih>
        <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de> <hpulcgxossrwvfbbcvcl@zndn>
        <10cc42b8-0f63-2d97-8da1-2943970d63cc@web.de> <ogwsaxvtiqlsiwojzxul@owpk>
        <3ba0c8e3-894a-846f-ba99-dad1deba7cdf@web.de> <tskgutqgpyszzedvyfra@prol>
        <f2ab799f-5f0a-0ce0-0625-13513bc1973d@web.de> <ffntuqzgjgcfhebokbty@eduj>
        <7f25def4-9943-ae59-a649-b4348a79890e@web.de>
X-Originating-IP: 89.64.255.37
Message-Id: <xiszmpcvkgewmkltlhqf@qpcy>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1490090911;
        bh=atC/2xfFovuGeSnSlFEARzg4S4M/y1zw74HI53cuY0M=;
        h=Date:From:Subject:To:Cc:X-Mailer:In-Reply-To:References:
         X-Originating-IP:Message-Id:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=sgDzi9/8hKfuHrN4w6ITV7NQA9KXDxHKQZvW6urIe1UQcTy1ktY0tDRvYGRvOgk9j
         ds2apEPMnBz7Iry6+yWr2PLLQYp898K025x3o5HGWePvdXUmpBaYXo/uHac6ugohtq
         s0W5R2cuTy8Bgt34s1oyGWubJQ3Vdf2SXF8qzIFE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Od: "Ren=C3=A9 Scharfe" &lt;l.s.r@web.de>
Do: "Zenobiusz Kunegunda" &lt;zenobiusz.kunegunda@interia.pl>;=20
Wys=C5=82ane: 22:31 =C5=9Aroda 2017-03-15
Temat: Re: fatal: Could not get current working directory: Permission denie=
d | affected 2.10,2.11,2.12, but not 1.9.5 |

>=20
> > Am 15.03.2017 um 10:44 schrieb Zenobiusz Kunegunda:
>> $ git bisect bad
>> 7333ed1788b4f2b162a35003044d77a716732a1f is the first bad commit
>> commit 7333ed1788b4f2b162a35003044d77a716732a1f
>> Author: Ren=C3=A9 Scharfe=20
>> Date:   Mon Jul 28 20:26:40 2014 +0200
>>
>>     setup: convert setup_git_directory_gently_1 et al. to strbuf
>=20
> That's what I half-suspected, and I think by now I got an idea.  Here's=20
> a test program:
>=20
> 	#include=20
> 	#include=20
> 	#include=20
> 	#include=20
> 	#include=20
>=20
> 	int main(int argc, char **argv)
> 	{
> 		char buf[PATH_MAX];
> 		int last_errno =3D 0;
> 		size_t len;
>=20
> 		for (len =3D 0; len &lt;=3D PATH_MAX; len++) {
> 			errno =3D 0;
> 			getcwd(buf, len);
> 			if (errno !=3D last_errno) {
> 				printf("len =3D %lu, errno =3D %d, %s\n",
> 					len, errno, strerror(errno));
> 			}
> 			last_errno =3D errno;
> 		}
> 		return 0;
> 	}
>=20
> It runs getcwd(2) with buffer sizes from 0 to PATH_MAX and reports when=20
> the error code changes along the way.  Let's call it test_getcwd.  And=20
> here's what I get on FreeBSD 10.3:
>=20
> 	$ mkdir /tmp/a
> 	$ cd /tmp/a
>=20
> 	$ chmod 100 /tmp/a
> 	$ test_getcwd
> 	len =3D 0, errno =3D 22, Invalid argument
> 	len =3D 1, errno =3D 34, Result too large
> 	len =3D 7, errno =3D 0, No error: 0
>=20
> 	$ chmod 000 /tmp/a
> 	$ test_getcwd
> 	len =3D 0, errno =3D 22, Invalid argument
> 	len =3D 1, errno =3D 34, Result too large
> 	len =3D 2, errno =3D 13, Permission denied
> 	len =3D 7, errno =3D 0, No error: 0
>=20
> So if we don't have execute permission and our buffer is at least one=20
> char long but still too small then we get EACCES (13).  If we don't have=20
> read permissions and our buffer is big enough then the call succeeds.=20
> strbuf_getcwd() expects to get ERANGE (34) and nothing else when the=20
> buffer is too small.
>=20
> I'd say it's a bug in FreeBSD -- reporting permission denied or success=20
> based on the size of the supplied buffer makes no sense to me, at least.
>=20
> The initial buffer size used by strbuf_getcwd() is 128, so you should be=20
> fine as long as the absolute path to your repository is shorter than=20
> that.  You should also be fine if you have execute permissions on the=20
> directory.
>=20
> And here I'm puzzled again -- you probably have sufficient permissions=20
> set up for your user, right?  What does the test program report for your=20
> problematic repository and its parent directories?
>=20
> Ren=C3=A9
>=20
>=20

This program produces same errors I get from git in every directory . But n=
o errors at all when run as root. Here is example when run as reular user.

   $ getcwdtest=20
   len =3D 0, errno =3D 22, Invalid argument
   len =3D 1, errno =3D 34, Result too large
   len =3D 2, errno =3D 13, Permission denied
   len =3D 19, errno =3D 0, No error: 0
   $ mkdir testdir
   $ cd testdir/
   $ getcwdtest=20
   len =3D 0, errno =3D 22, Invalid argument
   len =3D 1, errno =3D 34, Result too large
   len =3D 9, errno =3D 13, Permission denied
   len =3D 27, errno =3D 0, No error: 0

But when run as root there is no permission denied errors. Filesystem is ZF=
S.=
