From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 07/17] gettext.c: work around us not using
 setlocale(LC_CTYPE, "")
Date: Tue, 31 Aug 2010 16:51:47 +0000
Message-ID: <AANLkTi=+oGVx_T_-0T0RTqe+rV4QwQakjXUXKk8tddFL@mail.gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
	<1283203703-26923-8-git-send-email-avarab@gmail.com>
	<20100831151800.GG2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 18:51:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqU3v-0004WI-Pb
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 18:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827Ab0HaQvv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 12:51:51 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45112 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589Ab0HaQvu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 12:51:50 -0400
Received: by gwj17 with SMTP id 17so2624811gwj.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YzNy4BEYROK3zcuJwwUJOrZSRKIKA4UcrTsbDAJaq7o=;
        b=O7LMaripouh97hNkshbcNAkdYfvvIlRKigOj8HnPsZb9k/YNsbDvrKllRYFc5aUbQc
         GpYV8IXvUlSwgW7GLDjPYWobvDj5MXRY1e8M8yarXau6c/TMfsNWZKvT6ZuhzkYNYrd6
         u25NbMcM4wpNe6EUl69w3fkfvjLfikUvS+pjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Y2lKN9H8+0TkcJwtbb/uSTjKk6dmD7ZXB2FSZQznPBpkGZOIXnU53ZhfVUlXnWEE+u
         /H1MgQK0uPpY/xCbD/LIlzsi/bmK+/NWjA3QD00LR5RWhTQw4TeaEFrK6ZFe6Gli3x8p
         sPv91IMSiV8YJgqVo8pwp1Tz3lL920TE2oic0=
Received: by 10.229.87.141 with SMTP id w13mr4323093qcl.210.1283273508279;
 Tue, 31 Aug 2010 09:51:48 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 31 Aug 2010 09:51:47 -0700 (PDT)
In-Reply-To: <20100831151800.GG2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154938>

On Tue, Aug 31, 2010 at 15:18, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> In 107880a I removed our use of setlocale(LC_CTYPE, "") because of a
>> bug in the GNU C Library [1]
>
> Future readers might benefit from a reminder that it is vsnprintf tha=
t
> is broken.

I'll work something in about that.

> Aside, not about this patch: glibc printf can be very convenient for
> translators, because of format strings like "%4$s". =C2=A0Do other co=
mmon
> platforms like FreeBSD and Mingw have something similar?

I certainly hope so. I was planning on documenting its usage,
Johannes?

>> --- a/gettext.c
>> +++ b/gettext.c
>> @@ -17,5 +19,9 @@ extern void git_setup_gettext(void) {
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 (void)setlocale(LC_MESSAGES, "");
>> + =C2=A0 =C2=A0 (void)setlocale(LC_CTYPE, "");
>> + =C2=A0 =C2=A0 charset =3D nl_langinfo(CODESET);
>> + =C2=A0 =C2=A0 (void)bind_textdomain_codeset("git", charset);
>> + =C2=A0 =C2=A0 (void)setlocale(LC_CTYPE, "C");
>
> For the curious: we cannot use
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0setlocale(LC_CTYPE, "");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0charset =3D nl_langinfo(CODESET);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0setlocale(LC_CTYPE, "C");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bind_textdomain_codeset("git", charset);
>
> because nl_langinfo returns a pointer to a static buffer that might
> be wiped out by setlocale() iirc.

But I'm hopefully sidestepping that issue by passing it to
bind_textdomain_codeset() right away.
