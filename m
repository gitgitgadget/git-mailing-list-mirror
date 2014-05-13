From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 2/8] unix-socket: stub impl. for platforms with no unix
 socket support
Date: Tue, 13 May 2014 13:59:53 +0200
Message-ID: <CABPQNSZAxyWJucyJbO0ND2X5V+cnCFCGLZPfFhygi2tUVQCXYg@mail.gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com> <1399979737-8577-4-git-send-email-pclouds@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 14:00:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkBNu-00052P-S9
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 14:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933006AbaEMMAf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 08:00:35 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:62765 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932962AbaEMMAe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 May 2014 08:00:34 -0400
Received: by mail-ie0-f170.google.com with SMTP id ar20so186263iec.29
        for <git@vger.kernel.org>; Tue, 13 May 2014 05:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=r5Hx1rbzMc1R9ImJkZ6qQEelBGmE1n3Fd84pM/EEjI8=;
        b=xSRIfrbh+O+GtHhhXdlwL3Wy/fNGIwDL8K6lSiX/lh2TKh/W0C7BW/Xai5BMrPolmG
         krUc3e+9TGaCMfcUczDVR48PQ5VqWP7arEV7QBu12udZ00qK+hm3Y2R/eRBGjxw2//N7
         vCNawOYTSWbSi4yjEhbcqB2ER59HJ1uW1nNsZAA6YzBaFcBvcYbsVVIqWgmG5BaVY/zk
         EMy/RztRXVHq7CS9DiO41UvBJC4q3Japzo4y0OQA05EDPkavk/DiD2+2ZW0WIlBXJCpC
         OGfbFtckBMBv45Jk9EASOVZfpyzkCyWnZ/HY0h6itkZX6XMc+g7CJCjoVBBy0dZZZmyB
         GYiQ==
X-Received: by 10.50.13.42 with SMTP id e10mr31873750igc.24.1399982434007;
 Tue, 13 May 2014 05:00:34 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Tue, 13 May 2014 04:59:53 -0700 (PDT)
In-Reply-To: <1399979737-8577-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248774>

On Tue, May 13, 2014 at 1:15 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> With this we can make unix_stream_* calls without #ifdef.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Makefile      |  2 ++
>  unix-socket.h | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 028749b..d0a2b4b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1417,6 +1417,8 @@ ifndef NO_UNIX_SOCKETS
>         LIB_H +=3D unix-socket.h
>         PROGRAM_OBJS +=3D credential-cache.o
>         PROGRAM_OBJS +=3D credential-cache--daemon.o
> +else
> +       BASIC_CFLAGS +=3D -DNO_UNIX_SOCKETS
>  endif
>
>  ifdef NO_ICONV
> diff --git a/unix-socket.h b/unix-socket.h
> index e271aee..f1cba70 100644
> --- a/unix-socket.h
> +++ b/unix-socket.h
> @@ -1,7 +1,25 @@
>  #ifndef UNIX_SOCKET_H
>  #define UNIX_SOCKET_H
>
> +#ifndef NO_UNIX_SOCKETS
> +
>  int unix_stream_connect(const char *path);
>  int unix_stream_listen(const char *path);
>
> +#else
> +
> +static inline int unix_stream_connect(const char *path)
> +{
> +       errno =3D ENOSYS;
> +       return -1;
> +}
> +
> +static inline int unix_stream_listen(const char *path)
> +{
> +       errno =3D ENOSYS;
> +       return -1;
> +}
> +
> +#endif
> +
>  #endif /* UNIX_SOCKET_H */

OK, so I missed this before my other two comments. But still... in
what way does errno=3DENOSYS make this *work*? Won't we end up compilin=
g
lots of non-functional tools on Windows in this case?
