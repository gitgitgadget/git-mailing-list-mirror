From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v9 03/11] ref-filter: implement an `align` atom
Date: Sun, 9 Aug 2015 13:39:32 +0530
Message-ID: <CAOLa=ZQoHuE_NV1OMQrA7zoqYo6tUvXibURVz+3UknJsNLHV_w@mail.gmail.com>
References: <CAOLa=ZRnnMBKpsq1ANBVgF2=xwK=A2EsPKKrGS0R4mZ8iATKfA@mail.gmail.com>
 <1438800854-19901-1-git-send-email-Karthik.188@gmail.com> <CAPig+cSTssDihF5cBwu=2uKX1y6GqH-5EhKnb92Fpp30JA7pwA@mail.gmail.com>
 <CAOLa=ZSkmkPpiEfDrRXNQ6Tz5GT1+7vef3TOrj1t9aZ_3wm2Lw@mail.gmail.com>
 <CAPig+cTHKbn0oCV61n=p5o9WihsaJbvWqKt4y9eFwA0noJoPgA@mail.gmail.com>
 <CAOLa=ZQW1HBACAb4V_jMky4=54=rxqS=nyYMBX1CUUvA2c0s9A@mail.gmail.com> <CAPig+cT=uUp5T1W1-CBrx4ZMsTSdpoghg57affU3JZ3Uvq20Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 10:10:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOLgw-0000zg-Dr
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 10:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932895AbbHIIKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 04:10:12 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34598 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932482AbbHIIKD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 04:10:03 -0400
Received: by obbfr1 with SMTP id fr1so68414938obb.1
        for <git@vger.kernel.org>; Sun, 09 Aug 2015 01:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nlOZfgNlIvp9LD51DOYkVzt6wO7543DxzmHKQVdeifI=;
        b=khB7PneGem147VHAE+zQ9toic65OhbADHOV1C6maaVvOIWUFWDos6MIP2si0JviB92
         R5myEJ99Pmau5s4gCEqoD0F1HsQOofHaqgbgdwqbYvK1ka9LI0dS+xPSKfAVUOJzU4sa
         jdC/nLrTXlqVkIBYCyknAB6nxL4X4sCdY03by5LAvWXOIzfZWVUvBD1hODMbZlnBtgAk
         UIkyj4v24x0ZlaRtsFl1wO2w6ZVjsoZsc6w7qrutVOR5Y0FI5ZW6azabhQeEkFsh2/Ja
         5zn0F6fvmLqePKJaxIme3HP0Kc2P6C0U6oybnF9DfarWEyaV0lWxXPkMYRw5NWE8SNND
         ujcA==
X-Received: by 10.182.114.234 with SMTP id jj10mr14545421obb.70.1439107801537;
 Sun, 09 Aug 2015 01:10:01 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sun, 9 Aug 2015 01:09:32 -0700 (PDT)
In-Reply-To: <CAPig+cT=uUp5T1W1-CBrx4ZMsTSdpoghg57affU3JZ3Uvq20Pw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275531>

On Sun, Aug 9, 2015 at 1:34 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Aug 9, 2015 at 2:55 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Sun, Aug 9, 2015 at 9:12 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Sat, Aug 8, 2015 at 2:35 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>> On Fri, Aug 7, 2015 at 8:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>>> On Wed, Aug 5, 2015 at 2:54 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>>>> +               else if (align->align_type == ALIGN_MIDDLE) {
>>>>>> +                       int right = (align->align_value - buf_len)/2;
>>>>>> +                       strbuf_addf(final, "%*s%-*s", align->align_value - right + len,
>>>>>> +                                   value->buf, right, "");
>>>>>
>>>>> An aesthetic aside: When (align_value - buf_len) is an odd number,
>>>>> this implementation favors placing more whitespace to the left of the
>>>>> string, and less to the right. In practice, this often tends to look a
>>>>> bit more awkward than the inverse of placing more whitespace to the
>>>>> right, and less to the left (but that again is subjective).
>>>>
>>>> I know that, maybe we could add an additional padding to even out the value
>>>> given?
>>>
>>> I don't understand your question. I was merely suggesting (purely
>>> subjectively), for the "odd length" case, putting the extra space
>>> after the centered text rather than before it. For instance:
>>>
>>>     int left = (align->align_value - buf_len) / 2;
>>>     strbuf_addf(final, "%*s%-*s", left, "",
>>>         align->align_value - left + len, value->buf);
>>>
>>> or any similar variation which would give the same result.
>>
>> I get this could be done, what I was asking was, Consider given a alignment
>> width of 25 would be better to make that 26 so that we have even padding on
>> both sides. But I don't like the adding of manipulating user given data.
>
> I thought you might be asking that, but wasn't certain. I do agree
> with your conclusion that second-guessing the user is a bad idea, and
> that you should give the user exactly what was requested.
>

In that case I'll be doing what you suggested, thanks :)

>>> That raises another question. Why are 'struct ref_formatting_state',
>>> 'struct align', 'struct atom_value', etc. defined in ref-filter.h at
>>> all? Aren't those private implementation details of ref-filter.c, or
>>> do you expect other code to be using them?
>>
>> I guess struct ref_formatting_state and struct align could be moved to
>> ref-filter.c. About struct atom_value its referenced by ref_array_item()
>> so any reader reading about this, would find it easier if atom_value()
>> is at the same place.
>
> Do you expect callers ever to be manipulating or otherwise accessing
> the atom_value of ref_array_item? If callers have no business mucking
> with atom_value, then one option would be to simply forward declare
> atom_value in the header:
>
>     struct atom_value;
>
>     struct ref_array_item {
>         ...
>         struct atom_value *value;
>         ...
>     };
>
> which makes atom_value opaque to clients of ref-filter. The actual
> declaration of atom_value would then be moved to ref-filter.c, thus
> kept private.

Also the code that this was done in has been excepted into `next`
so either I send a new series for the same, or write a patch just to
move this from ref-filter.h to ref-filter.c. So what would you suggest?

-- 
Regards,
Karthik Nayak
