From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] abspath.c: use PATH_MAX in real_path_internal()
Date: Sun, 20 Jul 2014 01:55:33 +0200
Message-ID: <53CB0575.5020707@gmail.com>
References: <1405601143-31354-1-git-send-email-pclouds@gmail.com> <53C80265.5030903@web.de> <53C8562C.4000304@gmail.com> <53C905EB.3010908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
	=?UTF-8?B?Tmd1eeG7hW4=?= =?UTF-8?B?IFRow6FpIE5n4buNYyBEdXk=?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 01:55:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8eTd-0007Ft-OO
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 01:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164AbaGSXzh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jul 2014 19:55:37 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:34728 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755961AbaGSXzg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 19:55:36 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so4924087wgh.2
        for <git@vger.kernel.org>; Sat, 19 Jul 2014 16:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=d71U429xOsVDyIA3U39G93dmEa8bqeKVs+WDNPJUuug=;
        b=mBVI9/gWPLAslRUcZBLnzjTTmX0eqegAjjZ68uVNoOV4NDM50p3E9z3rNbhHwueKSp
         9Yb7NNdnPaGt7/EvYZGEFSQo3FRuprfpqWz+DU4hlieATe6tU5/1aHcrptQDp9Q3JStJ
         TRRIjxNM8+KwP2LXnq97UOxO22S5aYHbkVa7JkoXBJhr+yhjRB/qy2ps071WArnr/MRa
         A8fKZw46t49Q23J4j2wKSs8vNB6oIH3YeU9j+o19Dpgs0cP1Ra/eKTJl1AZR7A52nxBl
         6O1BrwSxjgErZLLmCPuexYQLXPx+T/olco1VtiDFQx6VB1p9mk4hdX2YDAHf6uJCXVJc
         Hywg==
X-Received: by 10.194.6.10 with SMTP id w10mr8715673wjw.51.1405814135372;
        Sat, 19 Jul 2014 16:55:35 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id pq9sm25338608wjc.35.2014.07.19.16.55.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Jul 2014 16:55:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C905EB.3010908@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253908>

Am 18.07.2014 13:32, schrieb Ren=C3=A9 Scharfe:
> Am 18.07.2014 01:03, schrieb Karsten Blees:
>> Am 17.07.2014 19:05, schrieb Ren=C3=A9 Scharfe:
>>> Am 17.07.2014 14:45, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy:
>> [...]
>>> "These routines have traditionally been used by programs to save th=
e
>>> name of a working directory for the purpose of returning to it. A m=
uch
>>> faster and less error-prone method of accomplishing this is to open=
 the
>>> current directory (.) and use the fchdir(2) function to return."
>>>
>>
>> fchdir() is part of the POSIX-XSI extension, as is realpath(). So wh=
y not
>> use realpath() directly (which would also be thread-safe)?
>=20
> That's a good question; thanks for stepping back and looking at the b=
igger picture.  If there is widespread OS support for a functionality t=
hen we should use it and just provide a compatibility implementation fo=
r those platforms lacking it.  The downside is that compat code gets le=
ss testing.
>=20

I just noticed that in contrast to the POSIX realpath(), our real_path(=
) doesn't require the last path component to exist. I don't know if thi=
s property is required by the calling code, though.

> Seeing that readlink()

You mean realpath()? We don't have a stub for that yet.

> is left as a stub in compat/mingw.h that only errors out, would the e=
quivalent function on Windows be PathCanonicalize (http://msdn.microsof=
t.com/en-us/library/windows/desktop/bb773569%28v=3Dvs.85%29.aspx)?
>=20

PathCanonicalize() doesn't return an absolute path, the realpath() equi=
valent would be GetFullPathName() (doesn't resolve symlinks) or GetFina=
lPathNameByHandle() (requires Vista, resolves symlinks, requires the pa=
th to exist).

>> For non-XSI-compliant platforms, we could keep the current implement=
ation.
>=20
> OK, so realpath() for Linux and the BSDs, mingw_realpath() wrapping P=
athCanonicalize() for Windows and the current code for the rest?
>=20
>> Or re-implement a thread-safe version, e.g. applying resolve_symlink=
() from
>> lockfile.c to all path components.
>=20
> Thread safety sounds good.  We'd also need something like normalize_p=
ath_copy() but without the conversion of backslashes to slashes, in ord=
er to get rid of "." and ".." path components and something like absolu=
te_path() that doesn't die on error, no?
>=20

Windows can handle forward slashes, so normalize_path_copy works just f=
ine.

>> If I may bother you with the Windows point of view:
>>
>> There is no fchdir(), and I'm pretty sure open(".") won't work eithe=
r.
>=20
> On Windows, there *is* an absolute path length limit of 260 in the no=
rmal case and a bit more than 32000 for some functions using the \\?\ n=
amespace. So one could get away with using a constant-sized buffer for =
a "remember the place and return later" function here.
>=20

The current directory is pretty much the only exception to the \\?\ tri=
ck [1]. So a fixed buffer for getcwd() would actually be fine on Window=
s (although it would have to be 3 * PATH_MAX, as PATH_MAX wide chars wi=
ll convert to at most 3 * PATH_MAX UTF-8 chars).

However, a POSIX conformant getcwd must fail with ERANGE if the buffer =
is too small. So a better alternative would be to add a strbuf_getcwd()=
 that works similar to strbuf_readlink() (i.e. resize the buffer until =
its large enough).

Side note: the 'hard' 260 limit for the current directory also means th=
at as long as we *simulate* realpath() via chdir()/getcwd(), long paths=
 [1] don't work here.

> Also, _getcwd can be asked to allocate an appropriately-sized buffer =
for use, like GNU's get_current_dir_name, by specifying NULL as its fir=
st parameter (http://msdn.microsoft.com/en-us/library/sf98bd4y.aspx).
>=20

We use nedmalloc in the Windows builds, so unfortuately we cannot free =
memory allocated by MSVCRT.dll.


[1] http://msdn.microsoft.com/en-us/library/windows/desktop/aa365530%28=
v=3Dvs.85%29.aspx
[2] https://github.com/msysgit/git/commit/84393750
