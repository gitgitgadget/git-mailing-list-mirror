From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 03/11] ref-filter: implement an `align` atom
Date: Sun, 9 Aug 2015 04:19:26 -0400
Message-ID: <CAPig+cRoryoJj44D0Q_m3fVAZeYrCc0OiNA7GJ3UtQK4XVOn9g@mail.gmail.com>
References: <CAOLa=ZRnnMBKpsq1ANBVgF2=xwK=A2EsPKKrGS0R4mZ8iATKfA@mail.gmail.com>
	<1438800854-19901-1-git-send-email-Karthik.188@gmail.com>
	<CAPig+cSTssDihF5cBwu=2uKX1y6GqH-5EhKnb92Fpp30JA7pwA@mail.gmail.com>
	<CAOLa=ZSkmkPpiEfDrRXNQ6Tz5GT1+7vef3TOrj1t9aZ_3wm2Lw@mail.gmail.com>
	<CAPig+cTHKbn0oCV61n=p5o9WihsaJbvWqKt4y9eFwA0noJoPgA@mail.gmail.com>
	<CAOLa=ZQW1HBACAb4V_jMky4=54=rxqS=nyYMBX1CUUvA2c0s9A@mail.gmail.com>
	<CAPig+cT=uUp5T1W1-CBrx4ZMsTSdpoghg57affU3JZ3Uvq20Pw@mail.gmail.com>
	<CAOLa=ZQoHuE_NV1OMQrA7zoqYo6tUvXibURVz+3UknJsNLHV_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 10:19:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOLpZ-0007f6-Aa
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 10:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932880AbbHIITb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 04:19:31 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34786 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125AbbHIIT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 04:19:27 -0400
Received: by ykdt205 with SMTP id t205so38274085ykd.1
        for <git@vger.kernel.org>; Sun, 09 Aug 2015 01:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=NrtAVTgAShmgHL9LTH+1a9irpxDo9pQuyBKRIGKhuYo=;
        b=uve0JvVMZXT59OHwmuTURNU7yAGtKh471XdkJerSrULPp7qzJK/28DT35GJ3Fg19kC
         tQIKDRqx1dI97a7pSjfxJQlnYLKHt/6SXQbHlfU8QtD53vK7HrmrVlKm7BVLe6UEBJD0
         yvfziFa89rNPEu4pnWI1TXfC4uDELpeplBtpmZ+1ftQOsV6mFPao0haHmsKZqh0aoT2K
         L2QIWETug6aLf8H0Q49hWmkJLr9lTwjHoHqy+eLqohsGbYKJfyloB2SSzYdwMxkmrd87
         IUj+YKcmcN2CY4L7oNX7fPS6MagGun1uao99ABm3vGEBTO5C+rtdOfqlu/BErfJWew+d
         g86Q==
X-Received: by 10.129.91.87 with SMTP id p84mr16370768ywb.95.1439108366981;
 Sun, 09 Aug 2015 01:19:26 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sun, 9 Aug 2015 01:19:26 -0700 (PDT)
In-Reply-To: <CAOLa=ZQoHuE_NV1OMQrA7zoqYo6tUvXibURVz+3UknJsNLHV_w@mail.gmail.com>
X-Google-Sender-Auth: QKZCkDI3e1XQDroDSiaegcsqVHc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275533>

On Sun, Aug 9, 2015 at 4:09 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Sun, Aug 9, 2015 at 1:34 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, Aug 9, 2015 at 2:55 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> On Sun, Aug 9, 2015 at 9:12 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> That raises another question. Why are 'struct ref_formatting_state',
>>>> 'struct align', 'struct atom_value', etc. defined in ref-filter.h at
>>>> all? Aren't those private implementation details of ref-filter.c, or
>>>> do you expect other code to be using them?
>>>
>>> I guess struct ref_formatting_state and struct align could be moved to
>>> ref-filter.c. About struct atom_value its referenced by ref_array_item()
>>> so any reader reading about this, would find it easier if atom_value()
>>> is at the same place.
>>
>> Do you expect callers ever to be manipulating or otherwise accessing
>> the atom_value of ref_array_item? If callers have no business mucking
>> with atom_value, then one option would be to simply forward declare
>> atom_value in the header:
>>
>>     struct atom_value;
>>
>>     struct ref_array_item {
>>         ...
>>         struct atom_value *value;
>>         ...
>>     };
>>
>> which makes atom_value opaque to clients of ref-filter. The actual
>> declaration of atom_value would then be moved to ref-filter.c, thus
>> kept private.
>
> Also the code that this was done in has been excepted into `next`
> so either I send a new series for the same, or write a patch just to
> move this from ref-filter.h to ref-filter.c. So what would you suggest?

To my eye, atom_value seems to encapsulate a bunch of state local to
and only meaningful to ref-filter's internal workings, so it doesn't
really belong in the public header. Assuming that you don't foresee
any callers ever needing to access the properties of atom_value, then
it might indeed be reasonable to introduce a patch which moves it from
the .h file to the .c file (while leaving only a forward declaration
in the .h file).
