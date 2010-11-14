From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 003/160] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Sun, 14 Nov 2010 22:42:57 +0100
Message-ID: <AANLkTim-j6TLwz0PugZvaEf1x3hW=76vT1gALC=w3DOu@mail.gmail.com>
References: <1289747245-23263-1-git-send-email-avarab@gmail.com>
	<1289747245-23263-3-git-send-email-avarab@gmail.com>
	<20101114181605.GI26459@burratino>
	<7vmxpb1ztf.fsf@alter.siamese.dyndns.org>
	<AANLkTinh_Nkxvw7Z5HU=TbJHHFRZeWgr0COJ+N96OeTd@mail.gmail.com>
	<20101114212757.GD10150@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 22:43:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHkLr-0007h4-SD
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 22:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329Ab0KNVnB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 16:43:01 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34601 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932319Ab0KNVnA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Nov 2010 16:43:00 -0500
Received: by fxm6 with SMTP id 6so1331867fxm.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 13:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yaMkBKz7RkbQ2BNk/rh0ZJYwrg/bpfTV7vgyK7bNVfc=;
        b=O679IA/k6ZYxr0h8SOPCXyOcACK5uhuUC3NzsunjUj/OUGjbbZ7WjAopIHBWqsP/ct
         kh37oW7kGntXYmxOVIi0otCtpWrrFcu9CIaX1aeuvKaufMIInCXbHvbyybLAhwrg0TAF
         9TxYoWDynXCfFNTsKeEwkXUfQVe99R/RQ96pE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wnxOF36MIoLYBMTSgNE66YuWbjZYGdFcyoUXqH6016+vYNuvrcpftNGOLTV6F62Ar/
         dEARO3n3BJ0vjUBJqCtSPhOxYJAr8u3tTIY6F2f/HPpzbCkWn06OFo27tXF/9smKVwRw
         GiPyu+H9nDMpEy6q1FAUqJmRceyzGt1hGuFlI=
Received: by 10.223.101.131 with SMTP id c3mr4038360fao.95.1289770978018; Sun,
 14 Nov 2010 13:42:58 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Sun, 14 Nov 2010 13:42:57 -0800 (PST)
In-Reply-To: <20101114212757.GD10150@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161448>

On Sun, Nov 14, 2010 at 22:27, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Thanks for the suggestion. I'll put it in envsubst/ then.
>>
>> Any idea about the issue of it being linked to too many things?
>
> Maybe http://thread.gmane.org/gmane.comp.version-control.git/160842
> is related?
>
>> tried to add another entry to this section:
>>
>> =C2=A0 =C2=A0 git-%$X: %.o $(GITLIBS)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $=
(ALL_LDFLAGS) $(filter
>> %.o,$^) $(LIBS)
>>
>> =C2=A0 =C2=A0 git-imap-send$X: imap-send.o $(GITLIBS)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $=
(ALL_LDFLAGS) $(filter %.o,$^) \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(LIBS) $(OPENSSL_LINK) $(=
OPENSSL_LIBSSL)
>>
>> But it wasn't actually used. But then again I don't know Makefile
>> hacking that much.
>
> If you send output from "make envsubst" from your attempt with V=3D1,
> I can try to debug it.

This is how it currently gets compiled:

    $ rm git-sh-i18n--envsubst sh-i18n--envsubst.o; make -j 5 all V=3D1
    gcc -o sh-i18n--envsubst.o -c   -g -O2 -Wall -I.  -DHAVE_PATHS_H
-DSHA1_HEADER=3D'<openssl/sha.h>'  -DNO_STRLCPY -DNO_MKSTEMPS
sh-i18n--envsubst.c
    gcc  -g -O2 -Wall -I.  -DHAVE_PATHS_H
-DSHA1_HEADER=3D'<openssl/sha.h>'  -DNO_STRLCPY -DNO_MKSTEMPS -o
git-sh-i18n--envsubst   sh-i18n--envsubst.o libgit.a xdiff/lib.a  -lz
-lcrypto -lpthread

I tried to remove some of those library includes. But it'll
complain. However if I do:

    diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
    index 8db71b1..7d4c870 100644
    --- a/sh-i18n--envsubst.c
    +++ b/sh-i18n--envsubst.c
    @@ -215 +215 @@ string_list_append (string_list_ty *slp, const char=
 *s)
    -      slp->item =3D (const char **) xrealloc (slp->item, nbytes);
    +      slp->item =3D (const char **) realloc (slp->item, nbytes);
    @@ -293 +293 @@ note_variable (const char *var_ptr, size_t var_len)
    -  char *string =3D xmalloc (var_len + 1);
    +  char *string =3D malloc (var_len + 1);
    @@ -368 +368 @@ subst_from_stdin ()
    -                     buffer =3D xrealloc (buffer, bufmax);
    +                     buffer =3D realloc (buffer, bufmax);
    @@ -402 +402 @@ subst_from_stdin ()
    -                     buffer =3D xrealloc (buffer, bufmax);
    +                     buffer =3D realloc (buffer, bufmax);

It'll compile stand-alone with no library includes at all. Maybe I
should just modify it to have basic versions of those two x* functions
so we can compile it completely stand-alone.
