From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] fix hang in git fetch if pointed at a 0 length bundle
Date: Tue, 3 Jan 2012 19:07:53 +0700
Message-ID: <CACsJy8B5B2bx7WK7ViziseuWCPaMgcc-avwtsw2DybRme8Vgfg@mail.gmail.com>
References: <20120103011352.GA13825@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, spearce@spearce.org
To: Brian Harring <ferringb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 13:08:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri3AL-0003GA-RH
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 13:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792Ab2ACMI0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jan 2012 07:08:26 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50894 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab2ACMIZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jan 2012 07:08:25 -0500
Received: by eaad14 with SMTP id d14so8590394eaa.19
        for <git@vger.kernel.org>; Tue, 03 Jan 2012 04:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=wEqOkwRJ4NfNstJe75N/KRRen7bfG84j4s5i3OzVpNY=;
        b=oh8f7mF3z6pWe7SLzn7mhehNyRM8113Z4V3HXgkPX99Ck3mzjxaV1aEXzgjXsgsUNL
         Ic0uRbpuN3cjlvF7fV8LqmFHYb3cjnVlhmlgepHk4avXEKg8+V0z8MusnLS6R+3Nu0R2
         V7w3Wijbye5IYJX96OeLmv4b3MKa4Sy373FW8=
Received: by 10.204.151.75 with SMTP id b11mr11967881bkw.26.1325592504204;
 Tue, 03 Jan 2012 04:08:24 -0800 (PST)
Received: by 10.204.32.197 with HTTP; Tue, 3 Jan 2012 04:07:53 -0800 (PST)
In-Reply-To: <20120103011352.GA13825@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187860>

On Tue, Jan 3, 2012 at 8:13 AM, Brian Harring <ferringb@gmail.com> wrot=
e:
> @@ -31,7 +31,7 @@ static int strbuf_readline_fd(struct strbuf *sb, in=
t fd)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while (1) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char ch;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t len =3D=
 xread(fd, &ch, 1);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len < 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len <=3D 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return -1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_addch(s=
b, ch);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ch =3D=3D =
'\n')

I think it should return 0 when len =3D=3D 0 because strictly speaking =
eof
is not a fault. It's not really important though because the two
callers in this file work fine either way.

=46WIW I went through all xread call sites. All seem to handle return
value <=3D 0 correctly.
--=20
Duy
