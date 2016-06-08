From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 1/4] bisect--helper: `bisect_clean_state` shell function
 in C
Date: Wed, 8 Jun 2016 13:39:03 +0530
Message-ID: <CAFZEwPMWRcvaspsKRMegKbtzCKgXohoeGF36L-fCk0DcyvrWPQ@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <CAPig+cTqk0d60Omsm12RXF2uzoxoPjbqHj7V8Y=6Uu+fH5b43Q@mail.gmail.com>
 <CAFZEwPMJbKAOdffWs7QedB+4j32LaBZeV1iGpUuGntMjXeN3hg@mail.gmail.com> <CAPig+cTiqRAnhBx6eCifdOmES1uD3piPYgsRHNMVFCO07W1nTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 10:09:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAYY7-0002nA-Ms
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 10:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230AbcFHIJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 04:09:10 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35075 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbcFHIJE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 04:09:04 -0400
Received: by mail-yw0-f175.google.com with SMTP id o16so543078ywd.2
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 01:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u3B6gnicDDaMnzJc+8lv424B/UTRgui3IvYnvhyR2Bo=;
        b=vRZoEVQIA0L6diOUXj1KJdCqEUwQpHn3eDN+YPc7p/mlIisDDw3D1+ugbrePS+Sx8t
         3J4UPYBHkJFX8dmE1WDATWRd7/wItgTQHVboxdCzk2A6vOM8YWumUYk+j58GLWG5qLG/
         wLQS3hBBVaQ58va2Ixk1MTD6LgXT9lke6C52YaYxjx3Ju+Dc8DSfIhVgpX+m8LayLbBd
         hupdrTvhKRfKYaxSCERH/zgE5njKYLa5+tzqmIMOqa1cACNGs1lMEasT438TA+9xOTMm
         aKiZq7+W8OyPK11wXHMWqczOQzsP4Q4ytFgKpA2+NE5ImsfusI1M5wcmcU/SF5Q6rkQr
         +iOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u3B6gnicDDaMnzJc+8lv424B/UTRgui3IvYnvhyR2Bo=;
        b=heYAKW+xyejsnPN1IE123Nw9wol0xQdNg94wEhfsI2vl+hPa7YueIep93euWHvy4tY
         iyi+XWxQxMzQjBH+z4m/4Fto/+kLhSwI9UOkbu17zNGEIGR/dfrLPWVnLcKZyaSFmzW0
         xwUauslePQvTdVGYBkAeigPGJ1g8CTTXBMcjeMxU+UNau6Nx99OEXf7y3aNi5UhF1GA/
         5yKcIGyHcpyUYk+SN2N7zQ4bm9aaEMr8hDWWLyQg1ah/m3WwGPqS4n1BBIyvAx5BECuA
         Q4Uxbricbnzzam61eY5m9/r2C7V+tShCz37Cotg7lrNaD6ep2jI0MYd2uVd2zlHc8aLe
         FkEw==
X-Gm-Message-State: ALyK8tJtrUrW5IFZcJtVxPukjNMzVwKNwYleUt/Mk0PdX4vJshmoeN6huEiChkaQ7zhsoQ26+dYawFdQJEkfWQ==
X-Received: by 10.129.116.67 with SMTP id p64mr1950576ywc.68.1465373343831;
 Wed, 08 Jun 2016 01:09:03 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Wed, 8 Jun 2016 01:09:03 -0700 (PDT)
In-Reply-To: <CAPig+cTiqRAnhBx6eCifdOmES1uD3piPYgsRHNMVFCO07W1nTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296766>

Hey Eric,

On Wed, Jun 8, 2016 at 1:32 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 8, 2016 at 3:46 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Wed, Jun 8, 2016 at 4:01 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>> +       struct string_list *refs = cb_data;
>>>> +       char *ref = xstrfmt("refs/bisect/%s", refname);
>>>
>>> Here you're allocating a string...
>>>
>>>> +       string_list_append(refs, ref);
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +int bisect_clean_state(void)
>>>> +{
>>>> +       int result = 0;
>>>> +       struct string_list refs_for_removal = STRING_LIST_INIT_DUP;
>>>> +       for_each_ref_in("refs/bisect/", mark_for_removal, (void *) &refs_for_removal);
>>>
>>> ...and the allocated string gets inserted into a string_list which
>>> itself duplicates the string (STRING_LIST_INIT_DUP), so this is
>>> leaking the string you created with xstrfmt(), isn't it?
>>
>> Yes nice catch. I would prefer using the string_list with
>> STRING_LIST_INIT_DUP and free the ref.
>
> That's unnecessarily wasteful. Better would be to to use STRING_LIST_INIT_NODUP.

Sure I will try it out!

Regards,
Pranit Bauva
