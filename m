From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] diff: add a special SYMLINK user-diff driver
Date: Wed, 22 Sep 2010 00:39:11 +0000
Message-ID: <AANLkTiktGT6aLN261FmXa4DeXX9+DNdFLX4_nFvNHCHW@mail.gmail.com>
References: <20100921205914.GA1166@sigill.intra.peff.net>
	<20100921211303.GB1188@sigill.intra.peff.net>
	<AANLkTi=zSPegcPNY8jr4S5qeXWHrxuC+0SY-h5EhyA+6@mail.gmail.com>
	<20100922003049.GA23931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?Q?Cl=C3=A9ment_Poulain?= <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 22 02:39:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyDMk-0003cq-7v
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 02:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636Ab0IVAjN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Sep 2010 20:39:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36483 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620Ab0IVAjN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 20:39:13 -0400
Received: by fxm3 with SMTP id 3so8319fxm.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 17:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fd5TO6uIE/13+NSJrLS3cg+yQGyxO2jv5DHco5N6KBs=;
        b=CofNlCx5rtysPWoT7+0v9R5br+XRYYpPGbQu8FVveONXBAD1wGiFCID2+y/gPhwOqd
         HU9Z8LfOLuiGick/zuVk4ANZPsViYVBx9gM0eB4Ae1O4dVVWimFLkSOdxP8irWKBU3pr
         fQRq6YPPYknrhuf7RqHr0LL+H49QDtuJ+GVyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u3WSyPVxfJXLLCJl0agbYUeSqQV5OXDqz3njLWq0BpH2YIYoWN+oJFAisH8Lt20MPn
         J525xeyb6xhTzQDmx0PnZ6YzVLTI6F9ADRBu8Px5jRtW2tm6/I8j0TruCgtYfrpGUfTU
         FNMLKyfN8wk3miv3oEvA//h73S7v5jOFVIYik=
Received: by 10.223.121.208 with SMTP id i16mr7023277far.46.1285115951600;
 Tue, 21 Sep 2010 17:39:11 -0700 (PDT)
Received: by 10.223.119.144 with HTTP; Tue, 21 Sep 2010 17:39:11 -0700 (PDT)
In-Reply-To: <20100922003049.GA23931@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156778>

On Wed, Sep 22, 2010 at 00:30, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 22, 2010 at 12:12:30AM +0000, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> 2010/9/21 Jeff King <peff@peff.net>:
>> > +However, it may happen that you do want to change the diff parame=
ters
>> > +specifically for symlinks. You can do that by configuring the spe=
cial
>> > +"SYMLINK" diff driver. For example, to add a newline to the end o=
f
>> > +the symlink contents (and suppress the usual "no newline at end o=
f file"
>> > +warning), you could configure:
>> > +
>> > +-----------------------------
>> > +[diff "SYMLINK"]
>> > + =C2=A0 =C2=A0 =C2=A0 textconv =3D perl -pe 's/$/\n/'
>> > +-----------------------------
>>
>> That'll turn every \n in the stream into \n\n, not add a newline to
>> the end of the file. Don't you mean:
>>
>> =C2=A0 =C2=A0 perl -0666 -pe 's/$/\n/'
>
> Yeah, it will add a newline to the end of file, but it will also doub=
le
> existing newlines. I wanted something short and clear so the reader
> could understand what was going on, and symlink paths don't generally
> contain an extra newline.
>
> Just "perl -0pe 's/$/\n/'" would work, as symlink targets can't possi=
bly
> have embedded NULs.
>
> But:
>
>> Or, more efficiently:
>>
>> =C2=A0 =C2=A0 perl -ple 'END { print }'
>
> That one is even more readable, IMHO. But it isn't right. :)
> The automatic line-handling actually adds the missing newline, so I
> think it would have to be:
>
> =C2=A0perl -ple ''

    perl -ple1

:)
