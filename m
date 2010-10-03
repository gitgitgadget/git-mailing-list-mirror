From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v3 0/8] ab/icase-directory: jj/icase-directory with Makefile + configure checks
Date: Sun,  3 Oct 2010 09:56:38 +0000
Message-ID: <1286099806-25774-1-git-send-email-avarab@gmail.com>
References: <4CA847D5.4000903@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Brandon Casey <drafnel@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 11:57:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2LJu-0005Ca-2r
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 11:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840Ab0JCJ5K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 05:57:10 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45079 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772Ab0JCJ5J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 05:57:09 -0400
Received: by wyb28 with SMTP id 28so4121914wyb.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=RW3jKMoRSZe3DX84XWHEvB2/GJdeOXEZnnRBErHAWiw=;
        b=a8rknt/uS2O1L/choTdqo9rsTwUxz629lPubALnCaW8LoWxNGEjfH34HH5Dd6oO1J4
         zQGRyvR/oTe9m1TTwPQF+vl8hJQBcfvTCdfL0wkJZcyM8YamTK61R9B6piarXirFoAsg
         2lLnZsGNYEP5S4a2EytQPyQaVXla8fsJdX/n4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=nEroE7QjzVfpUmMROJ3nM/fjspBuEE4vH4yZ+fxO/nl0v6wf2bdXAvaKfULz3UAdd1
         aJEebW9w2HZ6G8EqbMcIGg+0v1RZfLflMwfe9GUNlE4B1BWzvc5LiKqNwYLeybhD8W7v
         BMNbUEbRcun0HB8NR/HrQ0ynULrTK9T1SR8ZA=
Received: by 10.227.128.82 with SMTP id j18mr6833540wbs.36.1286099827090;
        Sun, 03 Oct 2010 02:57:07 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id h29sm2968435wbc.9.2010.10.03.02.57.05
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 02:57:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <4CA847D5.4000903@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157852>

On Sun, Oct 3, 2010 at 09:07, Joshua Jensen <jjensen@workspacewhiz.com>=
 wrote:
