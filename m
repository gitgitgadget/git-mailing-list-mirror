From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCHv3 3/5] Add a common is_gitfile function
Date: Thu, 6 Oct 2011 13:59:12 +1100
Message-ID: <CACsJy8C1yHYn8b85ia5SB9UfRBrpMT=xYkSmN4EjOoKP3xx_6w@mail.gmail.com>
References: <4E8C5CC2.4030505@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 04:59:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBeBf-0004Cr-2c
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 04:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758147Ab1JFC7o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 22:59:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35388 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758128Ab1JFC7n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2011 22:59:43 -0400
Received: by bkbzt4 with SMTP id zt4so2878241bkb.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 19:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=BBoBjwqB/K7iwLSmmVUGqPh7CG7PAJpn/a10vm+RQso=;
        b=o3iZn0ECoVrRNIgAbMpZRkMpqwC21u/z0wEQlt5brPkuTwPu57ShPA3RFIgNY8h2Rm
         PSNDxhLuH5YFBMhcOU9Z3Y/q0a3ozJ10sqnIrvQ/LcFEbFNUd2a5g0+fFDXjycaMBhrS
         ayzpq3Z0utuWeuZy7ramV+2maJ33M6huMabmM=
Received: by 10.204.152.201 with SMTP id h9mr158777bkw.147.1317869982171; Wed,
 05 Oct 2011 19:59:42 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Wed, 5 Oct 2011 19:59:12 -0700 (PDT)
In-Reply-To: <4E8C5CC2.4030505@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182920>

On Thu, Oct 6, 2011 at 12:33 AM, Phil Hord <hordp@cisco.com> wrote:
> diff --git a/setup.c b/setup.c
> index 61c22e6..a3d5a41 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -358,7 +358,7 @@ const char *read_gitfile(const char *path)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (stat(path, &st))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
> - =C2=A0 =C2=A0 =C2=A0 if (!S_ISREG(st.st_mode))
> + =C2=A0 =C2=A0 =C2=A0 if (!is_gitfile(path))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDONLY);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd < 0)
> @@ -368,9 +368,6 @@ const char *read_gitfile(const char *path)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len !=3D st.st_size)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die("Error rea=
ding %s", path);
> - =C2=A0 =C2=A0 =C2=A0 buf[len] =3D '\0';
> - =C2=A0 =C2=A0 =C2=A0 if (prefixcmp(buf, "gitdir: "))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Invalid gitfi=
le format: %s", path);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while (buf[len - 1] =3D=3D '\n' || buf[len=
 - 1] =3D=3D '\r')
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len--;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len < 9)

I think you are changing the behavior here. Currently if .git is a
file and not a valid gitfile, die() will be called and repo discovery
process stops. With your patch, it skips invalid .git files and moves
on.

I'm not saying it's good or bad, just pointing out.
--=20
Duy
