From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Set hard limit on delta chain depth
Date: Tue, 6 Dec 2011 13:41:38 +0100
Message-ID: <CABPQNSbOvVkSFAE32hXoZEZeHqg-+nHc93uGytfCPQMicu0uVg@mail.gmail.com>
References: <1323068688-31481-1-git-send-email-pclouds@gmail.com>
 <CABPQNSaE=TWGbBRMnthEuT181=XbOafPfgx88_JQnnQ6TiYyqw@mail.gmail.com> <CACsJy8BuUn4htSR6jAJfbueOshE6-YVV5dZGSWTGXbkuA0HO=A@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 13:42:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXuLp-0006U7-JR
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 13:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933140Ab1LFMmV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 07:42:21 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60089 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933130Ab1LFMmU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 07:42:20 -0500
Received: by qcqz2 with SMTP id z2so2119422qcq.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 04:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=PxnWonmGh9JLPGVbgq9XIEq5gWc1lts1OMpGCeIhNOQ=;
        b=gSmiAHzkPraA9BeWDu+mL1vreE9RwBJQLDyxyUx8HNgbgUU6f9Yzesy7VhXwNqLjb9
         a8iHA+hrz9+I4B/7eySqBk/a6xAk4tZET+PnAOMEKnsGdbBw/iyHZ0gWnHxnMffzTew0
         xUpyZYnc4LU6CmLDgGaSrARJh6ODzplmXFYcM=
Received: by 10.68.73.66 with SMTP id j2mr1023623pbv.3.1323175339267; Tue, 06
 Dec 2011 04:42:19 -0800 (PST)
Received: by 10.68.21.39 with HTTP; Tue, 6 Dec 2011 04:41:38 -0800 (PST)
In-Reply-To: <CACsJy8BuUn4htSR6jAJfbueOshE6-YVV5dZGSWTGXbkuA0HO=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186346>

On Tue, Dec 6, 2011 at 1:32 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
> 2011/12/6 Erik Faye-Lund <kusmabite@gmail.com>:
>> 2011/12/5 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>:
>>> Too deep delta chains can cause stack overflow in get_base_data(). =
Set
>>> a hard limit so that index-pack does not run out of stack. Also sto=
p
>>> people from producing such a long delta chains using "pack-object
>>> --depth=3D<too large>"
>>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>> =C2=A0I used to make very long delta chains and triggered this in i=
ndex-pack.
>>> =C2=A0I did not care reporting because it's my fault anyway. Think =
again,
>>> =C2=A0index-pack is called at server side and a malicious client ca=
n
>>> =C2=A0trigger this. This patch does not improve the situation much,=
 but at
>>> =C2=A0least we won't get sigsegv at server side.
>>>
>>
>> Wouldn't it make more sense to make the limit a config option rather
>> than a hard-coded value of 128 (which seems arbitrary to me)? After
>> all, different platforms have different stack-limitations...
>
> Then it'd make more sense to make a compile time config based on
> platform.

Can how much stack each recursion use be calculated at compile-time?
If so, I agree with you.

> We could have a config option that can override the default,
> but I really don't see the point of making long delta chains.

Aha, I figured you _did_ see a point in this, because 128 seemed
excessive to me already. I was thinking more that some platforms can
have a much smaller stack than (I would expect to) fit in 128
recursions (I've worked relatively recently with platforms with as
small as a static 2k stack per process), so you might not be fixing
the issue for such platforms. But that's not really your
responsibility either ;)
