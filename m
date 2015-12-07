From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 8/8] update-index: make core.untrackedCache a bool
Date: Mon, 7 Dec 2015 11:32:40 +0100
Message-ID: <CAP8UFD3j01UhkGz_Hk=xrLppmz7uLqCvtCDLygXfY=crhUZzFg@mail.gmail.com>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
	<1449001899-18956-9-git-send-email-chriscool@tuxfamily.org>
	<5662DC2C.8030009@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 07 11:32:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5t68-0004MK-SJ
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 11:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616AbbLGKcn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2015 05:32:43 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33237 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755476AbbLGKcm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2015 05:32:42 -0500
Received: by lbbkw15 with SMTP id kw15so56967954lbb.0
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 02:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4tQ1dTvCUxE7yCCpNrdPnCkZ+DCvhZDENwbc4ytDe0I=;
        b=Bm/6Mq7Igk3OM9OTYc+k+3hHS99ouXUoCyJW45K+RZ3PXGmGSYgl1UEAxorzsSXOI+
         Cn3E/ADsY1ab/1S4tvZ68RtHk+4kif/8uQF6I2sUTVmrl/8vUfhURtpDDvZFBT8xKmA3
         +F+hBLHdfyA2bUNXWQItkXCKypZqi2Te54LHrLDt0MmgEerqrL0huT2Ex3sEKBlJRj89
         8jBpI5m/Psaq+5eZhQcHbiVz9G1DdFNOEtqTo/iReF4uXlBSZHBHpexrcUIyfhrfvqRD
         Kh1sr+G1+I1Bvt4XWcnScidKsiRPAdZZ68rrFIt0kvUb60eIzm/HpBeM7+w/GFcdn+4t
         qRPg==
X-Received: by 10.25.18.93 with SMTP id h90mr13282397lfi.7.1449484360597; Mon,
 07 Dec 2015 02:32:40 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Mon, 7 Dec 2015 02:32:40 -0800 (PST)
In-Reply-To: <5662DC2C.8030009@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282090>

(Sorry I already sent a private reply to Tosten by mistake.)

On Sat, Dec 5, 2015 at 1:44 PM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> On 01.12.15 21:31, Christian Couder wrote:
>> Most features in Git can be enabled or disabled using a simple
>> bool config variable and it would be nice if untracked cache
>> behaved the same way.
>>
>> This makes --[no-|force-]untracked-cache change the value of
>> core.untrackedCache in the repo config file, to avoid making
>> those options useless and because this avoids the untracked
>> cache being disabled by a kernel change or a directory
>> change. Of course this breaks some backward compatibility,
>> but the simplification and increased useability is worth it.
>
> Some loose thinking, how the core.untrackedcache and the
> command line can work together:
>
> core.untrackedcache =3D unset
>   everything is as today
>   if --test-untracked-cache is used on command line,
>   the test is run, additionally the result is stored
>   in the config variable core.untrackedcache

I don't like storing the result in core.untrackedcache as it means
that --test-untracked-cache would not just test.
And I agree with Aevar that it's a good thing to be able to completely
separate testing and configuring.

> core.untrackedcache =3D true
>   same as --force-untracked-cache
>   if --no-untracked-cache is given on command line,
>   this has higher priority

I guess you mean that --no-untracked-cache has priority over
"core.untrackedcache =3D true" without removing this config variable.
This means that --no-untracked-cache would only remove the untracked
cache (UC) from the index.

But what git should then do the next time "git status" is run?
Git sees that the index does not contain any UC, but it doesn't know
that "git update-index --no-untracked-cache" has just been run. It
might be "git config core.untrackedcache true" that has been run last.

If "git config core.untrackedcache true" has been run last, it would
be logical to add the UC to the index and use it.
If "git update-index --no-untracked-cache" has been run last, it would
be logical to not add the UC.

> core.untrackedcache =3D false
>   same as --no-untracked-cache
>   if --force-untracked-cache is given on command line,
>   this has higher priority

Then the same kind of problem happens as above. There is no clear
solution about what "git status" should do when the state of the index
conflicts with the value of core.untrackedcache.

> Does this support the workflow described by =C3=86var ?

I don't think so. I think that when we set "core.untrackedcache =3D
true" we want the UC to be added to the index and used as much as
possible, because we know that our OS/filesystem supports it.

This means that using "git update-index --no-untracked-cache" when
"core.untrackedcache =3D true" is set can only have two possible
outcomes. It could either just die saying that "core.untrackedcache"
is true, or it could just unset "core.untrackedcache" or set it to
false (which might mean the same thing).
