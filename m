From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Wed, 2 Sep 2015 20:35:11 +0530
Message-ID: <CAOLa=ZQLG_HB0trodXPCb9n4x2FuH7h7-+KJYLEdNZSpd0PHsg@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-6-git-send-email-Karthik.188@gmail.com> <xmqqegihrg6t.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZQ0nyaQmvE3suT6hh0jO3s_iYxFLjSuLUY4STneMFJf9Q@mail.gmail.com> <xmqqd1y0q30g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 17:05:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX9be-0000FS-4d
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 17:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbbIBPFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 11:05:42 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33688 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579AbbIBPFl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 11:05:41 -0400
Received: by obbbh8 with SMTP id bh8so10350174obb.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NAs2kBbST7SdTSJiD4K9kJ5Fp7w/gCqnk3nPjGDgGQs=;
        b=pizv9JxlxjWXh19Knw86/ZnWolTeswa2YNZtfbcNlLgPvKBy6k0Yblx18t9ykjd9i6
         Mr1o7kfHMdAxvIFuNJLYAlKe+p/NhOKzi14Lb9jgYeCLBZfaVertygg+UNBUB6oe/3q0
         Oc5LTyQgUohH9fM2yek6hR4qG9YYH6gGI+1U+ALX7z5CZN6MQDpEEhZZGyB92mVljLve
         /Cog1dTrvBoqlUsaWVHgBOAKc19pzzv4y5Hh17Oyb3Lln2EjbjWZzLV+jJ1OvJutL7GW
         MT66/P1sd2RJC44BL2zivI2f1UQFxkzNOMEqK8eidM80YXsZJhRDRTRyKffrvq2t+cIV
         F+dw==
X-Received: by 10.182.81.98 with SMTP id z2mr20637073obx.70.1441206340498;
 Wed, 02 Sep 2015 08:05:40 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 2 Sep 2015 08:05:11 -0700 (PDT)
In-Reply-To: <xmqqd1y0q30g.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277094>

On Wed, Sep 2, 2015 at 8:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>>> +             die(_("format: `end` atom used without a supporting atom"));
>>>
>>> Not a show-stopper, but we may need some wordsmithing for "a
>>> supporting atom" here; an end-user would not know what it is.
>>
>> Probably something like "format: `end` atom should only be
>> used with modifier atoms".
>
> Between "supporting" and "modifier" I do not see much difference,
> though.
>

I don't see how we could provide a better message, as %(end) atom
would be common to various atoms eventually.

>>>> +             } else if (skip_prefix(name, "align", &valp)) {
>>>
>>> This looked as if you are willing to take %(align) in addition to
>>> %(align:...), but...
>>>
>>>> +                     struct align *align = &v->align;
>>>> +                     struct strbuf **s;
>>>> +
>>>> +                     if (valp[0] != ':')
>>>> +                             die(_("format: usage %%(align:<width>,<position>)"));
>>>
>>> ... apparently that is not what is happening.  Why not skip "align:"
>>> with colon as the prefix, then?
>>
>> Cause we wanted to provide an error for usage of "%(ailgn)" without any
>> subvalues as such.
>
> Wouldn't it be something that would be caught in the same codepath
> as what catches %(unrecognized) in the format string?

No, since "align" is defined as an atom, in the valid_atom struct.
Changing it to "align:" would work, but that seems a little inconsistent
with the other atoms.

Hence --format="%(align)foo%(end)" would just result in the
"format: `end` atom used without a supporting atom" error being
displayed, hence confusing the user even more.

-- 
Regards,
Karthik Nayak