>  ----- Original Message -----
> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> Date: 10/3/2010 2:30 AM
>>
>> On Sun, Oct 3, 2010 at 04:32, Joshua Jensen<jjensen@workspacewhiz.co=
m>
>>  wrote
>>>
>>> +int fnmatch_casefold(const char *pattern, const char *string, int =
flags)
>>> +{
>>> +       char lowerPatternBuf[MAX_PATH];
>>> +       char lowerStringBuf[MAX_PATH];
>>> +       char* lowerPattern;
>>> +       char* lowerString;
>>> +       size_t patternLen;
>>> +       size_t stringLen;
>>> +       char* out;
>>> +       int ret;
>>> +
>>> +       /*
>>> +        * Use the provided stack buffer, if possible.  If the stri=
ng is
>>> too
>>> +        * large, allocate buffer space.
>>> +        */
>>> +       patternLen =3D strlen(pattern);
>>> +       if (patternLen + 1>  sizeof(lowerPatternBuf))
>>> +               lowerPattern =3D xmalloc(patternLen + 1);
>>> +       else
>>> +               lowerPattern =3D lowerPatternBuf;
>>> +
>>> +       stringLen =3D strlen(string);
>>> +       if (stringLen + 1>  sizeof(lowerStringBuf))
>>> +               lowerString =3D xmalloc(stringLen + 1);
>>> +       else
>>> +               lowerString =3D lowerStringBuf;
>>> +
>>> +       /* Make the pattern and string lowercase to pass to fnmatch=
=2E */
>>> +       for (out =3D lowerPattern; *pattern; ++out, ++pattern)
>>> +               *out =3D tolower(*pattern);
>>> +       *out =3D 0;
>>> +
>>> +       for (out =3D lowerString; *string; ++out, ++string)
>>> +               *out =3D tolower(*string);
>>> +       *out =3D 0;
>>> +
>>> +       ret =3D fnmatch(lowerPattern, lowerString, flags);
>>> +
>>> +       /* Free the pattern or string if it was allocated. */
>>> +       if (lowerPattern !=3D lowerPatternBuf)
>>> +               free(lowerPattern);
>>> +       if (lowerString !=3D lowerStringBuf)
>>> +               free(lowerString);
>>> +       return ret;
>>> +}
>>> +
>>> +int fnmatch_icase(const char *pattern, const char *string, int fla=
gs)
>>> +{
>>> +       return ignore_case ? fnmatch_casefold(pattern, string, flag=
s) :
>>> fnmatch(pattern, string, flags);
>>> +}
>>
>> I liked v1 of this patch better, although it obviously had portabili=
ty
>> issues. But I think it would be better to handle this with:
>>
>>     #ifndef FNM_CASEFOLD
>>     int fnmatch_casefold(const char *pattern, const char *string, in=
t
>> flags)
>>     {
>>         ...
>>     }
>>     #endf
>>
>>     int fnmatch_icase(const char *pattern, const char *string, int f=
lags)
>>     {
>>     #ifndef FNM_CASEFOLD
>>            return ignore_case ? fnmatch_casefold(pattern, string,
>> flags) : fnmatch(pattern, string, flags);
>>     #else
>>             return fnmatch(pattern, string, flags | (ignore_case ?
>> FNM_CASEFOLD : 0));
>>     #endif
>>     }
>>
>> Or simply use fnmatch(..., FNM_CASEFOLD) everywhere and include
>> compat/fnmatch/* on platforms like Solaris that don't have the GNU
>> extension.

I offered before to help with making this portable, so I've gone ahead
and done it. This series is like your v1, but it has two of my patches
at the front to add Makefile & configure checks & fallbacks for
fnmatch if the function either doesn't exist, or it doesn't support
the FNM_CASEFOLD flag.

> The real problem with compat/fnmatch is determining which random plat=
forms
> need that support and updating the makefile accordingly.

We already do this for a bunch of NO_WHATEVER=3D flags. Adding one more
isn't going to be too hard to maintain.

> Further, the compat/fnmatch/* code would need to be rejigged
> somewhat, so there is no possible conflict (now or in the future)
> with the provided symbols.  We discussed this as a potential problem
> developers would need to be aware of if the system fnmatch.h (or
> whatever it is called) gets #included.

Since we do -Icompat/fnmatch it's going to be our fnmatch.h that's
picked up, so we aren't going to get a symbol conflict I should think.

> Anyway, what you describe above creates two code paths.  I would imag=
ine
> that would be harder to debug; that is, on some platforms, it uses
> fnmatch_casefold and on others, it hands it off to fnmatch(...,
> FNM_CASEFOLD).

My ad-hoc example pseudocode created two codepaths, but this version
doesn't.

> In any case, I'd like to find a solution to get this series working f=
or
> everyone.  I've been out of commission for a month (deploying Git to =
80+
> programmers at an organization, by the way), but I'm back now and can=
 work
> this until it is complete.

This is all from your v1:

Joshua Jensen (6):
  Add string comparison functions that respect the ignore_case
    variable.
  Case insensitivity support for .gitignore via core.ignorecase
  Add case insensitivity support for directories when using git status
  Add case insensitivity support when using git ls-files
  Support case folding for git add when core.ignorecase=3Dtrue
  Support case folding in git fast-import when core.ignorecase=3Dtrue

These two are new:

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  Makefile & configure: add a NO_FNMATCH flag

This one is a good idea in general. We shouldn't be duplicating setup
code in both the Windows and MinGW portions of the Makefile, and if we
ever get another odd system that doesn't have fnmatch() this will make
things just work there.

Needs testing from someone with Windows.

  Makefile & configure: add a NO_FNMATCH_CASEFOLD flag

The code needed to make Joshua's code portable. On Solaris this
returns with the configure script:

    $ make configure && ./configure | grep -i -e fnmatch && grep -i -e =
fnmatch config.mak.autogen
        GEN configure
    checking for fnmatch... yes
    checking for library containing fnmatch... none required
    checking whether the fnmatch function supports the FNMATCH_CASEFOLD=
 GNU extension... no
    NO_FNMATCH=3D
    NO_FNMATCH_CASEFOLD=3DYesPlease

And on Linux:

    $ make configure && ./configure | grep -i -e fnmatch && grep -i -e =
fnmatch config.mak.autogen
        GEN configure
    checking for fnmatch... yes
    checking for library containing fnmatch... none required
    checking whether the fnmatch function supports the FNMATCH_CASEFOLD=
 GNU extension... yes
    NO_FNMATCH=3D
    NO_FNMATCH_CASEFOLD=3D

 Makefile      |   27 ++++++++++++---
 config.mak.in |    2 +
 configure.ac  |   28 +++++++++++++++
 dir.c         |  106 ++++++++++++++++++++++++++++++++++++++++++++++---=
-------
 dir.h         |    4 ++
 fast-import.c |    7 ++--
 name-hash.c   |   72 ++++++++++++++++++++++++++++++++++++++-
 read-cache.c  |   23 ++++++++++++
 8 files changed, 241 insertions(+), 28 deletions(-)

--=20
1.7.3.159.g610493
