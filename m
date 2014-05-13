From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 4/8] Add read-cache--daemon for caching index and related stuff
Date: Tue, 13 May 2014 13:56:14 +0200
Message-ID: <CABPQNSatvV7X97j_+V52-cQ4t5qHx-Ho+R1bq63CGorg4gPhAg@mail.gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com> <1399979737-8577-7-git-send-email-pclouds@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 13:57:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkBKN-0007cA-DY
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 13:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759541AbaEML44 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 07:56:56 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:44847 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbaEML4z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 May 2014 07:56:55 -0400
Received: by mail-ig0-f169.google.com with SMTP id hl10so5797693igb.0
        for <git@vger.kernel.org>; Tue, 13 May 2014 04:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=mTTf34nNeuEyJhRGkWOLYkv6InHyxMdhxZr954UN9+8=;
        b=vcQGNgdl9hCnGVbqH/mbGRlDQ5pgn4+uh6acY39tTtdpl0yFxFHKoxaF12i05sMwYI
         f/r5JMQYIzxa7v85/axb1g8SO3vTibWF/ZG+V82rz/TBntasfx4FmXW9GQkevVTUM+6y
         LkL0yY8hx2icX+kFXLKWZXV3NYY2/YL4NAMN/0crbstQBL2yVQazwZ0hJZt15Dam+qd6
         wS5edheHNazhY4tLbPQ3VjpMAndHCVEL9MNWfA7a5hBAPj1x7YYHAFVf8tW4WAlCrjWY
         a/wDzWaiRlcbBfUIc+Mcc3mFUe4eHowknRjwDeK4ogCyRQk1rHsnCnyjEOmJ3FVWivVN
         fMWQ==
X-Received: by 10.50.85.37 with SMTP id e5mr54542039igz.43.1399982214855; Tue,
 13 May 2014 04:56:54 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Tue, 13 May 2014 04:56:14 -0700 (PDT)
In-Reply-To: <1399979737-8577-7-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248773>

On Tue, May 13, 2014 at 1:15 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> diff --git a/Documentation/git-read-cache--daemon.txt b/Documentation=
/git-read-cache--daemon.txt
> new file mode 100644
> index 0000000..1b05be4
> --- /dev/null
> +++ b/Documentation/git-read-cache--daemon.txt
> @@ -0,0 +1,27 @@
> +git-read-cache--daemon(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +git-daemon - A simple cache server for speeding up index file access
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git daemon' [--detach]
> +

Huh, "git daemon" can't be right...

> diff --git a/Makefile b/Makefile
> index d0a2b4b..a44ab0b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1504,6 +1504,12 @@ ifdef HAVE_DEV_TTY
>         BASIC_CFLAGS +=3D -DHAVE_DEV_TTY
>  endif
>
> +ifdef HAVE_SHM
> +       BASIC_CFLAGS +=3D -DHAVE_SHM
> +       EXTLIBS +=3D -lrt
> +       PROGRAM_OBJS +=3D read-cache--daemon.o
> +endif

I think this also needs to be protected against NO_UNIX_SOCKETS
