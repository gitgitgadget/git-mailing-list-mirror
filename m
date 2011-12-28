From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Possible submodule or submodule documentation issue
Date: Wed, 28 Dec 2011 20:47:40 +0100
Message-ID: <4EFB725C.7030600@web.de>
References: <1325013859.1987.65.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bill Zaumen <bill.zaumen+git@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 28 20:48:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfzTl-0005SV-Ld
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 20:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504Ab1L1Trs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Dec 2011 14:47:48 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:45000 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490Ab1L1Trr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 14:47:47 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate03.web.de (Postfix) with ESMTP id 61BE41AE8FA9B
	for <git@vger.kernel.org>; Wed, 28 Dec 2011 20:47:45 +0100 (CET)
Received: from [192.168.178.43] ([91.3.215.27]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MT8sw-1RG2as3dBu-00S9du; Wed, 28 Dec 2011 20:47:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <1325013859.1987.65.camel@yos>
X-Provags-ID: V02:K0:o+7wEja+ykIzfAZF3lEOXEPI5H/McuKPh/jwEbpwZtL
 1HD7nkBFiojJj+WovG2cnKNOqUxt3o8d/Lk0UzlOOQjNm+tazs
 IFvc4ySWnHh9US9kjOo2fWtFjO6vD0lOyZsER/8ob/fyS1rLlz
 74eLOlPRpqySEolFm03d4vZ9qdVX5/giN3SPLgrf5f4OAMLLfH
 6jLLlDhKcCqO7sQ6KkOHA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187755>

Am 27.12.2011 20:24, schrieb Bill Zaumen:
> For the 'add' command, the man page for get-submodule states
>=20
> "<repository> is the URL of the new submodule=E2=80=99s origin reposi=
tory. This
> may be either an absolute URL, or (if it begins with ./ or ../), the
> location relative to the superproject=E2=80=99s origin repository."
>=20
> and
>=20
> "In either case, the given URL is recorded into .gitmodules for use b=
y
> subsequent users cloning the superproject. If the URL is given relati=
ve
> to the superproject=E2=80=99s repository, the presumption is the supe=
rproject
> and submodule repositories will be kept together in the same relative
> location, and only the superproject=E2=80=99s URL needs to be provide=
d:
> git-submodule will correctly locate the submodule using the relative =
URL
> in .gitmodules."
>=20
> Based on that documentation, I tried the following sequence of comman=
ds:
>=20
> git init --bare library.git
> git init --bare library-pkg.git
> git clone library.git
> cd library;
> echo hello > hello
> git add hello
> git commit -m "initial"
> git push origin master
> cd ..
> git clone library-pkg.git

I assume you did forget to add a "cd library-pkg" here.

> echo goodbye > goodbye
> git add goodbye
> git submodule add ./library.git src   <FAILS>

With Git 1.7.1 I get the following error message:

fatal: '/tmp/library-pkg.git/library.git' does not appear to be a git r=
epository
fatal: The remote end hung up unexpectedly
Clone of '/tmp/library-pkg.git/library.git' into submodule path 'src' f=
ailed

Which is rather what I would have expected: Using "./library.git src"
implies the library living *inside* the "library-pkg.git" repo, not
next to it (and the error message shows that). "../library.git" is the
correct relative path, so the next command works as expected.

> git submodule add ../library.git src  <WORKS>
> git commit -a -m "initial pkg"
> git push origin master
>=20
> The documentation as written suggests that the first use of=20
> "git submodule add" is the one that should have worked because
> library.git is in the same directory as the origin repository
> library-pgk.git .  I didn't try moving the two .git directories
> to a server to see if the behavior is the same in that case (my
> test was using the local file system).

Hmm, the documentation says "the location relative to the
superproject=E2=80=99s origin repository", not the directory containing
it. This means you have to use ".." first to get out of the
repository itself, no?
