From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v14 05/13] ref-filter: add option to filter out tags,
 branches and remotes
Date: Sun, 30 Aug 2015 12:21:52 +0530
Message-ID: <CAOLa=ZSn6z03+jU1Ytn6nL0f0hQ36YAxG4629E1jTpyiaO7BZQ@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
 <1440857537-13968-6-git-send-email-Karthik.188@gmail.com> <CAPig+cRHc29TL=sHv3dkEewVQzPo0m8O4d1VL+dWA6PC5pHowA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 08:52:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVwTb-0007YG-C0
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 08:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbbH3GwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 02:52:23 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34781 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbbH3GwW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 02:52:22 -0400
Received: by obbfr1 with SMTP id fr1so72858421obb.1
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 23:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hGMRYFengQDzGn6ln7w8/vfZKQ+CasFg1mNwdcjLVd0=;
        b=KYZ/UONujdIZAWCzGDtNQJ4MHxBu41KvYf3F/8WOhWYaBbCTX0jjxU2o1WKWxD1Law
         X68l2OMrhIJdbv0O9biS+nI/TgjnA0xiRz9oGqY7NIF81iy2zREClLDt+vFnNSnu/lej
         2YIVM3evM9G27GR8YUvHTrNpVJaoEtRK0HVK7NJhP/e8KHyazQUe9ck7uA7RfZqA8QRb
         maR/wCrV3y7YCeEvqltBM9MhCbOlbBmoeVFWZARSB+hU2fCWbgjXUJZwi8YIdLvv0U22
         I94coh4FObzN88eGnXIto9sYrBKcZTtq1qC4+NUaxXwO36Vme9sXjcCOiRSmURhMiZz9
         Oy3Q==
X-Received: by 10.60.92.199 with SMTP id co7mr4645500oeb.37.1440917542147;
 Sat, 29 Aug 2015 23:52:22 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sat, 29 Aug 2015 23:51:52 -0700 (PDT)
In-Reply-To: <CAPig+cRHc29TL=sHv3dkEewVQzPo0m8O4d1VL+dWA6PC5pHowA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276805>

On Sun, Aug 30, 2015 at 9:00 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Aug 29, 2015 at 10:12 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Add a function called 'for_each_fullref_in()' to refs.{c,h} which
>> iterates through each ref for the given path without trimming the path
>> and also accounting for broken refs, if mentioned.
>>
>> Add 'filter_ref_kind()' in ref-filter.c to check the kind of ref being
>> handled and return the kind to 'ref_filter_handler()', where we
>> discard refs which we do not need and assign the kind to needed refs.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/refs.c b/refs.c
>> index 4e15f60..a9469c2 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2108,6 +2108,15 @@ int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
>>         return do_for_each_ref(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
>>  }
>>
>> +int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
>
> Booleans such as 'broken' are typically declared 'int' in this
> codebase, rather than 'unsigned int'.
>

But doesn't it make more sense to have it as unsigned, since its values are
either 0 or 1?

-- 
Regards,
Karthik Nayak
