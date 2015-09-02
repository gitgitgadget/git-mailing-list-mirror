From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Wed, 2 Sep 2015 18:42:20 +0530
Message-ID: <CAOLa=ZQxWO6+_N6TKgZ09HVGiNNDy29p6kU56Y2TX8Y+kYTcsA@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-6-git-send-email-Karthik.188@gmail.com> <vpqvbbttdjm.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 02 15:12:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX7qT-0002G7-Sg
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 15:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbbIBNMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 09:12:52 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36397 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511AbbIBNMv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 09:12:51 -0400
Received: by obqa2 with SMTP id a2so7288802obq.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JHxJIquZKABuSz9abWxIb6i6Z3hsSN9Alrm+x/OV36E=;
        b=ZMZuIKUEC+4OjCZ1C2H34BQhg1d6ogqZLg4WvBFi/9Ti+fKgFSrR8q5igE4yL/XTjq
         lY1GMUMfIqM5F7it+OnZw5H+fmYAk88PicPBFicMRsKINXLPRAS0nB15LXMqc8jfwTHx
         jJOOCMTdOrltxa/ochrIHD+JuUBI+tByLTsjSIjMOYwfGWeurI2mtBnIIP7647wp5fZf
         5XskFJFRKkSOyWfQr+R+nACpfZKsxEMm/8TnAVjfU1/r+1NwdxYFrVRIdcESk7tqQuvn
         J8g8hjG/+vP/zfg0Yz6OQw41i7IR8rVPn9f5ZzuOcNrLhQoo6uoO04dG1yVfrE2OFmph
         p6TA==
X-Received: by 10.60.92.199 with SMTP id co7mr14646696oeb.37.1441199570320;
 Wed, 02 Sep 2015 06:12:50 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 2 Sep 2015 06:12:20 -0700 (PDT)
In-Reply-To: <vpqvbbttdjm.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277089>

On Wed, Sep 2, 2015 at 2:15 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>
>> @@ -163,9 +174,28 @@ static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
>>       }
>>  }
>>
>> +static void align_handler(struct ref_formatting_stack *stack)
>
> Perhaps name it end_align_handler, to make the difference with
> align_atom_handler clear.
>
> Also, I think moving this function to be right next to
> align_atom_handler in the code would make this more readable.
>

will do.

>> @@ -754,6 +816,42 @@ static void populate_value(struct ref_array_item *ref)
>>                       else
>>                               v->s = " ";
>>                       continue;
>> +             } else if (skip_prefix(name, "align", &valp)) {
>> +                     struct align *align = &v->align;
>> +                     struct strbuf **s;
>> +
>> +                     if (valp[0] != ':')
>> +                             die(_("format: usage %%(align:<width>,<position>)"));
>> +                     else
>> +                             valp++;
>
> I agree with Junio that skip_prefix(name, "align:" ...) is simpler for
> the same thing.

Correct me if mistaken, but Junio wanted the first skip_prefix to
check for "align:" rather than "align", but that would mean we don't have
the error printing.

Are you sure we want to skip that?

>
>> +     if (state.stack->prev)
>> +             die(_("format: `end` atom missing"));
>
> Perhaps spell it %(end) instead of just end.
>

Yes, will do

-- 
Regards,
Karthik Nayak
