From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH B v4 5/5] git config: don't allow --get-color* and 
	variable type
Date: Sat, 7 Mar 2009 11:47:54 +0200
Message-ID: <94a0d4530903070147v1128e482n9522d60292d206a0@mail.gmail.com>
References: <1235177369-2727-1-git-send-email-felipe.contreras@gmail.com>
	 <1235177369-2727-2-git-send-email-felipe.contreras@gmail.com>
	 <1235177369-2727-3-git-send-email-felipe.contreras@gmail.com>
	 <1235177369-2727-4-git-send-email-felipe.contreras@gmail.com>
	 <1235177369-2727-5-git-send-email-felipe.contreras@gmail.com>
	 <1235177369-2727-6-git-send-email-felipe.contreras@gmail.com>
	 <7vmyce2z9q.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902220912r94e00d6ha7592bc397baa57c@mail.gmail.com>
	 <7vmycez86y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 10:49:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lft9s-0000Kk-0V
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 10:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbZCGJr7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 04:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753344AbZCGJr6
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 04:47:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:32248 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbZCGJr5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2009 04:47:57 -0500
Received: by fg-out-1718.google.com with SMTP id 16so630327fgg.17
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 01:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=t8LYh3M8XkoH0oO2OF4/qvKqnwcRn7i4EGMKdKG4zXc=;
        b=M0uCr6eWAN7qFPnyQG3rVFKgA0OmNgsRgKUEIe2XHCqhW5v9ZCC5EN99/6tfHmXDij
         IM8NvGqbsBmhYEWTORIn/5cyw6wqNjRqq8AvtLmCBdViaOF6cUF5OG+GjUJmwQDsmcHj
         DKStGAmIWAU3FxjO/FrFYNsXR3UOOK5ZxHK+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J0FAPFOSSsYb8buo6wjOMJwrcOvgc6UMr0ikunqJGUYM8rDtBAHEjjlomXXHHuda7R
         eRjFaZmvsZU0HQ/YB/WBlomwwypYusa4PElNqnXOXj8lX5tgdsLFdMv6n9EY/fTQYEZZ
         vCe8EQWjokiUErVRPT1W4lehhWCWbPI+QDWL8=
Received: by 10.86.86.2 with SMTP id j2mr1978345fgb.50.1236419274755; Sat, 07 
	Mar 2009 01:47:54 -0800 (PST)
In-Reply-To: <7vmycez86y.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112520>

On Sun, Feb 22, 2009 at 7:35 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>>> diff --git a/builtin-config.c b/builtin-config.c
>>>> index 8045926..9930568 100644
>>>> --- a/builtin-config.c
>>>> +++ b/builtin-config.c
>>>> @@ -359,6 +359,11 @@ int cmd_config(int argc, const char **argv, c=
onst char *unused_prefix)
>>>> =C2=A0 =C2=A0 =C2=A0 if (get_colorbool_slot)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions |=3D ACTION_GET_COLORBO=
OL;
>>>>
>>>> + =C2=A0 =C2=A0 if ((get_color_slot || get_colorbool_slot) && type=
s) {
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error("--get-color and=
 variable type are incoherent");
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usage_with_options(bui=
ltin_config_usage, builtin_config_options);
>>>> + =C2=A0 =C2=A0 }
>>>> +
>>>
>>> I do not think I suggested anything like this, so I'd decline to ta=
ke
>>> credit for this patch.
>>>
>>> Strictly speaking, "--bool --get-colorbool diff.color 1" shouldn't =
error
>>> out, don't you think? =C2=A0And it certainly shouldn't say "--get-c=
olor".
>>
>> Huh? I misinterpreted:
>> I see "git config --bool --get-color diff.color.whitespace" is still
>> allowed, which you might want to tighten further.
>
> "--get-color" gets, escape sequence to throw at the terminal to get t=
he
> color configured. =C2=A0It does not make sense to ask for bool (or in=
t) for
> that action.
>
> "--get-colorbool" asks if it is appropriate to use such escape sequen=
ce
> (e.g. when the output is tty and config says "auto", you would get "p=
lease
> use color"). =C2=A0In other words, its type is always bool, so using =
it as
> --int does not make sense but we cannot really say using it with --bo=
ol is
> nonsense.

Now I get it, but why would somebody want to do '--bool
--get-colorbool'? That is redundant.

I think --bool should be used only for boolean variables, not color one=
s.

Please let me know if the original patch is ok and I'll resend it with
'--get-color*'.

--=20
=46elipe Contreras
