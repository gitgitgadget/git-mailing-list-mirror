From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 2/2] bisect: rewrite `check_term_format` shell function in C
Date: Wed, 4 May 2016 23:38:22 +0530
Message-ID: <CAFZEwPO6L_F+VuQ1TAOK8GonmAXqy7WH__-dS2xmvb_cuh0tpw@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-3-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cRL7QkQHpSmeKEYECd9JQO8B29OOJoGx2AQORPfmW7QQQ@mail.gmail.com>
	<CAFZEwPNKug1pvGC1fTvZzVPBGKy71fw6S3qcx_fx98nYZasR3w@mail.gmail.com>
	<CAPig+cQn4iRCqquUE-g4879mTS7UJkHr7ANvH9HB2+087qCV7A@mail.gmail.com>
	<CAFZEwPNdmJdt=4Hg7KpfGS51sDeKyAPWgApESf564kt_eaP3Rg@mail.gmail.com>
	<CAPig+cTXj2=iV0RnZU2Lpr3aqoqWOhPKNdpmOjdh+GocNHiP6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	christain.couder@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 04 20:08:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay1Do-0006Rg-4D
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 20:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983AbcEDSIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 14:08:24 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:32787 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469AbcEDSIX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 14:08:23 -0400
Received: by mail-yw0-f180.google.com with SMTP id t10so110414728ywa.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 11:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=5lQEtUWwwmCNbeQlIFeyKd2q4xYCwletCbbrYadE5bA=;
        b=nGuNPIgWIH0FmjrcF6rrK4yYCGMmUuKubIVYxwu1TbLh9J8C4H+Xc7jcP0CdRZuc19
         dzzC4nDSreU8kqEQxc8RZ58hbCKU1FytXh2/4E9F5EqdixGCOPxs3hnRwfnK8smlUCtw
         gkvJ1bLgdG4RHqgV478lEBELutbt8MY4fyOwy1p/ZfADTwqo8WjSz46i3aWmkv/OpvHE
         juwzaZqjxDvh0W4YnEf+dArAoxtl5clx7hELhTlHWSZPUG+X1oG97ZSQBpNUJe7CB0B0
         TEz63eCtE2Sb5TBWu9xjqzWed+Emh4qV3tqivfmVqxDDYx7Fx+U8lS+0qnma468mqEqx
         q3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=5lQEtUWwwmCNbeQlIFeyKd2q4xYCwletCbbrYadE5bA=;
        b=dFRVU7PFkJfeIkMCftPFTQmtHUXjSkKTuDe9CG2H7H6lQhJZR4eVRHRUIHV/2bHGMX
         w7/kDSP/VcS6wDupSaVcN8WH32bf97Q0yhgj9R0z49Ww3UvdRipsjAPnd29TB8kUUopU
         g6BzU05e6hLKRQd/782BiuHOTi/Ac0bAAl7MpiDp4gcQduabyhoxhiDD6xvFn8IU8aTh
         nWlDUxUMEkY2x+gJimC0nPHuuLairpCENrCei6f5DHiDVY8FleGGb/4EfyYtCdEj0oeD
         I/5el09nT9HJ5Y8QGt1GQe9MbXdkrt+/eisbSjhVNcVHvAUHGJ4TrPuO3gQCNff1u/w9
         wzBQ==
X-Gm-Message-State: AOPr4FXYEe/qPHsYnxa7PuhJnif2p9Vfps435AAq6HnjIQ8z3F5m1j0S0WCvUpykDxeTdRso9SAKPvVXldWeOg==
X-Received: by 10.37.87.135 with SMTP id l129mr5990595ybb.7.1462385302428;
 Wed, 04 May 2016 11:08:22 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Wed, 4 May 2016 11:08:22 -0700 (PDT)
In-Reply-To: <CAPig+cTXj2=iV0RnZU2Lpr3aqoqWOhPKNdpmOjdh+GocNHiP6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293558>

On Wed, May 4, 2016 at 11:19 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, May 4, 2016 at 7:58 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Wed, May 4, 2016 at 1:58 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Wed, May 4, 2016 at 3:36 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>> On Wed, May 4, 2016 at 12:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>>> On Wed, May 4, 2016 at 1:07 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>>>> +       if (check_refname_format(new_term.buf, flag))
>>>>>> +               die(_("'%s' is not a valid term\n"), term);
>>>>>
>>>>> Why does this die() while the other "invalid" cases merely return
>>>>> error()? What makes this special?
>>>>
>>>> This is because I felt that if check_refname_format() fails then its a
>>>> fatal error while in other cases, it is not as fatal.
>>>
>>> The name of the command is "check-term-format" and that is precisely
>>> its purpose so, from the perspective of the caller, *all* problems
>>> with the term are fatal. It's black-and-white, there is no grey:
>>> either a term is acceptable, or it isn't; that's all the caller wants
>>> to know. Consequently, all problems detected by this function should
>>> be reported the same way (preferably via 'return error()').
>>
>> Sure. I will use 'return error()'. Any particular reason why this
>> instead of die() ?
>
> This function's specific purpose is *check* some input for validity
> and let the caller know the result of that check. The most natural way
> to do so is by returning a success/failure value to the caller.
>
> die() is for signalling an exceptional condition which should abort
> the program. There is nothing exceptional about a "false" result from
> check-term-format, thus die() not an appropriate way to pass the
> result to the caller.

Thanks for the information! :)
