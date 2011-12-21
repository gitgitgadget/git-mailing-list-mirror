From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 4/4] Suppress "statement not reached" warnings under Sun Studio
Date: Wed, 21 Dec 2011 20:03:47 +0100
Message-ID: <CACBZZX4htZRQH+2xvoskwE7KoTz98Ox-3xQf0hyEbbFDYCZYHw@mail.gmail.com>
References: <1324430302-22441-1-git-send-email-avarab@gmail.com>
 <1324430302-22441-5-git-send-email-avarab@gmail.com> <7vvcp9hjam.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jason Evans <jasone@canonware.com>,
	David Barr <david.barr@cordelta.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 20:04:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdRSa-0001b3-N7
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 20:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227Ab1LUTEL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Dec 2011 14:04:11 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58409 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557Ab1LUTEJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Dec 2011 14:04:09 -0500
Received: by eaad14 with SMTP id d14so1408100eaa.19
        for <git@vger.kernel.org>; Wed, 21 Dec 2011 11:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ciFE2vQzlt75+NMoVHLA26zY9cY2QKS3oUhaS5dINaE=;
        b=opo/PsMa+VB6rbl4U5TFdiddNnQJ4BV4uDYvAXNj3fb75bK2L7qu/hJYct60qEXuQJ
         TkccMVhFoojx9FIH+47LnsFVbymXDcRWJyMkBn5mDylneXYV+gIekVkC3Y+OTdc60I1F
         3OFraaqWFEu2bFlTcO2u2KWq5z59D9X5q0Gd0=
Received: by 10.204.153.15 with SMTP id i15mr2368227bkw.43.1324494248416; Wed,
 21 Dec 2011 11:04:08 -0800 (PST)
Received: by 10.204.181.83 with HTTP; Wed, 21 Dec 2011 11:03:47 -0800 (PST)
In-Reply-To: <7vvcp9hjam.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187579>

On Wed, Dec 21, 2011 at 19:27, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> diff --git a/read-cache.c b/read-cache.c
>> index a51bba1..0a4e895 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -758,7 +758,13 @@ int verify_path(const char *path)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>>
>> =C2=A0 =C2=A0 =C2=A0 goto inside;
>> +#ifdef __sun
>> +# =C2=A0 =C2=A0pragma error_messages (off, E_STATEMENT_NOT_REACHED)
>> +#endif
>> =C2=A0 =C2=A0 =C2=A0 for (;;) {
>> +#ifdef __sun
>> +# =C2=A0 =C2=A0pragma error_messages (on, E_STATEMENT_NOT_REACHED)
>> +#endif
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!c)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return 1;
>
> Patches 1-3 makes sense, but this one is too ugly to live.
>
> Wouldn't something like this be equivalent and have the same effect
> without sacrificing the readablity?
>
> diff --git a/read-cache.c b/read-cache.c
> index a51bba1..73af797 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -757,12 +757,12 @@ int verify_path(const char *path)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (has_dos_drive_prefix(path))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> - =C2=A0 =C2=A0 =C2=A0 goto inside;
> + =C2=A0 =C2=A0 =C2=A0 /* we are at the beginning of a path component=
 */
> + =C2=A0 =C2=A0 =C2=A0 c =3D '/';
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (;;) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!c)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_dir_sep=
(c)) {
> -inside:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0c =3D *path++;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if ((c =3D=3D '.' && !verify_dotfile(path)) ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0is_dir_sep(c) || c =3D=3D '\0')

That would make that warning go away, but I don't know if that changes
the semantics of the code. I was aiming not to change any code, just
to squash spurious warnings under Sun Studio.

We could also just wrap the whole function definition in the pragma,
which would make the code more readable since we wouldn't have 6 lines
of warning suppression in the middle of the function.

Or we could just drop this patch entirely, or rewrite the code. Your
pick.
