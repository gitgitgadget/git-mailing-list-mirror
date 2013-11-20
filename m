From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] pager: turn on "cat" optimization for DEFAULT_PAGER
Date: Wed, 20 Nov 2013 18:34:45 +0100
Message-ID: <CABPQNSb9ndc+QxTR6mcdnvt7oGQ7DbY6KXGt0LZOXshrg5Scow@mail.gmail.com>
References: <201308261957.r7QJvfjF028935@freeze.ariadne.com>
 <xmqqd2ozhhob.fsf@gitster.dls.corp.google.com> <201308281819.r7SIJmnh025977@freeze.ariadne.com>
 <xmqqr4dd8suz.fsf@gitster.dls.corp.google.com> <201308291541.r7TFfuJr023110@freeze.ariadne.com>
 <vpqsixsv6dq.fsf@anie.imag.fr> <201309030227.r832RmBd013888@freeze.ariadne.com>
 <20130903074150.GE3608@sigill.intra.peff.net> <CABPQNSb6PD+oSw_LT6KaUYd8BTeN-WHJFodcuiLe=u76rFYFJw@mail.gmail.com>
 <xmqqob5f6krn.fsf@gitster.dls.corp.google.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, "Dale R. Worley" <worley@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 20 18:35:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjBgY-00055Q-0P
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 18:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052Ab3KTRf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 12:35:26 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:53318 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab3KTRfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 12:35:25 -0500
Received: by mail-ie0-f173.google.com with SMTP id to1so3605426ieb.4
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 09:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=m6nGDw6Z0cW0k5qEOlKbIH45sMEyyJhmnTYKqfn239g=;
        b=iRTKeoly92dnGwfpV1qKwsrGNNc6p3Ruh5pc3ep1+HCzM+RZHbKg0+orM0XgCrK9Ks
         9n+rU6gBpYA/kACr+2CxXIMIe9TQYrxg/+9pKUL7ke7Of82Y+RD8hXkRzMbDhV/wI/P8
         Ri4pT6JokOS83h44V1LwaHJtjA/CpNtNZTPvCW1tuPdfL3VmC8LqkuZ37UtX2nYNyF7/
         +hFR/xvJO+h5U9KZpFPeVNOY7GDuA5vqeYl2Ez2+gSyAflZkk7NHsHgDD4ZLT1IQ0nqF
         LJmZ9UzpPTSVtwsBOFM1RGBxT+9Z1Efx9PHunMaOF8K3NaW1LwyFkv6KZpecibJ4pIDq
         eNzQ==
X-Received: by 10.43.161.2 with SMTP id me2mr1275848icc.20.1384968925304; Wed,
 20 Nov 2013 09:35:25 -0800 (PST)
Received: by 10.64.249.33 with HTTP; Wed, 20 Nov 2013 09:34:45 -0800 (PST)
In-Reply-To: <xmqqob5f6krn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238088>

On Wed, Nov 20, 2013 at 6:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>>> ...
>>> is set to empty., 2006-04-16). At that time, the line
>>> directly above used:
>>>
>>>    if (!pager)
>>>            pager = "less";
>>>
>>> as a fallback, meaning that it could not possibly trigger
>>> the optimization. Later, a3d023d (Provide a build time
>>> default-pager setting, 2009-10-30) turned that constant into
>>> a build-time setting which could be anything, but didn't
>>> loosen the "else" to let DEFAULT_PAGER use the optimization.
>>>
>>> Noticed-by: Dale R. Worley <worley@alum.mit.edu>
>>> Suggested-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
>>> Signed-off-by: Jeff King <peff@peff.net>
>>> ---
>>>  pager.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/pager.c b/pager.c
>>> index c1ecf65..fa19765 100644
>>> --- a/pager.c
>>> +++ b/pager.c
>>> @@ -54,7 +54,7 @@ const char *git_pager(int stdout_is_tty)
>>>                 pager = getenv("PAGER");
>>>         if (!pager)
>>>                 pager = DEFAULT_PAGER;
>>> -       else if (!*pager || !strcmp(pager, "cat"))
>>> +       if (!*pager || !strcmp(pager, "cat"))
>>
>> Hmmpf. It's sometimes useful to actually pipe through cat rather than
>> disabling the pager, as this changes the return-code from isatty. I
>> sometimes use this for debugging-purposes. Does this patch break that?
>
> If you have been running "GIT_PAGER=cat git whatever" and the like,
> we did not pipe the output through "cat" and this has been the case
> for a long time.  The only thing the patch in question changed is
> for those who build with
>
>         make DEFAULT_PAGER=cat
>
> and I doubt that you have been debugging git by rebuilding it with
> such a setting, so....
>

Yep. This was me simply not thinking things through :)
