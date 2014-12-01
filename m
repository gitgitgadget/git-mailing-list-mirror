From: David Michael <fedora.dm0@gmail.com>
Subject: Re: [PATCH] compat: convert modes to use portable file type values
Date: Mon, 1 Dec 2014 12:46:33 -0500
Message-ID: <CAEvUa7m9yyL-LHP2OHqo82ygWCfRavR=cFB8ywr=8bQJOAzdiw@mail.gmail.com>
References: <87vblxl8ah.fsf@gmail.com>
	<547B7B27.90204@web.de>
	<CAEvUa7=R7Bm7e=HCuw7QnMPwhunjJ4LUYv4LzMHMugh-iUkt8A@mail.gmail.com>
	<547C02DD.2010606@web.de>
	<CAEvUa7kVUQoQ1cCm36y3gC3fYXyzvQ6f8Kj8GfCsX7ovrquA7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 01 18:46:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvV3X-0007eD-1F
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 18:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbaLARqf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Dec 2014 12:46:35 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33628 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbaLARqe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2014 12:46:34 -0500
Received: by mail-pa0-f43.google.com with SMTP id kx10so11561147pab.2
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 09:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=E+qI2b67fKqGbHQ5XSsRSTyBhgcX13Cw76YIdXyO6Nw=;
        b=cj/hbIx4kmmgdRGJu6zkOfuruw7scVjUUe+zOwZiMaZCZh015hYlxrqUSBP6MliSRS
         cspMcfuHOkSUQcwNZa/bbrxI3sIpGNC4o/kqS5OByjyORowjS/dpL6qvWmPJNxDEDgCm
         ygHWl+9pv5DIdc+aU2AIsNmBRueMaz2bfar2NP8LXUQ9zyuIx63RAMbWOgdMYECQOJGB
         eBYg2wep42AEPHecGJV/KcR8UJC7S82I48ZQKbFvoBg143RE5Qg3k6fhngysGBnk8dvh
         w69u+dtJViNbnwLco9koJK3cPxYLMm1mM/ujVCdGfW230dpA91MbaQY64GEC7H/cc9SD
         +k2w==
X-Received: by 10.70.128.132 with SMTP id no4mr102848455pdb.125.1417455993329;
 Mon, 01 Dec 2014 09:46:33 -0800 (PST)
Received: by 10.70.55.36 with HTTP; Mon, 1 Dec 2014 09:46:33 -0800 (PST)
In-Reply-To: <CAEvUa7kVUQoQ1cCm36y3gC3fYXyzvQ6f8Kj8GfCsX7ovrquA7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260497>

On Mon, Dec 1, 2014 at 7:48 AM, David Michael <fedora.dm0@gmail.com> wr=
ote:
> On Mon, Dec 1, 2014 at 12:55 AM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> On 12/01/2014 04:40 AM, David Michael wrote:
>>>
>>> On Sun, Nov 30, 2014 at 3:16 PM, Torsten B=C3=B6gershausen <tboegi@=
web.de>
>>> wrote:
>>> [snip]
>>>>
>>>> Could the code be more human-readable ?
>>>> static inline mode_t mode_native_to_git(mode_t native_mode)
>>>> {
>>>>          int perm_bits =3D native_mode & 07777;
>>>>          if (S_ISREG(native_mode))
>>>>                  return 0100000 | perm_bits;
>>>>          if (S_ISDIR(native_mode))
>>>>                  return 0040000 | perm_bits;
>>>>          if (S_ISLNK(native_mode))
>>>>                  return 0120000 | perm_bits;
>>>>          if (S_ISBLK(native_mode))
>>>>                  return 0060000 | perm_bits;
>>>>          if (S_ISCHR(native_mode))
>>>>                  return 0020000 | perm_bits;
>>>>          if (S_ISFIFO(native_mode))
>>>>                  return 0010000 | perm_bits;
>>>>          /* Non-standard type bits were given. */
>>>>          /* Shouldn't we die() here ?? */
>>>>                  return perm_bits;
>>>> }
>>>
>>> Sure, I can send an updated patch with the new variable and without=
 the
>>> "else"s.
>>>
>>> Regarding the question in the last comment:  I was assuming if this
>>> case was ever reached, Git would handle the returned mode the same =
way
>>> as if it encountered an unknown/non-standard file type on a normal
>>> operating system, which could die() if needed in the function that
>>> called stat().
>>>
>>> Should I send an updated patch that die()s there?
>>>
>>> David
>>
>> Not yet, please wait with a V2 patch until I finished my thinking ;-=
)
>>
>> I take back the suggestion with the die(). I was thinking how to han=
dle
>> unforeseen types, which may show up on the z/OS some day,
>> So die() is not a good idea, it is better to ignore them, what the c=
ode
>> does.
>>
>> Knowing that Git does not track block devices, nor character devices=
 nor
>> sockets,
>> the above code could be simplyfied even more, by mapping everything =
which
>> is not a directory, a file or a softlink to "device type 0)
>>
>> This is just a suggestion, I want to here from others as well:
>>
>>         int perm_bits =3D native_mode & 07777;
>>         if (S_ISREG(native_mode))
>>                 return 0100000 | perm_bits;
>>         if (S_ISDIR(native_mode))
>>                 return 0040000 | perm_bits;
>>         if (S_ISLNK(native_mode))
>>                 return 0120000 | perm_bits;
>>         /* Git does not track S_IFCHR, S_IFBLK, S_IFIFO, S_IFSOCK  *=
/
>>                 return perm_bits;
>
> I had considered omitting those three as well at first, but in this
> case it would mean that they will be unusable all together.
>
> The z/OS S_IFMT definition (i.e. the file type bit mask) is
> 0xFF000000, and the common/translated S_IFMT definition is 0xF000.
> Since the S_ISxxx macros use the typical ((mode & S_IFMT) =3D=3D S_IF=
xxx)
> definition, they would never match a native z/OS mode after redefinin=
g
> S_IFMT.
>
> So translating those types isn't just for tracking files, it's to
> support any use of S_ISxxx anywhere in the code.  It should be okay t=
o
> remove any of those types if we know that Git will never need to use
> them.

Apologies, in my pre-coffee reply, I confused myself into thinking the
omitted types were going to be returned unchanged as opposed to being
changed to zero.  That second paragraph is irrelevant.

But regarding the last paragraph: a quick grep for instances of using
those file types in the Git source found S_ISFIFO and S_ISSOCK in
git.c.

I just noticed that I copied the list of standard file type macros
from SUSv2, and S_IFSOCK was added after that.  z/OS does implement
S_IFSOCK, so I think I should add it to the v2 patch to support the
test in git.c.

Another grep found no instances of testing for block or character
devices, so it should be okay to remove those from the patch if Git is
unlikely to use them in the future (unless we just want to provide all
7 types from http://pubs.opengroup.org/onlinepubs/009695399/basedefs/sy=
s/stat.h.html
).

David
