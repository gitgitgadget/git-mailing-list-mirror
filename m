From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH 4/5] grep: Colorize filename, line number, and separator
Date: Sun, 28 Feb 2010 15:14:40 -0500
Message-ID: <ca433831002281214q14e6e62bj54cf7227cd32873b@mail.gmail.com>
References: <1267246670-19118-1-git-send-email-lodatom@gmail.com> 
	<1267246670-19118-5-git-send-email-lodatom@gmail.com> <4B890572.5040604@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Feb 28 21:15:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlpXi-0003Gg-N6
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 21:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031991Ab0B1UPE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Feb 2010 15:15:04 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37481 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031988Ab0B1UPB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Feb 2010 15:15:01 -0500
Received: by gyh20 with SMTP id 20so840504gyh.19
        for <git@vger.kernel.org>; Sun, 28 Feb 2010 12:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IQjsztX3euZdFPxHCpvpeUt/tRnn2C+u3ERmZ7n/vXk=;
        b=sCMp5WgkHLajF66JeKJHfzGUW9vZbOwNGILiwjmlIcDMaZjYDDkciDdgUzaIEAVxB9
         P6M+uNpVoHs6SlABIW23+TdVwkAZc0Pi6GYH8Uu/GozC/Unen8B3hLL4LW3r5HRactFV
         d4NZyWwf/zDZ8gbpYBVvNhDR/d+yDp7v12oKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=plAUgnba7evybqYh/FXaEqnlJd4BNCNog8Kx2TbYFipckf3kKeuXpsbH5iOsijrW+/
         HZ4I7OWyJfLuDdKJT7264uexG/A9JpDeBNdvRMb9NafVizzpOcfDh5XIhJNp8d6E4pi5
         gG1yMN1ZjxSQxhTbJT5Yro8K8x8aj8123FRV0=
Received: by 10.91.55.39 with SMTP id h39mr2793561agk.77.1267388100142; Sun, 
	28 Feb 2010 12:15:00 -0800 (PST)
In-Reply-To: <4B890572.5040604@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141266>

On Sat, Feb 27, 2010 at 6:43 AM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 27.02.2010 05:57, schrieb Mark Lodato:
>> 1. With --name-only, GNU grep colors the filenames, but we do not. =C2=
=A0I do
>> =C2=A0 =C2=A0not see any point to making everything the same color.
>
> I guess they did it for consistency, so when you see "magenta" you th=
ink
> "filename", and because it can be turned off with a switch. =C2=A0Wit=
h your
> patch all filenames are coloured the same, too, by the way: using the
> default foreground colour. :)

Yes, I think I understand the reasoning, but to me it is very
annoying.  However, if there is a consensus that we should follow GNU
grep in this regard, I will do it.

>> diff --git a/builtin-grep.c b/builtin-grep.c
>> + =C2=A0 =C2=A0 if (!value)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return config_error_nonb=
ool(var);
>
> color.grep without a value used to turn on colourization, now it seem=
s
> to error out.

Oops, that should be "if (color && !value)".  I will fix in next respin=
=2E

>> + =C2=A0 =C2=A0 color_parse(value, var, color);
>> + =C2=A0 =C2=A0 if (!strcmp(color, GIT_COLOR_RESET))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 color[0] =3D '\0';
>
> This turns off colouring if the user specified "reset" as the colour,
> right?

Yes.

> Interesting optimization, but is it really needed? Perhaps it's
> just me, but I'd give the user the requested "<reset>text<reset>"
> sequence if she asked for it, even if it's longer than and looks the
> same as "text" alone.

The problem is that there's no way to say "no color".  A blank value
and "reset" both come to the same thing.  I would rather have as
little markup as possible in the output, and this tweak is very
simple.  While this is not strictly necessary, it does make the output
identical to the pre-patch output if you disable all the new colors
(just grep.color.separator, by default.)

>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 else
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else

Oops, thanks.

>> + =C2=A0 =C2=A0 if (opt->null_following_name) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sign =3D '\0';
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opt->output(opt, &sign, =
1);
>> + =C2=A0 =C2=A0 } else
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (opt->null_following_name)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0opt->output(op=
t, "", 1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else

Personally, I find your suggestion less readable.  My version is only
one line longer but makes the code completely obvious, whereas the
one-liner requires a second of thought.  Anyone else care to comment
on this?
