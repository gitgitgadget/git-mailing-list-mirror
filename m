From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Let mailsplit and mailinfo handle mails with CRLF 
	line-endings
Date: Tue, 4 Aug 2009 22:57:36 +0200
Message-ID: <81b0412b0908041357he6056a3l78ebcec413a2e255@mail.gmail.com>
References: <4A7735B0.2040703@zytor.com>
	 <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com>
	 <7v7hxk5b4y.fsf@alter.siamese.dyndns.org>
	 <20090804172638.GA15136@blimp.localdomain>
	 <fabb9a1e0908041034y1a43fdf6nae14ec106a82f00c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 22:57:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYR4s-0005B5-5C
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 22:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbZHDU5i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2009 16:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754726AbZHDU5h
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 16:57:37 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:34610 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbZHDU5h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 16:57:37 -0400
Received: by bwz19 with SMTP id 19so3322633bwz.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 13:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5MJPzrlOFxEbqQlQn85sCfe69/j9O6eBUd87Es55QLE=;
        b=EUOu/HwUSJhVBzFDeZGRvFPAvi9GzL2RfaP4ZppiRWiXAPQJhK8MRwnTbC8xrKzhVh
         9EH++hhVd9HJiJQa4TYUrLa3boi7ONf+zbmoAGIo4A+VtxukcFATy0mRrWb1TcW0cFxZ
         w8YtQAFOt7ldIEfOYQDivExV6DsvpaVhIJF4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PXLJTFk0AdWWPYqWve9gPcrY1vbTTOA9Vk3rwN00enjbeuzmX0M+veE/jfqvfM7d3K
         n5ylTMJMBW3hcVg6Rwu41/3x5KWI4ePIrWO2zPd/pOUdKnndt/dvcB8qvNCSM+W+OCEd
         RL24lyUUqdgrQ6eU1hbMsfQeRkGYCiQpMGrR0=
Received: by 10.204.113.208 with SMTP id b16mr84924bkq.179.1249419456688; Tue, 
	04 Aug 2009 13:57:36 -0700 (PDT)
In-Reply-To: <fabb9a1e0908041034y1a43fdf6nae14ec106a82f00c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124808>

On Tue, Aug 4, 2009 at 19:34, Sverre Rabbelier<srabbelier@gmail.com> wr=
ote:
> On Tue, Aug 4, 2009 at 10:26, Alex Riesen<raa.lkml@gmail.com> wrote:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> + =C2=A0 =C2=A0 =C2=A0 if (len > 1 && buf[len - 2] =3D=3D '\r')
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[--len - 1] =3D=
 '\n';
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0buf[len] =3D '\0';
>
> How about something like:
>
> + =C2=A0 =C2=A0 =C2=A0 if (len > 1 && buf[len - 2] =3D=3D '\r' && (bu=
f[len - 1] =3D=3D '\n'
> || buf[len - 1] =3D=3D '\0'))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[--len - 1] =3D=
 '\n';
>
> To make sure that we're not erasing a \r somewhere in the middle of t=
he content?

I think this should be enough:

	if (c =3D=3D '\n' && len > 1 && buf[len - 2] =3D=3D '\r')
		buf[--len - 1] =3D '\n';

I'll resend.
