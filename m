From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/RFC 06/10] strbuf: introduce strbuf_split_str_without_term()
Date: Sat, 12 Dec 2015 21:34:00 +0530
Message-ID: <CAOLa=ZQeK4VGf3n7vOtUspaak9gXn+G-DV9rwWDjr_n2_LeU6g@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
 <1447271075-15364-7-git-send-email-Karthik.188@gmail.com> <CAPig+cSxWybzunt_KWT+prZ=wXMi1wqM44jQZbp1pcz+spJW6A@mail.gmail.com>
 <CAOLa=ZQz-NE3uKtU72NUyR23QaJE4jf=UqiMptnM+hOmAE9GRw@mail.gmail.com> <xmqq8u50ehxk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 17:04:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7mex-0005Ei-CG
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 17:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbbLLQEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2015 11:04:31 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:34961 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbbLLQEa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2015 11:04:30 -0500
Received: by vkha189 with SMTP id a189so132391329vkh.2
        for <git@vger.kernel.org>; Sat, 12 Dec 2015 08:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SJqnE1AxgD7rp6wJ67D6TyuBrWAfAjejhs1vAW3Av5M=;
        b=dsbMU/F5Z20O5C4zSdh3Ni8a6aGL/ziDdjbjnVOAsAoz1NZ9q8unvAKUGZ6ROz/mYA
         Yofa9wRtxIJnFUGuLniSkLN7gpGFslKYIUi3qLJ+I7kt3ZvXqFOld6KhxkJdGeSlIXYi
         9OTOW+7hG9FVXvoTecJflqOcaeIO8M44kN4I8pKjL7n9mbz1EB9DepeeOZhwavbOtktw
         I1bUFEgHDMJ3Kbgz2kENWy7M6HZUY2CrujY8ZPSro7MW67+uUSQ2UJLBMQfY5OOeApwE
         H/50+jWMyE/YBjXGQkEV5lyDT2ECaa+3XZ5nFIYgSSK135C1RK3AV3dKEX3WFmjczsjz
         nNew==
X-Received: by 10.31.157.144 with SMTP id g138mr19500035vke.71.1449936269517;
 Sat, 12 Dec 2015 08:04:29 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Sat, 12 Dec 2015 08:04:00 -0800 (PST)
In-Reply-To: <xmqq8u50ehxk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282302>

On Sat, Dec 12, 2015 at 4:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>>> diff --git a/ref-filter.c b/ref-filter.c
>>>> @@ -892,14 +892,11 @@ static void populate_value(struct ref_array_item *ref)
>>>>                          * TODO: Implement a function similar to strbuf_split_str()
>>>>                          * which would omit the separator from the end of each value.
>>>>                          */
>>>> -                       s = to_free = strbuf_split_str(valp, ',', 0);
>>>> +                       s = to_free = strbuf_split_str_without_term(valp, ',', 0);
>>>>
>>>>                         align->position = ALIGN_LEFT;
>>>>
>>>>                         while (*s) {
>>>> -                               /*  Strip trailing comma */
>>>> -                               if (s[1])
>>>> -                                       strbuf_setlen(s[0], s[0]->len - 1);
>>>
>>> I'd prefer to see this ref-filter.c change split out as a separate
>>> patch so as not to pollute the otherwise single-purpose change
>>> introduced by this patch (i.e. capability to omit the terminator).
>>>
>>> Also, it might make sense to move this patch to the head of the
>>> series, since it's conceptually distinct from the rest of the patches,
>>> and could conceivably prove useful on its own, regardless of how the
>>> rest of the series fares.
>>>
>>
>> I guess it makes sense to split this into two separate patches. I'll do that and
>> push it to the top of the series.
>
> Sounds good.  I also notice that the "TODO: Implement a function
> similar to..." we see in the precontext can now be removed, as that
> is what is done in this patch?

Yes I noticed that when going through the changes Eric suggested. I have
removed it.

-- 
Regards,
Karthik Nayak
