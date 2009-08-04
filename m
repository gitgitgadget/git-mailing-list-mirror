From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Let mailsplit and mailinfo handle mails with CRLF 
	line-endings
Date: Tue, 4 Aug 2009 10:34:37 -0700
Message-ID: <fabb9a1e0908041034y1a43fdf6nae14ec106a82f00c@mail.gmail.com>
References: <4A7735B0.2040703@zytor.com> <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com> 
	<7v7hxk5b4y.fsf@alter.siamese.dyndns.org> <20090804172638.GA15136@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 19:35:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYNum-0001Q3-Jp
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 19:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933128AbZHDRe6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2009 13:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932928AbZHDRe6
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 13:34:58 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:11434 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932844AbZHDRe5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 13:34:57 -0400
Received: by ey-out-2122.google.com with SMTP id 9so15335eyd.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=jhHvK+0JXjBx+8BlMV/MPvDxP46WccLZp1DF+CnWO5s=;
        b=j1qC2K/ReF49tf+hYlH4vv/VRWavEoCeOmJaVGIGqpgD6ZVO7YIVui+uvgyq+WZ+W3
         6ZWFWSGGAgN14Cb2pmr4YAs9LyXqOmyZVbz+veoR9xpONb6Rqe2sHyIYqatLb0HwXdKG
         fTJYRjoteeHi0NpAQYGwqo1HuQxoj0IrXBgUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=k+7hs3vLlBIuzZj8lWFe6E9tjCdeuvKGBIyyeJUuM2KQUjojzraVq2IzMzstWiNUe1
         ROiVhsODL7kb9hqST/Pc/fMrIT1kMTgtsoh+A3LOiuEFLSoaNi3zloOjOKJKshBqcSZ/
         TSeCGG5B6uyUIQZSJb00ziG7+sj4qSy6t+kXI=
Received: by 10.216.90.74 with SMTP id d52mr1476577wef.51.1249407297115; Tue, 
	04 Aug 2009 10:34:57 -0700 (PDT)
In-Reply-To: <20090804172638.GA15136@blimp.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124799>

Heya,

On Tue, Aug 4, 2009 at 10:26, Alex Riesen<raa.lkml@gmail.com> wrote:
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 if (len > 1 && buf[len - 2] =3D=3D '\r')
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[--len - 1] =3D '\n';
> =A0 =A0 =A0 =A0buf[len] =3D '\0';

How about something like:

+       if (len > 1 && buf[len - 2] =3D=3D '\r' && (buf[len - 1] =3D=3D=
 '\n'
|| buf[len - 1] =3D=3D '\0'))
+               buf[--len - 1] =3D '\n';

To make sure that we're not erasing a \r somewhere in the middle of the=
 content?

--=20
Cheers,

Sverre Rabbelier
