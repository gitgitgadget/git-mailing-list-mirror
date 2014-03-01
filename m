From: He Sun <sunheehnus@gmail.com>
Subject: Re: [PATCH] Rewrite bulk-checkin.c:finish_bulk_checkin() to use a
 strbuf for handling packname
Date: Sat, 1 Mar 2014 08:13:40 +0800
Message-ID: <CAJr59C3VE=kuSUsFF8Hq+KU6+a1JOEt4edg3YhBnnc_EsPcZZQ@mail.gmail.com>
References: <1393576104-1758-1-git-send-email-sunheehnus@gmail.com>
	<CAPig+cSvkmZH2qEqKd=sjaMO8bfnxiKiuTKtfOuMCDwDfCDciw@mail.gmail.com>
	<CAPig+cSN1WGj9aMKHEo+JO6xN2dT_+0fEjPG3bK=ZsA4dwyWBw@mail.gmail.com>
	<CAJr59C2YTW-k=ujioUDfebf5koT4viB7NLtPk-do4T5Vo1Aqjw@mail.gmail.com>
	<CAPig+cTdMZw=tiJyr-0v_ZE_P92Yjc1g2YhhBF_Jv+ML87kz2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 01:13:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJXYo-0000Ti-5Z
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 01:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbaCAANm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Feb 2014 19:13:42 -0500
Received: from mail-we0-f177.google.com ([74.125.82.177]:51807 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbaCAANl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 19:13:41 -0500
Received: by mail-we0-f177.google.com with SMTP id t61so1123609wes.22
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 16:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=eBn4lwmfOyUyLpUuAseZ4zzmvPaNFkaA4L4lRi7PSLA=;
        b=VKI1+4XOKiotJ5B6oGjaamCEfmhCOp+UFuQw+eXuxYTGhDhUoHsdxuyWBmj6efbLOn
         RUzrwwk1ACtlQztEKuIFScS7kmKmksqHx4oWl5yYUtApmClMXVO6nU6LE7VsptlfPZdf
         ZVb+lj7MxsMtp4Cnlx5LIpS5zB9RLiSxHi1ymGGVP7wF71wAmUDEvZ9dgmr0YbjAqUsx
         /6/f4MYF362Bc/Mw1fY7EeyNDcFK24VJIKtFHITOJmA3VRHQwr68udjQcH0nWHMZLQHS
         EZ7ZMoGXF/MovO5KsEZ45043GxXls7LRjgT1j71DXZnM2rb6R8nvZuCYMPc2U80aIDe7
         o++g==
X-Received: by 10.194.62.243 with SMTP id b19mr17734wjs.63.1393632820189; Fri,
 28 Feb 2014 16:13:40 -0800 (PST)
Received: by 10.216.203.69 with HTTP; Fri, 28 Feb 2014 16:13:40 -0800 (PST)
In-Reply-To: <CAPig+cTdMZw=tiJyr-0v_ZE_P92Yjc1g2YhhBF_Jv+ML87kz2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243031>

2014-03-01 4:42 GMT+08:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Fri, Feb 28, 2014 at 9:17 AM, =CB=EF=BA=D5 <sunheehnus@gmail.com> =
wrote:
>> 2014-02-28 21:12 GMT+08:00 Eric Sunshine [via git]
>> <ml-node+s661346n7604500h1@n2.nabble.com>:
>>> On Fri, Feb 28, 2014 at 4:46 AM, Eric Sunshine <[hidden email]> wro=
te:
>>>
>>>> On Fri, Feb 28, 2014 at 3:28 AM, Sun He <[hidden email]> wrote:
>>>>> Signed-off-by: Sun He <[hidden email]>
>>>>> ---
>>>>
>>>> Nicely done.
>>>>
>>>> Due to the necessary changes to finish_tmp_packfile(), the focus o=
f
>>>> this patch has changed slightly from that suggested by the
>>>> microproject. It's really now about finish_tmp_packfile() rather t=
han
>>>> finish_bulk_checkin(). As such, it may make sense to adjust the pa=
tch
>>>> subject to reflect this. For instance:
>>>>
>>>>   Subject: finish_tmp_packfile(): use strbuf for pathname construc=
tion
>>>
>>> You may also want your commit message to explain why you chose this
>>> approach over other legitimate approaches. For instance, your chang=
e
>>> places extra burden on callers of finish_tmp_packfile() by leaking =
a
>>> detail of its implementation: namely that it wants to manipulate
>>> pathnames easily (via strbuf). An equally valid and more encapsulat=
ed
>>> approach would be for finish_tmp_packfile() to accept a 'const char=
 *'
>>> and construct its own strbuf internally.
>>>
>>> If the extra strbuf creation in the alternate approach is measurabl=
y
>>> slower, then you could use that fact to justify your implementation
>>> choice in the commit message. On the other hand, if it's not
>>> measurably slower, then perhaps the more encapsulated approach with
>>> cleaner API might be preferable.
>>>
>>
>> Thank you for your explaination. I get the point.
>> And I think if it is proved that the strbuf way is measurably slower=
=2E
>> We should add a check for the length of string before we sprintf().
>
> I'm not sure what you mean by checking the string length before sprin=
tf().
>

That's because one is not certain of the length of get_object_directory=
()

Micheal Mhaggerty<mhagger@alum.mit.edu> explained this to me.
    Saving stack space is nice, though given that it takes more time to
    allocate space on the heap, it is nonetheless usually preferred to =
use
    the stack for temporary variables of this size.

    The problem has more to do with the fact that the old version fixes=
 a
    maximum length on the buffer, which could be a problem if one is no=
t
    certain of the length of get_object_directory().

    The other point of strbuf is that you don't have to do the error-pr=
one
    bookkeeping yourself.  So it would be preferable to use strbuf_addf=
().

It is the same as yours about the space and time costs. ^_^

> My point was that if there are multiple ways of solving the same
> problem, it can be helpful for reviewers if your commit message
> explains why the solution you chose is better than the others.
>
> Slowness and/or cleanliness of API were just examples you might use i=
n
> your commit message for justifying why you chose one approach over
> another.

OK, OK, Got it. Thank you very much.

Cheers,
He Sun
