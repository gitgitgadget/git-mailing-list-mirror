From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: [PATCH] Add "core.eol" variable to control end-of-line conversion
Date: Sun, 16 May 2010 06:39:57 -0400
Message-ID: <AANLkTin-KO8n591Hz7BuJCaHCe4osfCvUhH4ua0beyXt@mail.gmail.com>
References: <alpine.LFD.2.00.1005141421560.3711@i5.linux-foundation.org>
	 <1273956445-67531-1-git-send-email-eyvind.bernhardsen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 12:40:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODbGQ-00088P-Fo
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 12:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab0EPKkA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 May 2010 06:40:00 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57263 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab0EPKj7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 May 2010 06:39:59 -0400
Received: by wyb36 with SMTP id 36so990412wyb.19
        for <git@vger.kernel.org>; Sun, 16 May 2010 03:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ag/8GOULpDZi+8uYMwtJmWhhvo9VGGPq2JAtsPPnGvY=;
        b=GWb0wFHRhRGYnCxHzmu9BlrKD7YPPB6nS5EeqG0VYRWjUzL0gIsRPsSOl+aod1HArV
         jX27ytDBCVr5A0qlX8X5CRQoeL6pWSzmXDnJAmC+tsEewFj6VnmwK6h24fRXTcw6BVit
         uvlZE4iZQRKJsycvRAmx3ZrBnNLUFmiyHhSiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MqZ/WlBcNLpJTHdTaHn43/cuugsJ9qr46vnRJOmhqKdjdaa04AEYbveIw8qD+pfenR
         zighKNXW+8jdHvumd5S1qDFp5cYDmuuy9ySwazlALIsTMtzMDUQCCNzS66fB+TAUS5yW
         JQDSvvZhS9OV4nKOAAWwt5WTU+D65PfM72oe4=
Received: by 10.216.172.202 with SMTP id t52mr2228329wel.21.1274006397353; 
	Sun, 16 May 2010 03:39:57 -0700 (PDT)
Received: by 10.216.7.207 with HTTP; Sun, 16 May 2010 03:39:57 -0700 (PDT)
In-Reply-To: <1273956445-67531-1-git-send-email-eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147185>

On Sat, May 15, 2010 at 4:47 PM, Eyvind Bernhardsen
<eyvind.bernhardsen@gmail.com> wrote:
> Introduce a new configuration variable, "core.eol", that allows the u=
ser
> to set which line endings to use for end-of-line-normalized files in =
the
> working directory. =C2=A0It defaults to "native", which means CRLF on=
 Windows
> and LF everywhere else.
>
> For backwards compatibility, "core.autocrlf" will override core.eol i=
f
> core.eol is left unset. =C2=A0This means that
>
> [core]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0autocrlf =3D true
>
> will give CRLFs in the working directory even on platforms with LF as
> their native line ending.
>
> If core.eol is set explicitly (including setting it to "native"), it
> will override core.autocrlf so that
>
> [core]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0autocrlf =3D true
> =C2=A0 =C2=A0 =C2=A0 =C2=A0eol =3D lf
>
> normalizes all files that look like text, but does not put CRLFs in t=
he
> working directory.
>
> Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
> ---
>
> It turns out that my resistance to "core.eol" was mostly laziness, so=
 I
> just implemented it.
>
> I decided that "core.autocrlf" has to override the native line ending=
 if
> "core.eol" isn't set explicitly, which gives some extra complexity in
> convert.c.
>
> For 1.8 I would consider making core.autocrlf just turn on normalizat=
ion
> and leave the working directory line ending decision to core.eol, but
> that _will_ break people's setups.
>
> Patch is on top of my latest series.
> --
> Eyvind

Looking forward to this change. In terms of usability it is really
nice. Eager to see it in a release.
