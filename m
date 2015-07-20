From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 3/9] ref-filter: support printing N lines from tag annotation
Date: Mon, 20 Jul 2015 20:47:24 +0530
Message-ID: <CAOLa=ZQBve8Uy+O9mKttTxUBonGGocC=kXS7s8BCf=FaF9sOug@mail.gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
 <1437246749-14423-4-git-send-email-Karthik.188@gmail.com> <CAPig+cSXuJ7ohR=afzRbmfLtEuzhGYYTznc2J_qxwgBKwyYu9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 17:18:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHCpL-00004w-QT
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 17:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbbGTPRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 11:17:55 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35334 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbbGTPRy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 11:17:54 -0400
Received: by oihq81 with SMTP id q81so110717579oih.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 08:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xYv/2tQ8eyyRfWYRthXWaMEjOItQrtAF/CYiU2a2St8=;
        b=L+8ErDZaMHbdM2P2BIcctl5/uOBWbxUBnS7pbvbxe3TRNCdz6Mjmem2zzenNLFbIvi
         aetnkvidTZLuuWNBXjlem98/89fzeohx2ijL2N69JBNlhFmVTUJIHuR3W2vW+reF0LW9
         X9fwlCk6BrI4j/ZHscbcy0gLrTCdZKCJh0KnE6LG8BKiH52JwbReFK3IJeQRlGmNS24F
         xNLIIjArfKNc3ymzGhEn3du5K6aAWWfXFVWU74DmfS9JsmZIAo1FUkAsO/sRsEoMgo87
         HRizOjB+wpqwncPeHxZZijx1lvmEg1l8Z68JsaFeGT+qWwz/VDKPNivQ3E3ek1ZDtWe3
         yUSg==
X-Received: by 10.202.200.151 with SMTP id y145mr25456737oif.111.1437405474039;
 Mon, 20 Jul 2015 08:17:54 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 20 Jul 2015 08:17:24 -0700 (PDT)
In-Reply-To: <CAPig+cSXuJ7ohR=afzRbmfLtEuzhGYYTznc2J_qxwgBKwyYu9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274324>

On Mon, Jul 20, 2015 at 5:32 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Jul 18, 2015 at 3:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> In 'tag.c' we can print N lines from the annotation of the tag using
>> the '-n<num>' option. Copy code from 'tag.c' to 'ref-filter' and
>> modify 'ref-filter' to support printing of N lines from the annotation
>> of tags.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 771c48d..82731ac 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1288,7 +1288,48 @@ static void assign_formating(struct ref_array_item *ref, int parsed_atom, struct
>>         }
>>  }
>>
>> -void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
>> +/* Print 'lines' no of lines of a given oid */
>
> This is difficult to read and understand. I presume you meant "no." as
> shorthand for "number" but dropped the period. Even with the period,
> it's still hard to read. Perhaps rewrite it as:
>
>     If 'lines' is greater than 0, print that may lines of...
>
> or something.
>

Ah okay :) Will change it to a better explanation.

>> diff --git a/ref-filter.h b/ref-filter.h
>> index c18781b..7dfdea0 100644
>> --- a/ref-filter.h
>> +++ b/ref-filter.h
>> @@ -87,8 +88,11 @@ int parse_ref_filter_atom(const char *atom, const char *ep);
>>  int verify_ref_format(const char *format);
>>  /*  Sort the given ref_array as per the ref_sorting provided */
>>  void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
>> -/*  Print the ref using the given format and quote_style */
>> -void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style);
>> +/*
>> + * Print the ref using the given format and quote_style. If lines > 0,
>> + * prints the "lines" no of lines of the objected pointed to.
>> + */
>
> Same problem. This literal "no" is quite confusing. Perhaps rewrite as above:
>
>     If lines > 0, print that many lines of...

Will change this too.

>
>> +void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style, unsigned int lines);
>
> ref-filter.h seems to be setting a precedent for overlong lines.
> Wrapping this manually could improve readability.
>

Definitely!

Thanks for all the suggestions.

-- 
Regards,
Karthik Nayak
