From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/4] ref-filter: add ref-filter API
Date: Thu, 21 May 2015 22:52:59 +0530
Message-ID: <555E1473.1010703@gmail.com>
References: <555C88C2.8060902@gmail.com>	<1432127904-21070-2-git-send-email-karthik.188@gmail.com> <vpqr3qagvv6.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 21 19:23:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvUBg-0006ge-CY
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 19:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260AbbEURXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 13:23:11 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36006 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683AbbEURXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 13:23:09 -0400
Received: by pdfh10 with SMTP id h10so114823581pdf.3
        for <git@vger.kernel.org>; Thu, 21 May 2015 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=47D1GGqRRox5s8HTGnb6/RT3fy3RpOSjKGh22RPAan8=;
        b=XrCkT/EFG9vZy3HY7wTXj/k3mB/7rARenF+Tp1Cwg3Nu5TlzLB0khOJAxQ/x8KZPlk
         y6iIoMlidcoMfwtRYOWc4YEgRNeu3KPFFlQwV2nwQSWvdosDVbzELo1DEZV5UUp2bAjF
         nGyDv/YP9O9l3It2gbF/3vpcXpKygMsuLvV9P/3WbCrE1VTk4yxjBZrI9pO4FevkD5um
         n0Jx/kC8ytd3T476GV8/QWY8drOZcD2/JAx+kPehwWfbFx2zQe6le+Ed2QBwHOfu5HXQ
         y3HoZ63AnY65nuNgWUy6Bjkw7yTx5jC1jZt7FMO7iHG0nHFeStUDtCiCoUGO4uN0cqTn
         pgLg==
X-Received: by 10.68.135.196 with SMTP id pu4mr7651753pbb.64.1432228988342;
        Thu, 21 May 2015 10:23:08 -0700 (PDT)
Received: from [192.168.0.104] ([103.227.98.178])
        by mx.google.com with ESMTPSA id u10sm13322989pbs.30.2015.05.21.10.23.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2015 10:23:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqr3qagvv6.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269617>



On 05/21/2015 02:17 PM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +static int match_name_as_path(const char **pattern, const char *refname)
>
> I would have appreciated a short docstring. The full doc would probably
> be as long as the code, but a few examples of what matches and what
> doesn't can help the reader.
>

Will patch with an explanation and some examples.

>> +static struct ref_filter_item *new_ref_filter_item(const char *refname,
>> +						   const unsigned char *sha1,
>> +						   int flag)
>> +{
>> +	struct ref_filter_item *ref =  xcalloc(1, sizeof(struct ref_filter_item));
>
> double-space after =.

Noted.

>
>> +++ b/ref-filter.h
>> @@ -0,0 +1,47 @@
>> +#ifndef REF_FILTER_H
>> +#define REF_FILTER_H
>> +
>> +#include "sha1-array.h"
>> +#include "refs.h"
>> +#include "commit.h"
>> +
>> +/*
>> + * ref-filter is meant to act as a common provider of API's for
>> + * 'tag -l', 'branch -l' and 'for-each-ref'. ref-filter is the attempt
>
> Don't be shy: attempt at unification -> unification. This message may be
> an attempt, but we'll polish it until it is more than that.

Haha, OK, will change that.

>
>> + * at unification of these three commands so that they ay benefit from
>
> they *may*?

Yes. Will change

>
>> + * the functionality of each other.
>> + */
>
> I miss a high-level description of what the code is doing. Essentially,
> there's the complete repository list of refs, and you want to filter
> only some of them, right?
>
>  From the name, I would guess that ref_filter is the structure describing
> how you are filtering, but from the code it seems to be the list you're
> filtering, not the filter.

Will write a better explanation and description.
>
>> +/* An atom is a valid field atom used for sorting and formatting of refs.*/
>
> "used for" is very vague. Be more precise, say how it will be involved
> in sorting & formatting.

Noted.

>
>> +/*  ref_filter will hold data pertaining to a list of refs. */
>
> This is the answer to the "what?" question, which is not very hard to
> infer from the code. That's not anwsering "what for?" or "why?", which
> are much harder to infer for the reader.
>
> (plus you have a double-space after /*)
>

Noted! Thanks for the suggestions :)
