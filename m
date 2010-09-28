From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 0/2] use libcharset.h with gettext if available
Date: Tue, 28 Sep 2010 18:29:35 +0000
Message-ID: <1285698577-28395-1-git-send-email-avarab@gmail.com>
References: <AANLkTinHCETsaM=ytHuE9S5A+uAb=e3YLETsJJLga+DM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 20:29:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ew6-0003wq-3j
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 20:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757691Ab0I1S3r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 14:29:47 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37663 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755791Ab0I1S3q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 14:29:46 -0400
Received: by wyb28 with SMTP id 28so5264287wyb.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OhwLcwD1Qdxb/Si5aebdLrjgHpA8a32zPJhT+id8jjQ=;
        b=GRgF2NG4T6mixJMXQfJ0L3Ev8gmveEg5fefUlK5ErUvVPKoyXqKg5Uuq4EK6Wzmarj
         ffBci21HABALFwILFK56zE489/veOivmm0BMFy7uAV1N2LBgmx8Ygc8Q/k2s223GwR4G
         a260zL2duhpnCX8cb81tB5ID4TJ8VF9d643b8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ji+R71p2jrXj+4tG06JRj3vq8PWRVY2rBWcdu3Utkn19mo7NN2fCQh2PDcNaj9+BIz
         UI+5eGOOc18LL+dgHD9Rwo71aJEjp1u8ER8KlscYObF55eNbIH8pkPfiPs6zRhKommTn
         T32qflJYLtY9ud0X6nQzDAREl0h/lW0rEwEik=
Received: by 10.227.68.207 with SMTP id w15mr370029wbi.75.1285698585138;
        Tue, 28 Sep 2010 11:29:45 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id x33sm4718305weq.23.2010.09.28.11.29.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 11:29:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <AANLkTinHCETsaM=ytHuE9S5A+uAb=e3YLETsJJLga+DM@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157452>

