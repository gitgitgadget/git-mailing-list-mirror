From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] pathspec: rename per-item field has_wildcard to use_wildcard
Date: Thu, 7 Apr 2011 20:00:11 +0700
Message-ID: <BANLkTinkdR4gg1=z-b4941Pppfsg+CgD-g@mail.gmail.com>
References: <7vr59gl581.fsf@alter.siamese.dyndns.org> <BANLkTikJ3=H_OgcNueMjnwwQ2W-2kamf=w@mail.gmail.com>
 <7vfwpvjobl.fsf@alter.siamese.dyndns.org> <4D9D9B60.4030404@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 07 15:00:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7opS-0006as-B4
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 15:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066Ab1DGNAn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Apr 2011 09:00:43 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61975 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755551Ab1DGNAm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 09:00:42 -0400
Received: by bwz15 with SMTP id 15so1975304bwz.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 06:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=6khZ3EkBzss3+/qJ/rTT7gdHYKOCI2GlaXeI3iFiPPk=;
        b=e7iG2n9LY2qkXlPV1F3zs+3Udgcuh/g4MfLLGSdHaTXuGp+hiEL7GZTSub3GEHQT/U
         LFRpFDUrhYnRmVlDSHTrFdRpFvp7xfQPqbPEOy/fvxW/B7RWs3qIJuFobV6C9BReX9sh
         4UYGX/OcbFbJyTWZqac9wfuDDFxghmDQj9ydA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HhTE7/BZ61mECeaNi98WuiWYTmbmGShf6WaJKI3vsMsacfV3UIqJq1wxErEt3QuGGO
         TpkhuBhEbQhydZOLx5jYhQPIa8cgkxTKv+4aaVTm1Pwx7UJHG/r3zvgAylT8LWLXZ08w
         NWp88r0z39fibn2Upmkeif3yOdSxWmrqnQ9q0=
Received: by 10.204.143.4 with SMTP id s4mr700447bku.98.1302181241101; Thu, 07
 Apr 2011 06:00:41 -0700 (PDT)
Received: by 10.204.37.195 with HTTP; Thu, 7 Apr 2011 06:00:11 -0700 (PDT)
In-Reply-To: <4D9D9B60.4030404@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171056>

On Thu, Apr 7, 2011 at 6:09 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Junio, we're in rc phase ;)

He was excited. It's good, we may get this feature sooner :)

>> =C2=A0(2) Colon, open parenthesis, a comma separated list of words t=
o name
>> =C2=A0 =C2=A0 =C2=A0magic, close parenthesis, followed by the path, =
e.g. these are the
>> =C2=A0 =C2=A0 =C2=A0long-hand counterparts to the examples in (1)
>>
>> =C2=A0 =C2=A0 =C2=A0- ":(top)hello.c"
>> =C2=A0 =C2=A0 =C2=A0- ":(top,noglob)hello.c"
>> =C2=A0 =C2=A0 =C2=A0- ":(noglob,top)hello.c"
>> =C2=A0 =C2=A0 =C2=A0- ":(noglob,top):hello.c"
>> =C2=A0 =C2=A0 =C2=A0- ":()hello.c"
>>
>
> Do we need the parentheses? I guess we need them to have the magic st=
art
> with a non-alpha, otherwise we could do with ":top,noglob:hello.c"
> (which I like but breaks those with a file named ":top:hello.c").

That has something to do with "easy to parse and catch error", I
think. At the moment ":hello/:world" is interpreted as "hello/:world".
Without parentheses, we need to look further for colon and may
accidentally misinterpret it.

> What about these:
>
> :/(noglob)hello.c
> :(top)!hello.c
>
> I.e. do we allow combinations?

I think we should. I don't like typing long pathspecs, just because
only remember mnemonic for "top" and happen to need "noglob" too.

> It seems you accept to break people with files named ":(top)hello.c" =
but
> not those with files named ":top:hello.c". Which is OK if it's a
> conscious decision, of course.

At least once we agree on colon being the magic introducer and general
rules, we can do these earlier in 1.7.x

 - warn people that ":hello.c" may change semantics in future
 - recommend to escape ("::hello.c" instead of ":hello.c")
--=20
Duy
