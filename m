From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Teach ignore machinery about pattern "/"
Date: Sat, 26 May 2012 11:30:36 +0700
Message-ID: <CACsJy8BjUQsCVVdzZtJxA9Qu2G0izZa8dvP1EKsQQAHWXZbHdg@mail.gmail.com>
References: <1337950056-26491-1-git-send-email-pclouds@gmail.com> <7vlikgtbcx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 26 06:31:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY8fK-0003uq-9M
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 06:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925Ab2EZEbL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 May 2012 00:31:11 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40408 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab2EZEbJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 May 2012 00:31:09 -0400
Received: by lbbgm6 with SMTP id gm6so1053036lbb.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 21:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2f5MMG5BE+gZIbtZ2LEBYpJAxnkiZ858laJexnZ9RY0=;
        b=MGmMg+pt1y+IUlJTmIeNpFZ+tO3fYq+uwiUsnP4YhM2TOSGQp3NA0r4RvpVpNu2UvU
         1Ij797sMVwNfETWNUk1f7yzy/29M84hmnIT4UGfO2iVw+voI3o8tkB80d+OAt6Upo4sh
         q2+AHrNIg8vYns+eF+r16dxlpG156g2jTJmwq4vjSETxzsNZL06k+ImgtsEt5QobaP/5
         XA++dmo2UaVKjDb442Th9LVNvSjCRWqH72vIY/9oNCDVmRphB+FDDTug3XqN0AN7ehi7
         NIcU7sq8tIpoRXX6gcbhvSQ8KK8t4T4oBkxTbQQDy0K+kGhWnCcBUe3BllqPZ5TO/MOX
         RULw==
Received: by 10.112.98.40 with SMTP id ef8mr556367lbb.72.1338006668109; Fri,
 25 May 2012 21:31:08 -0700 (PDT)
Received: by 10.112.150.100 with HTTP; Fri, 25 May 2012 21:30:36 -0700 (PDT)
In-Reply-To: <7vlikgtbcx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198541>

On Sat, May 26, 2012 at 12:32 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> Pattern "/" is ambiguous because the slash can mean "anchor the
>> pattern to this location" (e.g. /path), but it can also mean
>> "match directories only" (e.g. path/). Currently git interprets it a=
s
>> the latter except that 'path' is an empty string, which makes this
>> pattern totally useless.
>
> Did the old version interprete it as the former?

That calls for bit of testing, which I'll do soon.

> How does the above
> observation relate to the end-user help request in the other thread?

I assume you meant the recent sparse-checkout thread. "/" happens to
work due to (probably) a mistake in sparse-checkout v1.7.2 even though
"/" behavior is undefined. This sets a specific behavior to "/" and
makes 1.7.10 treat "/" like 1.7.2.

> When talking about an ambiguous expression X that can be in multiple =
ways
> and each interpretation gives surprisingly different result, if there=
 are
> ways A, B and C to unambiguously spell each and every of its possible=
 and
> useful interpretations, and if one of the interpretations C is to ign=
ore
> the expression altogether, it is preferrable to either
>
> =C2=A0(1) warn if it does not trigger anything useful to write a no-o=
p; or
> =C2=A0(2) just ignore it if a no-op is a meaningful behaviour
>
> when you see X.

except that we do the ignoring in (2) but I don't see this as a
meaningful behavior.

>> On the other hand, it's intuitive to read '/' as "match root
>> directory", or equivalent to "/*". (The other way to see it is "matc=
h
>> all directories", which leads to the same result).
>
> I am a bit confused about the above, especially "The other way" part.
>
> Does this alternative interpretation view "/" as "/foo" whose "foo"
> happens to be an empty string, or does it view "/" as "foo/" whose "f=
oo"
> happens to be an empty string?

The latter. Though there may be two way of interpreting the empty
string as pattern. The computer would happily say "match nothing", but
my human brain tends to thinkg "match everything" as "match nothing"
does not really makes sense as a pattern.

> The former would mean "ignore foo, and don't bother descending into f=
oo if
> it is a directory, as everything in it is ignored", while the latter =
would
> mean "anywhere in this directory and its subdirectories, if we see fo=
o
> that is a directory, don't bother descending into it as everything in=
 it
> is ignored."
>
> What I am trying to get at is why you are making '/' the same as '/*'=
 as
> opposed to '*/', '/*/', or even a plain '*'.

Because I see "/" as a special case of "/foo". It makes more sense
than "/" as a special case of "foo/", at least not without more
thoughts on it.

>> One may wonder why bother an "ignore all" pattern. The pattern is
>> useful when you want to keep just a small portion of the working
>> directory. But that's still a rare case.
>>
>> A more popular case would be sparse checkout, where ignore rules are
>> used to _include_. The thus now "include all" pattern is used to say
>> "make a sparse checkout that includes everything except this and
>> this".
>
> If the "sparse checkout" hack writes "/" for whatever reason, it shou=
ld be
> corrected to write "*" (or perhaps "/*") instead. =C2=A0I do not see =
it as a
> valid factor to affect when we decide what should be done for a possi=
bly
> ambiguous "/" entry in the exclude machinery.

That's one way of seeing it. What I propose in the patch is "this is
useless no-op pattern (*), let's assign some meaning to it, what makes
most sense"

(*) still needs verification though.

>
>> Recognize this special pattern and turn it the working equivalence
>> pattern "/*"
>
> Regardless of the answer to the "is it *, /*, */ or /*/" question abo=
ve,
> I do not think silent conversion is a right solution for the ambiguit=
y.
--=20
Duy
