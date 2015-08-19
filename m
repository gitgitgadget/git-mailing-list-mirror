From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v12 03/13] ref-filter: introduce the ref_formatting_state
 stack machinery
Date: Wed, 19 Aug 2015 21:40:00 +0530
Message-ID: <CAOLa=ZRBTrWa5EEOxa-Rf+J+8DWP7gSGGEYaG75EsR=A1DofRA@mail.gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
 <1439923052-7373-4-git-send-email-Karthik.188@gmail.com> <vpqvbcb2uoi.fsf@anie.imag.fr>
 <CAOLa=ZTy8QO=H9g9g3SKU4HaG=qg71GidGuXKLXNgu7Su3FQ9A@mail.gmail.com>
 <vpqa8tn2sgy.fsf@anie.imag.fr> <CAOLa=ZSzXyQZJksNqyroU6Td+LG7ZRTF_WNNryusAGZxTYTmDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 19 18:11:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5xi-0007j0-Eo
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 18:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbbHSQLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 12:11:34 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34601 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbbHSQLd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 12:11:33 -0400
Received: by obbfr1 with SMTP id fr1so8302513obb.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KCUOI2CPAHZBpJ2DH5Xmy4Kt7yU16LnDnbP1bvjga1E=;
        b=0q4MnUz+asVb7UKmWGIugGfChwFomcaKJWz4I94GF/pjE+DghQTI6rztDSw6iXpamC
         gdrUCJwctWgvI+0jIgnlNuJ1LGj8UKDfLodggPS+686n7K6pUXD34RIlwd8eLv+Ypm/6
         IDV6JCUs4sn0cVExs4xrVcjqVvfChTZVkfOC01DuE09cBTfm1995hbIzd+wjSLo5lESe
         EnvdH/scOMKws9pfmJI4y9uN+UeX6l3WSOfozURFRgs7iMy4Y+mKMWKalgilR7aMCcXf
         NpNvCCxCXekcBM44ojq8RAFYmh6jq4S0EeGosfHLF4heBmoFs7iWlO9xMYj/1wP1h8ns
         XC0Q==
X-Received: by 10.182.29.68 with SMTP id i4mr11044378obh.57.1440000630395;
 Wed, 19 Aug 2015 09:10:30 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 19 Aug 2015 09:10:00 -0700 (PDT)
In-Reply-To: <CAOLa=ZSzXyQZJksNqyroU6Td+LG7ZRTF_WNNryusAGZxTYTmDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276204>

On Wed, Aug 19, 2015 at 9:24 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Wed, Aug 19, 2015 at 9:14 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>>> --- a/ref-filter.c
>>>> +++ b/ref-filter.c
>>>> @@ -155,6 +155,8 @@ static void push_new_state(struct ref_formatting_state **stack)
>>>>
>>>>         strbuf_init(&s->output, 0);
>>>>         s->prev = *stack;
>>>> +       if (*stack)
>>>> +               s->quote_style = (*stack)->quote_style;
>>>>         *stack = s;
>>>>  }
>>>>
>>>>
>>>
>>> This seems about right, why do you think it's a stupid fix?
>>
>> If you have a stack of N elemments, why replicate a field N times if all
>> the N instances always have the same value?
>>
>> There's nothing to be pushed or poped with quote_style, so having it in
>> the stack is confusing to the reader (one has to infer the property "all
>> instances have the same value" by reading the code instead of having
>> just one variable), and error-prone for the author: you already got
>> it wrong once.
>
> Thats also there, I'll guess it makes more sense to remove it from
> ref_formatting_state.
>

Speaking of quote_value, The quote doesn't work well with color's
for e.g.
git for-each-ref --shell --format="%(color:green)%(refname)"
'''refs/heads/allow-unknown-type'''
Seems like an simple fix, probably after GSoC I'll do this :)

-- 
Regards,
Karthik Nayak
