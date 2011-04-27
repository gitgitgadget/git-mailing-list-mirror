From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] strbuf: allocate enough space when strbuf_setlen() is
 called first time
Date: Wed, 27 Apr 2011 07:12:53 +0700
Message-ID: <BANLkTi=vqgWgS2D2cD3Qwk1Z7_jqLarR3g@mail.gmail.com>
References: <1303820660-744-1-git-send-email-pclouds@gmail.com>
 <7vaafdexsp.fsf@alter.siamese.dyndns.org> <4DB738A1.8020706@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Apr 27 02:13:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEsNm-0006RP-5o
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 02:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127Ab1D0ANZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 20:13:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41967 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308Ab1D0ANY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 20:13:24 -0400
Received: by fxm17 with SMTP id 17so798479fxm.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 17:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=d40vvmBNetnlF3pqpyCDQDviBCUqeEAbMK1LvySmbSo=;
        b=sXHy2jK4QQmBVT2C8jJNNvWEIABVyBVnlGaAIjYZ4qNiqunWomyxxSlTwRp/znEzUf
         omXcO5FM4G29D8pUrt3o3/jfpyL9WxSI0Kz9LFIW0s6YZ9R3EsSnjh3hf9Rx1+kZAioE
         8rVY4e+aG0eRoAEM0IlBNJge0Q89zxV99Lf1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wpvR3/Pg+Sv6ad6cCRheDuhLaDloGr691mbbtObUnq4WlppTJ43GWobiNWHvtZEoDz
         3+PC4EUkdM7g/FNzU/C7p+kZ4nxJo7Cu8q+2hW2qd/PYAKyBZhu6e1PjUSHwWO4GhL+0
         yatAjpZMIIXaohlRVkfdxBgQHvv0C+ZMjHdVo=
Received: by 10.223.159.14 with SMTP id h14mr1531237fax.20.1303863203137; Tue,
 26 Apr 2011 17:13:23 -0700 (PDT)
Received: by 10.223.118.5 with HTTP; Tue, 26 Apr 2011 17:12:53 -0700 (PDT)
In-Reply-To: <4DB738A1.8020706@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172138>

2011/4/27 Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>:
> Am 26.04.2011 19:18, schrieb Junio C Hamano:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy<pclouds@gmail.com> =C2=A0w=
rites:
>>
>>> strbuf_grow(sb, 0) may allocate less than requested len and violate=
 the
>>> next assertion.
>>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy<pclouds@gm=
ail.com>
>>> ---
>>> =C2=A0 strbuf.h | =C2=A0 =C2=A02 +-
>>> =C2=A0 1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/strbuf.h b/strbuf.h
>>> index 07060ce..ab213da 100644
>>> --- a/strbuf.h
>>> +++ b/strbuf.h
>>> @@ -34,7 +34,7 @@ extern void strbuf_grow(struct strbuf *, size_t);
>>>
>>> =C2=A0 static inline void strbuf_setlen(struct strbuf *sb, size_t l=
en) {
>>> =C2=A0 =C2=A0 =C2=A0if (!sb->alloc)
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_grow(sb, 0);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_grow(sb, len);
>>> =C2=A0 =C2=A0 =C2=A0assert(len< =C2=A0sb->alloc);
>>
>> Wait. =C2=A0Isn't _setlen() meant to be used only to truncate at the=
 length,
>> and isn't that clearly documented?
>>
>> I don't think we need this patch at all.
>
> How about something like this instead? =C2=A0The call to strbuf_grow(=
) was
> introduced in a8f3e2219 when there was no strbuf_slopbuf buffer that
> nowadays makes sure we always have a place to write an initial NUL.
> We can take it out again now, simplifying the code and hopefully
> avoiding future confusion.
>
> =C2=A0strbuf.h | =C2=A0 =C2=A04 +---
> =C2=A01 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/strbuf.h b/strbuf.h
> index 07060ce..b157ede 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -33,9 +33,7 @@ static inline size_t strbuf_avail(const struct strb=
uf *sb) {
> =C2=A0extern void strbuf_grow(struct strbuf *, size_t);
>
> =C2=A0static inline void strbuf_setlen(struct strbuf *sb, size_t len)=
 {
> - =C2=A0 =C2=A0 =C2=A0 if (!sb->alloc)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_grow(sb, 0)=
;
> - =C2=A0 =C2=A0 =C2=A0 assert(len < sb->alloc);
> + =C2=A0 =C2=A0 =C2=A0 assert(len < (sb->alloc ? sb->alloc : 1));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sb->len =3D len;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sb->buf[len] =3D '\0';
> =C2=A0}
>
>

=46ine to me. I forgot the document, saw _grow and was under impression
that _setlen can grow too.
--=20
Duy