On Tue, Sep 28, 2010 at 17:42, Erik Faye-Lund <kusmabite@gmail.com> wro=
te:
> On Tue, Sep 28, 2010 at 7:07 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> On Tue, Sep 28, 2010 at 16:05, Erik Faye-Lund <kusmabite@gmail.com> =
wrote:
>>> libcharset provides an even more portable way of quering the charse=
t
>>> of the current locale.
>>>
>>> Use that instead of nl_langinfo unless NO_LIBCHARSET is set.
>>>
>>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>>> ---
>>>
>>> Windows doesn't have langinfo.h and nl_langinfo(), but libcharset w=
as
>>> invented for this very purpose. With this patch on top, ab/i18n
>>> compiles without errors in msysGit.
>>>
>>> There's still a bunch of lower-level issues on Windows, like gettex=
t
>>> ending up overloading our winansi-wrappings for printf and friends,
>>> but let's take thinks one step at the time :)
>>>
>>> =C2=A0configure.ac | =C2=A0 =C2=A06 ++++++
>>> =C2=A0gettext.c =C2=A0 =C2=A0| =C2=A0 10 +++++++++-
>>> =C2=A02 files changed, 15 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/configure.ac b/configure.ac
>>> index 1821d89..d3139cd 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -810,6 +810,12 @@ AC_CHECK_HEADER([libintl.h],
>>> =C2=A0[NO_GETTEXT=3DYesPlease])
>>> =C2=A0AC_SUBST(NO_GETTEXT)
>>> =C2=A0#
>>> +# Define NO_LIBCHARSET if you don't have libcharset.h
>>> +AC_CHECK_HEADER([libcharset.h],
>>> +[NO_LIBCHARSET=3D],
>>> +[NO_LIBCHARSET=3DYesPlease])
>>> +AC_SUBST(NO_LIBCHARSET)
>>> +#
>>> =C2=A0# Define NO_STRCASESTR if you don't have strcasestr.
>>> =C2=A0GIT_CHECK_FUNC(strcasestr,
>>> =C2=A0[NO_STRCASESTR=3D],
>>> diff --git a/gettext.c b/gettext.c
>>> index 8644098..902268c 100644
>>> --- a/gettext.c
>>> +++ b/gettext.c
>>> @@ -1,13 +1,17 @@
>>> =C2=A0#include "exec_cmd.h"
>>> =C2=A0#include <locale.h>
>>> =C2=A0#include <libintl.h>
>>> +#ifndef NO_LIBCHARSET
>>> +#include <libcharset.h>
>>> +#else
>>> =C2=A0#include <langinfo.h>
>>> +#endif
>>> =C2=A0#include <stdlib.h>
>>>
>>> =C2=A0extern void git_setup_gettext(void) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *podir;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *envdir =3D getenv("GIT_TEXTDOMAIND=
IR");
>>> - =C2=A0 =C2=A0 =C2=A0 char *charset;
>>> + =C2=A0 =C2=A0 =C2=A0 const char *charset;
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (envdir) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void)bindte=
xtdomain("git", envdir);
>>> @@ -20,7 +24,11 @@ extern void git_setup_gettext(void) {
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0(void)setlocale(LC_MESSAGES, "");
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0(void)setlocale(LC_CTYPE, "");
>>> +#ifndef NO_LIBCHARSET
>>> + =C2=A0 =C2=A0 =C2=A0 charset =3D locale_charset();
>>> +#else
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0charset =3D nl_langinfo(CODESET);
>>> +#endif
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0(void)bind_textdomain_codeset("git", cha=
rset);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0(void)setlocale(LC_CTYPE, "C");
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0(void)textdomain("git");
>>
>> Thanks for porting it to Windows. Some points:
>>
>> =C2=A0* Nit: Should be NEEDS_LIBCHARSET instead of NO_LIBCHARSET, al=
l the
>> =C2=A0 variables that set library inclusions in the Makefile use the
>> =C2=A0 NEED_* names.
>>
>
> That's not true, at least NO_OPENSSL, NO_PTHREADS, NO_ICONV,
> NO_LIBGEN_H, NO_MMAP and NO_SYS_SELECT_H use the NO_-prefix to includ=
e
> libraries (as opposed to the NEEDS_-prefix). And to be honest, I thin=
k
> the NEEDS_-prefix would be a lie in this case; we don't NEED it, we
> take advantage of it if it's there.
>
> To be honest, I just mimicked what was done for detection of gettext.
> Perhaps HAVE_LIBCHARSET_H would be the appropriate define? It's what
> we use for paths.h (HAVE_PATHS_H)...

You're right, a NO_* makes more sense here.

>> =C2=A0* Their patch compiles a program that includes libcharset.h an=
d
>> =C2=A0 compiles "const char* charset =3D locale_charset();". I don't=
 know if
>> =C2=A0 this is needed, or whether just checking the header name like
>> =C2=A0 you've done will do.
>>
>
> I don't think there's any point to it - libcharset.h is pretty much
> just about that one function. And if it turns out I'm wrong, we can
> add a check like that in the future.
>
>> =C2=A0* They also have a HAVE_LANGINFO_H define and fall back on jus=
t
>> =C2=A0 returning "", which works on GNU iconv. Maybe we should do th=
is
>> =C2=A0 too?
>>
>
> Perhaps, but can't that wait until we encounter a system that needs i=
t?

To both of the above: It's completely reasonable as-is, I just wanted
to mention it in case a list member knew of a reason to do it like GHC
did it. But just checking for the header will do fine until we
encounter issues with that.

> What's interesting there is what you say about GNU iconv handling "".
> This means that the minimal fix for Windows could be even smaller -
> we're using GNU iconv :)

Yeah, but probably better to do it by using libcharset.h instead.

>> I'm not sure about any of this, since I've just been testing on
>> Solaris, Linux and FreeBSD.
>
> I think Solaris, Linux, FreeBSD and Windows is a pretty wide selectio=
n
> of platforms, so I hope it should be pretty painless once this hits
> 'next'. Sure, there might be some platforms that needs a fix-up, but
> there always is with new code. And besides, there's even time to test
> more platforms before merging to 'next', no? :)

Yeah, I'm hoping it'll get into next soon so we can get more
reports/fixes like these. Anyway, I amended your patches a bit, here
are the changes:

 * Split up the s/char*/const char*/ change into its own patch, or is
   there a reason for why this needs to be there along with the
   libcharset.h change?

 * Added docs about the define to the Makefile

 * Added defaults for NO_LIBCHARSET to the default, I only changed the
   defaults for the MINGW entry, maybe it should be changed on Cygwin
   and Windows too? And probably on OpenBSD and NetBSD too.

Erik Faye-Lund (2):
  gettext: use const char* instead of char*
  gettext: use libcharset when available

 Makefile     |   17 +++++++++++++++++
 configure.ac |    6 ++++++
 gettext.c    |   10 +++++++++-
 3 files changed, 32 insertions(+), 1 deletions(-)

--=20
1.7.3.159.g610493
