From: David Michael <fedora.dm0@gmail.com>
Subject: Re: [PATCH] compat: convert modes to use portable file type values
Date: Mon, 1 Dec 2014 07:48:26 -0500
Message-ID: <CAEvUa7kVUQoQ1cCm36y3gC3fYXyzvQ6f8Kj8GfCsX7ovrquA7g@mail.gmail.com>
References: <87vblxl8ah.fsf@gmail.com>
	<547B7B27.90204@web.de>
	<CAEvUa7=R7Bm7e=HCuw7QnMPwhunjJ4LUYv4LzMHMugh-iUkt8A@mail.gmail.com>
	<547C02DD.2010606@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 01 13:48:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvQP3-0006qD-5r
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 13:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbaLAMs3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Dec 2014 07:48:29 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:58752 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbaLAMs1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2014 07:48:27 -0500
Received: by mail-pd0-f180.google.com with SMTP id p10so10877617pdj.39
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 04:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4If1dCgl1zGnWZyseyu7V7/mYuSWkZi85QrxW5ZIHsc=;
        b=GytgoZaWaOqsgNe5XxNNC9OB0yoDq+nsuUDKn1XtGZfa+Rl24S3FRsb/eYPu5SV1vF
         ihTdbRrRk5Yh9JJaE0uSfuBBTknTCCNphRdCsl22/KNlRBjZJhJz7aY1/9wH5XCqKVdS
         ea0EJXrd6C2pTrlCBNF9L11/Fg4oV6xQd7A/VwoXxWqqIOFEVsSPPsfyoJXKDlo2Vs5Y
         5cGPlKsoUF2tKCoy84dE+mmcuL0Pge1nlJXWrDk8tdDvfJX7CziKqP5fRIvj/N0h15QE
         KFZnZNg/ltJkHKiahCKJ219/BXVtk7w1nUIQ3RZK/6kbMzsx0zvwZk3qDgSmFzmkKyW+
         hFog==
X-Received: by 10.68.226.69 with SMTP id rq5mr51028633pbc.116.1417438106900;
 Mon, 01 Dec 2014 04:48:26 -0800 (PST)
Received: by 10.70.55.36 with HTTP; Mon, 1 Dec 2014 04:48:26 -0800 (PST)
In-Reply-To: <547C02DD.2010606@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260481>

On Mon, Dec 1, 2014 at 12:55 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 12/01/2014 04:40 AM, David Michael wrote:
>>
>> On Sun, Nov 30, 2014 at 3:16 PM, Torsten B=C3=B6gershausen <tboegi@w=
eb.de>
>> wrote:
>> [snip]
>>>
>>> Could the code be more human-readable ?
>>> static inline mode_t mode_native_to_git(mode_t native_mode)
>>> {
>>>          int perm_bits =3D native_mode & 07777;
>>>          if (S_ISREG(native_mode))
>>>                  return 0100000 | perm_bits;
>>>          if (S_ISDIR(native_mode))
>>>                  return 0040000 | perm_bits;
>>>          if (S_ISLNK(native_mode))
>>>                  return 0120000 | perm_bits;
>>>          if (S_ISBLK(native_mode))
>>>                  return 0060000 | perm_bits;
>>>          if (S_ISCHR(native_mode))
>>>                  return 0020000 | perm_bits;
>>>          if (S_ISFIFO(native_mode))
>>>                  return 0010000 | perm_bits;
>>>          /* Non-standard type bits were given. */
>>>          /* Shouldn't we die() here ?? */
>>>                  return perm_bits;
>>> }
>>
>> Sure, I can send an updated patch with the new variable and without =
the
>> "else"s.
>>
>> Regarding the question in the last comment:  I was assuming if this
>> case was ever reached, Git would handle the returned mode the same w=
ay
>> as if it encountered an unknown/non-standard file type on a normal
>> operating system, which could die() if needed in the function that
>> called stat().
>>
>> Should I send an updated patch that die()s there?
>>
>> David
>
> Not yet, please wait with a V2 patch until I finished my thinking ;-)
>
> I take back the suggestion with the die(). I was thinking how to hand=
le
> unforeseen types, which may show up on the z/OS some day,
> So die() is not a good idea, it is better to ignore them, what the co=
de
> does.
>
> Knowing that Git does not track block devices, nor character devices =
nor
> sockets,
> the above code could be simplyfied even more, by mapping everything w=
hich
> is not a directory, a file or a softlink to "device type 0)
>
> This is just a suggestion, I want to here from others as well:
>
>         int perm_bits =3D native_mode & 07777;
>         if (S_ISREG(native_mode))
>                 return 0100000 | perm_bits;
>         if (S_ISDIR(native_mode))
>                 return 0040000 | perm_bits;
>         if (S_ISLNK(native_mode))
>                 return 0120000 | perm_bits;
>         /* Git does not track S_IFCHR, S_IFBLK, S_IFIFO, S_IFSOCK  */
>                 return perm_bits;

I had considered omitting those three as well at first, but in this
case it would mean that they will be unusable all together.

The z/OS S_IFMT definition (i.e. the file type bit mask) is
0xFF000000, and the common/translated S_IFMT definition is 0xF000.
Since the S_ISxxx macros use the typical ((mode & S_IFMT) =3D=3D S_IFxx=
x)
definition, they would never match a native z/OS mode after redefining
S_IFMT.

So translating those types isn't just for tracking files, it's to
support any use of S_ISxxx anywhere in the code.  It should be okay to
remove any of those types if we know that Git will never need to use
them.

David
