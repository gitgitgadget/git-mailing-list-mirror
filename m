From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/7] revert: Allow mixed pick and revert instructions
Date: Sun, 14 Aug 2011 19:36:03 +0530
Message-ID: <CALkWK0=sggexB0HDN-6LsoLz2RO-ftABTnAYp7q-jVO0oCJu2A@mail.gmail.com>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-5-git-send-email-artagnon@gmail.com> <20110814121244.GD18466@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 16:06:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsbKf-000400-9J
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 16:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395Ab1HNOGZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Aug 2011 10:06:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35366 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab1HNOGY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2011 10:06:24 -0400
Received: by wyg24 with SMTP id 24so3027957wyg.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 07:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=k491VgvPqLm+pTau+h6dXeawo4Hw7tan5Mmsv80oo8Q=;
        b=E0wWmfXad4WQINIfrexRghR0jBkPS0ysbgI3QSkwRU1GvwR9iWL7sIozY+/mI/RUyt
         x2Gh7JDrAmLlhGPyYhA59zthu8APuCBPHbTBl5O4W+Jkeiwr92XbI58n6EJi9O11VI5i
         7TbOrMRuBViM13IgZQ6Z78ZSZY/Sn2WU63fWs=
Received: by 10.216.231.210 with SMTP id l60mr1249521weq.63.1313330783082;
 Sun, 14 Aug 2011 07:06:23 -0700 (PDT)
Received: by 10.216.172.132 with HTTP; Sun, 14 Aug 2011 07:06:03 -0700 (PDT)
In-Reply-To: <20110814121244.GD18466@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179326>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D strchrnul(p,=
 '\n') - p;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len > 255)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 len =3D 255;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error(_("Unrecogn=
ized action: %.*s"), len, p);
>
> What happens if the current line has more than INT_MAX characters?

I don't know!  I don't think this behavior is defined by the C89
standard, so I'd expect every compiler to do something different.  I'd
expect to be able to fix it like this:

int len =3D strchrnul(p, '\n') - p;
if (len > 255 || len - strchrnul(p, '\n') + p !=3D 0)
    len =3D 255;

> Maybe it would make sense to factor out a function for this
> computation, for brevity and so there is just one place to tweak.

Shouldn't it be part of error() atleast in the long term?  I'll write
a quick private helper for now.

Thanks.

-- Ram
