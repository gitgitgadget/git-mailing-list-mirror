From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [WIP PATCH 0/5] support --exclude for diff/log commands
Date: Thu, 10 Mar 2011 14:03:57 +0700
Message-ID: <AANLkTimixVPGuZH9o6gkB7J=ZOmJ2PuitCH5HY8AnDe+@mail.gmail.com>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com> <7vmxl37bdp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 08:04:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxZvG-0005S4-QR
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 08:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689Ab1CJHEa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 02:04:30 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:32890 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242Ab1CJHE2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 02:04:28 -0500
Received: by wya21 with SMTP id 21so1184205wya.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 23:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=+aSe+y4WBqOkJeJrnsn1Jl7rQAHcT/JjB3ZKTra8Kwg=;
        b=rHMvGCEXRCKMuC+ino1+z7Ycq6NPaAhbHpJNryIru0nii0i+m5GDyDcshXKtJqroZq
         z/L87/5cBLV01Ybdh6K7JXoIxgW+LhSsVz6GuHWCpf3sDrWY4VPDv7kf8uFWXsg+++Ar
         1vzMDKuVfuDSeNbIUU4reObikDWb2u/fl/9Qw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cPavepQear92VaTaJcFgCcnBY+44+PkeOXAxaqCUbONUsC8hwn6sBW29ad9WaNVETC
         gA+76bhq5R0LR4ZycokUaBIhy7ojBuXtNHxhO2pyq98HWx2+76EqzLNQWFGef9CUljrz
         WbnV7p2gF1ulGoZfPrb+EW/wCuaw5Th2zDViY=
Received: by 10.216.87.8 with SMTP id x8mr6571896wee.46.1299740667146; Wed, 09
 Mar 2011 23:04:27 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Wed, 9 Mar 2011 23:03:57 -0800 (PST)
In-Reply-To: <7vmxl37bdp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168793>

2011/3/10 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> On the other hand, if we go with ':' as a mark of special pathspecs,=
 then
>>
>> =C2=A0- ":/" mark pathspecs relative to worktree root
>> =C2=A0- ":!" may mark negative pathspecs
>
> I am still moderately negative on this "negative pathspec" stuff, as =
it
> will complicate the semantics (just one example: would a path that is
> covered by both positive and negative pathspecs included or excluded?
> would the last one win? would the more specific one win?) and makes t=
he
> design harder to explain to the users. Depending on the semantics cho=
sen,
> it may also make the implementation less efficient and more complex.

The semantics resembles .gitignore, or at least that's my intention.
But yes, this kind of notion is more complex than simple '--exclude'
option, which would suit 90% cases, I guess.

> The two most important things to consider are to make sure that peopl=
e
> with funny pathnames can work it around by quoting, and the prefixing
> scheme is extensible so that other types of magic can later be introd=
uced
> with the same kind of escape hatch for people with funny pathnames th=
at
> begin with or contain new magic characters used to trigger the new ma=
gic.
>
> I said "something along the lines" above because ":/ for root, :! for
> negative" does not yet specify how the scheme would satisfy the above
> two consideration very well.

The quoting part may go through another painful migration plan if you
don't want to surprise users.

I have already suggested to reserve the next character after ':' (or
any char chosen as the magic one) as control character, for this
extensibility. Any unrecognized control character will be rejected.
Even if we limit ourselves to punctuation letters only, there's still
plenty room for future after '/' and '!' are taken.
--=20
Duy
