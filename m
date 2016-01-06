From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 08/15] ref-filter: introduce color_atom_parser()
Date: Wed, 6 Jan 2016 15:46:46 +0530
Message-ID: <CAOLa=ZRaviYJNmnq0jucBdQLZrDKr7xNR30k3jP_j_n9UCJ91Q@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
 <1451980994-26865-9-git-send-email-Karthik.188@gmail.com> <xmqqr3hvivml.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 11:17:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGl9e-0005o8-BA
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 11:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbcAFKRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 05:17:19 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33723 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbcAFKRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 05:17:16 -0500
Received: by mail-vk0-f66.google.com with SMTP id f2so23868746vkb.0
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 02:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3J4cGpRZnhGw8yKIoJb/WS9jz15WpFDNOOZYFnGes+I=;
        b=OVvuSUXQXOEE5Wr64IiCnAE8P9I+w9Z9VHSHec2N94sb9UOJHCEhAECvbfgHgrtr+r
         LNXLx0b3vgDCijBYVLooKqQwaQcuqlAucq3Ko4QQ8GYgYMNXOAvlCBovZJzAUsVpZj1+
         Pnrd1SP6FlrY/dM5umwEDKwaBkBNwz8sBVDk/QODvzqnuIYWDhIPOzl/wsy6y1FrwDBE
         g7bsWXx3h62i60yoVKl+fNCG8bjorR1s5shVfYIuox4ql322ONuAUkScvOR44Vsddv2f
         0xNGPNPdrJoWueVBu2CukbWCnfdtQ0ri6X9XC+sktIGGAArbiwr6ioUr1O67estoD9AW
         HUeA==
X-Received: by 10.31.8.204 with SMTP id 195mr68347556vki.30.1452075435744;
 Wed, 06 Jan 2016 02:17:15 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Wed, 6 Jan 2016 02:16:46 -0800 (PST)
In-Reply-To: <xmqqr3hvivml.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283432>

On Wed, Jan 6, 2016 at 2:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> @@ -90,7 +105,7 @@ static struct {
>>       { "symref" },
>>       { "flag" },
>>       { "HEAD" },
>> -     { "color" },
>> +     { "color", FIELD_STR, color_atom_parser },
>>       { "align" },
>>       { "end" },
>>  };
>
> This is minor, as I do not think anybody sane would say
> "for-each-ref --sort=color" and expect anything sensible, but
>

I completely understand and the only reason that I added FIELD_STR
cause that was the default either ways.

> I think we shouldn't mark these bogus attributes [*1*] as FIELD_STR
> (and it is not FIELD_ULONG, either).  Perhaps add a new FIELD_BOGUS
> (or some better name to make it clear that this is not a "value"
> that belongs to the ref and can be used to sort, e.g. "FAKE") value
> and mark them as such?
>
> That would allow us to error out when they are specified as a
> sorting criteria.
>
>
> [Footnote]
>
> *1* Bogus from the point of view of "what are the various attributes
> specific to these items that the command is iterating over,
> i.e. refs (or the objects at the tips of these refs)", as color,
> align, etc. are not attributes per refs.

I'm sure something like FIELD_BOGUS would make a lot of sense, but I wont
include that into this series. Maybe after this?

-- 
Regards,
Karthik Nayak
