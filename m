From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Thu, 27 Aug 2015 00:41:49 +0530
Message-ID: <CAOLa=ZQY83p96ECfyxeUr5s_zWo-u4ZPP1Ot79gSwaATiq__Pg@mail.gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
 <xmqqy4h04mx4.fsf@gitster.dls.corp.google.com> <CAOLa=ZRYWNVmMeMCZSa+GcOTQ7NzuVB9RH_TFJ6-u7aFhrU=NA@mail.gmail.com>
 <xmqq8u904ix0.fsf@gitster.dls.corp.google.com> <xmqq37z82u2a.fsf@gitster.dls.corp.google.com>
 <CAOLa=ZS=Mtz0ny0tUWRBY0vfAgiRzaszeF0m_pxnK3+VGn1eVg@mail.gmail.com>
 <vpqd1yap8ml.fsf@anie.imag.fr> <xmqqy4gyukag.fsf@gitster.dls.corp.google.com>
 <xmqqtwrmuk7b.fsf@gitster.dls.corp.google.com> <vpq8u8ym4ns.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 26 21:12:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUg7V-0003iZ-6C
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 21:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbbHZTMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 15:12:20 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35643 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbbHZTMU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 15:12:20 -0400
Received: by oifo84 with SMTP id o84so1637893oif.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 12:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=h8mxr50ax94fQfeB3wLbuievdaLymcTGCTp2HQo24PM=;
        b=OIFgn1jXWNW0FXPu5KXjqIoZ+8ICDk19YPI6S+nOal7z2cPuV0UNIhj8VLB00rUDR4
         b6SuiVTu77eJ05Q70SWaHZ6M4I9qkHXwdzwEYAjBhSmGk5+xC3gxuiIHlfvLGcZCP4x2
         rP3lEMeCxypYAy4/NKM3PicFnmFKwm0E/dbfn2kCgBdxWFSJjijc+HehZ7PmjmZuTdh8
         aGthUHQN69TY/rRufyagpZiguCEKb7+bWn638P/p6X8bi7Pq2/uyafm4T0BjLkWUMS6Y
         foeiI010bZzfP12KeoktxVuk44HPWKCxq073BZ30lRlOegcSPeNA6nDnmWc1vgQkLGGY
         YdHA==
X-Received: by 10.202.193.2 with SMTP id r2mr3983oif.104.1440616338713; Wed,
 26 Aug 2015 12:12:18 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 26 Aug 2015 12:11:49 -0700 (PDT)
In-Reply-To: <vpq8u8ym4ns.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276624>

On Wed, Aug 26, 2015 at 9:18 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>>
>>>>> For the current code %(if:empty)%(align)%(end)%(then)Empty%(else)Not Empty%(end)
>>>>> would print non-empty, I guess the documentation holds in that case.
>>>>> Not sure if we require it to print non-empty.
>>>>
>>>> You don't want the %(if) condition to depend on whether
>>>> --shell/--python/... is used. Since %(if:empty)%(align)%(end)%(then)
>>>> holds when you don't use --shell, you also want it to hold when you
>>>> quote. IOW, you should check for emptyness before (or actually without)
>>>> doing the quoting. I guess this is what you're doing, and if so, I think
>>>> it's "The Right Thing".
>>>
>>> I agree that %(align)%(end) should expand to empty and %(if:empty)...%(then)
>>> should look at that empty string without quoting.  So
>>>
>>>     %(if:empty)%(align)%(end)%(then)Empty%(else)Not Empty%(end)
>>>
>>> should give "Empty"; otherwise the code is buggy, I think.
>>
>> (I shouldn't be typing while eating...)
>>
>> It should give "Empty", but the --shell/--python/... may make the
>> whole "Empty", as the result of %(if:...)...%(end), be quoted.  So
>> you may see "'Empty'" in the output.
>
> Agreed (with both points).
>

Thanks, will work on this.

-- 
Regards,
Karthik Nayak
