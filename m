From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: gettext CTYPE for libc
Date: Mon, 25 Nov 2013 14:20:38 +0700
Message-ID: <CACsJy8CMUMdzJyDABFj47oY8j8kKr5K88niXoM0o4dVQkWvkqA@mail.gmail.com>
References: <52900FD6.5020202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	git-malling-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 08:21:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkqTq-0000MU-Us
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 08:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810Ab3KYHVL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Nov 2013 02:21:11 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:64576 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab3KYHVJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Nov 2013 02:21:09 -0500
Received: by mail-qa0-f46.google.com with SMTP id f11so2700448qae.12
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 23:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ueIbfHv/576uKlf1nWLw/fn45VwIOfIp36D8169Jhpk=;
        b=XE3YJ2hIP7RvPQNYo9x3uX4IcykZCiwFggmh7zUytUo7gGgtdNOx2+Zg/cuHEnzDPY
         lct1aF2bjiHwyqxL5qHkpAtHFXd+6lF6KiTHqMgRADvc4GBsAkOxTlEnOdONOD7jLA+q
         MFbVDRBG7bxGzVBfWxTrbBJUp+Q/xEh+I3R/MXFEoT/y6Rfxv2LNX8uR9ZCH/h9WwP1J
         IspVDGv8eoa1OL6vNNbXR4+SRwuBO7swlnBIjaFYnrBNEtfMgXlhUe1jHDTRrGjVrMU+
         C3kT8vrA3s+dGT8Gha9S2EOjbeowUTCzlIu+jGmJPj3FD76Nmmn7rA275I3LweGfX5Bi
         wYXw==
X-Received: by 10.224.25.8 with SMTP id x8mr43173585qab.77.1385364068156; Sun,
 24 Nov 2013 23:21:08 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Sun, 24 Nov 2013 23:20:38 -0800 (PST)
In-Reply-To: <52900FD6.5020202@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238303>

Jonathan I see you participated in bug 6530, mentioned in the big
comment block in init_gettext_charset(). The bug seems fixed since
glibc 2.17. Do you think it's ok to revert the workaround if we detect
the running glibc is fixed (or if it does not run glibc at all)? I
think we could use gnu_get_libc_version() to detect it.

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=3D6530

On Sat, Nov 23, 2013 at 9:15 AM, Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <v=
nwildman@gmail.com> wrote:
> Hello,
>
> $ mkdir xyz
> $ cd xyz
> $ rmdir ../xyz
> $ git status
> fatal: Unable to read current working directory: Kh?ng c? t?p tin ho?=
c
> th? m?c nh? v?y
>
> So, somthing wrong with our charset.
>
> $ strace git status 2>&1 | grep open
> open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3
> open("/lib/i386-linux-gnu/libz.so.1", O_RDONLY|O_CLOEXEC) =3D 3
> open("/lib/i386-linux-gnu/libcrypto.so.1.0.0", O_RDONLY|O_CLOEXEC) =3D=
 3
> open("/lib/i386-linux-gnu/libpthread.so.0", O_RDONLY|O_CLOEXEC) =3D 3
> open("/lib/i386-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) =3D 3
> open("/lib/i386-linux-gnu/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D 3
> open("/dev/null", O_RDWR|O_LARGEFILE)   =3D 3
> open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE|O_CLOEXEC=
) =3D 3
> open("/usr/share/locale/locale.alias", O_RDONLY|O_CLOEXEC) =3D 3
> open("/usr/share/locale/vi_VN/LC_MESSAGES/libc.mo", O_RDONLY) =3D -1
> ENOENT (No such file or directory)
> open("/usr/share/locale/vi/LC_MESSAGES/libc.mo", O_RDONLY) =3D -1 ENO=
ENT
> (No such file or directory)
> open("/usr/share/locale-langpack/vi_VN/LC_MESSAGES/libc.mo", O_RDONLY=
) =3D
> -1 ENOENT (No such file or directory)
> open("/usr/share/locale-langpack/vi/LC_MESSAGES/libc.mo", O_RDONLY) =3D=
 3
> open("/usr/lib/i386-linux-gnu/gconv/gconv-modules.cache", O_RDONLY) =3D=
 3
>
> We will see, this string come from libc.mo
> $ gettext --domain=3Dlibc "No such file or directory"
> Kh=C3=B4ng c=C3=B3 t=E1=BA=ADp tin ho=E1=BA=B7c th=C6=B0 m=E1=BB=A5c =
nh=C6=B0 v=E1=BA=ADy
>
> in git's gettext.c, it not allow CTYPE=3D"" for all domain, so we wil=
l set
> this one individually. In this ex. I set it for libc:
>
> $ git diff
> diff --git a/gettext.c b/gettext.c
> index 71e9545..abd3978 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -115,6 +115,7 @@ static void init_gettext_charset(const char *doma=
in)
>         setlocale(LC_CTYPE, "");
>         charset =3D locale_charset();
>         bind_textdomain_codeset(domain, charset);
> +       bind_textdomain_codeset("libc", charset);
>         setlocale(LC_CTYPE, "C");
>  }
>
> And it work as I expect!
>
> --
> Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Duy
